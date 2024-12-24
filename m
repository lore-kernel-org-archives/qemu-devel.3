Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D433BE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 19:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQAXt-0001pz-Td; Tue, 24 Dec 2024 14:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAXs-0001pr-Mu
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAXr-0006uS-Bn
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735068378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+ozk8Sy0h1R32bjTY4lCO+OeJIzYn9vC6GxFu8ddNY=;
 b=Ycb8o2izv7C7TJvNwCSJ43oRlXVzVlbEWRrXMs86CEczLdeadcmyAPt/66TxAMdZJPTNfC
 yqi9IinymW3cqPBlZ0smUw+PqEkGnMRtoQsjXB0/PYRURUFYjLb4jmF+y9yOLhnTpm1S+R
 +6Qh+Yh0QE2BwOL5wYW2zykvq9c5kwU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-ZbxbUcyQPqqIBleImCOY7w-1; Tue, 24 Dec 2024 14:26:16 -0500
X-MC-Unique: ZbxbUcyQPqqIBleImCOY7w-1
X-Mimecast-MFC-AGG-ID: ZbxbUcyQPqqIBleImCOY7w
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8844560e9so112293836d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 11:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735068376; x=1735673176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+ozk8Sy0h1R32bjTY4lCO+OeJIzYn9vC6GxFu8ddNY=;
 b=f4MzYLRgJ+Y4pYiJHjQSEZWq85UjQnV82sefEoHZJGcLQrwilVPVN5w6dsTBTNO5+/
 78tmpvuPhF9r6lFDm8Yon778vOJtJ9+aSIFb8Z/YKxMe3iGN48X4RiyXEC47//2OFAkY
 hILzXLMwmkDO9WXkH2gSNw6sMZydLeUn73c9FgDUckZBHSwf5FtRfsoLMbK3qtsmslFp
 QWSX90dmlFztkmEzgwOCiJnDXfZDfhPLqIU14qvKfoKfvUa2bf5ORyiXJrKxxF5HO7ef
 mmdH15KXmoSyrNf4FXvN8pTqKpVHiWjn4FPW7dlgrefGEpLu+jA0DqKtMs8o94rJnFqT
 1ROQ==
X-Gm-Message-State: AOJu0YyKUg21Vztm9/PpXQDDqTwrKlj8bUsG+UOOhrGpQGxM+ldB9EwZ
 ZL8uEGbaZFnGDY1iJPQkp5DAIoX25vA8EA6VVc/6NXVxk8vAkf8GJs/5zeAmtKJqtHZLu5b2AAG
 PzsyYgegf89WBIn3M0zA6vUSjhH3rrfxjhFynYrROWZw86t+/4caW
X-Gm-Gg: ASbGnctuzo7GnbeG1QkGDwR/uo8wFZ9U+hdCf14ML6yZJrddC7qA+MDPSH4ztKTdRJu
 mA2iJgPlNDYLICAc7QOYT8XWR35AC+P3q5oZLW6vmpyPv0OQB/twvrbYVaIQ94TEsjymJb+p8Sc
 XUsDghxx3K7lkvwV4+p/WE+sS+Bey9d3KGFjyNyJIhYejO3NiaKovB4GeCLvQrfol04n8IoYhUV
 sTUZ8u+ObNiP8wW4agkK/3LR3mrImA/J+QBlFgAsWzW/MROxfNo8AlVlsZLv6CcwKOYrrYrbt+A
 Twsr+RldwsY0uW/tpg==
X-Received: by 2002:ad4:5d69:0:b0:6d8:81cd:a0ce with SMTP id
 6a1803df08f44-6dd233aab3amr301289566d6.43.1735068375862; 
 Tue, 24 Dec 2024 11:26:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG90auuSBO7zwjWlitXn+gqNWza0bsGzCempIo07eImD54dEbCV3Z104GbYz3SIkhcJGJ7VuA==
X-Received: by 2002:ad4:5d69:0:b0:6d8:81cd:a0ce with SMTP id
 6a1803df08f44-6dd233aab3amr301289276d6.43.1735068375569; 
 Tue, 24 Dec 2024 11:26:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea9d0sm55285216d6.7.2024.12.24.11.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 11:26:14 -0800 (PST)
Date: Tue, 24 Dec 2024 14:26:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 17/23] tests/qtest: optimize migrate_set_ports
Message-ID: <Z2sK1Vg2M43fxcRR@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-18-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-18-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 24, 2024 at 08:17:02AM -0800, Steve Sistare wrote:
> Do not query connection parameters if all port numbers are known.  This is
> more efficient, and also solves a problem for the cpr-transfer test.
> At the point where cpr-transfer calls migrate_qmp and migrate_set_ports,
> the monitor is not connected and queries are not allowed.  Port=0 is
> never used for cpr-transfer.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


