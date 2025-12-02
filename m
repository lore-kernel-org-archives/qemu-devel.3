Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC08CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 09:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQMyv-00067m-5U; Tue, 02 Dec 2025 04:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQMyt-00067b-A8
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:47:35 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQMyr-00009v-TZ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:47:35 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63f97c4eccaso4738210d50.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764668852; x=1765273652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lEpemLegAyTXUnlqT+PNdThFSruU/lxw5aPaSFuRaH8=;
 b=r1XIbf1ZVXpUJLq+WBUdX9yF3YMdkpRKnQ32+L614zzgIimIagHbrrU/RMIChVEyYT
 K4f17Tie4yTUsXXPavdb+kpyT9O/VWUEA232qFQoZMRx0g0xFcK0JGqST/k3sMDnfOui
 V7f+cjpGc2IjYG/hEwfXtk/XpAPC5oMDGnBXGGrRos0d8VpFAjRbVsgzTzwZ2zhckL7r
 EEq9LQpp+SVtDeE4wGEYfh0NW2wKvU7ZtLhi4m/CLUf8HPf5HMseodcJ4v8SyD9w78iT
 R2FBjrqPgs1s+SJCWQZQVQU5jKirO730ERvP6mEE/zTXAy7I9XGpEd+4K1hO+hARLFYE
 lvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764668852; x=1765273652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEpemLegAyTXUnlqT+PNdThFSruU/lxw5aPaSFuRaH8=;
 b=aetFKUwXnB++R0p48zRkmzNchOswiW/kTWKlKgMNX5IMCbulFUcTob3MBDuTq+S3WE
 vzxA546B40pylRyWdGCrpRICjTimrofdBj1O25HAjwOxI0oBNS8z9bll6XxTkwdjqv35
 8W8G2V7s7bYG13UR22EmB90dNnSmlouLZmGyPkL5kn943lgkO4JVlM8IcZRCIS9cGHWN
 ITsK8lQ09shRFX4gclAW+0ZplKH6WsG3351ktwyEfn6uA07RPgm7+xJPYDLMe87s1lK1
 gWVq+0UyjYw6Tqv9O7+4E+U/qyP24GIh7q+WIhON4Ue4vQdKTGDFILNc3LJcR8pT0uqq
 MUCw==
X-Gm-Message-State: AOJu0YyuVbiXvN/ioLbf2tcNnR12HYBMf1fSUI9GCm3784RR5KalNpps
 xoagQ3h6VfugCqYLpr/A7XHz8C+olWBmmq6V7J8kzrnqye7SzOOt5G/l93viygg3lmgpkjjRiDN
 M55DyNTWKXQQDWYkum8XtiOwbFfsj7LFdsbw7NALN7g==
X-Gm-Gg: ASbGncsapaOI5QwbWak7WeYcX7hx9WpyLFnIkQ668FkuLSDi1+DaBF5+VuRczDCRF0q
 DGwwy/mSGliJsTLbRQv8LnLndrPK6x83bPvQcbB6RRorx+YcI/76qA3/AI+RCfVG02SMHaAhB2m
 yyxRchmidZrFWT72qePlmK5or0k2/I9yikspcwy7858YAXVtSYnOdW9YGmYGLIXYYsZ/V2+UPDJ
 Z/b5H3n+4oXgD2RUj8XzDR8LVrD45rC3EC9aJamjDsdIK2dMXC7ox4Kfs6Ki4BS4suHzS8a4L2i
 +9Z0NQs=
X-Google-Smtp-Source: AGHT+IE59rVSFGhw46pOHKEiSkhDtJxm++jfhzPFG8QpqRyreGjPCiw75z47rzrF+V0KXM0hNqnGRf9b8gHnSAv6Dok=
X-Received: by 2002:a05:690e:1502:b0:640:d23d:3703 with SMTP id
 956f58d0204a3-64302a83827mr29749830d50.24.1764668852612; Tue, 02 Dec 2025
 01:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-3-gaurav.sharma_7@nxp.com>
 <CAFEAcA8WHgKtPPVQKNSRV2R5xVPCZ3vNxQgy9rcVu=ECrxNE2Q@mail.gmail.com>
 <AM9PR04MB84879F8FB1F3E1AE26F784F887D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB84879F8FB1F3E1AE26F784F887D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Dec 2025 09:47:21 +0000
X-Gm-Features: AWmQ_ble3u7hqyOGJ55SdH_DfkE9pZHabNXx2XSLa_v5-B_OsD9aWAIhzUqJvRo
Message-ID: <CAFEAcA8OwigUfpS8E_hAND1aD+oNh48nongWLM7cRfU8ZP+9jA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented
 CCM(Clock Control Module) and Analog IP
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 2 Dec 2025 at 09:32, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
> Apologies. I should have executed my earlier plan to maximise code re-use. Memory map of Analog and the reset values of the registers are almost identical. we should re-use the 8mp code. I will create another patch revision that
> 1. will have code-reuse of imx8mp CCM and Analog
> 2. will add a uint32 property 'arm_pll_fdiv_ctl0_reset' in imx8mp analog state struct. imx8mp analog class init will be setting it to its default reset-value.  in fsl-imx8mm we will be overriding this default value with 8mm's reset value.
> 3. Update the 8mm documentation mentioning the ccm and analog re-use

You don't need to mention this in the user-facing documentation;
it's just an implementation detail. Otherwise this sounds OK.

> One question regarding the patch splitting you proposed earlier- Now that we are re-using ccm and analog of 8mp, will it be like 3 patches ? :-
> 1 patch that adds CCM device to 8mm in Kconfig
> 1 patch that adds Analog device to 8mm in Kconfig
> 1 patch that adds the property 'arm_pll_fdiv_ctl0_reset' in 8mp analog source

You can structure it like this:
 patch 1: add the new property to the analog device
 patch 2: add the analog device to the 8mm board (setting
          the property)
 patch 3: add the CCM device to the 8mm board

-- PMM

