Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A774CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd68V-0000YJ-6k; Fri, 26 Jun 2026 08:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd67l-0000Jn-4S
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:57:37 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd67i-0000Wm-8s
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:57:35 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-662dc3879acso990957d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478653; cv=none;
 d=google.com; s=arc-20260327;
 b=ReDrpf5zKa2XZBT7msVTpXOqigPeMZ6xhrMnggEC2eajeMjIsuxe7amx+Ej0f4kmtk
 5MhbKOJsIj0CC23D02KiY5DBXJVTmEtiXD1jSnITSsfDORKrZHu1dyKGpCIvicJ6cyih
 86M96nyzRLcDcIgShIhmskY4A0QGuqVfnEplnPb0JeOFY9YMlwPh/belEJoOeBfQfJWQ
 sRA2/RhP8ULs9jS5pLe5x6AvJZZU53o2KLkpAGAhOXDn3LVGsEgcrtH/e+AZPntbl98o
 qntk2DCbZUa8GD57hzQPEFwRfOmF1E3szLtj7rY3fSp4njTw00ICYlba52JSdod58HUA
 /wiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rL7rtzP0qTGmTTi87bsLx3/ar4IGATB7nEg1GK9Hm9s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WwIS/57yKlZRoTxotj+wsPvdRv7TjiWJOBO6viCaDfGHXUC/A3KBWQ651uWIkdbzOA
 7n+MdY24CHRQ4oMixPOJHZkQ4unF3ESg2s2gkNNKg3q1zFVyyepKy5b7keMR+EZbHh7V
 zx71lvTGoOCpcm/fhVHVRvkM9oH5jUF+EiaKNf4kLRcnG0C9zBxNeot8qJZdZHSeE2AU
 DMIRO8QX4415qhNhXEC+hSfyyDDUU+sVxsvpqB27d8w36BWzNdjPVEy4p7yw/IXAV2M7
 HUP1mrvWAg/Hi49FUtpATTH+vpq4xIrUFdBaGOG1UHgzpMIf4rnOfR4evwAekROlD38K
 1rGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478653; x=1783083453; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rL7rtzP0qTGmTTi87bsLx3/ar4IGATB7nEg1GK9Hm9s=;
 b=K7liV9vb/depP5LyMZ6uw0TUcwaJIxTIHCt+CL3CUcNYXN0DV0Hi3caPZGXrTbVM2A
 rJVOL9byeNozeUaTVXsCs5NVOccPbd21NH+pG1V/K4w1y7jFywkQFpIoydnmnq7uV/6+
 lKHAihk2Vf+/b9FiIjiBJP1ZEqbf0SVGpW7Hk2ZMb05IEa3/hbI576sxFuOa032rAeRQ
 vxQmckt/NEOQy1jovLkH0APQheOVHMdeBQw8goxmzbnFn4YtpizIXE+hVUFqxdx6B1Sc
 MXATt+nqaTvNDTPOyz00j8Caqi84MwfrfFW3MKhfD9tGXilUskV9o2wluzPyj2PsQvjh
 SMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478653; x=1783083453;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rL7rtzP0qTGmTTi87bsLx3/ar4IGATB7nEg1GK9Hm9s=;
 b=remz5ERFwIsnAG8BlbPyfN9IjVnWLuC6bFfWdXqM8Uhyn0/oQcYjG/U9DxvZ/x+yi0
 RAa7viGlE7NNyvrJKntvzAOY1LOZKahJEQKLJ6jWRhsea65QMHU5N7Auf5IKvua0Zr4T
 mXRSfIiOoRkfkvw10Mc9Zw5/bXiIe56PkV8NIxrTm39U7fABq5DR55X+06koY2s7Sl91
 +U50ry6OYDjleMUjqUwlHQ/TADVZ1FtHFg0XtZOc+1AoZaDurvhpUsK2b0qGF1oodRW9
 e97zXoKntCIkKiiww+MCcbQSgn5HrnpbHtznyqeyDaiCVIwVXa10UFDTKWkz3yMYnPFR
 NfNQ==
X-Gm-Message-State: AOJu0Yz7HozB3TrxZD8kXUX1X7Oo6rawRSzxv/ORwFfIrE9XnEtCE6Be
 frzZISBgRaCYS1bTAM4ZjX4lUU9PnjbzhfC+NqicuaAhERCOxLyhdVlNlvyupP4urtCx+lm5EPD
 vLkNhpAhng7Qk6sX569Ko+yZX3vyoL6WJrM+Sc255xK4sFINvTAgu6K0pxU08
X-Gm-Gg: AfdE7ckLzckb8FW7nj0huE122BEMUOUQe1oIwotJiGXOF9Fbc4aOMMcKyFueTtt4bLj
 HsZy4jnSBwUmbn5AtX6VKtjtfpMMP6ZrpJfJdy62d0g/te2GvEa228wdqJOOiA2raGmtFzlttZT
 HKwlYTiILyVI1GE3ITMTODCAe+hfDq/I7y40CP0L/fduFIl2Ts+Ti6uBfWSeVozeX+Zozb60KCQ
 EVog0o+Grk+wNhjk8vnj2EZKrdtkidj/9a1Zf7XiK2KFuaTO+0I0yRH9By55SwRCPgZ6uSrjRgx
 gWm5bVOXoJJgi4Cmtz0z5sZ0c1Nua3aVGXTX/3bJOclRLxRPiP/EKyBmFiDTsSzlGTg=
X-Received: by 2002:a05:690e:12c2:b0:664:ae69:230a with SMTP id
 956f58d0204a3-664ae692539mr253879d50.71.1782478653054; Fri, 26 Jun 2026
 05:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-8-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:57:20 +0100
X-Gm-Features: AVVi8CfQNaw_5bUeH1BezpwGsD0fgNlKGb_Ux3QDQnw9y5D3fxGQVzZD-mqRyrM
Message-ID: <CAFEAcA9ADv3WfxDSnv_hhUjL6BEBuFpsAc_f6fU9Pq547r3G6g@mail.gmail.com>
Subject: Re: [PATCH 07/15] target/arm: Implement FMOP4 (widening,
 4-way fp8 to fp32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 25 Jun 2026 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

