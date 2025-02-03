Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A30C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevfG-0002Sh-1q; Mon, 03 Feb 2025 07:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tevfE-0002SQ-3M
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:34:56 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tevfC-0004k4-Jc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:34:55 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso8080717a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738586093; x=1739190893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzhz5l/GvhKS4x619rxmwWi9NvBC9wFxS93MG3dfQdA=;
 b=YdHqeme+i2jhIZt4iu3TOKwenBsE161j41fNmti3x1T1zouaWG0DpxKB0sZnPR0yYz
 nfqPnHlkYAOwmsC8jMTlilC7GeGFwyzpYm07KkLUsOGRAsNfchy0se0qhkAVvAQVsgH9
 03aSEghNFbPkihh0q9pH2jSF5mUmlB94i41jlfPdvHf6+8B0CLzWknSSBeUAKYXOggpt
 8MxCIp5E7T3U+r9lZ584Wq5dgeWuBWGg44bYWln5D0vdJ+UOa2nQqR8gSLZMwGDbrmlW
 XYUJOzPpmQtYHkd1gpwHg67XHky4fEGD7F6OoaYHBs7iw+7+XeS0TTnyO/CwaSeoCSrX
 8Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738586093; x=1739190893;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kzhz5l/GvhKS4x619rxmwWi9NvBC9wFxS93MG3dfQdA=;
 b=EzulIXLfQYK7biScdyiJe01KH/D8hhR6eRzcE3xFM3h5wnc2zmSoujpnX2ZEC8p691
 F8jR96l4zfjrh9HkGlAR0jIs9i0+ttMzJ82sUdZeTTx6mY8bS6bANL29ZfOMiKZ8cW6Z
 vmKOtwFf3cw/C/p+XJkdYk/gcN4AOAqNtb8Q9WbrB3v0uvvB6pVquoGnZsXYlTGOaME6
 w3KrenUqJFC6pryvQonZldrlg2yFYg7WluQJov1uQnLMsBlLvGf17NxjwQacVctW+ogd
 H4pDLrwARDUDp2cVHCm2z92JityCABXIpg6B2WslHyGLH7cAQ3p9SuLERY1DTz75EnMt
 KexA==
X-Gm-Message-State: AOJu0YxDVGGUQdPGA+IPQao/acUcjfleglZoilmDi/e5N/fld1lpU1Ty
 qaul1W82mTn31Fld/eYYnWIoNZ4Qn/JpI7a63JQHJ50+c2IVi/F88RjtVJw4yC2BEmxWzaWOYk3
 1lis=
X-Gm-Gg: ASbGncu5CIj7KUtheLbRJXlnNaa0+XESszW4jeOSga1IsAenbRqECVTjLGNloINoCS6
 jMRE89cUk+75VG/er6JP4gkQD1KAbwvRIGpiqvAfIgAsbJUX9TyMyMXhcqjm377Mj1joquWP7y4
 BY1IrYnNqJHYU9GLt2MYINu9Bj6xBhObB7BnyOsOtaiB1xqU7QqHUCCv4azbolV8w1ZT4YqKfIn
 LzqLuQopc2wzaCIQRbq2R529isUaDki8NC6hbGL2U7g8lh7ue2FrKZAXSG2agNyhHx4lVANAmbT
 J0/ZlSIpRsPkomgr1Q==
X-Google-Smtp-Source: AGHT+IHNWZMPassq9FoIhQsjhC40Nzw2IRehvaI4IhhUCRvuiFcZG7qACGEcWUxZJUtHfirZeWnVZw==
X-Received: by 2002:a05:6402:2706:b0:5d4:1c66:d783 with SMTP id
 4fb4d7f45d1cf-5dc6f3bc813mr20222306a12.0.1738586092573; 
 Mon, 03 Feb 2025 04:34:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723e4ceasm7522628a12.21.2025.02.03.04.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 04:34:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B3B2E5F8BF;
 Mon,  3 Feb 2025 12:34:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 11/14] target/*: Remove TARGET_LONG_BITS from
 cpu-param.h
In-Reply-To: <20250203031821.741477-12-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:18 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-12-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 12:34:50 +0000
Message-ID: <87tt9bcil1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> This is now handled by the configs/targets/*.mak fragment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

