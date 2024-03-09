Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EA4C54E5D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj36S-0000Ba-GG; Sat, 09 Mar 2024 15:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj36E-0008G9-K0
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:15:18 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj36B-0002U6-Cu
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:15:16 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d29111272eso45615941fa.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710015313; x=1710620113; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W145/tJ/AnzrQ+jVcLq0mzh8l1gW+6+qn4EZwemudHI=;
 b=mXRXTgJOWqCjktswyWDE1K5e/Sposs4XU2jODf1jFcQjoCVQAlDhH0jA47vFECh4Ka
 dRkhKWpT18DM8chOtkcQQcETK1W7oM+sXFzVj4IHd6Q8j6Af0/veJHSEhDaoILiMP67Q
 mTYm6ZXrimar1mGCNn5IfOWbJXAI1BeJx5b0uhv5p7lt8p2RQNvPfKx6iPrD9tvUe/ds
 kpgvFTKb3QeTUHGi0sYhKNZMaREI+Mtd2uZl0JPgFaoJpAkwUcWFEaB6IdywGsM4L9sC
 0FaOj50Kk2QS+TuS6vkbAWQfSIi/fsn2/za+oImVnB+dKCrq2JE46Bc8coSrGM2p8/Z7
 gIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710015313; x=1710620113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W145/tJ/AnzrQ+jVcLq0mzh8l1gW+6+qn4EZwemudHI=;
 b=LTE9yKatE8hJGqsiWyl9+7VTudMiKcWFFoU5OjMOFS44BeICtxMnr6lbhgpSl6tzuE
 Q3OSgNwQ6UpxTaOR9tKR9FG5ur3UDk+xBXISjISpMotCicrgV053zdWP1PbMfciNcUV5
 4bAb9GQvS7EDTmCm2WCtnt6qbSW1drPa89d7GmxQWuGTTlzmkHugBVKrFOwQydBF4LNN
 NvCbgOo2WBddzgZMEapCyF64S+1Cl8JXSJL23A5V3oi0/fvTchJupFyiduzg43LQP5BT
 GWXRKup0HHsjjUa6M26Loylh/Kvgxep/SFZTEAFvd5D+EFZkilASJYuBHNyGGw1krFoV
 yZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNLhzW6yBrwEJkRzbbQnBnLFETXYPfcVXPYaJNrJqEF76xdbg149SiMeT3KVFSqSTpUadM3IFsQVwGoaanto6Kd7ISw7U=
X-Gm-Message-State: AOJu0Yw3h5mbN4+7dI/K+F2TRQGMyjljRAteM4/KgKtsWlb8TOTKxv3/
 r1OR1tBKs3sltnbzIKuasPlhdATUgxRERJor6avyISMiYic8EePfz4ZZj1KpfbtseRjy1bzVK7i
 CdV8slhfjKY9cKwTH3jFXrNEAw5FH7P18ltYSoA==
X-Google-Smtp-Source: AGHT+IFAIMYaWRJxnavF0gYmB18DSJR7L64p2F5ffRCWP60/jkcmV94mD+6/DH9VMvbKh1OU1IR3ARY6/3XvG9vH2do=
X-Received: by 2002:a2e:9484:0:b0:2d3:c197:ad40 with SMTP id
 c4-20020a2e9484000000b002d3c197ad40mr1404798ljh.46.1710015313469; Sat, 09 Mar
 2024 12:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20240304130403.129543-1-thuth@redhat.com>
 <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
 <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
 <ZeYNQdqW2bBA4gNL@redhat.com>
 <86d80d62-8c82-4ec5-ab67-50c83041f979@redhat.com>
 <CAFEAcA8X6hR+GfnREQkWNqiOBk40r4o_dWPOiyfVT3n7YJqRVA@mail.gmail.com>
 <f31b2eaf-aa04-46ed-995d-67c785be167f@linaro.org>
In-Reply-To: <f31b2eaf-aa04-46ed-995d-67c785be167f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2024 20:15:02 +0000
Message-ID: <CAFEAcA_qXoKD7dGzqD_D_1F8bLNXLXbu3++xj31TYUgS=Wnn9g@mail.gmail.com>
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Sat, 9 Mar 2024 at 18:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 9/3/24 18:27, Peter Maydell wrote:
> > On Tue, 5 Mar 2024 at 10:39, Thomas Huth <thuth@redhat.com> wrote:
> >> Ok, while I was writing my mail, I was looking at https://brew.sh/ and
> >> didn't see a link to a bug tracker there ... but now I realized that t=
hey
> >> are simply using the github tracker, so I went ahead and filed a bug t=
here:
> >>
> >>    https://github.com/Homebrew/brew/issues/16823
> >>
> >> Let's see how it goes...
> >
> > Seems to be going slowly. I notice that there's a comment in there
> > saying that "brew install python-setuptools" is a workaround to
> > get glib 2.78 working -- that seems like it would be good to get
> > our CI back to green. Is there a way to test changes to the cirrus
> > config short of committing it and seeing if it helps? I don't see
> > the jobs available on a pipeline in my personal gitlab repo...
>
> Yes, but you need to grant cirrus-ci some permissions you weren't
> ready to give last time.
>
> I just tested it and it is still failing for me:
> https://gitlab.com/philmd/qemu/-/jobs/6357526794

That job doesn't seem to have tried to install python-setuptools ?
It did:

- brew install bash bc bison bzip2 capstone ccache cmocka ctags curl
dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3
jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs
libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools
ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2
sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir
vde vte3 xorriso zlib zstd

-- PMM

