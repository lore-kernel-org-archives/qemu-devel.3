Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258DFE77181
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKl5d-0000LS-OB; Mon, 09 Dec 2024 16:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKl5c-0000LH-U6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKl5a-0006td-U9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733778885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0H0jdsDyFxRohFZ2TOMJG8iCuTWPejxGMmpPLeQpiiw=;
 b=TwjBBIvohcclFn+Bgsi6fJREP6CCgBK0sBdlP9+eTGW9DwShayZoWimRBQEItPV2/VFo6E
 zvlGBmoZVRuIvEgdAZeSQXVhjTKcr4fwLlrCq7IG0sGouJb9iaaB9iiP0YyUv5J4TofrcR
 1D4mN76UBo2MGuaxs3riZAWugoG2d0k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-UsvPSFk0McGrS4OClE0Elg-1; Mon, 09 Dec 2024 16:14:41 -0500
X-MC-Unique: UsvPSFk0McGrS4OClE0Elg-1
X-Mimecast-MFC-AGG-ID: UsvPSFk0McGrS4OClE0Elg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6cf68526eso284185185a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778880; x=1734383680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H0jdsDyFxRohFZ2TOMJG8iCuTWPejxGMmpPLeQpiiw=;
 b=mpSY0JesHpqCSvR+h36iWmTqoUkqS0zwCEV4hIKo6xHioG2xRhayy7Zxe8e+GZmB3j
 fL6YTYRmTsn0/AA/woT+7Q6qs3fau9KnxXdfujGDnSZEH/2yRyXwSHRxZ6ONkbz9vxPv
 Yiv4/2EX+h9PLWIJviSqkyGqWFNExSz7gDjQySk4wdZiuJQ9IFalTs1UYSixXERUZ++A
 EktWQ+FefE43xlmB+1VVnFJU5xwVtuv07p+fiAnYzDomSAKESjpfGYifO8PcMgHegDn5
 1UL8vL46/bEs4xfj2NGowKR77L4zIJ4AZIrAJbb+l4hc06SckDzgxEDkPnpmHgjzb47D
 GQ9Q==
X-Gm-Message-State: AOJu0YzsiHNEmyL6fRaiGn7JSkO2nulkDdJNEQbQTnBivakkyWB4e/Uw
 xW1wNwgKc4fkxH7urNPjatfefkORsGwXq9QPRtZ0IQ4TJkXjTbqZJIfcS7FTKZSoCCFSg4RnpnF
 5vfxLPI1ZVMn3LvqlLQ3rcnUKS7hMEUMMUfQjMJ61H2xaoDcvCqIHsKiXBTZC
X-Gm-Gg: ASbGncsMYu0mSFwR0MRGh/r96J7dnbi/piWkqpljt9nolryDZkHHQSjFRw76auea4UK
 sJfv6Ounec4+Wfej9CCIJ0Ly5ZVoiLAcU5VP85yeH07VjvZczK3ovig7uM/oRhFNuQNwEcE06Ts
 ZImQSFoIZ82jbVkd/f5vyuhv+LOoeF9pIxlQcNf363wxDTPQ0W01aZuDnMTMmcVK/OW8A9Ew6YN
 yo9mJHvhqS5CRZVxLZ2xW31+BAQOMJuJQh3nYp3t1oxhHDujCUqdpxzyteZcFuJ217kOVjWsWZg
 ogiiLbEBJZPYsEg=
X-Received: by 2002:a05:620a:1aa4:b0:7b6:7970:6506 with SMTP id
 af79cd13be357-7b6dce7f2b1mr279724485a.38.1733778880751; 
 Mon, 09 Dec 2024 13:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5klpYt9bqP5r4WGj2+o42G/crKV1W01ol9pcF6nVUMD/CX4CCzEUsilHQg71SqNnUHDbkKQ==
X-Received: by 2002:a05:620a:1aa4:b0:7b6:7970:6506 with SMTP id
 af79cd13be357-7b6dce7f2b1mr279721885a.38.1733778880474; 
 Mon, 09 Dec 2024 13:14:40 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6da08306bsm81102985a.66.2024.12.09.13.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 13:14:39 -0800 (PST)
Date: Mon, 9 Dec 2024 16:14:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] tests/qtest/migration: Initialize buffer in
 probe_o_direct_support
Message-ID: <Z1ddvtuy8-3LgMKv@x1n>
References: <20241209204427.17763-1-farosas@suse.de>
 <20241209204427.17763-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209204427.17763-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 09, 2024 at 05:44:23PM -0300, Fabiano Rosas wrote:
> Valgrind complains about the probe_o_direct_support() function reading
> from an uninitialized buffer. For probing O_DIRECT support we don't
> actually need to write to the file, just make sure the pwrite call
> doesn't reject the write. Still, write zeroes to the buffer to
> suppress the warning.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


