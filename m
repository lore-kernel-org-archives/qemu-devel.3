Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5BBC28B30
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 17:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqy9U-0008VM-Rl; Sat, 08 Mar 2025 12:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqy9M-0008Qf-1T
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqy9K-0000Tp-FP
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741455585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bGcfUxnZD2BDHLv4HPQl4B+PTJ6sdhEDZmj/JnVgQCA=;
 b=VpZFwkO+X80lVCNQuyJxlGMqRChSIZfbkytkhvZRY6ep6/5Y3iMUTxg1tXHSIuguwFfCaA
 Q86fUU8xf6pzlQ70lhKfX7Qw1GOlTxLeDvxwHaUSKO1Y1GM3DHx9nbVxwOtsdIBsLnGIxQ
 bYX26Xhd/nYcHsLPgZu7x9lwpxdJn0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-LzOgod57OF-OEPExBo6uMg-1; Sat, 08 Mar 2025 12:39:43 -0500
X-MC-Unique: LzOgod57OF-OEPExBo6uMg-1
X-Mimecast-MFC-AGG-ID: LzOgod57OF-OEPExBo6uMg_1741455582
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so828916f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 09:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741455582; x=1742060382;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGcfUxnZD2BDHLv4HPQl4B+PTJ6sdhEDZmj/JnVgQCA=;
 b=YnzBaCShWll5+jrmF4Yoaq+yCTmIJoptPTUxNrRoXKeoFx76ZFvfEhoxxZRirG9/vz
 So+usu8ryWw5atQU6r+MczXfsKUsVjg/iK6QAbcz6iAKU3OeSAQLy6iW5j5tnXkj1Azt
 RVODdb58j1Gag5d4PvCXkQteXjvtuEUdp5+m8Gcy+2EYuzeH44R8mObMRlvF4dEMFwgp
 YUrIqJiRoL9O3DyelTl+bbv5xMvq46eCYOdrfpB/PO7ZWyMQuOsRuT1bVxJQHsW0rplX
 32S7089nX7dqUSJCxGgMxTgKYsQWy9Vku6qx8P+Bh21Pge0giTH4eHHZXV3yET1ILet9
 ex1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVyFJcDWUlXQxWthln+lXUC/gP+QfFuhMtOYxP6svrHpiDw356EiE19jsklu/+nUsdFhVuPPv0SrE@nongnu.org
X-Gm-Message-State: AOJu0YwMmYT/9IuJ+zzrsN6orzpM2Qc9hdc+K5Vwk/YMQoDvZPH2kNT6
 s2JJD6nRMmHkPvuK99eEg4XFNn27RPDQSln4+nUewmrUn75oCkWcWBIz8KMxRS1KMiRWlhCTaWT
 Fd+YGOeeUrwTfIByivKcjtdAH5uFIbjHcnxy4vIXD+oVJYDqEXdOH
X-Gm-Gg: ASbGnctvBiz2dQ1PM+k707nUDVGo64fjyEpett/m+IXEPC70CGWVzi5MET07Njd0e/8
 PnwIE9n2dsR+9v/cUewcpyvP20KbElKezBUzx1mJMPAMYFVoQnUB3VdQY+jAprVKQ6/6sBySRQC
 tXqXXxSruhuTO0exQWrhi24AQP85URqPNsHFxY9Fu1n6s4kr5tWNDH4rs/STw9qiCw77DslQzMk
 qyH4Um4XZ8pBGFt6tISD1/SVF1qwG179dvJsn93kiX67fHrq3hkhf9jtVWgZnJdI0atkx6ckvwd
 H6tddjkJDZxoOza9pv4kiqfNdEYeO3mHshLyEH8bnRWwUlovFnKvdw==
X-Received: by 2002:a05:6000:1a87:b0:391:2391:2f79 with SMTP id
 ffacd0b85a97d-39132d98a8emr5549110f8f.43.1741455582227; 
 Sat, 08 Mar 2025 09:39:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQMbpEoddj0se9YngZ5X8Iyjc8r63xl9sjZbhchD57b60ocj0gTwZgLixwwMk5jxxBRj8O/A==
X-Received: by 2002:a05:6000:1a87:b0:391:2391:2f79 with SMTP id
 ffacd0b85a97d-39132d98a8emr5549097f8f.43.1741455581891; 
 Sat, 08 Mar 2025 09:39:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103aa5sm9499939f8f.94.2025.03.08.09.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 09:39:41 -0800 (PST)
Message-ID: <a24abb3b-d10d-4891-8d1c-e9fafe6eae6a@redhat.com>
Date: Sat, 8 Mar 2025 18:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/vfio: Compile some common objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-4-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250307180337.14811-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/7/25 19:03, Philippe Mathieu-Daudé wrote:
> Some files don't rely on any target-specific knowledge
> and can be compiled once:
> 
>   - helpers.c
>   - container-base.c
>   - migration.c (removing unnecessary "exec/ram_addr.h")
>   - migration-multifd.c
>   - cpr.c
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration.c |  1 -
>   hw/vfio/meson.build | 13 ++++++++-----
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 416643ddd69..fbff46cfc35 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -27,7 +27,6 @@
>   #include "qapi/error.h"
>   #include "qapi/qapi-events-vfio.h"
>   #include "exec/ramlist.h"
> -#include "exec/ram_addr.h"
>   #include "pci.h"
>   #include "trace.h"
>   #include "hw/hw.h"
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 260d65febd6..8e376cfcbf8 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -1,12 +1,7 @@
>   vfio_ss = ss.source_set()
>   vfio_ss.add(files(
> -  'helpers.c',
>     'common.c',
> -  'container-base.c',
>     'container.c',
> -  'migration.c',
> -  'migration-multifd.c',
> -  'cpr.c',
>   ))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>   vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
> @@ -25,3 +20,11 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>   
>   specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> +
> +system_ss.add(when: 'CONFIG_VFIO', if_true: files(
> +  'helpers.c',
> +  'container-base.c',
> +  'migration.c',
> +  'migration-multifd.c',
> +  'cpr.c',
> +))


