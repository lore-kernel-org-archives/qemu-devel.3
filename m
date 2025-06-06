Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B996C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZph-0005gU-Qk; Fri, 06 Jun 2025 12:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNZpg-0005fy-AZ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:22:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNZpa-0008GO-Ft
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:22:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74800b81f1bso1908093b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749226929; x=1749831729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7SYTdlE/fJXOVY6ynl4ET3geGWrAb8cvhJwwq/SC4jQ=;
 b=zCr1n4S/24HOLqCh+n7zfY3do2elwaWDvjZf0LOINn36Mq71w4goNolt25gcjsXSo5
 tL9B2dG9zPxyHVL6Tmx3By5vwIgjkNs+zo2ld8JTIskkyW/cy+O67O632781qCE+kwII
 1K6W5Pimmky5BjQ3u+Fd3Inrdy8Tj8Xdq2my3YX+TeY5n/ZI8WGBMA5v9P088zUGRnrp
 H3qTQzZScuncXOmp35ERUdS0A+dGnVVl+7ckfAW2P0uwRukSuDGRK/sZFP4h8y20oEUQ
 ZAOXx7imHfwtKBeqQZumuw8BsSYiEjK1e7x+Gz4hSnpV5qaZwjJdOnXkvXuzy5bqE5RR
 jpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749226929; x=1749831729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7SYTdlE/fJXOVY6ynl4ET3geGWrAb8cvhJwwq/SC4jQ=;
 b=tu5lHcSEAR9xuPyffQgVQzj1pjHhmWIa5HYMJt1BTfA48a34Hg6wJc4MvRvk25+fME
 u4Qc8KfTdI7AS8fWhjwp3GCMcxwxH02ypInQXERYFPleT5QgTRSCtcGEZyEddbt+Iz6y
 YKKlnMraFySUNqsaCYXf/76TET7GBtkZU1uDou3MyMBkYME7ZJ8zO+F6h0EzLhxuQ1Yr
 UPOxQ0cBh+vppN+2rz0ffV4MU2sQntmewjZIz9S4QIUzmCGdyOLVjoVNjKr62hpQuB79
 Qxse2J5zwDph3ICgsbLiP1IMJdvvRrsaddwU9RKoR4GxCBDWMTYSI2p+v635HuIeGnCQ
 nOFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0PRFdBNFq495+99YXhsGKfPFQ29KH+APbLDgedof5BNUMBSuCvSOOPGYjL/aJWSxFRvKtKSN793/7@nongnu.org
X-Gm-Message-State: AOJu0YzHqtgSkU2B6ZJKapUO8idx96pehUE7mL3e7L3OyNEVur4uDuUQ
 7HRJBQTpW+9IDr9z/jtKgziLK1fL6FaRtO57tCGMUxAUWpnkpfL9XbcLPL8BrQOcMxo=
X-Gm-Gg: ASbGncuYbvdam3GrMSMorMJ8nS0ixO8/frfrpdmRz7ftG/rDYFyIYUdsS/m3DrHTXiZ
 i1ZcOG7LLn6lxI282fb/ekbQZnOCnIeN4/pNCQMgHhpjxeL+Q4fL23SwCLTCdtUQkGL3Kwyyj3E
 incKAbV1iuA55AZ2Lg5MWnlElgNVsU0LbqiWPMvU9naAxIm7x83FZTGIixQy/CHeS2dvQwfiZm3
 6BkX7rGVfEdME8FSSUqrEyTPMy4hF8+kG7KZ94J4+mDz/uunfPCrc/YwbRyTzzAO1l9ZDZ7v5m0
 37TtNhQzv38An49/Z6xWVlWjxWqYneo/jmGwwHJFqe3uJV25Ww6HnlpI72dhtW0F/VoaE4T5no0
 =
X-Google-Smtp-Source: AGHT+IGjNym0gikeObc/XVXl6dvxSz6Qhr+BYtz2Iz0Af39IPxWYrECHbX5B+0L0Mnvrx415OpDvsg==
X-Received: by 2002:a05:6a21:2d8f:b0:1f5:8dea:bb93 with SMTP id
 adf61e73a8af0-21ee24fd015mr5968341637.7.1749226928946; 
 Fri, 06 Jun 2025 09:22:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af7a90dsm1504256b3a.57.2025.06.06.09.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 09:22:08 -0700 (PDT)
