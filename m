Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A25C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txOtg-0005by-Jk; Wed, 26 Mar 2025 07:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txOte-0005bL-Nv
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:26:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txOtc-0006FT-5N
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:26:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso42213015e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742988366; x=1743593166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9s10LsKmHUKQpYc2s69GOFKwovPe1QZoil3Spxlj2OE=;
 b=sAr6KI6ESj/pqJuVZlpn56+TnXYid5jUtNlZj3w9KPvi1dlcphh3SnJIyGnYCIS4ps
 YZOJ883gtFfanWIkOio5wHUud6r2WZf1PYtQYQVI/5aunvf0pwPEQmySy/k6K1XrtLLD
 eJPsxJUUHn2X/eqxcM5iD12hwrAnUzBI2gSEv1kNbi2Pol+V6VcB6D+eihYki7WxMZfs
 HWqJkRIRvqMysvUswieFC5KOZPPUCCNRGwGH6HQh6BNc0LsPRcdo5bjtN+24dy/hC3Is
 cM9NlSTalgbfp6uunsZE6Oi3Txmsc4wUTDGZFs1HAFwWWBrH4plIRHlNwuUz5HTq79ir
 oUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988366; x=1743593166;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9s10LsKmHUKQpYc2s69GOFKwovPe1QZoil3Spxlj2OE=;
 b=I4Ck93hTjbba7CUpyjJ/ZtTh/jEVKDTABRspSguh/afKm3A0ujFQik9zPt8kzWFK9J
 d/iIyLimWZMONHMBHE/Dzajq3n4AGinxy5SypytmDBW7ML5FPgn/sBECsHNSfje+DS4y
 zObRaXL2aKBDfY7XvMdr/tKgxBPj4RC1s2Z0mEAUqlDC0pUdhFp4cklE8OYpFrHzdzJ4
 qoQPEbA3sRd5A9tss3nH5Wy7cTx2G2Asevfq2NazL+wAxm6AA5Q2hXr9wh62NOSpOaiJ
 zVXmrq40mZZcvEqAlTCnJgT+BH7bVfifgGdolx8LJciIfiDYAwmbgySOzLawFqMx1WU6
 8fCQ==
X-Gm-Message-State: AOJu0YwZJx8k1Lxr35Kv8zhrBOmTb1e1U65rrutQvrdtjw3DdGvHQjQ9
 6Ofeqj82K5tYmDu3DjrH2k02bnF7i88WXwwWJFdBtE/xgceHp9TmGuiWdWssHKQ=
X-Gm-Gg: ASbGncvLVyuE1p5K+VLiDJi9H8+8VoKw4zLaQvQvRvEDIa/AmodKstJSFimBXzrJMSS
 Mp06Ik4PZB1ofWHJXiXOJ7Kkg9ZBN5HBH4NEu53QqcmRQ/mp6Kgirv/4w3V1/L3rSAngt+A593+
 b6Swz9/g7DAloTMtyBpXgji9u99nhpa/DbMQZlWpmPnag1x1+249a0Aj1irIYLld83M0z5zQ3/h
 nKH4/c9zUK6d8NcnCMagf821UF7+ZxwvVLf2QIHniHaQ4KhHwPWmcUm10RkgpDOPgzZeJlzk/Gp
 UeXgNk5xV+ENJcqkoplHPiLfDe+vVx7rSAzac1N9x/ptji0=
X-Google-Smtp-Source: AGHT+IF1HkiNyKHRCE2C5iO6dL2QPperjNyh8RCGDxOakKGmHgqHtUiHVI+/kMKCry6vi2jXJototw==
X-Received: by 2002:a05:600c:4d1f:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-43d5100ba49mr147485605e9.17.1742988365708; 
 Wed, 26 Mar 2025 04:26:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6445sm16614727f8f.71.2025.03.26.04.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 04:26:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 67E665F90B;
 Wed, 26 Mar 2025 11:26:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Anton Johansson <anjo@rev.ng>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH-for-10.1] target/i386/gdbstub: Replace ldtul_p() -> ldq_p()
In-Reply-To: <20250325154528.93845-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 25 Mar 2025 16:45:28
 +0100")
References: <20250325154528.93845-1-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 26 Mar 2025 11:26:04 +0000
Message-ID: <87zfh8119v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> When TARGET_LONG_BITS =3D=3D 64, ldtul_p() expand to ldq_p().
> Directly use the expanded form for clarity.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to gdbsub/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

