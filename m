Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276CFC48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4Ix-0004Ub-D7; Mon, 05 Feb 2024 14:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rX4Iw-0004UM-An
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:06:54 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rX4Iu-0007iS-Tl
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:06:54 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-59a146e8c85so42209eaf.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707160011; x=1707764811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Se2AYabkUjDUOt5YIJBB7lI0SdJAPGRAlIRMo2qJFyc=;
 b=iH53wot7nm1rPb/EBf02H6fQGHPriclz7KeA6RLiQTU3f/hxHL1FW04jpHne5La/ka
 p+LhqY7QaVc6H2gsQtBRJwuTGmR8UnyQksI4ktgFNhwhfQfk7E1XoZdrJV5OoJFqToP1
 aZ3HmlNYU8B4UqzKj/e8JPEv8t7Fh7ZI8dccaHbfvDhuylIdpNtaTnKQYJkvgcJAhmLF
 mZK1pksxnZAZnZXeX5h/euqgq0696VVcFMXNCMeQ4FpPd1jGqc+NRqCb45Aaxhpulgks
 t6azUHd23lasItey16dhOhETonZadQkOpu1yf8yvK+lflUkXKrE30iPKz1Peap9lwyOs
 jXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707160011; x=1707764811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Se2AYabkUjDUOt5YIJBB7lI0SdJAPGRAlIRMo2qJFyc=;
 b=h4claD+gTUtAoVgW7y+bx++GqnRwkh7zPONMznVZslTbEvhm+Jp9a740QfMM//966h
 CGJbYbOdW7RPRGkrs0EZ7bCui4lLWW7Se2looH3gq/4dmg4AoXJyh4IEgLA2vKiWEPuV
 z9X8TJc90VHN4UiLibx+Y42/AgSIg00VYwfOxIL1atvmKm7oRBVQDTy6HHOqsr5PMjhf
 YwqajSEGQKjf7xYKZfcUwJBJYjy53SIr/HFix1cQode8jCpCApmtNtw15+qc4M/kxajF
 pu/1b/LgEKLw+2Gl256CRmCk1n+8I7VlFX1HPdudpLMsNoUz3cvAGk1pBdXVVDSqaJbN
 qidA==
X-Gm-Message-State: AOJu0YxH5DO6HCdKdLlaue1venEvyTPw6YdNgtiUGhmfYje4DHrWmizj
 jsTnjEe8CNTisD5XInN+lOOdAn0nF/6fFDSX5nPk7Zh85Jyeqn2WcoNO9MF7kWk5EXt4fkvhkAS
 dMnlGtOL+u3vsR7P7ZluBNX9sSFM=
X-Google-Smtp-Source: AGHT+IGhBssTKxdPzCrXHV55WZu1jgum4IhoLs2XM9ERA/FZ3qYZVdjJ50Sn8q/IYxosAEdoT+8pfbud2jcSA8Yb8aE=
X-Received: by 2002:a4a:241d:0:b0:599:49ec:6d15 with SMTP id
 m29-20020a4a241d000000b0059949ec6d15mr584834oof.1.1707160011436; Mon, 05 Feb
 2024 11:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com> <877cjiaibh.fsf@rfc1149.net>
In-Reply-To: <877cjiaibh.fsf@rfc1149.net>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 5 Feb 2024 14:06:39 -0500
Message-ID: <CAJSP0QXt4VtyeqZTY6nJ4fVQrjrjMFS7rHPCxiHkcQL8CD=qFg@mail.gmail.com>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
To: Samuel Tardieu <sam@rfc1149.net>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 5 Feb 2024 at 13:16, Samuel Tardieu <sam@rfc1149.net> wrote:
>
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > $ gcc -Wall -Wuninitialized -o jump jump.c
>
> Note that many GCC warnings don't trigger if you don't enable
> optimizations. In the case you exhibit, adding -O is enough to get
> a sensible warning:
>
> $ gcc -Wall -O -o jump jump.c
> jump.c: In function =E2=80=98main=E2=80=99:
> jump.c:11:3: warning: =E2=80=98foo=E2=80=99 may be used uninitialized
> [-Wmaybe-uninitialized]
>    11 |   free(foo);
>       |   ^~~~~~~~~
> jump.c:8:9: note: =E2=80=98foo=E2=80=99 was declared here
>     8 |   char *foo =3D malloc(30);
>       |         ^~~

llvm also prints a warning:

  jump.c:5:7: warning: variable 'foo' is used uninitialized whenever
'if' condition is true [-Wsometimes-uninitialized]

I confirmed that QEMU's current compiler flags enable these warnings
so both gcc and llvm detect the issue that Daniel pointed out in QEMU
code.

Daniel: Does this address your concern about compiler warnings?


Stefan

