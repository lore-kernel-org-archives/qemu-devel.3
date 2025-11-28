Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C9ECFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 08:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOtjT-0002e0-Kz; Fri, 28 Nov 2025 03:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOtjQ-0002dL-R3
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:21:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOtjP-0005Bo-8g
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:21:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso590895f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 00:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764318089; x=1764922889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2b9YBmYnSajt7YK1EINopDFJY0ljHmkHbj2X+ufVtrk=;
 b=cgyprACWHtEVcn8n07Gc4lWeiLTeTJWatjx1IYeZZpKZD4Ps56/W79VA1yV0kAbcCT
 vdlYU+VK6vAm3rsZQDUp6y6uV/c0CtTqUAeafHfJVdPwVaq9g+y8CnNa20aD4iosNUQG
 ZakxR+2oo6DdWNVD94fOCSe3lzDf4ifhUbFiCd8p6cK3+4WT9bwCR3xUO/KD9vDlR8aw
 nMxOph1638RNxyUDmpmp4TxS1YD8tBu/6OpeD0kHo4zQ90iKNv2+tVM8etOqJRo6obJG
 Be+IP8E6SDARsa77k2/5KAgNXKbBmsPiWe3/NzXBQMVzwTu+dS3ppQna29q4DFCIDdJH
 B8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764318089; x=1764922889;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2b9YBmYnSajt7YK1EINopDFJY0ljHmkHbj2X+ufVtrk=;
 b=R0PBskanofzzDedA2A061bxTHfuqkujwj0b6xWDmpJnOuZJc3iBDMhG1Cm0faLosLG
 7Vr1yLdBsayfkv8/0aejvarTqaNaSRX9V2KG81Jngc9s8PAOunixFclGT8ahUz2qVbj7
 ebdTKmXjGqiDK6i/aUYZJ57A5voaYtXyHm3n4VwVCbcWa7m40vxluTu9SQc6bIMUirfV
 ZkmX1l6ZFoTG43x02d4dFnCpe0qFxCA4cutGAycRl0PG47oRd6IG9UCz+hoGcLGFjPLa
 pBNjM7qIra9P3XVWXWAmrM5wcH7kO6dwVP7uPN3x6bl+GHWP4t0vJmwygC+HwYhDXOjs
 0AFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2N4XxPwP3ZuADp1wMM+tEtsFrcTx1jpR3Oeh+uv3B5aC+x8tZRqdlXPYrhIdyHPPp+shD4odiez/V@nongnu.org
X-Gm-Message-State: AOJu0YzwFEnw8T8RccANcdJxVoR16N0EIvKJKq2GsDdMXD5n9pGrkvhR
 yAnNUqb9A+iSloIquhDH3SfrWkvU8wMOveJyjZLK0XWTZbG4voY4lq1xoEBGVtkqvSQ=
X-Gm-Gg: ASbGncss92VChCo7f/cWzE9OcmRefPF1YrvLIK1h7pWHgt2HoEby2xkdnMs47hADdaB
 HyHZPQRmu/9gCRKcepDtMM1g6SCtG88t142Z7hT1aLwmyor8ZftmVtbSX9QIR+vpRyIFdUWeGjS
 BHoOl9S5fLRoC5tH+ZVdg8xbnPRWtHwpGGr0rtJEWVopPgABk8zJyqoBWPd9VNQF960K9v0mAF+
 +WGKqvmLNNgoR0XwFN1DIFywLTViXLXmZV2WjoNfS8t9DL/1ZU7icwAsZQ0li98/51EDZ8ydKAS
 yJMnbI4tfBwLB2nUZ65hlw3tzeO4cH4+kIvwAmVC9Lo6LH79cB8IfDzbGRRQGsqErfqcBhl0V1W
 AXbnSw3eHzdSAlYEHAiiY4q4l4TagwyvWqHb7TQdIMxNmljPhOmCHJ9TXIyh/q4VeF589s9w5wx
 DkLLwU33cV9M4=
X-Google-Smtp-Source: AGHT+IEjC/B4nkDXLJwuz+VkQS8QD7CuGb+GgfVvFw+N04fNRUeedyBnadXQmwnVDAPmYPdgQbBWEQ==
X-Received: by 2002:a05:6000:1886:b0:3ec:dd12:54d3 with SMTP id
 ffacd0b85a97d-42e0f344635mr13596196f8f.35.1764318089447; 
 Fri, 28 Nov 2025 00:21:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa7406sm7744155f8f.37.2025.11.28.00.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 00:21:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02FC55F820;
 Fri, 28 Nov 2025 08:21:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joel Stanley <joel@jms.id.au>
Cc: aik@ozlabs.ru,  andrew@aj.id.au,  benh@kernel.crashing.org,
 clg@kaod.org,  danielhb413@gmail.com,  groug@kaod.org,
 sjitindarsingh@gmail.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH] gitdm: Update IBM map
In-Reply-To: <20251128012151.711182-1-joel@jms.id.au> (Joel Stanley's message
 of "Fri, 28 Nov 2025 11:51:50 +1030")
References: <20251128012151.711182-1-joel@jms.id.au>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 28 Nov 2025 08:21:27 +0000
Message-ID: <87cy525zzs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Joel Stanley <joel@jms.id.au> writes:

> A number of us have moved on from IBM.
>
>  * Alexey moved to AMD in 2022.
>  * Andrew moved to Code Construct in 2023.
>  * Ben moved to Amazon in 2019.
>  * Cedric moved to Redhat.
>  * Daniel moved to Ventana in 2024.
>  * Greg moved to Redhat.
>  * Joel moved to Tenstorrent in 2025.
>  * Suraj moved to Amazon in 2019
>
> Most have either stopped working on QEMU or swtiched to corp
> addresses.

Queued to gitdm/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

