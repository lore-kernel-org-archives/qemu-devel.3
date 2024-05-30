Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB7C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgoe-00059Y-Ue; Thu, 30 May 2024 10:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgod-00059A-0w
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:31:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgob-0006IM-Bx
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:31:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-357d533b744so980350f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717079495; x=1717684295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLEtFY+TjDnCASraG15huVnKqKZafAVoxiSTo4gIZLk=;
 b=kXrbOAVO6Qwkboc3xSodFu/2CgQ/QkVw8uv5JDZ4cc18DUmCGmgAgUliNQyX+9yZlU
 KdhD3DT+0ZB0PqbnOPM/4LbVeksRD5Pdeubs6ZdCbFr094yp2OPiwGYAHTjK33ahhSkP
 Cb0exfS6Z5Kf+078aRA9jf4Lr0hoIuBSFwxzDqpYXgPu50a5uAWYiS6v/yZXUr+17eE8
 A3fvkmczYc3bzdMItl0EqLk0sqhHDdMleOlIOtADXc4VZFGYMPVzFWaySBlDm7IjmEbu
 +fSsx9zhXfzptH0x3ewgQ/MIbuELIxZxOSFDh49jq73HOCaNw11ZaZK8EBxWL3ThIrzv
 Y/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717079495; x=1717684295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLEtFY+TjDnCASraG15huVnKqKZafAVoxiSTo4gIZLk=;
 b=DZZGSr3gI/k4in+bVIftjtR8q1T1JmEDXO9yzZqtj/dWEs0r+rjNeKanuvSCnlAL8y
 tMyYtS6+DieM2rmot9Z3RjJYsRga6IOL8Un18Zg8ox4tgbC3ZG2Xv3OArCmaw07E0Ots
 IOpRICkdgLgs7M/PWkj1v/GkKsTkf/S2qZYFpwo9msqKVkQEF8ysZTcE4VZEIskbRVIE
 ftK4oNEU0r3olIrbdRn55+QCus7f78aKVG6aJPoTgvqz0Hs6kNnj2rXjFb6jrPnGKERc
 bIAS/Uoi+26AbLa9RfGKIhDUzL4fuDMJTO5Y3ubo280PAAIZ4FNU7trFoVR2oBslbU6Q
 04Qw==
X-Gm-Message-State: AOJu0Yz0CyHQpzdKFUztzTdQj47S1U6DWOSUJZAn+iwwY7Z9lpNmghu4
 aZazvSyT3x5Ru0URxvKrOXFfAPnZz751whDSGZwICcFtG6uduFIyK4TK7XpYMuOp0cvWJ+hovKE
 u49JWZQJ76FxooRHL4e/cAoxgG9an6MPtGFuKgA==
X-Google-Smtp-Source: AGHT+IHePEeqgxmtGjnGJq8BTabbzAvFxrtYcPM17fjKZE4XKew/Ybb0DP2qIkynKnEMh+TUVBrljO9mjxiKreR0qRE=
X-Received: by 2002:a05:6000:c5:b0:358:380:f44c with SMTP id
 ffacd0b85a97d-35dc0087caemr1468135f8f.5.1717079495258; Thu, 30 May 2024
 07:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
In-Reply-To: <20240530112332.1439238-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:31:24 +0100
Message-ID: <CAFEAcA-3sxcArbZ6k36Yffa4eL6AaX_ufzvwNrPSBRoYi=DNqg@mail.gmail.com>
Subject: Re: [Semihosting Tests PATCH v2 0/3] add SYS_GET_CMDLINE test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

On Thu, 30 May 2024 at 12:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Hi Peter,
>
> Looking at bug #2322 I wanted to make sure SYS_GET_CMDLINE works as I
> expected. While at it I needed to fix a compile error with headers
> which I guess we got away with on earlier compilers.
>
> I've added an editorconfig for good measure.
>
> v2
>   - addressed review comments
>
> Alex Benn=C3=A9e (3):
>   .editorconfig: add code conventions for tooling
>   update includes for bare metal compiling
>   add SYS_GET_CMDLINE test

Applied to the semihosting-tests git repo, thanks.

-- PMM

