Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F5DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFR-0001mT-Ex; Thu, 19 Dec 2024 11:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tOIgr-0005wg-Gg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:43:53 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tOIgp-0005AZ-Se
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:43:53 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso1287970a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734623030; x=1735227830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qiqib2pInmBFxhkNjD23YIedxQ2hBeSSKw4PWkkq1U=;
 b=SnQ0LGPdqpt6gH9xeMtsS+6NE8sSNDj1E2cvSgMTbiz+PN34gJxW00oOVvH9vZ8VeL
 Xz/kgZ0z2ReY1DkvJ3esjtfZ7xAeop0yZy98B7wywW/PB+y7qPV0Mp8CdF6mo8MeefbD
 NAaFfeNJfDulEazz4OIbw83v98rCTLY9WBONXYnV6MRxvXfwbRf481aGFjxAqfsgmL65
 wI4NsUoiP9R2b5AlLW0fcUoX1ngCN8+mMzheH5DPoHdt/VRTJ4ZM29huF5jH45Vednnf
 qfhc46DSrn4LZOIBFZt+CB9OKCdb31IaTDAJ9mPexEGMzhdc+sbfM5BysMinoPNQleZO
 Zl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623030; x=1735227830;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1qiqib2pInmBFxhkNjD23YIedxQ2hBeSSKw4PWkkq1U=;
 b=PzwCFiK0CYdWCoNhGv4eoRz1MKRI4Cv/49cfTj4oB6KCz3OTaU7l60ZccnYMI5iR1u
 wqBmZIDDBZphGj5ICmox3l4eRslCPrGmdW9BBsKVAsfE1LqvXzm5ec2yAYko2sxyEZw8
 dpNwfV3XZpLoONN/SfF+OGpCGkZbBTeGoODIvY+dTa+zm7GXWGcehesN4HdIPAN32TRN
 YSsRpvf9bs7Eq8doJWZjpX1oTg5s+ozGE/N0eRxWx83xKh8mJ7Xh9DhYb8gnJkTjmSW+
 qwug1PoboHxsx3qTrxATPegIkGp8oDXONIqeVe1dH+ocZNTbwb6MKslrefFhnXlx8bv4
 2iSw==
X-Gm-Message-State: AOJu0YwDGVOAU3lvb/Wv4zMeEdkg50c71MvDP+wpq4zaC9T/WBfK20xs
 vJhPMKB/hxn7EfSauhSJAP2HROJyKjBUQKe902j8ZjyMeOAiuckFmjoS8yNOu5g=
X-Gm-Gg: ASbGncv28ldbnp6qK+qKQVMiwK+jngHx7+XZdGllaTBBI9EevgiVk9MNBzkQWJ6wFpF
 cjwP56nelJ8owy1YJC6fBFS5GYNySttiQ7E/2g0nVyVEfaLD/0e+ff/Z2xSM7r9RbBQktQp0rCN
 JZvbSSeCG9O2gJprb+7h1nA5WJMwxFgUsKZLqNvySPxMJk28LALBGQ301uXeGNFy/hj0qsQW7Bc
 FRR9x5qJK7mzEWj+qI7YG0nSBXayD73DLtOmEuTdWNS0qwvxty7p/c=
X-Google-Smtp-Source: AGHT+IHm0a72hC7tdVpAmtxZZgxWa3f9CsHi+N22jOuHrNsa1sFByqdlQ9RYoq/6Sckyp0i2pNOrNQ==
X-Received: by 2002:a05:6402:4486:b0:5d4:1c64:b322 with SMTP id
 4fb4d7f45d1cf-5d7ee3bab9emr6202558a12.13.1734623029607; 
 Thu, 19 Dec 2024 07:43:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80675a41esm758400a12.1.2024.12.19.07.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:43:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 453B55F867;
 Thu, 19 Dec 2024 15:43:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,  devel@lists.libvirt.org,  Laurent
 Vivier <laurent@vivier.eu>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH 2/3] docs: Correct release of TCG trace-events removal
In-Reply-To: <20241219150203.55212-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 19 Dec 2024 16:02:02
 +0100")
References: <20241219150203.55212-1-philmd@linaro.org>
 <20241219150203.55212-3-philmd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 19 Dec 2024 15:43:48 +0000
Message-ID: <87plln3cgb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

> TCG trace-events were deprecated before the v6.2 release,
> and removed for v7.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

