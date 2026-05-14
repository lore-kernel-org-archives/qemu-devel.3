Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB4CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 08:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNRiS-0003eY-HU; Thu, 14 May 2026 04:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNRiR-0003eI-CI
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:46:47 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNRiP-0003Np-7S
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:46:46 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651c7ddf514so9180798d50.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 01:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778748403; cv=none;
 d=google.com; s=arc-20240605;
 b=BUUDhK7qhA25Y8wh7+xeauWJkoiGBfaEnd60/iOtgKlNsPCFt6WhXFVUA0bji9BVb4
 AyR6J4Joo6dsTC+e1bTDSnmkM9Yq71kclFyiU4NdQQNfxmMPWB5hp37Q6axLwPqJ3MbM
 bmbhs8Jps6g/n0dLmYfDSO6ChqYcTD1JotkD2iLwHG6HpGez1DUU3EkgYjNQhEdrOCyr
 pSiQ2e65oeVmchnBKYCfJShwoAX4bDWXLuOnS/nACWRCJa/xszQPZ/Al11b+8JgEvWlp
 X8cg/w55gYSmU59S/W9YjUiYdgvuY2SskcKcirCxOp59ps96ryA0Z/LF3GTvuJ2pNp5g
 gb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dftl21yUAP7hPMheGT+EubcO9CmIRUfK/VK3XSaFBZM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=kHqubxA5FGigcgrUnFpkIWanRE85d6SdYyPgQMnewwBhhI/jESeCKXGz9wEQNDmPyW
 dSPOYMQrFl7V7bfgDcMNfmaUAi2ceE6UcuLRpd3eaYpVjbyWSXUD4gRGzgHehxKZRoEe
 g32DHf55/+SAK35Ikx9bJ6RBocuK8h3adh+AL3q5iwqAeIidx82o577RArxhNbMEceZ/
 O/ib/TuCkgpylupV6cfTuLsQVZ/D7l3qcpnLH2NSigsSh0WahSvvJUZMIRVOr7fBVBks
 Bg07jBEBqSqIPc0QkPLAM1w7Lo9R19eyJMC9gkyWojedGA7X5AjKz4ytcAWbErVitgf6
 vWxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778748403; x=1779353203; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dftl21yUAP7hPMheGT+EubcO9CmIRUfK/VK3XSaFBZM=;
 b=PkLKK5/Mvt3SBHFa8oJb1KMyWRTF8VfWkXX7W9dbMbB/kHFFMSL8SarrrzqwDcsfxD
 2+yF6JtopRUnT0/9G0pWlRqtLDbYhox078AgBZ29DdoV3z8pf2Pm0jTFvYL6UV7lbOoS
 30f7zAtwz4vbKBYz0JkndVjJP7fC8T9+dRbmIY/UTInBiZxTrsCGyScRBXX2St0gvrUa
 1c9hKSVRgtj88+rKpRZBjWN+uTbtFiUNeXM4x1fp81eO28eKZUXt/sTZJ2AMJEE5JYbL
 5CthTLi5bT5LfknYFD1P5RDOuTXz0M8Bhq5uzm8P+5F1XWHKUrTCAo+UUsf4clM0dW2B
 y8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778748403; x=1779353203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dftl21yUAP7hPMheGT+EubcO9CmIRUfK/VK3XSaFBZM=;
 b=QthEys3yboc6MiwC83zSfX43WO/H8Xrst8XrEUxf8Wp3VcnOXW3R1OmG2Cg8zFUe+A
 610rHsZhGCgKBBLGxVbb/pFd7e5WPhIDQwY93MG7JPm/hj14JPoMQCf+rDY+w8M6m2Vm
 aBwQdAkr3TD7wPJRcmDajuzqLd2wzWtcjt1Q3cBJ2oEEuL3X3mrmzfuGOh+4NYZUbyVK
 2hGe16Of4ojawV5h0uyqq+G1/gZSEzaYK4V0/mlYYHq/ywmk/tpHOsIey2/GYJOVgC+S
 dYXSyU7gB0Xn2aCZ0in5yIZwpAdFDl/2BIEcBb3z3qbHhTiTu2LJUvqHUW2pGOQd0AWf
 Uw8A==
X-Gm-Message-State: AOJu0Ywigf+r2YEem7auUhXo+GMrl3PettH2IIJujD7hN8ygA2umLX9c
 S4FdyZzjD2EY32gFtk9fSLhHjyxWuqFA6760l8GjltEYqKHFS4c1tqwbpbekH06h0WgGmKfa4rd
 rHXhKEMYmSquORuM3xYf/LRL6ajsZib4TYBmp9c56+w==
X-Gm-Gg: Acq92OFR5HGfvsDMDh1T6BlahU3fIXou7EQ1vbF+a7ZT+d3xkwwzg+FuosCx4Vx/nIO
 z/PLr/mzY0jJP59gK2EsCoII5FiFzlbwS8clFGjjf2t4zXFNRF0IOUJW8iEOrl9MhmmKRMv9FR0
 U4J3xcGMicyMCnVm7RjSaMqYgLGV7wIzypNt+wmkJ8NTxs8BML6jr1DE199kLGbx8Mv+SpU5gVp
 jb7PRoOZPh46RW+Aap1mRlA7tyLGvN55FWv5w/wzjFyHAgviRsVe6PAhkxdOqR5bbr6Aroj74We
 Sv09XiDKgLOMibojrjtMTSpOAUzAJIr7LXT9Qhq0rjzKEYspDaSx7+LUatuNEj+NbbY=
X-Received: by 2002:a53:c049:0:10b0:65c:2ac8:ec3a with SMTP id
 956f58d0204a3-65df81a4d96mr4701522d50.21.1778748403305; Thu, 14 May 2026
 01:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260507234413.643512-1-richard.henderson@linaro.org>
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 09:46:32 +0100
X-Gm-Features: AVHnY4Js3Q0yxjg0LoLohc5y5RBsird6dQndANKG3al6XsvfIuXDVLxblLa-3II
Message-ID: <CAFEAcA8oCde3+2gvLL4vvgu_MiUjvic_nbLweO1WF+nkNuzgtQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/60] target/arm: Implement FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 8 May 2026 at 00:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260507160959.449170-1-richard.henderson@linaro.org
> ("[PATCH v3 00/11] fpu: Export some internals for targets")
>
> Changes for v4:
>   - TF-A firmware update for FEAT_FPMR
>   - Rewrite decode/encode of FP8 data types
>   - Rewrite FEAT_FP8FMA helpers
>   - Enable FEAT_FP8DOT{4,2}
>   - Enable FEAT_FP8F{32,16}MM
>
> This completes the set of 8-bit floating point features.

Do you have a git branch with a rebased version of these patches? I
had a look at them, but as well as some mostly trivial rebase issues
on current head-of-git I found that it doesn't compile, because
this series wants fpu/ to export a parts64_scalbn() that returns
a value, but the version of that function in fpu/ is static and
returns void. Did some patch for fpu/ get lost ?

thanks
-- PMM

