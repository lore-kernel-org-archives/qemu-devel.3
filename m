Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F1BCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2te-0003ni-Of; Tue, 23 Jun 2026 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wc2td-0003nT-RC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:18:42 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wc2tc-0001p8-BP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:18:41 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662e7fed068so2906442d50.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227919; cv=none;
 d=google.com; s=arc-20240605;
 b=fJpPLBowQ5Huq9g81Q6AGNx/geXq1Ek+UiEhnAQpzPmVWZZq6Gbopbxt/vah1dos0f
 kQvJHrREMiTFJw4bBrao4g/EM6sc0TqbISS7U0gKF8ILQYqJq897Q7ay3zRFL2Cfunhb
 v2dnk+qRKZBe5V2ZV7mcRdNcK/7NXgii+5Cwh+VISdt5vrPsjtEXl6gpGPAsarcDFdLd
 O5BnIMXU887olOc2LlpII7Atn8IwV1yv2WGRbtSxHSr60EwHizaM6GJa+c2pFf0LHF3/
 OBTELq2O5ACE+Famo67COYhH5TDY1Tc3TgIPJ+JkG9PY/pSzGJqR8gTfVNzQuvTyUzkd
 C+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1HikhzCygbcSREMbSxKDYoUjkFnj0CYVYDR0dfelPlI=;
 fh=OGCmJLUP0SDa9Ex01DM5bZ6kIElysIl2mTkIXt0Fcs0=;
 b=lBZRKfBOAAnoGeNhiynxuolMwDYSM4dNSHOAZSm7q5WtSoUTtW8BtckcpIdBhSEUbi
 3+Ez9+0yEmtUbiF8Y42yXNNoKsoZMKg9dCa+YgefNpGTuYbDZL+qsZPlI1jEc6FFfhPf
 ZZZU/pTIPHtsgp4wgnztgEMYlsEGlH+Yqa9zjziTJcrEfN1vmCz1Vgz+iDzhKsK08kOg
 nbdUlvuwBjrEhh/aYmlQahwAT7LllAmpqi1bvYRvT92tVpB4nDhbx69Nbp6Qp6Z//sZ2
 lHw0bz3GWUqPlbAt2R1sKwFT1zVxTgsB9U4Wsj9eMcxAIvabGojL4ZZtriv2FMmkCUjx
 DURQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782227919; x=1782832719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HikhzCygbcSREMbSxKDYoUjkFnj0CYVYDR0dfelPlI=;
 b=wb+GuBjhy59gGxleYleuBzzwTAchkfENSv6Ou64zouSkpaLDCCpbtbv6MZ0+Y/6Gm+
 h93pPpWnU287xyJiMilAzClTiMeuPz4GHj0/hvCxyJjH/e6Qlwkm+AT1VZXC+P33Z6YE
 DwA8ir6W73j3+yLjIeHz9LwZYs2TeHDqZ+zwUq8xGaQGf7ZhkwJyVog/KSdBoCaE7/tE
 fkrVtx7J2B3OKyYDXaZfEtVSmHuvcUxSS927AM/9ht6ieVPb8kkb4JsppH2MmKBDGl88
 6kC+BhLky+MDFefN3bsIA3KlOc7H2eCt5GfMHpSW/0HPCKWregmXAYlLJRg3AAQc2A+v
 wTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782227919; x=1782832719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HikhzCygbcSREMbSxKDYoUjkFnj0CYVYDR0dfelPlI=;
 b=nvyJWID8O0A9mkVk2IAAaJ/e4RIqnzBatjkVyxN0NY2AZ0BqBfLSzAZAuVJPzQ361g
 SiCJPgfwE1WgBdI5CJElE/2Qt4+gJIKwyd06hpt6IbTFj4hc68B1LWhMewPK8IvAlaj0
 O/e/rDLJjx0aWJWI/RtzKF5UojKqol3wkN/IZAWaXR/cdOS9C8uJZXiM4F4GrRQuboum
 k6lsBvGQvs6Cq+D5zvWEps31wuQOoVa8qTB4Cvi3DB/PkqiwIJLEEJ1UIta+5MIllOIl
 axEyHDaLNy/EmjmhT3J/jZiW0nMdBTSbON7JgCIHK7bJ2nIG4EpJBCArr4K/GYDgb1WO
 FUqA==
X-Gm-Message-State: AOJu0Yw6U1Y589siZNlWnqsQG095//9C1ETqxnRVXmBNa3FfUfTc47oA
 7xO+X+WM4E67mLzlOGEiyWeaqn2+L5A9aGUNpRmaYCKSf5AWIUQCpaGD/YrLRifEngsm0/zDb+2
 SQYyRfRlcYGgCnfNxXKP9AJmfYb33+g19cc9KQxyHZA==
X-Gm-Gg: AfdE7cnN7sEflZDWfSD9WgviQ+9WnqNF8XPysEGCiG+LOEGN5qMPvl+Ka6fkR0KpBhy
 iMZ8fZpwb3TEzP0IzRN0pT42TAR/s5X7J1Wl0Kjt2g/ZketpPr+lMSOC7UPgIOsdF7oS+e9jyEB
 ixaOE62Pf9/xwUyatnYQLNQ7MYZo3yarx7AWVNB6DmQVF9f14+gzcx3QX+npH2jXdGylZH6GL50
 5RPYKgvSYw06KUUXLSjYQjg/cFqhFTMDbdbD8mEK0N9wnIfzi3ZepSBdA1eGbcz+gb6uRSqdjE4
 qUmR/ikoACRLjr2O689m69Dt3l4yin8V6kpLMX7dokkKFrj9T8tds1kb
X-Received: by 2002:a05:690e:128e:b0:65e:1d95:29da with SMTP id
 956f58d0204a3-6635a026a1cmr2997845d50.32.1782227918435; Tue, 23 Jun 2026
 08:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
In-Reply-To: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 16:18:26 +0100
X-Gm-Features: AVVi8Cex_iyqwGUpp_Ts8y0P6KkIZbqVIGOEv73-UmYxjupz8zTiA8P-I4SYa6U
Message-ID: <CAFEAcA_4w9SHZDwptYYnfGhgpWOeynZQ43fjuvNZo0VDV3WuHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] target/arm: Add aarch64 GPC3 bypass windows
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Thu, 18 Jun 2026 at 17:33, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> Adds the GPC bypass windows defined in D9.2 of the Arm ARM. D9.8 (the
> APAS instruction) is not implemented yet.
>
> A large part of this is testing. To test GPC effectively, we need to
> check that memory accesses are causing exceptions, or not causing exceptions
> as appropriate. For some tests, boot.S is altered to record certain
> exceptions and continue executing the test. An alternative would be
> to use gdbstub to break on locations inside the vector table and continue,
> but this requires significant coordination between the C test binary and
> Python test driver, so has been avoided for now.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

