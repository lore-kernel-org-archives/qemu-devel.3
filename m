Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0438AFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHAM-0007c8-6T; Mon, 27 Apr 2026 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHHAK-0007bj-6D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:18:04 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHHAI-0006SH-Nt
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:18:03 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so15190030eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777277881; cv=none;
 d=google.com; s=arc-20240605;
 b=j4Kj6DeeE9zDrXwPKUiV00wiNOSCiDvpSsVkAy67T6/CT5sHB5aoDuW8hzAHQkRXPe
 zFxe+Rxyy9QSwkpba+wUl/4w0JsPWDTfdYyvpP5zvRNsyTbgvyhRlUWFVXUozoaYgsr4
 a6RvDbN/ABWMcUhKDR4uF8aH2L7Z6B+CzKiv8lE5JZm4Ld0XWLe2VA/5UMHbaAqSvHO0
 7g5mhQWf4T7s0R1CvZQCsTLWMDczbxnxbHfGzvxBOWvhm6oWZH/D7m70ROMPdxUSqKaW
 IpY2f8O3otxlifMv9k1JFUHbbzrscKpY5vFFU3+D8CbIcMkz13i7e5ZCOHvYuOy2vwoU
 M9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tRP5909te7OtzU/OJaXtbDnc8GJ1x6uIQ+eCRE5A2kg=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=HfKZvlt7eSzIJLj34nsKGEO615Kum9D/OSnaq0ZzvRacednGVveH9ttDef7Pi0Jruc
 FRZu1MuJPGcmWeKmTv+R/Jf/rgh/rSKEOIduON1Zs55mOBgDF+gpPKZow8/L9YQwMGbm
 F6LMlX29HlonHOpUXm+lpcc+00myBwHpbeP2ZEeU5f4ALyNoodPAgCn/xIJMUFKoUkZc
 ZuM1sBOTsEVtglLWrjXJMfd90E+G38q0P1uICSXStRovjGIIldHOZF9E8EeV1KMMNsCa
 lEbBtJDaZyRPTtH7FgX3nSraKvI8GEIe9AbDPbqxx7hVZy6wuxHylEhYgSUEJ2DW3cvO
 SMVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777277881; x=1777882681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRP5909te7OtzU/OJaXtbDnc8GJ1x6uIQ+eCRE5A2kg=;
 b=BJn/S+v53xWaZC5fi0Cquzo2dQ3mPSXL7GJUbDd7xXAk1jPCZDVR//8B3/a+fU6USf
 m4WPe4v3yBlrM+NQ59Us6kV9w/tXRAe3G1urtooGHXXwIfhzkFRJa9n3KIkZozAvrPlG
 VoRNnXS58aey8upCU0Z7HZviceo3a6CAv3JFqNfwxXtiJrebQn0LoeCYHN6P0aanXsZy
 5/i5ZCsneTE873WpsA8mNafa1dXpEmfz30SBCCnWs8nSKrQGmYAQuMzOYTwGjIIDaWLS
 F3koWUvb6f73ZA/xsIDCOIR/LzE0e9NHmtyAA7kyRpu+u9SjmV4ZudYmZctvk3yEHjf+
 OgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277881; x=1777882681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tRP5909te7OtzU/OJaXtbDnc8GJ1x6uIQ+eCRE5A2kg=;
 b=mXVQHqmvsl6E1KfCZsqUIDr2/z4qks4ZfcHxANinaqZCpB3t5DtsODbMdR8Yzpxz5V
 QRPgUmcKxgo3VxfafDajsXjuXycJa5QZYZwwBiz9kghv1gRK5zFJIQzKuF50Nv/3QIxV
 yaBo4rKTsnX2x2WhCCsw0jl1RfEtH2QZ0HLVGt5IxyrjunJQioEamStMO6hn0dIvhmrH
 +RuSXfzQmIHRPSiNrEbOkFOE0ZRKLUWxQUmwW6+bm7xSKaUjETg6RaLKFOjC7YhrMgNT
 e6KCntXab/pbaczQ/Ilkf8giXFojC2JahlZA5+hJcWLXngsMiBKoua87CiImWk3oKUB9
 fTWg==
X-Gm-Message-State: AOJu0Yy/bEvpOyJ5EAy48OEomlGulR8kJhj3/c0KR+y2wzkWt3vIuMuS
 2SkG0m6/BC9pjM97D5UopymRNRtEBPCSD/23hcS/A9Jlva2XX06FXYoCO6ajA5u1fMbrwrnQcTv
 d1Wh+mQyqAAat1NLcBiwNV3NvZlXviQU=
X-Gm-Gg: AeBDievQR6SWlM3gtND01/GWivN3llQj1CpMwBKNQtptHjjEQbC8M54pQrKxDLL0LFi
 8+ijdc6bLr17QPctSw5egKblmolzUi5RzLdr73M0IqzVuJqum/z+P9fEFPIw1B9sGTH6/Uyabcr
 u8zZoDRZSMG8bPnvh1MRPbpW1wPJGZ6DqYfw5BBMFuE9D++zsu1fAeDU17F3Vi8not/IuU0XJZ+
 vQFiejiDXbAXSGp/aFi2l+GJKIoRnOIHPRIBEEpGJx4STXeWj4F2nCmxbqgeBx5YXmD+KUXaarf
 RLjSDCmM6yWt5MMlEinvTS2t+11wO5lblBHNEPGLU15wraLNyv0=
X-Received: by 2002:a05:7300:371e:b0:2d9:6373:ad22 with SMTP id
 5a478bee46e88-2eada6d66damr7916352eec.12.1777277880816; Mon, 27 Apr 2026
 01:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87eck4x35p.fsf@pond.sub.org>
In-Reply-To: <87eck4x35p.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 12:17:48 +0400
X-Gm-Features: AVHnY4LoLc4IalYcT2Mag9AzWpeOQeb8_emFVcsI1WGoeRtlMinsDPm5rfcEcd4
Message-ID: <CAJ+F1CLjuWApGFeivgTywJwzORfwtbf0kjxJdmw8_vpuraJZig@mail.gmail.com>
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Apr 24, 2026 at 10:52=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This commit removes the QemuConsole from the global "consoles" list whe=
n
> > it is finalized.
> >
> > Previously, there was a TODO comment indicating this path needed
> > checking. The assertions added ensure that `dcls`, `gl_block`, and the
> > `dump_queue` are empty before removal, confirming the console is in a
> > clean state.
> >
> > Fix potential use-after-free crashes when a display console is removed.
>
> Suggest to mention reproducers: QMP command qom-list-properties with
> typename "qemu-text-console", "qemu-fixed-text-console" or
> "qemu-graphic-console".
>
> > Reported-by: Markus Armbruster <armbru@redhat.com>
>
> Please add
>
>   Cc: qemu-stable@nongnu.org
>
> and Fixes: if it's not too much trouble.
>

Given that the hot-unplug path is not tested and has probably not been
working correctly since forever, I don't think we should backport it
or look for Fixes commits.

