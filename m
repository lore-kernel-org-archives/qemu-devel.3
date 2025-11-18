Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FF2CEBF97
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLN7z-0007FC-Mk; Tue, 18 Nov 2025 09:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLN7m-0007Dm-G7
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:56:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLN7k-0002hk-LG
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:56:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso12034475e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763477763; x=1764082563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGAWhpUpxqCVxKw6l4fX0ruOU+Z0rt7SJWTNgkNOSSI=;
 b=WEUr51rwLErF6QbmfuKlI+JyyQVn3F7uzM9vLDHMQhN7TPdu+dRUs3AI3tJ0DGw+wm
 wRCmgrvfedFb50vHzYBJDRSMUiJlcSOoMnVgnN/gh//y0FyF+4eMtXbEc9G8/n7GjXQU
 r0qDX1XkYMcv2z0WA8EZS+rInaMfEOfabuGLcqre8wH4cf9cgT3J8UlJRqgV0dMGu9/1
 S96ssYTSMNh2bhBfoOER6Y7HROWmvbOT8217/etq5ZEEBokm0QJOLH8QNiXVLO6TiMGN
 3rndhIdlZm5kxyguCyESRkcHnKuHIjn/43JzmOb6aWGNtcD10Rp3eMkLkyAkz/CtVglq
 reXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477763; x=1764082563;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mGAWhpUpxqCVxKw6l4fX0ruOU+Z0rt7SJWTNgkNOSSI=;
 b=BbuCGnIwgsyfpKfZVEQ//n/yh1qTuou1pFngx1hTy0HUIUsXAkEZYIKuBCRgmDHQNa
 44/gifrFny/ctLCBMHlEyPuSHgoPkkS9/ND+R4LPRmKj3zSJ3/jzSL97jEJyennanLPQ
 R2Nj5fHmTIU3r25W02eerc5TZ+6WfUSj9lrs/Q0IdRGWngg5jza93wXIinHX1U8DyW5a
 1bi1s/Rxh4ZWABBjlAlTa9cNYkWvkd/vw8OFagKxxkQWVTLBXBCdGwuFjriYa+Ef5W+T
 gBDYbDYqp48RBCEvIggCl8k72Mac3NvibWiEkiZtMFfbQhh9nMn3tkkpc8B0GTPH5Bf3
 tM9A==
X-Gm-Message-State: AOJu0YxOiYExQwGH2axTCaeOsEiK7otk1wnAy+U7AqKSkeAOIuJqf4Tp
 xHhoDAFE893q7AdXbd1BiGHfUadhzAt4cSuSGzH0LAr9ab9Fj2KlR+4DUBqSR9zfOZ6FEixT9FR
 iS0Sm
X-Gm-Gg: ASbGncs0zBRjyIEtDiXeWxBGwSvozwTcF6NkPfpQz5s3hqutUjzM2ZfZxIdMF0T2L8E
 +7OCk9AAFvetOA3y6+NTjZUNGqvngLibDwx39rS/vRcKGlRofln0aOx76hl9plw0mEr+w3uGuyV
 lNG0KZg/Bk7JvWBg0IYsWMNT6/LIyJU1lcxovsqqHkmLnVmXKp1+JDvoySSQTbiiQfJsvYAz+Xt
 h4jsJ2RKZXJuFr3NzyFPb7YJtc8AIbe39ChbZMDeXsF0FHwhmkBVoXgVApCLdOXMYSlTEM5g8id
 FJsO0IFN5WYHd5ehREUrEXTlU7KdIfRDYpNhS8OylczQq1cxDiBJx5Vfb/WF3VqLfkJvA6kcwE2
 hWyeiG3CRNMuhxC174D9XKpDClEfInlOdwxO6Vs2P4H4PCDcniTlbdYGiA/VT6y01SJ1iOoFhSO
 KSW8jG+AaZlQ4=
X-Google-Smtp-Source: AGHT+IEBHq+DGiSspoPRNeaWOBfeapeSc1YKuBKNV9A869w0A+rEo79/RI274cP7TikDzOvldLIq3Q==
X-Received: by 2002:a05:600c:3b25:b0:477:7925:f7f3 with SMTP id
 5b1f17b1804b1-4778fe62d4emr141128605e9.14.1763477762638; 
 Tue, 18 Nov 2025 06:56:02 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e35b7esm378706095e9.4.2025.11.18.06.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:56:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A32C5F8B9;
 Tue, 18 Nov 2025 14:56:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com
Subject: Re: [PATCH v2 3/3] mtest2make: do not repeat the same speed over
 and over
In-Reply-To: <20251118102942.551194-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 18 Nov 2025 11:29:42 +0100")
References: <20251118102942.551194-1-pbonzini@redhat.com>
 <20251118102942.551194-4-pbonzini@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 18 Nov 2025 14:56:01 +0000
Message-ID: <87ikf7jsou.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> There are just two of them (slow and thorough; quick is simply the
> default).  Avoid repeating them for as many times as there are tests.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

