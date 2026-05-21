Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B965CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4DL-0006mo-5y; Thu, 21 May 2026 10:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4DA-0006hB-Dh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:17:23 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4D8-0000ec-70
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:17:19 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso5418943d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373036; cv=none;
 d=google.com; s=arc-20240605;
 b=TnHmNRRLFK9tF0rktJ6TddivGVJp/Kfym6JKWiV5tlJgBtPdF7W6bxSV1t71a6Yx8p
 wf1Z9UkDs+haFzwq6zBgHQN8YaY0KTHGFaKuCTZzBdJ88IvPWpC8WUzwGELuDzb+t4qB
 D+L/C9LAIpKNa9GhvO4Xdp2KnijqBvKEz4TBfk1meIC9bYI83nyZ22J/8NXqBgb/rUzI
 3X50ZWc49w0brd3Ec5QjCF8k3JEewiJPss0oz57tYaLL4Z09z1zwrmdsl7JuQwYTps97
 7EkB8nzvckhqKK5+DlMoiIZGXPwbwAleK5c/QbaTHLtZc0cYPXLF1qe4cMuM8yluVhIA
 dTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B/R5nmoCOoJ66VRW1FPc4pkr0+6I0oidqAcJnl8VECM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=DJws9uKNdT+PEk91L86noHVGA6ImrVv5A+P766lONZmByNX3c0xzYuNKdJLc5avf1G
 kiJ24UmXh3USIyc+g0KQFZGG4GbML/72h3bser5cRxs7qs7s2CI2DCyMBh6h/s/FbPTl
 gXo+jPR04Xh4FHhAeBlJ0DIpQ6p7NYZ/kv69u5l+0SIK2grCI5Ol5JsdgsDgrpWgnqWL
 VGLPt4g6BZWSQKqD7vMP1lhGvb201HV+4a+KZmt8QMT187AR/sFAUwS+gM/2daPoKNG1
 WboAt+LH3isKbfuaBKaSXPVJpT7i0l81MMKlj6z/Zzl3zJu2ovVLFD4k8mehPY114jdH
 4tXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779373036; x=1779977836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/R5nmoCOoJ66VRW1FPc4pkr0+6I0oidqAcJnl8VECM=;
 b=OIECp/R69JahI1/ycKrAZ40rae9o6uCtVTY0u+La7G6G0ygW30ddCpWMcnb7sEDOBS
 Cz0L/GEH4EMvDcKS0Eg8X+3SaTycGCrdtk3Sv+d6PjFIZ1iGyIhEyVBu8WtsIX6fklWx
 kfwQAHh1dV1kMnKrrbNgDqWmm+w6C7OTaoHiZ3Z/8uH8IwCdO2n6fOWVqCk8UrPByX0g
 4scFgrp6gyOkglI9lWVtOw1DqNVqVL+pqS7exgeS8Yq99+pJnowDOecTuZsvmk5KUcwS
 4vD8kh56HuNNSXRKyZBikv3mtTwwNzS3QQI+GUXhJivfgE0i5ZnKNfuZ+W5cfOzADPwO
 M+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779373036; x=1779977836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/R5nmoCOoJ66VRW1FPc4pkr0+6I0oidqAcJnl8VECM=;
 b=fi7F2frzbbAZWXp6/XriS83WQbGGoG1tlea4CUP2jAx2G05tSFRdzLmpmH21A1Wml9
 ZejcWDjs0DOzIbj7HUNB5LezSiORxa4eu9WAHhRKMlBoMo/8vSkslzAvWyaqMVIVI0KF
 6cNia0hGpQPIXnUlZnXBMZE+DcjWkKPzh6jbbgMVTRqv6ml96O1RoRvIOceKqLD62zFO
 NLhEopaCWhsECTO6LU2Ii3yNcHzmuCzzOBF7SD6M8aMpk3JFyu3+vwGNhtRn7y0LS311
 Vau66gILdk22g+JehxaK5AgZQ6/C6goZ2p4xNSfDnfTSYnk3YjqfBeTQKYyvdhyJUkzZ
 7evQ==
X-Gm-Message-State: AOJu0YwWsWM29oAnpU7z60A0WITrJswjD8PKEPvAtp6K9xaWmnZ+YZwt
 gpwwGmQOic3sc/IQyaO4wXV5+c35dxVRlK091BZ6SV1P7pfop/RIXUwaBk8cAT4pFXkFCyCyrV4
 k3PrJrs3OPQqKU1sLobP5EUBkHr6+X9qj8eCKO0oX1w==
X-Gm-Gg: Acq92OEnXNMLU2fsvAnl0g+FJGwkFJ5wVjPb/hIW0LG97lPDO1N9NvK0I4ILCLixmfe
 KCSLxCTj+1Ova9dHHSeJsiHU6AbCfBYuggbwOBGOJR8rAHp/bMzu73aXqWbYs4sTuI84QJ5mEQ9
 RnN/E/qSYXLCSIJ6DcMapQDwjG/BEhqkcR1cRWvhVnNSCA4H4XF2Dy8zE/BZ8b8Jk4LAseYDUT3
 R1BAMGyX+F+NCCWDBIY2cQBPh3NYSZSElS+AIcwdW3IEY2hWFsEP4TcRqo52TS8/mY5kGeKMTcc
 OWkwmwh7IDM5Oqh7X7Bb8/gFhyhSHcNEMDfUzEtJoRrY7empu37Vvq6L8qya0KqirjFZhO+28RC
 mTizldIDJaCl2
X-Received: by 2002:a05:690e:418c:b0:650:4a79:f3ac with SMTP id
 956f58d0204a3-65eadf36cb0mr2252646d50.9.1779373036353; Thu, 21 May 2026
 07:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-12-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:17:04 +0100
X-Gm-Features: AVHnY4Kk6ABXHM7dhBLcu0KepWMwRXBxbijqYXT2_J5mfEx1NQjS1mzjHadPeUs
Message-ID: <CAFEAcA-kqCYK9a=XA=YDEWTz7fQXSW3s2a17ZyYf0HThQFpPgw@mail.gmail.com>
Subject: Re: [PATCH v6 11/64] target/arm: Clear FPMR on ResetSVEState
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 20 May 2026 at 19:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> FPMR is cleared when entering or exiting Streaming Mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7eb7031294..3d6e7f1ccc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4856,6 +4856,7 @@ static void arm_reset_sve_state(CPUARMState *env)
>      /* Recall that FFR is stored as pregs[16]. */
>      memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
>      vfp_set_fpsr(env, 0x0800009f);
> +    env->vfp.fpmr = 0;
>  }
>
>  void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

