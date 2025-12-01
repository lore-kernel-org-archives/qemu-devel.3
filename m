Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E8CD111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 07:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPyO7-0004k5-Mh; Mon, 01 Dec 2025 02:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vPyO5-0004jK-T8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 02:31:58 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vPyO3-0006l1-ND
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 02:31:56 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4ee2014c228so30962561cf.2
 for <qemu-devel@nongnu.org>; Sun, 30 Nov 2025 23:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764574314; x=1765179114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmW/W6ZmE1Z/XIbg3R9HSYzl+vJvUftLQsi/LCskuis=;
 b=BeKFVwKLg2rquolv+GOUlxB/3xdDG1ekFlON8bKHvrgeSZXV8kPuOvGHkdlhuBfw/g
 ugy+CEGb7Nd77XHLv78sflo5Tvvf7z+wBxQA5bqCjByc0Z87+Aclzy1FZ3IIwNN8Jlpf
 x464OsT8YL42E5vOFv7tqh9/uU/OEUxpTbCg4TmUA+U2JMlPsYQBQGlvEa9xOkSfuS0s
 ryp+jC0Znc3IjHfVGkdB2+tYVBgsUcZrhX65AQhOBv9NoNL1D35dVjpnv79SvSH2rpgK
 YnmTWynVWh/Io5+eB5ky4gik3cJFV+9DiVGwu0tWfkd37AkIawJhGBF1kunIcxkA02l6
 Y/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764574314; x=1765179114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmW/W6ZmE1Z/XIbg3R9HSYzl+vJvUftLQsi/LCskuis=;
 b=RdxW3/L7YzNttu2syAuqxIHPsnRjBpFdCzUAafz2v4p5i79JJvQJavfiD7iIJj9+O2
 thoOj5hVQhxLV8sxcD5fTByL6sNmr8VSngitr+4uU6PbaBDaFvP+YnonoesWVs9c70Af
 S8Mov3P/C42Rdti8iYvKza3t6aK99NSkbfyxDEHotNRoVNJQItr66fBHc7FOAdyA5Blx
 HX11Pl8fWyjoFrJnLRs1l0UeMJCphWbG70IuZv9zcQ+F6HPliZDcRalsvS5IYIhaxd29
 2eIGohG9wrCyrvIch8MkUvk8Js36jvphmbHFMZ0Y4jzRkNFvTNhhcL/H9NwaFhRpie1W
 JRrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe75ZWOhpraKHuMgN7fd+HkD9bilxVVfCpQAaZW85ljkDGDwi2IZVyiEx0Eih9PblGKXsA2RVVsXaf@nongnu.org
X-Gm-Message-State: AOJu0Ywt2lB+x4HAZunLcLW14jcKu/WnC95RKgajQAP8tSr7Ah+DKyYJ
 uqRYjfGOhuUoBSCX+L3G0kJGNTWfGbHRGbVwUQrNQLHX5MamQskFMRrFuY5le6zFbrC+4pkavUg
 LQjA9VZxs90j8g7/WeJ5N3IPTgwI0OpI=
X-Gm-Gg: ASbGnctKMlQ/heCVpYviKj2NHMyLbmx+lJ6bXPYKVM2w6TdZ98+/OSBCFep9QshR2TT
 L4tN3REKgoY3Wg6GC503Rerm8XFq7GSRAiEQwlHq+j6AYRDgIxLMEMdOTcyzESfztfVAKkygV5D
 eCg79s0NknBjKT2+NJztmSZSX8G74DYuTDs9KEMaYDZ4yQyCvx3FbhMYfwCaFmGVnugzwEkAoNY
 0ZPGsKBRm0KHg5YP8dBglPWJzlPuAM1mq2O+mngRIqeut7IQBJAOig7jD1n5Ob+cFFXOL0HHAb5
 lSbEm8gJt+uFNNwgZTQA+aOy9spz99XH8C1t0Q==
X-Google-Smtp-Source: AGHT+IHM0MEzgoUkFDGzFAR8RHPW25AWN5pHLqorIBvRQ3zVH6/55mJYS4zrpXQFGrZFp0ZlzVuk63yKfN5NRAt982M=
X-Received: by 2002:a05:622a:64d:b0:4ee:1f5b:73c3 with SMTP id
 d75a77b69052e-4efbdafae82mr343391631cf.60.1764574313779; Sun, 30 Nov 2025
 23:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20251125140706.114197-1-mail@jiesong.me>
 <87ms424u8p.fsf@pond.sub.org>
In-Reply-To: <87ms424u8p.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 1 Dec 2025 11:31:42 +0400
X-Gm-Features: AWmQ_bnHAi1pRv5KkaTVVdfAAGIt1ke_wiY21g4NOmN1h7JmqGMsjeWiXZKx6CE
Message-ID: <CAJ+F1CKXSHJ=uhtUSTmzaBMS5oMqHEzw3Y0weOE2MxmMbQsL6Q@mail.gmail.com>
Subject: Re: [PATCH v4] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
To: Markus Armbruster <armbru@redhat.com>
Cc: Jie Song <mail@jiesong.me>, eblake@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

Hi Markus

On Mon, Dec 1, 2025 at 10:00=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Jie Song, Marc-Andr=C3=A9, is this bug serious enough and the fix safe en=
ough
> to still go into 10.2?
>

My feeling is that it's a bit late for 10.2, as I suppose this bug has
been present for a long time and the risk of regression is high. Also
not enough people reviewed it.

> Jie Song <mail@jiesong.me> writes:
>
> > From: Jie Song <songjie_yewu@cmss.chinamobile.com>
> >
> > When starting a dummy QEMU process with virsh version, monitor_init_qmp=
()
> > enables IOThread monitoring of the QMP fd by default. However, a race
> > condition exists during the initialization phase: the IOThread only rem=
oves
> > the main thread's fd watch when it reaches qio_net_listener_set_client_=
func_full(),
> > which may be delayed under high system load.
> >
> > This creates a window between monitor_qmp_setup_handlers_bh() and
> > qio_net_listener_set_client_func_full() where both the main thread and
> > IOThread are simultaneously monitoring the same fd and processing event=
s.
> > This race can cause either the main thread or the IOThread to hang and
> > become unresponsive.
> >
> > Fix this by proactively cleaning up the listener's IO sources in
> > monitor_init_qmp() before the IOThread initializes QMP monitoring,
> > ensuring exclusive fd ownership and eliminating the race condition.
> >
> > Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>


--=20
Marc-Andr=C3=A9 Lureau

