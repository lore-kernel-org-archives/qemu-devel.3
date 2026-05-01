Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FBBCD3425
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 13:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIntB-0005Rc-Ka; Fri, 01 May 2026 09:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIntA-0005R8-1R
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:26:40 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wInt8-00026o-D8
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:26:39 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c305f381eso667213d50.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 06:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777641997; cv=none;
 d=google.com; s=arc-20240605;
 b=DWgJGDDPQT9DAxukTARk0uhrnfXtsVKjtUgEyBmef8sULtYdk6bAWyPcNsonazkmmo
 ykr2kCExPLc7MV3NVYqWFVCjC9H4qncN5SCLPL0CbsYwRVlGBclBpJpEZGymOhf/811B
 Pe6h7OHfIHluLBSTlJCiBacTYe/92hSLhQNN6UDCPHomQZjhEkTkNR0tJvQgDuwFCXVG
 I8qjv3v0xn31Hae/elyF44fujmDUbyn2Iz0OgualwgXkFZ+ouMuUTHibt2ol3DUA+nIa
 oVfmHIZgfjoPwVc+KD+s8m4PTvD2Yb3+eMpz6aZJuE8xsZdX1hJUUBvDKWXYR9jeaZam
 TaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ZdKGHo6oo9Cb8ca2wioUB050Gq3EF1HvVEUamfky4FU=;
 fh=bunhSUUMZiSXnnbEKh7YVR7Rj//jW4IA+hi+BYMiG3w=;
 b=C5pmC0Z/CF2j3w76ruN9CUalE9imgFISPpe+O/98PMBgwhUmXNySFVJO/sIzK/wa9x
 V7DAYlt+8RcjzNj35IIwk/f4McYO2BWRqdoW/0KX614fw/3hawAtVTs8RAMvp469d0xP
 0BVFaf33hJ5zyhAdRCdxFVMZ91VFYVSU5Wp7pDWw6pDfUCn+kQzxkiaVF8HYoRfdMqPA
 aNgKWq85eoux8LHge6DwwuKCV/+F1Q0Qnr1rs1nXdQ5bi15CqzVaZwh4aU8E98CK/0TK
 fQqyPJl0e/l04LTWyG6Ydi5MKQBA5sD3E3z0Utmu9GiBt8b6hmzv5/jS1PDD5J1eh44W
 TW6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777641997; x=1778246797; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZdKGHo6oo9Cb8ca2wioUB050Gq3EF1HvVEUamfky4FU=;
 b=J8vJeejMSlKwENsQseBwF1zfIVk/XBsnJw1WpEYaLZdiALfkXftCulKHEKF3EjTm4U
 tjKTlTh8kDq3LbfWmUgFsO5XO+HKDQC9BBgDPkBRRavwIb99kkdAMK91mdHnJxAHgwUo
 NyFEcvahOqHpj6mdoAB/xzxFSolajLULVy6d9yKDYQhrdCErLmQLxXw+KrFzOXo6QV/J
 D/uOcaQOYuX1FZl0vXWCRizyd20tnv6C4KkOG9QoGve6MKQZ4o/hYT+ZLWVCorEsdbq6
 Z6ahFLYhwFDOg4io6HzjFZDhuR2gMcrIH9k6zOn/qrgdpQIfX92Kxisk5/xACtyO/7EK
 tgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777641997; x=1778246797;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdKGHo6oo9Cb8ca2wioUB050Gq3EF1HvVEUamfky4FU=;
 b=HZycy+PY2aK+G9frjHcAFN4FdOavzKQVi8rcm6kHcn+vmjs/AFuExBBZKaxWgdvEil
 /2x1rKqgH1MpMxTewMaT3DTVsK6ALbqEXGW2/jnngMml5NNEh/bgPDJqmGGkvVBk6iCr
 pCYWHwxKkUWrShauYuL/Y7PWPT4tf0USizPgrwiZr5UM8/kkze7f7ORh8SzwD9aS5Wut
 DJsJPwN9chakoSCeApk2wombbFJlrxdofwz1wSUVVaHRMa/kqsQ444flFM0ChYGLie+6
 pqw3BdTpem+E3Z2SeXO6bPCeE9we0vKez8roU4GrojnX0kUbecPs9LhZ9cO3Kdc7FXDc
 bK1Q==
X-Gm-Message-State: AOJu0YyTPFjOX4RYWR0Wy8Ix6wEk+e4KAO0ZzyAO6RltVXKQv/Rv3He/
 47QD4P8FlLKKZukFy1PH1Br4MtiHI4UFuHQM1HTFsWVzxL5cIzrgJbWeg2noNwIpEM86iROObfF
 R9IWUvqkQX9xBy5dTRc/3M7dkYfSLxulr7Kta7m88R6wQVvBUNJH6NYk=
