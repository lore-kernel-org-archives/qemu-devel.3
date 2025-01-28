Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6A0C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tco3l-0003LF-H2; Tue, 28 Jan 2025 11:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tco3j-0003Jo-Hi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:03:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tco3h-0001Fa-MB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:03:27 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so59705455e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738080202; x=1738685002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMXscEc1WJ9MTRSQI0SXbF0xZCxvtd8Q/GmNjY8YuGc=;
 b=dlINntjd9GPxIYj7R3eKGTYZXh68oUJz4eFcKMbBHCv1tjfLM5qCg+agF5vlLHOHPY
 QW9d5eaJ4O3DzdFFDrX2uiLTzhN1Nr5Wece+l52lYVjELEQnRLlDp2lPBji4fGRruyB6
 qlLP8w/gcMCk5csEi37dw4BgkqXTYQykF5qiaDuWM0Ry5n6zpmtit6OCP3LdhM3DKo6q
 Ou3MCl20MSauQ76SHuBG6JBN++kwOPOJhAjnUqJtQVTngsTNdVyvTIBSnminhvCPbHQf
 JiDj++xjqUHHVy/esNZsqdT5xRtBdmNzi9urMMrAgdWJ0L0b/c3sNdYBLE2lLU7FAfb2
 7Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738080202; x=1738685002;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMXscEc1WJ9MTRSQI0SXbF0xZCxvtd8Q/GmNjY8YuGc=;
 b=e5nf7HDFfyLmbTvfog6+4VHD7V2tI9PL7lVnwlOjbszl/T0XBoZaBGwWbFzfaTZOc4
 OEaP5Zx83bD32+h8IP6p0RWyiMLpBBxX9cjEh4hkPiYVOWx3X2ZRTGWha19uHwdeuj9u
 Y36lfPb9dDbdWUNoV6mFvDnvrwU6WtOFZJuH5UTtbgVgYd5nJd646pIU+Q3TdUgvIUtr
 sck3AUVpjK0OxjRwNunMjY0h2cKxY/fS596wINNeaH4XkC7Rzb06Bbg873c9X7yS0ItQ
 r5+ktYLI7rxCKPck5XaaQpBKIhkrDc9u9+1I8wpskmS1ayNILH/DvI1MS1oj4IhGodRX
 H8yQ==
X-Gm-Message-State: AOJu0YycpJd1f2fvFTFl11j0VUjtjn//Vr0JInoQWoqeJ0RkxoHYeU+f
 YoHD0m4qIn/v3izMoWjEWpowjYIFDmS6JC3do7wPNjCNosQbHZYfO4NJVG1IJJ8=
X-Gm-Gg: ASbGncvjnluKLnsH4xwHt7zGm0WxSvbjWP4M7OhcHGAp/QVicTCJg0J8ip+NnBaKu1p
 oljojU7N9FWyjCQH9xGRhjXO13MYpQ4gncayIrfn6acjlCbYWvaeM4b02rg6hz+eer5tYMIgJ1T
 OQ6I4Ui84lbF5a3NJg7sJOusAQE4/kY2Q9a9+AP5ZTuu22Tam1X/ZZ1RAk7lx1A3vmtHxhnjdTd
 foQDxkm6JT4OOf/J2idgwp/haUyUqzu5G1U6tUV/HP8ahgCCnR8YFP1OcWxiNmlMvShtExYwZBD
 By3q0+iQP4GJJw==
X-Google-Smtp-Source: AGHT+IFvfk1WOK7CC0pqkkOZGVi2wJCqS+pxXC+qzXL4PUDIhsoEjl/oMTnQLTIFcfboNu7a5dIzWQ==
X-Received: by 2002:a05:600c:4e52:b0:436:e751:e445 with SMTP id
 5b1f17b1804b1-438a079c1e7mr404672515e9.5.1738080202020; 
 Tue, 28 Jan 2025 08:03:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f269sm175989545e9.8.2025.01.28.08.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 08:03:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8937C5F87E;
 Tue, 28 Jan 2025 16:03:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] plugins: fix -Werror=maybe-uninitialized false-positive
In-Reply-To: <20250114104820.2613099-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 14 Jan 2025 14:48:20 +0400")
References: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 28 Jan 2025 16:03:19 +0000
Message-ID: <878qqv2aew.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ../contrib/plugins/cache.c:638:9: error: =E2=80=98l2_cache=E2=80=99 may b=
e used uninitialized [-Werror=3Dmaybe-uninitialized]
>   638 |         append_stats_line(rep, l1_dmem_accesses, l1_dmisses,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Is a false-positive, since cores > 1, so the variable is set in the
> above loop.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

