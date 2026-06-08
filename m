Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50202CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWQO-0005Wb-FP; Mon, 08 Jun 2026 05:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWQM-0005Vw-TM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:37:38 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWQL-00057h-CO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:37:38 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7e8ec43e5f9so53116447b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780911456; cv=none;
 d=google.com; s=arc-20240605;
 b=lcOcPavQ1H0R/4DZxD2Rdf4MKIx3a6v48n+ns/wgZ59iMch7TIk3edyqEqQbVsGioJ
 3DhnCZOHvWqU3SHEnK450rZJNMUrwKS39pjwPERnomhEs7bI964J3e9dJJn3cKZ18Fg3
 N681HELl+1D5AM525WNacl38Yip0gdIRx08b6n//a585jH/HQSK6nZTz0dEynB8jCa4G
 jgivxM32sPGM9rSVinLp76t+pWHCvTw/EHKKNpxv3oT1iiCCHt0OpfgPj89ytNbqsgN+
 VRu0Y1YaxRFiEfwGQLxylznm+G2YMOH8jyyFEUOSUFlw6NxGF6ouaBUYJMhthBiU96It
 fkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J5L1JFcEbvERzC9sMUHEuhDP6qO9bjuPMoCnatQ7p9o=;
 fh=g+MQkiJJtCsmZcvB/tRD1/+P3M8b+o/kjXYGQzUye+I=;
 b=NNWrevY6RUzc7NUVh0ZtKbjxXG2VWIZVqjS2dL6C8Vy1PaKE7xLKGTkaJVfm4KtDAY
 nFSCkfKP4e2njUZzw6GaXewT0tgGAyOZe3DNeUCRYQIJEAu+/01V6s+R+Oyf0rkYEcYf
 DuUpWef8r4ZYS+DXhVPC/UoiFeqC+XZ2VW0qo/bNwIx7GU+tOqI/fAt+ID3URRZ1TE7b
 HruwcUdfYXcyGOWawuKYT/OkpgxglyqltSe2IjhQDKppDtX3dBYY0MdMUa3WxbG/hjyx
 jU8FdNNiBjyJ7Jrtdcxd9RgAlVxY552q/PyZjgOpaH4hRnTrDq/QtTWTkulBnNpNSkAo
 qZsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780911456; x=1781516256; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J5L1JFcEbvERzC9sMUHEuhDP6qO9bjuPMoCnatQ7p9o=;
 b=vuCalg2Ya6Hn87VliHEjbiooRkJ/ge0bp5g31blmkh6Xdp7CAzZxZNn3HwKH/AEowe
 pqctREOozOSfMYcDl7+qVKqlFNUaRH30wbAqXIFvIg6d5G04K28E2lDeunCUDo3A00bC
 akdJJ4JduXaFEq5MHp4LyRQjDR9gHtEx5WQ4xyAhVJchWuE7cIj7Dzl308XGkevLpS5J
 /iwCSyhmCn37YEfeso5uAuuc0HcigM8Yzf6kfw53e+RP1ehwmNsJQfGnm4byK3WNzWow
 V01EeUnPcUb0ozkFcf55Pzl2qalmkKQ305Q4O/QXWIxtQGDR1pwOR9mw1Qv1+zOKuQmy
 4Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911456; x=1781516256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5L1JFcEbvERzC9sMUHEuhDP6qO9bjuPMoCnatQ7p9o=;
 b=JfVdjTTMmeMy8Vy23PKNvFI8UxkUyMvdzKjeNsKj8NjTAeNs8Z1ux+BwlGPfxDK1TO
 R766RdtLTdX3Qz/s1cp/RQtp4GX98YpsZLG7A5HqRC7CCcEzM/5BWzV60eRhks2CyTT1
 27x9yFHKdj6UjC2AWr8tCzFNq0qIGYapm4yJQFbs1lKiYruteCLxZLP9/B6E4b0b4kPb
 24+kkXinUNeVjz/+p7SpT5qtxx0T2vWN/UwoOGvlQX7XKV3U/GZDYa9KsztL8nGevbcq
 mAcOeKdFhKXEf/oNaH8w7+zF44KBZnkpGvPiDnqPf4VSwCTfH8pf/5NmYV2beUyjgxGn
 KHtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QRRaX3OyPYHBnJhLLG7qII7zGExN0kuWhUX406l5Sv2wkCUVa4AOss7xAVYtytQd2FibVbf9Te7R6@nongnu.org
