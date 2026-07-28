Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AEDC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woje0-0000MD-2P; Tue, 28 Jul 2026 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojdy-0000Jj-9H
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:22:58 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojdu-0000J0-PZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:22:58 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso565496166b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252173; cv=none;
 d=google.com; s=arc-20260327;
 b=NrM5/ARUHziyKyw5MSWA5AqhtKOq/Jlm9PycYUFNObmJ/pTW5apVv/ZgxBUd1UQHkl
 ZPuwHO3ujSsWahPHx9MxZgGUQW/n0C2z+P7uX3V4FnmGAA5vwYwa+B9HS+5Pg4tpZ7mj
 QHKf7vT28NoQ5kC0fV8oh+eFZ3R+4txeqwYQbYmi+ZjCLTzcQN9+JK3apHIky1Fqh2PF
 hgkaORZ/jW1FASkppENGNSZ108KOVh1Aa3vCXf90zP39NvxvyOhF+bpKrkFmqArrGpyx
 I+26D2NJ3q5DJS8m+rKvaXCy9yhVQ++5vtxpJay3DK2l95diwwO4urLDL+yjE6CfjWJo
 cqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ogZvDInZDBn1NFO0Umde521YcougVrryculVQchctzI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=rj9TWqFJDjh+o0d4VhKDlQSofnk/7EQF2zLu1u9yFT8gfnS6dG6byS4Uw+2yfh1vsF
 fizrCLSalDypzZAU3dn042quA/QOdSN10l9qVJl8/vqIoKecskvz6NciYjkv4hx2dTvt
 nH2YUfRx24Ct2DjqBbNBSgKEk+Yt6ybE1hjFRpI7/FIwAL874xrtW80+Wc9nifPJkTst
 gNA1O14CkimL7afXZduS9Mpkywzj7xvbPHuRTekvEXP1gjVANcLgCufrykTTjFqrksUq
 LcdsuhcVWeT1IBnbBvCDU7INhtpHJcmFxjGUv0940YEEEdm6lj+sfNe1o42Kz0DffMui
 75Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252173; x=1785856973; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ogZvDInZDBn1NFO0Umde521YcougVrryculVQchctzI=;
 b=ksj6VXFocBK/BvsFnHM+8c0OgMUJ4DWFHDi62yrfWzv/bITSYdsJ2bA1quyhuD//kX
 R2Rqr28TxyrUMt836teyvJC/2ow2AsGLDuJlCdf/nupg+G8eE7fPAFSlMvNOJhIRjVz+
 n+PtEEqgERscONtMpzmi1O5GVUW/5VCoLVLTI5C7xCIjliISRKrbY+Y35GPH+JjAtOCl
 HafDGKWG+mGUBz0X54ZJ7Ca7KWTk5tYeAGbn79ylANjNUNATXg5GuJRvNJnJjlNKIYG1
 q64pxgo80nQ8dfYWy/l8c7aoLyCcKilPvxL5u7pgjBdXFlmvG1fF/Na4Hl7CYVi1BMny
 R+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252173; x=1785856973;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ogZvDInZDBn1NFO0Umde521YcougVrryculVQchctzI=;
 b=KKAQ91qV9qkSieDq8/KvQMlcqPTD6xXiN1eo+OuldeCWhYbhaIsP6xV8Hm021ICm1n
 6wOQpISX3lyT39r+0PkTsHxTQHrk7cEO8HXdlCdIwTFWVuSAVcepjEhWP1K6iRcOHVLn
 6oDXyLo4UDeidGQyuH6o+cxLAQHk0NUqIfODc3v+C6+Y+5aLL7dst7/jChP67L6JVcSC
 uGOwCm06G7/6ULcxdv2LtAmzkxSHORIVvdj5XXZtOOJR8WsyCbN0Z+QElV9IBR7GeuXm
 fzRcWwQx15Kas7VihDsUAUhKsCeOMLj38Rfw3abMVKvlL1V2fXwjqXKe3X5LGNxfmzig
 H4XQ==
X-Gm-Message-State: AOJu0YxSpUO4mVVhanXcp8gSs/R8QGFHmlT4bcKxoiGb2ky02X1rT1TU
 R1adA088ff+JKBphPTzV0mF37ITmzZKVKNOotl3CqTRsXJITo2cpjokN15xm1acj4zMegFNw57M
 0bk/qfLkoS+e5jlFsOaoRl8JSRrcAxHpLxOksw7VJKA==
X-Gm-Gg: AR+sD12qzuXtxracxuOI333/j4kcIxda+cLz15cTPq210128fqTGhyS7Ek7CKaopGLM
 pFYcsorpsKdLCA38voMk3LswTlErQdnBgQgjyJUcYbZiojZtoW6BrmjyfazTF+V3ULnmTzdbua0
 d3ySQ/fP3P2RQzD3luZ8bCQZ9QRcc5vnNIOwhTFVhESGlnbKrLxnqwa0c842BiY7wlMCDUk4PHr
 VUtroRr1fTlUc2TO+rbrPMGLvQla3N/T9mwYkYjgCfZ8C1lf+HTv+xxn03tl45BrSzKIti+Xxu4
 qDAhMAxr0/WD6z1yV9/V8bbcIb3AGpdWXrH3YTQVjIfrQY7YaVExemPo
X-Received: by 2002:a17:907:a0c8:b0:c16:9ef6:b7da with SMTP id
 a640c23a62f3a-c1f727be1bdmr139367966b.59.1785252173106; Tue, 28 Jul 2026
 08:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-3-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:22:36 +0100
X-Gm-Features: AUfX_mw-J8d96no8_Z8pObvUFwGfaNIpg-ypNV5coC7vBnr6x0wcReD2BOLLTUs
Message-ID: <CAFEAcA_-2+A9VSa6xP=_U=kjpemohDVP5yLf2sA49Qq2PA5GYQ@mail.gmail.com>
Subject: Re: [PATCH 02/20] target/arm: Remove DO_ZPZZ_FP_B16 from
 translate-sme.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Tue, 21 Jul 2026 at 19:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Expand the macro at each use site.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 59 ++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 13 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

