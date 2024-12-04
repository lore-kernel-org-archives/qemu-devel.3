Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80033E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIulx-0004Bv-VH; Wed, 04 Dec 2024 14:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIulu-00047k-AS
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuls-0005pF-MV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733339445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVB1zuctiamy1XXRAw/sql/i0syviaIxARUs9G/8gng=;
 b=HQ0gbCT6GKIVo45CUiWVdmfygHdDXwyFnKEdJ2O6mjuvMym4UlPXJOLWjtK5Yv3AYZHOGZ
 /Kq2o2G6AN7QLIQxw5JNxUGDjsyxjplhR1NZk13dNVCglFDAQmKX2u0rtr2IPccy69NJ1+
 bCW0iVhLtcWXZYxIdgTKGYpNkm/B33M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Bmq2Z52ENgiMyY2JV5oxJA-1; Wed, 04 Dec 2024 14:10:38 -0500
X-MC-Unique: Bmq2Z52ENgiMyY2JV5oxJA-1
X-Mimecast-MFC-AGG-ID: Bmq2Z52ENgiMyY2JV5oxJA
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4669be6c87aso680491cf.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733339438; x=1733944238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVB1zuctiamy1XXRAw/sql/i0syviaIxARUs9G/8gng=;
 b=ZEIyrfTCdKdfuqkLzXZI+0PdbFFbuJ4s7G4f+6Khwa8wICibFAi8BVYntYFQivrM53
 k978JssRbt8BNZi/LtpPQp6bYrXG6ohETd+ZbxYzw0c47TUvV+3qsk52U+2f51YRKcAM
 CnjXCLo9pIKDRcRoO9piuvlBnzVkE+SyiPiEO9TRDLSK5HM7sZTgIVLracT5Y+q2Sx/N
 UtYZFB64OHBwwfs/AEAdrP9VdnPt1Cs3U+alCz9T74lSfd/Uze/l8nE8I2m4fO1mBeuZ
 ReOBW5RMgLqDz6twslvCPzEw8hVUg477eAGweHP1AdMBEPfnBTp4HZBOrFgmSvfsK226
 LbuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg1VjlikIKSg/0fCz8P+C+jRV+1JvF4K4uswfvv7Iej53v+vV5RiOTxGK10Rsp7Z1l6PW+AZlsU4I6@nongnu.org
X-Gm-Message-State: AOJu0Yzu/TpYjiWkKyD97RDzxYHRkfiQrZ7dMwzS0hZODZMZFGmsvLb0
 pvwFpdVYkyu3rmyVF1PZ1dYRBW2v69Y/sAuFVY/z9kvdJCpdMsv4E+HUKwJkDVkHjb38+dJVjAe
 gxH6VgrN3W+9o4x7wbrvAIyZD6pmqGFONGZcnh8tTKgeTZDcYlglI
X-Gm-Gg: ASbGncumosjQvoVzNg4t8olUARhECfNs33x/3HJeYI9GRRPm/W+iAJG+OYchhJddbgF
 sy+Jv/Q4Twl9FxN4Gj913FEfqlE4kRt6/zNyulPv2uDsnL84KjIEEbCo2UvneTIF7OI1OIlh3fw
 VY7hw3sQMuMbue9HUf6OfXmqQ1INECmtzz6WoDIwyPqSVG0Y9FpHDKtxOD3/Az6G//OSv9R3oVX
 I0yu0jN8ld8bRucuZCvCp8wmauiHN99vDNRMHe/wnjdLvf6buUTfzL67DVqaVGrwdDl+g/LygcJ
 C+AlV16LXBI=
X-Received: by 2002:a05:622a:1b90:b0:463:1577:2416 with SMTP id
 d75a77b69052e-4670c112289mr115828191cf.32.1733339437820; 
 Wed, 04 Dec 2024 11:10:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7yKjRg4gy6x4cBTWgLIMyltWQq1EhZ75uo8Hhn06MNODcVHHizLL4Tvx6RS6fQMroySOuPA==
X-Received: by 2002:a05:622a:1b90:b0:463:1577:2416 with SMTP id
 d75a77b69052e-4670c112289mr115827791cf.32.1733339437483; 
 Wed, 04 Dec 2024 11:10:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c405493esm76904421cf.11.2024.12.04.11.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:10:36 -0800 (PST)
Date: Wed, 4 Dec 2024 14:10:24 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/24] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Z1CpIA7_o7s-NzJ_@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Sun, Nov 17, 2024 at 08:19:55PM +0100, Maciej S. Szmigiero wrote:
> Important note:
> 4 VF benchmarks were done with commit 5504a8126115
> ("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
> reverted since this seems to improve performance in this VM config if the
> multifd transfer is enabled: the downtime performance with this commit
> present is 1141 ms enabled / 1730 ms disabled.
> 
> Smaller VF counts actually do seem to benefit from this commit, so it's
> likely that in the future adding some kind of a memslot pre-allocation
> bit stream message might make sense to avoid this downtime regression for
> 4 VF configs (and likely higher VF count too).

I'm confused why revert 5504a8126115 could be faster, and it affects as
much as 600ms.  Also how that effect differs can relevant to num of VFs.

Could you share more on this regression?  Because if that's problematic we
need to fix it, or upstream QEMU (after this series merged) will still not
work.

-- 
Peter Xu


