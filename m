Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37A5CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzH3-00072Y-QD; Tue, 09 Jun 2026 12:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzGw-0006xJ-0O
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:25:50 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzGu-0005hd-HZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:25:49 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bef47b1ac01so869332866b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022346; cv=none;
 d=google.com; s=arc-20240605;
 b=GsmXE5M3NZ9iIHItMfKptCYbEeE/rfu2jrl2tPWycNNkmXso/vI2nn5d03oqQBkTzj
 ReZj77AcESm3PXmmee4yRIxzUCoZn1+f+L77G5fkIdrto9bNXiMwHqoJOLUE11pLewMg
 TovHREV2Iy7pRZhl7HJapzzlar5NKG7/f7bdZH5tgECn/heK9/5A3t65lcIixBQ2QZV6
 6N9NSmF/E64Xzzaocuj6+D2TnwlbxeErdO/pV/5jaE7xDO+/IuK+XsXWjQp2cvLyMwqG
 wCDWAxcpyCDqjsQBp+h9qUNIn9SkERoJmL3JWBBrENS4J1xUfuMC/cCCwPRLorKRXlZI
 crYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iZ6B5/5KFMGcml+yrVI24NNUjdE1+KahKb88orQukBM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Lue1Q3dW2AkwApoioTmwT0jPlIncBiBrW1ffBEo1pWQ6rtUZxgnvo1A0f+mwjaH57s
 +DBTNzBWoV13VaClx4pHIhxoGgOw+xUdQXRm7eIdsspezkMoQT3OJGWRTnlLpxIq9JbL
 nz42aWqWIDW2PFp4WOI0LBBZO0xqeNmgVDPRkEEUzmARj7yY+iahRJ/DQs6y2gqll4i1
 J4pbxpJ+WkZWJ3L3VSYS10EoDMynIko7BF9Bze8kKnvVQfKNAFkDTfJS60q7+I6/aqts
 0afJ73g9sLJgpeZzTc37h+ha5FfZD4CLq7TPlTbV2ynnrNblC+j0oB2g4EUYDDVZjOgY
 kpnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022346; x=1781627146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZ6B5/5KFMGcml+yrVI24NNUjdE1+KahKb88orQukBM=;
 b=GtTNMhEAJyzLG8iv6LLwZN0KaMIDGlqNOQnuYAmPZhQdJGQf16t0jaXLJvzIN3rjhk
 vqAMiK2iFSifTk/bVDawkwTKEho1aEMIED1NiPNmssL/6ak3Oe8jRsvZtk45Yq0PPQGW
 pQmlQ9Rw1T15t6skoko61NAEAFuRYGViMYg+w0FkKmkazPvNL3VRE63zU+ON2MIUyfF1
 ChNiPFxHdnocPa7z8NzLCpEnyI4AIVF/vLFAfxvVfFHcRqKPwep7Q/8beuT3qF6MD7hM
 27quQzZI3jNm+TNw5PwRmRggfRhMpl91d7yQ6lbekDetSZXNl4aNxMgtk5fuiYw2tVt9
 5qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022346; x=1781627146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZ6B5/5KFMGcml+yrVI24NNUjdE1+KahKb88orQukBM=;
 b=mYFLJBA+HxoAQS0dsq5TiFNevNdeq3yOiOdwNuexhJPNB1PE0fnXCpDcy+DWW3wGQS
 nWQi9bXnBvX8NEExtJsKU4AZjSgoHSOcZzmBQPvG0gtPQoa26rp9zKre8BbE3IOJ7k8e
 +4kDyfE4EjoPyuASQqraWBcpBeWspEB10sWVQKd9KT1JBrHjhCUSsw/NMZj/o8mr9vpz
 LASuOE1CqfyaSh8vKN3yvwaveceCrDXzvbGMW8PVID1+y73OkErqO2fNxciRlTm9xl9S
 7QqMPkm06fxd0qMKvpOZCsye/L+v5BuakU80+cezlxmpDjcaul3zB9hesOvwDHz7D1/+
 K3zw==
X-Gm-Message-State: AOJu0YyCwmwLrBz68/cTUNeRn/E4VVcnUzHlPqT26cRs1HR6gsHDMaNx
 gtA3Kf04lSPexEqemyQRBD7CDQ3WI5oORLNztZvjs7moIIA+rPW/eZHpo3sjlE6Qb/U+U/jn14x
 0TximlKAmHTMbru1jWLW6HFCPJKxtWFUrK60FsR8MSp9wLOp930O/
X-Gm-Gg: Acq92OG7mD6EQOfm+31X/inviZDkr8as6KLpo1k2TEuJ4a6orhchT/T9CEaXaincCdY
 lCx9TOXLOxYZTZkvRlZPT82Z20c3JTM3N5NkmA0vnHuDeN3McGONFs3Tpn7rIfl8ZZyYc2V6LhU
 9dTTIukW2cBVSWvYrQJZEfqbKQCk4zHyVtPU5PvYNbpRLB8nL29GDcKQe8lgUcL8epmzwIEf42Z
 9b9SlVtxkstpuC85KEdoiQTBCvL4unpfudvtTtyYKltv3KloXpNwZC4UACLIVJbx1AYUdHlKuoT
 VzIM+AdOLVGv+DQRQkcsCU4dWo34ukUy/LHzQs1kGJ9PCCF5P6b7eBaVS/ujsL6PXGETHORcjjI
 Qfg==
X-Received: by 2002:a17:906:c10c:b0:be2:36d7:573b with SMTP id
 a640c23a62f3a-bf370473fa6mr1106911366b.12.1781022346389; Tue, 09 Jun 2026
 09:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:25:32 +0100
X-Gm-Features: AVVi8CdAQ7Fk6JHulkR9J9lseVEDqLuhdCvE_gpH0jljW8wuseJULhxdZPPzn2Y
Message-ID: <CAFEAcA-4KZg4oPL2Dv-TWmkwV0won1+iBD_B6aLNphyZj=-1VQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/45] target/arm: Implement FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v9:
>   - Include 3 arm patches from the fp internals patch set.
>   - Generalize TRANS_FEAT_STREAMING_SME2 to TRANS_FEAT_STREAMING_IF,
>     pulled from an in-progress FEAT_SVE2p2 tree.
>
> Changes for v8:
>   - 23 patches upstream
>   - Rebase adjustments
>   - Rewrite arm_init_fp_status per feedback
>
> r~

I think I've reviewed all of this now (either unconditionally or
"with this fix" r-bys); if you can get a respin out by Thursday
I should be able to get it into a pullreq this week I think.

thanks
-- PMM

