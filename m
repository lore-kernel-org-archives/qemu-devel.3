Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C91D49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 09:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCyIf-0006jq-KL; Mon, 18 Nov 2024 04:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCyII-0006ia-J1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 04:43:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCyIH-00045i-1E
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 04:43:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso23197405e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 01:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731923017; x=1732527817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6MNrKpnwZ+tRHw+0OXWmFxzgLcDpPI0LeFZvBG2a64=;
 b=ZKfuoQlJoldZ/XMXgKe9P20zmKA3Kaqo4gqvKXQ/EafUpmcro/ayrVRsKTXR6b305T
 JtpVGb9L9+Y4QKBBkQf4tHTNdXdmbbOR1GHHcMpwpIxwEwVCaMHeD/k8tSxEQnx+jlnb
 WinAhTDf+O12UcIwHw5DCKVfd05k4RsBp0Z+fOg3clFKNI8vk9rR7q9tsHfl5obwjuPT
 CkmdTwbXxtKankKZclJVNlQrFJpyZ2i75WPUS7+H/nKwRcp1xmUq5fPeG2duruQtg5c/
 qsqk3TVv53YeTCP8svu3elGDylk7kqPxgU8JsN0yw6biADW8gDj69a+Ot44t9nPB7ns3
 /Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731923017; x=1732527817;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+6MNrKpnwZ+tRHw+0OXWmFxzgLcDpPI0LeFZvBG2a64=;
 b=QvjaClCL1IB9gB9dA2lTfUc6jsCe28OUTz00aOrmHzTO0dv4+A/g/KN3Ex3RT5c/Vh
 mGXHn6+yNoWbe39L1O95HjzPBRz03jiNLA+14oRmbW8kMmtfG5t/Zg8n5Zt0/fAR7x7d
 RUmbFZFVOuZspavDk6ppqCfAIqa9sGMeMsK8F5FGiTBtn5462JvMhYmOBtuT44isOjqX
 o9f3/imsH4GHcO7aUdmLSKp5ipUsaoJyt4gweDHT3aiZOBylwgXSjlqGJpTXwRUhSPMh
 iq65ucdacaLiAX4Peui6BqhaST/0guCgQpuB3l7M43MWFBZJPT+6vF41Y03pOUDQam52
 L3GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzh/81F5v6dmn0GFtBLcmAA7CImBk5aFYh31kEdHE1+qXqZWaU2A736X0ilV032BG48USqSraH8Y0C@nongnu.org
X-Gm-Message-State: AOJu0Yw5n/L4c8tG4vyhyq1izHgyG4kH2J/ZKZLPlNlvsAijX8telWIO
 LwTQJ4YCU7YYlTenkmzC7DpDRW+oekvSTk5vGeipal2Qu82/f5jXNyJfr53uov4=
X-Google-Smtp-Source: AGHT+IErSBM8nq53K2BRYq/44o2/9KWXjEe2MfXL1j7D/JGjPbaQKYEAklhhqXeXYUV5MWpyRNytow==
X-Received: by 2002:a05:600c:1f94:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-432df72c661mr113330875e9.10.1731923017006; 
 Mon, 18 Nov 2024 01:43:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab7206csm147855595e9.7.2024.11.18.01.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 01:43:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8C5E5F7C6;
 Mon, 18 Nov 2024 09:43:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust/pl011: Fix range checks for device ID accesses
In-Reply-To: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 (Junjie Mao's message of "Thu, 7 Nov 2024 14:13:07 +0800")
References: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 18 Nov 2024 09:43:35 +0000
Message-ID: <87seroubaw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Junjie Mao <junjie.mao@hotmail.com> writes:

> The peripheral and PrimeCell identification registers of pl011 are locate=
d at
> offset 0xFE0 - 0xFFC. To check if a read falls to such registers, the C
> implementation checks if the offset-shifted-by-2 (not the offset itself) =
is in
> the range 0x3F8 - 0x3FF.
>
> Use the same check in the Rust implementation.
>
> This fixes the timeout of the following avocado tests:
>
>   * tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt
>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt
>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpressa9
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>

This certainly fixes the avocado failures.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  rust/hw/char/pl011/src/device.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/de=
vice.rs
> index 2a85960b81..476cacc844 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -182,7 +182,7 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint)=
 -> std::ops::ControlFlow<u
>          use RegisterOffset::*;
>=20=20
>          std::ops::ControlFlow::Break(match RegisterOffset::try_from(offs=
et) {
> -            Err(v) if (0x3f8..0x400).contains(&v) =3D> {
> +            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) =3D> {
>                  u64::from(self.device_id[(offset - 0xfe0) >> 2])
>              }
>              Err(_) =3D> {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

