Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06483C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CzU-0003aT-Qp; Thu, 03 Sep 2026 15:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2CzT-0003ZK-3k
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:20:51 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2CzR-0000EO-E3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:20:50 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8565d77c277so3718707b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463248; cv=none;
 d=google.com; s=arc-20260327;
 b=SdmCQIHC6M+X9ResOPq1vG1jwmjKEFWvo+aEAHlcg0ryx4bICY9TeiSrOtQrvJ4vQY
 gGGIWtJUQwdq2dog6kxNgxpW7jU+VQ5TUPviVTcMAVn7667rFNd91d99rzdlnlV/hHSH
 X6wT702kd4wSybMfh7cYbzzLh4Ys+yciCBvbg+t/R3q/KSs14auX5G9hYsXigePcQGm4
 3q+VFlzOVVmta4efIDnqbzhSZRmdyQj/nh2zBaNK6udn0/3CJI2MNE7XjSZW6jevdY/8
 XRdOQfPRsbZ1LSIZEYuTwOtJL7dVrUL+62a0IjzlMvWaRulTEwD+w2XNgVaP829Lzmft
 Ut+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vd78+Wj9CMhYqHn83YR752ZGQCyXHd/seO2G8VpiUzM=;
 fh=8r54HVI+NKB1+sxmVNjrgLMOmbN5mcDUgARKHJo8oec=;
 b=Cct8QPK4JqnwXDRF+2bw55hHv+8qvLXhbDaMVl5K0Tvj4lSSugc8xmATt/a+Z2THrE
 Fx2/TbLsl/2SriUqJ+3IGQOs4escuEwqK9ZA2AxZ8mI/j/6MZsnttWsQtGCeDbcwBWGb
 dcdrMQErrV89da/ASsp8uRBsI/Ek+2taoctOpl3ztUh7/vIglRSD8Jyqcg1ulks8HqCe
 xPohusGj0fzpkU/PwpIhmIKlK6tRlAI9fvnAlr1k6dlpwuasdrz7pb0E1bbhsOZVZWPz
 yURxvCyfu1Urf9NkvOl+iBJaXmodProEilpd5c5UDb3kC3hh2M2kcqGohb834mZrrY6w
 7Nqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788463248; x=1789068048; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vd78+Wj9CMhYqHn83YR752ZGQCyXHd/seO2G8VpiUzM=;
 b=vE9Pi1FrMYHwxSyRdSDZGu5UfJMNb5YEkvj0dNhWdOEbUNaZf+yTS56KaqK3ZFCIGT
 yyiDUW/aHmTTjJTVsfUFiiQQ5IGpjtx1HYAUFma0jahh6MgSe2c/7w2nQf/Pl8lRQDik
 djulvzgKlozMz41jcRVbob7siEKH6g3s9m7h+FVgBdhDQRzbjgLZIBTkr5Fb0eO3PlaU
 utSNu7ysYp8qFDslCguPEUkGcVdcZPkg2B3lV737OvekFNUrHE5Ujx7MF0p7gg0bHabt
 kCws6zdkAVGMoIe0m9y5GJhJVmhlsJO/1ij7wdZ/xrV1p6t7w49AuXmziUuN2b9ZrTRX
 Juug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463248; x=1789068048;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vd78+Wj9CMhYqHn83YR752ZGQCyXHd/seO2G8VpiUzM=;
 b=fSMB8SKD/ZEEWmv2A/vyuJ2NLJ9nZ8D3vPm5iuJ1SvccoyttmzVKKegMkdmwLdlGHi
 fdOJD1K/OWEJjlLESRN0toP3HTGvnPPGG7iWjV8pEcC5LJJ1cYCLOL+xaPhpxq9HNP3Y
 jdKxBgUmZ68QpDRJyuAr3SMMJijGaV9Rmk5dsrjhtSgiIJMO9Q2BkGT8g8JgDeAUwYl8
 f/f6fNR187/UI0FXSFYM7HVJuV9bMXGGaAegIeB+Ko45bwX0gLJObYYvXHBSx5/CVus3
 b96lSfQgsz5LV3TEjDqcM4DXCbnxPFOLp1EkvBbn603nlDhScBTNiVmLCI1BvEDBJXji
 JEOA==
