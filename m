Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88852C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxLtA-0002nY-UV; Fri, 21 Aug 2026 05:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxLt5-0002bp-9d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:50:12 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxLt3-000269-No
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:50:11 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66c67a73eb7so3037096d50.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787305808; cv=none;
 d=google.com; s=arc-20260327;
 b=fTcXx1zCG718xSSY6SRd3lMyOFkZx9eC+NbszQjDTc1qRlHgm/u7TNa4DuWMqPZHlG
 qpNC8iyjhTdFz6Xu2W7i9R06DShmUnMFPHSI2ktRSKUCAYjlhWfIw2/zYr3LPMW7b4gc
 HCPDC/az2yKHps3Z28Xmn4ODufCFCmOmtz68b+1jHrCiqKgeQXbY2vUjrkTAVBUjNo9R
 YWefpVfcegjeAOvFzxHFm5lZuF83EU+HIpatCIxlqvDrLl6XQwZklAxJXSKdcY1Gk8Bj
 WHPPVW3/pgF+KvJbh+stgxWVTj9r/S4W9eyLaI6APZH4TKOK002fPQAoPX8c+oB79r5w
 b6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zOIr6OQWT1TpVNleRhPlZA3/CrMUb/jLsV1bzQTDp0Y=;
 fh=7cECbk+eeZZWmhF/2Eu0ejsHx/xDt2cWDXsIVgiivgQ=;
 b=lpL/sPuaK+9OSJl51ieXot75zeaMvup+NbcHBLc9kW70G29SzkqCN4jHyGtAopY1zU
 pBxAb3oN28Xi1gJnXaCFhn00EPV8+NrxBgCV4OgmHLZJcqKZoR1A3myHhwGM0IPtqB5a
 PZjYzVzzTff+RFvyyyrXlKL+b1f3OKL5E7ZVcyd0li6iwXHd/WITExvIemDX1J8/8uRv
 Cx/HUI83aiM7R6zSUYb3Kb/O09bquz5+L0aBXZKUkA2acZpJ7elGsQWEGfAwCddUucHa
 cJrpAwDLqY6ivPTFTLaHTrHBj1TfrQDNPZjUwtWgTZBq6gEaX52Tb0ESP50opeA748qD
 SMEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787305808; x=1787910608; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zOIr6OQWT1TpVNleRhPlZA3/CrMUb/jLsV1bzQTDp0Y=;
 b=JB5ayxGWWMkFcuLMtYk6rJ2qXIj0JYJM+lxrpD3no/kxiZ1l3phXizlnmm6Ut90Xbe
 xhT+7zp1ZzRUE5b9LH6Xs+gxreNBqeONzJOA8qR1vzds3Ow8RIr6tgbndeYYXsfgiZ5X
 FTg0LFys0Bzy06broqdSeTdXgnEqZZpRmZvwdsjc2nFMMhB29MameA5BzGEgfxUHVBiN
 lMAkRGNIJMzg1cqYumlXsMx+o9yW56ugwb6L58RjSVafmJJ8FbThXYEjxtTPKseXrItX
 wEPWS8cgS6NZ9mG725Z668bTBq3oEqoqLfWt3wd2PBrCS/bGDT4CFpqxf0cgOO4orgpA
 nwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787305808; x=1787910608;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zOIr6OQWT1TpVNleRhPlZA3/CrMUb/jLsV1bzQTDp0Y=;
 b=p4vw2TrJEO/onK8oIQ1wVT9pAJ1pZF5Zo02C5TJJBaFrsDqD4cMGc0JoaqjRvFhAqG
 AfphNTk2pC8Be2x0KXGHxQijpyWCWVtc1W8WjjXG+j1e8bozaGMPDFAmghupjYEcMQLZ
 RONRzGivOEc7YhhNekhqWlvKuKE7bnkbofKvU5k4G6WyjFhhXmy10MaD3XprlVKD8PzW
 vS9rfXe3gfiIHu4nVyGKqoGXAbpvVAb5EvVH89ngPQ2Mmlz1psHF3VP5Fpu7B747okrH
 94EZdgobnccqKILCDH9b/JrjwypZ28/CZ+FS+kNxFf7r+pR3UMF7oygpjo92286W+iil
 0kNw==
X-Gm-Message-State: AFuF++lCxla6Edlgb64kAWfi7U9otyUj+VvkNEowr5Yv7iiPYxCBxf9B
 ILlm65wgiBaWp5ICPZT/gfD9tlxpo2ZYcWipx7aCWUEmlv1I/sIV3+STku/gRv59HF0EjMAKelU
 GdrDdKDElyNa6kE6vQbWt0qopiHCjuTYLXLROwRzksA==
X-Gm-Gg: AR+sD13KygK22KLCeWuwC4hDmBewn8d79GgidLJawk8n0l5MZS7EylgnXyXrj/Wml7X
 4eiqmrqXs4lBldaE5LgeXJj98sHzIClgMc7Qmkw7i5vZu/HM49C/SCOCnxyjOyCfXgOe07A2xBP
 8xZXJLqW+Wu1vXiFxAqcV78MDDzjpzWkveAOFgdT304hPdiR2XgDhKVlbQVco776yV8GcNFgTGt
 jm8i1p5PWyrCxssrqMERKvY/FJHiTRKcWvZDyKZiJeFfy4lSots3YAf96ilcR8+VpHik63dvBs+
 EBtBCNQKwzk/kw6shE9p17Y8JPdFv8K4Od923qQrBGDyFL+RLb3WB3HBIHatY1BRgU8ShObb+lQ
 L8MHoaSUf9tCwjpAEbWjxnuWc+eZT
X-Received: by 2002:a05:690e:134a:b0:66a:d7e5:fcf8 with SMTP id
 956f58d0204a3-66cd645108bmr4542127d50.0.1787305808578; Fri, 21 Aug 2026
 02:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260816131300.51799-1-bin.meng@processmission.com>
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 10:49:57 +0100
X-Gm-Features: AcwNN1VYDanTeIxlRvHym8KqE6usBIglnb9GQbgy3cA7GKb4c2JeCNuNJ_-NdXE
Message-ID: <CAFEAcA9c0r_Am_14jD0TkMjmfy6Hn7H1xc1zO7bY8DDiC2n6XA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] hw/arm: Store the ARM boot info in the machine
 state
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Sun, 16 Aug 2026 at 14:15, Bin Meng <bin.meng@processmission.com> wrote:
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
>
> Changes in v2:
>
> Addressed 2 review comments from Peter:
>
> - All assignments now use individual field writes (e.g.:
>   bpms->bootinfo.loader_start = ...). This applies to: collie, cubieboard,
>   exynos4, imx8mm-evk, integratorcp, kzm, mcimx7d-sabre, musicpal, npcm7xx,
>   npcm8xx, omap_sx1, realview, sabrelite
> - The following boards that previously used DEFINE_MACHINE_ARM/AARCH64 now
>   use the macro DEFINE_MACHINE_EXTENDED() instead: bananapi_m2u,
>   cubieboard, imx8mm-evk, integratorcp, mcimx7d-sabre, musicpal,
>   orangepi-pc
>



Applied to target-arm.next, thanks.

-- PMM

