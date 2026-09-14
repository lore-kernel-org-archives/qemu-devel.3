Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE2C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x654y-0000sc-Lg; Mon, 14 Sep 2026 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x654v-0000s0-HQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:42:31 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x654t-00021x-77
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:42:28 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab201f9so1482184d50.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 04:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789386146; cv=none;
 d=google.com; s=arc-20260327;
 b=mpA5HSgijAH0klqc64FQjws4QBcGeUSvdMOdswLwR0kYp7lwfgsXISP0SDZSKJFQ6n
 DGFd4TSf5WOaOraXvIMKaH0uDfhU2cSYdWCkONvCTntbui5CiQZiRrxXmvvfoOEOYqqM
 03sNDv4cTBlVOFS6oYnBqU6j6J2pTcmsyV6HDeZdsVZUddI9PaX14JxCUEMVD21GIg0m
 4WFHgWN7Xi6uNwgHctAMqgSSNptTJmKT90Nh6Nb8TRY4UJeMaHCmbXxgyFFfreAZTlRw
 IuDgVdJyCmIEwvu0PDX26XGCRdEtfwUZ/vOdbL6Txtei+5prin1vb5WaYpzxpvOhaQyf
 Ka3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CqjmCk3ShyWFBpfTGrnIxPC2Rp2QWi8mLEyLTcq2rms=;
 fh=xoyGy1iXIjKzL/Jt4FlK7pqK0c/MEWF211lTqootSvs=;
 b=rXJyyS3NVZIioAf53zYxXVyjRwSsRjCxaUTvCaUOiSpoZfNKoQ/Vst5VGbbEfbrj7+
 L5ld9RoXQDQtAMcCXqnRQf3E6IZGy1O+p74WqMjxV1pTS2QcI7DtWLK/KjpvVb+XRtvq
 Zw7KIy3D3ZdODTAymwSJj3zLRQOdxSHmpvvoRftSNJXZihZpI5qWHwzv+XEDVejRqwwZ
 NIr6+qnHLKY0f1FoB7jE3IkOdh6ysNMpMxqKPDOSdTzYJpv27pa+LncTgAFX02sE/ETx
 uz0QR6wlQZwQto7/rUnqyjFduSUldzboFriiCikC9qJzqK+ERBsliRrtzM7JLNdG2JOP
 Brnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789386146; x=1789990946; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CqjmCk3ShyWFBpfTGrnIxPC2Rp2QWi8mLEyLTcq2rms=;
 b=XfTjLANI3tkxSxru7z+03C5xdD4oqjZAsrTBKV1Q6xIuMwC2Muj5lnmJ++Kmlx+76b
 Vv0xpaGQUpzbTnP78qjot7+D1ZOZlPpZIZNxpdKpG+yIYj0MPTqR2d3Gn1ykWaVDUm3D
 m8iVIXa60ZbOtCL+XIF8GZmOiEmcdBtT9+w34DADhAl1nArFGCCFZRjWBpf94VFxC76+
 Iu01y6d/zG5VSm0WSwZtu4nL7oAtZ3WKJFSebI41Q3YXfaN1mwEgpB9pss40kWBlMWAo
 3vRMFwsvOecAijVugFBA2x7SfQTh3bsn5MO45A+L0pdyjcWgjol9+wFhJRrkSTAKyYjO
 pbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789386146; x=1789990946;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CqjmCk3ShyWFBpfTGrnIxPC2Rp2QWi8mLEyLTcq2rms=;
 b=iKl8EjkDkKtQePxlBS7bZM+N87wTEvT8v/jm978uGTeBBRrk6TfCZs3VtmzEkwSMiu
 t40BPI9SmN4BYr2f1g5+AUe/S689+x8R5pJNtl8p+SOgzyYa80fysbX3xfB3z11bdbaq
 5QELm1Ov9XaqQki4K/icFBOGoZx6P2RnRFZqHxI/wl6LtBZZfN8/IfyM36PI66soTZHk
 x7yUfNXWnAoaLHh6Fwrg+V+w7nhFCRRmem1scaGYo8FlTgEjwxwbLXzwZUfGO6Nh7pi9
 YpqlnOEUefkPf/wk7jHvmIv/woIySCuW6jkkXmqt2KWbp7E0X/lsbR12CV1t0wPJMSES
 8Qtw==
