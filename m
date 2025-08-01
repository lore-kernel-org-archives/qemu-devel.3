Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9820AC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvC3-0003Lo-KS; Fri, 01 Aug 2025 15:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtcw-0002gG-O5
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:33:12 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtcv-0004Nk-78
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:33:06 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71b71a8d561so9465127b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069584; x=1754674384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+oKFPoxa17L30Apq6AbtGxo6W+Y0e3K0GUlF/Z3Xdkg=;
 b=RyXNbhvhJcJUa6+dTahOT3F6QiLOUUC7X+F+JRYqImgL7qnQ1ZEocj4qG68fKMV7Dk
 Hq6tmx4CMl4WzOwUrCtecczDPi3ZvLr7FYk20gG44ppvcDt4dDLVPCbVRPS5HsVpAGjp
 +ud1JZu86ujUhRLbDVkKuQ+GfETfiOW6rxkj/lrpU13ny3JWDFVfCwGeePDNSOunFpE3
 tUY6wTn0dInTNp9xJXTIJ3CgKW6AoM6Rc8+3WREzgNMynWvpMzgzGRq70M0/hV7s93Rk
 F4JW8eojFDXJhP9I45fOaBNBdK+hDhLVsbNX4o3wXJDGiofk5XUewPnAkxmh9qprRPyA
 XiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069584; x=1754674384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oKFPoxa17L30Apq6AbtGxo6W+Y0e3K0GUlF/Z3Xdkg=;
 b=mxGdzAmCi9JwWHTJjwgtEtKnn5mcpvzSU75ke8yKx9pMxqVrcqNEA2aozX3vCZGdI1
 elXdLDPZnOFmqWGe6HBwX/+zTE15d4AxLUsmJp6rXMkTkoMm7nLTLwG+ra0991hbhs0q
 klkmYANxL8xBZo29ipGUjc1lf5dd7k/w5COFYjorW7VYDMpT9gCFdicnkeuGRH2eW6Xp
 oOvHtT/DqI4Zyqz9+jgl/ciIKjGJU5skYYoOELIfW35P8ZvLfZ928gfWkmR7gXwhUXMx
 b3Iklz1rEXJnLqntX2kGNuRMaHZsz3DlMJexyO2DfYhe2Wof/rbv9QhxfkEvfktmSU/3
 2OWw==
X-Gm-Message-State: AOJu0YxuyW8sxm7tKaQmMuMkW4sUIxrBiCXc2Xjmrg+QyjYVCTsogXdA
 LyRrf69N9Fq2wBfD20S+THhe9+RlzcggIEXAeXNXLom+08FXbWyDC0RekQp566RSW/UCaq+bMHb
 6gCz+q3nOKOcHTgxSue75YOdJFK3wSMPZXpDpzqLd+Q==
X-Gm-Gg: ASbGncsuMHACAxehfhnuligW2BkKuIQswvPcEPrFp6QYF8E/u0oUVx0CZcl6pH6kDfk
 LwSBbbFcCXfSLgR+mAyXDXdSmxgyGfv8KmjkvbGS96fKnwcAfXGPS2x424IafFKSvLnNOAom/h8
 ezwbVdRo6lx5wZjGI/Lwm7VZf9ZxDpnAiT6bh8KlM6sYniz83dyTVjczkZ9RZHRCgq5khYcn9Aj
 jGQGJbaa+bavvyceIY=
X-Google-Smtp-Source: AGHT+IG01G8cy0llHWgKtBeRjUNLObclItiehQLKFXsTnKQ2mjlp+sHZuenchwshdh4GwToQ8E+S3RZus7/PjZ8vzVI=
X-Received: by 2002:a05:690c:ed3:b0:71b:68ab:8bf9 with SMTP id
 00721157ae682-71b7ed12778mr8790887b3.1.1754069584136; Fri, 01 Aug 2025
 10:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-37-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:32:52 +0100
X-Gm-Features: Ac12FXzYKCM3UvlJ_SO4d-jyFOT5Nv7ss-UbBRH67ogjKnAbYRG_-ecp8Je0BPo
Message-ID: <CAFEAcA-FmkK=P433y-DkTgXMTd+fOvOmst43TakxAbhbUbkQ2A@mail.gmail.com>
Subject: Re: [PATCH 36/89] linux-user/riscv: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 30 Jul 2025 at 01:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