X-Gm-Message-State: AFuF++nbE221GzHBuNCb278n8G1DtPx8fVHd7vF7M/n2RXRZsDZq6R1t
 fHvLlqcp3eY7jCSuVjus68VMxo+O5IYjfLwHk1XuoE2/r/AYsMh7U7VN44NqAlsoVxrvpp7thGU
 /5IS1EFDXY2jzUyYQwzIAgrGqAMKwjNxNNhJIYAxcRg==
X-Gm-Gg: AYBFou0hstUIZAJA+Jgdd1kWafB6HxjQmInpauGzPYrGYu9NBIdRMRCs+ILx48jNq56
 y8hkL1iM+SxP0RkNyxMg+7KBYR+hSygZ87AIpY4a5NXSkZHoDTQcZXOadUNFuE3oSoBOC1G4YZk
 npzsEtgTPoO9vBN/wNOuiY6rTfIW+JA7/qmG0Z3Z8buWgkvNeKP/GwtPbSVT654JGV/Rz7vtBPL
 JUPCg5zuro6PqeasEr1eN9MaA4fOg99JxcR4fcMBLip3xU3mK73iJPUGEkv2a1ftj5MHmWohEYg
 p8RK+lR9Fc6V8M4YgvK+4US7MdkF1mnuXbn2/4HIdmEpT7B6giGi/Nv9906ZXLBXEnkTrHEqgam
 zVb3SUF8PxO9uaaqnS7QUHRZxF+ui
X-Received: by 2002:a05:690c:e146:b0:830:7633:a1aa with SMTP id
 00721157ae682-87125dfdf43mr5338837b3.21.1788463247649; Thu, 03 Sep 2026
 12:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
 <20260824054806.2790041-85-alistair.francis@wdc.com>
In-Reply-To: <20260824054806.2790041-85-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 20:20:36 +0100
X-Gm-Features: AcwNN1VXa0LIP4AgO6b9BX1sSoTKVVUwXSJlOzRCVsI51AGSUtLMpr0b3JNKiEQ
Message-ID: <CAFEAcA_phpOmsdDJkxVcTYRbShaTQonz1f0bm6e=-Nbc44xgLg@mail.gmail.com>
Subject: Re: [PULL v2 84/96] disas/riscv: Split rvi_opcode_data
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 24 Aug 2026 at 06:54, <alistair23@gmail.com> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Generate separate objects for OP() instead of collecting in a table.
> Return pointers to objects directly.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260812223142.349142-52-richard.henderson@linaro.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Hi; Coverity notes what looks like an error in this commit (CID 1685513):


>              case 2:
> -                op = rv_op_csrrs;
> +                return &op_csrrs;

This change puts in an early return, so the whole following
switch on operand_rs1() is dead code.

>                  if (operand_rs1(inst) == 0) {
>                      switch (operand_csr12(inst)) {
> -                    case 0x001: op = rv_op_frflags; break;
> -                    case 0x002: op = rv_op_frrm; break;
> -                    case 0x003: op = rv_op_frcsr; break;
> -                    case 0xc00: op = rv_op_rdcycle; break;
> -                    case 0xc01: op = rv_op_rdtime; break;
> -                    case 0xc02: op = rv_op_rdinstret; break;
> -                    case 0xc80: op = rv_op_rdcycleh; break;
> -                    case 0xc81: op = rv_op_rdtimeh; break;
> -                    case 0xc82: op = rv_op_rdinstreth; break;
> +                    case 0x001: return &op_frflags;
> +                    case 0x002: return &op_frrm;
> +                    case 0x003: return &op_frcsr;
> +                    case 0xc00: return &op_rdcycle;
> +                    case 0xc01: return &op_rdtime;
> +                    case 0xc02: return &op_rdinstret;
> +                    case 0xc80: return &op_rdcycleh;
> +                    case 0xc81: return &op_rdtimeh;
> +                    case 0xc82: return &op_rdinstreth;
>                      }
>                  }
>                  break;

What was the intention here ?

thanks
-- PMM