X-Gm-Message-State: AFuF++nITeivAgUsu0gshPHhu+ILaju/jmgB67GMLNiMF/Xy3UYlyBE6
 TpVvVSV/Qjz1WnJjdJZeC8TB1WcpQ+i+cCdqivUNQgP+hsmI5cuD3zycJ8cxDK8eL2DKtBeb2/R
 SRy3QEn4g6ZiYe79jAU6MHMUmlnGK0CpHZZPatM2/og==
X-Gm-Gg: AYBFou18W6of3N+VNfTcRre5Oh/9HH3cHKjAagiW05r/gRSTUme/mGyU/BjU7yQdw6S
 Q0vjaZRzMhgnmbFHx5KFcAf8cy1vN/nG0ZE/N9TvN/o5VrlMq9KaNa4wkYIfx4gx4G3sXH/mL+7
 +Jks+WHQl0uEgbp+sExAMvFuL5eYKzE+JiwPSYtb0wH9yx1y5zg+FrWcCyTybMLZTVd7mIICw7Z
 YmcFzO/1wLIF8d4f4MHQQBxooMKxE7dNxVxyaa+sIDvVi8qgM6OwOK9Q2uwohkc6Rh2dpKpb1vM
 dRjV0LjRGLnE0OYL+ZmRsZKvV6oUiNbpapUv0WFNClTvQxwh6G7i5l1nSXy2fi0+YKdlz9/lKwU
 Vw8j8qfKQheZyK8g+mtqCKEUslW+SeMgc9EgAKJ4=
X-Received: by 2002:a05:690e:80c:10b0:66d:207b:a0c3 with SMTP id
 956f58d0204a3-6714dfd24dbmr279272d50.16.1789386145781; Mon, 14 Sep 2026
 04:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260912183110.502358-1-vpyr@vpyr.dev>
In-Reply-To: <20260912183110.502358-1-vpyr@vpyr.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 12:42:14 +0100
X-Gm-Features: AcwNN1ViEbHmIujLgfQKK-6kCJekJr0Qkg5qAwTo0eEt0rNndCA0pqPgQvQhwT0
Message-ID: <CAFEAcA8GCtoQoRD9qhVZp7Oo=-Y3-0OQehZvJh_c+Z8xfzfbew@mail.gmail.com>
Subject: Re: [PATCH] arm11mpcore: initialize SCTLR reset value
To: vpyr <vpyr@vpyr.dev>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, vpyr <vpyr@proton.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Sat, 12 Sept 2026 at 19:31, vpyr <vpyr@vpyr.dev> wrote:
>
> From: vpyr <vpyr@proton.me>
>
> Initialize reset_sctlr to 0x00054078 in arm11mpcore_initfn.
>
> Previously, the generic reset mechanism initialized SCTLR to zero because
> reset_sctlr was not set by the ARM11 MPCore CPU initialization function.
> The new value follows the fixed-bit requirements documented in ARM DDI 0360F,
> section 3.4.7, Table 3-20:
>
> - Bits [21:16]: 000101, contributing 0x00050000
> - Bit [14]: Should Be One / Read As One, contributing 0x00004000
> - Bits [6:3]: Should Be One, contributing 0x00000078
>
> V, U, and EE remain clear because their reset values depend on the VINITHI
> and CFGEND configuration signals.
>
> After rebuilding, the test read SCTLR as 0x00054078 instead of zero, and the
> 0x00050078 mask check passed.

Thanks. This matches the reset value documented in the summary
table 3.2 in the 11MPCore TRM.

Applied to target-arm.next, thanks. (I added the
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4454
line to the commit message which will cause the bug to be
auto-closed when this is committed.)

-- PMM

