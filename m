Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FC1E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxSN-0004Gl-Ej; Wed, 18 Dec 2024 12:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxSF-00049q-5S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:03:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxSD-0001VN-J3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734541399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+umMeQZWJAOb2QyAaZOingEdwoIhI/E9+ym/x0Jaz4=;
 b=OfKcJVtccT1Sl1BRaSJmme2BVcrvTL37h6R8E9yHWvUIvnA+rxICq5tmkzjECROX1d1QO3
 rVHrsZBgFLNzUBrHfx3Nsu3uzn+RLjBquFnrmwB0cR7o1mUktQF7Hz1nJ1lLud0+ZAQgcK
 rZdn6ohvDpsz7XQ/CyG41UNQbvarjrQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-abSOP8wNOVGqLflklO_0Ow-1; Wed, 18 Dec 2024 12:03:18 -0500
X-MC-Unique: abSOP8wNOVGqLflklO_0Ow-1
X-Mimecast-MFC-AGG-ID: abSOP8wNOVGqLflklO_0Ow
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88d56beb7so66859926d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541398; x=1735146198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+umMeQZWJAOb2QyAaZOingEdwoIhI/E9+ym/x0Jaz4=;
 b=ddyoRz5ei2bu6cgnpcN6I1DvB/Y4fv4BJbZgvAV7EzCA5zMyc2Kx05UpfaI2+AEQ3e
 ZZf92qAqlOsZn2shx4cyNAOPL0hOQdNpRXDxN7eRCn+Y9t8gAgFGczuQeZZI23jX5Ot/
 4M8bdWk91Mrs1jZHgxzqkweSlg1wZY96mLMk/EZiSJy+LsGnu+YyFFbWkmwA6npuRvbT
 ydAbgK1ZgEb8l57kzLSQypoguuV9/+uRSWs4Z8tJDZQSun9/NnRK3B4mfwQvoq83i1u0
 IQnkuu2pdIueOofNkKKN5job1Yysv9fG0dWiS9OUvXfzawkKgEaPDkIdTkXp3jesd9rU
 y3uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQkJ/0/8dXT4Dr88caC3GH6I+pv2JF+QD5DfKxTaLBAec+bJYgCf5HMuSLJCs6k2R3MSN34Dod+ad1@nongnu.org
X-Gm-Message-State: AOJu0Yz6FILziuqkjyiyyqNChjzL/2hVlfEJGNMPxTZQneVqXUrW8YP/
 38jgJ6wvsrgolhvcijH/3pxqfR9zOzFAcQalxt4La7D5+Wmcc3oqGwXmDSQtMDmqu7WoAD+Rf8d
 1HlVBBxF5L4/asyIQolNRHJmgPwl6UCuE5/ujvsFcyOczCxH5IHLF
X-Gm-Gg: ASbGnctWWuj8r/f99Y5rdslrfxhvOKoHu0vVPOb+Gpw3mXADJCV0FyLADltwjCKxQcj
 nXLhoCkNR63I5FyBz91DvZzLTKViSrDSfH0nt5ZCNlZcl8gtAydO/RF0VyZnWk3vShNT/1hKPDP
 HYJgyu1PcIy644M/gc4m8052p326KHMPRkksaOtcHLmTl1OfNLu0ouFqb7Lc04zJbnZzf02UGYd
 wVvnmOEyoHHaqypQFNwVvCSK8sGxwi18x5WibL2+N2daqrq6pstKF4fKM+kIeorvelvrsI1jPo6
 WtiLRb/5E01G50S08Q==
X-Received: by 2002:a05:6214:1c8b:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6dd090b5cd6mr61493536d6.0.1734541398029; 
 Wed, 18 Dec 2024 09:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZTyLOIuzK8BWUWs4HH4M9iygjds9ts/REi9W1TNlu86993+Q59ysB/tobW7X6gcvoJM0tng==
X-Received: by 2002:a05:6214:1c8b:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6dd090b5cd6mr61492786d6.0.1734541397461; 
 Wed, 18 Dec 2024 09:03:17 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd22fed2sm51983306d6.10.2024.12.18.09.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:03:16 -0800 (PST)
Date: Wed, 18 Dec 2024 12:03:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, jason.zeng@intel.com,
 yichen.wang@bytedance.com
Subject: Re: [PATCH 1/3] multifd: bugfix for migration using compression
 methods
Message-ID: <Z2MAUj-ComKI2HUE@x1n>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
 <20241218091413.140396-2-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218091413.140396-2-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 05:14:11PM +0800, Yuan Liu wrote:
> When compression is enabled on the migration channel and
> the pages processed are all zero pages, these pages will
> not be sent and updated on the target side, resulting in
> incorrect memory data on the source and target sides.
> 
> The root cause is that all compression methods call
> multifd_send_prepare_common to determine whether to compress
> dirty pages, but multifd_send_prepare_common does not update
> the IOV of MultiFDPacket_t when all dirty pages are zero pages.
> 
> The solution is to always update the IOV of MultiFDPacket_t
> regardless of whether the dirty pages are all zero pages.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Jason Zeng <jason.zeng@intel.com>

Ouch.. thanks for digging this out.

Reviewed-by: Peter Xu <peterx@redhat.com>

Is this the correct Fixes tag (and copy stable for 9.0+)?

Fixes: 303e6f54f9 ("migration/multifd: Implement zero page transmission on the multifd thread.")

> ---
>  migration/multifd-nocomp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 55191152f9..2e4aaac285 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -362,6 +362,7 @@ int multifd_ram_flush_and_sync(void)
>  bool multifd_send_prepare_common(MultiFDSendParams *p)
>  {
>      MultiFDPages_t *pages = &p->data->u.ram;
> +    multifd_send_prepare_header(p);
>      multifd_send_zero_page_detect(p);
>  
>      if (!pages->normal_num) {
> @@ -369,8 +370,6 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
>          return false;
>      }
>  
> -    multifd_send_prepare_header(p);
> -
>      return true;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Peter Xu


