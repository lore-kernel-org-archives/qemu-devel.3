Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BACDC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohvX-00005l-7S; Tue, 28 Jul 2026 09:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohvU-00004x-Tp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:32:56 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohvT-0006QH-Gs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:32:56 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66804667af2so3010425d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785245574; cv=none;
 d=google.com; s=arc-20260327;
 b=iT6ng07SDqIJ+0+DzwDQ1Px20Gbx3VmVed4e+gkFRo+nirCcLe/JCqNC2rHey11V6e
 eKaSDNVhcR82FYyIPvuvNXtJBLYpiK+gO/MsvjJF/wdxV559yl1oO8F8GOOsbXNWBQg9
 3R/w5mjaZR2IHliNOW/6srcWYtCo7amGs2M/PRGm9AQ7TRo5k/qiOwngvMWiy9N2RnQb
 xJSt+5vaPrIVfKFOSB4P4ZtYG1Pt3ElB6XM+Km5Wmj1aheL4Ua87/QM/2Y7LqJs6RuVq
 c8mhKFhefe60rysPcdGzkwBYiVa6UTE+YkXBpT2gnuhCT/3Lyu8MTGALyidiZjPDFCcj
 ccCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6sPYaJgB1hdPcWM+7vs02Bb72JIY3vo8H5ekZMbOJig=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=GNG96NE8FSJQy6aTSeNGPY/kuMufUgpWui3LJAXzY97IEsEXRC5z+leJkT162rQ0Oz
 n2VoLFOIB/cw2srKjDZmsnb2IyuzkF9eOJNF13bhI7nFAzLl44Y8cIwMW1WmtotVos8A
 1fllsOQ0chIVlxNwDCOJ7leB9thf/Y/oTk1Fm6QjMa0DOKPauvnzCTIYdOikDYcQVsqJ
 smAebVyT5sF8mcNjD+GsIu+oJySrXBx6lLwe9TbBT97mXxLaQPrvnmXDj6vPBvnHxrUw
 +K8RVdIBl4jYc5EPneyOH+fvY/KPHMAWOaK485IiXOy5NJStxDREC665QX0fj5z3B7U0
 cUSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785245574; x=1785850374; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6sPYaJgB1hdPcWM+7vs02Bb72JIY3vo8H5ekZMbOJig=;
 b=Tod+Xrb+fzUWqshaqjuHNIcfYe3YrQIHnkCY0FMmtcA8HmGehj7Ch6jqNUVrEMsTcq
 4QJWMVbpEHfPBFfF92DxyJVEZe8ICDW460P5ETq6GIm2RKMODWc73zbzXuRCo83Vc6FD
 oYFPErSWHtR4VqKW64k2RvnTPzsD67u4kyIxR8R2tTnxmtECbrcsAPxoJomK6hH5b786
 9TODn7flZVUBObnOeulPPki7GzlyOMSmZoIev6nKCQCf7bRQUQCKVdDJe7tAJ6NySM68
 bitHCQBUv4d+SaRDwiopk30jvE4AxiebQpZ78JZKlDzBvMZejESL9eOXBBAMovUTsOiR
 BIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245574; x=1785850374;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6sPYaJgB1hdPcWM+7vs02Bb72JIY3vo8H5ekZMbOJig=;
 b=D/rBH7aJzsVwrz95KZmZcxwv4r69Yj+LqVw/cO3+fM79uC4D20DHcgKiDZu+Cq0Ka1
 kNuGPRb6pzIf2/77cTMAxJQ4tHD/MoxXwNKEED+bIBVimBzaD7DQhL0mmeDrWvpHVfZ4
 ewMLZYQl6+PYtFZRje8WPPcOStnTlwPhoRsp04rnlwCcH4p64si8fshD7/ZinxV77Vh0
 RW/ZjQtuI/sB/lwQNtKplnP11asuu7O1vZoOW+xB0SFdz2eT8jAXbXr+bb2Vr8G1nscb
 iJILYayREpxGAXTGvkjDaRCNPYbHYPS/gwoTWAbfLvb0jelHmIbLpOd3HPIknPkzQr6w
 atGw==
X-Gm-Message-State: AOJu0YxXTJX+lkmPxp7C+XUvq53YOu0cBKKcspECzyysECSxHq2zMNyy
 gDY+PUS2xzef+SjSqwo9iLsMuH9aG5M4R3uU3mVTbVAdnNaAC0dqBo20gs6nWAPcN6Pd3N1B+Zf
 oV3m2HJuUZTx+uVFRj/64dRtwqZAbCwB6b43RuuMbHQ==
X-Gm-Gg: AR+sD11nmrcdFPotL2+5nA2gGjziM8/X2FZFC6BuC3/whYgxQbJvOkc2QoBXWr2Yi4F
 WLGUlJr7b3FMHplLp01lfXfjSi2s4H+LZ688upIw75LPopMVhuwxvnLZBQdZCJ7vSIIq3DF9P8A
 nuXTHAah0VuJvilTVh8KZtqXtxEa3Nxy0Rul5FeqTYRggWWGepwnL7snLnfPjg75kPyGdN06jQ2
 EDi6nx9CWs4+hU+V6X3le88sEwVLyJjsMNHPrdP6Zl5vMPYNTlPwefr+Ikkq4cGokXNkCAOgLgD
 fL1nrLSVnO9ztQ8L/cD6ALoCX0W1xuvO9vlwB4cfwjpgoA==
X-Received: by 2002:a05:690e:810:20b0:667:c3c0:f2b7 with SMTP id
 956f58d0204a3-6690547b262mr627184d50.19.1785245573873; Tue, 28 Jul 2026
 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260719174905.420725-1-richard.henderson@linaro.org>
 <20260719174905.420725-2-richard.henderson@linaro.org>
In-Reply-To: <20260719174905.420725-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:32:41 +0100
X-Gm-Features: AUfX_mwSQHdmraRIB0oA2fRz0o0h-NQyxZpkdRlySEMS0L3wMuNcBs_yV4Yq_JQ
Message-ID: <CAFEAcA-gmA0_VHWQVdk8=1v4usje19wu4SHwS=Lk+dgfxTWiOw@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Sun, 19 Jul 2026 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from z2z to zzz to indicate zd and zn may not overlap.
> During decode, retain z2z name and duplicate the same field
> into zd and zn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

