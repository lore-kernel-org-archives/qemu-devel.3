Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82E7C5CFDB
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFxk-0002XS-Qf; Sat, 15 Aug 2026 11:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFxj-0002Wj-EY
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 11:06:19 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFxh-000373-Ro
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 11:06:19 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-836c8bdac50so27799387b3.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 08:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786806376; cv=none;
 d=google.com; s=arc-20260327;
 b=eng7kl/tD4E5fSE/e9ml2KHAWhWvsMQnjXmaZ1LNTKuEqlKbXquQ27aAP51nLZZbdA
 3FxYSn+H0dCYOogymtOW/d+Q3gDMNBYBUhKPGhLPvZzA71dNcTuRu8hIw52m5DFLIacH
 OU70XjTSmsLMO0o855Vyk1bb0n4F9DJiXTZqZJsKA68RuQY4Nt8ZPTiIESarEOhpcNsA
 9oHBVOrIB8iXD+qXXNIX+GQERWOdCe35g84s5WDw/fOdrRfiBHV9fvRA0Xd9G036X2Fv
 LEioJSc8SPB7iwlOB0XwjovSS8YIF/MKmg1uQe8BFiFQBBwl29FLz4rcrnftt0J/vjed
 y82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=br73CETfcW8D96ViD7v/9LzJ7uXqDbxvWBVvAVgEVKU=;
 fh=7cECbk+eeZZWmhF/2Eu0ejsHx/xDt2cWDXsIVgiivgQ=;
 b=aIbO5007tVltjb0gwZTyL4qSWQ36vecuGiRQXD+GhBFZdpiB9FwMKWIZ7r7Cg+BPCV
 VA0venXEaR7yoAxI3QVsrjGlU+pawjP5yNJW86G9YOatvZBhr2BlK6+KcTqwBfXiHNFM
 doC810OeA2DZmBEtWUr76nLs3l0PVE4f+JB6pxpcO538fUtCOVBeS8s2foZHwcNDP0Ds
 EyyyiaAMEsAVIidVVCSMCrrmOBQe54yO5Ji5iGb7imP0+yxpcNo68xxGSwY3ZEaQ1pz/
 Y3tbbm3AI+I73IKpeqV0eUDAUeT/QG0ASM2N24IgLH/9k7KB7tQPXUFoBlaTSeYt46AW
 AEKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786806376; x=1787411176; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=br73CETfcW8D96ViD7v/9LzJ7uXqDbxvWBVvAVgEVKU=;
 b=RDj4if5x5L7ZGBlA381AArPMakxvZdpyVbTvpkwS+hnviRRicmi9WBoVWHmiPBhdI8
 LqpErxJ2FipiDNHpOmcex5cWqyxVfjF5ipukyVTZExHoCw5/HNiPA/yySBO3nqkh7PlY
 3CJ2r0MmrlFALpNgs78Tgb3t/mm2NaFF6UyHrWS2E2a7lZiOudk3Tu8makPQR5LJJE2j
 +SpeIul4xEV2M3JelqG8G09zzHAT0PF7PImP+G/3OdzqkiNm9OfaeN13pr0Ahb/dqiEv
 EXpyqS0onO6eW0nWslmicQigmIO5JOIhlgwzPg7NhQMIUg935pfOv+SHnDzfScJiPIAS
 Q4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786806376; x=1787411176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=br73CETfcW8D96ViD7v/9LzJ7uXqDbxvWBVvAVgEVKU=;
 b=QpzB74E+GOcBVLwvaYAeYnBmLwT/wh5kYsuMRfyp848cTkcu+xoR5q23wh8XU5ecFW
 0lE4jbGa/Ny6V+dnyC9oI8zvVFi/OlIC05DRmwQFddAceQ5WrVz83ZdXvaTH/+aHTn8u
 I1ZNOVqiLyB1feZhlOL1V1Z/N9XzBI9PSI9SzfglvjMkaXjSrMlhpeop1T4keZomQffg
 +oWCZ6FOyaQwCwZ8Ufi71lXAyv58nsbHdE1CuMxDsjFq17z2KDWWPEI7+Qh+A059WMOS
 9dv6F8cj7+Viwql3DuVfKwPkvph2KxXUxjcrv3R9q7zP9KsLe6e3i5e0HAm2wdkPBVgk
 8c6w==
