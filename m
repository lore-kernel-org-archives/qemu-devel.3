Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FDD61018
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSy7-0006YE-TK; Thu, 29 Jan 2026 09:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlSy7-0006Y5-66
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:25:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlSy2-0000aX-Po
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:25:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so8086645e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769696753; x=1770301553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7jnQfCSnSYMjfClHlZhNPaVnBLTtEV2GmdtaRmWt6Q=;
 b=PzlGefxZg/D1q4hAZyuz4qntyuYkbp+2Uxt5wjKGiWzeP6O4PS6VIV9GrSYPaCbFqO
 u8AJN/CURJfLg4kubSKt/BLhDYHT87L5aVm81x+sYU4kREohm6TpcWyth1xS0LE2CUSw
 Nq0dMhorrPuDdTQ8FSnVDPgcJRepMfhFmmdSlS2nBX9kzEwgczpFU1NB0xBgH6XiK56E
 W9dNdzHC25n28sR6Lpbx26v8HhYbj2FkQFNBKIt1F0xxA7y1ANQVL08atWHFBETy33An
 3h869SMkxp3YvAnBQMQR6ClPCozb6DlVBjiGYQ8IGfD19iS6eMm/fZE/drffww4mrx41
 FcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769696753; x=1770301553;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7jnQfCSnSYMjfClHlZhNPaVnBLTtEV2GmdtaRmWt6Q=;
 b=WRoK13YhPiHg5ZP3/YN1N+Ao+ibJYPu+OErXHI/Tsn1jFkUhrU8pQZxVTpEoMuGsm0
 sTOBBW09ljtbkhVUPD3eoBV/JLoEf3wjv5/1XNa0SJlgUpyFZf1FhF7s6MJOjP6GIicJ
 ZK6bNA5MLIH2m6wHRb8yNbchXO7G3c8s7s2vfWtWZLDwERIZtwT41BYkZvnSRvnOExtr
 eMDJwQNmo75Zp9gq0IBiGPQjPr8q3ysSHkO8tRgi4B0vAinlRob8zKtcPIATFu0JoNtC
 S4G3nceZQCUcrJiw6Plv4CI+ECS23bii5V2htWVFoF13642XhkMYvGnQ+icerUamWnz8
 VOzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW2J+cVmo4PxhvpGyeza/+m8byMWG3TIlggFbkk63LQIAcghnYrMJfFDIohY9ixrE+K8uPoiLfnoIJ@nongnu.org
X-Gm-Message-State: AOJu0YxSc96XJctEI/dBCr0OQoiqGvdAWssZKGe8Jw6ShHDAEwEZ43Nn
 YstjGNDecMHSstVp978UzVOZ31D7T23afl0YxNIBA32FesJDOpBHmVkGHosTrK7wIQbgfmex9Oa
 vX+gaJ3y83A==
X-Gm-Gg: AZuq6aLyMkt+/djQl8Je9eR7+tpsmuNHLZOYEaTsz72vXgLHaA1hcgTYCj1qGcPwtdN
 Sq2wHnKHtuann+z/NXo5qF+JL6NjxhV6mdXKe12H55HXKh8RsG4t4SQmgObj/FA6/T7oLNJ9dtc
 GxsC2o21mlbLFJCkGlsoTcWg/Q2JtChClp3hk0wOC1XmuYZeX0abr5K+Gt7TXW0TKmz+Hmj8zjJ
 Nw4IU2p5AgYm/8Kq6j0lNjoIychJADiD6v3jRdfi9j835xUUWsRgNdf6EzpAQeUyQcp2lKg1eO3
 Ym1+2fyyDXwTSMbEpVyGrvGNi6q5efPBmbIQHabgkHbjewyi22X+kPd9jTlf3pQeJR9L/JrISfl
 E/8/DH72zbdo2YOsxisStEgs/nEgi9Ktfq9YK0G2lRWQUVM714QNwd0Zt1qYx403Qq+jL2rygpo
 F9+nGdHFnEl7NIASj/6128VA==
X-Received: by 2002:a05:600c:4689:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-48069c98051mr92622895e9.28.1769696752765; 
 Thu, 29 Jan 2026 06:25:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5d55d3asm3669015e9.6.2026.01.29.06.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 06:25:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC5545F878;
 Thu, 29 Jan 2026 14:25:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 1/6] target/arm: Account for SME in
 aarch64_sve_narrow_vq() assertion
In-Reply-To: <20260129113455.1283266-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 29 Jan 2026 11:34:50 +0000")
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 29 Jan 2026 14:25:50 +0000
Message-ID: <87tsw48pht.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> In aarch64_sve_narrow_vq() we assert that the new VQ is within
> the maximum supported range for the CPU. We forgot to update
> this to account for SME, which might have a different maximum.
>
> Update the assert to permit any VQ which is valid for either
> SVE or SME.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

