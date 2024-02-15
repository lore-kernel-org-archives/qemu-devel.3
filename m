Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F30EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafvd-0007Qm-LG; Thu, 15 Feb 2024 12:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rafvc-0007QV-9s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:53:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rafva-0000VU-Oz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:53:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412255afa19so4413635e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019621; x=1708624421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzktAMvtO7C/mHHuwjSjiIz1occrK265AGq4J1ErblM=;
 b=vSnf7drZAos+n25A5S6djz3MWe+K9U8u9EczDC5VKwDgaaQzuVBc9RGvdkWw8qFJnF
 LjHl4C2jXNDdFMM4qTVNoC0sc5CUhq9JfgWIoYdINlcSWms+iZtj2WlyWWTd2v+J9jLw
 XBZ/0J3gUc8yJLclYcITolq5SxPOI1T9MV8jPgRQPYSa4km6VkFGQl93vfQyLm1LzC15
 0vdfIef1UZOuPMMqCepCZv8EzwqT0iYdaYMgn5SBdY8topA3T+0F9Kt4zuWqgbI67Ear
 wzh+VfnUqJEdSepFstq/YKf6oN+U6+aPB8Kl8zRBBwN8omObyt6l4kQX9fyPPpBAjaFn
 D0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019621; x=1708624421;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rzktAMvtO7C/mHHuwjSjiIz1occrK265AGq4J1ErblM=;
 b=SSiGrnxfvwm3RzI5Faw6qFVnl8TZSio1xMuDYywQQueNEXbcve9I7GA8XC09qCASfL
 ZFapb++9miAgiHB74dWJrBqo55qd8nVxbS6PpFa1q0vEtcADjWSAFtdL5xQN9nn0A6AC
 CCurQEfYFZZuj5L5cZaauWXjxK0tBbI2IWf/bVZ80OD0PlgwketSXGGCEarEaWkkx8l/
 4Wmscilfzfpihoh2luAfq3et1k943HqggOZBHXtlHnPkxrNXWDCnNnUtMWMedSCJ7oWS
 LHDunr3TIR3lm1XKbD19C3viGgYZg30+xZUoOyjzkKe65E6+2jmk8qDEarCdBeh351dr
 PF5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXet84D8DlzaBX2Fd8nz5n6lEnRphitu3+CsH/lMR+POoWby8upyo7Jz/tkdtQ5CIKQYTzMaUYZNNBsiKCshon3nMmDCD0=
X-Gm-Message-State: AOJu0YyVvyztNFi++/7V6KmVgk9GyHMBEuX13YkDGOh9juWf2/m6vi8w
 /TY60qUXFWoiz8Kj38//hUpxgIgu8Ymdat/LR7S5SB5rYozWD8rQz40zlgRvK+s=
X-Google-Smtp-Source: AGHT+IHl7pVTwGKUjnJLaX61A9k8tkAd3j8R809ZLVOuCmzU6QLtUtOYuRb0w0hIG4U+x1tgZgl7DQ==
X-Received: by 2002:a05:600c:46d0:b0:410:bb99:af83 with SMTP id
 q16-20020a05600c46d000b00410bb99af83mr1739986wmo.23.1708019621244; 
 Thu, 15 Feb 2024 09:53:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ay14-20020a5d6f0e000000b0033b2799815csm2673475wrb.86.2024.02.15.09.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:53:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80EC35F77B;
 Thu, 15 Feb 2024 17:53:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 09/13] hw/arm/mps3r: Add CPUs, GIC, and per-CPU RAM
In-Reply-To: <20240206132931.38376-10-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 6 Feb 2024 13:29:27 +0000")
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-10-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 15 Feb 2024 17:53:40 +0000
Message-ID: <87r0hd62cb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Create the CPUs, the GIC, and the per-CPU RAM block for
> the mps3-an536 board.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

LGTM:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

