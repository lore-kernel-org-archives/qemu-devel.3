Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EB6CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZT8x-0007BL-Tu; Tue, 16 Jun 2026 08:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZT8v-00078z-GR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:43:49 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZT8s-0001PF-0Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:43:48 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66049669d78so4298412d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781613824; cv=none;
 d=google.com; s=arc-20240605;
 b=lO0OIIVvTDH95x5cSVROTHYrYrjt0YzmVY3PqW1td5wanmSpSe+ZLYHu6wzVjBCayU
 rfC76/Pokm8mazYKgGX+hP5PGybJYDFAtRWjNcmzeRzzbjrVuiBCLZwUP/kiLT5gRIrs
 jTHALXd12IV8A2CKrrw2OPZjtoY0CEVQtH5eoFvanhsRY05+ceHXwNB0BmWU4sl1h1sS
 XPIXktZabh3jPttaHng/5LHlskQWZ56YoeV+d0t3PJD87O+J6XTepVssegGCspqsQq7Z
 KJQOH8cgxh0sKa7oLOBHIlS462uPKoNvQh7qcyGQWfRtZn9myzL/yzjvdQ/oHpbyXCWV
 tCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=laoIaVt7WeDw2SyRjKGoOZgX+naUFvyDr9NXQGotLjg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=W63J8p5tsZXwxHFOpHglldC9PfgjLhucokdvpX16Mpik407YUgD1y3K2ZhFfj4CiKe
 tneYR2Iiu+YgVlBkIyrvfcy5fr9AJ6RkqsY3Wgsa8o8XbUZ90tK21/t1UL1zZUqjYdyh
 cgLBnab43Tio9J+tz6NoGsb2NK+HHn6YObxLMRYrqJt2ULmR2GkT2cpQ9IjrOiPhu6U0
 kX6gLwTWDcxe74cPfhfILCagGBUJvo0NljR0/hws/BWT6tYjk10DNMUGYqklFngyPEr1
 W5ATjQJuhL+fmtRm9DhBjgyHSz0Xmre0h86O2KTLKs8EYdlmw8KNEpOSJ0H8UyWOwWoL
 SF8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781613824; x=1782218624; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=laoIaVt7WeDw2SyRjKGoOZgX+naUFvyDr9NXQGotLjg=;
 b=b6/d+hnhVIKmK0TPMcrQKvPHGczD5vUu7b90wE82PndZ9qqhZ/IUoQqEH825uIAtTE
 VFlX/XU/imfBGiBdcMSfBGyHhFNhHIKDdeO3z/5ss4rE5FMLYifFjRfwLJy3z/9FCar4
 IdE6OU75t8/qanu5zyxoxrQRDhmXAuyk8y9b08lTnYnxrWwYi1uj1YMm64UXl51fLjzL
 WOuBbKV+Rz9SHS5vibzIXLl5oVyd4v8uMYLoEjApMEC3++Ok3Sp9edVu+ePzybRgcyn4
 +T6Z5y+fl21f+ajYKqa/YzTZkfYO+PE29AumxrQdPG7mY8NL26VgF3o+egVzSTG7HWqS
 4WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613824; x=1782218624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laoIaVt7WeDw2SyRjKGoOZgX+naUFvyDr9NXQGotLjg=;
 b=mdNQuGep1Dz9V34sJIvazdrEff3U/su54/I84MVVt2A6xaQC7Fpp6rYzxwmKoSwxer
 vfLNfcXra1dliJzSD5CeBJhABWLXHBORj9l8kHzqcaYOdYZYqAvYJPlUVbFcZ1WJXbNO
 v3JVN1IXTQEXL+VPnJuntAf+5eEL8U83cZbWk5qozTTg7N/QZctEh7eQqMS36e3Odhca
 GjpdHIWVfXrjllDHafU9+cO0FRP9oEiwBrxA0qHBlrSDXrNotV9yKx/NFv1JNcDSxGw1
 YGCl7IZjuT3xs44VHGREUI1vZe6gHY2qngo4CzONjolPyFw+5F10v4qkjK5JHn0lEET+
 QFYg==
X-Gm-Message-State: AOJu0YydoyDfHdOZ+htJeoq4M4fGvlCDfPV9wwhYbczhJ+i7Q7yEXjbm
 nLytHU6+ZOXWSSScmcxSsV3pTtDntA6FoJWMK6MjIVTh/iYThuONcer884YIM+qMmaVRgCJ26lZ
 rGi53oMP3XSgvnGaDDdPDZ0VlMLZbr6HFoLIr+B9j8jDNinzi0L7X
X-Gm-Gg: Acq92OG/GxWGiUThbwypevyuPZLRMEqTTM+bGJVpnf+L3tkWbCm48P1TuQz4htrjURi
 iBzb8MSTfWXszAEltmf+k752OfOqRkDPJ1SEDaRuwi1RmtgFdKujcVNse1/LvQmQjRBzN57k9y7
 0r7KHQbxPBECa1+HO0LnQPylwJLmk4iHzgcW8vUTix1+28FQkSPABAaiq9OZdRAV/e5cRTkEI8n
 iSSqd74S53dXaO/XQz4ULv1Z5ejq2Cv7hhG6+XD6DgrZjL2+nxLrQoKEVy0c0wXGXhkcafXY23h
 bXZCgYd7FKFvC9d+jraVSZoPiTVp100tSro+v2L03TmiP2XRUZLeITdMdCuIPRJPyTfpQ3Im/oT
 TVw==
X-Received: by 2002:a05:690e:12c1:b0:651:cf23:6612 with SMTP id
 956f58d0204a3-662782d7051mr14533944d50.34.1781613823960; Tue, 16 Jun 2026
 05:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-12-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:43:32 +0100
X-Gm-Features: AVVi8CeaOQ6yPz4_zQYXf4uAJXrN6Y_KF6DsdjE35YC67mTANLchqI-ot9qDvWM
Message-ID: <CAFEAcA8UuBtuZvyQP4bUVoeNcP34o5pTY34Zu-QPXPon_Zy3Bg@mail.gmail.com>
Subject: Re: [PATCH 11/25] target/arm: Implement Floating-point round to
 integral value (predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 5 Jun 2026 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the various FRINT rounding modes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

