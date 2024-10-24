Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E4CFA456
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3umK-0004MR-O7; Thu, 24 Oct 2024 06:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3umI-0004M2-Mr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:09:14 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3umH-0005Pw-5L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:09:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so80573266b.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729764551; x=1730369351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzmDY01L3a4QW8U3i7R5j0APsDf/UzCDPnfjlygwr+A=;
 b=KRjQwUnzn0PakMuputudVkQvZdYjfNymlXt3PtvuvZL7mE3XX0cegCxV6bpI0YcPg2
 PBQD19qQwHxFG58iKz6x1wvys2yajDheoY8TCbneOubGapN816Zs9X9/r/mec4WdHdoN
 g9dmxzz+ssbrvyBvmfWpQr46t64rl+VcNog8+j4q56qGqPm1LI/7WmNH2Nbyu4MLi1XD
 gAIuoMoXslO2Tpvi3wB6Zq0A0QwHhXc3evR3lV7r4ir4oLjgZtIPIQi5yrb4lyvYC5DX
 Q4WNuQ5wRgv7AcC3lmC1rOT4gN/f7C+R41jRhdY9eGpM3BX+Ort4+Y3Vu357yCvyS/uq
 T34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729764551; x=1730369351;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fzmDY01L3a4QW8U3i7R5j0APsDf/UzCDPnfjlygwr+A=;
 b=n6ezquZ3NNgb+2qrI6e7zIOVQkXqk2gddTxzam2gI0qNOIXMH6OOD4xT1n8RHMf/58
 bkB8Gd6lZToB6yRENipSBuJ+tIDTqwwWt8eNOhFCkGFEcb/pVcCzDNyxISOGHtOCtOKa
 Rs3mPH4XtNALrwtL9zhXxogBb7Sp0OsPYTgASfvrOU87XJhsR39OAWlTwd8Z8qfhVgQ2
 hZZSvP5S01yseoR0JHJ8mVs0UnBcQO193rZRrKEHzL6hsEkUGGq5vbC9+sRe6NWZLz1w
 eJByrctSLxWeq8OMKXpbdI+k4n4LP2eiBweglT4cHdtG08mrqJt9QAWIVODxdiuny0H8
 sF8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/O88dwGmQRNNfBSDyci82sUGDkj6sHahAbIzKAOnbACcq1MHwBjCB+7+sSGXVyXD87fsUp7fOizYc@nongnu.org
X-Gm-Message-State: AOJu0YwvPM+LWKJEEt0MAHhpKMFoQcivnKcvRUnFYGyjg/5+LoS95rs/
 JTBLxapg/UhvqKVKRvHJoD6PlPoIkAZ+fcmndzlwXBZ6i5nzyXiUqQH4HBoyTHQ=
X-Google-Smtp-Source: AGHT+IFcmyWzyE73dsLk57UjkbHveswh6uh2TAVcE1okyBdmTqPtConvn3N0to7DcWpPDXn3EJi8Iw==
X-Received: by 2002:a17:907:9405:b0:a99:ee42:1f38 with SMTP id
 a640c23a62f3a-a9abf8aefbdmr505233566b.31.1729764551455; 
 Thu, 24 Oct 2024 03:09:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9159a2bbsm591820066b.216.2024.10.24.03.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:09:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BB045F897;
 Thu, 24 Oct 2024 11:09:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v2 0/6] Support virtio-gpu DRM native context
In-Reply-To: <20241015043238.114034-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 15 Oct 2024 07:32:32 +0300")
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 24 Oct 2024 11:09:09 +0100
Message-ID: <87ikthke2i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
> It's based on the pending Venus v17 patches [1] that bring host blobs
> support to virtio-gpu-gl device.
>
> Based-on: 20240822185110.1757429-1-dmitry.osipenko@collabora.com
>
> [1]
> https://lore.kernel.org/qemu-devel/20240822185110.1757429-1-dmitry.osipen=
ko@collabora.com/

Now the tree is open are you going to re-base with the tags and get it
merged? We don't have long before softfreeze for 9.2!

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

