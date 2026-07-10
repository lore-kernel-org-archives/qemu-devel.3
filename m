Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi945-0004DN-Lz; Fri, 10 Jul 2026 07:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi944-0004AP-CC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:06:40 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi942-0002z3-MA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:06:40 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-667a0f55a59so1146596d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 04:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783681597; cv=none;
 d=google.com; s=arc-20260327;
 b=LsG+hG0IKTVPEfWhRqudtX4IIyjl0Wb44iDtsqXZJEKcTlzCOs+qyjy760R+Fd126N
 VxajBsJGQbtanbBb2cyIV89FqRmko/18k6lL1Jd+pBvOWBLKbJzCyhZ66URlAa5NxgYq
 +NOY84iyyR7PtfZjDZYeBl3jdyZWdwBqTnZFjlNprsu6YAgbQHpP5wPz/YvgGHjW71bA
 yg9iTwi7k4mZ+NOEpcg+iNePYN7x4sY2BhiAehC3efvRmspna9RlnxGPYm88a7CqPozp
 RUE0kYE94WqJAl+iBkfyMowuvF2LgF8bdFCL7oqxBHZTRQSLZrVULf1DvdYeDjClBwgm
 hJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x8HsZE5XjZFh1KROTAxOBXAVD8y3Zf1yZmVnfUK8hvw=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=UV1SL46A3LAiGlu6tVNFbFscq7oQXRczuI21vcIW0kgzSefSg8qZaEMEgpph3dA+Ai
 BkypPVROK1HKYCj1r2i7eKCwgpGXpTmwJQNABf4USmMc32Fo7a71H8LZKjnWbL0Q9JIT
 WynfzTyjf0OXk7mRgAYyDInNT7PzIODVuP9thIVToOjmPsRt832atb0s5XOMugfv7RRG
 vcPOBEVhxEMKRO+7evi6kV4EuW9DFFCtv+5GqebNDMic+70RlOF9FxYw50gD/QN+Ni5u
 Au1gv/fHsyJ0HJGBQjD9SEOcDRATcgvZOphRosCv9W9OYYMic81B8EGnACUUdjTG5x5r
 GQ2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783681597; x=1784286397; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x8HsZE5XjZFh1KROTAxOBXAVD8y3Zf1yZmVnfUK8hvw=;
 b=nCTXsGjv8kpVxYTlbmK+S37yHJd3d0HiK661ayQ+bvFiCopVBe2XUUq7LxhU30MRmj
 PDQ1H7cjzgnx6BSwIFltfG8S8FcbNSHSvGroxpI7HKQuzfAmzYhAoTLAdsD5HyMymazk
 WQmoyfhfZli7py+qEKVYZXlKWJe3W/I2aX00ph7AIN1epQ4qpRGS5N0VIs/j6Q9t+4wd
 pAP4fH4Q0+mkFxGgyU4flZNZc7TpG+lQ/RKvFCSyEPFBa1nYqQjfTowMIJ7OHn0Pm1a1
 o72ONMXz+ty06DVwECw1gOlzWNUm019XYELYCiKIMUYy6T7onnc8Gi94biA0ymqEeImJ
 erPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681597; x=1784286397;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x8HsZE5XjZFh1KROTAxOBXAVD8y3Zf1yZmVnfUK8hvw=;
 b=iX5rddn0BWvx5DagNc4TzMMxPxd7sJTwsLppd20ORD7yDnU9m/1xyBuZCrcx3XJ8Ox
 R0cSxPah/rjah1NSGjwbastudo5iwV8ADkouuIoAWCQThR1wAfoGR4jBk4laSZ94ANaI
 0yw0rMczXwgqEBkiZnJmltGXJkP1iLwcvaE0O3s0L/8hDVIkLeXEdRvZP6UlDzpNSuZM
 QCqwe1rcq4akGsTXcx5Ae0//WI11zrNZ0bGJva7wpFGJmsuvAd37/0QvyL3p7lZ2Q1Wx
 cLvNCS7D/Lpd9Yc1+e0r9dwGN/3XXLqvG7SS2G1d1EoQexJbi0R92GSj92vNJgxFdiLE
 MAPA==
