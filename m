Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8A4E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqxi-00061R-EJ; Thu, 09 Jan 2025 06:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVqxL-0005qP-J2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:44:08 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVqxK-0000YU-2r
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:44:07 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so126633866b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736423044; x=1737027844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lNbzwETuyPwD2fngNnbT5rPVUVrEFkr0DGFZO+hvjU=;
 b=TbmtGHtQCXGmRXMqtalwYLMzYLo0fd83yDH3C43Uwk6sSwdTPD/YAJll37Zew758Aa
 MUGxG66mY8a92zn3a2YXr1AzaLtZVuvzIAwhJqnKCdvOKa2czx9p7937IV/GoEwX/wgA
 llu2MXDn+2Kp+auuWPcJqCnEl0AthJZzT4DklVnMTziYcg5+a9CU9epCkuQfJJiVHJV3
 HlrsUWp5Gw26CcjAXkK3En8U42sSkDvR0HAFT1fhik5Y0K+g+5BCHQFgcZoGwmdHR5c7
 2dTlHHyU9FxCTRnXuSuMzSWSG4Bivf4wCSVaKQdl9I7P7dj0ERjEkgIobCut29mEU5mS
 ijzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736423044; x=1737027844;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9lNbzwETuyPwD2fngNnbT5rPVUVrEFkr0DGFZO+hvjU=;
 b=dWfmAx5O7OPfAgj9LyKxlLWWk60XkvU85Fr0eqKEXaAiioKhF+9gYArL3Jldmy8baH
 L28WSNemNtEYtTUgt8oAolcTCExFbJZJPfje/7CuneEP2i7hIoJ4uoDYkcufndsz5Sa0
 6zU2etgtvQK0HeFkoegEizOxWMlsJ7T9GEOHSH7k4Bgj/J5OoLjZ/GKOKp/p2kroR59a
 oFhnuD8QzHRAvTBM75sUTK5jlU2sRKdSwsh9SB0yy/+9/cR3owl8UWVpAG/0gc84TF4J
 42y2SUelbVOb3TzgSgUVp+zlPyCm3jgUNzpRgMSazxAnta56zn3MvAz8lwKU3SOku7yV
 3w6g==
X-Gm-Message-State: AOJu0YytxJ3HwMYVIhVM1IbwymCSS8/wQkodZAIFyQIfqhW7ggv/fopJ
 +hyKQep+9zM1RxRnJ4tnt4v/dSgOVVM5JvLU8YKp3QYJY20MMZULOq+Rt7MMdNQ=
X-Gm-Gg: ASbGncs+IYF5MntSi6V/PuIpMQEt/stvJo40DUGVLrBN5bUJbKonmf4kbeIoS3mjlQm
 WKOC225M342cpcX5iz93/NY2nNexcapk9OHKz8m/p82GK6XZzgAMUq8/CAjXzfWRfTtdmeUGICg
 K6CGiJSvl8PwN3KTnk9o4MsqAdjuNwp7lqy0lWTOM8ugoA7g0g1u4n/Xjod7975/BRdGkQBjc/A
 7R9xlH64DBGppHh2ezLXZUQQJb3nV3R33aepPCEuF7DyurZqd04iE0=
X-Google-Smtp-Source: AGHT+IGwiFvzodt2dPieuhZRmuiAbrvH7xjtkBb1UYVm1eR/1bSD2UMp4Eh3T7q3cVS0n+obxmcnPw==
X-Received: by 2002:a17:907:3e02:b0:aab:da37:95c3 with SMTP id
 a640c23a62f3a-ab2abc6f18amr584753766b.45.1736423043947; 
 Thu, 09 Jan 2025 03:44:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95aedf6sm63707366b.138.2025.01.09.03.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 03:44:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB6525F87E;
 Thu,  9 Jan 2025 11:44:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 philmd@linaro.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 00/11] Fix 32-bit build for plugins
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 17 Dec 2024 14:42:55 -0800")
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 11:44:01 +0000
Message-ID: <871pxc9pq6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Since 9.2.0 release, we are building contrib plugins using the QEMU build=
 system
> (before, it was external makefiles). When building for 32-bit host platfo=
rm,
> some warnings are triggered and build fail.
>
> Thus, at the time, the decision was to not fix those plugins, and
> disable by default plugins for 32-bit host platforms (see cf2a78cb).

Queued to plugins/next, thanks.

Although I think people trying to use plugins on 32 bit platforms are
still in for a bad time.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

