Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CE6E7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwfi-0004Ev-7B; Thu, 26 Dec 2024 17:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tQwfg-0004A3-GE
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:49:36 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tQwfa-0004q9-K5
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:49:31 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so1417756566b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253368; x=1735858168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyVa46bX1WsdcEitAxUMph0tk4txT5xR6ND9lEgYnKw=;
 b=t1VObxw2+lPQ/JInjD0r7ASfRVYZ6VrXlJ2JmnOEtaz+qiYtjKk1igQ4hK3NlO1Ai6
 x0lAh4zPrcLNmHBQL81nxC9EvbPl9+ctONCG7ZNt9ZgoKHECs+AVySPQfybGMYaB9kjY
 C/j2gdFr9XbU3hgZeecjWNK1fkeUa/RAFmX8hA++gk3+uNohE4myQ47Kmbb+DzEV1RSp
 zEyBfPJ6q+ayCoA8Av2jiKRVyASdtGoaQsJmWHeiOW9R5+euNrIGxLCKvCFXqMBxrSke
 aqIV6dafCJ+iuR7UpvoNt86aQKoWYL4LPHgixmTYl3gwg90sLHlbbXu9pzi9p4aC3yT9
 IfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253368; x=1735858168;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tyVa46bX1WsdcEitAxUMph0tk4txT5xR6ND9lEgYnKw=;
 b=N83rpF4sS5X+BvT/1tuK7ad+Aru9+V+sc/y+9W9HS0EjD8hUQB3jkgf3u2syeUY0u1
 sunWEw8qQtgX/wgSowTEurbgLSuyxDoyH+AFXK0snw7EtyCyNiqJWbbR0MKo6bYgRSQM
 6qoeiSf0Ln1H0U4TlfoLgsx/7uc/804w690IyQIrE6k48jPebydgUFWaupNObGGYqVZ1
 cJuArvZWZuuhv4V46OtEx8oaXmNHnrkdcgQmfyqY3SGkY5tt91gJ7z8Ajj96xx5Ke+gu
 F/fmREv2PWxp7XaVmIq6VRk+uCo3l4ZCrSpMVhujXeGDU7G4rWblr876gy7jPeQZDAWG
 k32A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYUlIJwOu/i1GgcS/rhTvuTS8PF04KVR8BefR/xxcywNTrkRsKa8PtGAyB7L8Xv4kGMr2M7FLrga9K@nongnu.org
X-Gm-Message-State: AOJu0YwUGfaOVX4W8i36WYWRlSeXi5XzAuudgY9JsQTQNh8Gi6g5r0Ns
 OFcdD+Y9c2rG7FVqJEklr1xIlTg31bHcYLBKzjKNGufpfMd+6avg7ymA7AVCrSQGqmmigZEl5+e
 JZjc=
X-Gm-Gg: ASbGncvY64LjhIwiuaHkL5ekHwb+m4xeplLDG1mRAsJkCiLeU5wvPkThgeoVaLRikLv
 pyzrjYCerMnJ9q5LFScR3zXVfDMnjI4kfKw64+iRoiO60duRalP7ZAjmy0SBb6hHj3PytdB2ybx
 1WRWGc0rn0Zeh5aXvbA9qDtHEXGCNIf3POeU/+ccQBpIh5AqZeSdhmVb+6ng6Mec++QYh3yFItJ
 9QgrGjbXDdcjvVyRjW6cGkgzzPIWLl+2mfP0XXDpR4zkhy+L9P6DiY=
X-Google-Smtp-Source: AGHT+IF2w/VftigUceH8Q69K/kTrwCkoRBKNoJPykU8izGQCp16Cr4LzqMvZhjeF/59kiG7RtBhTbA==
X-Received: by 2002:a17:907:3f0f:b0:aa6:8b4a:4695 with SMTP id
 a640c23a62f3a-aac349d32eamr2008908766b.31.1735253368494; 
 Thu, 26 Dec 2024 14:49:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82f577sm1018292466b.18.2024.12.26.14.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 14:49:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 333E45F8BF;
 Thu, 26 Dec 2024 22:49:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tigran Sogomonian <tsogomonian@astralinux.ru>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] hw/misc: cast nand_getio value to uint64_t
In-Reply-To: <20241226141626.28722-1-tsogomonian@astralinux.ru> (Tigran
 Sogomonian's message of "Thu, 26 Dec 2024 17:16:26 +0300")
References: <20241226141626.28722-1-tsogomonian@astralinux.ru>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 26 Dec 2024 22:49:25 +0000
Message-ID: <87msgikqkq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Tigran Sogomonian <tsogomonian@astralinux.ru> writes:

> s->buswidth =3D nand_flash_ids[s->chip_id].width >> 3;
> <=3D 16 >> 3 <=3D 2.
> x <=3D s->ioaddr[offset] << (s->buswidth << 3)
> <=3D max_uint8_t << 16
> With x << 24 overflow is possible.
> Other cases are similar.
> Thus, need to cast return value to uint64_t.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>

This code was removed in 192f75ad11 (hw/misc: Remove omap_gpmc)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

