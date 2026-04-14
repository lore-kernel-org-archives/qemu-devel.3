Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E5DF9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcOp-0006w9-GK; Tue, 14 Apr 2026 07:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcOn-0006vq-Uj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:57:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcOm-0002hW-7L
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:57:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so3386024f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776167862; x=1776772662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQKTuwmRxA+OIOiaFfMIP1eOIxafDejRlksno/Y/2T8=;
 b=EsCm7yygytuHNgrE/r+U+TM3FImE/DKFiK5Ghix3xih5lXHFVy5z3f9Fz13S4VhWrW
 ansnAIRvOFAxA6RCJAU2HuUo4pX77r7FU+HJ63wIvEPDKj7/GKZEkJVN5OUE51CTq9UC
 23rx/CZxw9zncl4G3wqM1C12Z7MTj7P1yOjPAymG4s6DJekM8aki1md5OkMQWrQCOX3v
 LDkMFHDf6w4ss5f6VPgiKgr2YKaOL4g8f31fspTx/TaBCVynixSf/ltVhrMs+u79Kux1
 Ra06ieQHmBv55vyt5LEfBZXW3AF2sMbXN7jvSIj7ioJBRyHYuRjefe/L0nc/Y4NUxXAA
 w4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776167862; x=1776772662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gQKTuwmRxA+OIOiaFfMIP1eOIxafDejRlksno/Y/2T8=;
 b=FRT7Gc8h/LEKtK1cloP96ODsbMBabW6Ycpnv6f2awDrTLnRG4YMJDyRoKsHY8RKhmS
 asbD4Z4mvDQEAZjqPHpOyD4bERflz+kxbNp2fJ34RP9XSBSV/CFFEzK82IgBCazm2JTw
 trge134IuP2mDqcFeigsa0wBG1inQU4q5NCrfXp/IJGcSEewVukJMDGvjKG5qKvx4/DU
 R3x+Cv+Brf70ulHEuHkiUBcD4cbDPk392EY059FDLU5slXij8ezv8ql+s2n5DeA5p+bm
 x1EZN56luD3kY6cqoxYj+foryxjbzRRYaLjnTJmhcdhNb5rGQyZDXK03EUCbLG8x6BBr
 MXPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yqJ3efcHLhvuMaaSX7tPPjLn+ZksjBvNJzAzHPRwZsMd7c4vjKQGKS2p4m15cUyPKVUOSzXkrSIA0@nongnu.org
X-Gm-Message-State: AOJu0Yy3C5yi6BjuPIEx9KlT+aZFcx1FTzfHc+ahcBWm9q8F6mFxfRCV
 AgpqiblmjeSxMy9mKfbJm56JgIQf8a5neyjYICicgMGIxTZa0rrMHcspbaXj3RHaIHs=
X-Gm-Gg: AeBDieu66M5wFKmZGC3RMkXU0eIPo3KR0VjF5Za2q6qQJtLfmQktWSgS13vjoqYvnnl
 n+tYmWC1JVXMO8KBBiErx3BHp90gqhanpHwJzJhHdbNLqP/zRtLCApc838JtTZIYb+zSo/6O7il
 Nk+Ru6ns3xK/xzTIAohWarQINOKaIPnv1PUiBkJ/IoOFIxn78Ms6gXRV8bykHeobuQbndmouGpV
 7X/Vv/l/HYoCSaIxiubA0wrmwc17iexGpoV7lgr/z0WE/0x7cF6wrIRQWmsoq5Ea878K4O0CFwt
 edeLmPfmK+3uM+lnQckZsdYF/80q3fcJcKRNLLsXER2Fbtd8gBr2UgvjiFJXkBgVWbaouz1fJBP
 /Ht7ynHkJkr6ieWXk4NggLRuaNiyASOHGlsvQMv7MnQlW8Dq/nATR79eSQ8nHQ0T3umurc59zr5
 Ij3K0jDWAblvd7jn+KJpN5FRaRBTP0rj3RN9TxOduAI+ahA5gUwP+6ajLhpDXXMNe8+Q==
X-Received: by 2002:a05:6000:144a:b0:43d:78ae:b78c with SMTP id
 ffacd0b85a97d-43d78aeb861mr11656070f8f.14.1776167862398; 
 Tue, 14 Apr 2026 04:57:42 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46713sm42148734f8f.21.2026.04.14.04.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 04:57:41 -0700 (PDT)
Message-ID: <b763b4bc-3ec8-4815-9beb-58ed4c745a1b@linaro.org>
Date: Tue, 14 Apr 2026 13:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 60/65] hw/arm/virt: Create and connect GICv5
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-61-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-61-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 12:16, Peter Maydell wrote:
> In this commit we create and connect up the GICv5.  We do not
> advertise it in the ACPI tables or DTB; that will be done in a
> following commit.
> 
> The user-facing gic-version property still only documents and permits
> in its setter function the existing set of possible values; we won't
> permit the user to select a GICv5 until all the code to handle it is
> in place.
> 
> Although we currently implement only the IRS, and only for EL1,
> we reserve space in the virt board's memory map now for all the
> register frames that the GICv5 may use. Each interrupt domain has:
>   * one IRS config register frame
>   * one ITS config register frame
>   * one ITS translate register frame
> and each of these frames is 64K in size and 64K aligned and must be
> at a unique address (that is, it is not permitted to have all the IRS
> config register frames at the same physical address in the different
> S/NS/etc physical address spaces).
> 
> The addresses and layout of these frames are entirely up to the
> implementation: software will be passed their addresses via firmware
> data structures (ACPI or DTB).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/arm/virt.c         | 101 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/arm/virt.h |  14 ++++++
>   2 files changed, 115 insertions(+)


> +static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    SysBusDevice *gicbusdev;
> +    const char *gictype = gicv5_class_name();
> +    QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
> +
> +    vms->gic = qdev_new(gictype);
> +    qdev_prop_set_uint32(vms->gic, "spi-range", NUM_IRQS);
> +
> +    object_property_set_link(OBJECT(vms->gic), "sysmem", OBJECT(mem),
> +                             &error_fatal);
> +
> +    for (int i = 0; i < ms->smp.cpus; i++) {
> +        qlist_append_link(cpulist, OBJECT(qemu_get_cpu(i)));

This is OK for the virt machine; real machines should care about
correct cluster topology.

> +        /*
> +         * GICv5 IAFFIDs must be system-wide unique across all GICs.
> +         * For virt we make them the same as the CPU index.
> +         */
> +        qlist_append_int(iaffidlist, i);
> +    }
> +    qdev_prop_set_array(vms->gic, "cpus", cpulist);
> +    qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);
> +
> +    gicbusdev = SYS_BUS_DEVICE(vms->gic);
> +    sysbus_realize_and_unref(gicbusdev, &error_fatal);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


