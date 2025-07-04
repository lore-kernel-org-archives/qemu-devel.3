Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A970C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiVn-0005mO-VY; Fri, 04 Jul 2025 11:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiVk-0005ku-Vc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiVj-0007dt-Fs
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751643574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n36UyVWIgxfe52Y1m9fDCPkKNvUc3aarkdo8vp7w9mA=;
 b=NEkjF006/NrVOqnV20IxYEI4wf+w8C6CM+mjbS9NZPRrrRuQGn79WUCfNDxOj4h4UuXGp9
 5vjL4U5m6VPVmP2lS8jZSixiRG1raOs5W1gaaz2WP9sHZRaxevxPSD2H6Zjm36RWIkhF3i
 6lYo3PSDuwtFESzYqwKLg2TsOShCgQc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-KhqwBklENNiACcoTn97KNA-1; Fri, 04 Jul 2025 11:39:32 -0400
X-MC-Unique: KhqwBklENNiACcoTn97KNA-1
X-Mimecast-MFC-AGG-ID: KhqwBklENNiACcoTn97KNA_1751643572
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fad8b4c92cso23138556d6.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643569; x=1752248369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n36UyVWIgxfe52Y1m9fDCPkKNvUc3aarkdo8vp7w9mA=;
 b=hQlBTXBnvL22KOaAue6YVQiWXmxGvSnac8rrzhnLCaDzwQu6Xal/DXrW3FkCjFwBqH
 eJu7cvB+VlDJ0whz6/LjXEieYmIfRFBnUZUNUFXFC7W6JmwLjTlLqPcNCO0C9VufiPbU
 rlY4HcwuoYq4IT/FLewy6UVtdD2L4+JvqYwiHtBU9N4flGxBAqztgBW7RPIQOw/M9w0r
 MnpjJZRHh79PNEE1oLZbIbG7YXTAzSkOqSRa1Bk4Wbs8EaXbFZfuAdzdJdjrfUqErpg3
 SiQwdE26JVzgb5TlNjjuO/8KBwF/Kxs0bvEjdf9SKIVK6coCl1FUdRwADFEAxKnuJ39U
 9cJg==
X-Gm-Message-State: AOJu0YzEQ8/rlbAsdn50l+aAc7Z0/7acheEBlF5KuOGQlOot8pNSIEWf
 4+WyVaQJaAMPQN876+nk07LE86xd/vcj8DudBjehu8HWudCe2k5LeTaZgoeKFvXfRBvXbYJvIZE
 xGogqmGp/CGtth7C3JmXni1RaSM9Jc0sM10CwHMssKqTYEiYqPYVEO5hs
X-Gm-Gg: ASbGncvhG+6PgddELR0JKJG0xNyWQyThMGQEaENObUx83zcHI6cdk0DVeYpP6hCxWh8
 /msv8m6nNyVWWFU6SJUBaJ7WJ2FIIxgFq2+5NpRwhz+P3wDvHQ6Fx3SVl7d2KZu+bBRHkz4GUbu
 F0cOpydth2pYeC2kjjB53UPzfRBnmP5hBGHau8641eFtTukyC4GzvYVbxzwtZYpWCkxVwBiuPzg
 TmaWkYRmmTratbIxBCFv2Dh5LKl7XssTUjFGKsqTonW9bfhDpvfNC8HWhPMj9cGgdRYQjy9f3Ec
 3aMBmquHu87YXA==
X-Received: by 2002:ad4:5fce:0:b0:6fa:9b1c:740b with SMTP id
 6a1803df08f44-702c6ded514mr36514036d6.42.1751643569182; 
 Fri, 04 Jul 2025 08:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFYmFUias5jHRDOlrYfeknrehgTmr5z8sHKTdsJlEb1ob8jlrcNfcaESf0Wx/5BpObv0corg==
X-Received: by 2002:ad4:5fce:0:b0:6fa:9b1c:740b with SMTP id
 6a1803df08f44-702c6ded514mr36513686d6.42.1751643568794; 
 Fri, 04 Jul 2025 08:39:28 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d60460sm13927676d6.109.2025.07.04.08.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:39:28 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:39:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 04/24] migration: Remove MigrateSetParameters
Message-ID: <aGf1rQ7wLoY1L0Se@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 30, 2025 at 04:58:53PM -0300, Fabiano Rosas wrote:
> Now that the TLS options have been made the same between
> migrate-set-parameters and query-migrate-parameters, a single type can
> be used. Remove MigrateSetParameters.
> 
> The TLS options documentation from MigrationParameters were replaced
> with the ones from MigrateSetParameters which was more complete.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


