Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A2ECAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 11:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyU65-00015c-Mx; Tue, 16 Sep 2025 07:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyU63-00015B-67
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:43:43 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyU5w-0003Tw-Rb
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:43:42 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d71bcab69so36335147b3.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758023013; x=1758627813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R2GJcsijddl+DQmsjULjtQKML3IigbwEY0yVqdqSnwM=;
 b=w/uKyN84EZglJ9PjvVxcpQxsjKciNyx/HZXTiKrkusXrmVxbJJV/jb7PRSKsZyEicJ
 o0y7eDICfJ9VuA2UtBwLa0eVOPaGNmT3mt4wdFOr2JKdGpoJxUmouUptVg/6sU39L4W2
 MbSIBoK1aM40+5u8cBf2/lwpSa0MyiF0j4q19QNLqroX8HXM/8Q0Dj1TB/dOjhT2wSt1
 TNNCV2VRAtPfvnGOz9/IUkNyGPrFrMVWVVIyiP3M5JeSEN9eomBSFn2oQ1gxD7ACbpI3
 /8hbde8qSlBB3M4Jyh3lyfeYNS/ED/ShUVL4u4jJnBEYOwWcsvDUHeoT8guopOsQXKY4
 MeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758023013; x=1758627813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2GJcsijddl+DQmsjULjtQKML3IigbwEY0yVqdqSnwM=;
 b=f2smyRQ6+WurCN5bwzQSwTSyPrNPgAorkv5lzHR41wAWF10SI0Ex7cNBmX3vuWF4tD
 s3LGL+lSU0bZFVQJ32OCr5EJhBjg3/oO6qmtGHfX19DbiAfegAWrB5KQWBSRuRxg5pZZ
 5W2PBe0rreadd4/K31mVmANw1HYomsQ31x1l4DtHdFHgidhrxQ/TzYrfic05oiR2toFg
 PkOmx/IVVxRXAGfPVzQAAZb/kzlrWi659HYMz8yP+gcfyf5ugdO7r9jtwXfeH/bx+wvV
 KnKnYYADltrLZzTRQv4++ylRhkhzoLT5dNCKFpGGBhON80ewr3vbrWU5AuNmMejNdRss
 XMuQ==
X-Gm-Message-State: AOJu0Yz1FFxkod0rRB+/Q8z0tv9S1P1ZX75fIcg1EWWa2L5JVyWlkNt0
 QYjUc/HFo1isVLfKiW/GR36OpXCUKIDZf0Or/wpxhcrDdyYQ8niXaHngxo2fhPEEZ7SaPJcxjWz
 wwQt8nWbFJAnS4JHlyl+cPQuSQqAe5AMqrBifakRItw==
X-Gm-Gg: ASbGnct1bSedT8SHLKFC62HmXbv/K8QuWq1GSgmSGkIAmeFDvIWZmatiwWVlpXjbMfr
 GVwPdHGtHwqmFdvSuiNNGFC7UdBlePkxWYSBwDlF5Ru8+yY59jf3T5CUKFKECVMRr5fzyq+cXJy
 Yyncc8lQeo+n4r0fchZV3Alu+1XyJMqSSUhM1R1X5MyPoRZDSwXPJdwjvDP0kSrnUTKHXD2SvNp
 aIPUQ0l
X-Google-Smtp-Source: AGHT+IEQlCy0au6n8jixIpIrWA/oiMrQZSlD2zsttYyQwWYCnBbj4d923+AvCxhKRKR4ubu/Yso2i5PedB4onU1lW6A=
X-Received: by 2002:a05:690c:a012:b0:730:c83b:e9f2 with SMTP id
 00721157ae682-730c83c14b2mr117859247b3.37.1758023013174; Tue, 16 Sep 2025
 04:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-21-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-21-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 12:43:21 +0100
X-Gm-Features: Ac12FXx9XadVkXfh56DOz_qdBwpDZ-EOHCcGJXsWKrZwlOYAmecKbo3OMlJbzyc
Message-ID: <CAFEAcA8Amg8KDX0QYKqe7RtHPMC+GFD6N+c5z4S-ts_V11_RCA@mail.gmail.com>
Subject: Re: [PULL 20/24] hw/uefi-vars-sysbus: add x64 variant
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 4 Mar 2025 at 12:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The x86 variant of the device is mapped on the fixed address 0xfef10000
> and uses etc/hardware-info instead of FDT to pass the mapping location
> to the edk2 firmware.  The latter allows to move the device to a
> different location should that turn out to be necessary in the future.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20250225163031.1409078-21-kraxel@redhat.com>

Hi; apologies for this very late comment, but I just
noticed this reading through the code:

> +static void uefi_vars_x64_realize(DeviceState *dev, Error **errp)
> +{
> +    HARDWARE_INFO_SIMPLE_DEVICE hwinfo = {
> +        .mmio_address = cpu_to_le64(0xfef10000),
> +    };
> +    SysBusDevice *sysbus = SYS_BUS_DEVICE(dev);
> +
> +    uefi_vars_sysbus_realize(dev, errp);
> +
> +    hardware_info_register(HardwareInfoQemuUefiVars,
> +                           &hwinfo, sizeof(hwinfo));
> +    sysbus_mmio_map(sysbus, 0, hwinfo.mmio_address);
> +}

Device realize methods should generally not map things into
the system address space. Can we refactor this so
that the board/SoC/whatever devices that create the
device do the mapping ?

thanks
-- PMM

