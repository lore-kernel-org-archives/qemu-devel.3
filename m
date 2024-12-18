Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C788E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNy4s-0001fm-Gn; Wed, 18 Dec 2024 12:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNy4r-0001f4-3z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:43:17 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNy4p-0007RA-4t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:43:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361c705434so49136615e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734543786; x=1735148586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VMe4HhiOX8R8eFmeGMoYQIpRaNCqlkZdci/vz3PVyA=;
 b=S9GnU8BwdPaqemaPf71yLmKU+mErLxd0nt4RrYvdvzr7boSrg1n+AW3HSlqosGW6+b
 DYLVYNfy9lDTo+LnQ1NxkMxpfsMgiZYkGTR5wqrdAcoBPavke/EM7nVrMiEgg7C1KY1/
 ey6Pq+SjB5Uhe2zXxmNa0SAmJJ1ToK1yHwKgaUZbUt5fHQS/CI88t15ExiNBTOV/Jj9r
 5M+CGpSq2/9M8N7L6IhmilDVJ/86UHjVU+lJvUpAG327qd/9ZMbhrIeF0gNBEwgjxyMn
 eWbVewb+R/x37SbfHZkvmtd1GglJv1RuurVWNhpZH1uhCx4b+7BUOnRAbtSqtzot/lm3
 cNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543786; x=1735148586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VMe4HhiOX8R8eFmeGMoYQIpRaNCqlkZdci/vz3PVyA=;
 b=pQ5TjjVQ2AOOU0SFyYdIs0tWuVQcM9z41oePeea+Q0HoWwyZ1lnVharX760JYilRFF
 583ArgshzDTHyrbKyEaoz4zcfjaUers2cpIkIl6LpOx9HK/0YcN7o4GtvM44ELM/TPNM
 G8cdv3VSWNr+46OXs5ArT1bCMKJj1ZOpCYuPwTAye92eb5BMNyMyJNltuNLzzVWg838S
 YG3RqglvfeAedKBDfnm4xOynci+1f8pBJ2tp4LEFgY9cMrEEuj+8ZCRpKpX5BdP/VZ+9
 IlBSSIfBiflGRhm67ee+kSGIdiSxjWRmXse4ampY9O6zSSjeFBYaFQsKkwIobsgSr/4X
 EALA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUsT3OGXudQhqgY58Z607DV6UWakKy5qynI2Hwe/NXV+CNKWrY6ZDuPH8+n81faaYvFAIjMM2cTIX/@nongnu.org
X-Gm-Message-State: AOJu0YzIKfsqMIqM2DHKcsY1FlnETxRtpaKP7zWlvEor9dFP1la1TX0i
 GP1nK9T8a5AwoZRLLlmJ1CT9VYrwI6bsYHTbl4lA+S/CoM6iDBzeBhQs1asjnKQ=
X-Gm-Gg: ASbGnctTKzbJMQUMF/9NRxb+hYXFqR0fdGrW7DscLGMqzbh5jW2xsaAkmpSYgfikH2P
 yhTMnCvnzNrdRDgedz5irdHdxNYkmc4wdZCJ8OYSe3vU9JV9Ay6HQN2h/QwNSzxSh9rDpT2ws6n
 6xRSv1BtfWDLstUNXv4wrsgjmw2i6WR0LPXjY0dT76B4BDYtJr6pb4AOVEIzP5mdPF07CgwAJ3F
 R4XWkJmuK408KbsP7qkOY2Lg6/wGWJvdh+W7prGkWvbnfqaB6Zm3f4TFXSCx9n1APxWBp4t
X-Google-Smtp-Source: AGHT+IHbxPNuB0u9Mb8wNyTTy6gr+gavotIabm+vBsXFJrJflZluYV0SlhFFCuob32sRgGvuw9ZLQQ==
X-Received: by 2002:a05:600c:524b:b0:434:a350:207c with SMTP id
 5b1f17b1804b1-436553ecb7cmr27021175e9.23.1734543786550; 
 Wed, 18 Dec 2024 09:43:06 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4471bsm26557165e9.44.2024.12.18.09.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 09:43:05 -0800 (PST)
