Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049BEC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsJ4-000285-Qf; Fri, 01 Aug 2025 12:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrOe-00038J-Uc
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:10:13 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrOc-0002B2-Mp
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:10:12 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71b691a40a8so10706807b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754061009; x=1754665809; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8Xc09egFgZLeMfnSihvbNvEvg/y2vhYSvr8g4jpYYA=;
 b=aX2pLK4fq1id78tQQ4gkPTvsje3+sE7uQovvIQANDpEePaYEQVzZMm5S2/utnUQ6Lr
 yeE6nENofqxTrcU8Gc19oOCVg8Dy+TGRNb/ujprD2ytWfisnd6Riu6hMcEQunA6rSHCE
 waflInF6bU/8lwC0elFZVqTQ3mdxDKy+Poio3S0UwIrQtMksNbAKDhEWrpzP9j7aoGrA
 EIwWpi1X7nbtw3JTs9MIjPgv0oIMtsAZgX/Sw5xg6z8ks54KL1qfIELmurmftengKdCG
 +4mdDwnIHTTtRpBGxEheJv/k78bnkMAlAF2rKRULJVCtjwfOBeUEpwEteABYb4E/Hp1L
 KyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754061009; x=1754665809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8Xc09egFgZLeMfnSihvbNvEvg/y2vhYSvr8g4jpYYA=;
 b=aVA6EWL3LcrS+BKE+W7CcutfozTKZ3BmcpwPmzOofFXGXCvXLSjYpe4k6Bl+c/jrvw
 ueqLuf1nZ1wH2uMNapI8K1YolDSLIdr5IMfQkNkSeBx/XzbgT1dnl+7O+wlIDpqMBOiX
 kGsQ5ksiAwgTBEZ8JfYXGthjI83XHyp//yI/14w4WaL/mwxwVwh2Ww89RhSwprJSAakd
 OEHoy/69bwgOqsImi27XeNO/xO/xyuPYLtKr72w/HWbhvaSs6CrMVnTBh+DIRezctq3c
 mIdOKL078VezgMwnP63kfX/tvxB45K1eHxNAwEzAYXkOVpy+ZVc0kmX/ka1W1HWfDK6b
 uvWQ==
X-Gm-Message-State: AOJu0Ywao1BRPbl3gv3iGX95dn6ZIbfPdIXQOwiHDHc1oXnSI2RkrYgD
 lxtb7niTCguvAwvVwCsw5+/KwvXhHSzyRR+WpBaL5b4o1S33avweyxTpTYk6TR7FnJexUej4vTb
 CE1v7noBTHZzFLeAB7TlqJeHWVmZyzIJ0fH564Ui4cpAo/Ui8F6HF
X-Gm-Gg: ASbGncstk5GT0wEd3i2TcljC1h2KFOwMoAxzH/zv85ZFT5TqCyrqRHPCyT+wsZWbmy/
 MwsMqrsUoZnVxVyIheLbc/aROKCuF1dZjwv8Nd+oyrrRumikDnltJCKpHvZFkheca1h9NxLutWV
 sNhGnUGXepVOIAg6WShd8HZYxmvMi8kLdidsA58S/DNBKRu08zHlj0l29Dc4xrP3DdGG1WevLt3
 SVjCvdx
X-Google-Smtp-Source: AGHT+IHrlmMO36dED1A2g1ko+FLAyyszNPLkabzWjy1eD0jG83fO1sDl+8yJGTWp/y33GSbJmgN4I6TlojeKiYaq4pU=
X-Received: by 2002:a05:690c:a84:b0:705:750e:851 with SMTP id
 00721157ae682-71a466fa600mr166353177b3.37.1754061009123; Fri, 01 Aug 2025
 08:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-13-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:09:57 +0100
X-Gm-Features: Ac12FXyODqxq64LRkOvpaupySCNV9a5--tT_pad6njLFCF5nLreojn5nLRN9UD0
Message-ID: <CAFEAcA8OxEj7biK6MVTfXPHJFouLD73u4AP8WoG5QhrK-5OAcQ@mail.gmail.com>
Subject: Re: [PATCH 12/89] linux-user: Remove ELF_HWCAP2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 30 Jul 2025 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All definitions of ELF_HWCAP2 are now identical.  The only
> catch is whether or not a target defines it.  Unlike the
> primary AT_HWCAP, we'd like to omit AT_HWCAP2 entirely if
> there is no definition for it.
>
> Mark get_elf_hwcap2 as weak, so that the function may be omitted.
> Check that the function exists before calling it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +/*
> + * Locally declare get_elf_hwcap2 weak, so a target may omit it, and
> + * so that here in elfload.c we can tell that the target omitted it.
> + * The declaration in loader.h, used by the definitions in arch/hwcap.c,
> + * remains strong.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wredundant-decls"
> +abi_ulong get_elf_hwcap2(CPUState *cs) __attribute__((weak));
> +#pragma GCC diagnostic pop

Having to do this dance with the GCC diagnostic pragma
doesn't look very nice. I would be inclined to go with
the more straightforward approach of having the target
define a TARGET_HAS_ELF_HWCAP2 somewhere if it implements
hwcap2.

-- PMM

