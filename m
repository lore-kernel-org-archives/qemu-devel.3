Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EAC88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62mB-00005o-Kl; Mon, 14 Sep 2026 05:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62m1-0008Td-3d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:14:50 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62ly-0005j1-NU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:14:48 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab2029eso1530757d50.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377285; cv=none;
 d=google.com; s=arc-20260327;
 b=XA7VcTSe/aO85iEVnxryYHXmXVggdrvAcg9HnG7BqoV8Wf9NmPiWkE9WP1Mwi/B6YP
 EdY73NaTVeVURmP5v4bjfGjfSKc1/mDU2HdDBUyoayvLa0LVu+FfpaNzSmVsiOqZcy6k
 UOdwd9ibck8GHF5cUo8rAyxEaWYXfmtluTsa9dxIjP2pMIFCjV7qVVOD/+qCdG1xSwsM
 wq8uECOIeRe2WSWlxXCpe1uFObWucO99SN7JgxFUcMWHROagQO/eDpagw3zZRu3AN8HB
 /IE063TXDjZpbyA4P4tCkz82Nh9BPePeEVGytoQGUUsLaoJQnfblnSwqRL41pbseObpy
 IfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n0JaoRFooY/s4epk3+cMM8iTtFzbAc6LFJZ3j67fLc4=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=nqBocvCI8OtO+wjeY+BIY8X3EzIa/wCDB/VJu26nks204LcejM5pOAbZjoCt8oWmfs
 sV9nj4J/RKMp1kHnuCog4vsXxX5ak3Jjw4G4DFeuxxwJDc/mIsmDsBwhErTuJ+KSBN4r
 S5GU8NB0yJyHbIxiXbUwxgMKobsJS1D3UzWkCS9MwkI3Dn2nZFCZQHNuDkmKpNvP/2yl
 kr7Z+SA7jbqNVadi/4orBQofrBIwKVtDVaqnnepwzfA+KZ+clJ7Isdkve1YFnCY/FsBE
 wvWoQvJ0Jd0bEHFmxX0IPncEgbTSm4xhQitZ3yF6fRFHezpstMnWrT6XC1SAkRDOgG+/
 lTrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377285; x=1789982085; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n0JaoRFooY/s4epk3+cMM8iTtFzbAc6LFJZ3j67fLc4=;
 b=uwOovws1KPQoEdtO19n+ZuTdLhWl2qa/ibMcEjOudmfvAid97zcVUscLw77Q8kAopL
 Z9OIENr2PzyhbGcv1KiwLh8FKH4qccZ5ZcZw59Qkju1w2AB2uaet6SK3xjKUrPLaI2up
 WpH6yw1MPTL9FLlkBgjCVXF4UFRcnYZKCTzoKWfWGEvtdhS/I4x5+jaq5N503qMU2ucp
 cXByE0vAF1TLuq9Mc0xo8m2k07wNvH5J9r+sfxNwIae7gGKq/mzCw7AfKc0viHyrAomd
 +hzhyQQATYRnN2KgMk1NYqWFHEDq9URtPqcHpk5iF2VwwRrOIVZ8SVgLjOpuo3b7/8H5
 JVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377285; x=1789982085;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n0JaoRFooY/s4epk3+cMM8iTtFzbAc6LFJZ3j67fLc4=;
 b=N5w+EkxcbypJxaXoaP54femPX99BWRjqITKuKIB9KuMBUM78+I+yzt/ZpqURqDv3pj
 V27fKKklhZKkQZNREHVhMeY2aw2qxeRBIC/J1gkyk4nx+LJX2QCVlP1SRm0HDvUeLPjC
 sEj2yqkPYNWSQ6zaX7rgSz7l98aoITSaQvxdHJU9tfLdDQCa6Ifeb6c/fM2tVGIjLjzI
 v4ipPsdamw+iTgRJSq8WHbjBa6yHXKIlDz9FdEqQfIRQxwoAQBMB6pa1nQHgdiVHhC5g
 mnCc5mtGXSK80zfVZk3XlcT8X1F0FZE0ozAZQLvr93Hdgxv5Eo07jhRcpyZ9M5poZIk3
 1gCQ==
X-Gm-Message-State: AFuF++njJyhx/2Xh/U0xC9A6igp0mlgI1iHRHnWFpLEsmJWSkEtt61GT
 sqWD+seYAcayHnYs2+mtxy78hWai+xAb2NxD6qHyS50wwOJPfygqEpHtVqVX4WUfAH0Aq1y6nZH
 7VfZmzVAMGzpxlA2Ul9OEWR4fBWA+CuyI/WPjIeAHeA==
X-Gm-Gg: AYBFou15Yd+S/7ntOjkc56pT1b7KLLc2ShxCfHMeteC8tQSlN6x9AlJJ16w4Z6+YTrF
 N7qTdO8n8mvszFpdauoyiDjip8tW33PtkCqUQmvomf1OX8WY3sFfDbVftIBRtOaXxaE6zlC4H+N
 4Hp6anRcBEpVaJjvTTLZLEDtf6xs/XtzQckGp8gJGVqEsB+w2iZakzkUmC3q6bl43IZjWIplEDx
 qWLY8VIQc/DOZoGLAWrX7i+7QdqWcamzftgtAnd5xCP15Mr/t1YP4pMWTcFtrqgfStZUh02QEkd
 9Xyvj3Z0jolcEBCUvk7IvT4cOeyipC0zGrmWHMlS1zSXyFpTzDM+1w5oWkZYQAXzwGqfeoF3D4k
 BBLd0TgaYLOSHFI7WxYOQbVQhhkqtjtxRdR0GBgY=
X-Received: by 2002:a05:690e:1908:b0:671:3884:8672 with SMTP id
 956f58d0204a3-6714e1a97a8mr335203d50.82.1789377285261; Mon, 14 Sep 2026
 02:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
 <20260906222551.3712954-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260906222551.3712954-4-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:14:33 +0100
X-Gm-Features: AcwNN1U09yPIzDUP3yit4mbxWDB3hukNVFNgoQsXN-KuSonoahOpTX4J0kdBZGc
Message-ID: <CAFEAcA_VegX=QWO9GnycfVeeSsmpVd_20uGGYBJ2f_49fJT9cQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/hexagon: Fix semihosting ACCESS filename
 handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Sun, 6 Sept 2026 at 23:26, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> HEX_SYS_ACCESS wrote a NUL byte past its fixed-size filename buffer when the
> guest string filled it. Use lock_user_string() to avoid the out-of-bounds write.
>
> Fixes: 7711fdba88b ("target/hexagon: add main arch-specific semihosting operations")
> Resolves: Coverity CID 1685942
> Link: https://lore.kernel.org/all/CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com/
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

