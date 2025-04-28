Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7A9C3ABA4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Oxa-0002Pe-95; Mon, 28 Apr 2025 09:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9OxR-0002MY-FF
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:55:43 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9OxP-0003aw-2N
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:55:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so794135566b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745848537; x=1746453337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEXGM8VEQ7TacdCTkEDwWwtSCt5+sL53MvUEavsTFoM=;
 b=Q/TXTaTftCsF80gNPRd4fWzqSaPl8EqcleXBzZN/puy2p5gtAZLoF+jRo7PH7bNPrs
 bW6zt1Seeq94mhtOL7v3rCt4a65eXmVdUvdjDrJn9g8cXzuqI1p/5kDi07XXPD8yAt2f
 8/dK5aaK+ugm8jtMQvPP/6MXqVTEBSsJeEht+gJWeIc8lMEizyUEyyOQijLqyTYYAc5k
 t2K+ik8pqcAcL+lvHUevuAbeAZ5cUNgctdY09jN10o/mXrqX9iGxbtm7ElHMOu524v/7
 YCvelzhDBFtabnp5TA0SWzhL7Fw/5H13GaGbJnPTOy8FqpEK394tTmCLGvJpY0r34DsQ
 a4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745848537; x=1746453337;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEXGM8VEQ7TacdCTkEDwWwtSCt5+sL53MvUEavsTFoM=;
 b=wHNYiUrpAeQPTQlCsR96Hh3+N59ZVGxOihWz1wTAZaFSVY1Cf9TAyKmLyuzx8cU/tc
 OsinVD0Ftm/dGULs+bgGDKM4wCGAmlZzQKAuX9JAi4gvZrKb7gBkoZIG4AQoBeq6Od13
 yZNfMWYNgLhB+l6/EfCumH4WK7Rb2NM491naG9dqNlHlPn0RGqokPV/yQDLOQGeyTU+r
 RXQWyQaoy0YzKmU2Mfp4AgkeMqc2Ak0zZfmeCJctdbsB8NGy4dNuv09+vkaqu8Cbn7bV
 RhcdJsMa4jty2Qzmqxt83507/gIoPwGQD6jBWDR3djF4B+NgIUx9FrY092PceziEtofd
 SJ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUccnf77gTDhAoMmN+I9u2VheHeuong2hZJp3UcZCYqraGV8bybNmxw68dW5uP5UNH98dbLaTwCCP6u@nongnu.org
X-Gm-Message-State: AOJu0YzRVWswHIm5zEZv1wewtees2UJH9k1pyjN1AaY/ZJZoWwfgv8kU
 C4izF0B8XZUaC5YqN5S+ExaZZoxIj1anRDmkhafqAnubfgp/wj6+3jcXe6cdr1c=
X-Gm-Gg: ASbGnctFwiObB/yPFbFa5uCdTo3qO+LdKY2HKNQrfAZ5fJFyri2q1T2MAij69qWmo66
 I0SG8NQ9iSc3yY0QMObeIWEvMCEQm/uLEfKuSm8nVNNsxr2xYa2kNrhoQFc0Uu+Pim6Ks2Jrx51
 YRF1vzzlQ8nuCx7Idj0qiyC+easWSPoqyehkWrJFctLESnsqwM6bngpMLqbr/rIKC1tnRP9vehM
 wWHoEo3gAF85UaznyDGISsfhC9b6l+qxBGyBVCcbxEEJdtbSm+JfyC3G77aDga7szAYVMcGlFdh
 rgzv/wf3tX9UsRqFlarvET+HFjWOgmauJC9gxjik7V0=
X-Google-Smtp-Source: AGHT+IEb4w7yVlKdUqckxkSYEYMebtULtjjmYXNW0Hy3uNfvsSfXqnrJ905dgSqaYu4CQ0BBDjOGTQ==
X-Received: by 2002:a17:907:7f15:b0:ac3:8aa5:53f6 with SMTP id
 a640c23a62f3a-ace848f8408mr698956166b.24.1745848537433; 
 Mon, 28 Apr 2025 06:55:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acebeca80a0sm44840266b.90.2025.04.28.06.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 06:55:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF2A75F905;
 Mon, 28 Apr 2025 14:55:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: liucong2565@phytium.com.cn
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,  "Sean
 Christopherson" <seanjc@google.com>,  Jiqian.Chen@amd.com,
 akihiko.odaki@daynix.com,  alexander.deucher@amd.com,
 christian.koenig@amd.com,  gert.wollny@collabora.com,
 gurchetansingh@chromium.org,  hi@alyssa.is,  honglei1.huang@amd.com,
 julia.zhang@amd.com,  kraxel@redhat.com,  marcandre.lureau@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com,  philmd@linaro.org,
 pierre-eric.pelloux-prayer@amd.com,  qemu-devel@nongnu.org,
 ray.huang@amd.com,  robdclark@gmail.com,  roger.pau@citrix.com,
 slp@redhat.com,  stefano.stabellini@amd.com,  xenia.ragiadakou@amd.com,
 zzyiwei@chromium.org
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
In-Reply-To: <3118467e.dc3.1967c73dca7.Coremail.liucong2565@phytium.com.cn>
 (liucong's message of "Mon, 28 Apr 2025 20:51:30 +0800 (GMT+08:00)")
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
 <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
 <f662c725-e40e-43eb-b155-2440cff34324@collabora.com>
 <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
 <03414f52-def8-4b50-8da4-69b722dfc758@collabora.com>
 <87cycw61m8.fsf@draig.linaro.org>
 <3118467e.dc3.1967c73dca7.Coremail.liucong2565@phytium.com.cn>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 28 Apr 2025 14:55:35 +0100
Message-ID: <87y0vk4ch4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

liucong2565@phytium.com.cn writes:

> I user Phytium D3000 8 Core, and I am not sure if it has a broken PCI.
>
> https://www.cpubenchmark.net/cpu.php?cpu=3DARM+Phytium+D3000+8+Core+2500+=
MHz

Ahh - looks totally unrelated to the Altera platform so hopefully that
isn't an issue. Apparently a lot of the PCIe implementations are based
off the same underlying IP but without details its hard to check.

I assume everything runs fine directly when not virtualised? Without a
patched kernel on the AVA you would see corruption for X11 systems
(although not Wayland). e.g.:

  https://gitlab.freedesktop.org/mesa/mesa/-/issues/9100


If you are happy your Arm can drive the AMD GPU ok from the host system
you should focus on verifying the page locking is working as intended
for the guests.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

