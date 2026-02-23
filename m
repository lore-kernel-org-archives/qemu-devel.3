Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E827E98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSf4-0002kn-Pd; Mon, 23 Feb 2026 04:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuSf1-0002Jf-LF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:55:28 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuSez-0007x1-Pj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:55:27 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-649dbff9727so3644118d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840524; cv=none;
 d=google.com; s=arc-20240605;
 b=h3pDy2aWERXnF03f+JAXMGnXSHT4L9p8hPHtj7GVKTEjqW+2/sdwD8J7zdGG+46w8w
 /kaka65OQU2aTrbv05i7CykDS5KK9zBbNUfpyjL7ls493+MXRsODilCxcF6pL/FA+ucC
 nh4NIIliE7UTuADk6Gj6nWM870/7+GRbupzf8k8nud36u0C89h4yd9miw5OWIxIRUtzq
 ImYDMuod+nTse8qoDVU+f58e49cLmXrLOszkKNEmSuzBBTizutVYaQMNs3w1gH7r4we7
 37U/IfV6qCU4z3c9bn7rcM9opBWobloivIdvNjJqyWCoA5jZIsFyoiSFxCOzEpmu3arE
 H95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MzTHiok1vhJN1c4Ov4uL4bIGf+8tZDGQjoNL3JEpXKg=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=Yv9T6AfP75PlQpNxPdsRQxkJKktZh3SXJ1ugkkq/5IZCHo1qzfROzzzl6rg8+oA87s
 +nDOkRXd8BMhyfbhyfzlTKcyC7IC9ZJZ9kEVQssIrxMimlI4vmlughJ/lY9Tx17sOuov
 8QYmbabwiB6JZedcq3BM4Fui3j9ryuHw4vwOYDGH7W/E0hUC/Vl2oJybDMUUBKIuW4Xf
 eBjozER2+QY9535YPX57c0YrQ/0R5CudqiVtf2sbGWn45bLPRhSFU+/AdosDVAoHmaYM
 OX4SsfVZvAT8UNKxEeHPsjbUVm/1cgs47XJhj5mm7Hnq5D0MptqdtpAGvsEgM1C69DG3
 MC9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771840524; x=1772445324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MzTHiok1vhJN1c4Ov4uL4bIGf+8tZDGQjoNL3JEpXKg=;
 b=gMWfh9QcB12pD8FsO6uT4UUuRrg4fQ0UBVUjgFo8Xo/joi2w8aNeHSUTLDsLYX7q68
 OvyAVFcKYwEqA7E+8GJI3UBIeQ4ecWhUAfQgKzgQcdW+IESeX0Smoez3YJQZTRj9V/Q2
 DgW82GXtPbJ2jmf/m4rbnLwbnvf/9WDC8/1ghwaHGfVqrUvSNUeeIoQ3yssVE5P1bHr0
 LGbUGOqfqTSAv0fBrqqyl5rG+Ix1MOoaJIvl9PCUzUioy9Z7avqmx6OelL/n2qn1xDbr
 EKSsOPr9Ffas3Q8q6Le0RDVDyasD1RxfMY9ZJUT576vOs4DJBRbSE76gc5cnGc3G8Szr
 MSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771840524; x=1772445324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzTHiok1vhJN1c4Ov4uL4bIGf+8tZDGQjoNL3JEpXKg=;
 b=hf4RsRDOw2cv0YEikSIwOmlDf0yQgCxZ6yoFBQ8PlhmrSwbLmfNXarSLSivbw3Bvej
 U+A3WdQqR2rCfwn/mTo5admCozTq20T+X5n9QCOi6NjVu3pXxkc15hGqRz1P0eWADu+/
 6klKjH5Ck4HgIF9Qx+esXERn13vkk2TnGhKsKh7uGA40DUFRrBq1Hev4WI3uYu/GLePl
 0TxheF7SsYitu7vMiangYTKbshb8N+eeBcVjdT4iAEKPamjg8vlEkgdDA1phUKeUdw6j
 PshaZ7DdQ5P8aaBMmdOuc2RIchZrjFnzHKlc98sZOo4tG/qQw7f81e5ytjm35WZAJxrS
 r+VQ==
X-Gm-Message-State: AOJu0YwRGRjhyTDQA8rALmvpGYl7zuC61P/HQ4VYtAgD5BONblmgpCTt
 7pmR5DVx1NjRgwk0Ky61wplDBeTqVU+wKbj1xRF/M/dnwxitxE+IdMNK6M/UaHRU8Y0i47LUY/a
 B4f9KehfvmkSl4rmPg62khEpksjy3Ru/QMNUahcMkIe4r4JstL8SC
X-Gm-Gg: ATEYQzyG795VjgDykrCqlzUpHjpu5tQi7TEXPnKbNvwuRcX3Y/Oi0/qhFlPERoGYI5Y
 ZFpdXDzGeXzpz7kk/06RiuwryJhDCXdVfAtx0XubCE4pbSQCA7xMHw9DLswdAVV3ozDrFrqco+y
 mGNLYj77+OxeN0LX9iHV5jMdl8pgEn8gPKWvXg64vhQS+hRweJHL4uEYRrxJOV9OHIbgn7Qt5Bb
 ZhFZiU+J9QhJfaCvYaoeDjOIEEtjnJj1B9Btl3X2HGYRnL45ouZ+f4ekdaHfRAf17x338Fwu3oM
 m5mmR8ta3aHAB/+9uE/10gqcA3qH2wQ9ME2dXG0X6J1pQXn7tfVBwrVSr0aGsC0UK0bH8D1bZ+k
 6jA==
X-Received: by 2002:a05:690e:1517:b0:64a:d6fa:2c6b with SMTP id
 956f58d0204a3-64c7906c424mr6708043d50.76.1771840524543; Mon, 23 Feb 2026
 01:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20260219203507.3502009-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260219203507.3502009-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 09:55:13 +0000
X-Gm-Features: AaiRm53E4FJMhF1bzN87GEQWvi4d7SeFbXXIr5HsDZxSOhFISnmMYJhZBca3tSo
Message-ID: <CAFEAcA9VYs6vHH+jXhLBVfyYckHgc8Yu13h4M35SmOCVG9W37A@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins fix compilation for cpp plugin
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 19 Feb 2026 at 20:35, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:
>
>   Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260219
>
> for you to fetch changes up to 396d005e4b83aa4a65d81778d180d545046ba0a8:
>
>   contrib/plugins/cpp: use __has_include (2026-02-19 12:34:11 -0800)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH] contrib/plugins/cpp: use __has_include (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260214061025.1239457-1-pierrick.bouvier@linaro.org
>
> ----------------------------------------------------------------




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

