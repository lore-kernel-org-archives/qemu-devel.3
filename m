Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D7105F782
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0yN2-00045t-Lq; Fri, 13 Mar 2026 04:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0yMx-00045B-4I
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:59:43 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0yMu-000222-6M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:59:42 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64cb577e79cso2266621d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 01:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773392379; cv=none;
 d=google.com; s=arc-20240605;
 b=Cu2pcog1e8BjmP9YKnoeV0+zO5jiiJ9Zaov4gJATzWs1WpQQMyk3gAeT+00y/cMlZr
 Ggxe7oWMe3lFZdcq7FQNZuDX4teWlt+5XH246a6ctr8saIzVk4ax5U18x0+yws74/fdX
 Ug0uI2yaJOEFPDSBEOxpMW3DvyTvnOAWUK34yN6z+0BtFZIoAyuWqKbxavkhyfjYySiu
 ji/0MK+JYvBZn/M1KcqIbtB8b11VuXb78lL76xme0DCdO/Kc4UZnTlBl4DEqtvL0T8a+
 kQr4GpF0+ER4mzrdpf+b2DqFrswi2ZhATvM9YIplQSoE/GNYaM58sRozMRk6HKw2n9L2
 PJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mltmT6aMoafo7V/fQ8c/CuHXNuMtEfOyupyXicc8i+Y=;
 fh=eaC721saG2n+zpiy/I+LGhWKuuetemv+53NQpA7YMZM=;
 b=Hz0KxTewGLBnmKrmAFU7+wjpOPgSdkyQ6FSyl9IonmpKd6Ijx7eOUp6vd3NI2Ybphr
 1wHLZm69RyEkQ+pf1ZIyEip7g2MFYgLbiEwwmlBstMXLvtjA0ff6ZZhOxv8mdLkxPzQ1
 YtPF8djQqQGj4vU7WGIq/JYYT3le1F4OjNOixc3Q9y+E6kH+BwQCwaS9M0BDtb3JdcfM
 t5gjtJ0muGpVohZsCLwTyC6ZUkwFQA/jL2sDK1cj1Jo/l+yxq4n/4tpY8R6/6gpdoo38
 6/VYcFJ9pvcz7rdk4kVryxn28F5jUCuEFmJjo5FdicuyN0CmtY0nL7QYJFX0ycr08jB2
 B/ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773392379; x=1773997179; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mltmT6aMoafo7V/fQ8c/CuHXNuMtEfOyupyXicc8i+Y=;
 b=St8pb9u/UvSIAl5yF23wcXx1PzNyCCEiVyCjgWOwqv92tlWnapAWQcxB/8o60rStBd
 KXMnSWxzpEJneFdQpDFiXwf7euPK4vxmusvLs8ZlvLp7TUS6PLJ9Udbybe6ynK4NvpaJ
 pmRE7Rsj4TSIktM4kR/IPGduHZHxK8cE3DHbuUcvZlegU5cPz0YcxJa0KKOZpEAMxg5W
 K1UXqbvzUntbWtVotaSsZvd3/eAcRwh7J/j1vsYO0y9BJKhVtIbih/skO61T8j+f2wbY
 3rFVuFfzjGvDxMqv0AvkuL/RwElKCGwLh3qAHPUeqUHX67/AtdbpqgNzR13Z6Cmu8q9o
 zDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773392379; x=1773997179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mltmT6aMoafo7V/fQ8c/CuHXNuMtEfOyupyXicc8i+Y=;
 b=LW80LWiSGr5ABxx1//F+jYzRtU87PiNAv/i1jQIeA2MDBm0V8UNcI97os86LH/kIvP
 7eHLH0ak//3nkDsqHDWFAqB+uKYOp7DbPAwjrfLUmRIiBUZQEvdX+snnTLS52kLz+qpc
 Q7Ilhxvl28n7r5KeHJIBZmH3SDnh1PIdEFEXVPEBgnS6kdUkBKs8H+l6F6jCgZeyJ47g
 Ws7vUQ9qOzKeZuQmBJsFHoGyOJjvW2Qa9iM1PGIZcU73irdmPd8eUWhBQrTDTzT/d4jN
 xKaUDSgRv7wNzBJYBWaDn6HON0O45mjSdj93GqsgyHJFJEdHg5Sh6jMBme8T4ESPq4MZ
 iByg==
