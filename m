Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5BCCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclYB-0001fQ-1s; Thu, 25 Jun 2026 10:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclY6-0001eH-Mm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:59:27 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclY5-0003y3-34
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:59:26 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-663167a3ba2so2607761d50.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399564; cv=none;
 d=google.com; s=arc-20260327;
 b=j24fJtmeTZ0nEYzBov1sSc9l7QLxwqzZerHi+9OfTUen1CFhMJlRLbPao/aUmHvszT
 yZXUipIWJPQQ2X3YqG4WuMXd3+Zsz5lKp+ajh36OdhUEmzo4JBwShZXTYDwW8zlrAAVI
 4UQTfZNxyxdEyrF7K+Aeh8gtxGBKIfpFChtPrkYthAQIDUal2n5xCmnNujEzVNeqXcgz
 x9TJ+kDGNcn1RwiqpVWRmM1JoO2hlMJrtQbgYFYgmfFB+7tWQO5YJ61hp7Dm/OMvCw5z
 qoVzf7nCTALXJQuEYsWcHKj5I1+EpoMhcJN2uioFazCRemUzCpUZge9EcUauF/LfeEdP
 7rAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HzdtMgVwHzlp/WK8F9dbK0OiTLbLnYpCESvD8iz7rCw=;
 fh=aFvIJ4ygZFxdcCpuPOlGUskz99qfqRBDfvhpWs3RARI=;
 b=ML5YB1sHaEM4BQKjt5t/SLJPA6q0MPHyqrah9MLJr+QSq+30hVPg3TIuuIRnkExAMg
 9opezsiL8ksN56NCNQKZw6Wlf11lecOz96pQJ69REySW9vbkbJO+qgnbXt3t2d5nmKS5
 jRFISsWfgjnlv+K/Sg1k4xFkLk1cDrXiRZ5zJnFpAzHIZLYSvjYf16t56SgkIMJeGw6a
 Mrdagt8FvuBlSjzl70FJytegB4ibnj3LsFu5ar60EdkgvgCx2fpQ8w5TkcEPf1tauax7
 A/uo/4JG6IqDC4SRt8PsJrdD80MXUCtQE/G14zxAcGYOk+6p8gFD5pe8VG8mTsW5bPcO
 ptKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782399564; x=1783004364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzdtMgVwHzlp/WK8F9dbK0OiTLbLnYpCESvD8iz7rCw=;
 b=SU754vQmGoh0iy53qcCGbBJXZPf4vMfYtIeUVK829/ZQzzw4/JTRFAiP1ljbj1IHTo
 UHThxp1pXlmj3wWTAUlkxQFEit83CKfcxhmSkvle+NaPKQq0Vb32Eq/V5obL/ScQFgUr
 WegUWiB6Z5eoCyDhUFVz2j0elSy8ptsnD3gOTdplNaERLQjVV4r5HLuWr/T5Ry7RoVcr
 4LfIC+rL8lGN1tmTkLkdDd8GugORtnl5QlyHdAJnbREki2F7LWhrZLaqbiD8YelA+tWR
 anowsumTkJx4T5WVhsLWbeSIhFjhZ57PwMSUl3iK6uLTOo4Jq2AYZ2HU8rKekPYMFU3p
 unug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399564; x=1783004364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzdtMgVwHzlp/WK8F9dbK0OiTLbLnYpCESvD8iz7rCw=;
 b=Oa8YmpyZleTz8EAIj2fswrAF5W/7VcKwjomDdEuRK2vgamSo9k4438G45+Rp5rlMDR
 i6r+FZVzl6ronaLWeSMBXP+CTNPXis5eoULZVQaRZ+zuoAXNbFHy5f7RQU/gWZ0EPnPx
 +YBTEVbp2r9dP7cvgz3OaxYx8wzUUi4w8HnJp/FCQNIjB+DjlYB6LGIRlEHLlwkiuut4
 znGrn5+C2BtEMbjjltwgYGz1eTBF8heJUmcg0KIWf3DiLE4iYhrvHZ8OgDpN/ZP1AwlU
 i73xTDfrQ4xxhqMkpuVFLK61NFhwkUT4hxC+SU74UvKcC6WUjm+dxm5oNahVKnsiVfbI
 PECg==
X-Gm-Message-State: AOJu0YySxZHaklQ50aAweJ1Ids+ZzbBticROS0Fye2YJnXI4k0eMf+46
 ciP7nxrEljfdxSCsUOjOixIb7gGBmmY6TFJKt2fthscaDO+rQGiR1tHKkCjHiCWxeJklaW+w9gB
 Zsn/HEt/dKc/Y1TGQoDivRSsG2mTpKiOZ4k4PDDwBgg==
X-Gm-Gg: AfdE7ckMCNX+es6Hex7W7FZPPu2ITbcpIcOdXoWnuq/BqxfjlUv8rg7IO6MQ73RwrYa
 7ZLy/jGabrAiegm4suJ16TnfZAz7GW10FQKKf/XVFcI+B2pv8ujdY2wZBEA+Bh2nAXm+tJe9kfX
 xxuC7cRHb3JFGXFhILmSoKV4WLCF5lOqYrC0td7lGM+2nakbfth6XNTV0v02mAhcLJBTNl9Ac5p
 S818/euil+X63KCatAPSHHGQSdW08VjJsLE+X0Q/+ogDX+6LfZNfXqYyStl0id1OLWgJzcZx8Nw
 1d01LwY9GY/qx0i213vCQcsT9fRH9BonM9t2umf4xb+pCI2LweaTEydbk5AGsb5gCac=
X-Received: by 2002:a05:690e:4386:b0:662:8a91:f034 with SMTP id
 956f58d0204a3-66487d83b10mr1656826d50.38.1782399563852; Thu, 25 Jun 2026
 07:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260623170354.43981-1-163wangjack@gmail.com>
 <20260623170354.43981-3-163wangjack@gmail.com>
In-Reply-To: <20260623170354.43981-3-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 15:59:12 +0100
X-Gm-Features: AVVi8CcAN68-jUD6W6jP4xsWl5dBErSXJVYSI8N79sP_1tddjMvjBV9yVsO1IIY
Message-ID: <CAFEAcA-XeUSW5h9ATR196uTMXVr6OXtfgXjpCFNv5p3yArtcUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/misc/imx25_ccm: Replace DPRINTF with trace events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "open list:i.MX25 PDK" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 23 Jun 2026 at 18:04, jack wang <163wangjack@gmail.com> wrote:
>
> ---
>  hw/misc/imx25_ccm.c  | 34 ++++++++++------------------------
>  hw/misc/trace-events |  9 +++++++++
>  2 files changed, 19 insertions(+), 24 deletions(-)

This patch and patch 3 are missing your Signed-off-by:
line; we can't take them without it.


> -    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx25_ccm_reg_name(offset >> 2),
> -            (uint32_t)value);
> +    trace_imx25_ccm_write(imx25_ccm_reg_name(offset >> 2), (uint32_t)value);

You can drop the uint32_t cast here. We needed it with DPRINTF
because that's a variadic function. But the trace version
is a normal function and because the argument's type there
is uint32_t C will do the conversion for us automatically.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