X-Gm-Message-State: AOJu0Yys8salWre6Zzzpc1/lv16LmFTsNgiZwHLzaLVKqC7SYG53qoG5
 SShRu1SIGkeWM5C734/XtvwNE957QixyI1zJnYTcCW39edg5qRz+8e7uRBExXGbxQX4wtWRLBbs
 SR0yFtzCrRt55xVhoETqnYU2ap3jGuj2+P0TsXhlaXg==
X-Gm-Gg: AR+sD12YGuui/hVqUR2pTiGiX3WHHKTP+g1wvnRb1L6Ff10A4mR3FBA+o88WSjBP2wz
 Cgk3Us5VRbQSEXworpvK4BCTZcVElmxE+CmQWzSNRVwxnPTO3VvjodzwHG924QDRJayz39n1O/P
 wm+qgxwA0nclvKDxsLk19brp9MMsf6ewsNqNlb6/dT7zr7UOq26T/plQeYA3pe88PfQ9VeHNu8B
 4fpzssQe9QuGRinsVA09uidWcxX04wpjx6SCS1m0R8n9mQbxJwdSpQjeEtaOskJO4uJX0hpBe2Y
 Eevimc4ojlmpKeutuV3r+qfVa/L10kr67Q9eph5wjsze336ALxupy4WBL6h7IRr3/GoVf+/oJGX
 lO54FLR38SEzCM8Ep3nkZY2xiobMo
X-Received: by 2002:a05:690c:4a02:b0:81d:6af3:b9b5 with SMTP id
 00721157ae682-8370dfb3b07mr57271187b3.9.1786806376065; Sat, 15 Aug 2026
 08:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260813154918.996812-1-bin.meng@processmission.com>
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Aug 2026 16:06:04 +0100
X-Gm-Features: AUfX_mw18sUHajhEpEjidhR_31brmxtbzYwwt4TZkZYTQh2Sj4or5Gv8FxFH4DA
Message-ID: <CAFEAcA8R5N=+wHpgOHu20FQg1W+cJVcZfBgFhTi2c9phHmXSAA@mail.gmail.com>
Subject: Re: [PATCH 00/20] hw/arm: Store the ARM boot info in the machine state
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Hao Wu <wuhaotsh@google.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Troy Lee <leetroy@gmail.com>, 
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 13 Aug 2026 at 16:49, Bin Meng <bin.meng@processmission.com> wrote:
>
>
> Most ARM board files declare their struct arm_boot_info as a static
> object at file scope (or, occasionally, as a function-local static
> inside the machine init function). arm_load_kernel() stashes a pointer
> to that struct in every CPU and dereferences it from do_cpu_reset() on
> each reset, so the boot info conceptually belongs to the machine for the
> lifetime of the VM, not to a static object whose ownership is left
> implicit.
>
> This is a longstanding leftover pattern: modern machines such as virt,
> raspi and xlnx-zcu102 already keep the boot info in their MachineState
> subclass. This series converts the remaining machines that still use
> a static object, moving the struct into their machine state so that its
> lifetime and ownership match how arm_load_kernel() actually uses it.

Yes, I think mostly we have this leftover because converting
machines which don't yet have a state struct to have one seemed
a bit tedious. But it'll be useful to have them for other
cleanup reasons in future I suspect; I like the cleanup.

Rather than commenting on a lot of individual patches, I'll just
list a couple of niggles here:

(1) Can we be consistent about whether we set fields individually,
like this in patch 2:

+    bpms->bootinfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
+    bpms->bootinfo.ram_size = machine->ram_size;
+    bpms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;

or via a struct initializer, like this in patch 3:

+    cms->bootinfo = (struct arm_boot_info) {
+        .loader_start = SA_SDCS0,
+        .ram_size = RAM_SIZE,
+        .board_id = 0x208,
+    };

I don't particularly care which you pick, I'd just like to avoid
the needless variation.

(2) Could we use DEFINE_MACHINE_EXTENDED() rather than writing
out all the QOM boilerplate by hand, for the boards which previously
used DEFINE_MACHINE_ARM? (No need to convert to macros if we were
already using hand-written boilerplate, like omap_sx1.c.)

thanks
-- PMM