X-Gm-Message-State: AOJu0YwTG9eO0kRRwl4bRC2awz2R8UyjCtX47vPST/bv9lb1Z2MdoYWD
 TkTkot6wdfa7jJjfT2gWzn8Ewe960BjvyytnHI/0x2dedtsvmDOXhgWe5skUeTSBQaWfhlxlVqv
 6M+nsNYmayeVmSA+nnkd98ZWOtyBDdjaD4bjQ0DsSFQ==
X-Gm-Gg: AfdE7cmmQE6Om6t76dcYJsfBdPlQ0AtnQ3zwpv/YiSoS8pXC35gQ7ekaJcRHnouurGQ
 a4drXZWxaJgWjqTinz1vFxHBbwMC2Ps8meaRrALJ5F9jK8TsRINHUDbZN12HVHJBe4BZGoo6t7T
 VpmUy9pvTCreEbt1e3FHwwRQddP6LMbd+AcAEExZ/SrjKcZx/aE1cwA/hfrr8tq9nBRnaCL+9fy
 lAvCToYtJK5MsaTI+DWlKgIi118gRNh5QVnmHrrT0ADn4mG5jcFT9F2BJqsrbpeB1vSWaEKAeFU
 clcXu6aDQhpm/TE/ikDwknBbpLn3XKBWJxzh4sDDV/jJzC4J8fWyg9rd
X-Received: by 2002:a05:690e:d4a:b0:664:f765:24c8 with SMTP id
 956f58d0204a3-6679f0c2e50mr7032421d50.43.1783681597202; Fri, 10 Jul 2026
 04:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
 <CAFEAcA8R1RXrGo2xov-4gKLQXX=FTVKoK1rGuxuYmBo9e8SN_g@mail.gmail.com>
 <CA+1f7BD2pVP2ByBRbwbHBRWNNuZHKdM_7xSVSmPztEWw1BbVbw@mail.gmail.com>
 <CAFEAcA_jkzy4evQOefKz3B+=wzcVULWr+swVP4=zKkcbcE44pA@mail.gmail.com>
In-Reply-To: <CAFEAcA_jkzy4evQOefKz3B+=wzcVULWr+swVP4=zKkcbcE44pA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 12:06:26 +0100
X-Gm-Features: AUfX_mwOQ2VIPWWBmDtkuA9a35g0gnE1BCF-u_q297ELVkZ2kIAfTlH2H9k0u5w
Message-ID: <CAFEAcA81tCVFQw4J42f8YgdtNCESOA_vnXDGoVW8hJ_mKPnH=g@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] target/arm: add support for MTE4
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Thu, 2 Jul 2026 at 15:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 1 Jul 2026 at 06:38, Gabriel Brookman <brookmangabriel@gmail.com> wrote:
> >
> > Sorry, repeating as I forgot to include the mailing list:
> >
> > Hello,
> >
> > According to ARM developer, FEAT_MTE4 only implies the existence of
> > its 4 subfeatures, plus FEAT_MTE2, and MTE_PERM, all of which are now
> > implemented. There are no features that MTE4 guarantees that aren't
> > either already present or introduced by my series. This means that we
> > can now claim to implement FEAT_MTE4, and close the issue.
> >
> > We can also add it to emulation.rst. My apologies -- I can't do that
> > right now because of my current role, but it should be a trivial
> > one-liner for whoever picks it up.
>
> Great, thanks. I'll send out a patch which updates the docs,
> and close the issue.

Alex got there first: there's a patch adding FEAT_MTE4 to the docs in
https://patchew.org/QEMU/20260708145841.3032079-1-alex.bennee@linaro.org/
I've closed the gitlab issue.

-- PMM

