Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A901FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHg83-0006WF-NV; Tue, 28 Apr 2026 06:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHg81-0006Vw-OI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:57:21 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHg80-0004Bt-1I
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:57:21 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6501547d7edso10429819d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 03:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777373838; cv=none;
 d=google.com; s=arc-20240605;
 b=KEfKKWkJLwPL9bYIMwmKwpMhugw7wXRaMwBhpCD1mzI/rXXIh7N5TWCE6F5bxAeLuE
 OdRrzD+sAotTHBnYzzUv7Hnx7J1MMuAXWbZVN9ZEg2t8p0giaNDY1u7b6D/cR2lvUKLV
 QxcDD1lDCmYcUAUNoD2hzXj1iDSxNvVSZeIKuQPOjajdTJgTv/ySvNHducMtOZ+onpNB
 St/e/u2VxYAUT47qHw2vC857MFVglygqkndBk/kGrWtMWAuNHqJRtc9nbbVVoVplaPRr
 KGpwa/1b2Ht0MiPgYsyNpL92eWFbhAOY4qYDS8xnS+tQpx6FUsLvven1t9vzhSkmUbXG
 N9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OBAvmJZzvIkI3Xlg3xS7iYIU6kQ01BvEEeAFoUTxU+w=;
 fh=5hpO1k+4pWDxQ9oa5Nh4x0RcpkpENqy649CApJlWSfY=;
 b=juJN2qtM+6E6GMXV36fW7acPreFlWl37Ay5s1BXAz6bpbzOtpU7O3YTqCjXKfZHTxv
 qSNpoMoqtfE4GEk2+oP/AjpviGu4Py8iOd9GtPeuVu+HnCa/7CJRaHEmitooPkmfbAFu
 vH3tB9h+5lwQrwM7eghv6r1vB849S4QHj4JaA2X3/MwZr117NcpaeGetjM3X+Is2S+Gi
 E4HBu+ehcCJTLH/EHELm+r50fpcZz/UB7GXBhg/vA1n8VGi4djcVN21ILMCjTtrN4ctR
 1jzIKKyQY5qtuXqoKmeqV0XRZbxdCWnmaRN5zwnK7dZtnU+446nKMkz+23MMGDuTCR23
 1qQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777373838; x=1777978638; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBAvmJZzvIkI3Xlg3xS7iYIU6kQ01BvEEeAFoUTxU+w=;
 b=aLwCteCHggpCBl5y1sy+5ixw29ttjkM1n5uW9VM38nnrdPX1X0gg4Kyn7JHoiwjVND
 r0kWPerFbGdcl/cHStdKtCSJNsiXw0+54NJLW9cG7nm2aWdTklL9LOtDl8/wD17YBwbE
 lwzWeYV7wTJmjlMTifAgh8pKvoMKGdW85rLyhO/tEPbpTcZ85qc+LEcMX9XBraEXGHVu
 xKit/WIVlUC8VERFc5hyBt+Ar6vZNnZdZ06TmYEOOl+UL1NSZENgIZH9iiYYi3gXsPSw
 rV40vrcrJ3dobekXU4kr/VTmh3pe7qF4liNqI1o0zWbUl2BlYIuWZTa7/21Ouu0OXMyJ
 bFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777373838; x=1777978638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBAvmJZzvIkI3Xlg3xS7iYIU6kQ01BvEEeAFoUTxU+w=;
 b=dm8bQWxsKWKF6WdaH5zjoRO3MhxFpxj7oTtvxuSSBEv24KpsbAoCMUPhS0qachEir4
 zIAf7Eb8grj1Ol5DGZ6e02BEZ1zqmmqNgUbJ1iAAxYWSraJV06jaohYyMcdgG2sqEpfK
 yvF5cbXNNlkmpZpL52dWxbbywazxhAulLP4/UQ6ZDUhzApWwPvZAYBnIJrKG7QumE1JM
 TakyALLN3/dOSnYXXj3WctYW/micRENJ3vsb5YjMytN+h4YYq6nLa9cugFjZ3o+KtBS3
 S5rgKS6AKpnjFuwYtt7vN03fSbY3eXPvqnFhL29KrV5Y1MkRFSv7dMWnSWKtSQgDhPJr
 uSnQ==
X-Gm-Message-State: AOJu0YyZoaE8nf0wth2kl2Z1BTFbg/aXj57u3Eh1WsZgGVo3FoBAOimA
 6pjRyOT690L1M2S/+eKTGvW1xjBy6T5DGRfQFu5RTtIhD1Hux+O6lU/HGtguNdLnNBsrB1VOFLF
 YTiljWpu2iKrLJ7xFZXV2wwRkHE/5WFAvP2n0L8Z79g==
X-Gm-Gg: AeBDies5Cy4OS2AHqnj5Q5bdFFo+h9phr9ZpfrJBMuuo/aSzWq+aLxLg1/dGuktgpQA
 Tqh34AqEsk0VoVlJPKtUWEUymYXFUvG9med9Z6CF6MsbbTfroRzT7tFbC//0fryfgWpHPwcX3go
 89PQtxkDRWqbnRzaBIG+7Tjr9zhmI50OVguSMKcE6xLaODQbix0DQVvbzBVm3CenC2xUvPQR02g
 PIKDdljUCLhH0ppxMQ9twZCIUhY5W+73piwPoXY8CNO00A0DvYkCBBid2dWHHEd+S7biw48rrq1
 ZqpprJDz8UVkFI26u4l10cH9V0nSc7/POu3I/VgDkq416t03HwVOpKRHBgMRkImVIF6yqYtOZw+
 ah6JvVwjjWCcP
X-Received: by 2002:a05:690e:1482:b0:649:e6de:8f4a with SMTP id
 956f58d0204a3-65beee55532mr2113624d50.42.1777373838377; Tue, 28 Apr 2026
 03:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260409035015.132370-1-richard.henderson@linaro.org>
In-Reply-To: <20260409035015.132370-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 11:57:07 +0100
X-Gm-Features: AVHnY4IAs_L7jY7gvXtX6WYx0bSTSZKudbd0tYKZwesq7MzoA-dFzrprx2Zz-k4
Message-ID: <CAFEAcA-fht7aCnsScrhAvuP0=pnPAnNOJMwCTo5wqhHaU-eeaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] target/arm: Remove bswap_code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Apr 2026 at 04:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260407222208.271838-1-pierrick.bouvier@linaro.org
> ("[PATCH v11 00/21] target/arm: single-binary")
>
> Version 2 here should probably be RFC.  This time around, all
> instruction loading, and more decode, is done by translate.
> A new CPUARMState field is added for passing data to EXCP_SWI
> and EXCP_NWFPE.
>
>
> r~
>
>
> Richard Henderson (7):
>   linux-user/arm: Restrict regpairs_aligned
>   target/arm: Only define aarch64_untagged_addr for aarch64
>   target/arm: Segregate target-specific user-only fields
>   target/arm: Store SVC immediate for user-only
>   target/arm: Recognize linux faux BPKT
>   target/arm: Introduce EXCP_NWFPE
>   target/arm: Remove bswap_code

I'm not sure about the SVC part, but I'm definitely
not very enthusiastic about the BKPT and NWFPE pieces
moving into target/arm. I prefer the existing split
where (as far as reasonably feasible) target/arm is
architectural stuff, and things that are matching behaviour
of the Linux kernel for user-mode (nwfpe, odd bpkt insn,
user-page helpers, etc) stay in linux-user.

thanks
-- PMM

