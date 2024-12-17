Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5ABE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 10:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNV19-0001gd-OO; Tue, 17 Dec 2024 05:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNV18-0001gH-Ow
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:41:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNV16-0008VX-Iy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:41:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso31774785e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 02:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734432085; x=1735036885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xUd8cWXS6KVZA9NKThZTIXyrutZP/erTS518/GcehIo=;
 b=tlLD4SpZbxje2D0ig4D6JjFxvk7qpRr2PDiUm7to6LD7P8ySwMRMvsqwpqQ991sdg+
 mgrnQ9HX1vSUJyUGZwt9C3IGDZCHl6lReFtl5hj7Bhg0zNr2SQgparw6FvzS1ZrkhbF8
 cktoTFU3IKRKO8I4IXuePpf50CHE/PrWupW+Viy/IE+Q7yhnf/7rl03DavZrcEmTv7Jx
 DpwJQo9GxE26eHQpDCPIWA0y+tcCW/u9zCxbXBC6/eQNjijpywi/cFQj5WlFZuqu/zu7
 CcQF09fxnRhyddzCwRqvAvcOlI2nqC2Npim2S7wGYReIpE9l2hWNdmvdAhUqZ3jqDPEg
 ztKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734432085; x=1735036885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUd8cWXS6KVZA9NKThZTIXyrutZP/erTS518/GcehIo=;
 b=Vv95CE9JY91v2qQblA5oE21yQ88/w2Fi0fSz7fCAEhIWYIjD1nfi51Pi3iNeejyvtb
 Dy8WhFRsVPg6N+qWqUSjiAh91YbW7oTNrJBl0n2Dxi/IxmYR2jieelsP39ba88GJUUk3
 JO+hcNvL8a+8qICm/vKN6QOLBT1lQebdBFUTjtMAW9u6F6h2UkLSivIUpl/Zpln8xhaG
 i1Zgpa5zd6Q5Il527a0CzVH8RdnWAUFb5TOIyOjkqXNnrhHpTMcShYacznixsmY+QJ3y
 BVz3L07SK44rMAZRIi0BlFqB/luctGhu13p9CpnyJTnUDA3dvU5dOJPWapeG4Dsi/Vsz
 2Tjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAkpUfMj2Y+5KAiKji3h8BxXZkI0oTqMk34aDk/dWw9scoquLFtYosMY6JwxYVRN3KivTLH/NVjgcf@nongnu.org
X-Gm-Message-State: AOJu0YwVV9BT38oiMxzrAJ7qHpmbdAl2qPZolWmTR5p9P1KJIHGJ1POL
 57T3qSbdUHXhgWLR8/b/Gc26mHueGYcvBxb6C4ZEbjRdgnrHb9d06cd7lWQSWto=
X-Gm-Gg: ASbGncvtkOZ0sdLEUmBzVXetM3FA2rXerohy3RQPSp1VgSjUUbvkvXKH5tM+syVxDPV
 ZkRj67EtXc9qSJdpjR9aSCay5h98EAJmQ12YYBEIqrkFSoPioUYwdFmKB1d3GvbJOI5LQ4kmYw0
 LmrT23YfAhlr8SzFVBN7nw1Tske7b7W71kvJeUw9jAWQ3mOnbMGr6ItmA4wf1FMPP2b50AcUcas
 F1NumQCoLz0XS1yfeKXvT3MMI+R5OphWPtI4RqNllB1OzyLt37QBBN88XwjUFk7l301np4j
X-Google-Smtp-Source: AGHT+IHrsDCo0q3Hr2JcZOYsEY5sLhbpvl0yzth1MuBCizljxYCJNiZHqyaEjHpcO1co7OjZR6Rszg==
X-Received: by 2002:a05:600c:3b22:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-4364814eefdmr21147035e9.4.1734432084887; 
 Tue, 17 Dec 2024 02:41:24 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c462sm169009075e9.14.2024.12.17.02.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 02:41:22 -0800 (PST)
Message-ID: <0d6d208a-00ee-47c9-8d47-bb5758133ecb@linaro.org>
Date: Tue, 17 Dec 2024 11:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <26c97140-6ec5-49f5-b0d4-d4f7f82a12f0@linaro.org>
 <E18F7A48-BA4D-46B3-BD73-38322BF33CEC@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <E18F7A48-BA4D-46B3-BD73-38322BF33CEC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/12/24 11:06, Ani Sinha wrote:
> 
> 
>> On 16 Dec 2024, at 8:35 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Ani,
>>
>> On 16/12/24 12:48, Ani Sinha wrote:
>>> VM firmware update is a mechanism where the virtual machines can use their
>>> preferred and trusted firmware image in their execution environment without
>>> having to depend on a untrusted party to provide the firmware bundle. This is
>>> particularly useful for confidential virtual machines that are deployed in the
>>> cloud where the tenant and the cloud provider are two different entities. In
>>> this scenario, virtual machines can bring their own trusted firmware image
>>> bundled as a part of their filesystem (using UKIs for example[1]) and then use
>>> this hypervisor interface to update to their trusted firmware image. This also
>>> allows the guests to have a consistent measurements on the firmware image.
>>> This change introduces basic support for the fw-cfg based hypervisor interface
>>> and the corresponding device. The change also includes the
>>> specification document for this interface. The interface is made generic
>>> enough so that guests are free to use their own ABI to pass required
>>> information between initial and trusted execution contexts (where they are
>>> running their own trusted firmware image) without the hypervisor getting
>>> involved in between. In subsequent patches, we will introduce other minimal
>>> changes on the hypervisor that are required to make the mechanism work.
>>> [1] See systemd pull requests https://github.com/systemd/systemd/pull/35091
>>> and https://github.com/systemd/systemd/pull/35281 for some discussions on
>>> how we can bundle firmware image within an UKI.
>>> CC: Alex Graf <graf@amazon.com>
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> CC: Gerd Hoffman <kraxel@redhat.com>
>>> CC: Igor Mammedov <imammedo@redhat.com>
>>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>   MAINTAINERS                  |   9 ++
>>>   docs/specs/index.rst         |   1 +
>>>   docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>>>   hw/misc/meson.build          |   2 +
>>>   hw/misc/vmfwupdate.c         | 157 +++++++++++++++++++++++++++++++++++
>>>   include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>>>   6 files changed, 381 insertions(+)
>>>   create mode 100644 docs/specs/vmfwupdate.rst
>>>   create mode 100644 hw/misc/vmfwupdate.c
>>>   create mode 100644 include/hw/misc/vmfwupdate.h


>>> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    VMFwUpdateState *s = VMFWUPDATE(dev);
>>> +    FWCfgState *fw_cfg = fw_cfg_find();
>>> +
>>> +    /* multiple devices are not supported */
>>> +    if (!vmfwupdate_find()) {
>>> +        error_setg(errp, "at most one %s device is permitted",
>>> +                   TYPE_VMFWUPDATE);
>>> +        return;
>>> +    }
>>> +
>>> +    /* fw_cfg with DMA support is necessary to support this device */
>>> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
>>> +        error_setg(errp, "%s device requires fw_cfg",
>>> +                   TYPE_VMFWUPDATE);
>>> +        return;
>>> +    }
>>> +
>>> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
>>> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
>>> +
>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
>>> +                             NULL, NULL, s,
>>> +                             &s->opaque_blobs,
>>> +                             sizeof(s->opaque_blobs),
>>> +                             false);
>>> +
>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
>>> +                             NULL, fw_blob_write, s,
>>> +                             &s->fw_blob,
>>> +                             sizeof(s->fw_blob),
>>> +                             false);
>>> +
>>> +    /*
>>> +     * Add global capability fw_cfg file. This will be used by the guest to
>>> +     * check capability of the hypervisor.
>>> +     */
>>> +    s->capability = cpu_to_le16(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_EDKROM);
>>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
>>> +                    &s->capability, sizeof(s->capability));
>>> +
>>> +    s->plat_bios_size = get_max_fw_size(); /* for non-pc, this is 0 */
>>> +    /* size of bios region for the platform - read only by the guest */
>>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
>>> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
>>> +    /*
>>> +     * add fw cfg control file to disable the hypervisor interface.
>>> +     */
>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
>>> +                             NULL, NULL, s,
>>> +                             &s->disable,
>>> +                             sizeof(s->disable),
>>> +                             false);
>>> +    /*
>>> +     * This device requires to register a global reset because it is
>>> +     * not plugged to a bus (which, as its QOM parent, would reset it).
>>> +     */
>>> +    qemu_register_reset(fw_update_reset, dev);
>>> +}
>>> +
>>> +static Property vmfwupdate_properties[] = {
>>> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    /* we are not interested in migration - so no need to populate dc->vmsd */
>>> +    dc->desc = "VM firmware blob update device";
>>> +    dc->realize = vmfwupdate_realize;
>>> +    dc->hotpluggable = false;
>>> +    device_class_set_props(dc, vmfwupdate_properties);
>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>
>> How is this device instantiated?
> 
> Something like this:
> $ ./qemu-system-x86_64 -device vmfwupdate
> VNC server running on ::1:5900

But this device is not marked as allowed to be created on the
command line with:

     dc->user_creatable = true;

Am I missing something?

> 
> And we can maybe add a basic test for this scenario:
> 
> $ ./qemu-system-x86_64 -device vmfwupdate -device vmfwupdate
> qemu-system-x86_64: -device vmfwupdate: at most one vmfwupdate device is permitted
> 
> To exercise the fwcfg files, guest support is needed as I said above.


