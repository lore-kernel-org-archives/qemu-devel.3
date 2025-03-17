Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE71C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBx1-0001Au-2q; Mon, 17 Mar 2025 11:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuBwp-0000rE-KZ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:00:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuBwn-0007HS-3X
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:00:11 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3040649f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742223606; x=1742828406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSSCP9zPNY2OmCBCLj9nNHscfEI5TLHwDb1acZrDD8o=;
 b=veGkmo9GxFrJCHr0ihv87OCZuvSScZrn2c1E/NV5sxwh7/qYHpUmf3uK1KF1Gdp+zc
 OjskB/XZf+4UJwUAIZu8fkZrv5d/cIw1z7J0je/tnHbhfEGvHk/IiZU593hegZKWr/dH
 0eHdG4VExoUt2nMZQO/jTsD0PlcgPzkpbv6a96WfsyMyd3hvD2+6c2xdH1h18IV1AYjs
 4YqqHBSmTRX2jOkG85PPcQ0LNqJcy983rgSfir4RJoPvnGChph2Xkr1o/LzmdoAHMk0I
 9q14twFYe5MBIk6oJ3S4c3IC3GIezSt8pSFySdN8NUvAdM9rxtKMtNYk2Ka4Zatsm+BA
 brNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223606; x=1742828406;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSSCP9zPNY2OmCBCLj9nNHscfEI5TLHwDb1acZrDD8o=;
 b=PYoPqsOGVs+N3r36T/qOVcER6x869Dq9MGz+RtqEHiUC5QuEtd/Ytcy/2tFpgDqQb6
 vn0pAdxxH4Meh0DW7HCTGYfYaw2URfpNVbEdkTguN67FAuxGjns7Jq3zaB+GU3sqVpf9
 DiIWN2a/3KStkhyl/06GhwSZTdsftNSOS5WIOQYfhSXNHJWKjH9eQbUdJfftQGmDtQ1S
 dP/SZdn/zqzBNAWAhI5E4XBR9QpWMR4oHyUKTi52gQX6VQs8BVUeig3eqNy6Khl2rTUm
 9YIUVEhk6uc643p5ThC6DWazOx1z5/PCDAOGablGgf32Jt+Hn4SBJCvjm6g2Xi7y56ix
 Ie9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ/P/AK1C0IdfJBUz0J8mZ3gIa/eG0CXZ6Cl8a9pm0RL1dsOiuqNn5L0lwD8fV1u+5iuDAykF4AScz@nongnu.org
X-Gm-Message-State: AOJu0YyEwuIqOo+5b4XPKPoadKz/KzhzSIry6OoMc5+UXR+8o6znKaws
 44UtPKfo2iZaeKwlrzmDPXxc65MFoY2Zz2/zJ9dN34cqFRRiO4OcZF+TR0XY0JI=
X-Gm-Gg: ASbGncv/SNdBX8+oHWaWEayUUbfQRNmsXDQj/i8tdt8bi5pclsY0Bevfr1eogIzmF8X
 VMaIiBgFxL6/NjiRVgzCLhWgFCKC7Fyy+SwI4ru7gGJPoWdq/48kgBSBCgVVUHDD8TNe4yDt/tE
 afBziHC8mz7fosY/QKwgr6RPWnZ1ATCcHg7wIk9Td4axVX5HXjUFlbaZcUgnt/9mssrPh0GNJ+r
 n2xdboBfWmg5T/KmoiFCdj0spzhHaUOzBF6UB4VpzofHhFXAiXaT9u4pq/Wl8QvdbDYYjMppNgw
 upNP7jxK2hbtkW5VLErVASKONRSiR/CVd1eo7CNUFhhzjQw=
X-Google-Smtp-Source: AGHT+IFqlAXU5ghPyB8LGB/0WjjxgNBx+wZA+ghFO/VM8tK4fZ7ibl6ELKOl8ayHGewkIog2ytm5EA==
X-Received: by 2002:a5d:6c6c:0:b0:391:34:4fa9 with SMTP id
 ffacd0b85a97d-3971a6850b1mr15546855f8f.0.1742223606260; 
 Mon, 17 Mar 2025 08:00:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975febsm15595396f8f.59.2025.03.17.08.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:00:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1685E5F892;
 Mon, 17 Mar 2025 15:00:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH for-10.1 3/9] target/arm: Handle AArch64 in TYPE_ARM_CPU
 gdb_arch_name
In-Reply-To: <20250317142819.900029-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 17 Mar 2025 14:28:13 +0000")
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-4-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 17 Mar 2025 15:00:05 +0000
Message-ID: <87cyefog7e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

> Instead of having the TYPE_AARCH64_CPU subclass set
> CPUClass::gdb_arch_name to a different function, make the
> TYPE_ARM_CPU implementation of the method handle AArch64.
>
> For the moment we make the "is this AArch64?" function test "is the
> CPU of TYPE_AARCH64_CPU?", so that this produces no behavioural
> change.  When we've moved all the gdbstub related methods across to
> the base class, we will be able to change this to be "does the CPU
> have the ARM_FEATURE_AARCH64 feature?".
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

