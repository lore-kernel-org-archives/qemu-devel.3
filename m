Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A068CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2Dz-0001dZ-OV; Fri, 26 Jun 2026 04:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2Dy-0001d0-3O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:47:46 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2Dw-0006eW-KR
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:47:45 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66388bf3793so751068d50.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 01:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782463663; cv=none;
 d=google.com; s=arc-20260327;
 b=kHQCCK4laTNWa9Owd8bRNvdu89OA9R5vF25n9iAUVSdWO1fWxn9vI5S5c3wUz+16Pa
 Kt2FuRvVrJAQNqCe58W/hgmzyyrGoIe39PxN3qGsFGYq4OviwuxQsQrY8UCbsX//w0G6
 UdX1mvZespjuGZSExRwcBYHb7QtjTYSZ+yHQNsOMOCTf5wqSKWRy2noQ/OGU+m1N80ZS
 bkInLP73FX0nCzFeHkG2vCI+2fhr1LM7iKfhCd+N6Zrw/qlO1FURZePRESbOGMdprgo4
 gvZi0ry1fo+hwhuM33/B3EeXQv0NvThZqeGOe06qe8nChj1dkBpVBvu2RVY7NAXKdBJV
 KTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=68kgUU/w3XTlGLUvPcU8AgkULNeWQmRqt9ekv85PYd0=;
 fh=HycL0dBvNlD96nvbpYNKtj8Cja0HdIu5dYQa7Inkh/w=;
 b=ZRUX3OLahhMS6PDM7nR6vepa/kl/ehknTHIXvDFm6ETtHlTRD4HWG+yQgxUE1wvgxm
 hgLD6p0msS2Fob0SpjH33COSaYuSp4wJHURKKBVUgu9zPBMHd1yC+Vyoaymanuq2+h60
 SlShynraUiT4enVdGzxv+JEmd/u0zugk+ixf4uJu8h1LACjVoQCPFj7r1Ll49TZiIzJs
 rzswUH/fjtLJ2s3KuxNJ3DQpnGvDVz9rU6+sxdNZcRUMiFL97ooH2FbRe0v6qxX5zb8j
 0pJLhzqNhpHxrtRThHd3STBrWqnyvdnCgYT+FyGMlduhjos+yEZF3ayxUtCw/ZozurAl
 KW2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782463663; x=1783068463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=68kgUU/w3XTlGLUvPcU8AgkULNeWQmRqt9ekv85PYd0=;
 b=rEv/yU/NB++sejPDnECkGfxa2YciXj4Rmr6byPGudP2rt7pXzY72P1zQp2GHnkoMtw
 iHH2bDatVP08mgF5CT6EHuzPt4ySUE6XZLgp8WVQMNOt1Lx9NxFsGp4d1BiBsTD5zFPL
 0tzMVRdThKmgtytHG1SIbfANwsKYNXi+Fh9+XOowRDxEhfyUa8hCnJzcbBRad1So5y5f
 xXyWPjYWdk8DbJdMRyM/fBmaHmpKrF43bTXZ8eYqlkYYo5953qUxvopsHtcS9VDlcDGw
 IKQS7v5dnv3l7WSJrSHgNcAIvEtDBW98lVrT7vss3JiMzfGLtcVXCGfqtpq3DH9VVJqb
 dQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782463663; x=1783068463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68kgUU/w3XTlGLUvPcU8AgkULNeWQmRqt9ekv85PYd0=;
 b=gUkqqOnnLz0ayExxvpu6NB2r7+cQrdwUKUR0oty4dH8pyPkbGx6fza0tm1rKkUDcTY
 u8Z075queZWL9JxUSssVe7Q/mn73fJSQGuVYfHBhtipSylgPlVtGXp+QSsj9LVQ2f5HK
 4Ag7TwGX3Ws8HdD+WB6ueHJ0gzKAa4u9/8SLw+iaoMJRT3ZsuyRtu6kh5SDWw4Z0XMBl
 LHa1wE1lm6vAh0MrVoaPbPoovE3iSohU1ERk3JLaZLRvLkqFdZA+AsV88poL6TFLTUrI
 w1261KeWIcNdaCXTF5+d4UgxJNa+MkiEjgjV6oHNBKbmiTqiSFRkCxCgqMQ5j7rm7HZ5
 XYLQ==
X-Gm-Message-State: AOJu0YyP1X/hEnzC8HfOxM8zYDedcGWs3yPF0BI4CVnRdW5ESRDfFxci
 CzA/kTeb0F0ASNjuhfgywDeI4U50jG+8Rjgk2kuEjKjl3763MMoJMzRD9xZm3shDyaLEFc3Pyb+
 CZRudWgB6dho/T067479WSrTX+ElP2n5beSOfyGPhFg==
X-Gm-Gg: AfdE7cnwI1aNyIh/VyjbuIkJHMlGOhs4EH7wewW78eLT5sRI3n/EJniiSOXqQ0kUFV6
 E+YkgPOVWm+ltb2G5iccM8Zv+JfGz/eae/jl1RNmQKuG/UGqsGFhpBRKYVRAfRBOQ8C5oChpXUv
 g20PfsAjeZDhkjoTYqHpSnf3UMAh5CkbaOZ0wUwxUjKowUB5lITkWHLsKm0D4KJ2uJ85pMZgGBM
 a6HBV2Ti2FPgN8rJayijon05fOgazgX020dNpnUk0sVPvFsOhXPbinaZK5GAwAmp7fr/FOEqczw
 P834eFyLGw6rbzfH22aIf+LuGAOzZ+vLdaLoblxMCdi7qdM6O5KKuuoq
X-Received: by 2002:a05:690e:1207:b0:662:f28b:7c63 with SMTP id
 956f58d0204a3-66487e77653mr4609413d50.63.1782463663324; Fri, 26 Jun 2026
 01:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
In-Reply-To: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 09:47:31 +0100
X-Gm-Features: AVVi8CewcwFSOjQa2qWPxbwBvA7NyTQfs4ypJcx8d6XL5bMPsuOLT1AQJFt3We4
Message-ID: <CAFEAcA99ws+EPh1eL72ygPd2XxAiBUZ6Jfqe_ky7+0Jn-jYWGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement FEAT_FPRCVT in cpu_max
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 24 Jun 2026 at 14:37, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> This introduces new forms of FCVTXX instructions which convert floating
> point to integer but place the results in SIMD & FP registers, and
> forms of the [SU]CVTF instructions which convert from integer to FP
> with a source in SIMD & FP registers. The logic for conversion and test
> values are otherwise the same as the versions which use general-purpose
> registers.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
> Changes in v2:

Since it looks like you'll need to respin this anyway,
a minor patch structuring nit:

> Jim MacArthur (6):
>       target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
>       linux-user/aarch64/elfload.c: Add FPRCVT
>       docs/system/arm: Add FEAT_FPRCVT to A-profile support

We generally put all of these in one patch, since they're
just single lines needed to expose the feature to the
guest and document that we've done it. Compare e.g.
commit c45b02cb24ee. So you can just squash these together.

thanks
-- PMM

