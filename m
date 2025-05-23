Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1B2C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 19:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIXgK-0000zX-BP; Fri, 23 May 2025 15:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uIXgI-0000zI-3c
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:03:46 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uIXgG-00075n-8R
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:03:45 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6015f8d4b7dso411676a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748027022; x=1748631822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nB9GFzkvxRffatDjF/6H2an8txJVM/+TY7gEXj8ECg=;
 b=Tr4wYPRE7r6/oHXOUrbQnqY06zHc1YrpjRSGsTgy72TvTX96F9/iF0BjizrYbe6Qmb
 uNaqsgYtYJE2aY6NxLCEU6J43FaPxSVNMItlqkpbd9NqZukfsFnw3I46AAPLdZCi4mlD
 ETp2xa5aNRP4IsOpGQTJHEaoJJQHmgkK4Nw0gJBXdiNwHEed2WA4oIsBS738tWwWc6Qa
 lobkMWJeqqmasDp36XFPS4pX7F0UwCP7AK6qzvcKAy33PrjfK6J2MfLGohlnq+HRGE6A
 jojOz1PqdHj3R5k8jEyzVXzDMnltnVo/TNHDky8IkfeyI77vx7K80iAhbIgwyLBw0Uj+
 vl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748027022; x=1748631822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nB9GFzkvxRffatDjF/6H2an8txJVM/+TY7gEXj8ECg=;
 b=mimJ6JNgu66X3hbWBpxOVBLJa4RWWqlOlZOdSeVCUFlgbKRw0NtAm5X7XWh3bteELd
 YfM4dTodmSGEQOniuMddo+5sRTZb03daIQZkrcYIMueHufl9UqlquL3JCDepeYHdFK7b
 dI98UKveZ2dSY8m7IPrw5LSI29W0qDJD4rq9v/FeTv5XOh8JZeo2A2HxKwe1z1Eini69
 XdAW9GUHWfNPMgF7pLHt44vgg5U+c8A2vONUmCf+ak2mYKh1bPNJBa4siv5GEwsw6lzS
 9nzw/FYme94muD0mheBL2k4WB0XEsKKA14Wps55BW/++399aRjEwGAdFxaghimcHDlCk
 1PLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3NfyYB7ssBnQXuqgtDR+elIDUqZx9ljCTVYOMxuqROdhg3MnsvFoZ+21FgNBverHvURXrmqRCnImX@nongnu.org
X-Gm-Message-State: AOJu0YwpK9zL+sNrEkVxPT9PEc0dgHIzY0ptvqohL6PeXp77aSkY3Tr+
 YJ+7zJjN+L53EH8blhuLbsm44sOMOF635TaNUXH6LUp/4KtOOrecXJ3qHWY+MZvkdBRzraSGROq
 Ja6QQBlFFGTCpclruD2ktb1BujiuzDwLJK38HXQU=
X-Gm-Gg: ASbGncv43Ec2c0aIvLDBRiCN5yMFUxWMxcZ7I1En8gq4CFywH7oZzktv6sTUN+gdn81
 NDYZTxkypPSJgPs/sEMqAB4BjXZdbQcOMTH7tM6IYgVQDD/JElEGv+pmfJk1vKqrK5/54CpvTeL
 zKrmt+rKbso1psUoRE2jEWVE+uauyRFIo=
X-Google-Smtp-Source: AGHT+IHE/vgUocXn8OJSAAo9WnoubWHuDvY4Si8R4kK0vrqpQyMR+DRZX4q6IhPlQkFFTSx7JffANTsU8Xpm6EJrnts=
X-Received: by 2002:a05:6402:4303:b0:602:bfc6:f99d with SMTP id
 4fb4d7f45d1cf-602db0c06demr198617a12.24.1748027011714; Fri, 23 May 2025
 12:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250519170055.3693275-1-jsnow@redhat.com>
 <20250519211718.GA58576@fedora>
 <CAFn=p-aaeXTjqMmPpH3_-RwcOHbqnbFz4eztnA3V=jD9cKhUVg@mail.gmail.com>
In-Reply-To: <CAFn=p-aaeXTjqMmPpH3_-RwcOHbqnbFz4eztnA3V=jD9cKhUVg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 23 May 2025 15:03:19 -0400
X-Gm-Features: AX0GCFuDWBsTopDnTKHrQ0LvvAG3N2eiFukDlR79eIGdKWkQcZOx0k7w37XzC9Q
Message-ID: <CAJSP0QVW1x8TyHo_=fZAPPYoMsccm=--1y=jL-LewzaBTOeZbw@mail.gmail.com>
Subject: Re: [PULL 0/6] Python patches
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Fri, May 23, 2025 at 1:40=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
> On Tue, May 20, 2025 at 9:38=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for =
any user-visible changes.
>
>
> Did these get dropped? I don't see them in origin/master.

Hi John,
Sorry, I missed an error message from the script that applies pull
requests. It was unable to parse your message.

The email uses content encoding quoted-printable and the text body
encodes carriage return characters (see =3D0D in the raw message at
https://lore.kernel.org/qemu-devel/20250519170055.3693275-1-jsnow%40redhat.=
com/raw).

I updated the script to discard the carriage returns when decoding the
message and it can parse your email now. Your pull request is running
through CI now:
https://gitlab.com/qemu-project/qemu/-/pipelines/1833846709

Stefan

