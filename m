Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F57FC83F27
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 13:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ud7Gf-0003VM-Lw; Sat, 19 Jul 2025 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ud7G3-0003JP-LC
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 09:05:43 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ud7G1-0002W4-Rz
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 09:05:43 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7115e32802bso19494567b3.1
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752930340; x=1753535140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rdHWqNjsEnKnYyOJlz9vzA1k2nB8gSpn71TCjUsXRgY=;
 b=oTKRdxI8M2cFjKvwe0uvkFiu9QHoA7iuMxA7ISwDLhIWUorEPXlqx/1HOk8D2leqfY
 k5Y6WjusiYAxhox+01LnuSgaxHFMDnH7AxhWwG5E1Z3v6752WBlNVf0kptNcr3GoFPp9
 1wQyL1RnmEiuLvbMdmGmt/I9FEVUum8vaKSoB7Ma/ngA1yiqF2vBkJjB3AAgvkXKvBQC
 8BjA/4SRXnQClAKXwix7YXg36KbFQfgmZz7qPpemeM/3dCUwogm4K1W0VXtq+eBGhGyE
 6KDx7kkxppIVi70KjYPqrO+Jgix7KUBnvTthjezMWb6Ug6yGNplV1BWCMXLdvi4scXdP
 vLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752930340; x=1753535140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdHWqNjsEnKnYyOJlz9vzA1k2nB8gSpn71TCjUsXRgY=;
 b=lAEj4vb+unObE+5YILDRtqdW5eJMMUzvRxoA+NbSx+EqI3P7SZOIwizACLtLHsJD92
 ITO6aPLKkeRN8OZdFlXdhCwMUZfxE6ehl/2RWWpo1GFlS4/H71yWIbkx51DwIj2UfLIe
 AO2FGjrIT4WyMXwuai0E/SKXt59zGm/Qs07C095BeGX5W94ZEro1EWDWBtDUqAz8vXfm
 EH1gXAF5abzWrAn9OjeAxddN+bQrdcifz5dNU8wvX+5iE3Dwo1iBAbeCxq5pXx5fztkn
 nr/IOuzhZhH35tTHsH5FZvg6Kyh0UWWyh1zD6ZQCLRhWI5M+D4VN6KzkYp0ZZgqCg1ra
 AQkA==
X-Gm-Message-State: AOJu0Yy0rN599VLWOIC4QAO3u8ITgbl3k3NWNVvsu+xFpvNfqAsSJD3l
 xbNIX7p0J0zwpy12P2PZhRgn00+xhvM/sbPfWp5NBxueEswxt0TnUF47sSJGN/+exOVqT1GkK4a
 JcLAhW6cY6S5SqCC+LKdDBbw6VeZ00Ik10+Ucx5MDfg==
X-Gm-Gg: ASbGncthklrptpqdw9zRJIfByXkmYoTcC+0nBzLRTnnYd0TXYGsJC6iTvxFhsg1ifUH
 L+D+JPvL/3oqVn7nLPGZlktdvsDSREvkiYjcmlGNGpuZVE7O6+gZb043INohBVd8BDsLbWUNtWL
 fqqWSqYZSVh5Zmeul5YH7O11D0yk2YznQX6S5f3D/nVNHePNC8p5bm1d3GsDMQ6xfMVAUBqe9RI
 d0wAjNr
X-Google-Smtp-Source: AGHT+IGBf/8Ag7+EBypnztfy5PiHmawAljeExdqPVCQvhTa4tNo/j9AnT573Wao9PPZAlpCv1u44AWTpfRx8omI3QMw=
X-Received: by 2002:a05:690c:6602:b0:719:4ef4:ff4e with SMTP id
 00721157ae682-7194ef51797mr76456897b3.9.1752930339990; Sat, 19 Jul 2025
 06:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250718173832.47820-1-richard.henderson@linaro.org>
In-Reply-To: <20250718173832.47820-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 14:05:28 +0100
X-Gm-Features: Ac12FXyEQKcgOuSBgzbWHd8nQ268wwvwHL3J58iLsOILJADL-50-IWxVx83wckA
Message-ID: <CAFEAcA_eGk0Dzaw_pdTG=gUSjwGjThxvOd0fcSOEf6M-cHs4bw@mail.gmail.com>
Subject: Re: [PATCH for-10.1] tcg/optimize: Don't fold INDEX_op_and_vec to
 extract
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org
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

On Fri, 18 Jul 2025 at 18:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is no such thing as vector extract.
>
> Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

