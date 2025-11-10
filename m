Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C4BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPBM-0003pm-6I; Mon, 10 Nov 2025 05:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIP2X-0006gY-BL
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:22:27 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIP2V-0000aY-Ox
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:22:25 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64166a57f3bso1985896a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762770141; x=1763374941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55xzI0BaR303IwKPDQx1rJHhead9W30id9nJBm/dyr4=;
 b=Ivi85AqoRGxSG/ML2CFWriUZ8I1wKykcvd3wLPac0FO9kPZ8BRYbgs69LlX9HSVYGs
 oWeWOwDjO63cEoobHgeQYWHZKWMyjQiqLPJF9pr3iZ2ifUAVyyfyvynpC2Q4nh3+bFSb
 mEvFsn8RszVL7aQrQsPd3a6YvadoB/JUcObWh4LYTPWFSJnHam6h3k4HeIVY/G7BhjCG
 vCNdLaK1kMdCSrIpKERH2gI37MvhdqT/qCzpoSFs9jQ7HeH88YmOBrWOXePpJS9IHVNa
 nCVHkB/UtrlbNhMCRUDIjOKHQl+9O2OYy/1zNqW3pNCQTnsZRTW4q6pw93RlMKeeQBcr
 opiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762770141; x=1763374941;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=55xzI0BaR303IwKPDQx1rJHhead9W30id9nJBm/dyr4=;
 b=D8P7hUiOYooPxudNnAtK8Q5JSasQTsFx+shxY9TWAtfJIHnu0nqS+br50Gcw7LUitq
 z5r8Usr+qEUIcUxaCPsLOhqf6/LqyAleoCN3petkZ6wI5/nn+4lLhl41YC+SjmKNI6Je
 AkZe8Ix5gtGFZG0TI7xaGV5NILLlfK9N/dr7mjf/D+f19iJOTCFsBWVYMgj8JOHzQJGS
 LURKI7Sn9uzbuxrxsPtz939Bs8L9uvVBCrid3j7tZ+mw/5ZrUA8tNgA+XmEEL1F2PAmK
 qsb7JojJ2UL2ApO56u1vhQt5jvLhAJ9ETVEq4nwyHw+sJo0AH/VaSRt0tGgIww2ukhbc
 0B8Q==
X-Gm-Message-State: AOJu0YxpyUvECMzwSM/1l4ESCrwJh4xyk2uKJ893WqZFanYHOvO2vJRp
 8OVIpI3r7I40hfaWgzoZ2aABE4p723HYJuWqJwGiPGxnxklekMleBAigAQ0ZLtPg/bA=
X-Gm-Gg: ASbGncuIVehi7ON8MFFUp1fNZ110e7S/VsMGKUDIBTeSJpD53RHBdsfdMLEGbAsCaxD
 My9aqcshJfnznIB39WLghbX6+TYbfrWRd7pY7uuBzaG/c3I0YqQdcu/yckqlhhteTjOXE6ELsSf
 U5btNBLvsIvLbgSnPNQPLLtPHjVRvhq96Ef7++98eOugcM72eE7WVsoHNrGrH9sevDBLcFnyPoe
 r7Gl1YIrfmPFbsFyl1qEsEsguhjhOUQPYlUOzeePFBtPnCgHKSiYU0qGXerjOkRNJDX4x7jpd4+
 6wUOuZnz+bSxvkplYYQ6ASvNXvrfaBY69T2Za7IGt8uDSXryuMsk9uECg2gRLOku0rfdraR6j3e
 jPUY0E+R+zB39mW83BjtoeE2mXfOQ1a1eUI86o7b6sp9hwnQpreFWQ/NhfyOKEfy74KF+mTN1rj
 Tb
X-Google-Smtp-Source: AGHT+IG2ZR9GftqNaoSRiKKFKjRwqFrDX8bQbc60yBuZfThaQNtfRIoLenlR31dUkyV55D3uMhsh9Q==
X-Received: by 2002:a05:6402:2688:b0:640:c3c4:45fd with SMTP id
 4fb4d7f45d1cf-6415dc00b0bmr6147233a12.5.1762770140828; 
 Mon, 10 Nov 2025 02:22:20 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f862cbesm10895306a12.31.2025.11.10.02.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 02:22:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37BD65F8D6;
 Mon, 10 Nov 2025 10:22:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] docs/about/emulation: update assets for uftrace plugin
 documentation
In-Reply-To: <20251027085808.2306054-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 27 Oct 2025 01:58:08 -0700")
References: <20251027085808.2306054-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 10 Nov 2025 10:22:19 +0000
Message-ID: <87bjlarxus.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Linaro is discontinuing its fileserver service by end of the year.
> Migrate assets to GitHub.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

