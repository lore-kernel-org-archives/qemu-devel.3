Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7176EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcwC-00064z-4Q; Thu, 30 May 2024 06:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCcwA-00064H-9P
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:23:10 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCcw8-0007v6-Nz
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:23:10 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52b7f846810so486020e87.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717064587; x=1717669387; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bym47If7hnYqCHRJeiE8rzTe+ZpA3hGmUg8NZW8a6hM=;
 b=uAhmDR2DzyOSR8a2jJZtW9hkG8WMjDBdcTyc0w4H+CDNyRoejkwFBYnathjrBCCt4U
 6rpop/8ZaKhYOmIIXWDjXU+eBeHbfu+7cf7Lk2++5hwh3L02zER2jCsqK5dr57K6tX6n
 kIe/lYrwH+Xv/aECnryRQaRxkADO25l1oczLU+eNkB1KBl6W7/hoR80XpZM4DS0opOr/
 NSzSChIPtoALYT4pd5uA6fy8Sxa6edsuby0RSEFeySPBfefuWc4I2hQrbJrXVmn8mGNX
 s2+eDyq89FOQtIkFKChN53M8KHB5WuJ3ATyTWM5GsRjaPJDWfIdkvCv7ts4wGWSm7Sv/
 mPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717064587; x=1717669387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bym47If7hnYqCHRJeiE8rzTe+ZpA3hGmUg8NZW8a6hM=;
 b=IbowN+dHdfENe5v1HCTOo/HyEdX7CxE5UCiIulDkVcPO8lDKrYoxXXmCmEmERP7KiK
 5BDrqsZQwXONQCXlm9oPjXTCMG3aEF/U1QoF0oGAmyOED9SMVvVuHin6wlSb7qxlE63z
 EbuBX1IlWNBDbx+WUVUXTZC59LJcR1yR7Wpxsadpd1IgRh4z7ftqGhC+SlCjjdoem90/
 j23oU9il9QjdfdIeoHtellewJwM7ouqyV3P+yFZvAdFUeqQJoiNokU5X2+uz7uVpMTiu
 V9BcayRQFc3lMGjzpUbU8oAYHYwU0QgbC4Wa3lmpNs++ELxp34vIvzUu7ANi8fUJ9XJt
 aHlw==
X-Gm-Message-State: AOJu0Yxz9qf59fVBfoTZUvrZ9hR416gRT8Sbk/FsTjhvVbLymxqOy8hY
 9BDSQ+7nQNuqADUhEiW9vnNi3x8Y+mND1SD6K61R7UmT+jUjeKHJgy2DWPa+0H/0KefxCFHSqgf
 DfgLRRqoWqKEsTRih68aYkdz6nKIRnodwxFhlYQ==
X-Google-Smtp-Source: AGHT+IEXeJRroT+dDNcS/7mfuRKSHkefc+baqzjqVDqXDUhqPyuCgGiSZiqSVfEvDQsw80HMlzDJIvekxdm0SfwYIVY=
X-Received: by 2002:ac2:5147:0:b0:51a:ca75:9ffe with SMTP id
 2adb3069b0e04-52b7d47a4f4mr1244699e87.42.1717064586763; Thu, 30 May 2024
 03:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240523165353.6547-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240523165353.6547-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 11:22:55 +0100
Message-ID: <CAFEAcA8ptk94Zm+HpW8xRzcQ7eoGA0oU5v06UuQAm=aYdOfuog@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm/sbsa-ref: move to Neoverse-N2 as default
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 23 May 2024 at 17:54, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Moving to Neoverse-N2 gives us several cpu features to use for expanding
> our platform:
>
> - branch target identification
> - pointer authentication
> - RME for confidential computing
> - RNG for EFI_PROTOCOL_RNG
> - SVE being enabled by default
>
> We do not go for "max" as default to have stable set of features enabled
> by default. It is still supported and can be selected with "--cpu"
> argument.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

