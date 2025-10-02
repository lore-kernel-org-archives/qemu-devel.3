Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D17CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 00:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v46kt-0006Gv-IE; Wed, 01 Oct 2025 20:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v46kr-0006Gi-DN
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 20:01:05 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v46kc-00073Z-C7
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 20:01:03 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b5f2c1a7e48so316828a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759363240; x=1759968040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=19lwUuZNKZ2bDLpTXMefc0x8xklKWo67KC08NTtTmeo=;
 b=WwrtG40KXVEp6IlBt1Two32ryXmmrZ9ycrHIGA75I0y3MPmf/GbK9JkfsN6/g+cnuy
 u7pk/TPr4n3vQ2u8j0yP88n6zpPslxeAfsQatWNuhFBIL2+GmWFA/o7N/AqqzTDoNzr5
 d0PDHOVQhEqGqFKGLPiZZ1mgRHBE+qMq4M4ZPIlnt+sMPOOFy9Hw53xJpHP+V/94rN1a
 UuEK7pIt5FrttnzUB1qlQDenqWFTWUELGczdxclkhpIOg/CXz2fbYz4g5jDyQIbH7lQc
 sk+4kVrccqG+EIsc+vlVQRdqyo/TfcXXr9LyRZ2iCNjmTwntoNt4aQzslRZQF+cQ8vJA
 AgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759363240; x=1759968040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19lwUuZNKZ2bDLpTXMefc0x8xklKWo67KC08NTtTmeo=;
 b=QQelLStPLvCMHzA8Sr4sFL1rO2JnWCcHKAIvQArJxK5sVGfnydG2z4lx/DCczQPHoX
 L5j+7qC+Q3YLNHk6AWMI8q309FnxenEYxcbGnBuSqocS3Egumw+3JbY1GkBYFl6+mC8o
 1c03sA9i3dJ+POP+AzyzVAs4uBHHBuoSSkFqMIOjCHkabG4E0GW/MId0LIyiOMknQFgr
 uS8yHwIJYRSUgVcsOqwHvVD+IdZIhpSAQXQ6YFHLMm/Dw/XCGYYW1dmChYrbF2rX191D
 JarxU2tueCCMGYRbd1e4rlxtLixQ1ZwsC2uf7ubICqIV5ryckF4206gVEmp3M4WSt7y0
 YUAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCrjLlTAu3Ets5P2uXg9x9Ehw30YT1iiprLwQ/NajV7ad8Hm5CmV+Keo3mgo6X/maw/x0vylescg9U@nongnu.org
X-Gm-Message-State: AOJu0YzKukHjHj1aC8mgO+qRWY5VsqBFeJhDt/vGowpxnHjE2pLD1rY/
 no64OZ3fKK4oaxYGcI/E9/OUQzrp005kkQljyB49uAcspnmwPyklDzIJThfP+b3LKZyzrV+NRii
 zg46ITQ0tu3WQVtzx0qkOd6hvLkoP9+Q=
X-Gm-Gg: ASbGncuEtS8aMEdXuIkTgXRnDwD0AaM/WqWClDoK6s+Mw4O8qp4MkVX6zFyHWMUBxkK
 cTQmmK1SpI4F89/NFheRn/Mx4/IozdMvn1kNUW26SbwrMHVTX0cMCRZkDluc2K2/XHv8v7YFwWn
 7LGI/bg8Yg2yPM8hh+QkMnM6qjxK+gXPbmIr5ux0oDgZvJn9vCusJl4+wPoQwLA3DNQXqgF0dLn
 hO/zXM+cmJfCzt357aH74GnOgczJ/LhceKV/8MpnjHcye/mxwD1YgqlviGi
X-Google-Smtp-Source: AGHT+IEAP3x0ZEqWZzyZLcacNQMZiKNQhUBlXwJP/p9L8otJgtSzqlIetg5287Vk7Nq5tH1F4qi8F4wOGN3ob3Wtntc=
X-Received: by 2002:a17:902:f650:b0:24b:164d:4e61 with SMTP id
 d9443c01a7336-28e7f2a26femr60203655ad.13.1759363239998; Wed, 01 Oct 2025
 17:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-28-marcandre.lureau@redhat.com>
 <CAEDrbUbOWp24F_wO88Tb9ZCM8Q+jXEK_1BzwGMwC3MG=3TzgAA@mail.gmail.com>
 <cbb6c926-b5a6-49c2-8b35-0988e1fcc7ce@redhat.com>
In-Reply-To: <cbb6c926-b5a6-49c2-8b35-0988e1fcc7ce@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 2 Oct 2025 09:00:27 +0900
X-Gm-Features: AS18NWD-yMDc_EwfuqcImRf38F3sXJgpX53bBJA282HVdDz9__vj9Pzi-gb0RjA
Message-ID: <CAEDrbUZBdWOMWVYcfUf7aV1+=QpyM0GQVnxhcxcU43WPTWezeQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] WIP: enable rust for wasm/emscripten
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Kyle Evans <kevans@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, 
 qemu-rust@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f3791c064021ac4b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000f3791c064021ac4b
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> can you please open a PR for this patch?

Sure, I've opened a PR:
https://github.com/mesonbuild/meson/pull/15074

Regards,
Kohei

--000000000000f3791c064021ac4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo,<br><br>&gt; can you please open=
 a PR for this patch?<br><br>Sure, I&#39;ve opened a PR:<br><a href=3D"http=
s://github.com/mesonbuild/meson/pull/15074">https://github.com/mesonbuild/m=
eson/pull/15074</a><br><br>Regards,<br>Kohei</div></div>

--000000000000f3791c064021ac4b--

