Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35982CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVmg-00082C-Dt; Tue, 16 Jun 2026 11:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZVme-00081M-5R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:33:00 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZVmc-0004EN-NB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:32:59 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so5090438d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623977; cv=none;
 d=google.com; s=arc-20240605;
 b=hlMPvVt4AW+3GDjLA3G4eVb7jjrLh/bi6zZD4RxVfBoeIHJtYLZPnFeoe9vbV7DFwc
 mdQ0QptAIQtxcHl4kta4t2bQDgoKa88rESVw/kEYoYgSYJ1AKHQOBvwPBVl8i442Di6U
 POKnB7+f+BLjU8AyqWlRgVIkhlLxoyrSE8m661Ev8bdPamHA0UMbF23dtE8J0dkRg4Ml
 NesBi3ZHHdPtGKeYKFajxPeRLVHNm1cNHN+pxpot8K8zGFxn83CGk+0jW+ZE+jaLiInt
 ZP1qZeXgldv7h2kIHfZ0/FsviX/b+5ZHEbWWDOoPYnOmWtjDiyM5xhq0LLW8SXfy07+R
 UHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fmlcTBy5GUF+phg4A0g5MTQk/Mzl6TKYJScxaFXs7So=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=TtmvVz8ALcMxVGVuBBwho/4AOZdBvGkSA2KAmwGWXB96GA0018Avy5DUSZVy0Z9+6Q
 Guq7FmiRvI4ro8Uu2mAZ7rF897l8+2HT6ZpGY6+QcCQoct8rG/40Kfu6G4TZSssj+W0w
 zQihWQlDVuLaiGJruP0mzPvNwlCLSUog7e7om/gFo6HNUWKYItGyWmtoSmvXHj2XcvOf
 EA+DRaKakR+kvnb+kCDmivoVIUiTs4KDjE3FaoZOPTn0ddtkMF78er6xA8e+Tt0+LIjL
 Qaz7B/98C1cUzJ1DqVAEkUaB7w62Gwcy67DJ5QA0AAnkKKc04gFzoKdklwfkC2f5QZR7
 nRgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781623977; x=1782228777; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmlcTBy5GUF+phg4A0g5MTQk/Mzl6TKYJScxaFXs7So=;
 b=WYi4/FcJt9LjwpDDxLhtM1zxJCE9ToqiEvVFBnPBVQwslXBhPUR26Wlq3Uh6TYlkcp
 5wDLUlGGLMxIOEOSTU3nVTH1i3TxTpxsnarfrCwpWL+SlJcuj5aB2/xzhxl1O41AIoaW
 KPXyIv4ZvLGENAHd8qjk+rj3/taPepkoCGsLGaiNcYy80L8ZLH5uvVZsh1ZbCNdZc3oC
 mqKeZCnjyytXGdMXo958sWmFfloSxbtDs6snMYyIOFtcrlclm0kiCLWjAt6/xgyH0PZH
 8Ufy/kKXr9xrUhxBB68u4lrsnfdGnOMxthcEHbRfDDC9IVadvEkkV6RroTeZdui29jox
 V2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623977; x=1782228777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmlcTBy5GUF+phg4A0g5MTQk/Mzl6TKYJScxaFXs7So=;
 b=FJx01Pc4+va1UZlkOY10IlSsRZbie/vssN0rCQODkFKEHNgToMJv5v96PFIxLahNhl
 vY4QbHw5VJZr3q5pz/tpaDrespiXqUnzIPEU+N6HgwDk4SIxIn1CFoal3rk3HIrrkoXr
 Q1NHYp9MpgtkIJGAEt5Ta89T5LAUC9X/d/eckKAEl7w37CzXne+iwaeaOLZybr5czfFl
 zQYvJxcSIXQOc4tz0yIE0OuVbcsjJvCABZTiHP03h2rAVerG5GGtylJ/egIOMk3sEgay
 POZ/gTFcheAb4QHMBFqK/I4im7E5uD6go/9UySOiB+/xra8Em4w1hOhrcaipTYslA4Fe
 Zizw==
X-Gm-Message-State: AOJu0YxWlIjsepswDntq6U+8z7fuHTUlXm3mRDjMzdB8s9iSC0cF5l1o
 fOwPDhl4eTh8EavMVOdk+jlQNPu2tQccoeAOjlao3ijPSqHJLFZxtnZHXoOLVmZ9IsLRX6jGVM9
 qX2/9S8KWtBdi5jg/CqIoliszaGMKFexCqfIO8jJcKrlI5LTQ2JMM
X-Gm-Gg: Acq92OGW66NqIwzxoyJn+EiSRLN3MPtfgUeLr3qmkETYHhhx3i19FvtFej+e9BHYhIm
 c/ya2LLjBz1+5hWPiglYZprOdfHkMsK9kZioqQr1dD5CjpML7fi4ruic/YldUlyy7Rh7nEKO6f8
 dWjRgru0IOrcZyPutlt9KPSbm88uCiDK8Mn5dPY+Z/csHB1zCtB6JIG3N1WsHb6B7zPnQEFzG13
 jFYv9Utyi9XkNIk4L4fKIjwclIubbgVJ2/jqv9o6ki6fK08LKubhKan4BV3ajxagemdwntdvz28
 IuNUFtBMJpdOzA0tufx8u8wFDFev5FHlJTCx8ZWw1lyD9NE6IIUkIqkpNQh9YdaZdIw=
X-Received: by 2002:a05:690e:4183:b0:660:4117:e4a8 with SMTP id
 956f58d0204a3-662850c264fmr11319946d50.32.1781623976719; Tue, 16 Jun 2026
 08:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-26-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 16:32:44 +0100
X-Gm-Features: AVVi8CdBQ_mcr_jyMzNOmTB1zCppsLRdrrPLgp9kLB1OvtP1noM2sihgE1SDdhA
Message-ID: <CAFEAcA_qwMxsJKF8T1-ZMxOapsqumhPVpgV6P+MBPUKm=uLSWw@mail.gmail.com>
Subject: Re: [PATCH 25/25] target/arm: Use expand_pred_N for
 helper_sve_not_zpz_N
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 5 Jun 2026 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These is a bitwise operation; with expand_pred_N,
> we can always operate on uint64_t.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

