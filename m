Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E92E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 19:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRCB-0004EE-Sk; Thu, 02 Jan 2025 14:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tTRC5-00046O-P3
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:49:22 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tTRC4-0003aA-4v
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:49:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so79674465e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735847357; x=1736452157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEPqog8njYY5NGwc1eOzP0PMQycHlah5Rlw+iHhu850=;
 b=QYVRDyGm9wRF23CSEI6fN1MwgaNL9JMQrZTp/YWEsnByULxkbrrJlZZdVpnaqISrHM
 7GgMWmZIX3aEwu3/mU5e5//eA7aD9rq6RmlmB+KpRRuWb9K2OexTheQ36u+BGM9UcV8D
 TVpDxv7ZsWRY9gCpFJa188IuqGdsYbgmnUpD2PCvY8Cw21tloHE1qM4MUakY0HCgw9Wi
 83tbVSng2c4qljfw2j8j+Q5gBtzPOeFhhlikaOomp1rhvyKp1m5xTvj+kZJ5uRugzdKY
 C8407rHhuMHGw4tDPvYaurwgrLxUreu1HAALb9X5lfWvgzkYSk8N7S5U6paNr6un2MLk
 GOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735847357; x=1736452157;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MEPqog8njYY5NGwc1eOzP0PMQycHlah5Rlw+iHhu850=;
 b=V5TwLiAAeY8/mHW8gznXOHr2fb+9lKKjTNM4s2f7o7sMhsAAe2fwhIrNvC4CKuMkP7
 4CcucJw9PpiX4Fe6VYt7gI+Jyx9BoYxD67SKNSq9Pa3PaqhtqX/VqzyFxBzLYc2KsxqM
 Tcwqk4IAGS56BPEcxUFCTqdWIT4lBXEL6DaeJucSLLkTZLO3dI3Vp97zXUJ6ys3WQnJA
 0YsS01XFjZQXU8uLQ1HeExfx36a5itqNb+Lx3rA7Zn9ashl7wTxXrVMy82pb+L3gXvdM
 IaJ6r0sENGnMlXL1iGTHSkmNa1j+nIlolqlW8U4G8Ob5kbISi+T4bxlVedSEsJzXKZ0y
 ft3w==
X-Gm-Message-State: AOJu0YxF0LgUiooufvh3LkVtpVUYAmQPwJ1WfVas+lrRpnKiIVX4ILGo
 sTb6JHG8uCunftkPzQZa5sc5tCT7V6ZC6D4nERtu0qvQ0N0byE+5JkURm7s4fgw=
X-Gm-Gg: ASbGncvin2ohwS71pFOTi/2/Ntv7tfV39jla+IJQYvO8KJpUkKejV5AHBc8qKlYVjeN
 AvN9S9muHxoBSoceIlMp7Jr1nvBlGhB5pKkfdAxPcf0xt7jskf35PXbul9PH6dPS2u0L078LG8s
 4yAYjT3jhdhXOJ1aZrI249VztjpgL+KuSFuhFm5Zk5P9X+OekI57zxLOJ/O89914WMSJep5REly
 Zq0BIDatzBc7zkrarOU1TQN6TB4zUNRDcQNH3QEFHIGNK71oTg/SIY=
X-Google-Smtp-Source: AGHT+IEkWFW4n+s8I3voewKCXxO2vTmPfQfNJGylhQp0PthToUpbUVP7ywbuUsP9UtyIvBfMy2c80Q==
X-Received: by 2002:a05:600c:4f94:b0:434:f953:efb with SMTP id
 5b1f17b1804b1-43668b785d2mr345968945e9.32.1735847357482; 
 Thu, 02 Jan 2025 11:49:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366121955fsm468754985e9.21.2025.01.02.11.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 11:49:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6239F5F8C1;
 Thu,  2 Jan 2025 19:49:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] dockerfiles: Remove 'MAINTAINER' entry in
 debian-tricore-cross.docker
In-Reply-To: <20250102152513.61065-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 2 Jan 2025 16:25:13
 +0100")
References: <20250102152513.61065-1-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 02 Jan 2025 19:49:15 +0000
Message-ID: <87ed1luhc4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> AMSAT closed its email service [*] so my personal email
> address is now defunct. Remove it to avoid bouncing emails.
>
> [*] https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-ser=
vice-to-end-august-1-2024/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to testing/next, thanks.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

