Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D4FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTvu-0003bf-Ek; Wed, 08 Jul 2026 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTvq-0003bG-8G
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:11:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTvo-0005At-Jd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:11:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c00f74baso5602555e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783523483; x=1784128283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xA6et+nhgTvwDEnRxOQTIDEVAIAKYeG11QDQANwIiew=;
 b=ixGmrwYI5bXRCb47gqXzV2zz74iZ5PbdEOzT6BezFifTcK/40BUkYh2EnDmj7mHRyB
 Z9/9jnQgaCaOin1GAqEFGfIc3/PvnM7+AG+ChIqG+g6s1awW8en40JZ59YBGoriBZnAc
 Ey2ik33yFGmueaFag2v+9jtn5BK1aP0WAd/5ai8SJqEd5uQFMN3cDdYIWqBN/6o2yWk4
 Zpu+asM4YxUvNLy5/PWLwKbZJuw23l5i9SaqUHilLCmnaNyALB8ev5s1aVhYGqui0cqN
 EM93vwaSjFXrJfa+0jDUpRCj0nOUAmtV3YJlM4ajbNhahYMoZCaYW4BKs1P8gY33tgt2
 6Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523483; x=1784128283;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xA6et+nhgTvwDEnRxOQTIDEVAIAKYeG11QDQANwIiew=;
 b=ZQX+8VcfZsRInUp5yrED08ZaAo1h3hpWTJp4+0swBvTraqRC+H3o5LgLp4pHHIB/uK
 PvCJu6qEvdkB66NZ+gxlaZndnlxZbuhac9WCBvmxDD60GopN+l86lokRqZeIR0JPSD5R
 DvzY8b+dPgoa5E+mQDoQvdiq4gkemO5G4yFA2TG17jNUrockY1cTzrE4QTLFRGYQdFDg
 dsq07MmwZihKa68Yri6HwbJxIcgfgk/q24CiARaiNMnr7kXmx1mdjbBrRuyf8/YJcpEL
 5Hc5etK0deuDWFheO6MoLNsXh5t/oqCEyZLQJvGpdyeen1KcS9PozVu5SnqWpBIzNMvc
 w7BQ==
X-Gm-Message-State: AOJu0Yxw0BroafvWLR9rr9FRLCb3BxxT+ysRlLglHg7RiZeQbwJLMLPL
 qZNsBcSUzwGqYEVKlSLNTIoattbR4NRnORvlbgQFos0+AoGePlcz5btnfv7Lw0lwY00=
X-Gm-Gg: AfdE7clon6+7bon3aBWeBdxPYOyapIhwyG14c5AoFD24kgywsiwyeITm0Yu6t2zG3+s
 ywg1jHU0KYUVEiM6oxHkoqcijlpspjsaq8aK5jmvHziXElV0+8PKqQdiKW8DxUvgLrmiU4zRh5G
 NvI2x2FJdRYzZpfsz74dOhSPFMjr6EwQq7+XmshqcccRKNMvwMOE3cAAg0gNifRLG6fZs5yWEQg
 UUS6IdoItCahiG+vQVVdTXFq5sZkJuN0CjCK3uwqKV9N9T/2fRcMoAOxc15gjihsNsOax2XPp8j
 tIyncthsSvRf/q6ZyKUeLbEc58RjFKN/jUuelNGMK89hb+cWt7ZlsntxiTBdIOKU1Y/36JdD6/a
 KZbqh5eT5EFlJE48L+F38Vz/r3EAhQTRU7yu97eEOJ7EzFWl6EXNA7c3SyDdkNqNXbTGNfQEdA+
 O56hpoALgzzVO4
X-Received: by 2002:a05:600c:3e07:b0:493:df47:8d9f with SMTP id
 5b1f17b1804b1-493e689b2e3mr32627615e9.10.1783523483184; 
 Wed, 08 Jul 2026 08:11:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5bc78sm171152895e9.14.2026.07.08.08.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:11:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4CE645F8F3;
 Wed, 08 Jul 2026 16:11:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,  Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] mailmap: add email mapping for Alexander Mikhalitsyn
In-Reply-To: <20260708134744.169452-1-alexander@mihalicyn.com> (Alexander
 Mikhalitsyn's message of "Wed, 8 Jul 2026 15:47:44 +0200")
References: <20260708134744.169452-1-alexander@mihalicyn.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 08 Jul 2026 16:11:21 +0100
Message-ID: <87ik6ptt2e.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:

> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> I use my company's email to sign-off patches, but send them from my
> personal email cause it's Gmail hosted and works much better than Outlook.
>
> It causes some misunderstanding and inconvenience for maintainers sometim=
es [1].
> So I would like to add this email mapping to clear out all possible confu=
sion here.
>
> Link: https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvM=
o2-jr2XBTby4zqf6CTA@mail.gmail.com/ [1]
> Signed-off-by: Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@futurfusion.io>

Queued to gitdm/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

