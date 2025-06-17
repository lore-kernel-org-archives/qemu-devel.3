Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B4AC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSwx-0001kh-P4; Tue, 17 Jun 2025 05:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRSwq-0001jU-7R
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:49:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRSwn-0000qR-Vi
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:49:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so45333355e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750153779; x=1750758579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MIGgXe0qn24URSUCKWhPtEyR3MfgmbY6tI3zH7K+6g=;
 b=F0jmN0H2KEIeMKyYVrQUyIVZn/RQFRv4KGf0dYXqH/kskxxGiE8298D+H809In5h9V
 4kt4SbyvTcVTgXNPVwCJoVBTG4RqiCnwqsn9vibMZCRlgasuMo/qnRUgjzyJcCf6TWFQ
 lS5jMi4RICvRlX789Eo2VTlDtzXE8IUHC4390XRUxvM8PnfCd08xQbbMLW522ZOcVs8d
 +TSV/4I5W8iLpFIXPyz5pBmqfNRSuGeaHWHPnx++ycsPD2SEQ391t3MUj7yTPbUrFKLD
 W+UjiTD5yIxn63nVf914d5lbQFOvf74+yodK2Uwz8byF7HtxMSsBE7tEvvkyVNkNbnZK
 /rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750153779; x=1750758579;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0MIGgXe0qn24URSUCKWhPtEyR3MfgmbY6tI3zH7K+6g=;
 b=C2lUem885brPDv3sjUWKdMaXvCAWaPf6YpaShLkBP0Wjd1mf+qY/ROGrk+mBpodA6k
 bsAcglCumM0ljeTxEz8Ev228Zz/bWB8aAyYSZRKI2oVR7yMxll8kU1HKci4M7sw5ybQc
 kOkRbKH/6WhnBlLYXbptJVEKGrYCJeRy3lUh/6eZyUg5UgHjD6rnsdc4Z+PHswCre3+u
 MlFEuqaK4Kn2NMF/3AW0XrP49Gn9fWeZoqd0hCu0f0LMzQAeOeHcERm10W4R8ZBJsiH7
 0Ovx/xJEM7da/Dj+HWCsJ46SO0rh2t604N6FdV3lF2KCfE1HZLFQwOKKJxsMBrsm8RTo
 34bg==
X-Gm-Message-State: AOJu0YzQw2pT2IIBgyoL7VtgLxWzItD/hjys1qzy3s1SzhD/53DIyhno
 STIfEFIRvVR2N2TER0Lv1ui/fXdahdLmRslaUP/ieVKWc9fK4OaeIHUf4A3XgQB9f3o=
X-Gm-Gg: ASbGncsg6mJyhj7utdqlgZlxczwu9VN6wApaP9lnT83klpJiJApmzW6xm8gYra9rwn8
 385BdexUSrI/C/nEVUTK7oFbqWh21cQv6Cn8erw9LnPRi4JgMAuvoHaUnBsVmLs519LHWNfk/Ug
 Fmr4yyQW508EVjxyOiJJCnnWHNJkBlHuRW2CJBx7kDbCa5eBquy1CFLRVOSK+bUxX3Iu5hRxzPq
 vHPeRkwx0yQxoDDjEAS18GjHWkjxVs51dXtrisLN6bQOcbrzmljYb/oUQDCGhCjIBtIxBD5251/
 FYg60cEMhVK1q1k0iLySphhKollMCW/5wR7vBMS6TbhI/+gUxfWprffzavVs5yI=
X-Google-Smtp-Source: AGHT+IExPSZmM3rkkLnGvglSp7dxaL9vViuqBVvxKfWYx0haex0UFVQEG1ERtyuYutibnG4aFxOxxQ==
X-Received: by 2002:a05:600c:1e27:b0:450:d568:909b with SMTP id
 5b1f17b1804b1-453430e5651mr93647835e9.14.1750153778783; 
 Tue, 17 Jun 2025 02:49:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm176355515e9.29.2025.06.17.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 02:49:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FFEE5F834;
 Tue, 17 Jun 2025 10:49:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  thuth@redhat.com,
 eric.auger@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v5] tests/functional: Add PCI hotplug test for aarch64
In-Reply-To: <20250528203137.1654964-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Wed, 28 May 2025 20:31:37 +0000")
References: <20250528203137.1654964-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 17 Jun 2025 10:49:37 +0100
Message-ID: <87msa6vgsu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