Message-ID: <ae7090c3-37e4-4f10-8267-d7106aa5e259@linaro.org>
Date: Fri, 6 Jun 2025 09:22:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
 <9b083ae2-3afb-43f4-8929-fc693b581a0d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9b083ae2-3afb-43f4-8929-fc693b581a0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/6/25 2:04 AM, Philippe Mathieu-Daudé wrote:
> On 6/6/25 09:52, Daniel P. Berrangé wrote:
>> On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote:
>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>>
>>> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
>>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
>>> for ramfb, so they don't need to load the romfile.
>>>
>>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
>>> device, because the vfio display also use the ramfb_setup() to load
>>> the vgabios-ramfb.bin file.
>>>
>>> After have this property, the machine type can set the compatibility to
>>> not load the vgabios-ramfb.bin if the arch doesn't need it.
>>
>> Can you make this a series, with an additional patch that updates the
>> current in-dev machine types to use this new property, so we're clear
>> about the proposed usage.
>>
>>>
>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>> ---
>>>    hw/display/ramfb-standalone.c | 4 +++-
>>>    hw/display/ramfb-stubs.c      | 2 +-
>>>    hw/display/ramfb.c            | 6 ++++--
>>>    hw/vfio/display.c             | 4 ++--
>>>    hw/vfio/pci.c                 | 1 +
>>>    hw/vfio/pci.h                 | 1 +
>>>    include/hw/display/ramfb.h    | 2 +-
>>>    7 files changed, 13 insertions(+), 7 deletions(-)
> 
> 
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 7f1532fbed..4e4759c954 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>>    
>>>    static const Property vfio_pci_dev_nohotplug_properties[] = {
>>>        DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>>> +    DEFINE_PROP_BOOL("use_legacy_x86_rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>>>        DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>>                                ON_OFF_AUTO_AUTO),
>>>    };
> 
> Alternatively with target-info API:
> 
> -- >8 --
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 8c0f907673d..689f10625f8 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -12,6 +12,7 @@
>     */
> 
>    #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>    #include "qapi/error.h"
>    #include "hw/loader.h"
>    #include "hw/display/ramfb.h"
> @@ -147,7 +148,15 @@ RAMFBState *ramfb_setup(Error **errp)
> 
>        s = g_new0(RAMFBState, 1);
> 
> -    rom_add_vga("vgabios-ramfb.bin");
> +    switch (target_system_arch()) {
> +    case SYS_EMU_TARGET_I386:
> +    case SYS_EMU_TARGET_X86_64:
> +        rom_add_vga("vgabios-ramfb.bin");
> +        break;
> +    default:
> +        break;
> +    }
> +
>        fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                                 NULL, ramfb_fw_cfg_write, s,
>                                 &s->cfg, sizeof(s->cfg), false);
> ---
> 
> Recent work event introduces target_base_FOO() so that'd be:
> 
> -- >8 --
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 8c0f907673d..2aa3b309010 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -12,6 +12,7 @@
>     */
> 
>    #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>    #include "qapi/error.h"
>    #include "hw/loader.h"
>    #include "hw/display/ramfb.h"
> @@ -147,7 +148,10 @@ RAMFBState *ramfb_setup(Error **errp)
> 
>        s = g_new0(RAMFBState, 1);
> 
> -    rom_add_vga("vgabios-ramfb.bin");
> +    if (target_base_x86()) {
> +        rom_add_vga("vgabios-ramfb.bin");
> +    }
> +
>        fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                                 NULL, ramfb_fw_cfg_write, s,
>                                 &s->cfg, sizeof(s->cfg), false);
> ---
> 
> Unfortunately I had to focus on more urgent stuff so this isn't
> merged yet (besides I hurt a finger yesterday and am now typing
> slower). I hope I'd be able to respin that next week.

In case it's too much effort to respin all the series in a close future, 
maybe it could be a good idea to just send target_system_arch(), so that 
people can start using it.
 From there, people can add target_base_FOO() easily on a as needed 
basis, without any hard conflict issue.

Thanks,
Pierrick

