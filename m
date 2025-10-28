Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76773CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjUv-0003IE-4v; Tue, 28 Oct 2025 09:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjUt-0003Ef-8S
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:12:23 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjUm-0001ai-1w
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:12:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7815092cd0bso71693547b3.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761657130; x=1762261930; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nGzZaXPfdGQi/k2OduiVfLXwisTBw3+ULg+qkqz8MQ0=;
 b=IPwRPO3hFinF/kq+wdxJRwBr0tG/p6jp5qxb9Ep9Ba9ZnVsb7Ls1xAkgNwp5/7c0k+
 K0jkV6Csz41dTCFhZAU4yuorqsH/1vOJ8IZ+F0eih7CiOEycrRS3wQLQ6mMlTaS/yEQc
 lGezbs9CXiTYRi6EdVFBg3FU1okS2ZSjVjs3OhcPbp04xQhDeUmwoevQ1us7k0wjCvzH
 oUl5Jdiyc/mBelcWLtmxYG5BvXr/0lSU07+RD/iyR+4WTdqSJl03RBWlqyGShgZJLv/6
 VPuT6P+1N7/fYFoMVO923vWu15SXdFzB+/Y8OCxZfi1VSVL+dVnqPiyxj8gOYcJOeccB
 CUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761657130; x=1762261930;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGzZaXPfdGQi/k2OduiVfLXwisTBw3+ULg+qkqz8MQ0=;
 b=trmDrWWEiPYORiI+a6D77JZptczjzD0sYC9WVd0qpf1goDEiGNENXsH1EXas45CuE/
 ZCoCRQRQVNipYlPp6hxIfptF4Bf1aVVfxQ8chmQOEgRTdOgcEu1KLwF17asuNY4fg6Iv
 eVVXdxY2pMNy338fKQjYpCceRXQFqcHEC0EBaCM4E+aAN8Gygwjfwq8eLoJdfPzT67+J
 3bagb5oi6LzmhKuE+nEFrzC4aa8pAdJUbfioMjnZNk9b+/h1tkEuMKPp51Rd3zG8vhVf
 DyPf+MRV85/uMFLKAnzx0nGVTyZQRixZI4Jq+f4RajXUyCaM2Nm2tUpm6hkMhqKfa+hA
 bbmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUthqCtcCtLXGAq4QDgALTFiIo1b7kKo3GXvEQLglO/P2f3iQX2tP9pO781gP9rLIjuhPtWoTtyZx8J@nongnu.org
X-Gm-Message-State: AOJu0YzTwEg9H1hbZNSyjcVnKtO8kNf3PbRtw4/aWrpt6z+sppwy+Fo7
 pSBLxXgjvjJgQi3YHxVtwvgOEVcCgNwLTzHMa8gRAhsorVDdv7nRW+rg1eDM7Lex2n0C9zuI2jQ
 kX7mwlZzwA+TRr2PXsJ3hG2wCYl246q14ei3jvlucbRXmEj8VaUHy
X-Gm-Gg: ASbGnctAQrCUa4Wo4PHJZwdxPpVtgTaoOGwFU5IYWMBrSKKfbguFwFm86RxrpTL9/XZ
 R8ucyf3XpXqiaV/+ZX2fdOp3wn2dhcqaSO9JQV487aWjfxnH5WdEoAtDkjzsm/lzm4Ixkv1GsTO
 7h6d2oUqMYmg5FGxIxr/1UIAEY0Z2rgXzcJyMq1qkSFFdkMZbng3a+RyyHNJqZNEJU/JutbrzsG
 MTWGP7qYUMnp5JfM6kFNSiWqwXJOYx3q1iuoIPtt4/EZ5PwYk/Al70GEZwt542D1UMsbj4r
X-Google-Smtp-Source: AGHT+IHGcJ45V1+WjBFIBSAI4ClL9m/WmZCbthHsPnhkm8/w3MXiAg5b9SCDLeu32+/SxabsdU81yUplUk4vj41GxsE=
X-Received: by 2002:a05:690c:6887:b0:786:266c:5bd0 with SMTP id
 00721157ae682-786266c6964mr1141967b3.42.1761657129853; Tue, 28 Oct 2025
 06:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <l6slswtmabktu6g23so3sldafschilwbp3kqolny3lppjezosi@hn6ptmklek4q>
In-Reply-To: <l6slswtmabktu6g23so3sldafschilwbp3kqolny3lppjezosi@hn6ptmklek4q>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 13:11:57 +0000
X-Gm-Features: AWmQ_bk3MRGbKJdKh9dUDAFbizqaKm8Fsz-dyqCTioaCzK91k4VrG1xRH-rp7W8
Message-ID: <CAFEAcA-FdX1OwY07QSWfavJ9vQuyOhf2twOXY1GCREfER1_qHg@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Use correct type for FIBMAP and FIGETBSZ
 emulation
To: Bastian Blank <bblank@thinkmo.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 28 Oct 2025 at 12:58, Bastian Blank <bblank@thinkmo.de> wrote:
>
> Both the FIBMAP and FIGETBSZ ioctl get "int *" (pointer to 32bit
> integer) as argument, not "long *" as specified in qemu.  Using the
> correct type makes the emulation work in cross endian context.
>
> Both ioctl does not seem to be documented. However the kernel
> implementation has always used "int *".
>
> Signed-off-by: Bastian Blank <waldi@debian.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

