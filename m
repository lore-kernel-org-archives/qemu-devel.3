Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E6DEE4997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLO1-0000xW-KY; Wed, 11 Sep 2024 07:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1soLNz-0000wI-55
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:19:47 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1soLNu-0008Ki-Ki
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:19:46 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso2259622a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726053580; x=1726658380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXwcN/vuwbVA4vvXOqM7ZcDUWuYGAG0x7bproYW49Mc=;
 b=nrDRs31eKX8XfCMhZer29mJz6TpVBQULqjuDq4tOGI48bjUIpZGtnIvGLUm7yHJmpM
 hPSvcyBX2vTK0tw63TnzePWyifDKHbes223OYlaWaC5dFLVWY2T+/1e8JsOVcdGypR1l
 hvNLoReOe8W0OSRLDJZ3bViVFeUM65VA1cy0J+K/rLNBWQHiqUFhyf0aerqwiFrWclXr
 6fP1xvslmEgJ1rKIo8GOSETQ+dSiye+ZZmX1huUfrH+ODQqPFqh0LD76IV6+wZlGOh8y
 54kCuROjYKWa5mK72ky6VCr6ZaKSF63QKwZRjn48JGwBXjkBCFzeFuixj6vWD9xq0NN6
 U3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726053580; x=1726658380;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXwcN/vuwbVA4vvXOqM7ZcDUWuYGAG0x7bproYW49Mc=;
 b=HnoAWwiAyvT8g1E/1mznxkzjJumBjyssL8P4Dk1exLvurmu3LHuxWSfHbWfjMACPZG
 T1SF+4oI+ztrRT+PALkTGYaJ3PSrhPc6P+VJED6f6dG3091kKrkFjUUlj32Q8tyWRDfX
 26BJ6cYt8e9JEBZTQ4vVc56Ui/hXDWpOftVnEGcf99rfs6CPYue73/LureJMktykg4m3
 jzGNMf+4/vsIJWIBHR3s/QWqK3Qual0Sj6Ob136By+swz2b4TT8snkJ6TMnHtGS/TybW
 +A8yOw1OYo6ia99VsxcCc7sZ344R2xFcA7wx/fUAxFdFTSGf+cmK86sNYsC04ySOR15r
 RXGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqbDiydLX5o/raUENeq/FJo91C4ZSXXd6j1NOBruexQiLjZEtUmWMdpzm5gSSklDhSN/Ba+g6/SQ+Y@nongnu.org
X-Gm-Message-State: AOJu0YxaVWBZ8RU3AF+y54yJK0Y1z3KUeP6fCUignzCJfXlk0vqX4oym
 pP71L6nS/kadWITBm10HAE5R7YaFaBh7E9g4caIHeZWaI5rJ75UI
X-Google-Smtp-Source: AGHT+IHGIXBEURhfxBFAu1XAe+ag20Re2C/YNNCWNnuffvF8MMUk3LPrM6BREZsakH/3qKcip7wdsw==
X-Received: by 2002:a05:6402:27ce:b0:5c2:480e:7960 with SMTP id
 4fb4d7f45d1cf-5c40bba1bb4mr2211527a12.0.1726053579242; 
 Wed, 11 Sep 2024 04:19:39 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-102-051.77.191.pool.telefonica.de.
 [77.191.102.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76ef0sm5307393a12.63.2024.09.11.04.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 04:19:38 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:19:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
CC: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org
Subject: Re: SDL2 keyboard fixes on Windows
In-Reply-To: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
Message-ID: <41C761D3-77E5-4E85-BB78-5B52ED502A4E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 9=2E September 2024 06:12:23 UTC schrieb "Volker R=C3=BCmelin" <vr_qemu=
@t-online=2Ede>:
>The Windows keys do not work properly with the SDL backend on Windows=2E
>Patch 1/3 improves the situation=2E However, it's impossible to solve the
>problem completely, as there is no way to grab the Windows keys=2E The
>Windows keys are reserved for the operating system=2E In addition to
>Ctrl-Alt-Del, there are other key combinations such as Win-Space or
>Win-L where it's not possible to prevent the operating system from
>executing the corresponding functions=2E
>
>The other two patches prevent stuck modifier keys and unexpected text
>input on Windows=2E
>
>Volker R=C3=BCmelin (3):
>=C2=A0 ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
>=C2=A0 ui/sdl2: release all modifiers
>=C2=A0 ui/sdl2: ignore GUI keys in SDL_TEXTINPUT handler
>
>=C2=A0include/ui/sdl2=2Eh=C2=A0=C2=A0 |=C2=A0 2 ++
>=C2=A0ui/sdl2-input=2Ec=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++
>=C2=A0ui/sdl2=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 71 ++++++++++++++++++++++++++++-----------------
>=C2=A0ui/win32-kbd-hook=2Ec |=C2=A0 3 ++
>=C2=A04 files changed, 55 insertions(+), 26 deletions(-)
>

Series:
Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

