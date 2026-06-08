Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B23ACD8CA8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZWu-0001OL-Tq; Mon, 08 Jun 2026 08:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZWt-0001O3-1C
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:56:35 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZWr-0001nC-G7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:56:34 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7e8833c99fcso48353257b3.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 05:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923392; cv=none;
 d=google.com; s=arc-20240605;
 b=EAI75VtDCEZCESS0z8i3tIPjgu39/rFxRHvrQWk7aSqgcuEvm6UmSXIMn/1L3WA3Cc
 2B5yqsIV4JHHQp5v2r2tKJHPSjnkBw/eChGlWcxnhR7aRSelVUwxSqZpG31mzxhQHlKI
 QcnS5XfisEU1bIK//Gc6LfXwMn8OCnZ7FTOrGOUa1NFLiyO18/vG1bGwTGVywZgm+nhP
 EIdnA6k2nRrbnHwuivnFm7kPJN1DEDIzatkFdM7Kh7THn4gLzRkrzSyIZNrang911ajv
 bseaRMvHIpdKjW/3TclCMzIBXRTwMP3uTWzxXQrgyfQDZToDy5Gcp6W2MtlmPxgzlZEa
 F+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1vhrGzGthU5Lx6YRYT4B5rIyCbSWWkxMyl9+Cf6n308=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=jzDUyXHGsQCXfC5cOOqUKZNmd16g5DPQgN8xPE+wyXBEqn6Kt/yX4yN4MrLJaVOLPF
 09N+BYX2q+rIbfwP/elflpOI9pr97E9E1gq3UP567hwLDqGO7u03efHnN1t8CjIgm1/N
 osIsrkdnmpDFSoP8aqBLtNBoatb8i9/BUQomh9slLBQKrv78TVkw1A13ZK4qN5oaheiF
 jJMikVgYCSv31tbrTHsjgeIbQCy4kZU8aHMenwc5gH2Ac5hshxyhbseHcXUOVcT8imS2
 OT9DkPm3eyolN7fZ1UlUswsU0v1DLbvZk/vc5BLx/BYEYjVMK5c5+Oz/a+o3tPviItx6
 NqeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780923392; x=1781528192; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1vhrGzGthU5Lx6YRYT4B5rIyCbSWWkxMyl9+Cf6n308=;
 b=HFOwcIdk1osylyJIpykXGQeqaZzh04LTCCVZQnw1T2J6Ry8UkA2USWVRwZaAxZfKSj
 esTS+PRz80vUlBoCPbTuXLj7QU8fxvSHZAgDZCxfVgqco4DnGODSqKnyQ6EqW0G1IHCj
 oHKf6AGp62aHUH4rVrJ4xoBYcxoPdeBJhBvwPGB3crfBIC5u8cS5Qv3L1vOeY4doaV8b
 WMDUuzCXcHw2UlLASPZqJm6+Jc//cKMLOJi0xQXtW6AE+TNmeFb4GMMy7poT9YjEDw3w
 FA3iG2SgeNxW8qLpeammh9WMN1aNkiAKoyx8+lYOhZEVfTbt3vSqUhyxiN/zgQxfJENh
 pimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923392; x=1781528192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vhrGzGthU5Lx6YRYT4B5rIyCbSWWkxMyl9+Cf6n308=;
 b=g0MdxPiRAhEhMyyPOEoAoVxmfNcDUSmo/PYkrwHJzy0/BH1FfEWt3ZETBXaDHiXkYy
 Yf0zjXL0hd6Fbd6hyMKixGwefXYQgAbs7gPirx5bWmZsvBgvjRJTpD4gvxQHsdIvBLGZ
 f0ZQZCmAEooYOA4Wz/g6qin/UUl/UxqveSLNgqSaGh0rN2NsjdbfgOiP6CfixjkmPO1W
 xn8zOw7SLCymiVWY1MIraTnd2o8gitaYk4ZJEZK/COb64bU1HwXW74H7GEEtLAOzunFY
 ZWV0HE1QXW/uzI9DVCcsLYlwjse592bx6o22p6qJOKfUKUB/HfhufQj4VVa2VYi5y+9O
 RQKw==
X-Gm-Message-State: AOJu0YwOO7kUPHi3p7XyzrS2vj6R1PFlomxD28bla+W0w/UzmKQwxVg/
 7PSPPGdvq5VINPbvfbaW2f1ekaaJRhOxVScV4nHPRsgHEECr6tK2acUEtVLRid0CUaskp/ETuuV
 L6UCG1uXVQ35SI954DDp8YBpGTbz2/Vemmk5QASNj7g==
X-Gm-Gg: Acq92OEo3Fd+Np1eJvur3Eme7Wv/xs/ZBI1aGN26pEgrKJnu7zX+I1AGoWCWCYpFxSS
 mpdmpjlM5R2qtW3LkD1zglNHF2Ex/BTDTM0eZz3nGsFockG5sPN+btP33Hs46HLwUysM02/1IV7
 prE4FAQXDRdBR1cXbvJIWP2LR+hRi0QxwWpAUkzbv08+ayyBo+mIxfhZSGFRYoKVLNwcc1fYzqc
 MgTSV4xTS/Ibsky3Hzi15WZEjLq6qxb0kd4SUdeLIeaAv+rCgjnsczadOQSCtbRZxhYqR7zavme
 izfyvih/pQQL5hpThUeVXXGK/CODkd1e3Lismb3OPjZNAE6pU8NYzksoIc+GF47EObHuQQo3v1y
 Dfw==
X-Received: by 2002:a05:690e:1242:b0:660:74f5:7e19 with SMTP id
 956f58d0204a3-66106942890mr12396289d50.0.1780923392126; Mon, 08 Jun 2026
 05:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
 <CA+1f7BA1Xbmb5atHKfFpd5K5VoXKo1zCmf4M6cH+PkQPifPXug@mail.gmail.com>
In-Reply-To: <CA+1f7BA1Xbmb5atHKfFpd5K5VoXKo1zCmf4M6cH+PkQPifPXug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 13:56:20 +0100
X-Gm-Features: AVVi8CeBYvBKB9VZHrRfLfdZelVZKRuYZh99KN4ozy3VDz6vNq6ZdcVdhwqeS8c
Message-ID: <CAFEAcA814k29Gf2Zm=exmPfO_2cdAmKGKvUOUJmnLe8JYdy04A@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] target/arm: add support for MTE4
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 4 Jun 2026 at 08:28, Gabriel Brookman <brookmangabriel@gmail.com> wrote:
>
> Hello all,
>
> Friendly ping: I have an external deadline this Sunday, so if anything
> needs to be addressed on my end I'd want to know soon.
>
> (Re Peter's mte-10 segfault: like Richard, I can't reproduce it, but I
> am happy to dig in if Peter can share a way to reproduce it.)

I can't reproduce it now either -- I suspect something went wrong with
my local rebase of your v6 patchset.

Applied to target-arm.next, thanks.

-- PMM

