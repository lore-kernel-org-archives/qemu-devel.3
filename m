Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A28C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6dT-00020m-UV; Fri, 26 Jun 2026 09:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6dR-0001xu-Ry
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:30:21 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6dQ-00056S-Db
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:30:21 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-662c360aa73so1062859d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480619; cv=none;
 d=google.com; s=arc-20260327;
 b=ItGEBXCyTA1J/PilF2Rkr3kRW233S80cjy5h0t7yd/o9wpeVhcdRoQrmsqNTbNderD
 zD5K2dyVn/FL0gEPRoe8GjTmiCCtWwiABUnhQnHngwu0rpGtzlNDUsZarTrZ1qmbyA6t
 LSNqw5J2sTC8JXCn81nYeNq+t/uNEhnvISSURACa2CK5EIfkJ9e8jg3jWMZTzfy61AAo
 OivRLw8RQv5pljNo1NmZ7FGdd2BrUKM2cXMloPE21f9ElvhRiqVazqxhpgBY/aORSFtj
 WwQ2ITsyyL4OgwsuisIDJc1dayZ33STuDAaFA0n19U1YgSAjOm9Ee6fa5RdQpiYSpaKu
 z1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iQPU1fcB0barELB2ABXUvww6NvvhuhNrEJiOJIcI1wE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=MpgKJgyCaRAHSiWy5gYAKqsmxqiHVRZfx5Ukkjl3/dNSh6dwGgbkRXflIzCKcBuiU9
 Uql3kryd1rYeMabTp2UiFwnEGOUUYW58rtQcXdICsOdgignHDEKM0TUf2zZfY/4yQuui
 TBxR6i+P/zH7ltRt3fFpFCHR2bnY4fFQp21uTy9+cVw1VXboow0sW2LXwEsnZtpaeFSx
 8s6ZnXZJI3j5emJ+Z+HiP5wimCGQTWl5/Se9hkR4D1s237H5SGBk5tsTZJY1CJ3p+gAZ
 YiMfM0+p26AwEcOo/GhNKpS5XlJOVcrLJLAknz+5ZjugpIIYTVHH5GphjNlbMkrEyhvo
 OqUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480619; x=1783085419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iQPU1fcB0barELB2ABXUvww6NvvhuhNrEJiOJIcI1wE=;
 b=yGW5jAM5/4aWmgARJifSLx/Gywwnnq1Fb1P5p7SV0kiFL2vIRSVqDPS4Mx0FXVKBd3
 BttZLY3JwI2CYvTaPRZuuunWWZxq3x/Vij0DvIEO5k6eylXOJpAj2R/dAXJ4FUg1XgVj
 Cq07d4482EDXrvlf6vhZdw9vp+714N6Ses6hxra0vNEAjhDNV5NlGhtYQCmRzd4/wAs7
 v7pwWhwzcGPbNOuyEmhVzOPn9yrXWIwtXLmsCO/qXo4HqrXYWuxjxZjfSf7BcmligiWV
 wu/nYO/RUE4ieLb2zx+FsfmFfK5X9cVRZ9TducMQ+vknDFGGlr9EsARwOBiqH3up47BG
 TZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480619; x=1783085419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQPU1fcB0barELB2ABXUvww6NvvhuhNrEJiOJIcI1wE=;
 b=RQuh4IUOrfO6dMV/UutwvjguWuk9od2tZajxNbGN6R+EkOHwkXfwxa0c1W3HKtb9M3
 +3mhf/zV99l3+5R1JvxImshHmo0s9Xt6qTlonkkXBaz/IiPpUvWZsrpOe997IJYGQYsa
 yVPBUDWkH2jWxRh5wpNtAySIY2cKyucV9WKxfNjYanS19PjIEiQFk274F8kZOLh3toq2
 HHCz0TsCPTUZ4ZJjv6zxiebj5NwhKoiWDb/pucHzRtemjN7lXDKItUh/O4Dz2Cwz8ICf
 DPUWrt/1TmROmCEJnHU0z1il6RXXM8+2YysSDXWhBf2bxg8RRSUaw5w3GPG1dU2x1pel
 YnwQ==
X-Gm-Message-State: AOJu0Yz1e7FbQV7SbnqoNVhXR+m/S8reCvYYrQMVqquD4h5IacVJoQf0
 eJGkDxbjHvpRN163rxN/U0fKTx0Uq5kqvPl0GgYKHCLEu/9KByKBoPygzn/j06aa6G0Czz7+gYf
 1q321ZFewKOkhxL9/hZbZ14ArEFUrqRVmkiuksqymKRYbCHodFy9n6IIrU4Dj
X-Gm-Gg: AfdE7cmx2R/xrbusbhpH+O/heo3z0e4bFGcNpw+f9ucgztNraUTyyuT8tN2u87srA/D
 AfSGoGhMIngjCSx5F6VuV0BULA9YO0Gqf2gdZLh+edxyJgb5/XoxtrZAFGdpq1OfhIUGbmf8+2x
 aXPoKTFID/nOjLgFcksce5qkTCSAEgNFzEGZxR83/4I1TNPWZVsh/w4IExe3P//kn5cyTEMNAC4
 8sg64sTT0/mJv1JQBjewBuPe00T4kftsHzMaaHrb4sgSH5AKR75/On55XPebFjJraaONWD5+LMp
 unLkKdWTjlE/Fzfo4QazbtLJrC5Ge9GCm8pAPBC3rltH3xuw1wtD5l8V
X-Received: by 2002:a05:690e:4809:b0:662:f405:5d41 with SMTP id
 956f58d0204a3-66487f9a1eemr3806277d50.33.1782480618881; Fri, 26 Jun 2026
 06:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-12-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:30:06 +0100
X-Gm-Features: AVVi8Cc25qPp3O8IVQFJq62LoALCyZE8cRR1kDz1-E0BPfnS37kMZ7eiDXQlJ6c
Message-ID: <CAFEAcA9Zv-kWJ1RKGBekg73it_q1Q0PEfuj8ho6WgwPUXmzUDg@mail.gmail.com>
Subject: Re: [PATCH 11/15] target/arm: Implement SUMOP4[AS]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Thu, 25 Jun 2026 at 23:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

