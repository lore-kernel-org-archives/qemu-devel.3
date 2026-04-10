Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429A9E9904A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6W9-0001In-K6; Fri, 10 Apr 2026 03:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6W7-0001IN-VF
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6W6-0000qx-7X
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775806981;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRfM/2uzYK3VTBfMBLk8dXqfUTctabwqWxHpKci4tIM=;
 b=KdS5NY0q+RZfJWDxZaiUGyXZeG6YvvgqCD5Av7sAFlipunupfS1mldl08fdj3dZJ/o2iey
 4QoG+gNZY64tNVWChdBY5VBXM6uO8rG+OT0ApOyUclIMhp8vnJMXvs8d8Hz3NVB5FzlR+w
 5m95AltzBKGMPH1RM8BUGdqvawz2GIw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-NPP4I7rQOe20QBWcicig7g-1; Fri, 10 Apr 2026 03:43:00 -0400
X-MC-Unique: NPP4I7rQOe20QBWcicig7g-1
X-Mimecast-MFC-AGG-ID: NPP4I7rQOe20QBWcicig7g_1775806979
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488bf01961cso11538205e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775806979; x=1776411779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRfM/2uzYK3VTBfMBLk8dXqfUTctabwqWxHpKci4tIM=;
 b=gGYRQ5c/0oSlGxXdgHtDQ6X5UWoFiEUkycFdRnXNN5rP0ctr75OhN7qx635csafLko
 ZSG3WW6utUWaC0XWvUzKP9GlVlP/Uoaq13ymhu9sMtLft3kLybyfWLwTx8HBQvNyfCMf
 0vyXAtBeOeC3R5St+jEHe1oVHGw4VdgWB3T9V8BWOqD8GYEIMO/xAsyvfL3CLybHEwRl
 by8ikufvo57g/pepWbE76edNvE3x1sUpLRuhtIKmA7Bk8yxQ2qc/OXHO3lQfDNOoM0sz
 eWfzLW2UbBPBrIbJ0RnWdF6C8jOOdKLp3GVve8j8fqOK3opYOihZmeJ/ncljSP1NSJpD
 U6gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMiItMt1IGyxgt5Mbx61t/P9lGeHws/HZgCYEZoFg0PvNq5vmbIlt93f936r9Jpsn8l3IN8PopSYBY@nongnu.org
X-Gm-Message-State: AOJu0Yxkc6rXWQlTwKxrXm5jf0pCopMhY2uQfuEjogaBLQFHj/JGybet
 ZEhPPhKpPCYtUHGzZSsz0scm1W5zTnJq5SIORjJjAQ0D3ZlR/9CqHmZm1PsoyS80VsowYzclyKc
 CkQ8x9nDcu/U+/sedgnfk9Q1qn1eN9B02xFvKR9k3Ns16QyDAkEZ/Kt4q
X-Gm-Gg: AeBDiet6J9oDYdd8KyFV+E0g4pmhczJaMJSPbJnFc91f/91lxzigaP2vLJl/PGN6oQy
 LMfIrhXfKTys2M8k+iEG5NmICvIOq6CtlXrHcXNLGUs4QBkLcwTosMyXI4U4ZlFIFHnrSOgZk3V
 s5w9gmubwR+gKO8kU80T/xIEpahT4aJkJn10cpAVPfauZcV+FZnzuUX6dcYCLtYGJ7dWmqXoy7S
 tehk5yuueQW2+jaqa1ZuERXV17z8GhdJvdFvB+Wcsy3dxhe26cmDZgmXC4M4CishyGuPkWUciVw
 ajTKrHzVLmtSFFaVmgeaa2SllssH8J7iKp14mEqm1NLxE/1K3iH+Wc0tu67A8hl6tjOcorotDrH
 p0MVsOlXxoNX+1bP4wiFqU4uSVXZWLhzgE+OYtJN48YW1e785tRUmeHJQIISA8UlWE6nIzw==
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-488d67fa48emr25267045e9.9.1775806978601; 
 Fri, 10 Apr 2026 00:42:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-488d67fa48emr25266695e9.9.1775806978115; 
 Fri, 10 Apr 2026 00:42:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3d4dbsm50551495e9.14.2026.04.10.00.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:42:57 -0700 (PDT)
Message-ID: <1bdba168-e5fb-491e-a9ee-6311bc95b38d@redhat.com>
Date: Fri, 10 Apr 2026 09:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/arm/smmuv3: Change the default ats support to
 match the host
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-4-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260401010231.4166776-4-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/1/26 3:02 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Set the default value of ATS to auto. The default for ATS support used
> to be set to off, but we change it to match what the host IOMMU
> properties report. Introduce a new compat for the changed default.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3.c   | 2 +-
>  hw/core/machine.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index f3603554e3..f353865187 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2158,7 +2158,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
see my previous comment about squashing all those patches. Besides you
need to update qemu-options.hx where the default value is documented as
non auto.

Eric
>      DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_0),
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e9..6796ab63cc 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -37,6 +37,11 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
> +#include "hw/arm/smmuv3.h"
> +
> +GlobalProperty hw_compat_11_0[] = {
> +    { TYPE_ARM_SMMUV3, "ats", "off" },
> +};
>  
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },


