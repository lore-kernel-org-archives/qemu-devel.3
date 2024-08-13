Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4168C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdsnh-0001s5-3U; Tue, 13 Aug 2024 10:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdsnf-0001rK-Os
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:47:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdsne-00082m-5o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:47:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-429d2d7be1eso10904425e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723560420; x=1724165220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0px/orlrIMHhXMfC2ZB8HC11Bwmb5ktsGPUmj5EFAIk=;
 b=s9rcT5YqIpNzUQP+DY12MKt/eMkFu1A1zJLN7lXEueAoZ+yF3ndQwkTJIzQQY3MKQp
 sHp4E91Tgv2kYWXydm6bT5I5SwjbXivyduJKnaM9gk8IhpO+HmMg8adRAly9jqgVouC0
 21cKNf+HPspTwhytPXrbLV4gi581txXeyzRagB9qGldj0gtHST1oeinIWYUFTKLfhfDN
 xPsktDOo/zB4K2qCbXNgLO/WeO57mSgYK/nGIVV9yAhHQhzxyfQ3lFuEhTzH81ZcPhLP
 MI3Arp/E6kGxo7NPazi0ZjSZ1rq2AEWEwItlCUz2TOdXsm40zOyp0zjnkC8AJbpOA6f9
 spbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723560420; x=1724165220;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0px/orlrIMHhXMfC2ZB8HC11Bwmb5ktsGPUmj5EFAIk=;
 b=kf4PWqexcs8UWgsxJ0gLwWtQU1/tWG4uCtzCSkAW3G7Vi1hn2tmNBGAQG0f7gsuTLp
 jseMc/beSM/UHoCCH7/kmFoktiNkokhvs1FPYho/CJtoLYeeZvKbGlt15kyfhjMG8LNa
 Z+K2eOItYeqcTxmjMp19/BH6KSqE0uSR+FmifUO7SPJazdCxjiqNdc2ltECsHc5vufav
 KyUh1Rs1tsC/e9ljJaFBGaDZjGKNKpN9FTfYLWBt02U9swglMkxmKFtcWoHDW4uyk5yC
 FPrWE8VmQBiICMGEGGelrj8abWkVKWSLHPW9D0GpwMC8yDvQBnXb483kL8HmUi6dPMXZ
 bCnQ==
X-Gm-Message-State: AOJu0YyjI6A+adRB5zopfcbKYxwiXWmGN+e6rdv3wLKBC+ot+kDrAZ0p
 QXHiYnS3nIJhBmMP5aKrZ+YhoKjYJUI3XzwOEwE5wi3ejpB66g3y9Pqo5KlxAtM=
X-Google-Smtp-Source: AGHT+IFRQXPpkpgxsM/kGLA9WjNo+CLMPaOmB5ZdqXViLjYrb8AjTLiMqhRN8ayOzOb0AyltabRnvQ==
X-Received: by 2002:a05:600c:1c9b:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-429d62fdf96mr23957795e9.15.1723560419772; 
 Tue, 13 Aug 2024 07:46:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c775c509sm144114575e9.44.2024.08.13.07.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 07:46:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 749645F7A3;
 Tue, 13 Aug 2024 15:46:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] docs/devel: update tcg-plugins page
In-Reply-To: <20240812231945.169310-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 12 Aug 2024 16:19:45 -0700")
References: <20240812231945.169310-1-pierrick.bouvier@linaro.org>
Date: Tue, 13 Aug 2024 15:46:58 +0100
Message-ID: <87bk1wa3a5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> Reflect recent changes on API (inline ops) and new plugins.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to maintainer/for-9.1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

