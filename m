Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E847C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXBH-0007VV-J3; Mon, 12 May 2025 13:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uEXBD-0007U3-La
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:43:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uEXBB-0005lM-Bd
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:43:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5fbfdf7d353so6261923a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747071783; x=1747676583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLCCZwU1fpn9UUMYzsI8IvsGIFCdQYUqQRR94oJylXY=;
 b=dRiZ2HTnMb9PPj6+zWMmwVbOmrYSf+al/ZJHHArULZFqtJEXjOpuzb3yluZsRLW9uR
 JbMCHC+fy1VMQueHfqzj8GTPMN1wzNAGR32Jsmw6abMZRKRyvvnHKNW5iATDE66yy4q+
 3EZdHA0aITXWXz4U94eoo9Xw6muRIlG4cqWfBbTfCYjyyPVYFbW6kICSUFXXyMx03Mlk
 gKNF7qFyaWF9xzY97I1eb75WkimAB+aN9UD//irwIC2G1TpiWBnglD9b4du81Ld8Cb+O
 5Gp8i59qUF8i0f0lCIgE4XrJGxpKGd7zd0iYQuXBXnPD6kadA20Jn8Hkys2B0AmSzCuO
 lJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747071783; x=1747676583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLCCZwU1fpn9UUMYzsI8IvsGIFCdQYUqQRR94oJylXY=;
 b=Qgf1hnMqpcXdys1xBl6XZ33sEQxn7rp6T9Mi/fPxGk+8d48seBE3TPQ5Mvo0kmvZ4/
 Mc1mwV4JXjL9ITY1mb62sK6P6nbikl/+43eGX7Pn00gIv5Y41rMqqP6GUveqBdMQVmyy
 QyxJfeQ3bREkGpkbKcwiAoxoIj/speS8vcbA0z8uFYN8C7xkMHooS0/1ZxTEa4W5zby9
 42ahlR55+wlFTsmbDQnrFlAgxsCIq9xLJ+fww+Q07R5IyUlXgfIeU5fcy1L88bjB2zc3
 xPZPQ40eixOTkYHxNJlWkn0/jsnotz1Zrf0CRauoJ7k1EY7cyYe1G0uvNkXxAxNc1tU6
 vgFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmkaibzoRhrVHQOV1TQy5QZmdv54y1mizyEM71MJdogg4iWgfx8eHBOYUAaLC0S4nSWkDHhnXrAg3N@nongnu.org
X-Gm-Message-State: AOJu0YzLpWfKkHR+8MZlukgfFeMz6d+uKrtYCvXdklggSgj+/eVW+CEv
 mIrNGsuCQa6iqaJvw2zWyMS53wpxASTqUq5FBHtEU1BwBIxHQ/6zE81hNPvtXh/0vVUs2EbNXYN
 hbKPBwdwgeIFcDzTZNDPlxR5atnc=
X-Gm-Gg: ASbGncsqkkdLJhTpv3JjCL0PVyasky4AdX5KyySmhGe2NQ+BZ6NH2aQXyLkxozcbIOH
 W/LzZKCIDGI3JlYWtWAcCdkA06kkaXUaYSSwCEOKfVChHDzX5wopHD/JQVwO2HQ8BGYy+9eAXuh
 HpJLoH2z5BV9LXESwiQ+eotL9C1zSzioU=
X-Google-Smtp-Source: AGHT+IG4SA27J9kx6WR6EQ5vrwFGYxvJX1zcs30cfCqR8njC1O2kkZxJyHS0ECKhmrHnfwp9qj5eBudSadP5eKdb65I=
X-Received: by 2002:a05:6402:13d4:b0:5f3:7f49:a4b6 with SMTP id
 4fb4d7f45d1cf-5fca080a80amr10298700a12.23.1747071782912; Mon, 12 May 2025
 10:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122522.73786-1-philmd@linaro.org>
 <20250510183552.GA116934@fedora>
 <CAFEAcA9mav8B+u1-C47KZtc-cnUBGY-f7OZG0QAwtb0uGMdxPg@mail.gmail.com>
In-Reply-To: <CAFEAcA9mav8B+u1-C47KZtc-cnUBGY-f7OZG0QAwtb0uGMdxPg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 12 May 2025 13:42:50 -0400
X-Gm-Features: AX0GCFtMK3Z8tB5PQ6Tl3ejYkdxHiiwm0u96_-2rFHbe-ng0yz1wiDt41rxnHSA
Message-ID: <CAJSP0QX2sSqGEn_Wx9+pT0D-JOwc4WdtcZN2o3M3cin07dSUEg@mail.gmail.com>
Subject: Re: [PULL 00/19] Misc HW patches for 2025-05-08
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
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

On Mon, May 12, 2025 at 1:05=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 10 May 2025 at 19:38, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for=
 any user-visible changes.
>
> This pullreq from Philippe doesn't seem to be in upstream git:
> did you forget to push it?

I probably forgot to push staging to master. It's there now because I
just pushed some more merged pull requests:

https://gitlab.com/qemu-project/qemu/-/commit/f9bb7e53a341d08fd4ec8d7e810eb=
fd4f6f936bd

commit f9bb7e53a341d08fd4ec8d7e810ebfd4f6f936bd
Merge: 3e1210e8b0 54e54e594b
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Fri May 9 12:04:10 2025 -0400

    Merge tag 'hw-misc-20250508' of https://github.com/philmd/qemu into sta=
ging

