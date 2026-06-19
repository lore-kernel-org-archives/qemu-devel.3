Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC184CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZZT-0003dg-AR; Fri, 19 Jun 2026 09:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZZO-0003dG-Tw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:47:42 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZZN-0001jL-Dk
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:47:42 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-662fa4a4470so1468968d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781876860; cv=none;
 d=google.com; s=arc-20240605;
 b=eJSETHOiygTGklwHj1vBGfhfCnFrRcPn3oXgHoq9m6bfIJ07ddJLHnGyT7mu6lviVN
 vbWjKAYO4HWhlaNFEzENnBgwycuhJk5RHngaxD8hlUKMqTInTvHe0n+E1eDzL9VGrrIY
 I/4zIjG5R6bmUfL4opR/LI5SqJMMmdtc86lUtuzS/aic4ofmKdvfnGKROnjWGUPUGbXh
 9QBdHu59SN1TTxPRWqisTmN2BfUGi27xlf/A61NaRfX6WmC7bUiuxuksGsMBy4xNMPHG
 0wwvMi3x8npQpelA2K/8WkSIwyKyyGr706f5ZkU2iPaIQj+yP5OwGxWRii+jtzyYXq/a
 rvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=URQzZS0Jl8tMQUwbL1jRpdDDy69l4cqlAxrqHuJCDII=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=hZE7nEwm9LGJq6llFkl3wsyqi5RTMkmFSozuZFjAFbK4gGrPSUctgnpXU3XH/qsYLq
 jq3Bej8gVxJpdok+54g5PNMKSmTaH4f+zgeZUc+nZxcPH59BHaoZiwTSYXPjeNl9iVtg
 0ZgtfR/fEUOTe8MCVNQF0CEES/M2YPzei+1OEQMeYGFX3fqG59MHzrbbeavUt352Mf10
 QCDXCiwE5BoXfEOLuqLmVWuNk+EL47ZsqHrtnDQM8qLwhGuiAvPptQX1NLB4KeW9Eh+K
 aRLtL4XZvHYBVqMPGxTZWEz2cl/VQpqI/SSmm4QBgIt100f6anbwmgdkyxTz5j/YWHMi
 oRLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781876860; x=1782481660; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=URQzZS0Jl8tMQUwbL1jRpdDDy69l4cqlAxrqHuJCDII=;
 b=vNER0YcyWGUXgl/SvpcUbk7llkfVXEgOf1xns4qmU9MrpEQpm4Wgk0EbCOQbzh8iLI
 MYz++C3SJKK0zE0rAuJ7m0ard3l8JJQzHnFRYhHlB00MCvEaYMKK8rPcEtx/tkFYADb9
 ncZTWxWcsVbIHWaYaC0jgmZgz6FPJD+rPEueur398xELyhIGObzapAafxa4B/l65DvC3
 PyxBQtjT/NzQx9Tx5e6YZPT/qLzDaCPw89K6Sur15nMbj4ZMemiUq9uMWKNtKinEZZTB
 Jxi716wQh1QliWcvN7uMZ6XW9A7xoJ+Pqj4vQ6T8S3n/iDFHSTIVOTMNMA+LKTAp6QJV
 0UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876860; x=1782481660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URQzZS0Jl8tMQUwbL1jRpdDDy69l4cqlAxrqHuJCDII=;
 b=jllikNZchxOxQsKSCv/s3gObzue866i+eMeus47eoxFBmaIyhzz1Aq1XrPalA3vxp6
 BTrSN5gwnF2hlrKlRz9Qw9xIfhxuYLssd/E5dYnlCM3QnK45w1BzyXg+NzUi3Rg6WIc2
 NZdS92VpnpNMzT/u9TFPWXHGeH79gvx2CHrso/EGkMurXwr74I94g/jWnC3PCykys1bu
 M2KhEqub1/h2DeEGT4j4+NwHzKaEJcCSBjkpD+eHJQcEmOiLdTHzooQGpVbd5cDILwJN
 ipifTNlY6pk9U1TmE7FOlEUIRLzXEL5iurLjtjFr8kPS2KzEs4l7RzGDzweLwz2NVWbr
 NAcw==
X-Gm-Message-State: AOJu0YxRv8iCtiz1TLxabC72BGvZFf2LvdqnyrXjreVCr5+Ns9EuGaLt
 tOrDOY7FNMx8yJM9D4ejDaqVfq45SCSpqlFnCSEzwbEWUSpBggvqm8BvxZO3ccB0xYodjDL/4QV
 bYPABXxtaC8hfN4XBzS+tYWGjS+qhMi0Bq0unoK5UBVw85Ubo6QM1
X-Gm-Gg: AfdE7ckkCtbWBW+ACTrQYADr9cW47yskL0cgS55ZS6d7WgCZh3n58vqrCvJmCTwK+Ac
 yarE6pNv5yOR0nPyho2GoQBdCJXlp9BiRQidpjVw4YJcZ74OqfSZtevZ2odzviALYwbIZf+9cNM
 cXR4HTmAZzbPs8qqxgmFywtQ/SYooZFDE2TNpqyHOm6r6lhOmGBc8c04D1kSsPkIBWeKk1pFRXf
 fDS79ZvDfjYTPcA2k6APqqzJ6YgItsd4p2i9+uBV1MFIFyCGoAm5aYtVKfyvcsjitRvu+MUiSxp
 qJSrLzwyrPgtd6nFPhd3ITFCuN9b6tRLKfd6Su/qbrtghnYfepGb5Rp7
X-Received: by 2002:a05:690e:d04:b0:660:6199:2278 with SMTP id
 956f58d0204a3-662fc252ffamr4089022d50.0.1781876860108; Fri, 19 Jun 2026
 06:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-9-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:47:28 +0100
X-Gm-Features: AVVi8CfpmVV_8kk9FMwZx4D0NypuGFpcasucOVwZdz76jUv0FtPc-2e3VPkLS5E
Message-ID: <CAFEAcA9UwdvcP2QvXThe+God_z_6wH1T1XfJ26VYON_hYTh-9A@mail.gmail.com>
Subject: Re: [PATCH 08/10] target/arm: Implement FDOT (multiple and indexed
 vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 4 ++++
>  target/arm/tcg/sme.decode      | 3 +++
>  2 files changed, 7 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