X-Gm-Message-State: AOJu0YwYn9MMpryUCk32Neu18BTzGlMhKPzIMVrNBNAuj5x0yTTAZEwG
 tIXe6zjtErqrnz88HiTN2Ta+S+6RHfTRrhyXbJRhiS6nVU9Jc90Q/RWIP9wByl14ooveD/JrcGC
 HusF1NB1x3ja1tU5eDucXMiXo+VAjGiyNd9JC8fE6Wg==
X-Gm-Gg: Acq92OFiMP1RsoBbs0sp9r3sdZerKa5sQY7CxMV7jOEfIVBI4TIV9RU9d5HXiY9eHlk
 1Akfn7TIzzuMah1tDTkpIKEtW186bPg5+Qcdre2JNrnfNEo6bX/PZA8PFrzItdnWzLO/kv0iuEI
 evug+g5YM4KxejTCErB7Uk6qfyunCMVMOjIXnHF0JsigoUzEV6mSoomxtHR+FnxFaoMQqBPJ1f0
 lElkE6rS4MAIsPOSx/BxJ7wzcQtRc2ySNtYcoNdEga5cg25a9eMXbPyRkfaGKAHkTK1mu2kRe9a
 3HKIVP52dJVxcfNWsi6NxiusDw72KFBU8MrSc/HZ0sG9wTAZbEo7mkeiaVxv0LkbPHoF4f3xL5m
 xsQ==
X-Received: by 2002:a05:690e:bc2:b0:660:8508:5c15 with SMTP id
 956f58d0204a3-6610779e086mr11012601d50.49.1780911455764; Mon, 08 Jun 2026
 02:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260605034729.2874861-1-kylefoxaustin.github@gmail.com>
In-Reply-To: <20260605034729.2874861-1-kylefoxaustin.github@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 10:37:23 +0100
X-Gm-Features: AVVi8CcI9Ri40NPGHNuqJlFE6tU-04vN5237IiSyt5BxVqNfiKETCrUY6erp-1U
Message-ID: <CAFEAcA_=2j+jHuqcCF0S9X=4q3dhY8=EKJuGCkuuUSG1jaO0bQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: align down misaligned PMSAv7 MPU region base
 instead of dropping it
To: Kyle Fox <kylefoxaustin.github@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 5 Jun 2026 at 04:47, Kyle Fox <kylefoxaustin.github@gmail.com> wrote:
>
> When a PMSAv7 (ARMv7-M) MPU region's DRBAR base is not aligned to its
> DRSR region size, get_phys_addr_pmsav7() logged a guest-error and
> skipped the region entirely (continue). The architecture calls a
> misaligned base UNPREDICTABLE, but real Cortex-M hardware does not
> disable the region: RBAR.ADDR is only bits [31:log2(size)], so the
> sub-size low bits are simply ignored and the region matches against the
> aligned-down base.
>
> NXP's i.MX95 Cortex-M7 firmware (and the MCUXpresso SDK demos) rely on
> this. The M7 sets up a deny-all background region (region 0, whole
> address space, AP=000) and then grants the peripheral space with a
> 512 MiB region programmed as DRBAR=0x4c800000 - misaligned, intended as
> 0x40000000. QEMU dropped that region, so a privileged access to e.g.
> LPUART3 at 0x42570000 fell through to the deny-all region and took a
> MemManage fault (CFSR.DACCVIOL), trapping the firmware in its default
> fault handler before it could print anything.

This is a guest software bug -- software must not rely on UNPREDICTABLE
behaviour, even if the hardware implementation happens to do the
same thing every time. Other M-profile CPUs might do something different.
The right thing to do here is to fix the broken software...

thanks
-- PMM

