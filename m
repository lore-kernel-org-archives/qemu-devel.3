Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F5CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvd5U-0007FN-IA; Mon, 08 Sep 2025 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvd5Q-0007Bf-SX
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:43:16 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvd5G-00044F-AA
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:43:16 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-5fe42994547so712639d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757342579; x=1757947379; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MjCS2i+BWTwbrr8oSmqEFt7NhP7oVYdVTwKcAgAWybg=;
 b=BG1Oa5/E2zUsTS2uqx37JRtY9g3pLzvhcR00/fQukNrRv9JVWXNCRPIIhYhoxd2Vhp
 S4cA2fon6ZDHObNtHK3Xpr05SG3XRN+s4hNsjmUWoPALmo8fRWXYst4WYxXUY2xdm0iG
 6AJ4UkKqzLbpipwsn0CY+pYlD2lhwJ4HRTxc1OuyiSCho1htfSgNRWpsnWurctNt3XAd
 hYfyaouIsAgv9l69DfosipnqAjbVSUmKg4WQQ3ahtPJron8/BqE8rGvuyMaT3ILAgDVs
 PpdW8eceE+HPArpiGNv7f+hIgvFof4Ub8kMGpKpGgNcmSZWHQ4/e5bkPu98SPUGs3U7B
 uIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757342579; x=1757947379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MjCS2i+BWTwbrr8oSmqEFt7NhP7oVYdVTwKcAgAWybg=;
 b=L68kd1sLhSzP7Or+IwpQv6CXnBpfehDcrRA0qH75hUfmPMS07bTEyVlUJnxYsklYPi
 rE9WgmU7WVEq4rfk178WP7C6K2S0jnIvdY+ZiQisvd2OZfsFDuT1qoARTUU80ONo3Kcv
 OTVaSBO4SNsNLaMWF32Uc4PsX29zo2XVUrDmbzrJAWil0J2KLW//AjRZJCDW82JXvG2P
 zjjdPQe69qZO76DAhJiLp+hLv0L+YnDvzyjnEO47Hp/FGqSgohicG66/UJVgZm4e4j9e
 hMWiZimjzwHZI/02UHhRCvXyj6E4IZPtd9NG7DteKMa/UK3/Mk18eJprIVi3at5vJwSm
 OdQw==
X-Gm-Message-State: AOJu0YzoLDYcG5b1wKmQuIMI1Mzju292S+plXMmtDTW1ch2JWccZHlBn
 16xirC0QMzhIap6nhzEN9DJv0srng+4dciLq6MBlqA5MJn2o6Ft+3MTXV8HV9VrsHoZ0kiavJC5
 gdwn9Mb37zRXZG1rXuiDfnoqZP4/pzkMhVmvRibGrgA==
X-Gm-Gg: ASbGncvfvAnzD7MZFouF8AY7rf2uVO9BI1EBl/qAVxJ/xjI+2ua6BUauSB+knPUnTp+
 ZgZNhosvK/0eLO3Gt1ah5dChGcw+JWIXrZlZtYq83xjToRj7PsgvE84x7wj65+BkE+oUfQ/VqFH
 MEr+m+SarFEflHc4+43XjI9KF8azJjSFS0F9R0qm4zj+3DCENR151zmM3gxqp8EZFyey0Zwmxtn
 9Tmid6Sk7id49VSwqQ=
X-Google-Smtp-Source: AGHT+IFDU7jSad7wodjc+4eJqgVqUbLnl22mqF/vdk4kanMP09O4svsTrAshpOEVJZv2f4j4HxUDUyNZ9oEU+Zt5k/c=
X-Received: by 2002:a53:b10c:0:b0:5f7:1cad:a334 with SMTP id
 956f58d0204a3-6102d271c10mr4191365d50.8.1757342578636; Mon, 08 Sep 2025
 07:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-27-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 15:42:46 +0100
X-Gm-Features: Ac12FXwqN3IF2A5haIEUPyzaU47iqKSTHeNGHdLDpctTAquydgtIxIiXG6RlgmA
Message-ID: <CAFEAcA_M_bAdA2WsKUeMjBAk7aiV-n0NMeu7fwz1o6fkG+cXTw@mail.gmail.com>
Subject: Re: [PATCH v4 26/84] include/hw/core/cpu: Introduce MMUIdxMap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 30 Aug 2025 at 18:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use a typedef instead of uint16_t directly when
> describing sets of mmu indexes.

> @@ -306,7 +306,7 @@ typedef struct CPUTLBCommon {
>       * mmu_idx N since the last time that mmu_idx was flushed.
>       * Protected by tlb_c.lock.
>       */
> -    uint16_t dirty;
> +     MMUIdxMap dirty;

Indent looks off here.

>      /*
>       * Statistics.  These are not lock protected, but are read and
>       * written atomically.  This allows the monitor to print a snapshot

-- PMM

