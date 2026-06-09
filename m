Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D212ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz0h-0004wo-Bp; Tue, 09 Jun 2026 12:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz0f-0004w3-D0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:09:01 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz0d-00057r-OX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:09:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bec3ffb95dbso941585766b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021338; cv=none;
 d=google.com; s=arc-20240605;
 b=iHYvKHfkg78eiaPQy/X1ijWJzqBaUWyrTqP7tULmIuT2hfVwrziWbpPLEepLrJZC8V
 F2jrx52PJ5neJhIK4/KSspGm1WPMupB25NNfOvpd/ADtOX3YDG9/xbHCQGwyu1Uv/FBs
 JMAgzRVA5ClU6l3c0nAmRN7Sa1nYAN+z0AB6PVvECE2QxT0vGrOOsLcKJ/ERpwkig4+n
 q3sCtiztuPXSPnFDjIDG5JJpFlQ2ToO+ifqL7d2fKER+Q2Oo6NCGnUStK+1kxT6aKO9e
 yiFCpkczX36Da/eU0IcM5k6sJuyh4tznASbrT6d8PH9a1TaFGDYdKSzMMe65y8I7T986
 bDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PbmVMlBTI1D89FAE/1WRXmY+YS4Lim1UF2iTW3DOm/k=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Q62xLGBoFeOeBBBC5R+74eTG8UC3dI/8CE3kOhnKA+LemEKx+cF5rvOwgMIJTwpPff
 BsAIwXywIkHWxmKm7kqjPk20QYBf0mwTFAxGaw+zSW8nOrf6uJzS3U+TCAO1doAf73un
 xVZyh3icvWe7uyxWcS1eyT9kEG4v/22JRnsiyuxcrJaxurGEVWQnhG7yuyFcko3Vs1EO
 ouHqkoMI3LgbC881kArfzxy04/RTTSYzcdyKgimWuQq6eINxkobqHkW5bs7g4UdnVXpG
 Fkoncm/ihk2znU8PojfOmmkVFRQU9NFMiOjb+eeoymVMLUGuFX+gwg6mIuTudh9OIiWK
 /1Gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021338; x=1781626138; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PbmVMlBTI1D89FAE/1WRXmY+YS4Lim1UF2iTW3DOm/k=;
 b=YDQx2SPC4RJnFlQetEIGsw9XTghnt5HCHJdHH0Oc1W6iffsi6BMnt8YZYYfugcYTJR
 GrjYeXoMplVrhWm5VxBmq3qF1SOQJrVFPtiXpHMtI4ZYqhn0087SwBEJF8gy5eSGgc6Q
 u23WXPWS4e8JLHOiUY84sPI6HCnqzK4qZGT1VfjH0QYR++Pg79OwR90HGfj6RvC2ITaM
 v4zAOA6UjecK+F5AsYxPpISxqzzhzMET/bSyqdaCTEEHYighQaki5s8vo8jLbAKcwQ3N
 h5GwY0eQLFC7dPWSkPBX4FCPFiolGTrKLu+bUJqowoFUePKRC9K0m+wwGbcgNG0h1Are
 peYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021338; x=1781626138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbmVMlBTI1D89FAE/1WRXmY+YS4Lim1UF2iTW3DOm/k=;
 b=eKTs4gj3SxwTTkLCoQ+w8CMUzCsm6Mk4KWYddVcAQIA2VrABwZ5JzI/NMIv5bCwXNo
 QSBwHa29pv9/clyhGroqaOVGQA7Np0ICmv+OqkDIJlnIRoR9wMBSdjMnigvvEUeuoWUo
 tthfAyUFyqIeLYiHXNCCDh1PM8SLxf0Hiwius20TNWMIsfFBFChU2eNgTWlsXy6os/OA
 oWTiI0IheEXs4Po8Toz82CBml30CEbuU97TRIFeuhJSQA7mmTTwEI5UGr2VzjiIit/0p
 wmd21e6dlQgwYG73C9gYyabR2rPI3fsCOhLoFAIrntl29X6Fu4OlUqyJJ1QSS5IVCiO7
 mwtA==
X-Gm-Message-State: AOJu0Yy0iJl34eLyqaS/OFGxN3snu20MJh0uFkRfbiyax2vc8Ahfs2cS
 8bNW9zqe8UU+NqJAhCp3gBHZMs46429WZuLiIgR3EVoeEWu2eSkXdvyO3oY5R9iBoJJJ982vdp1
 229ydUiH1KAzVfp2jLrib2UcBqtYOwt1T5qETMYDDGw==
X-Gm-Gg: Acq92OFyTkA+sBah9oBiWZKXc0uIY1ZJeKEo3bELvrqwtWgL8CSk751dCL/HSVUfI4g
 hia1Fs5ugEhY26b/AGyVylRe4lHjPHkbnGgobC12G4yc3/8xQ8mgIe1qIBgnC6reeqcZwlJCPVH
 2QDnWkqwM5iPY6eD3PTogt2/FYix08R87rJY/p7tbLYLkDs3nlfZgPbpjPKuRXcMGU7kIE+l40j
 FvOKBgfQmCX7KBZLHQwzSxt+JQ9dpCR0XxcN59vdOTXXaNyx7pcFy/5VDoX05nlOPq6c6vjIju/
 geMKd3A9Ps9TAxeuzKRlvlKRSiVPgqGbRXZYNfJwkiPY7D43nkrcQOckcWTB4lwQWpseytl9gWr
 maw==
X-Received: by 2002:a17:907:98c:b0:bdc:9d94:3257 with SMTP id
 a640c23a62f3a-bf37086d218mr1156582266b.14.1781021337849; Tue, 09 Jun 2026
 09:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-32-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:08:44 +0100
X-Gm-Features: AVVi8CfNGi9WeMNwcHz9j9Vvj8wJSjCU6dlDLSe8Jr9M-q9whZH2BghVviLVve8
Message-ID: <CAFEAcA--Pfh0AB1TLGXZzqpqB4jSQyNYM3GuwCLk-XJdBT1DPg@mail.gmail.com>
Subject: Re: [PATCH v9 31/45] target/arm: Implement FMLALL{BB, BT, TB,
 TT} for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, 3 Jun 2026 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

