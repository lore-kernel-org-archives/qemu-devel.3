Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429E2C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfd3r-0007cj-7o; Fri, 03 Jul 2026 08:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfd3p-0007cU-96
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:32:01 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfd3d-00006e-Qy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:32:00 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664db84f074so599997d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 05:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081908; cv=none;
 d=google.com; s=arc-20260327;
 b=oVs+Vro5mfrCrSf+bWaEoh14qsI3gKNV39vAoVLCOVKSe3aFCotoKF4m7f/ndrodxI
 UyhJQXAniliPbR1VbemwvASrQ94prQjARrNo1v8wx2ypxCXCTQR8UoFUeiE/tFNslCXV
 z/DX9J/9t5FTlhgF1gbXeQPpHxuYjTK5OMnMOb3GorERXbqdTiw2HVaXcKSG+w20pnA2
 BCIm6X7RLgMRgokJPddNOmWuanx3xokJfWDmclFZr/KWuoKKOnh1Gl5DFEVhzdgyHUEA
 vj3zU9LhzIxLjf0wmQF00j9+Kca9Xxohbs5DPBbGjbZrhoanCBnHBRppuQ+2rizTLA5F
 ZeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cH5pEr5Aa42QpwXY8XBAi9u/QJ7yeOm7vvinpj3m4hc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=dnfulcJ8zQ/ck3X0o/hHOyvSAc+7IZlXy9uUILdxvd9LoiEgq/ARgAWcjxcranOeNg
 daFGXC5vaY7bKPonSiHZQz8d5HcC1VjHA2SEw82fb28YcD3qc1cyLLrhzXk9hdo+fw88
 +ftWV4BbygTT98PjU+TR3JNRx+HIwoyV1qVYAItk4WrUXY7Vy97YW5Fuf2ZS8cWc305F
 lH8GGdk1tKtgbTrCQitHUU1+PL3NMMPRnBaFO5wKhJtD5OOpH96MI5AzEN0coyFq2KYv
 bURQARm+X5+tHUY9As+EEWFBSIRBiBofz9yoiD02Vb7LKG/fTEmX06j04KbTwZd0re1v
 8FgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783081908; x=1783686708; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cH5pEr5Aa42QpwXY8XBAi9u/QJ7yeOm7vvinpj3m4hc=;
 b=xFdsog0nKBGSNrEDrSoEHpxniUeVRT2ldqreGy+tDn3QTdoGkioG2FwPczF1mqShYz
 1QBIW0jNRTshl+Odvv74i+h/FQ3RgsNVYHbA98XtR40QGkDTF3YSCE11UtqqdaXxrOoV
 H82e0QBIHt/VKdR2fmqTuxmZmAFPenEX2X1IyFl3QBLLI0zmVyJLKMhVctTUt15sMp68
 B2UnUDp+h8WG/GZqh7AjSQnT3a/Tf7nbm2lp66m/7BOSk9tknRBAnr9o/cZcPTBNP8Kq
 KrdXSB1dO9YfaBUPt4Mz2CmmQM9tRWaxDXb6zrcPk3pq3LsP5tdMm27BbkyYr2sptWSQ
 CM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783081908; x=1783686708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH5pEr5Aa42QpwXY8XBAi9u/QJ7yeOm7vvinpj3m4hc=;
 b=B7i5TulBJDxQrPFrWl8CZd1OfSodYQ1Oo2fYZq7wv+IDjbQ9vxay0cXCahwlWs2Yxi
 5HBps4zW55drOh03WqLK3hL3MB2SNvbCLiQtr9Rbh5FIMiLX4JkiQICVgyPydKDtyrek
 zqS0FyIrpbXffxC3c8veLIhxFE48dj/oCBJJzbrL30INz0lJaF8VD3JTQjupL9Kpv1fb
 VqI0DdlJBY5sZuTi+oFF2YtpJRnfV/I01vP4arWHh80b4WwdK0s3fnHgxpBsP1B1SASw
 g/Z+YTaw3KozXUgyY+HgP0cUdmHBv72TEmEcc9OuiWuvFcI3KeBxOi5hdrvg7lPmLQRP
 534Q==
X-Gm-Message-State: AOJu0YzUNmfs02zVpkIPHo2+N8g5grMmWypfU3LSvMGHIXAUZsVGseCe
 Oaa14hSPiXUSvDsY7KaZfId8xa0UTovgB/KsWgCcqZqQlJ5Hvlf+XKychvbt6bYB5dPZhJJJKwA
 DmGhERa+IXtK22aPalLpgyavYK6nUfU9VGgleqgJyi9XcZZGyQfP7
X-Gm-Gg: AfdE7cm1ziGt31ZPfBtAH7ElU/7n1YYEWe4s9H3yTmjKJa7iL5WuZ+9FMLkakeO4ugP
 OsnLsvD58lOVzsOuTJ+YZxjV84TmIsmxfHhaom5cPenov58FFSETJJf5T3gjB4gx3X3zrpP2cW2
 NbeRLxInANJzKDlqW3+K2t2lUOTyErmb9XUJ+LRcxxvv6dQLdMi4fbrR4ru47WXtxQq5//c7/je
 Vo4j3qaKWUFCDCO9nt7CJQbIMkuAfYdnSgk17btFuf+9+KntiVjA2aJC48KOzuOScUQYUbZhV0y
 oKqzNvCFRdt9xho8ddVZIhxVffJ+K8ZEGyBjCyFfBWY2SpmQ7svcRYVEm8F3a3ewEPM=
X-Received: by 2002:a05:690e:d50:b0:664:b3c0:6546 with SMTP id
 956f58d0204a3-66521d485b4mr8860949d50.57.1783081908321; Fri, 03 Jul 2026
 05:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260702204314.79224-1-richard.henderson@linaro.org>
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 13:31:36 +0100
X-Gm-Features: AVVi8CeVLa5RC2aLQpvW1fcbYz-IRiGWH1aknUzhSpBFj_yPRYFsTHJwwnG4gV8
Message-ID: <CAFEAcA_50HH6P=0+T-ESvaY=9FOs8LHtC1t3SdxR=Tg2-TkntQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] target/arm: Implement FEAT_SME_MOP4
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 2 Jul 2026 at 21:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v2:
>   - Rebased on master,
>   - Two typos fixed,
>   - All patches reviewed.
>
> r~



Applied to target-arm.next, thanks.

-- PMM

