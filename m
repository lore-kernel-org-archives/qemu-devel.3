Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2100CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4e4-0003yL-Sb; Thu, 21 May 2026 10:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ4e2-0003wD-7s
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:45:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ4e0-0003Vr-NS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:45:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso5785528f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374703; x=1779979503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=783MGJ2QrLOoE3gfkfV0O2PFHK/94YQhK6UM2ldYWwI=;
 b=yOrvwrEbGebbX+ph3kYrgA9PGzh2IbeWZNGcPnZufRL1yo44rax7npLCdF+NA5q5Xc
 ctzuhMpAxVDQ7cl7iDzLsUoBq37mygOPCIfb39p/XDri5sUif4IoKFIOFQTXmpxCNCz3
 2MYF4rXM2zBg08nxSdAzD6TJSK16TiLQy0Iu7wWpn7YkrfIVNRLx8SFWWPblQSlr5lo+
 rkEsRphedUMFP1fD5oik+y7FwvaPWv/pvwl6qUYK68Lau/pS9AXN21oIW0zW5K+MBG17
 IMB+2xiwSJjWM9dOwihJi5DB6KuWPqqdcre/KLuWCY/QIxd3HqgQz6E8/Haxs3YqWTJf
 RFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374703; x=1779979503;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=783MGJ2QrLOoE3gfkfV0O2PFHK/94YQhK6UM2ldYWwI=;
 b=f9vosoJp/6zEUO36OEutWHZzrVHIvenNwa4Qz8eL8w4VGQ8xaZkOTANg8lxcn+RGhz
 nV7ADqGamknjqyYT8EQPXx0XsCDDGs4A38la8e88RhJVrM4w+q3vbN8y7HDGvTa1/NQw
 +deq9uMIvEzMYkM/1a3cAY79cBLVLJIGujasmsZW6WyErE60YMJ2/FXOZh/wPgx5OAZM
 Pjo54r39l9jKGVu0UqZnmMlheFc0MqNgthVrU30OljesxDk3/FufufvzeVhy6miYLb6e
 KkklDLRL1UTNpTHh5xJx+YdNGZ5KA3XGUVqZXL/XvW9j1EbLkoaZsNqi6va3vEusvMKY
 EbVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZQrf2zKZkgTNZWQMtjAhp2lEyoyUKYXm6mDWvio54aONIq3Gulj234De5NMfiqT43/5ZfZgiXuVqo@nongnu.org
X-Gm-Message-State: AOJu0YxC6TUClkvvgszuZP09y6gAXLyuTBZsRcCkT38VCdGsoUQtNZCg
 0+/ObFa8plV05r22ufDMVvO5LtYZncaXt8mIZAr5Bp/z2j7vg2Y1auhClgweE01SgYs=
X-Gm-Gg: Acq92OF2VR/xmWFYvAMeByB4QtNNNbz6QBonMcnblc5AinHqXkWTJznudvkV++MN1yK
 sWSKy91mtaHVTZtR3OPfxu9X4zhIA3nk+AvmkcYm0RiKs/2OEYjPQsV/J2C8sXmeywFvq1Cmvgo
 +x7XBNVOXCozbZy9Znk08X9ARMuJ/2VCQgJ4WuPtf39yEt9hmG4g5EMUijzwPucA5mUfwF6G5oi
 /8PUssl1OFPw/j+mNmjJcBGqcJzXdFfRMUZM2L3doBOB+fBVY7nAHjD0ko6EljOZRRfF/KnJLFn
 wYvPZFkb8oHziCOWVT6a3S5c20pkvqgT9BIkPEj/V8oP66V9gjA8PXoC6e5ZEKdhummZ7TGSgCv
 c5zP6LVi8GhnZHpgjdOAw4EmCm9xV/zKrr+itIpWNgGZfwZqFTQTwJD21aHL4Ucypz+t3A5pDJC
 M5A8c14jCwf82wGw/kBT7lGt8gyCjm5IhY/A==
X-Received: by 2002:a05:6000:25ed:b0:44f:da26:cbb4 with SMTP id
 ffacd0b85a97d-45ea38d9f0bmr5368576f8f.21.1779374702745; 
 Thu, 21 May 2026 07:45:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa9358d0sm3071266f8f.26.2026.05.21.07.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:45:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 213E05F886;
 Thu, 21 May 2026 15:45:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] target/arm: SVE2 FMAXP, FMINP must honour AH=1
In-Reply-To: <20260521122913.1565011-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 21 May 2026 13:29:11 +0100")
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
 <20260521122913.1565011-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 15:45:01 +0100
Message-ID: <87se7kom8i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The behaviour of floating-point maximum and minimum insns has
> some odd special cases when FPCR.AH=3D1. We get this right in most
> places (for instance, the ASIMD FMAXP, FMINP) but forgot about
> it for the SVE2 versions of FMAXP and FMINP.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 384433e70983 ("target/arm: Implement FPCR.AH semantics for FMINP a=
nd FMAXP")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

