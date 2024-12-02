Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDABD78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9oj-0006go-Gv; Mon, 02 Dec 2024 12:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9oh-0006bZ-3q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:02:35 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9oc-0001b4-R7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:02:34 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7251ce598adso3021660b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733158949; x=1733763749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l/3jlym+CaGZeqYFr0WXzW2yqAQf2DEzRMSSQjKT1gY=;
 b=kUC82czflWH3gEXgJ2G8B8CBDDo3U6xiYLbRzfGFEOAVe9pyjFOGyGLNgkVjwBrjjM
 CQY7+LQo5PBkuFMgPyzw3R6TIgSOMDgP0JW4GBDg0V8MllXiBWfwFitv4wW8pLzz/lGE
 qF7PgiwA07QHqhzxHnwB8mcV326Hk0RHU/qfeqB/rGPgf/akXt1PpCmyYLbBgP57ARdl
 BIREtOrE0sTJzccpqYViZeZmbGExXuPaf0lVrhbImUqYni+bw0QuayhCEN+eS4iWj1Vt
 sj9FoWz8jgeKxMAHyTjteECi8IPkawgdFmOcQsM/VdF+OEk8jClk3/yKuQmicP2TAC7D
 +5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733158949; x=1733763749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/3jlym+CaGZeqYFr0WXzW2yqAQf2DEzRMSSQjKT1gY=;
 b=TOK8ilPK5j3DkfI+ebJBYxqQd5xQeh/95dAUw/Xo9OS5UG679oRRJ75Cki785wqW5+
 KUAVAAlODjpTlGpipLlLFVdMMcGHnPOrMNXqvwrKBl8kL5b9QdPF4x8CtPjbp37ztHtH
 hvW7cDgi5+Yrk8tTiKSWYqK/zsQUJfiYMVh7STSGZp7NYoB8SQ+sdg1cimWoLGTQH5tj
 DBB6rIJ4C/6Wwp2vm6xHwZBXUk3fUyQwbJAMGQnfIEM3ujZU+A0EChy+vfZ9S5POieLe
 Q1WwtkDnNzs/B9FyeiLeR1ySaW2qiBv/nywcmDOYzmwqqbgw9VHuf/CecnFo6M+Dee/j
 WCLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXbyQcVhWsw8f6sazjsQy7fvTTq2sDpk4vxv+Cvex6cpTvNjalZCNpy4RQlqjgrV/aqsiz33Nsfy3f@nongnu.org
X-Gm-Message-State: AOJu0YxGCi03niHUjzVFlmxXf0PP/5AZWF1Ne92/+X3DYEl+Pcfx/E/X
 G+dW6X0pyhosWJwsg6foA3PvFn0UQ5B1xLHZBd3rz354k2ZaGmU=
X-Gm-Gg: ASbGncvsm9QnESiKx7g+H0jMzGbAiJxyKgz8m2RsHDvsbekP//Tz0rY4CqBO/ZlV2bd
 M7G0+JQqYF4ZwskkbBNIFfkSEEmTM0Fuh7BCOjQg4pdRGWLOv9cERqFrRmzdpSJe02XhBemcUpe
 pnvhQaQB3NxqS0Ay13SN82Xy5QL/KI1uKupwnVq+HwCYCucItQrMoDpeNpiLUYpw6dzwDeYglrc
 4Vwz6fW6lSvoTkO+0xnbehRG+gjwKe1TFzFWVpCev3EEX9ehDDDQiE=
X-Google-Smtp-Source: AGHT+IGe8yBNqesM+B7c/sM8az59k+MYK38bBvQkC/Wqhs9eWaNCNvaUkyqnHD+QyBsi8Md3FGW+QQ==
X-Received: by 2002:a17:90b:3a8b:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2ee3cc17a99mr21458600a91.26.1733158949068; 
 Mon, 02 Dec 2024 09:02:29 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee97014017sm3819041a91.33.2024.12.02.09.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:02:28 -0800 (PST)
Message-ID: <068e78b1-6334-4b0f-bf77-297e5b4f0243@gmail.com>
Date: Tue, 3 Dec 2024 01:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] vfio/igd: canonicalize memory size calculations
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-3-tomitamoeko@gmail.com>
 <20241201222843.6f415e29.alex.williamson@redhat.com>
 <c5e8fbe268e344d03b63e94c440da965121bfb98.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <c5e8fbe268e344d03b63e94c440da965121bfb98.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 12/2/24 17:10, Corvin Köhne wrote:
