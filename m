Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDF2C9EC95
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJ2L-0004gg-Ft; Mon, 12 Jan 2026 09:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfJ2J-0004eK-QW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:36:51 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfJ2G-00078z-VW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:36:50 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7927416137dso17754637b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768228608; x=1768833408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ST0Tl6J7PJeFQCwoxZ6aeBSJLERjB7Nd2nkbaSDEbX0=;
 b=vyN1fjna1Ay0tbvVx39D11x2Wu2zlZMZsMxUULOVpMy+6EcAec4A7k41s33RlDTOZL
 Jh9kFcNDcQilEeA1v9asgMLpqHPqlXBm0OWoX/dpH7krTL+14EaizB3CaA6fsXpTSnko
 AGrmFV4HbNJwgFdodp8U8Xz+IGPSLo7qhdHYMzjiQmKDRZ2l0I2SWMlBwjoGcbV28QMk
 YUUPaBq4PG6jBefm3XnaQV1hd4wnyi33SJJFkGH35tunLQZU0ayjC2FZJwfifDKE+04h
 iPXw+5YElqtBlKa+1bOvS1rDOdGNgTJLyignHy3Nt6jVOqieEZa4Pl1bZk2zeu4OLPsa
 26fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768228608; x=1768833408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ST0Tl6J7PJeFQCwoxZ6aeBSJLERjB7Nd2nkbaSDEbX0=;
 b=iMueM/YKtiQYkkbQh2AGOveSvW1QlRgEoikeHypDNdly2Oy4FaL3vwshJLtPVa487e
 GhraS+62ww6f+AOtUe314WIkrSe1RU0YYrbZkSUFiMSNKqiu201GgtHHC5qWHOvK4ksB
 NUELlxDyzb80AJ2Vfn688RhEvAFTKFY2CHnqnNCX17M9EEIicfrPxFH57QM2iU8rRzEN
 XCkmmyUyX+g+wlD3Z3WGA2a1yDzpEn5klvjHKy2Y0D9osqd3iUQG5ky+Tzuc63fuD5A0
 EpUuyuRNjMw1s9EJnCeEnj03zq76nSL8uyNocatnasqvMOPFWKC4u/tulZ0P0sOdmqPF
 L+Ww==
X-Gm-Message-State: AOJu0YyF2pxetgA8gO2eYcK1MDJVHn6vWV0iuUl3dnnJo5s9NAO4+eA2
 WJ6iu3QyHpwUN0r8wQ5uZl0K/rvndJlof4tKJUnxXvhtnIhtLI2l6i+85IlpUdEgx6UYv+AYbsc
 uAlaUrGNoyPincmljQ2KdCgSKNEiMp57f51AJ7pUc7g==
X-Gm-Gg: AY/fxX7er1LFl8Wa620sPQOba4l6M3eTPRHXGJmYWf9wG9jGPG79bW+kYo5O/zadZDC
 CEHg3MzgmrY2CuN/Hv8COqgWZM28Y4TD/flqNd/UDxgXtpJkql1ZcU9O5fWh6xJLTCtj0ctfajw
 14AvvVQi8C30dmTOqXXysSn8ESUsXhvhlIEmkpo+DlCFw7y5Z74vIXsHsodzL0fi+CHYWpuaAsP
 XLW9yIAQlqPXrwjVbi02U02dubIxbtP5YV7iscr5jfUJJFQ5kz9RI6R/+fLw2cqFwq88gH5aX8j
 vcFI7LrfXZDtsx4/TBB+T1I=
X-Google-Smtp-Source: AGHT+IExY5Nljmrhazv3RbZ/0CdtM5AmehHcWY/JR8UFMsmRD4OAsBOKCs4DZg6hhWQtoAnuADVIosj8koAGTSAQKqQ=
X-Received: by 2002:a05:690e:b4e:b0:646:5127:ad81 with SMTP id
 956f58d0204a3-64716cd325fmr12636264d50.95.1768228607626; Mon, 12 Jan 2026
 06:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20251226064225.791454-1-lihang.lin@gmail.com>
 <CAFEAcA_ovy2HzhVTKJiRNaZvVQ3qvkw0Pres0HZ+TFJjx1wc3g@mail.gmail.com>
 <CAPR+-WF6uSsm6nBY7jmmxKEMSHR3t+d4KG5KAtsDNJPxen-r9A@mail.gmail.com>
In-Reply-To: <CAPR+-WF6uSsm6nBY7jmmxKEMSHR3t+d4KG5KAtsDNJPxen-r9A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:36:35 +0000
X-Gm-Features: AZwV_QhpRwj6PdbhTIErMqmH4MFTw3X668xzhtsAESXsjfpXgNS7Q_cAqpXY4Tw
Message-ID: <CAFEAcA-NSqMH_+L+jOCD-QsafFq78L5ogRmGRqVZnXdXja2WTA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
To: Lin Li-Hang <lihang.lin@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 29 Dec 2025 at 04:19, Lin Li-Hang <lihang.lin@gmail.com> wrote:
>
> Hi Peter,
>
> Thank you for your reply.
>
> I initially identified this error while reviewing the code and was curiou=
s why it hadn't caused any bugs.
> After further testing, it appears the original code behaved correctly by =
coincidence.
>
> The ASL code in the ARM ARM for FRSQRTE states:
>
> ```
> elsif sign =3D=3D '1' then
>          result =3D FPDefaultNaN(fpcr, N);
>          if fpexc then FPProcessException(FPExc_InvalidOp, fpcr);
> ```
>
> As it turns out, the sign bit must be zero by the time it reaches the fin=
al deposition code, which explains why the incorrect bit placement did not =
surface as a functional bug.

Thanks for looking that up. I think that although this isn't a bug it's
definitely confusing code, so the best approach will be to make our
code match how the current Arm ARM FPRSqrtEstimate() treats the output
sign bit, which is to say we know it's 0. In the pseudocode that
looks like:
  result =3D '0' : result_exp<N-54:0> : estimate<7:0>:Zeros(44)=CD=BE
and for QEMU it should look like updating the comment so that
instead of
/* result =3D sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */

it says
/* result =3D 0 : result_exp<4:0> : estimate<7:0> : Zeros(44) */
and removing the unnecessary deposit64() call of f64_sign entirely.

We should do this for all of rsqrte_f64, do_rsqrte_f32 and rsqrte_f16.

thanks
-- PMM

