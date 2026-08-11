Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C3C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjgH-0007ny-PE; Tue, 11 Aug 2026 06:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjgF-0007mv-Rs
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:25:59 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjgE-00059D-9J
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:25:59 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-80bb41f7f3cso30325467b3.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443956; cv=none;
 d=google.com; s=arc-20260327;
 b=OUVAq3PWWJnN26tdh9DNGbfdRTKkp56rSnnhNwGhDouikmoi0Z0if8WFcTBeI+FSBi
 B6PzBUjr9QPxmXFKxTpPqSEKnKZPPXDy1TdHtdTdo6HcDM6yhtdsMviO5AEkLmpysxxL
 iAhXFERqoBvVWGAKD140rEQmJf+7iJNMb0tJgh/AFyT4PGf5CsXrTVUdkvjb21eAsW2y
 XeJ484qtWTR9ceUJPXIuwBHiJEIyajsfSLtixA/L6KJklWE/9f50xiSdcWrwPvT+r//H
 Q1SJSy5bv/00XEIB6JE+9t6Y3CvfLbi6GXsQH5/4WzkiqQs09HJ8nyTLn2e8z6DFI/VF
 jE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8rV/GeOFwghZ/mUDsgrUlESp+c74JXJ5GiSeMNO9mnk=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=HVRO8dJBeQUu8shTREsAqgdAZ2rWKd66npc7NNDIthvqYPhaJsb3Bs8r/Sc1B2fxKN
 1AXAo7IuaP5Ka05VHAh9L8dsIiW2Scz1Yv1NiJ0crIJdXeJE5r/i7whgQ7yyGLpFg55M
 xREzedMJrqieag310ZlkvZGBk4M2co1Mi43orgCjc2pAAQ4aH+QM0ytktOm1U9UtzpnU
 kSoWymTstAsCwM1pnsmL5qoTj+DRt5UE8lcrsjDMiuLP3db5nnd7D4jQVg/OyiO+Mmfk
 EBHvB9jPsOYvagP77m3uv+uIfd86hus+ZYstHzeylYrYnvdCqmrMMpPRAJPRkN+P+c4B
 Fnag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786443956; x=1787048756; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8rV/GeOFwghZ/mUDsgrUlESp+c74JXJ5GiSeMNO9mnk=;
 b=FleMbhmRmcfQyCQhg+2sh5gHMNAJwoy4dTIPQ2EjVAbl34W2Ljjb3W++6LAeK1ShH9
 HTab8ck6vs9gp6fsyXWUfR/jUrf7GpMrLeWsri21EwyZg6bXEAzLoxqeotlO/xwTTNFV
 8tOFnGPoaJIuiLtqcdR0NQ+10kb0ynk1z0UBbEOkoSOtmWXtS0SAlZR16Vo18YteoOxp
 TlYY9G1nQM7i3jO7A/Q+J76YFLBKhtiUt8HpBfUR2zw2gMIa84aXjU1Iclj8dPzJjzav
 HHqMrQYIZi3Xw00FC7bySRBQ/9MowLsf2le3BzEkCwtatPslk9HcqlqHx2JFlqwvIZRi
 WRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443956; x=1787048756;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8rV/GeOFwghZ/mUDsgrUlESp+c74JXJ5GiSeMNO9mnk=;
 b=ZQPm836lPZPO7D0ZJ+2x4s18yI+rpj0K51FHC/I9WQNHbjSE8L0S5P4KntR3+wSbtg
 NRUU2VrCfUNtvTNWnHXEVadj5xw702ewx50X6QNqfX4+fC2fvQF7U5Vnpo/Y2IfqruwR
 rLOk4/XHjpT9QM7tgg4CzNQbqxCm4gedPFQ3jokKJLg8VSR6iQKahkWsEBMBvadU5X3g
 C/d6ReDRgw83oPQPIlKdR9G2QIToJIJPXiEmQwdhDC8fE42mMdWvvmGakphxiEoxQff3
 KeXpXA13pd9MpTVig+a62kbQTiDJ7WeqyQ54HTie1KeBztSBFzV/NN/Pf7Hcl5ulIYlw
 51jg==
X-Gm-Message-State: AOJu0Ywjx+LJdK8pFhY+LhnDjf/WrYW/KkRKFlHrvvd45e+6BTjfnMjn
 0X03CbsfHqF1lEqj/jE24U4UQsxUlwGrpYISGFHno8x7YzwUKx4+MhyQGU4btScw5Sfl2VLtJyd
 GV/dby4YPEaZTdpXezYz7c1JQl3Q0AuFJHqpkySwsNg==
X-Gm-Gg: AR+sD11s+j4I5sl+DtGWjYXeZe65g2NeFHbxGWRRsYkbwtVx6y0A7dqCWFQFoSeJUjN
 6VagwI1tDbRGapuSZ8x2QUI4bJJtEEa+rroDEGwnODPA0y420LYcxo/rBO3P/C7DqASYexHly6t
 YmugrDAfv8AOEKyxjQbkpmY30QX8rTsu+V9PL0PPyd9iVrSuSjEjydhQcQ6bK+s0yRqE2sYUMYf
 gRsewpODorU4Bh+Gpq9gTs5ELlxJrH0oST/bEiLBZNXTm6ak9ATYyRwPf9nx+vZ82iT/7ghpz/P
 FkGj/TIScBDFhgyjQ7bFoo6vIaxxc6L36TJ/ngARLExPwrT0fc71wnLY4XmnmC4XRRoKBaMa4kj
 coU1O4+DhXk3YW/tbhYEVcwtSYiW3
X-Received: by 2002:a05:690c:884:b0:81e:a471:e893 with SMTP id
 00721157ae682-82f2db9e0a9mr12285277b3.24.1786443956435; Tue, 11 Aug 2026
 03:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
 <20260805191257.11303-2-simonxhy0404@gmail.com>
In-Reply-To: <20260805191257.11303-2-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:25:45 +0100
X-Gm-Features: AUfX_myYkigxjIB_8Lvn1mcxJVf6NXjm02vswH1uexxDSD5Q-DONFEK_xOD4V4o
Message-ID: <CAFEAcA-myBo1Oa7US8FoKMNVeVdE4o0FjMkho8vTRmVu_TULOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/arm/armsse.c: fix SSE-300 s32kwatchdog address
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 5 Aug 2026 at 20:12, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> The SSE-300 SLOWCLK Secure Watchdog Timer is only defined at address
> 0x5802e000 in the secure region.
> Page 45 of the SSE-300 TRM specifies that "the watchdog is Secure
> access only".
>
> SSE-300 TRM: https://support.arm.com/documentation/101773/latest/
>
> Fixes: 8901bb414a24 ("hw/arm/armsse: Add SSE-300 support")
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
>  hw/arm/armsse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

