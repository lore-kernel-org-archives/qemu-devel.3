Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E780C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpad-0000lU-67; Tue, 30 Jan 2024 09:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUpab-0000lH-R4
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:59:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUpaa-0008Fz-7U
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:59:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so16771985e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626791; x=1707231591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UiblXSj4QkLRr0+VsvzLHbNebXQPz1ut+cFGEbO/p4=;
 b=zGNP7oCf+its7V+nstCQFSCtVJrd432t5YduyiFlP0Q39Kcv6W08RyN/pDrzrg3zMe
 Za/eapHD3WB6xQSJaiM8wUCkY0FxY/40tPPRJVujrnDN8jtZuSFjoW9A+PNMDP8JhxKA
 yghs07q2WWuj/T9+hjirN0xuRpaBeoKAILF0Rq5fpsPNpVaaDRrggGL5qOdTh2wX3aJs
 338aB0jeLBYozNRCayq9p/c2ncxNSZtnxmCgIBjnfzNhpSTJCUafd842O7tNfDZDutOP
 5SoJFmvoCugmJryCuyORMl98ZOMaK6Lzi2JxM4jaJhVTLM+G2q6VVHmI2Y6pEHrYvNqm
 gP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626791; x=1707231591;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2UiblXSj4QkLRr0+VsvzLHbNebXQPz1ut+cFGEbO/p4=;
 b=crtyJxa4N4R8LBOLbfyblWTYG7W3+fGzmMnZmTu8sfZlS1/CqMGEgxA2lde7gYCarX
 I4tehjgL8ZzJ48TzYbft/2Hux9N1DjFD+pQWS+DGXCw9Lg2MAV3As8k1VEoPJ1Awsc39
 al5pdjaAT67VxJvHEa3XqUeyveVWQuMTgW09ApanlsgOmO7h58Ubcin5DsvS48ZksMLS
 o485i5eOeJPmcvGmC9MhK2cBmXWjwjYAm4vRQMT4vnCmR2IJ5ACYUUGXcpBV83POTlAM
 Q2ZqXZA+H1R1/4GkktRWFoGuqJPg73+NeLxZNCHedBnLqG6Oi+pF77+ncDJmMxkEgQHL
 Bbqg==
X-Gm-Message-State: AOJu0YxClzQwqUlxSfq2ptHS3K3zE1tzgC1uuF8xIkMmP5aLzF86tV59
 MKsBDPhMIS3gP2Q6O2HJ4OHUxPRcmuVBDPnObu5LxsFEJqVgcuezryVBwj5/058=
X-Google-Smtp-Source: AGHT+IGqYns31rzWU/zCq5Dk2HyK4I6uZ9qoC8TEazn0HOLX38mYn5updaym/ZN0jpp36+sv8LbUhg==
X-Received: by 2002:adf:f9c4:0:b0:33a:fd2b:bcc0 with SMTP id
 w4-20020adff9c4000000b0033afd2bbcc0mr902301wrr.5.1706626790729; 
 Tue, 30 Jan 2024 06:59:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i3-20020a05600011c300b0033ae8bdd642sm6554321wrx.114.2024.01.30.06.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:59:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E0F95F9D3;
 Tue, 30 Jan 2024 14:59:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] target/mips: Use qemu_irq typedef for CPUMIPSState::irq
 member
In-Reply-To: <20240130111111.6372-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 30 Jan 2024 12:11:11
 +0100")
References: <20240130111111.6372-1-philmd@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 14:59:50 +0000
Message-ID: <87bk92ooih.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Missed during commit d537cf6c86 ("Unify IRQ handling")
> when qemu_irq typedef was introduced for IRQState.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

