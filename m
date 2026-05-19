Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKif-0003ex-Iy; Tue, 19 May 2026 09:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPKib-0003XP-Bc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:42:46 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPKiZ-0002JW-4R
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:42:44 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65dbe04fc1bso3726301d50.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 06:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198161; cv=none;
 d=google.com; s=arc-20240605;
 b=RlY/qDx351srTV/0GMy5GIGCy0pCQT8Obt6fInfyxeZpE0yVNuGugjZLEIXMTJ+rWA
 1LwVsR/U6jNK/nzuxFVbK+zE4MwtgbigTEY9A+R4TBYzTtUIitf86co1zW+P/YTv+mEy
 /+AoFImxr8BUCO6n/tqdQ1ojA6SNiij3VJz+blbTd0J2up2mwiQQAa9e89VJJfExaEIC
 u/fcqY9PSopNXO9bX34fuVaiv0238nFRUga+XQdjN4RKTpG6HwD1nRN8KMbzoECsr1Ss
 PEXe76/QwOi9xoaX+/FZpb5uaY6+jHvdcKF4gkpdGjZHbRvrlBQH4pGDzm4EnsBzFPls
 siDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OMlJgMATDg1IQX7aLN7DGj38suPNuOZtNpaYRIBBqlk=;
 fh=dXQfEETdv44juLbUqi4y7hxEPUIETiLVlJo4LA74jm0=;
 b=kM5Cf1HZz2DNM9AjXfXI8+HT2l1BUtc2uYqZiSl0hqzGngSi+t0FruS2LMSCiz7uIG
 A5kErtYe6nO+xnJKwEQTRyU0HwIZZlH+VIeaD8VUml9iprt7XKqFlnqOmGGA7ot8G4aE
 Ou1FsgW1cIC9XNwToV2Otcm/N+0E4PgcynofmJtRB4C5lavG9HObtFkPox83R6cHbvWo
 IJ8Bn3Mk82MtVqfg8MdsGA4sDvNrMuZCfdA7+NIlemuQBJsOm6pB7BQZNKPWYsR+qVLH
 A3sFU4zcUSTaamYEZm9cPUAdAyEIvk0nYnUHqpgXGDT6uMGL/qqtRF27Y/QuSjGrzlKv
 Ep9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779198161; x=1779802961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMlJgMATDg1IQX7aLN7DGj38suPNuOZtNpaYRIBBqlk=;
 b=zPWRTCXQgUSJ7ioUHPJ3Clsp07w5JEcel601TOjutY4P/soTuX7a4T+wzxS5suixPn
 0w8xdlANHnMD/mwz8WydgKuamYa1e/sTI0qU6kgzWyPvTgUxbYbNu1BUkvX0igZY23/p
 UD0dy9Max5BaXKSOtuK/zpfh6DFmx3w52qn3YAdCKkAeLWt7OEDj3lMwD/dAx9UFnicm
 1HabnE4Xgy+vnpLgtnkFgu1XsNWpuNWuGp2Qh4uEXx0TKrW6MRp+LMoU5Fx5+AcySKh6
 /N7xjVFQegKlvH9HRN0SDs9pSX1nt3cSjp/oyoIonyR37Nc2a0gJ0mhU9k6jEex3Pz4Z
 v+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198161; x=1779802961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OMlJgMATDg1IQX7aLN7DGj38suPNuOZtNpaYRIBBqlk=;
 b=G8PKj7ivtwa/PfGio9gKFF6dfZhCKhH+teKE1dwrzI6I5DXng/qZlZJc9a7uzzEUOU
 e+mr7MyUPo4u1GcvuzMOzG0N1XuxIpvG3QdSq378+ts85F8C6Vc6G6aK1kgL/0MZnhh6
 WSENGo+9SpThjNeLO2AcBxxCpwxac6/YoLqHFyCg5YGjfmF9mscQbUQSMWndPOWh7N/m
 9pvKPukwmbv8paKE/lG70GX+7947bz840i+++bO+20UflYmMwhtMtyr5s7s55MfxB5pS
 +8F1XkgoH8nk2FarHPpI85RCQuEHZSdqyCUg29EzNo5DNOBlWchqz0W6tPuyTMroGTqv
 pk8w==
X-Gm-Message-State: AOJu0Yx1tyU3lOi5Z464PT6EzsG5TPrP+sYAr2isflpxmfjId4cn/Ge4
 2ofZE3E7iwv4URvAOr8CrhqY3K8QrOqEeXzZrxio2mBPmCKAPFgV6n106JxwGxlReJQCbXJpdBI
 uvHK/gHCh+c/rIBKPwaDQvNH1ziOd67FrWU/xtEgg+g==
X-Gm-Gg: Acq92OFOX+8y4mzl1/c1ehipDqQ9wEbQMGhHR+M0lG52DhqE5o+k9eygs2jFsjgSFkM
 Ldi/jPssMFop9WH/mVBINqhq6Ijc7QYIjTa/PVg+Vt4SC55/9+3Fp35gxSrZmu9C7FVSHffuRAP
 GSaj3wAq60Hk4MauYSWmVYP2xwavS49WxyAlF+tSrsipiuPApDsyjjUAXU+/90jZJ/50sxoFRKh
 lG4L2iI9E42gYUEBGgwAMeb8eugMNJw3Grwg1dp17maxXhte2YVp/OcpDhjN4BWfrkg4WTvedux
 +MiFfFwlle91xZFpzqyUeA7vd8ihg6NoOThi/yWo1px/CxK6OH1Lr7Vt6f0TTcXrNFs=
X-Received: by 2002:a05:690e:191b:b0:65d:7e2c:cbc0 with SMTP id
 956f58d0204a3-65e227d265dmr19502363d50.37.1779198161121; Tue, 19 May 2026
 06:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260519133329.4268-1-deller@kernel.org>
 <20260519133329.4268-3-deller@kernel.org>
In-Reply-To: <20260519133329.4268-3-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 14:42:29 +0100
X-Gm-Features: AVHnY4JH4aGY1RjMQxsi_e2JgFjodI8Ao6c9Ru8Vr_F9s_yLhePhNa3mdw-Txm0
Message-ID: <CAFEAcA-5Z5NNNuTNy04P9_1NCFNdpE-9+ySCSnwq1+u5ryTjYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/hppa: Move static variable lasi_dev into
 MachineState
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 19 May 2026 at 14:33, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Avoid static variables, so move lasi_dev into the MachineState struct.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

