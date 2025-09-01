Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE8DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyVE-0004oW-UA; Mon, 01 Sep 2025 02:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyV9-0004d4-Ev
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:58:53 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyV5-0005Oz-Jb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:58:51 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so193542366b.2
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709924; x=1757314724; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tw4JXSc0ulq4Tvq9M1VvHYI+xuxHa38s2Cd4L7osjt8=;
 b=v1ubt+tIfM6RW7QJRPCAv6jHQbMKikxzeDURuTrqZA9tJ+7XCMQSOQefDnSA4MZ76F
 QYYyfhYaYvtyjCLChlyPjzKZmWT+EkChn+J0A4Av5TVWK+Z6quZ5e1Zf1wLKSDT8IGEf
 MG40VWF9du/0f1NcVdnD8C6F3Txb6NN6MduUsdCmYKqiRIL8W+byhfZjj1gPxxlNdTo+
 4k/oe36mPp2UXz5FEV5O4m6XKjMFX1JeMVpE0YM1wU/UqeGp255P70i8D83HyKq334vB
 Hq7h0QtDOyYDSICM+AVWbDEkyBh9DQeQmAEKgWT7D8cMQ9FfZDPDptUu2i0ovuyYHSrR
 dpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709924; x=1757314724;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tw4JXSc0ulq4Tvq9M1VvHYI+xuxHa38s2Cd4L7osjt8=;
 b=oX1OEPZAiFQIMJSZaGUH2nGgEh7RbXz1KBhfrTG/Y/33y4tMOQrvcigSRlGCCzxYxF
 NzV5Oo6/OAijHUajqKueS307NjSfjE29iZi8JdLQFSelDnGMc9bgVuPcVDFvfvR1P3yC
 SlL0cUmSLPta2DgDf7LyoEUzkiO/MR2Lwtl1a5JLV7c53uB2EzqXq9gDQbgHi1JSYM6o
 kYnkw3bjT8AkJzBYcX/sOaer0UfzJEdPKUsXHxazLB7M/pLRrf4ytWA26XlncQtqbDRI
 /6dlNlzXPaRNMrsPIS7jvfjZ3SjJdaSw1V/fwv3xLSsUFW+Dm8ufPnNYeayFGYQ3suEe
 NDCA==
X-Gm-Message-State: AOJu0YwzMjOU8NuyhOhHuyFFPRV/pCqPjpVBynnnyHW7acuUq3ikG1jZ
 lVa/NOjBGhxpb4BlzNaSgKpKkY98anezXRAZ3Nu7IKA3rpItTjDvR4Ll2Mj317ptgNmS1UbRWEx
 FkVIw
X-Gm-Gg: ASbGnct3xKcp8nIeOEzp06q9fk4WvmViPt4UrNtXSqwF0bIf2Sk8nTi9+F33Ts9HPp7
 yYa4N4+1rfeviouNgaS/pkFvAgctX/IxkaSX4QE+amhbMX44laP43RIQZqJGzDuXXqGi89ZaQV2
 7nfBdH6MJigi6buv1UvULbLGx46u99Q8IFvY97qeF98eMDZYyb7NfEAaaOSdBE4Lhvi+pZhnNzX
 qAUPPKv8j2ZepzhsJwaClF2DxXf+u4S3WWldKEYOE/SbC3XHxAsgzCHUHwJcXFq4e/rTXmLUADO
 e3MMAYp6+2n9nT7U5Elv8pMHkUb/lz88Hh2oYUOjb40nPWX7N4Q/KOlUEhMWov05T0SLvwnYP2z
 N+YX/MGsID5GvBX0zwlXWEHwPR0bKiV6LykbgjHNdYgW50/4q1JayfBXOydO3lk36XvqP/8XA3c
 WXqBjIN0w=
X-Google-Smtp-Source: AGHT+IFjaZYJRY2NGY2Xv33mxU+veLTjviJTy2yIKezBVSkbsEW03Tl1Lr/nxQy59AcZ4uL3rVbchw==
X-Received: by 2002:a17:907:26c4:b0:afe:a83a:87ce with SMTP id
 a640c23a62f3a-b01d8a2f955mr668819766b.2.1756709923890; 
 Sun, 31 Aug 2025 23:58:43 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0432937d7esm115862866b.17.2025.08.31.23.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 23:58:43 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:58:13 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 40/61] target/arm: Assert ARM_CP_128BIT only with
 ARM_CP_STATE_AA64
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-45-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-45-richard.henderson@linaro.org>
Message-ID: <t1we1u.ty2nxrkdo1vh@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/helper.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index 64a987d143..3b765408f2 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -7353,6 +7353,11 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
>     assert(r->state == ARM_CP_STATE_AA32 || !(r->type & ARM_CP_64BIT));
>     /* AArch32 64-bit registers have only CRm and Opc1 fields. */
>     assert(!(r->type & ARM_CP_64BIT) || !(r->opc2 || r->crn));
>+    /*
>+     * Only AArch64 regs are 128-bit.  There is usually an AArch32 64-bit
>+     * alias, but must be defined separately due to encoding conflicts above.
>+     */
>+    assert(r->state == ARM_CP_STATE_AA64 || !(r->type & ARM_CP_128BIT));
>     /* op0 only exists in the AArch64 encodings */
>     assert(r->state != ARM_CP_STATE_AA32 || r->opc0 == 0);
> 
>-- 
>2.43.0
>
>