X-Gm-Gg: AeBDieuoOpBFDHbrYtDQUZ5UudPsayC/buBq3AsdwGH9XLPzxXePDZFDtq6rxcu+jPf
 c12Nmxe4w5KRs/YutUM1VtbvNtqjgYCU/AOnc/q8yJUoXJm3JNP7V1fI8PgrqYXBETkSodddINa
 +TZ6FYOMpb81ji7vvFXGORZCpLHtGtYRZVIG/QcXpFvwpPsEr6i/dbN5fPV+R6DhlrmDizwvfXA
 Aibzw1eg0dXMsNP1Plq745dPCrvQg8gCQhK/gJi8T/r+f0ozKEtGI3uKynoPskk1FxK/UT8+Eb6
 9ho7yfhF1rBn2E0eWNOtzlDmUsy/5xth2/cb1KiHlJeQkuCJM9fTkr5KFSdhykazSVooYovd7ga
 6HA==
X-Received: by 2002:a05:690e:4259:b0:650:3064:4cf2 with SMTP id
 956f58d0204a3-65c18aee941mr4704287d50.5.1777641996611; Fri, 01 May 2026
 06:26:36 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 14:26:25 +0100
X-Gm-Features: AVHnY4JGIrrdf9PSbpR1pXeS2eLOJL7gDMGm71m8-KeQxSXmtU5YSrFg4qAJ9P0
Message-ID: <CAFEAcA-WB+vfiHZpPut=AdEOCXacsTfrvxiGAmhaGH1abHD8ag@mail.gmail.com>
Subject: Future of target/arm "max" CPU type
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

This is something we've discussed before. I don't think I have a very
solid grip on it and I suspect I may be missing some parts of the
"problem description" (i.e. what are we trying to achieve) and perhaps
some implications of the choice. Overall it feels to me like a "no
obviously correct answer, make a tradeoff" question. I've written this
up to try to clarify my thinking and canvass for opinions and for
people to point out what I'm missing.

For a long time now the arm targets have defined a "max" CPU type
whose definition is roughly "all the features that QEMU
implements". This is helpful for:

 - giving us a way to provide newly emulated CPU features to users
   without having to define a specific named CPU type matching some
   hardware that implements the feature (which might not exist at the
   point we add the emulation, or which might also need some other
   features we don't yet support)
 - giving users a way to say "I just want everything"

Mostly this has worked pretty well, I think. (It can cause problems
for some workloads that break when a new feature is added; TF-A
firmware seems particularly prone to this.)

However, it doesn't work so well if the architecture decides to drop a
feature and mandate that newer implementations may not implement
it. Up til now that hasn't been a big deal, as only a few very niche
items (like FEAT_DoubleLock, an old mechanism for quiescing external
debug before a CPU power-down) have ever been removed.

With the Armv9.0 architecture, a big feature gets removed: support for
running in 32-bit mode at anything above userspace (EL1, EL2, EL3) is
not allowed to be implemented.  We've got away so far with ignoring
that requirement, but as new v9.x features are added, they are
designed under the assumption that there is no 32-bit system mode
code. For instance, the GICv5 CPU interface defines only 64-bit system
registers, and our non-compliant "32-bit is actually there"
implementation would give you a 32-bit OS that couldn't handle
interrupts. Other similar (or harder to spot) issues are likely to
also turn up.

So my suggestion is that we should have two new CPU types:

 v8-max : "all the features we implement that are valid
   for the v8.x architecture"
 v9-max : "all the features we implement that are valid
   for the v9.x architecture"

v9-max would not implement AArch32 EL1/2/3; v8-max wouldn't implement
any feature the architecture says is v9-or-later.

For the existing 'max' CPU:
 - on qemu-system-arm this would be a synonym for v8-max
   (since it must be 32-bit)
 - on qemu-aarch64 and qemu-system-aarch64 this would be a synonym
   for v9-max
 - on qemu-arm it can also be v9-max, since v9 doesn't drop 32-bit
   usermode support. (Though we don't currently implement qemu-arm
   max this way, so it might end up being effectively v8-max until
   we get round to implementing support for selecting AArch64 CPUs in
   qemu-arm.)

I don't think it's worth claiming 'max' as deprecated and dropping it:
as an alias it's trivial to support, and there are a lot of workloads
that won't ever notice this change.

It's possible some workloads currently using "max" will need to switch
to 'v8-max", but I think this will be rare: it would have to be
emulation of an EL2 guest which is itself 64-bit but which runs some
inner-guest VM within itself that is 32-bit. The failure mode will be
that the (outer) guest will report that it can't run a 32-bit (inner)
guest (in whatever way that hypervisor reports that kind of error).

So that's my sketch of a proposal -- what do people think? What
have I forgotten about?

thanks
-- PMM

