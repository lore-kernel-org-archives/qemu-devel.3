Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32F0C02197
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbFp-0004LK-JG; Wed, 05 Feb 2025 03:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfbFn-0004Kf-G9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:59:27 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfbFl-00022g-Ko
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:59:27 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab6ed8a5a04so1089547166b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 00:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738745963; x=1739350763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRy5QSxkB50liNc7fDoBvuhg0TDSaVBd/TizOuLSEh4=;
 b=ac7Nrjp/d3LTzVyksR8mORtdkhcqOAy5Sqo1YYp/pz4bFbSm7nmIPfg2w7a6ey2Wpx
 sHjos5VsTEFsnPsBAszf1clkduAlv7J8nPg/B5STPYEWSFNhPLiLrA9FSsnwCfP3jt0+
 wjHGIAEjlz+qvCYcLTM0EVaDCJsMxB2Sx9qFK7Q5CB6NI91yUh6hPg1JxSq2pUt0yT6Q
 MXxL/+teyLSJnZSxcOxrNQ2xTuPRtC6OM4hVKbj0tmsfVuLK0+QqOulRGew7q3wTHSrs
 vEbKk0vZzT1rVtdRrOrB9jqPp9EVvE1cJN2NNH74F0SFOOrog9aRFu3XPf9rpxA3oC+o
 MOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738745963; x=1739350763;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hRy5QSxkB50liNc7fDoBvuhg0TDSaVBd/TizOuLSEh4=;
 b=spkyp0wVk0tJDCv7nHyc4v2juOljre1aZ+xzYt1PQt5AmVlo1H7boKx3Yg9gdjrKex
 Ux+oVZvHxsg4Uo0AQrJgFJaOCF+2uRbos7ebygwoPnf//0uzim7Ay2cQJ7i+20VqBuhT
 otg3UwPoh6n/5yfVvE+h/QK1pbg37oO57ds4DdvmrGNj9oR9PEy5jDIIYUy3lYjpnS7R
 uTmcD5PDra+A2nVn2PeHTDit2K+HSTFj6jrBBFpoc5yAWcRU1kOrodeMQbs2EGVBVvgl
 12G5HN3VgnGLGHUhLl5tPQi4wVOaEHmx+7shQ3tHkMngO2iY+TodpYKIapzb5uzakE5k
 iNyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfHmwsq3PJNdL8CtRM+FOguZkrWSmZzm5DK8D4dCypLDqW8/xkjHPnlRLtx7U+1Z80OZUH1IS55tbf@nongnu.org
X-Gm-Message-State: AOJu0YybazBzsBn7MENoL38iEpt4WS/s8cBpnYPt0kgIZV6FuC5gyQTD
 x00wtx6APFx76kCuAjUMN2ipOzByJ5ZRa4oanuqt6CF60qy2LnbkiBICw580iTU=
X-Gm-Gg: ASbGnctz7PbSh8eE7ayRa8fQfkXV1Tz6oENQaVVhYZZCPE5eP8Lr9QX9AxrKyAQ41C1
 PAiS0u9FjNgFk49wqVRE2Y8f/7rjGx/ZSiwZu10JrukyrwJRIw1RTVF/vzNBrsxrxABeg6HCOsg
 tv9BDyVOIzEQV0oGMsavevB7JTffA5fA/Kx8Es1HPLVi4rNjrtTEE+J3NTqoYo/0SS6VTm6axJq
 UThVY7R3JRZy11+6n3AdAm0MBsaGim80LJ2ShLq+Y72dU08KD/dLByll2eMAd5nD7taTsl4iW8S
 hSJdz0FkhFMXsOaC6Q==
X-Google-Smtp-Source: AGHT+IEm/OY7UR98FfWXp/5NAGxLke08KHfHgfFdL/PDGA910+G909QHuKbArPQMHhG1nU94G/tu3g==
X-Received: by 2002:a17:907:da0:b0:a9e:b150:a99d with SMTP id
 a640c23a62f3a-ab75e212f20mr199017966b.5.1738745963427; 
 Wed, 05 Feb 2025 00:59:23 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47cf88esm1056076066b.46.2025.02.05.00.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 00:59:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 35DE55F90B;
 Wed,  5 Feb 2025 08:59:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 01/14] target/arm: Report correct syndrome for UNDEFINED
 CNTPS_*_EL1 from EL2 and NS EL1
In-Reply-To: <20250130182309.717346-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Jan 2025 18:22:56 +0000")
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 08:59:22 +0000
Message-ID: <87ldukahsl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The access pseudocode for the CNTPS_TVAL_EL1, CNTPS_CTL_EL1 and
> CNTPS_CVAL_EL1 secure timer registers says that they are UNDEFINED
> from EL2 or NS EL1.  We incorrectly return CP_ACCESS_TRAP from the
> access function in these cases, which means that we report the wrong
> syndrome value to the target EL.
>
> Use CP_ACCESS_TRAP_UNCATEGORIZED, which reports the correct syndrome
> value for an UNDEFINED instruction.
>
> Cc: qemu-stable@nongnu.org
> Fixes: b4d3978c2fd ("target-arm: Add the AArch64 view of the Secure physi=
cal timer")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

