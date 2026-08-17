Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0C2C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzQr-0005cK-D3; Mon, 17 Aug 2026 11:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzQc-0005bS-Cu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:39:10 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzQa-0000UR-Ce
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:39:09 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c70d1672cso3570047d50.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786981147; cv=none;
 d=google.com; s=arc-20260327;
 b=fbfzSSPqd0KCh/NKPZps7QOrFfWuG8iJvBkGVHC7RkZmQQH7lu1JhiX0VNMz+a2UJj
 Sz5/aVuCaFuPhdx2uEFvSU4FxHVh5pd6IBVjKX882qU/IFt9UEroIpGbmy+Fm9tmZN3Q
 uaRHpC7aPkVoLv+712U0RtOFgFObVNjGsrQqF7IwL+EWq/e13Bf+kGPSXDPUvPA7tWjV
 oWKu4VC6DLpQg67VCH8AkiW4YkEcIJ3Tc/7MITUtpvVFIHHTPb6xELwnLMvO6aZVEnpG
 lA1RCBVOUkucomAbkx3riT5mEkKrsJ1vcdd5dOv+NnC0fe4HfzGPA/B3g4bGsMvReTGE
 HWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n6jmdcAg8V7YZllZqZSNbr90fowePbfCBGSOOGmRag8=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=MHbqDKz0xbamUfTmeuy9udUhz+L5G4T+GI6r9a/gN+01ZplW1F0WI97pRipgLC6kLM
 /0/u67fKjcLBPsOFv6/qY4CLVmzrukHEp2rafo0f3MoAm43o53dug8jIcci6t8dU60+P
 znAMxXyxrjeEtr20L/wptJhpkp3QXiPhPtJO6hvY0Vefw3Q3ppWg9jUNYja+7WCVwD1j
 lMHbacGYxGzAzr7UO1I7q0mHHFy94ep5JYS0fPNJX/tJjVo9R4TZX6qCLG/75SvpSXQv
 FmXu4OOzKPspHfykZEGbhfWahjDaUwAnehOpgsvcBgeJrsWJgjPy8Axz6VeYZI5U6S5w
 07dA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786981147; x=1787585947; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n6jmdcAg8V7YZllZqZSNbr90fowePbfCBGSOOGmRag8=;
 b=lyCuKF8owAES92kB0vVEqo6Kh3EFp138wkNoGQvcdAq+aBP9quoX+BV23ESsFV0RIw
 bxmaGoghZUvcSbPOxJehAKi/OPwKy8O0P8s92wgFpQ+c90Wq/y6+uNacuD+VPOSS4yUE
 a19oP5FjDALYPZKhWXUDGCGOa1GLez6kx49GwenHlF0bQYm3ulPUhVaZSY87wXKhgG+L
 B3DM6fM+L9LeD1hX3KQKEhqIXL7/KJq2+FSG7QxTKuLstEl8+uT6PrAmBbuZOMnh2tZI
 Qrx5wyJEhR5ICbcbddr0rRckhcDHE3CZv8Idbl8jkgJEtpmqFa5hu0VOIgWf94Rm5z2Z
 B7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981147; x=1787585947;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n6jmdcAg8V7YZllZqZSNbr90fowePbfCBGSOOGmRag8=;
 b=qWxGKcUzod4c2HuDt0oQgHkeuz76I5hrsB5lJqYDFGc0PCIFAiGlv8ZZy41eEAZC2S
 3ibqoHFW4h2gIyL+M0Z/kXnVpSLNiJwK2ubnZMDNTE6ARZPdmjD0gCfnk8E9JbU5wW0E
 WxmTPhQBGjO1ib5Nnqaqwkl2cKnZ9AbMh3+d3Bkzr53iK6xUcw5H+SH3RAWRyWJS4Kkf
 I5AnDqQ61xuH3WkFzXc6cjSx+gY2fHtBO4Sg116WJdKraXkJlEN2d5iuCvKo4jktrWId
 W1reorrmS1ZzBp3QvGaFy83qxmA1Rul2lw5EXCgNe6VzBJYdD8Jz1EVb1FmA+ahlw6V7
 ZwFw==
X-Gm-Message-State: AOJu0YxUa5SJQJzaYYU+DFqqfmRcgzERzGOTdvbh9nT7gJ/Vc6fDN0gu
 TujQ5+YDEI8Irg+mtHvP3BQIGhUdAhqZ3v15bJuoBcUwLQFECCSZIHu50GsbdLxy1VAwmAu68Du
 Um9pgnitQs+rztiXk3C59fH6ytxzrkytCBZ57pO1PdA==
X-Gm-Gg: AR+sD10KtwogNDoKLA+ZInjDjK7rJ/1gNBGAyw7YYVtwlEMU4KoSSxZOi2FrflukNNg
 NCHVuTyI3lj4q2h3w6e4i0CAiXDcN9wZjDZyi25GvwKCsbFXqVuaD3oW9KQpmDblW6DWWgc3kY0
 /5FKPY1XIc1QdnrmL+b5KE7Vz9NLtZVCLihR8S44YtTcjO0wFLRV0Y6hvNX+YvtnZSQBO/Jxd7L
 /4c8iXjXLSMicb0frRrnpNgnseBhhTq/edxkyRqOOjeKSebsT3zPTGX+aYY1r4BBPNu4maRdp1M
 MVaNndDT8njIAU4TBbnSzkq4MWZvToj11qYFL0SsOOXFqxT3AvOVZ0CWqBXGlD0d8bnRMHZsw9X
 gxeU8pMqAER+lRHUsQl83JKOrscDVx/QqYAUbLmo=
X-Received: by 2002:a05:690e:d84:b0:668:8bca:3c41 with SMTP id
 956f58d0204a3-66cb9da22fdmr606139d50.17.1786981146796; Mon, 17 Aug 2026
 08:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-8-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-8-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:38:55 +0100
X-Gm-Features: AcwNN1XtSLekMzWbkZk9OBbiQ2fBoN9KmdC0b8MVN_UCRxIyAIVmMp9X2ncLBTA
Message-ID: <CAFEAcA-znXsy0xwyGdpA=CbC2piEQ8EWWNPOhQOo0FC8yCxJUg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] hw/misc/iotkit-sysinfo.c: add SSE-310 support
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add SSE-310 PIDR and CIDR registers. Add sys_config2 register and
> always report 0 on read as we do not implement the NPU.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

