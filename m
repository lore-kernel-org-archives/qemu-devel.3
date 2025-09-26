Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BFFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2AI2-0000G1-Mx; Fri, 26 Sep 2025 11:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2AHv-0000BC-H2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:23:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2AHo-0006VD-93
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:23:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so22147215e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758900177; x=1759504977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCaIDOvmlMCmdkKsmc7xs1lEySgRK9lBDSltiGmWm3A=;
 b=omEH7PXSQalKtrI8k1u5TV49qkA9Brrte3EZo13epq1tKd8Abu3TLpEMtfccEH2V33
 SFe2EwIJrlI4Dgld+hIjqXE+Oi49p85oYE0ALD+fefW6mly/9ARdupgZbBL0uyk17k6t
 VrI0SKh34vXfPXt82a+s6DCv40D4UV/jjgD99xsk/yvJSxA5TQxUzPqRWKOuYifr+AH+
 mQdM0dukvN8mPo5QDtBZ+ShzH3mH43k1CQfwwmCpRQHG/wsoHuOtUEH5wpjk4FIIGurY
 lQ2IEQ7LsB7uPifwHw2FOtbKOD487XWDSeRaZp7SWguPdNj0hQGBfOzfc7T/d63n2jKP
 eu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900177; x=1759504977;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCaIDOvmlMCmdkKsmc7xs1lEySgRK9lBDSltiGmWm3A=;
 b=YZQnYND23M92oEb/23tA1dsSAaQ8SAcZwiUUWXrnMbT0o7SrCd7+uIc7LZfkaJ6aGp
 D7D1+HqJKe5pszJ4YkSnNLZ3rSOaxfDWXvv+wtfqnWNMv9Ar8ugheGsl5xR0v/3XFTdy
 8XZamZFC3Wjo1JS2jiGtcT2xxIiZhDlg8hducldnKLo9KKeV7qIKaQfyNLN6pZCKRepU
 4Ob5SDqnVG1d6l9/Wvf8sgdZ1BPwSHvToYYxF8aQbatqIsKAIt1R7yA9BNAgQNxp9l6E
 mKboWfVvE0W7ZyvrrWxWZw9bDcrzeMf+CA/6fY3BUD/KTi99gHsy7WyXLPNyZN3YipTd
 azmw==
X-Gm-Message-State: AOJu0YwXrVnXx/OSTAcxFHhUV5Eq7LVdYXhk7tnVjYPyw+9AbjgzFJia
 6EEfjPcIAUBAE25HxMZPn50muLgF5sQbemv8ZsSPA4BZ2oAp6P1+zXgWZDIJPGi6978=
X-Gm-Gg: ASbGncuiClP/5rWlDpPs0XcRkFc3VeDjiF6EhwCAP4u/2PxcDfwm7yt7GFX0F92W6zw
 eMHCS+vGMf0iR9N5d6qTlnEDuWmJE3kNE4jx7MKQwp2X8TfxeUKsFxcJsIURpQMeu1syMmWbIuZ
 g8rI3fBCIoXOy0/851tvg7elxcCFYUJizmIUEMeDc/O+xiUY4iyY6uqHRnffNRZa0zorpG0K84F
 PyYVuM6S02C5oaFvxTHjtu/1tD3PDSHQbXGUbtMOiWdymAJ5WDCABB6PTD49ZVN64eraVkH9utm
 ig3OGO7xknuddnoKutZLyaYnF6R5sGG8XEBeg8dmat/xLNjC6uXnc8rk1Wp1NUGDC7OiEOcBEjv
 PmF3PV1x5OXeiy1i2q0XkTaY=
X-Google-Smtp-Source: AGHT+IEwO6690xWpUp8eganu8jdYSyS1SMdK/59XsbptKdIVruISq5H+/8nBlBy2UqxEOIc4joWHPg==
X-Received: by 2002:a05:600c:3b98:b0:45c:b6b1:29a7 with SMTP id
 5b1f17b1804b1-46e329c68d9mr110201195e9.16.1758900176802; 
 Fri, 26 Sep 2025 08:22:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e42eee0b6sm10038095e9.10.2025.09.26.08.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:22:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C97925F7C3;
 Fri, 26 Sep 2025 16:22:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Kyle Evans
 <kevans@freebsd.org>,  Yonggang Luo <luoyonggang@gmail.com>,  Li-Wen Hsu
 <lwhsu@freebsd.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Warner Losh <imp@bsdimp.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>,  devel@lists.libvirt.org,
 qemu-rust@nongnu.org,  Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 03/27] scripts/archive-source: speed up downloading
 subprojects
In-Reply-To: <20250924120426.2158655-4-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Wed, 24 Sep 2025 16:04:00 +0400")
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-4-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 26 Sep 2025 16:22:54 +0100
Message-ID: <87ikh5i6gh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Running meson on each subproject is quite slow.
>
> According to Paolo, meson will run download tasks in parallel.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

