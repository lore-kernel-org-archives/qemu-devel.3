Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02ACC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 19:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRFUL-0008LO-3r; Mon, 16 Jun 2025 15:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRFUI-0008Kw-Sp
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 15:27:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRFUG-0006M8-E9
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 15:27:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4530921461aso41947435e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750102038; x=1750706838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5sNYy8GIXJHqYbgx3GFhoCSmj3LgV1O8QDMmhPO6sA=;
 b=EgFjc5mIRFH1f5gCvMDAlkY6zNakpr4gyA7S0v7OKOsg71eC9QMBI5yt9gs2YTA8ab
 EYi/GFbaQRWrt0aT+UbGzodck0vd/oJ7lPMs8sD7nxseNTQpxZyI/JosccUlhskjId3y
 XrP00JWkauBojNIaRjI0hzo6QLyaiQPAAK2WmH+mwgXzBA2LILVHH10gwvDj8XjbXh8X
 DSulKqdMAKlOQf8TTpD7zBS3DVNRpZN/5jjh0TyJsQ2bYYLQxJJynq0Pqm/Gay4Oalbb
 L8ZBmJg/g1asXC8lad1tAW4l9WOj7HEYLdXHnSU6Betiglk8nWuJ0p+U0z90t68fwToB
 e9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750102038; x=1750706838;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5sNYy8GIXJHqYbgx3GFhoCSmj3LgV1O8QDMmhPO6sA=;
 b=I+TRjrJBfDfqd9l22vibn4wj9vvYZ4z2GU0bSyy68FhBRarfW8kYSuVSNa5xxONTPS
 +81NnABIwlrZpObS5gl/wcdVcpMW+MywIeHTEAF21pTezE5DgoM40kVlTT1AWVAgMjOJ
 by51sd7AdThe4jHZ8/M8naenZIZOUdmC4DPdBr5xcLX6xVjby1r/DkxicN51I3iRrM7G
 Sg35rpo/00JQHJLnHnS1kGqXvLZ41EecnN0lPK2HM/o9ZEuy70GAxCU1OlsBDv6t1v2U
 U5TOKe/T/PxPRMoH2eC+wXcMCwEJrRZfrzU3tClKlmXP85mOiD2C3yQW25zuClm8VrFR
 iAQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCxS5510zy10W+zXhHePQzf6gGrwwTyW7Yi4mi4cFG770a7IBU3YYeQQ04JdXc4/VbO5cJm0zDhbMp@nongnu.org
X-Gm-Message-State: AOJu0YxTTXXuQyYfDjj6nafp+hxhLlmVjCDDgE+Xgmb5MM5vZx58fZFM
 7F6MlTpLqV931IDChEESl5yEUtA3fZIWBDmGG457hfnk0mfujfGVxXAhzQ3x2EDhjnX4RCfZVm5
 9ZmZdztU=
X-Gm-Gg: ASbGncsKPG2NX1dDe+s6mTykf/iZcfCW9tYsFOGnGkyj6o8mw5hrbTc91rqtTPgzDxz
 DHf7RcSH+bPzbH7TSDpnHtQLTbTRDud4A7o+XPqpvZ4CNyUVS4GNfMFqJNaN52PCShVpQrgFNFP
 +WTqvO9sT0cvdlmi01z/iP98mXhmV6Ppz63maYKibOaWIctvVaKkvW0Wd4+4GJBH6zUeHzMb6jA
 f29BrftZY0lm0ESR85Kmp51whiDzr3kUJ/SrW+PN72H/kUdMcUeYAc27eCc1mLLwAjyrkvCu0bg
 bgCG+sWiXWAT2ArYUhcjP4l02PODmpYlxieurHTCxaPZ2ZFIxk9LFjwD/yTZHwg=
X-Google-Smtp-Source: AGHT+IGfP2Mawrb/HvtQhEhpjgMqONIUvyz7jOnqtfTTvNA7/Dj1T3FY71ulkmG0Dr4sWEWj9EuFOg==
X-Received: by 2002:a05:600c:4e54:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-4533caa21d9mr84398215e9.22.1750102038113; 
 Mon, 16 Jun 2025 12:27:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224956sm154816575e9.4.2025.06.16.12.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 12:27:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBBBA5F7D7;
 Mon, 16 Jun 2025 20:27:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Solomon Tan <root@wjsota.com>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Make RETA[AB] UNDEF when pauth is not
 implemented
In-Reply-To: <20250616171549.59190-1-root@wjsota.com> (Solomon Tan's message
 of "Tue, 17 Jun 2025 01:15:46 +0800")
References: <20250616171549.59190-1-root@wjsota.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 16 Jun 2025 20:27:16 +0100
Message-ID: <871prjwkq3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Solomon Tan <root@wjsota.com> writes:

> According to the Arm A-profile A64 Instruction Set Architecture,
> RETA[AB] should be decoded as UNDEF if the pauth feature is not
> implemented.
>
> Fixes: 0ebbe9021254f ("target/arm: Convert BRA[AB]Z, BLR[AB]Z, RETA[AB] t=
o decodetree")
> Signed-off-by: Solomon Tan <root@wjsota.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

