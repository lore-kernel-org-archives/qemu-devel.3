Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9066CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmrQ-0003Mm-KJ; Sun, 17 May 2026 21:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmrP-0003MZ-ID
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:33:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmrN-0006Zw-Jt
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:33:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so442967966b.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779068012; cv=none;
 d=google.com; s=arc-20240605;
 b=dz8GNXtzhLx5vDODvuhg/9IArncrKXX0NyP26dEcqWauMnxf7zEoT9LzFH5f28aQhE
 P/du7ofomZ3WsstzDFnmp/15qTV9Urc6Vn0+f4r03lHskkGH4Nn0LSuVV5qrsI4bsQMf
 bOAfdo5tFQypiNehcC/cLQH+ItC119HFEskme0VWJcyjTg7XlbnaSD7ryUMLX6dWkPE1
 6kowl4Tb2cFIE3C5eD8LiSDJ9hToGfNYdfum1PFsZtcGJbQVeABTr6V7mYZqg7H5n/lz
 KaG6qwHv4GRNGJCLH8SjaJC/5nLaBCAfj+I0feav+tLJ81/r6h5VV3kuzHpFOMgdhVnH
 lcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LMiUofhpgDLJJBgt1QmEXiVG5looPFxLvvqMFy/kRPU=;
 fh=b/Q5p3p2DAwOon0/j8DGZfzvGSHbY8gAr/7v7xrL3wY=;
 b=HkDTka8y5vkmWbz3DmkuJ5Dd5rjNGwLcu/C7bMfJ0ifoIwCGd6F/CUnSGwc+yYdSFm
 WJTsUtbHXbJ58kNGuP3xwqCCUUIOdeFB/t2qPxmapEk3JOw0az3cbpd3i3VOLEcjUX8F
 AdHWQf6R8TuOw+Y14fLMcbcckAw3wCbPdu9fAZoHscBIg2yhafP3XPE/lUY1VWSu/+2t
 IcTiH9REgbaP1XFxuixmAlnC16bFCrafmt2AgGSwdbpraIsoVpGbxaEhxVEZNkRzlYmK
 vcfGtND1Hqcs+6jitncIgfi8KLTdEQ1U//qfZrF+Y3J4QwrgRMfsNhU21k5P5m0U+DEP
 kfmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779068012; x=1779672812; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMiUofhpgDLJJBgt1QmEXiVG5looPFxLvvqMFy/kRPU=;
 b=AUDmAlWTmoqTaOsMEMpac5xD4NoRUdp0XNfSXmuGfx1fjfUx5a2MvrK60pz80tMRCO
 IbTIKKiCXw+BLfQpFo7jDiP3Z7C6DrrZYzLvWOQcrCDlA61zg201YHtKoEVnnetFJ6v8
 pD7I9Tojn3MDqYiobmP8zqcUnjwBWSIbcMERO3Yf7f3YiDEDTg+SoAUnOahpPUxgzRh6
 D+34EiDcLup20kNIX7IPN7UDbfl1XM+2kLgMEXT0lD84qNN0GezKJ6OqvvwhROxaafWL
 x7ngNnwHk6abuIqwU9Z95y6mxtR1FAf2oiENXt3xFAsQqAKOgMNDvYsCfad3dGtTKY2k
 7vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779068012; x=1779672812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LMiUofhpgDLJJBgt1QmEXiVG5looPFxLvvqMFy/kRPU=;
 b=YITxZ0P3UvUILXSnNqJMbolq3K1pBGlgD8n58gM46nfcGEGuDFQN37ygsR7WeSfWKO
 gF8plGDaU4gwkn5+GUer8wqGdEL22+MvT7j/2gKC4bEHiTKg4aYmGFtBup7A3vc6AhSQ
 ykSAoKVKaddFJV1NuEd5XrVay0mSptn4/PDbCBndyUZfja06ouk3Ave8oSRPKe0JOrGk
 K6MwH4WMuoe3aKelRqVd/9/FUr+WLpxt5EaDVU5dTiWysH4Kf9ta5P4IvZWW1UZ73Xxe
 5JRe3riVUHp1CPGjwz6OzaJ4qG4ev9FpxLUS7+Ae3qTOeo3pyU6yaM8NVUAJhoj0bSrB
 Z7bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AH0ZnTNf8MU+wgNGJsYuwR/Ve+P9ojR6o29JGipvFhn3T7EQLj7v2hyS4zYRL08MtD7X32c1zvfpa@nongnu.org
X-Gm-Message-State: AOJu0YwdhL89EeShrx7AdGJ1jlDMD90imNGXFoR/m9AUWwUy/diWo6v4
 Uw5sdZjgFkSzt/D934fx2msKbnpBYwZQW/+PcraOJz0g2dgQ3nILgDVVgw8P9wKpFJ72xpvdWJP
 rn6rgm1EAECm1bveYA6E/4zofxoPlWYI=
X-Gm-Gg: Acq92OHb7f6kZPKmHZKrumd8CrLwug0h2DZ8ZjQwG1u+wNEi/3earXXaEjeviH8wc16
 f0zfH+smmia3fU16kOgBD11CxQG2fCudsyLCg7Ap0LtLH2az3FRO8dmPWy4yD+NQ2C1fHGQHZHr
 ZNApVK9sU5vVusvQ0vzBtxe8/JgC6UeZGX9iQXTOKu05NtaF4jY2sPG0YjfjLj1xLOtlx/W2+Cy
 EdCspr3SxXQ1OWJeJIZsXGRCmpu6huAvo/gFT9pDwg384XIAcSqsYiG0ZUhmgfDSqQNU4oFlUmk
 +U48eDk2ny6C2kr3WjDoEkEdySysBa5LReTcWQ==
X-Received: by 2002:a17:907:7f9e:b0:bd5:25bb:4e9 with SMTP id
 a640c23a62f3a-bd525bb09efmr582366466b.11.1779068011826; Sun, 17 May 2026
 18:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <88318c83-e8be-4b0e-8499-039203d1bf79@oss.qualcomm.com>
 <cover.1778653159.git.zhouzongmin@kylinos.cn>
In-Reply-To: <cover.1778653159.git.zhouzongmin@kylinos.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:33:03 +1000
X-Gm-Features: AVHnY4KySgJhaqIchwlDcaZuaYbUU9hw0GnDSoRe0BSf8oWZR6nq02zc1yh5ZrQ
Message-ID: <CAKmqyKOq3YUbnLFZ9DHo2tv_47J0god5h-ztYLm28HyGWHJKtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add KVM support for Zicbop and BFloat16 extensions
To: Zongmin Zhou <min_halo@163.com>
Cc: daniel.barboza@oss.qualcomm.com, alistair.francis@wdc.com, 
 chao.liu.zevorn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 13, 2026 at 5:04=E2=80=AFPM Zongmin Zhou <min_halo@163.com> wro=
te:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> This series adds KVM support for the following RISC-V ISA extensions:
> - Zicbop: Cache-Block Prefetch Operations
> - Zfbfmin, Zvfbfmin, Zvfbfwma: BFloat16 extensions
>
> Changes in v2:
> - Patch 1: Removed Zicbop from legacy KVM extension reading path since
>   the extension did not exist in older kernels. (Daniel Henrique Barboza)
>
> Zongmin Zhou (2):
>   target/riscv/kvm: add KVM support for Zicbop extension
>   target/riscv/kvm: Add BFloat16 extensions support

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/kvm/kvm-cpu.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> --
> 2.43.0
>
>

