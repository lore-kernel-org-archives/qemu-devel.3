Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788F3C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoaS-0005F8-ES; Thu, 10 Jul 2025 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZoVy-0001UV-6F
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:28:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZoVs-00024G-7V
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:28:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-454b1d0a115so2714145e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752143302; x=1752748102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jX/a0JUujtIuYmPCHdgHGffMRyymfSnECvYLYAAbLGY=;
 b=IQawixhqpbuO76cDm0iPuo5cg8PLRYzt4YFRveCh+unyxwaOzJgThkdymNovvw7YH0
 qlwiYOaNcK4mvISfk8xy0SruySbjrzmrzOospq9G9FpUB4TxwAVVspujlGngNZfp98sP
 ZYDsjnbUBdAXfV2vjO43RFws6EmV1XDj/SfRqbjmAo5+SptTy/jpijzuyYhdk86evAAA
 ZpAM7iGHMG9fzIjynuFPD5wH+M6iX9GUI/R5YKHxJgAzqDazdZOwV8jh6tZueROUOhp4
 gHjp/d/OouwnjzVGeti5/DBIx6IzeLHhQdHD5jWtEYCfQ77IEQX6DDsrRCAjxEZF+Y91
 ykEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752143302; x=1752748102;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jX/a0JUujtIuYmPCHdgHGffMRyymfSnECvYLYAAbLGY=;
 b=sZYZVJZAO3xA0s/uwJ4/zG/YebsvUJUHCkJY0toSeHEzwJbqjb6YUUHcer9EXugZIZ
 URpGuCLs/b0k3CdeBz4vE58eApgW/GTSOTUBpt9EzudoS//5+C/SouUSjA/gRjCy/e7/
 PM4C+3TbDOcK7awuAiIF5qaXHXiKidDlR1k7X0USvQ5DEWnWjXU1o5wjpw/LnSjgu36o
 nXTbWE+QmVd5MK1Mgz/didckRo+HBVXUuvysutgG/RsYMB93avPmilO+vmsGNwatI5z6
 tczMaDdBEO3M35K5poh5M+o0iwcQCH7HI+FqH//59G6i5hpixgtxd2yeWNgoXvL6KtrG
 QIVQ==
X-Gm-Message-State: AOJu0Yy/GV/fNeLXzBkkrDWYJfD42dLfOrM7+EKMhMg5Mb+zcaak4ZrB
 xNs68qKx6Es34oFcrgOc+tuom5y6+YCDTjPL+ZXvIRr2Cwa2WNUlXo+2Mq6dAfOhreg=
X-Gm-Gg: ASbGncsVizVINYpUUfgoJ7A8zV4IpN5fUN8UzWpGYlzc50cQoq7fIOy6tk5QxSMh0d2
 cmm1QHZ+ODTIJaNey4bqeWDm108rBfnirgHZgEfphc2YmfCXPnbzeYmeBSJFr7HecVTKg/XYxHY
 oSwcF33LE75QQiLP839YVO/Qq5S/fWJLM8izHGTjzvE5SxGJb090JdPcUjYu6yVNlVJeHCH3SpR
 xQ/hNutDxcTKjpWyHPWIYtyqBSYgE+zkV5emU0rEj58WHXaKOZBQ9HkPI6BPbNrMJV094Q9RvQk
 EMB/EPR6JwKa20kwdXRVSH1HVdlQqkZbpjwcz3/yqSxO1J9kDZ611y0+KLmsoCRIfZBsBa5qDw=
 =
X-Google-Smtp-Source: AGHT+IE5LWHCupJg2RmXOukOIggHZMNPaG1vungwxinncWEKLIgrY9jmsfj2MBg4xt/uF3ailpUffg==
X-Received: by 2002:a05:600c:8b0a:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-454dd2925f0mr22028385e9.16.1752143301709; 
 Thu, 10 Jul 2025 03:28:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm1505017f8f.36.2025.07.10.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:28:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F21C15F812;
 Thu, 10 Jul 2025 11:28:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] docs: use :kbd: role in sphinx docs
In-Reply-To: <20250709-docs_rst_improvements-v2-1-cb5096ad0022@linaro.org>
 (Manos Pitsidianakis's message of "Wed, 09 Jul 2025 17:32:59 +0300")
References: <20250709-docs_rst_improvements-v2-1-cb5096ad0022@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 10 Jul 2025 11:28:19 +0100
Message-ID: <877c0gtk58.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Sphinx supports the :kbd: role for notating keyboard input. They get
> formatted as <kbd> HTML elements in the readthedocs theme we currently
> use for Sphinx.
>
> Besides the better visual formatting, it also helps with accessibility
> as screen readers can announce the semantics of the <kbd> element to the
> user.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Queued to docs/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

