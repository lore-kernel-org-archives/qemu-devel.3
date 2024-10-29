Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E830D2AB14
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5jBF-0001jo-P0; Tue, 29 Oct 2024 06:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5jBC-0001iK-27
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:10:26 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5jB9-0001dL-M4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:10:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso8122749a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730196619; x=1730801419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AN9pvc8Qen5ygV5OCPkxjXApiKlaWjv7EquPAaoT3fo=;
 b=QboPyTmfn8bhVxbMhufq5bPosCeiFhiMiwZlgscoOcxAyx/UmBMgBkUDBi1fjflFrT
 u8kMnrqczcLcgLAfoqNoLjHloBe4owSHIqMOtUV8JaiPc4JOFr+uTVKH+N0dfG6Ic3pB
 DXJPNrX8rTWOCHx2RFS4qO02jh7V/8xdF3irPlb4sEUo8E9MAEC8cav5RX/BEtnNj7/W
 B2CxQXFAG/kAYCoGenwX2lUq49HRR5CdwMC4B7yvQlvVGr0FTvkBM+lgqyaL3GQXXRMn
 JHLOzALG2hF/rt9ZuKto60LBTGM4VSHX1MAx2I5pfpH/Eubr+8rRqMCQuGvhuNnLclAg
 oTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730196619; x=1730801419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AN9pvc8Qen5ygV5OCPkxjXApiKlaWjv7EquPAaoT3fo=;
 b=Sg7EkjcGF1x5fqBt4HHoaNuW3x5ndw0qx8UwNunO0mGrLNHoUP1o2BopULkMmfR5XG
 CUp0GOy/Vpu5UyDaULSkNxkNU18lZ5mfpswZplPELAdl2mrrv8vFh/4G0du0/kfeS0ix
 rGlj4bAtVK4RPFLYVT3SxEzpIO7Jp9EecAMpvSsi3KjbX7HsEXb+mLHW21QH93FgG0DQ
 iH+7vNGDww4yX0D8i+UB2mnCo2eAW4JcB2nwxmSGmJCNnFeEobB2gt0th6XgrNQYbDvf
 YN1FgudND+S1Wd3mALFOQQ3Bx7SKukIG+zBu1EjtHv0t03i26BOVNZHdpry0js7pDFcN
 nBeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTkjHuCMvghyafgwLQkyQOr42AFifcKX2e2GR2Hf9E6gDHj2FyIGFwN/Dhpb6nlGJQ8+zpRk0Kvt99@nongnu.org
X-Gm-Message-State: AOJu0YxdvZB7v75NRPBQQUN677UtEYOSP4JEuOz8Ey14AtUPq9txNEPy
 /Ew5kTjyMmoPwjTiRou/PK0Iv3LWTIOjjcEbHYgrxKvx8vLzpNgrQ7CSpIfcwhnyE5+023xieqG
 14m+GD3MFsCyNp+K3uS0fXBrNsmQhsAqNscj/Zg==
X-Google-Smtp-Source: AGHT+IEJlKNVHDt1fwnACbxFMCVJEbHqertCIVVjn9p0LZn8ZkF6YM6otJgMWMRcEC9Ib9KXAhZNznsazbpeYhWwkxE=
X-Received: by 2002:a05:6402:274a:b0:5c8:bbc3:9dff with SMTP id
 4fb4d7f45d1cf-5cd2900fdfcmr1444318a12.5.1730196619471; Tue, 29 Oct 2024
 03:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-10-peter.maydell@linaro.org>
In-Reply-To: <20241025141254.2141506-10-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 10:10:08 +0000
Message-ID: <CAFEAcA9D7_WBrkxipoSa1T0FT3MKojBWrhH9WBeq8NZpLd5Kog@mail.gmail.com>
Subject: Re: [PATCH 09/21] target/m68k: Explicitly set 2-NaN propagation rule
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 25 Oct 2024 at 15:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Explicitly set the 2-NaN propagation rule on env->fp_status
> and on the temporary fp_status that we use in frem (since
> we pass that to a division operation function).
> ---
>  target/m68k/cpu.c              | 16 ++++++++++++++++
>  target/m68k/fpu_helper.c       |  1 +
>  fpu/softfloat-specialize.c.inc | 19 +------------------
>  3 files changed, 18 insertions(+), 18 deletions(-)

Whoops, Laurent pointed out I forgot to add a signed-off-by
on this patch, so here it is:

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

