Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B0DC88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62o4-0000lY-2J; Mon, 14 Sep 2026 05:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62nv-0000kg-3w
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:16:48 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62nt-0006AV-JH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:16:46 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e56a1fe3fso1292816d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377404; cv=none;
 d=google.com; s=arc-20260327;
 b=OSLpyr1Svz00Td0OBg50YZxaEfc20rIK+UmEiYwJt6NlqrkLakyydrUEYWyDT2QWcR
 C2InpklOkGwB3HKTWEYfE3z54+YEz6PsnNx5tEiMDfoSJfwKdv9hcZDV06fOapj41M/8
 540XJANl4QCb/ko/2qSlWTHQNfw0odK/Bw1HuSZhkmXC7dS5X7QOx/lvQhAKmJf6U6dz
 /V0FJ1aIl9un6NC3QQqx7YnoMPC+Kzjjxf/7et2jHxuk4+Be1w3zB7Gu4Q/q8IqUahZg
 7bJIoGPlHbeLxnz0pQPFcFejS/QZq3t9RcHhNJDilR8FuLt67fGRmmojYpFBB2P2YKIN
 THKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cuVNCcrSOpi9sOD7sQqHogVyBc5TXxEpbbTv0EpMwhk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=VgbBQTOOK3W+Vr0/yF0rrchL9BlVDr939LzeQfeGoEd9a7pkiPABIfCu+aIhkbbqlb
 obIkNLFYQ09qRYIYf+ruCXtb4daS7esu/3DqjgL/qFhc/KYrheqnBF6opMgGmnzNCSfl
 ctTX4UbNqXACg7I8+l3JS4WtKIxghXDWZhlYPy3Ryp6+BiQG0SrOrSvMSDKBXQi2EcSo
 ZFnMMyDyyGpm7o98ApoXenlgIOvhkvVjlLMxQ0rRD1SJe1Qyw0p5L27jEFrgToFh7dKL
 WFuUiOWPE720Bp06Gi2gxDJTikzefH+qTDWRFw5sr+NCpu7cauN/rQm+qgn58mp5Z8Ac
 nl1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377404; x=1789982204; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cuVNCcrSOpi9sOD7sQqHogVyBc5TXxEpbbTv0EpMwhk=;
 b=Pax7AZYyFArV9H8SnZ+9CLzlWCHUmbdUXQVlDt/QWPPNyD5UushHlyWugTrrpLsmQ1
 GHImuJHQiCX8cCWq4LZlB1pcMhOuoqU15HJjW/jXEY18wtMfWZ6tf1FB7c4ISAVDLyIi
 y/Ldfmyrhgs53I5nJT7gEAg51Cvo/cpK6SfUwSV2BtBBfbSTFrMSPG/ftthth5oMqVlj
 4PYUFzyOAqBbJvkvPejIQM4LImgCdSRCzIFJLMKZBDLA20Q2+Peq0TDP+QICug9weBhs
 EEoHnFYzlASQEZQykRO/smpVOXbeeTkyNwrdRMlyt3lKH6h4zYTJLNULrOcPr9bDgCGN
 eKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377404; x=1789982204;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cuVNCcrSOpi9sOD7sQqHogVyBc5TXxEpbbTv0EpMwhk=;
 b=pxWmxkBjLBBzMD+SLVs6uNM9ENWXWSK+odByu7CYYufKhQwYlNNfL47kcGubLUOYJp
 dvvggTPH2Yq+mWIfK4h9zMbyVVtENz14b+CeyhKtjSNKoTiWwAvSZ3hkDOZGoq7OrFsQ
 4F0SY4lmGxlh8Og9aRqjB4dpZ9Nn2CJufqFJYnmQUAXi0dwX9jWTne1M4cSX1oKBV13S
 kHWgdT+BCt8xQtFOuxGsrdHOYU7veZqgTYnlt6nAJKLdKAfSyEWd8XgWVS4lPUvuIcIb
 J9WJldV3PhYtY7r6xCBDaj4GxtzRjo3gMsGieMWrBr/+HJK6TeLclchSlcqTKW3yvtN6
 OO/g==
X-Gm-Message-State: AFuF++nxuFv4jenLMX2PnOhkNk79fm+L3NDqsyH5KVIoUCamQI2OnWu2
 33PmFr9WMLhTovrVyQkcY0cb2G5cBEL0T3MPYj5vqhKhsmPuIJjjOXFT7BNo+W5PQZS0DtJoxFW
 Kdv1DSddRKh62mXF8/spSQL8fHBF0oO8LNrUi3H2KCw==
X-Gm-Gg: AYBFou0j1nazUupDZwfLgFPEXXj7hpW5SlqNwz5N2Uy/AbaYAldCg7X+fV23mRWRGWB
 cwWvcC9MFAkYN4OGl+3iyyknvULGRetiYp3KNzGtlQKfpk/aK/4JR2QsJNF8l4YHGy7gMHmeCuU
 7L5Y6Bp0fXSq2bJh24L/LwBNNJ58baJRhbg4aSexlgsqEsyHe0PgSz5od+baoHA25Ui3CWhqZ9V
 oNXS+2NFS838plumhNSF9HVWHZVfFSE/twUNwyZ2TLZuPQ70CrZ4oBrXPnfjCFdgN+FBjQZOnqr
 W4uXVnJHCfp/Ux/462DRrrDaZo50fzNFVjsdCiSZbulUUw1aJp86Qe95daD4RrAY4nbEtlGB9Hw
 S7cOqFIJq8g7CbxW+t6Ffd9Fm5UY2iK9pUzZamdo=
X-Received: by 2002:a05:690e:4553:20b0:670:fdf6:dfb6 with SMTP id
 956f58d0204a3-6714dfdaae7mr189754d50.21.1789377404174; Mon, 14 Sep 2026
 02:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
In-Reply-To: <20260806173123.333423-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:16:32 +0100
X-Gm-Features: AcwNN1XiMSb6RZJn0vc6KF7TWvHzPXlsYl3L7Yoa2djgaU5fqKp5cuTo1w0l-_4
Message-ID: <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 6 Aug 2026 at 18:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
> within the range which are not explicitly listed.  Previously we chose
> not to honor the TID3 bit.
>
> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
> on these registers, so we might as well honor HCR_EL2.TID3 too.

I thought we agreed not to change the behaviour here? Is this
just a "forgot to update commit message" thing?

thanks
-- PMM