> On Sun, 2024-12-01 at 22:28 -0700, Alex Williamson wrote:
>> CAUTION: External Email!!
>> On Mon,  2 Dec 2024 00:09:32 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
>>> calculating GTT stolen memory and Data stolen memory size in bytes,
>>> and use macros to replace the hardware-related magic numbers for
>>> better readability.
>>>
>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>> ---
>>>  hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++-------------------
>>> ---
>>>  1 file changed, 57 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>> index e40e601026..b449316ec0 100644
>>> --- a/hw/vfio/igd.c
>>> +++ b/hw/vfio/igd.c
>>> @@ -116,6 +116,54 @@ typedef struct VFIOIGDQuirk {
>>>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11
>>> and later */
>>>  
>>> +#define IGD_GMCH_GEN6_GMS_SHIFT     3
>>> +#define IGD_GMCH_GEN6_GMS_MASK      0x1f
>>> +#define IGD_GMCH_GEN6_GGMS_SHIFT    8
>>> +#define IGD_GMCH_GEN6_GGMS_MASK     0x3
>>> +#define IGD_GMCH_GEN8_GMS_SHIFT     8
>>> +#define IGD_GMCH_GEN8_GMS_MASK      0xff
>>> +#define IGD_GMCH_GEN8_GGMS_SHIFT    6
>>> +#define IGD_GMCH_GEN8_GGMS_MASK     0x3
>>> +
> 
> You should consider reusing the names used by Linux [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/intel/i915_drm.h?h=v6.12#n50

Original SNB/BDW in i915 is not easy to understand I think, probably
adding a comment here is better?

>>> +static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
>>> +{
>>> +    uint64_t ggms;
>>> +
>>> +    if (gen < 8) {
>>> +        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) &
>>> IGD_GMCH_GEN6_GGMS_MASK;
>>> +    } else {
>>> +        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) &
>>> IGD_GMCH_GEN8_GGMS_MASK;
>>> +        ggms *= 2;
>>> +    }
>>> +
>>> +    return ggms * MiB;
>>> +}
>>> +
>>> +static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>>> +{
>>> +    uint64_t gms;
>>> +
>>> +    if (gen < 8) {
>>> +        gms = (gmch >> IGD_GMCH_GEN6_GMS_SHIFT) &
>>> IGD_GMCH_GEN6_GMS_MASK;
>>> +    } else {
>>> +        gms = (gmch >> IGD_GMCH_GEN8_GMS_SHIFT) &
>>> IGD_GMCH_GEN8_GMS_MASK;
>>> +    }
>>> +
>>> +    if (gen < 9) {
>>> +        if (gms < 0x10) {
>>> +            return gms * 32 * MiB;
>>> +        }
>>
>> igd_get_stolen_mb() used:
>>
>>         if (gms > 0x10) {
>>             error_report("Unsupported IGD GMS value 0x%x", gms);
>>             return 0;
>>         }
>>         return gms * 32;
>>
>> Therefore this should use <= to be equivalent.
> 
> I'd personally prefer moving the code in one commit and change the
> format in a second one.
>
> If you want to touch this, I'd align it with Linux, which multiplies gms
> by 32 MB unconditionally for gen 6 and 8 [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v6.12#n404
> 
>>> +    } else {
>>> +        if (gms < 0xf0) {
>>> +            return gms * 32 * MiB;
>>> +        } else {
>>> +            return (gms - 0xf0 + 1) * 4 * MiB;
>>
>> This does not match the line from igd_get_stolen_mb():
>>
>>             return (gms - 0xf0) * 4 + 4;
>>
>> Explain.
>>
> 
> I've chosen the current format because it aligns with Linux [1]. I would
> keep it as is to make it easier to sync with Linux.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v6.12#n460

Will use
	return ((gms - 0xf0) * 4 + 4) * MiB;
in v2

>>> +        }
>>> +    }
>>> +
>>> +    error_report("Unsupported IGD GMS value 0x%lx", gms);
>>> +    return 0;
>>> +}
>>>  
>>>  /*
>>>   * The rather short list of registers that we copy from the host
>>> devices.
>>> @@ -264,17 +312,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice
>>> *vdev,
>>>  static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>>>  {
>>>      uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH,
>>> sizeof(gmch));
>>> -    int ggms, gen = igd_gen(vdev);
>>> -
>>> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH,
>>> sizeof(gmch));
>>> -    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>>> -    if (gen > 7) {
>>> -        ggms = 1 << ggms;
>>> -    }
>>> -
>>> -    ggms *= MiB;
>>> +    int gen = igd_gen(vdev);
>>> +    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
>>>  
>>> -    return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
>>> +    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
>>>  }
>>>  
>>>  /*
>>> @@ -481,30 +522,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice
>>> *vdev, int nr)
>>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>>  }
>>>  
>>> -static int igd_get_stolen_mb(int gen, uint32_t gmch)
>>> -{
>>> -    int gms;
>>> -
>>> -    if (gen < 8) {
>>> -        gms = (gmch >> 3) & 0x1f;
>>> -    } else {
>>> -        gms = (gmch >> 8) & 0xff;
>>> -    }
>>> -
>>> -    if (gen < 9) {
>>> -        if (gms > 0x10) {
>>> -            error_report("Unsupported IGD GMS value 0x%x", gms);
>>> -            return 0;
>>> -        }
>>> -        return gms * 32;
>>> -    } else {
>>> -        if (gms < 0xf0)
>>> -            return gms * 32;
>>> -        else
>>> -            return (gms - 0xf0) * 4 + 4;
>>> -    }
>>> -}
>>> -
>>>  void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>>  {
>>>      g_autofree struct vfio_region_info *rom = NULL;
>>> @@ -514,7 +531,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
>>> *vdev, int nr)
>>>      VFIOQuirk *quirk;
>>>      VFIOIGDQuirk *igd;
>>>      PCIDevice *lpc_bridge;
>>> -    int i, ret, ggms_mb, gms_mb = 0, gen;
>>> +    int i, ret, gen;
>>> +    uint64_t ggms_size, gms_size;
>>>      uint64_t *bdsm_size;
>>>      uint32_t gmch;
>>>      uint16_t cmd_orig, cmd;
>>> @@ -676,13 +694,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
>>> *vdev, int nr)
>>>  
>>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>>  
>>> -    /* Determine the size of stolen memory needed for GTT */
>>> -    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>>> -    if (gen > 7) {
>>> -        ggms_mb = 1 << ggms_mb;
>>> -    }
>>> -
>>> -    gms_mb = igd_get_stolen_mb(gen, gmch);
>>> +    ggms_size = igd_gtt_memory_size(gen, gmch);
>>> +    gms_size = igd_stolen_memory_size(gen, gmch);
>>>  
>>>      /*
>>>       * Request reserved memory for stolen memory via fw_cfg.  VM
>>> firmware
>>> @@ -693,7 +706,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
>>> *vdev, int nr)
>>>       * config offset 0x5C.
>>>       */
>>>      bdsm_size = g_malloc(sizeof(*bdsm_size));
>>> -    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
>>> +    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
>>>      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
>>>                      bdsm_size, sizeof(*bdsm_size));
>>>  
>>> @@ -744,5 +757,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
>>> *vdev, int nr)
>>>                       vdev-
>>>> https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAAD3YuKN4_e
>>> If2wAAADsWKVxcuZtvheRgRqIemuzgT-OABVjIqlMqKN-
>>> EU30bxV28qXZ_Y5_SMs0YfH8q_KtHOPLp1QG1mJuzWERjIVCEePSftEKzXou_Qr3jboY
>>> Ii_VUdvptqZTIPyfY-GJ9iOrnUrKoc_oifOB9wY1 );
>>>      }
>>>  
>>> -    trace_vfio_pci_igd_bdsm_enabled(vdev-
>>>> https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAAD3YuKN4_e
>>> If2wAAADsWKVxcuZtvheRgRqIemuzgT-OABVjIqlMqKN-
>>> EU30bxV28qXZ_Y5_SMs0YfH8q_KtHOPLp1QG1mJuzWERjIVCEePSftEKzXou_Qr3jboY
>>> Ii_VUdvptqZTIPyfY-GJ9iOrnUrKoc_oifOB9wY1 , ggms_mb + gms_mb);
>>> +    trace_vfio_pci_igd_bdsm_enabled(vdev-
>>>> https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAAD3YuKN4_e
>>> If2wAAADsWKVxcuZtvheRgRqIemuzgT-OABVjIqlMqKN-
>>> EU30bxV28qXZ_Y5_SMs0YfH8q_KtHOPLp1QG1mJuzWERjIVCEePSftEKzXou_Qr3jboY
>>> Ii_VUdvptqZTIPyfY-GJ9iOrnUrKoc_oifOB9wY1 , *bdsm_size / MiB);
>>
>> Technically this should use le64_to_cpu(*bdsm_size), or retain the
>> addition logic.  Thanks,
>>
>> Alex
> 


