Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F62CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kOc-0003fz-EK; Fri, 17 Oct 2025 09:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9kOZ-0003dl-Vc
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9kOQ-0006nZ-Pz
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760707266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3BumayGbNRyHUpWdyfjMJmdw76TdGOERSiEhbAvqrs=;
 b=K9aPU8iM/Q/r8NPuk4ODtGe17raDxoqgFDEwGlHs38xjTu128V6YXSu7gtpRFDWWTOAakp
 qitTlyHc42/ZFL0ccupQl3C+TC+EhwZng4JfFgtKzMigcewNVEGzZuCOkadTCdk4PzSx0S
 fnpSgpUaX+mXxGUtKjnRXp1DDZu5010=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-KMQt_hkoPzyx6m4TS0T_lg-1; Fri, 17 Oct 2025 09:21:05 -0400
X-MC-Unique: KMQt_hkoPzyx6m4TS0T_lg-1
X-Mimecast-MFC-AGG-ID: KMQt_hkoPzyx6m4TS0T_lg_1760707265
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8909da7f60aso362173985a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707265; x=1761312065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3BumayGbNRyHUpWdyfjMJmdw76TdGOERSiEhbAvqrs=;
 b=kvY2Enfwh/Lq6FfDznDvcREhtZcRVrvX/bLQKK0FD+KTqxRfxjaDWMvSCBS3+zRvN8
 03xiry20IZgJAjHCjIQ4gaeBYqWIsVtBOoNv4Ptx4XjKcer+IMXmP8kq9Z5uidy74qqz
 50sdyfclqH3kKZWgj/LR6rV6CXqG8X76xD9CZlaWttzpeQLqRrEKZK7vKDERl5yp8zkl
 k7d43iAI7Dt6Vz27Yc/OJR0oxUJC63Qa/jn6qM3vsv6HDimTgNbj4hzezZ5C5ft5/xeX
 CuhAeu149KHghwkhDuYQLdSxTw1wkH0AEbE4u4E9+QnFTIKISFT3S9Vi7CCvkI5rwTXm
 hpfg==
X-Gm-Message-State: AOJu0YxDpkpT1FRpIuqYhwgCPLJgM9Lp5DJFbD0FY8D3cQga8CGTYQ+n
 LXDfZWWj/wSeGo0WNLgISMWfZ8ZvL+MfjHjJHM/KlY8db4gcVHm/boWk335xstjK6yi4Xr0bHlB
 9i6PDXtXNqTOvMO+Tq9ce7R26khhMCtznqEutGYT7wt0Cz9W+QLkrXW6T
X-Gm-Gg: ASbGnct9BmvC2sF1ZvOV+/zuD7KL47kAhSsA+eg9D1PKEs+heSRSRGZ5udXmj03mzR6
 juSvGVZzijgvLqr7eVifYK1pQqevlRo4FZHeYkmpXCxZnMOUoeZ8jic88FhgaEU37Qrng3vBPHP
 DOMNpXNBmWuo0bk7ficZjSG0BIGJ5gnrhpOSaPDxr97JM2zgbxS2apCS71l6yTogpmdiEPkBwFf
 ASaIi2pBKAQsGJOwbbT1qeU67Dmmx7t/LbI6hs7RC1dmmrgl3OA1c0mPkuuzWoL43LYWY6x/N+9
 q8eYCCZtvlBG8YUaS6txFG4HBNZERL/fdp+XkG7yCkVsMgS30me/F+gAE2WOVcAnsV04VkBgHXd
 Ehwa3mSxWJ/zGruHhat6L15eauT6OTc7IZhHqBqfYdT9tnl5stiM=
X-Received: by 2002:a05:620a:404c:b0:862:3e8d:e4ec with SMTP id
 af79cd13be357-89070319242mr514590185a.60.1760707264751; 
 Fri, 17 Oct 2025 06:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrHLqe9dlhOtF7Ce6PlZ9ZTwdDRDlpp13ujYJEeqL0uQXLTl3qucOzMqmH5ovtykdWKJaKBQ==
X-Received: by 2002:a05:620a:404c:b0:862:3e8d:e4ec with SMTP id
 af79cd13be357-89070319242mr514582985a.60.1760707264080; 
 Fri, 17 Oct 2025 06:21:04 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f358742cfsm424166985a.11.2025.10.17.06.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:21:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:20:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/5] igvm: move igvm.h file to include/system
Message-ID: <estmfxhn2aukzxzzpcuj635nahvppseudipkp2ifojwyylegdw@hsvkeysd2tsm>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015112342.1672955-2-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 01:23:38PM +0200, Gerd Hoffmann wrote:
>Prepare for arch-specific igvm code being added to the code base.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> {backends => include/system}/igvm.h | 0
> backends/igvm-cfg.c                 | 2 +-
> backends/igvm.c                     | 2 +-
> 3 files changed, 2 insertions(+), 2 deletions(-)
> rename {backends => include/system}/igvm.h (100%)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm.h b/include/system/igvm.h
>similarity index 100%
>rename from backends/igvm.h
>rename to include/system/igvm.h
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index 45df63e06c1a..d00acf351249 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -12,7 +12,7 @@
> #include "qemu/osdep.h"
>
> #include "system/igvm-cfg.h"
>-#include "igvm.h"
>+#include "system/igvm.h"
> #include "qom/object_interfaces.h"
>
> static char *get_igvm(Object *obj, Error **errp)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 9ad41582ee5e..723d45b755a0 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -11,8 +11,8 @@
>
> #include "qemu/osdep.h"
>
>-#include "igvm.h"
> #include "qapi/error.h"
>+#include "system/igvm.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>-- 
>2.51.0
>


