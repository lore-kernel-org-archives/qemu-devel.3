Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3954C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6c2-0008V7-FD; Fri, 26 Jun 2026 09:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6c1-0008QN-8i
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:28:53 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6bz-0004nf-Um
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:28:52 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6647bc8f900so1188150d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480531; cv=none;
 d=google.com; s=arc-20260327;
 b=BaK7vzDa1bEMG7OhNMFvwUhB4cXqYIz5f/qDr7JA36QvaqcYSi+EISbfuFQK5Boo/s
 O2P/aWAObWvf7NknTGDBB8IrxUouZ1rRDJQ7YiBCQB6v9vUhlLteP2ZgChNgFJ/LjMRK
 9zj9IzXyyT3CFKklKENMPm7wqd1LH/IMPIePy95ivtFnyXKA9hcq07m6xrgddtHH47rl
 GU8CwDJYmldheR0nJDuaPojiCyWAOM+zHu/xmkIcjGCsZyZ3iMMY2URbk/2p31QoAsvb
 lhvJTMcO0foeohMBjzZKzO1Wjen355LUvEyoW56wNpAGpudCKzhBr/YtvORpHXFH14T4
 r57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=16rcxC9eKTWRh45+UkrBUmawBkQjl/XSO1guN6LYfy8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=RaKNfSLwX/AnkPz0L65TB3Quknbmn1VjFKXHahSPJLaZnOUKnCJMeX13dnaYVERjnM
 vtTxRKls9j2ZfSL/wbe/KwnYTYQHhK4KOQzEO9r+imyp0cm7UQmHSRd5XLgD2R/gbBzp
 LHe6kc5G4xRrZA1cq+NEX1r5cJQyKJITcMg+rnOXlRCCIeD0H+5kK0t5AOwXsbxfZxz4
 gAj9FnEWLjjnhhDJm5MZQACJA4bAn2kivT8K0OowjDw/4uBMC++aw8hHieGbdM1oZ07E
 j2FpL38R3Qb2g+ksHWW+k7hpgdgHFQV+T8BcRQrIZl7lZ8tZ60aLxm4lENSZQoAr6pkr
 M5NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480531; x=1783085331; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16rcxC9eKTWRh45+UkrBUmawBkQjl/XSO1guN6LYfy8=;
 b=YBfh7mOdU+tNKvRb1ReJmIfQ3bh2pzfl27NTPB6+ke9ugjR2591IHgQe9sVo1d+qGO
 y5MG726IW8b/8r8RsQlNDLCFzl8gRf/Wd3Zg06CKQB2UEarEolJTME6C90w/IkL3dOCD
 ukZ5RQJZHQm76ivL2GpyU5T17d0tLUgxA4RhwqrNFkZAIMAU1bMv54wQNAWUh5Sq/x6l
 xMHgXmE311+ZBEecmAGyu1iBq1imGhPWnjB7ifVLkL7lkboRj7J+FXkE0MXB6YMzRiK/
 zOzTE7boN4TD4nwWuIMJ5kP+/LEEGQsfeWLBCa7AbTbrXDJ7pYjCpSfscVhnu0ooe7UK
 uAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480531; x=1783085331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16rcxC9eKTWRh45+UkrBUmawBkQjl/XSO1guN6LYfy8=;
 b=YSlLcl8g+OOEoY570QFBP1yo+eQ7/HmsNvId7alb+wK8kIIiuBmepsS34UVtOshhVu
 sW0vYyZyU2Yl3bbyhFXk0jL+ipNL1gen1l046gCP9xuPoog3Inr6WAu0euLTys5qgeeS
 tuunLx920WEqQ9voYesF08N24Pi9EfzDMN32mL4YscUq45tN0H8xRGD1bQdPQ44WQxK0
 x6PUeMPsOIakm5ICcOvg75g+BBVwvfFxgqm47lSs7Gqx8ps2fmas5ZvKefFcbUZ2zjAT
 zWanvSKR4MaALRir109cMQv3cd53sxChqJzbT8wtENYcg3dKlbZ/ibbi5EmociZbu6Lw
 uXtA==
X-Gm-Message-State: AOJu0YweD/WpPpp8qiijCznhbW6QshRxj+RG05BVwztin9Wj8abWyXGy
 r7gz3vjzwoYMEA9Ba5piBMhdU40YEExQ7kTUVA67XwfmEYY9CEM8RZhgv5s8ZugMj8nXctJdWXe
 y25+FbySw7/igfZeNifpeHTAIkL96EZ0VXulk1RhmIA==
X-Gm-Gg: AfdE7cnWYElZQRI1RpzqxoHEkfX4c1YdRy1n45pJrcL1zVRsB34lR/rp+9nn+dHzxdN
 Hv4fvvt09dvl4WN/NuunCRdsMWF8GiQR+tyH/A++xuItt0bm40KnA3/lqJ8u1c06xPp4p0ytvxc
 SaZwszlJ7oGXf+mdEmeqk78yom3gn0K8anjFp3OpoNry9WpbioFhDgixJARn39kIbFhuQY1GQv5
 sr1VpLWLegP7mbA5f/9EJeZ5ycE53anPMwRXnhoX9yp7at2CsFx6O3UjBOiuadKxOm0Bx9m34rK
 +BzRJZu4ZZKSBB+gYHcsSW91MNxJTyvEAOsjSfcwGTbVJuNAWbdv/kqE
X-Received: by 2002:a05:690e:400a:b0:662:f9a7:e4ac with SMTP id
 956f58d0204a3-66487ad3f30mr5808494d50.6.1782480530662; Fri, 26 Jun 2026
 06:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-13-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:28:38 +0100
X-Gm-Features: AVVi8CcCFu1kIVMimi3TBAK3hQB4Zg7mwVn12hs8AohEK9baX5z-cQQQqZSgHy8
Message-ID: <CAFEAcA9iTYy0BHBiMWS=isNhaS88umkELtp117FTFk8A4rN9dg@mail.gmail.com>
Subject: Re: [PATCH 12/15] target/arm: Implement UMOP4[AS] (2-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 25 Jun 2026 at 23:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