Message-ID: <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
Date: Wed, 18 Dec 2024 18:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216114841.1025070-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16/12/24 12:48, Ani Sinha wrote:
> VM firmware update is a mechanism where the virtual machines can use their
> preferred and trusted firmware image in their execution environment without
> having to depend on a untrusted party to provide the firmware bundle. This is
> particularly useful for confidential virtual machines that are deployed in the
> cloud where the tenant and the cloud provider are two different entities. In
> this scenario, virtual machines can bring their own trusted firmware image
> bundled as a part of their filesystem (using UKIs for example[1]) and then use
> this hypervisor interface to update to their trusted firmware image. This also
> allows the guests to have a consistent measurements on the firmware image.
> 
> This change introduces basic support for the fw-cfg based hypervisor interface
> and the corresponding device. The change also includes the
> specification document for this interface. The interface is made generic
> enough so that guests are free to use their own ABI to pass required
> information between initial and trusted execution contexts (where they are
> running their own trusted firmware image) without the hypervisor getting
> involved in between. In subsequent patches, we will introduce other minimal
> changes on the hypervisor that are required to make the mechanism work.
> 
> [1] See systemd pull requests https://github.com/systemd/systemd/pull/35091
> and https://github.com/systemd/systemd/pull/35281 for some discussions on
> how we can bundle firmware image within an UKI.
> 
> CC: Alex Graf <graf@amazon.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   MAINTAINERS                  |   9 ++
>   docs/specs/index.rst         |   1 +
>   docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>   hw/misc/meson.build          |   2 +
>   hw/misc/vmfwupdate.c         | 157 +++++++++++++++++++++++++++++++++++
>   include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>   6 files changed, 381 insertions(+)
>   create mode 100644 docs/specs/vmfwupdate.rst
>   create mode 100644 hw/misc/vmfwupdate.c
>   create mode 100644 include/hw/misc/vmfwupdate.h


> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
> +{
> +    VMFwUpdateState *s = VMFWUPDATE(dev);
> +    FWCfgState *fw_cfg = fw_cfg_find();
> +
> +    /* multiple devices are not supported */
> +    if (!vmfwupdate_find()) {
> +        error_setg(errp, "at most one %s device is permitted",
> +                   TYPE_VMFWUPDATE);
> +        return;
> +    }
> +
> +    /* fw_cfg with DMA support is necessary to support this device */
> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
> +        error_setg(errp, "%s device requires fw_cfg",
> +                   TYPE_VMFWUPDATE);
> +        return;
> +    }
> +
> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
> +
> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
> +                             NULL, NULL, s,
> +                             &s->opaque_blobs,
> +                             sizeof(s->opaque_blobs),
> +                             false);
> +
> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
> +                             NULL, fw_blob_write, s,
> +                             &s->fw_blob,
> +                             sizeof(s->fw_blob),
> +                             false);
> +
> +    /*
> +     * Add global capability fw_cfg file. This will be used by the guest to
> +     * check capability of the hypervisor.
> +     */
> +    s->capability = cpu_to_le16(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_EDKROM);
> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
> +                    &s->capability, sizeof(s->capability));
> +
> +    s->plat_bios_size = get_max_fw_size(); /* for non-pc, this is 0 */
> +    /* size of bios region for the platform - read only by the guest */
> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
> +    /*
> +     * add fw cfg control file to disable the hypervisor interface.
> +     */
> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
> +                             NULL, NULL, s,
> +                             &s->disable,
> +                             sizeof(s->disable),
> +                             false);
> +    /*
> +     * This device requires to register a global reset because it is
> +     * not plugged to a bus (which, as its QOM parent, would reset it).
> +     */
> +    qemu_register_reset(fw_update_reset, dev);

Shouldn't we use qemu_register_resettable() instead?

> +}
> +
> +static Property vmfwupdate_properties[] = {
> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    /* we are not interested in migration - so no need to populate dc->vmsd */
> +    dc->desc = "VM firmware blob update device";
> +    dc->realize = vmfwupdate_realize;
> +    dc->hotpluggable = false;
> +    device_class_set_props(dc, vmfwupdate_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo vmfwupdate_device_info = {
> +    .name          = TYPE_VMFWUPDATE,
> +    .parent        = TYPE_DEVICE,

What is the qdev API used here? Why not use a plain object?

> +    .instance_size = sizeof(VMFwUpdateState),
> +    .class_init    = vmfwupdate_device_class_init,
> +};

