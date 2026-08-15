Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434C9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 15:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFzz-0003Pg-2h; Sat, 15 Aug 2026 11:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFzx-0003Ou-72
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 11:08:37 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFzu-0003NN-BR
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 11:08:36 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-836cde02992so18454597b3.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 08:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786806513; cv=none;
 d=google.com; s=arc-20260327;
 b=ONWOmsj6ifNdIyg02N/Y/IJeyGWbZ/S3pK2KAo+gjRPDzsAfVM5sM5VjK6gHTAyJFr
 hbn4K0ld0JjgJHU+VUOy4l22seej2D9RQ9kB0p9RxCFrnGvwtGO2+WGX++2p3xp5JOpg
 YJKXwDwQItirZ7hgPr75CL0dvwjHy182v76Cp+5Z6zjUiJEX1YeJNoZG80gHz9GhYlin
 tygnyq0RsPDR11ZoGuQwBur6tiRcvLCw6KROuFv9zp7PJeogQZDTwlIpFDWWZKOINLQM
 Q0weS8Wep0tzZkETcw+7VmVm+97E9CeVwaHFuJxYomH7PLD4/pbittpnKAKNYhsIIWxT
 HumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+zMVMJQSl0cbPJej/Ayy7qOsUldZf4RWw5DuYAFtpZo=;
 fh=Ijcv9MccY/L0uU2KICyIKoF3lVznktSoEO31c1W6cCA=;
 b=UYdLsscAZ/9+Tlhwsm6PGUfcwnsNsrqkDoSohL0Cw/4jLidwcuXkUWN/jjTUfXunOS
 MuO1hfb7BTJmccwoXesSla6tI4DZUjx6UTaeIIKfjxooB3rO96SPv1lqBaUkXEgqF9Rn
 UqNryge3lvpt79yqtq1rk+MJo3gTuBBeJrtkIh+GSrXBhWU5P2eqbNhjO+9hc/JS2pvN
 t0xPMaet/OaBuUJYmkoiqGCjkHA1ymzN0gCK32DdDKW0jzsf2Chgr0IZyVTXoQEul0mD
 weaCBVCKdWPX/7ge7UBszhUGIvWAKiHFF5xjjbQzFWNyRq5VQ0fpCKCLBlPRFISClpUU
 LEKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786806513; x=1787411313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+zMVMJQSl0cbPJej/Ayy7qOsUldZf4RWw5DuYAFtpZo=;
 b=uP5AHW+t4BnSKYEYEL8YjfiHvaGfU/bYk0DTni1+MaJr8hWG57VAD3JC9ycxDZaLzM
 ZpEGDx+umaBQQ1jzR/NyeR5a47uNw+bCsJdfV351wjJasUxBDMIaiaLZ4j9fX5OI0uaL
 PV14C6QDrZijJkfYFqfGBa6T3vbdcWwaBUI31ZkzZZsYqaTtnvm/Ki2LgKXrzA8bxVnR
 FigCj7itdWS1/vF5kSLAGfSkZXm7uxA1MfkBQ0jFzTtcJ9xJt+uiJZiZbtJKlBQzYnD6
 BmJOOwdahh+eeve4V0c8TykkjdrI8fWVgJ/uf63oJHaMBxO/QDwEriIuDOwCMlP0m+jQ
 kqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786806513; x=1787411313;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+zMVMJQSl0cbPJej/Ayy7qOsUldZf4RWw5DuYAFtpZo=;
 b=hbuHu79ZD+udb/B36bVksbcNYjyazpG4kknzw1tRkM86BNUsyu/PDQtWHffPfpAihp
 4hm9RYrP3YbC81MtbGcYDn8nS4/BCLAfybcyrYcnEBYeOvxSycS6XNOZOvBDfVUK529x
 Mxc/eBHN8rlOMpuaDgdBpIoqh2YwB/tTbBRO/jKpUJ3qLkrdrb8iB49uNuBw/oJTwSYU
 oXhzgJHNiyuHvfIJVfgMr1GZokoyD8rlb2WsEaTHF4THGarCBcJxQelNDjHLMcRm4Wqo
 1wEnul0XZ3sJd+x387fRAizyZB/WIP4aRvbRVfKItBI3NdgSId5b0qfHN+g/iwOY3FRT
 MC+w==
X-Gm-Message-State: AOJu0YxZaJ3Z5JChpHHF3Kk9e7aDIV8acZR7P8ORMLUllvvrmwaO+n38
 zn2XQCg3xSYlrRmnOYINTk2mw4ewSYnw1/rk415/rsltzXEu65aE/oXuoVRJoDiFSLbi27FmIyg
 TrAeicWmTgrVTxXzaMIzFpzP6+/Cay+RYK1Ug8qzmxQ==
X-Gm-Gg: AR+sD11GFHUHsa4WpwKX1sYx3FWgFxY86HkFvVAjoVxJC7LL++MfaOy4xZtAj7o9/td
 qAXER6km93W2J+odSLtXAj9nuLliIHJDrpBtzoxanXwdlcPERZBv4Ycrp5EU/2C1USx2HOcFo0B
 Ns6EKILeIRMyjQFrcsSmli2MrIoLRemRRGL8QQHWqb2XRiK2ljxfnGbAky21q2YbAzcnE+kCz16
 8ncddEYB+pz5jJBR7nlkpU15hBL2MXXMKpABSN7aZ6l2ovNVY9g7vhfHoYH549ayDLrT/93eHK/
 VfhYs582EAJ5GwUJ2ZInoj1LwA7F+Xxg5V3eDy0N+myR4K/MNvsWcnoALj+gYKCx5vNcnPWJfXs
 zCtcovVHSZ2xp0FBm+aVWrQxVtnP8
X-Received: by 2002:a05:690c:6011:b0:81c:b865:2231 with SMTP id
 00721157ae682-837147034a0mr47795037b3.33.1786806513045; Sat, 15 Aug 2026
 08:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260814080507.23196-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260814080507.23196-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Aug 2026 16:08:21 +0100
X-Gm-Features: AcwNN1WMPQeuRss8g5pFgMUg0gWMBI4d9Q7vM1fdFl5e6hqNv0RvcbzzdEqHB2o
Message-ID: <CAFEAcA9mO7R7ujwiv3CXOKqcVwtU3KoJ-i=EkawaGLUYUmvhqA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 14 Aug 2026 at 09:05, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> So far TCG plugins can only be used when TCG is available.
> Move the arm_do_plugin_vcpu_discon_cb() call within the
> 'if tcg_enabled' block and wrap the definition with #ifdef'ry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Applied to target-arm.next, thanks.

Does this fix any user-facing issue, or is it just something
we need to sort out for hybrid acceleration ?

-- PMM

