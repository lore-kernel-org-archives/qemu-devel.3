Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B027CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 10:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxNj5-0001Ih-I7; Sat, 13 Sep 2025 06:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uxNiu-0001Hd-6l
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 06:43:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uxNiq-0007Bw-Vp
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 06:43:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso1172570f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757760191; x=1758364991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roOkeYsJSJo4xShnJ5Df5hNGC4JiwdyRZWQP138uK2I=;
 b=oPBE33daqjONFTYZhJLiIoBIANdDDTFpwvLu3vjRN8qUSntcpr/y4wAAaMy9I06L0v
 KunkRcEmJJtq92WlIUUJJtiKZS3AEnw04bqUeYjh1PonPSJGkrDB8QowNBDxrnfvp2vC
 WfkeYjlo3XUEVJnPYfwvSV1DzANnc48/dwKMS+oYy0CUhLWMTedr0oPoARU/zrH3vxBk
 iphAgJwttBVcE9th4vzDC2mtHDZ9TLA9vGP14mr4BtvD0Mq8Uk9NbSu9J2AZa/qvJSYa
 JFlW57gXaNRqtRkCHvrPSGJ0oFJMh/h3oszunqoMB3uJK3Xyg3IylujhF6NemxcBLBaf
 nB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757760191; x=1758364991;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=roOkeYsJSJo4xShnJ5Df5hNGC4JiwdyRZWQP138uK2I=;
 b=rKRVCPfeZW0mwcu8uIt6lWVAHv94dbEQXfSb4b1aofkNL9M6hBDERHmOaU6q8tNoGP
 MC9dbRvAoGTkzhm69S2Mss1XAzV3trU90ibGr6vT9xOr+hzN8wa2LmkOYNwSi0pMo9rL
 pLLcHJf9yv8lL8X5BiCL8VaUggYe3IM1U1zchQxJrEPfSLrMVdMijRUNivZCKANR7x/7
 L0M/V7iH4lUFK9Bao+20ZnATMyQCVu5ndzwNmB6GkxfD2h8+E3S0smF6TwbPUcSt9jcO
 AMFD6UnhckQml4YYV+jpEmB6Zi+e1Xp17s0LAItqyNEccr0o7A5z3as6Xt8/q0TxIkoA
 +vag==
X-Gm-Message-State: AOJu0Yx6QGiLGA3I3Nzd953Brz2jGOQxrOwf5ujFyC16FMAfIrUfLpEb
 dxSyBaSuH0l7IorSZFL228JbhXtt6fVPwgAlkq4e4eewGyntynGHoc6KYqywhpSY+a1flvorKCh
 /unq/SH4=
X-Gm-Gg: ASbGnctOqAqf4rpTdsMDW+dw0XHw8XJJapf9wQ14QQNGNWEK0lGMETzYAuujHD8xkGE
 iRcjOh/g20Kj7IsWjTtOjmmMCIIc5Bxg9VjUcDr7xpOJraxfEr8z3NiZJz/88Hiwf63zJ03/t0L
 3tvYE62lTPw6MeEuyMXMxCpHk2VFIulvyE2gHeyd6yioPIFjAG1UkM2875mGywIGqF+utKnfoQX
 Edd52AyUpsUZxcbAoklz4I5KCb+ULhn5jB7iC2RXEzbsLdOOAq/4Rhe+9D3/bM8JxLL3W0ZUci8
 kOTVaKmK8yu7Wa0dPm6jsu7eNl+vDpPQJM7tmrb7Q6e8PQX2Ej/AODZVwrUFA/Pd0SS08gIAClX
 D+8eSNoIWQTYYnq1SRSslyudNf7y6mLe91w==
X-Google-Smtp-Source: AGHT+IEx+ONiAdfieAwPpzl8/JhEUd1jFzsYRHVd353MkBayRTBBYAzOqAeHZGrMaK6BUbbQtK2eLQ==
X-Received: by 2002:a05:6000:240b:b0:3e7:6457:ca85 with SMTP id
 ffacd0b85a97d-3e765781280mr6510319f8f.5.1757760191026; 
 Sat, 13 Sep 2025 03:43:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f28c193f9sm12327615e9.2.2025.09.13.03.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 03:43:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8EA4A5F7F7;
 Sat, 13 Sep 2025 11:43:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] ui/gtk: Fix callback function signature
In-Reply-To: <20250913-fix-signature-v1-1-974d16871432@gmail.com> (Filip
 Hejsek's message of "Sat, 13 Sep 2025 00:58:35 +0200")
References: <20250913-fix-signature-v1-1-974d16871432@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Sat, 13 Sep 2025 11:43:09 +0100
Message-ID: <87plbu7hvm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Filip Hejsek <filip.hejsek@gmail.com> writes:

> The correct type for opaque pointer is gpointer,
> not gpointer * (which is a pointer to a pointer).
>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

