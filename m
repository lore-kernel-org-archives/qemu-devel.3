Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED23FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhbR-0001Sb-MC; Thu, 29 Feb 2024 09:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhbL-0001P3-U4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:41:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhbK-00017u-Ab
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:41:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412bf4030daso3917065e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709217693; x=1709822493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44X07IMVk8k3cE4MZq7AslSB+N5aY2V9DGjREiNTHiY=;
 b=vsBPbzLVrP54xgXnW1cDrJrFVpFTGvDlugstfKwlkS3buy59nT8q+dgS42Dm/eCKDi
 oDkc2SookjkpLKDq0uGU2L96KQHYrlWJv++8FsMd5VKjvsNyQe7JQrO1a4XOe7veNd03
 ZZTD72eF8u1BMy59VqLNRqQpq4oVKg9LAGhcIqb93hPEK/0RUAycISwfYPotmMi9AOU9
 8xINvuSQ1LsSlEt2W4MMeZov3h6vbq25YuOSzlqQksgOUVhA9H1OOyBDvVRizA2bIaNY
 DlXA8sZwTxLZkpRX7f5vgiLris/6OVsmX3eZ1A+XyZk5ChPlU4RKb5uE8RwqbSvVVukQ
 RoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709217693; x=1709822493;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=44X07IMVk8k3cE4MZq7AslSB+N5aY2V9DGjREiNTHiY=;
 b=PrWZR7O1y0lXWXFqIUYF6tb+4y8RL4lNmwse8+STwyK4I9aP8l0Q8cz+290Inf/cxr
 PEFqQkt4GfitUdaIf3LkVnJBKyuKoSJ7IFjjGW4j9Fcq1fE3OnTRCxtd+lDfeqcdBm2Q
 ARI5UqKo32mLCQUl/VpDEBbh8LkmSXnLyO/YChSuyYtwJxxbUzPv514pWSmGLvzdSIty
 eo0xxfmYZ7gP63dfmHKvHhEzFLmITk/aGB3zsSPwRLZxu1b/yEjR/T2LvG781qu8xesb
 h3R13S7FStjv1uwau4ny/WG7QurI9K0KDBNA7lFrT8GM+nq7oOziReoAlBzfcGuJZ1AT
 +PLQ==
X-Gm-Message-State: AOJu0YzkCm1+/nUtI/OtM9O8YDHandRvGduDx5A4vGoOQ7D6gsUM8m6T
 r6Hgt+zUYjZosvCFIGYuYuUepkPuprF6VozVGOcapVIaqaA9KJTXolKdKpQi9hc=
X-Google-Smtp-Source: AGHT+IGokmdkeHiSZOzaenb1+49v7WDOtmHKDBhYR/RO4dHqYpHs/++hEK0XYx9//G2koZpFzUcY0g==
X-Received: by 2002:a05:600c:19d3:b0:411:a751:322b with SMTP id
 u19-20020a05600c19d300b00411a751322bmr2078217wmq.18.1709217692836; 
 Thu, 29 Feb 2024 06:41:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c45d000b00412b67388f0sm4532259wmo.6.2024.02.29.06.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:41:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B2425F796;
 Thu, 29 Feb 2024 14:41:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 11/12] plugins: remove non per_vcpu inline operation
 from API
In-Reply-To: <20240226091446.479436-12-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 26 Feb 2024 13:14:43 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-12-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 14:41:32 +0000
Message-ID: <871q8v9vtv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Now we have a thread-safe equivalent of inline operation, and that all
> plugins were changed to use it, there is no point to keep the old API.
>
> In more, it will help when we implement more functionality (conditional
> callbacks), as we can assume that we operate on a scoreboard.
>
> API version bump was already done as part of this series.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

