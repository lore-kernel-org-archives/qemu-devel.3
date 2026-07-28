Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9EFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojsB-0002nL-4f; Tue, 28 Jul 2026 11:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojs8-0002mZ-9l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:37:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojs5-0002RM-Kf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:37:35 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69fe400c14aso4334666a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785253052; cv=none;
 d=google.com; s=arc-20260327;
 b=hIubrln7Ncecd9ceu93QPsfWLxTK9w8jwJq1wND6IvJlmhL1IjzFkZXpfPHWAJ6hYw
 QwrIck1W2aUxdqFzSwKJw7MPhJZsXKjsKkYAwcBWN1vl3IznmdgWFHdIjqOUUAjTshE9
 HCly3EtZ327c/Aulamwi8TtzcbSgWlCEyU10W8ghN9cl0qFHehRf8CXTt03iZu1LL/Aa
 Qr+ylZROlrLPq9FlxTg+FsEYH7fKD7FZhmZh9RJhymjF2B9Z9BFsJwSKaICUtX/xZ08p
 FMMjviCcCy18cT89UdJ8h0OJ2yuoh/omxUcWIk5ZoDPTl+xcOe2ioQGbTKcvj/ozrzgr
 aDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zSTdcJA9g4HhT9G0/MZLWhXuhZr307IuCjIHZ90jeIw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WVWFShcIMSZSJJUfPHWZooI3egc+PTW1imdV9cYUrqA4FgKIqk132GLBX4VY45149I
 VpFcFK7nSiyZNMeGbyNGCm7kYanvbG4lTW3Q7mqElct+OV5ZV5tcAsjxFQG3MP9UBx+O
 w5ZAJRfNmMMbEhzHRbWE3X8CgVe0Ff6uLME1QgxJbXMa00WQnPnVkmw17YCWvN5hzOh+
 iVsJyvvvK+JDRu+u6piRn8SSvpnEW6OK9byAjVfYWfw6JZEkpeTPn5AIp78xzX/9qFAR
 eHBjPjh8NuAytH0ZAS3KsY7cZWOizBbXInclsWJXFFKIEXcMhtlHbCxMcF7otfgEgJWI
 X0qA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785253052; x=1785857852; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zSTdcJA9g4HhT9G0/MZLWhXuhZr307IuCjIHZ90jeIw=;
 b=GeKzmaDrgj8kWqRi7WDG2Gi7v6Zx3py/NNGfqNIm9n+eyc41jReUFj2afZZde8uFCA
 VyLdrqrHVDaYuCUJxQYIzikshMZ9F1aUCjVEcXo12ClXe4fnscbc4DdlG4dMVK7EgSdg
 Qcd42j6wUqZUca4Dv6biux4xtVbi6lJO/44HkSWelULSGK+u4brJXOG0xmrfb0CQlXiR
 ZD5Lk8Glxdm25IKjFdA8/G784NULXQqqfq2fc3PVi+KQDlDpovI2CbwqAHzQGWPp8Qep
 DeZSp4mioQmFxSsn8U55+snG6hNcrxvCKkLevTeznQOfTYpxvTXukwlYO+Qx4b5S7QdD
 hfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253052; x=1785857852;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zSTdcJA9g4HhT9G0/MZLWhXuhZr307IuCjIHZ90jeIw=;
 b=Rnyce72mFKu62ZlPtnuK0TgyvPd4G6VBoB+ouE5ypYGaH8lcjyiyMkKSJN3O6nU+cI
 nOHPvgEZchySmx/l3FCCNJl4XyGdxpjwMy0ConP+zX6S6NaCFSwtqeyVTimLSi9Kff+I
 jVHH1//9/V5j728kcz+0Mlc83w8FoP8pKW2b/wOpK7D2XG9KamydcGIG+dxMIComY/Jk
 vXM62hJMAmylWp5ikB9RaIZepB3YqDtuKS62Hmq73rdb7RBc/JcLlU/kUNaZDt2jjqLO
 H5HXrU84HxFU1REkPf1TainO61mji8Y+ga52p72+FulPzytKsOnALN/uUFPzziYMfgIk
 swAA==
X-Gm-Message-State: AOJu0Yw6fH5ODM9+NTN8xdZjFkdBv2r2FnnSyCxUi/SX7GGUzlwjl4DJ
 Ptpj7RA7vhuhGHEBGatN1B6ILRc/CZZcgFF1bySjdPquJlSldfwQXKvIHeghizzlLsUOudF6BL+
 L8q/cJRQlTgnYwOABHgG3PGFXbQoMhRsacjAg5NBJ5g==
X-Gm-Gg: AR+sD13mgopso/+6fpQcL65cR9UhaNQzmzkd3HEj40/tOcf5Youy8VNmolpVj3LHCAI
 4XJkr1cLq6jvgvsFc8WMLljxM9gtadOA90DsSAtazTeiS44jtbxm2CrjpJNYjjr8ZIg/Lj38rjj
 9l4ipnr8GLdOghhhZaYaQeKZy3+LO4Wop8gBVCvakOvM1rI41Y4QLdFqMtH3ZXyR5eGHU1nR4LX
 l8/QcweoJTemHXjs8KhitEpqHtRUo6zEFxLMWWgz/URZ+le51d4AVXlozSeAGe4ZR3Lu3IwUuGt
 XRoFWScKy8QjQ1jEW9L4CGE/VYk24ypcRG8F00gs3okLow==
X-Received: by 2002:a17:907:97c1:b0:c19:5b6c:945 with SMTP id
 a640c23a62f3a-c1f71d3dd86mr154421566b.18.1785253051734; Tue, 28 Jul 2026
 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-15-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:37:19 +0100
X-Gm-Features: AUfX_mzYFdh6fT3FOs9AFpT5G0u4R60-lewgZrwcYQyFEbgo5dATiZ5PVf-euM4
Message-ID: <CAFEAcA__Qh1KWcuZ9vZTFr7CgFwfP69QGZYntOutKqEh0YK4sQ@mail.gmail.com>
Subject: Re: [PATCH 14/20] target/arm: Implement and enable FEAT_SSVE_BitPerm
 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 21 Jul 2026 at 19:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++++
>  linux-user/aarch64/elfload.c   |  1 +
>  target/arm/tcg/cpu64.c         |  1 +
>  target/arm/tcg/translate-sve.c | 12 ++++++------
>  docs/system/arm/emulation.rst  |  1 +
>  5 files changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

