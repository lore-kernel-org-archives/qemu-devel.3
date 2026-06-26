Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EADCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2gH-0008ND-8s; Fri, 26 Jun 2026 05:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2gG-0008MR-00
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:17:00 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2gE-0004vA-Le
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:16:59 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664346e66daso728923d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465417; cv=none;
 d=google.com; s=arc-20260327;
 b=VL7qcD9rpLm+vs5r4ryOrOomlhu++rYbR/SO1DVdmWxxrsgYSvCNtDRMCW2yfJOqwq
 YhoYpcDJfi6VCx1JXhXwFQcucJh4jJJZ58KD/a9mR0Fpi6o6K+4TtRc6Yt2zbv/CKuWP
 wW3NXf0l0xda89h2TC07eAwMBmHWxVBbgqwp741Gmz0LSKlIzZ9GMp6Cd0i+deJFO0fB
 YfDgjU3Mtqr6Vt17x3THLkb+UXOxUC765AerIsGMtkWrQOwfCijxwl6WTirs9BWmYDpv
 8aihhSauodjub+TAHyOCn4WKG1dfDhhebcN6j4wtH1t/YrXhFQCaG/imQ4JAQQ9kaA3i
 T1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qgUA+fLbwrvGdpgTE+LuerIpJ7kwSME7ZYbWBSky9zk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Q1K3vRsxL1O7PIj2QVz/X1H00agPtnfnVlUPkkg77o76FcV5X9m/QeZwRGFg+Q0rij
 zojVpjJOuDFXZdxlpxyfJKTif/VRbGd3pILrPagrmm1VybfOitb7hN1qDa+UxYNnu5Pe
 coYh6BgWp9E+bR54AG0vkzvADdwu94Ht0INVztDy3siulfKJM0rkDQS6mXzYdrm2EVN4
 h9VdvzQst84JuAlLuW9yO9NVh+BMwxhd9L9T4VR+HsHnZVWm7yNUQK6pXZplAUQuxHgC
 8YEIuYRwZcqDFmzNBV+wZjwuvJ2SjFF0e6t3p+A88dN9BG4DedTPltMJexYbwotb1kCH
 Rlow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782465417; x=1783070217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qgUA+fLbwrvGdpgTE+LuerIpJ7kwSME7ZYbWBSky9zk=;
 b=GlUQqyPd5cbLPUU3/mHypwWFbspFf0xk9i+F6A3aOolJ6cm5E5YnEL3K8KUoLa45wl
 uLXDZbMc5o+XiXQ3LWKIf2rdzhNjSE348qFpAJE6HjgqwttS2Tf/WD1Qnw+IBK1Rzmi5
 mQGIMVb64mxgeBEYom5bk1c4Iv37ncIZn5+qO+2s4vI2TAfUzU7YBx/r6qRmd2iYeK+2
 /Pj5CB0qUxNWbxexdOjrUt2ZDbwynSPRWXAF4tlZsJd6Myhh5+3KnkvR44jpgg4ZfyMt
 AGo+bW31z/kYo6YLpO1r9GrGcG0Yeu0TJ41LXIJ30VenST7WWDJJ+p9SEV9rpKuVT+5P
 dh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465417; x=1783070217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgUA+fLbwrvGdpgTE+LuerIpJ7kwSME7ZYbWBSky9zk=;
 b=tQDidkuLO+z5vH9PJhRaA7YaMSP5yvgteAFYVH1gyHzbXji7O9rwclfG4rYxjw2yWJ
 meT3sqiKhfI6gdOGEFHlJIKGcZy8Po3wpYmpCHq5m6jaNzFkG303DyraCEb6KEFa0tTG
 uVfxNQFpEj6icVL8g3wcdWzi/5pVwcuFzxR3ZYdkxG+HhY4Bbs4UFwD+hZtM+Gv0JgKO
 qrc/Hhb7lRdqvNKNAc/YSWiw7ZrPSIEHriE9Q/rTHOJPMlbmKUJnkP5YqezjwgznLhKd
 vq4ikR3ukym21YMMcjYCWcBK4NeCtm1OZPxY7Ah+PYws6QWeLCkYIMy9ap9Ls3o7dQSm
 6TSA==
X-Gm-Message-State: AOJu0YyMj3US3EVtPeWz2vgD5SjQbsFkZZ9YSpGT/2cNP3CswVfVdmWA
 cOgSjKd6AGGiqZerCWslmniQSALpUtOSCeVyjeIq6kmHl1vsmzyzA6ZOdkp41XM7c0vlStLdE6O
 iAgIYw4CtAbOI8eok7wjY0zqMYBiYYnkx5viQdKvHKg==
X-Gm-Gg: AfdE7cmCHk0OSIwa92hhxzB87lcg+BR2tJLvK+O43mYo6F1AdkEhbBfC0SQZh3iqSv2
 m3CVzBycNhIhbbeAc8z8v/3KVnyCzLoESXYM+thZrnUasMtC7jEtK3jh1QmJVl4pnQv7E1u12KY
 INfOb9usyVBmshJC06b1Y4zOKLEQoNJwPvToQPPq6KawdQSEDZO+jqk2HnTyVh1dCDtnLL+PiKz
 JsXBmV3KR/p9SGm4pUw8r9wb3hOwqm3xBCZXWVgCDj5BFf0VlmmGFQSCiYGmEhKeE7PRBEU4Ybj
 4KBa/l4+dl78hauU4JXnzCqYMQ7Rqs+3c6wdG6P/zJVu8CyH36xWF3Eg
X-Received: by 2002:a05:690e:4402:b0:661:1307:3d4f with SMTP id
 956f58d0204a3-66487e76b6fmr4179891d50.46.1782465417141; Fri, 26 Jun 2026
 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-7-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:16:44 +0100
X-Gm-Features: AVVi8Ccz1jmZmv2-i1w_ZbJiDZUPKVAMZGYNrOYBFZ5Xjc5dJy7X1F_ljkq6NwQ
Message-ID: <CAFEAcA9mqb_=YnnAoFMhOtj+N5_YmO6YMgtQrHoSzLTBpNac4A@mail.gmail.com>
Subject: Re: [PATCH 06/10] target/arm: Implement DOT (multiple and indexed,
 FP8 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Patch subject should be FDOT, not DOT. Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

