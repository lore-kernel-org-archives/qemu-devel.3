Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4E6CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3kU-0001AJ-RL; Sat, 17 Oct 2026 08:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3kR-00019g-5e
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:42:51 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3kM-0004Jq-B0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:42:50 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-885cf67963eso6141697b3.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240964; cv=none;
 d=google.com; s=arc-20260327;
 b=VoTRh8kinaaXWloBwsTKCRB3nPRz6KMTjvoMPyRozQ/sSC9TaxMRCzWSBHMZgVG60V
 MPFHwkh5VbTZCS/mnGG3iYaXC/NGcSS09ZjAJ+xMirO6CWgWmBhxQYNNsuFIQzkWHpBa
 sWrof057XJLSV7GL41ddK9db7KKSDrGFid36s9vK4olQLkLs6gsUQS8mligHCMhoZA6M
 qd+18qqxwj8jrcqC6L0+qcbN2EYKJGW3U4UTFnduT0Se66e7pG49HSsCv2XmBgAiNEXR
 RRP3jj54Kt/BVX48v10XGjt14Pso+kl5gQRMMcE8IJHeYOnqOmoi/yd0EdRzyQ+lziXI
 xn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lws8Tb4aw4cS+GBBTx89l9hWdf4AfSDK+rtzkOVpL/Y=;
 fh=K7nln+snUdxD7vSx+57hZxjc8+cW/kJ+xOG3YICKLNc=;
 b=EDE7E2ikIx+Wk4o21ZwSAMq+3eu3BVJsh0ZS3Ly5sq7t6Aj404UBqLW8i7qeH1rEyk
 qQPK/4BQ+2VGXkBc09zGbKwfdI4FkI8e/8WhZZpP6qlfJntuUYw4SYLetDrucsp9XObb
 n6EvENFLtR2wUOyHyPgHb8+XlueahdgASZswIbnYAt3UXKdWVxf9F5sr9DlT8v1T3nQH
 O29n+ci902r2CR04qCWLSzuy/yUcWJw+mLXZqiYYOLBt2Up75MAzj+D/9UBa0G4pBWhJ
 ZQJXd3F6OGiEAYDEX7EXafu4ThnqsBSvx9fTlaUg1ZAnyRyrbKK3+V7EIsh/XBJBWVnZ
 mX+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240964; x=1792845764; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lws8Tb4aw4cS+GBBTx89l9hWdf4AfSDK+rtzkOVpL/Y=;
 b=o0wi3W4AZ8OwgqvxyDAcK/ufKHNJkRKI2BQ3dUdMubeWp7bbobkgm8LT95LtHZP2fY
 KaHtPVYmn+AfgDprACa84qsgko6H6Rw3vCeJ+5mDhX0yhxqRJhZ/n1M80lFLn8U2zd59
 YVNfxcVyBNcIxxyZg2LGuQe+L8AIGLrXvc0SBCfkkyq23r5kctbxsK/ferED0ETu9Grm
 cyiBIzXphiG3pzkduwqEOv7mwNR2eULPvdyJDW0T5ZXoEpNRYw7gA4TxwtbVJ5dOQhbo
 YUVBOh6HUymlRaQHIJT0yLPRfYeyLl6lq14ry+QwLyMtybV1Tp6pvVYOpcsRaMjpiT5Y
 2f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240964; x=1792845764;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lws8Tb4aw4cS+GBBTx89l9hWdf4AfSDK+rtzkOVpL/Y=;
 b=EkqE8eMjF14ICOOSy1jSSanMAVVGYFZXzqdlekX1KhjikBD2T5ca9lFcm71KtYeZrz
 /VYIjRwX/DndM4x+n81yWlC+Gzz8nYW/LQq3Rfsb27uQDFxnR0KsY+hDPZytsDR+SZTA
 AU5iX39BsuTobOr9mtVm2vIZWD3YH1HncTpCjpQmI5gu3JeqcGkkO41rVUq4Gk8vJXO7
 I8QfgrvcihvKmz8Cmow+qfKkW3fma6X2sQw+acaqXxopwANqPE3JOIVcv35QJZoBS/X9
 TzhUzcgErJ/GfQNm6ntVu2PFerA2j9FP1b+kU6C+B9I6fWrIUkX5KFmfLyfKSdiNeNZk
 D2zA==
X-Gm-Message-State: AFq9FYJwjsgdVrBM9/uczT9eq/uTFar2NzW31BTWiiLiVmgp49kOPOUB
 Ty9GejKlgmj5AnRDipR1z/OJEJ4trXMGUp4MgqVEyCsrgzNo1klVTdEylvw0zbVxccbQWshMCUB
 d5CQdbLHjX71rp1TMc1q6jXr4VPIUei6uvCovurIjhf4vn3+wf8o8+e0=
X-Gm-Gg: AYBFou3sI70zhxVAUuhgbyqlIrz+RBu1pc0RMu+/kymfTJsOFvRf6J//DlPo2+mOLMN
 ro9yodRwOLWURn1aqfkACVzgHR7WmqQ3mChSNvAgazXvwXeCx+DJJgv9Uq5M9wTFC1QmyRgk9Tw
 tCUIEEAodsQ8N04JltOpEVuwmG4FpSGNCSPjNuP3waIocEzW1v31ue4rGXj2BaEBZ2zdDxDLQqx
 n++vKwzXZVIDOqWFbM2KoMc2fjdAltOeZxnSt2NaY0hXHhMvBqtvhgwhtbRpuB7+slI/5i8LOjE
 gyQuwLPWvxIQQ2dwhGAfRbg5BKlx0ScFlhazC5yMjH9Vjesy+9W4xddpmo8FJS2GJ1BbIP2wJ0D
 iJhNK0K1htqIZlcuuT8w7V855b6OxS9WGcJ80Iyo=
X-Received: by 2002:a05:690c:9a13:b0:873:5c7b:c102 with SMTP id
 00721157ae682-8b0f222301amr9707397b3.58.1792240964239; Sat, 17 Oct 2026
 05:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-5-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-5-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:42:33 +0100
X-Gm-Features: AclHuK_mJv06pfcsn4a94sOCKn9v_eJXQ6gDrvsM81IlSNFD1ymKxmelB0lmX3w
Message-ID: <CAFEAcA-D7rmx-YC1TTra0Bv-P9rzjbz=2AJ4XUgdDWntBTs23g@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] hw/net/bcm2838_genet: add GENET stub device
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add a bare-bones BCM2838 GENET (Gigabit Ethernet) sysbus device:
> MMIO region registration, an out-of-range read/write handler that
> just logs, and a reset callback. No register-level behavior yet;
> that comes in the following patches.
>
> Adapted from patch 19/41 of Sergey Kambalin's Raspberry Pi 4B
> series (patchwork series 829638) against current QEMU master. The
> reset callback and class_init() use the current Resettable-phases
> API (ResettableClass / resettable_class_set_parent_phases()) rather
> than the plain DeviceClass::reset hook the original patch used, and
> headers moved under hw/core/, both API changes since the series was
> originally posted.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

