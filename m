Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F49CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3iP-0005s5-Vx; Thu, 21 May 2026 09:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3iG-0005hj-Vz
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:45:26 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3iE-0001aF-Ry
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:45:24 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c477a3278so6471718d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779371121; cv=none;
 d=google.com; s=arc-20240605;
 b=M5HD1aGkyLKQrspOYWKQI/p54Pnkjm5rJbW06cdU0lT5En4q+g36Nd5nz4I+kDpocy
 apZXKX/fX+7sqn8fnyUfNmNPPTfYf+bUp4vhcIoBAPccvlZRoq0Lo8NauyNFYAR/0g4g
 9QGHuk70oUknTLXsRY2hlcsWZ7Brod44eTE8k2NFkKci0huApYmcwYWKx5a5VNcqZPvK
 75uPaoPuZznyJOtnNyC2FJlA8Z+3GcS5MAcEygd6nld1dJrCeHlrvBGX9Mx3spCDmddw
 p9ctYg92ObzgEbIOnZzQ6BaYAjhW89lgS8EguNTj2pQcve/n0CnzjtJH+RUz63fXF8k3
 JwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hR6Kgi/hPq20tUIiVCeUY55XQJ4DT1x75IeZjfiM8RY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=H4tUcYhjisw9OjO0LPm/Uqx+6xeYNeosdjPTot/XutCLAM+f0aYy3Z+/l7o54lpX1O
 LH1pSrWcj99qqdIGQfEfs2GOrycBKM1htGzY1Svyoy9QTL69g3LSQxsNm3PPw6/qtg3k
 Q9Jm3EkXop/T0wxGBj4bqL9cIdnMvNqwzdXi7Q2BUjLcF+JubCrRX8tl4vtbKDUo7Yrl
 IrV88F+8Qv+zYDMPxV43xg6SnKSYjIVh0836qUvOty7up6HPg9c+GGYRXMm1ZiRe72xU
 y8SG7vYGI9gG4888Cst7i9M536L2gzu+9p6jRx5hzTivEJj50QDcqoOnkF6F+3zCbU4b
 o3tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779371121; x=1779975921; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hR6Kgi/hPq20tUIiVCeUY55XQJ4DT1x75IeZjfiM8RY=;
 b=u4XPtR16PhODjCCfMW/xt/9YMYD7PnODHyWir6H6+ZH1uWuY12yia2WdTb5+faEFB8
 h6SiQhsP5hripJaTzwC+49qltAzZU1GYTcs8u3uZRzI+Aew+6yyy16DU4L5VKatIf16O
 R7q1C0FPalqgq/8tfwXsAxtNRzuQdkSfuVVdhNZMnNt9WHLMBVHfArlA5QL8s12RY0HG
 UpHCRzmuQ10X9U5DzG3tOYslk7ZOot6mqJID0OPHGeBIwrPaOd4+3y7l5CamnpWcwbv0
 QJaqF/fOQp45ShVRyfmH0DGzHVvCUn1dN3+2sJaDD2UBRdZvuYR4EkusNyAZCSvFiiBt
 3yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371121; x=1779975921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hR6Kgi/hPq20tUIiVCeUY55XQJ4DT1x75IeZjfiM8RY=;
 b=KbvB0qod0FudNKLuj/MFLUukqA0f20un2a9u0WA1dYByMo8Sz6oVZPbjZaYOYS2jaQ
 0K9FpA9WKF2tbSd3NmnkfmueLlfZSD2F8dZlP1QfWvCZ1VUPcTm9ZZ2sq2e29JLcIlPV
 VxUda1lxG96gokcZwct7GU90sFVxjNf36ABtMRiQ/5pifiCSfeF+/IYshJGoB1BZyvsQ
 7nVdtLCd1OcI0r1AMWjdO8CJizxsa9asqkHEybKj6NZ31e+NzTJ2HNczWzyh5FkBgeKB
 YT3Sgj9yVAvzweRUvulKe9PG4CsbHuFwpkzB+9qdPT85CgrDeoIzcfIyl9fmOPcPCgDn
 L75g==
X-Gm-Message-State: AOJu0YygXccR4460v/8F6nUMgUVXV29M+7qWCFy+Hew3IK5I7NQtko93
 keX5MScoepX5naVdYYJoyea7JVlGF7306P985PU8hRQkBbyp/m+POpwzCrbawL5JJfBp8FhTfGa
 SS28Ud6W4KUckvcry0dYbT+7mZrOc6tyMuhUWH/4S1g==
X-Gm-Gg: Acq92OHLInvbdXqYdnXNPEICLFW4pg6Ge5sVwfBfKiX1RWHb9TVXR4RZi7aYQrW/tnZ
 uxO4hxpfe+SBGKpuTO6f8dKNMeHA+2Txr3rtkGYnep2U1Hh6mIz5OXGsgyKWRPzY8WmEc4V9+14
 sbScmuCQ0iMT21dHZM+MqD15f5rcO43OniOFu/8mxU+q908DF5dxqcsW+cIOFeTn0wvG2SnDxXt
 G+gxCU0fEcIDAiA3naU6WynDOlFCj13a2Xmc/EK3fKgafgn42gP1HsRPvbzhtI6glEczy/ywCww
 c+fzq52PUPx2JJzz2mRzP6gJTvq+BpBuahU0Bw2zu8CbgDiFNUW/CjWZS9F+CT1w1Mc=
X-Received: by 2002:a05:690e:1389:b0:65c:4889:30b3 with SMTP id
 956f58d0204a3-65eae34d005mr2784093d50.60.1779371121089; Thu, 21 May 2026
 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-4-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:45:09 +0100
X-Gm-Features: AVHnY4L4G-rgDvgBniwFTS5dMDZcDiGNffYcdFBarwI7CgK7pXt-c_o2Shvg06c
Message-ID: <CAFEAcA8z5d0=HcMSJB0iQRbmVgTSTFQhXHszqZef6dw9JyzV7g@mail.gmail.com>
Subject: Re: [PATCH v6 03/64] target/arm: Implement FEAT_FAMINMAX for SME
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

On Wed, 20 May 2026 at 19:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since there is no bfloat16 variant of FAMINMAX,
> check for missing function pointer in do_z2z_nn_fpst.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

