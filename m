Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C516CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMrD-0007pG-KD; Tue, 19 May 2026 11:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPMrB-0007os-PB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPMr9-0002EI-RQ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779206382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sX39/IXIiUiLKrBvENj56XGp3PjPuuO4VY7+wn3ATW4=;
 b=MZrfWR1kO1nQgdJ2O8UXy9biHEEDhjR/HouO/K5R4D6CZZ5tpQ1wuHnTi+Sg0pV2SoXTpW
 F4+87JnpuRcMrDW0Y824fIM290C+2eblsbet7gFBo2u/qLZYycrZGJqq9cj8wLf+gxdyTb
 KqtkhaJCAtyLyhNo7lxZPRPRqgDvOX4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-OB7sI3zRNoaRq6pgVrzNXQ-1; Tue, 19 May 2026 11:59:40 -0400
X-MC-Unique: OB7sI3zRNoaRq6pgVrzNXQ-1
X-Mimecast-MFC-AGG-ID: OB7sI3zRNoaRq6pgVrzNXQ_1779206379
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fe44ce385so31312475e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206379; x=1779811179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX39/IXIiUiLKrBvENj56XGp3PjPuuO4VY7+wn3ATW4=;
 b=HMj4EFbvTKYL/C2nzjNkncN3Rdu5e/lojLZzNPMuVLl/JqNQ3Cbi4QF33EqR7uHqL5
 CCv6GoMkPg4lPEFwkh1VgwBauNFfTYceBFPS7p2Rj2pN169e8STwh3SoJR1LC67RnmN3
 SkdmzCMvEhnvZXPZfuzoDNOk0AvHL3gpQrO+1aZ+e6rd4vtHuUIcFsN6jmyJ4fWYqXjp
 JzNp/2ey1rVoqWkNQnPPeN0ZRjBuIUJSA4QK6/OGFmB1BNaO6GFLILdACYYPjYJE3lAS
 fZbNZlgnmDL7LFtCnpr2Gr/oboDdl0XgEHDvUQCUrWLBNqCU1Vhf+RP8sXkAewsa9WOx
 rOoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KPDmVLw2DWYNWkgC0nViSWbHamYmsA7VcyBxr6n+JcsbRWJSVXNdk0J2qJHTezWPiTD00c4X+nkz6@nongnu.org
X-Gm-Message-State: AOJu0YwyGfEDU/ZolK2H8JjyKlTYeCTYUv2WNZYfe16cRTXC+nhe3/Od
 kd4LP9nX4U+1W72ikUXvRySpFTPTp7HbR/iHLpSdUQM9yj4tTwkqa7pfCFFXN8l4bURT4DhhKg4
 cyQHaYQqo+E5BOrOw5P/8/1unqSAAItqaehpoOcdDHeE8fB+eUzlDAaFE
X-Gm-Gg: Acq92OGiEYlMmfLE7EdSmLDbdGE5C7QcX5Ga/VJFKEZC/8QToB2qvbm/93HHse9UPK/
 JJkfGtvjtsRD/iG/UoyNjtXYyKGqYt8k2XumG1ESNUh4ftqJzFdWO7r5Q7Z6CjZ9iCFmMxxSRHG
 /M3FrRcNuwLUAIZmbdeWlUBxJL2bE1OVL+5Q5h4uUgg7a1tvLyV5eLwMahA5MRilrVEXABvgEpp
 +kpR5baHdJBJwUbaSEm81TsdRN5EYT5oBe7FNxbvtAJjOO9l+U/x9OSw1xNsWXPIfEk1Ft3Zoaz
 JqMFMG1QTKsP7u979w6oiSUKzjlBzJa0eBK7jMBjtOF9W0+sCsuH6nnBEVj97luAznX6wDmKxf4
 Tv8bA4zDY+UxHu5yFL3Ow7j2/640ohG4haEVua1CAeDqIpqEH6FwlJLimuEhRzveeuRFDkA==
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-48fe60eb0ebmr336969535e9.10.1779206379325; 
 Tue, 19 May 2026 08:59:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-48fe60eb0ebmr336969145e9.10.1779206378934; 
 Tue, 19 May 2026 08:59:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf86db7sm166440045e9.6.2026.05.19.08.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:59:38 -0700 (PDT)
Message-ID: <acd61fd5-a0f8-41f9-9144-d6889d6deaf0@redhat.com>
Date: Tue, 19 May 2026 17:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-7-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260512193520.3109172-7-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/12/26 9:35 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
> to match the host IOMMU properties when accel=on.
>
> If accel=off and these property values are set to auto, the default
> property values defined in smmuv3_init_id_regs() for OAS and RIL will
> remain unchanged, while SSIDSIZE and ATS values will remain initialized
> at 0.
>
> Introduce a new compat for the changed defaults.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3.c   | 23 +++++++++++++++--------
>  hw/core/machine.c |  5 +++++
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 31c2eec2f4..665e6a2538 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
> +    /*
> +     * AUTO values for accel=off will resolve to:
> +     * ril: on
> +     * ats: off
> +     * oas: 44
> +     * ssidsize: 0
> +     */
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> -                              SSID_SIZE_MODE_0),
> +                              SSID_SIZE_MODE_AUTO),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2162,20 +2169,20 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "configured in nested mode for vfio-pci dev assignment");
>      object_class_property_set_description(klass, "ril",
>          "Enable/disable range invalidation support (for accel=on). "
> -        "Valid values are on, off, and auto. Defaults to on. "
> +        "Valid values are on, off, and auto. Defaults to auto. "
>          "Any attempt to turn it 'on' while the host does not support "
>          "it would fail.");
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support (for accel=on). "
> -        "Valid values are on, off, and auto. Defaults to off. "
> +        "Valid values are on, off, and auto. Defaults to auto. "
>          "Please ensure host platform supports ATS before setting it "
>          "to on.");
>      object_class_property_set_description(klass, "oas",
>          "Set Output Address Size in bits (for accel=on). "
> -        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
> +        "Valid values are 44, 48, and auto. Defaults to auto.");
not really related to this patch but I notice that we do not have any
"Please ensure host platform supports..." statement as opposed to
previous props.
While some host requirements are needed to be statistied too.

smmuv3-accel.c:    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
smmuv3-accel.c:                FIELD_EX32(s->idr[5], IDR5, OAS)) {

>      object_class_property_set_description(klass, "ssidsize",
>          "Set number of bits used to represent SubstreamIDs (SSIDs). "
> -        "Valid values are 0-20 and auto. Defaults to 0. "
> +        "Valid values are 0-20 and auto. Defaults to auto. "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "A value of 0 disables SubstreamID support. A value greater "
>          "than 0 is required to enable PASID support.");
same here.

smmuv3-accel.c:        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
smmuv3-accel.c:                               FIELD_EX32(info->idr[1],
IDR1, SSIDSIZE));

Also it is not written (for accel=on)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63baff859f..3339da99ee 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,9 +38,14 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
> +#include "hw/arm/smmuv3.h"
>  
>  GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
> +    { TYPE_ARM_SMMUV3, "ats", "off" },
> +    { TYPE_ARM_SMMUV3, "ril", "on" },
> +    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
> +    { TYPE_ARM_SMMUV3, "oas", "44" },
>  };
>  const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>  
Thanks

Eric