X-Gm-Message-State: AOJu0YzQ4nYQjpYVxD/XNJLL0geiUdLba97rP4QuqV8Ux9ZROSTfcuAt
 7C0A7Ds6lpp8KVw32vK7HdBEEmSiL+ZtSvuHNhYNZedJoX/LuGdDjI16QAQWjqJIhiEdYXOqOKA
 j4Q45WCJuiiAV98f5mfRmfPt5YYsqvrOnnUNyvivEug==
X-Gm-Gg: ATEYQzzSKaUV0bDfb9NGYwbQvE6tutmbbAl1mgrtdMpv1CSYi3S5zbKL3yqgleIdMoo
 WGw4B9BCchZ93GVTF6DDeht7WycFMzP0cuJRKeYiky1mUkC8sUNx8YtlbEMjz4PAekLcpntvpL6
 IPuKlSHYOhnl3TC/QpgW1eEW9n6qA7LxRLVzqCVm4HnKHM3uJi73B0FtgJ+FW0mkMsUuCtivkGy
 etbGR2Xud5Ua5mJbsH2EwmH/L+A2KLEP/u1GBP75tgxuPnSDIG+sRsM7Ope+3QIkCarJ52oTp5L
 mklfWrhV3braJShniAB5blTZdLFn5N48Ua6gCqbM0qlhbjXseAioBdjN+xo8AFRbHhY=
X-Received: by 2002:a05:690e:200a:b0:64c:a1f8:ee27 with SMTP id
 956f58d0204a3-64e6308bde8mr1853167d50.72.1773392378727; Fri, 13 Mar 2026
 01:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260309214852.92545-1-lucaaamaral@gmail.com>
 <20260313021850.42379-1-lucaaamaral@gmail.com>
 <20260313021850.42379-2-lucaaamaral@gmail.com>
In-Reply-To: <20260313021850.42379-2-lucaaamaral@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 08:59:26 +0000
X-Gm-Features: AaiRm51xtyHatKKDExPQgrJMY0-M31vYv6zkJHYTknmG1JJmEe1dOb5Pj8zMaiw
Message-ID: <CAFEAcA_w4_4by-iWm4CE3J3Ydm1B831nQbv=HHOtW8i7wMMD0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/arm: add AArch64 ISV=0 instruction
 emulation library
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de
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

On Fri, 13 Mar 2026 at 02:19, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>
> Add a shared emulation library in target/arm/emulate/ using a
> decodetree decoder (a64-ldst.decode) and a callback-based interface
> (struct arm_emul_ops) that any hypervisor backend can implement.
>
> The hypervisor cannot emulate ISV=0 data aborts without decoding the
> faulting instruction, since the ESR syndrome does not carry the access
> size or target register.
>
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>  target/arm/emulate/a64-ldst.decode | 293 ++++++++++++
>  target/arm/emulate/arm_emulate.c   | 738 +++++++++++++++++++++++++++++
>  target/arm/emulate/arm_emulate.h   |  55 +++
>  target/arm/emulate/meson.build     |  16 +
>  target/arm/meson.build             |   1 +
>  5 files changed, 1103 insertions(+)

This is a huge patch, please can you split it into more easily
reviewable chunks? Something like "basic framework", then
add the instructions in multiple patches that each cover
one coherent group of insns.

Are there any places where your decodetree file patterns
differ from the tcg ones? If so, that's fine, but please note
them in the relevant commit messages for convenience of review.

thanks
-- PMM

