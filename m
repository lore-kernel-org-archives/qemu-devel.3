Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F192C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6TFk-0001Jl-La; Tue, 15 Sep 2026 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6TFi-0001J1-DW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:31:14 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6TFe-0002dR-8x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:31:13 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e56a1fe3fso3077794d50.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789479068; cv=none;
 d=google.com; s=arc-20260327;
 b=KBAiZ5NjAUnISFLchY4dOo2e/8IsWQ2k30CYPZ8Hcm4L0CsRVuKFJciiBIpvf1mbdo
 7SOyou335PG3EPaKtUC/JeCWraUezRGtMzDlGvPbRwFbCpq03lEyBXiySFwjLad24QZ5
 OtBAPkF9IBK0tb1oKTyI6NwSqdZGmp+RAXn8jeFn8GAXQHryHaGYRqeFURFVs+Y9x1w+
 oj7DQVDQ6OM6SVguOG6FnlOIv9TwJYNp8/GV1jN6R1Kfig4ZFH6MOLalRqPS4qXSdIhZ
 uD8G+Ek9XpMeQjjqsfCQCPIKbK0eb2F1rd4phxJWe/bg4GQsTz6o8Q6PL7Ijq2sL1kkF
 87Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fEhOrvP/PY+ycmNwRjKVQCDmoJyCRHPJYQDd+YEQUVY=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=NbzAOiaCGiqASbMDQY0skgDBaJzGFabNB9MpXHP6GF5sgLKR3t5ptPQ/QNm++ViQ5S
 LYn02aAIq3wZV90CE6MpvJ15MZXIJScjOAuH7uAruB0Qalob/i4/xAbT2z1QKcpjc2+8
 rq59RP847gYG5r5OzarHcYkXLOZz7KkkuwaccA5O5n9Ea2lXWjYNCNBmr7fOkfkOko+R
 EiwFYw1qqCfYyx5EIduE8JSM0ePNCvSmGocIMmvh6vlMIfkn62H4TQHKhr/AWGszt+26
 em+rsF9eH962oFbnwykXVenxcTHYayMKShkJGL67emK0HwPWWF731n7pBnTu++Ir+u0A
 GRyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789479068; x=1790083868; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fEhOrvP/PY+ycmNwRjKVQCDmoJyCRHPJYQDd+YEQUVY=;
 b=pxhmBiIV/AfD6dmRvDf0r6E94ik8W3ovsOxsMlwZCPDIO6/Aj0dEBh2Q77y3NKUFF6
 YvxW1DFp+dkfLTnBq55J31zRIUAj2hbIFcmBtXiXnlH3FgdL/uwbNA8RfpZilLLU0vk4
 QQTqyXzsiILiNbMmeJW4qO9N8pEPr3pyJq4SCWMVJmrTe7lkFj1pIZVmVqhv2YSZb8/q
 51G0NtQSrtI0LLaBNCbVBXaj8Tlp65PWao0YEYz2rrRyzlFbMrOpprrVMdF1QtY6cGF0
 s4Q2dLKOeZtf0ZDZeC8nOmzx9ne5IzugOXyd3zPDUEYn5GZao1YoNyU8g52C1KRWuCUZ
 4mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789479068; x=1790083868;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fEhOrvP/PY+ycmNwRjKVQCDmoJyCRHPJYQDd+YEQUVY=;
 b=nehDDJtwjQsJh+Fsth7qonEfW8UgdPHsAlYUuYg/mS0W8JiM40F9ZHJZmYqwiKkUDa
 11H5Rffw8eyWLD6mbQvXBaR9IMz/8ymciOXO/Q5VxN04U7hhAy1bTHZ5DM4kZtAdIozb
 wr+UBljaARHy1BHimbLeTkk0m08WJu2vWYMzJLw9PnSlgj6bHhrPTdkrEMObZQWCehUk
 cl5kHKqrCKMe39VfVH4D74tVR8TGDb1QsHiNqbFA+cdcM78dVRcXUJgF7BfsRionAXlK
 enMrmUoa/BW8QV9iov7Cmn3ZUrzU4WbU5IGGJjEkhAQ1XGwFiUhG5KT9wxdyX287CNne
 XyXQ==
X-Gm-Message-State: AFuF++mN/6ZPrmD3/DHD0ZPvqKyINmuiWVbrmhVVLP8pVh6W3w4OYlH7
 gal4joRr63txS2q0dikOgv0j+iiGpjQcrxCH4dwhKqLIzgCUa8OWQIQttjJiRsyXsmj3oFoz5Nc
 yiSCrrd8KoclyS1l+EJoFWaCOtSkknR8Hg6tT0ykh5A==
X-Gm-Gg: AYBFou2F6lx/WVRxYafB02ljroF3lsrFJVTdoXGVz9UkCaavFCOwv5LCc55muooyLpB
 28R8s2asKXt3RgaM2GL52rDpyz0FD9dz+C+F80fHLWp5ljL/70bLOMA2me8X5JwESthslMsglMe
 /r4sgUTCJjx0Akrkq+te+KJmCCJkGsG8ej0GNUnWvIYPiDcdvFKkuqNrx2TyLxWYi18r24JS6I9
 nITNz2m0rCTsxgormhy2LWVB7BHAMz8w4czK5hp1deeJQHqMM8NUNjp+7rjYsFGqalGR9WrbCxp
 ytlW5iTBtneKuXVRavWSKdzj0HZR/5lVFlhvx9RtyvlRR4bdBf6MCwiIB4NbtaFI3ol6JcDHmxW
 HdxNzp3+tNmE4md5QuALVrrwbAqWYwIOZcCiRGY8=
X-Received: by 2002:a05:690e:1249:b0:671:4fbc:2452 with SMTP id
 956f58d0204a3-6714fbc293amr1834521d50.49.1789479068335; Tue, 15 Sep 2026
 06:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:30:56 +0100
X-Gm-Features: AcwNN1VcHT47mpqUdKbYo6ksjx2UUKFcENSyTE-sQFRSvQFLxj56zCGvaCZldAY
Message-ID: <CAFEAcA90mCJ60BmimEYWAx9YsxGSkWU54pbq6FTOxfQ1GsqSeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] target/arm: improve Armv6-M support
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 20:23, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> This RFC series refines the Armv6-M support in QEMU by correcting NVIC
> limits, modelling the optional Cortex-M0+ privilege extension,
> tightening MPU register access, fixing MPU region size checks, masking
> TEX bits for Armv6-M, and reusing QEMU's existing PMSAv7 implementation
> for the compatible v6-M MPU.

> Gilles Grimaud (6):
>   target/arm: enforce Armv6-M NVIC limits
>   target/arm: model Cortex-M0+ privilege extension
>   target/arm: MPU - limit regs RBAR/RASR A1-A3 to Main Extension
>   target/arm: MPU_RASR: mask TEX bits for Armv6-M
>   target/arm: fix MPU SIZE min for v6-M/v7-M/v7-R
>   target/arm: extend PMSAv7 support to v6-M CPUs

I had some comments on patch 2, but patches 1 and 3-6 are
fine and 3-6 don't depend on patch 2, so I've taken 1, 3-6
into target-arm.next. I plan to do a pullreq later today
so those should appear upstream soon.

thanks
-- PMM

