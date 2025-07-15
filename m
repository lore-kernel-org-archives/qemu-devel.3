Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA938C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbHn-0007BE-Gw; Tue, 15 Jul 2025 04:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubbHl-00079L-8p
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:45:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubbHi-0006du-Ve
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:45:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so9428399a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752569108; x=1753173908; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ACJWwgIui1ouhTnmi/uFhM+flKe5xK/K/78Kl/blJs=;
 b=VHEHdlgDdDAUbx/5Rr5QTyCuIarGV/X8dBkYQtgUjl0JArXYxxr5Ducq246fLmQXfY
 wTqwVY/da1CB7lVhFuI2YXyiiwT5v9tzRIcfLO6o61fDusKBe5HK7jzvfLpr+kMPrqOB
 v2ew1AStpHUxo1ihcccDxHSjFFUeUMWJa/kQvYsMoGXANvfNfP4/WXPPKWqOz6oCU+Xw
 Dk7FqtLXNer/pxAnpW/N9KVuX6HJPgsD7xrhnXhpBAuRhlfCOPIDT/22pEHeyjMRtzbS
 2LoyVCA9P7BRfQ5gz3Pr1McQbDKwIz7Iq8SZR/shID0Lzl1hqOEmaYb3wXAQ4hQNNOZT
 c3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569108; x=1753173908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ACJWwgIui1ouhTnmi/uFhM+flKe5xK/K/78Kl/blJs=;
 b=DN9nK10QMMsyf9Ff+TwiBlaczNX/1TfHxQKw1aZ+tBcKRF563o7jAIiw+7xhmNCRWi
 O8u+/cgkLocHGTiKV7qD7v8bf81p89sisqnAMV8nAB7LrPCVLsnzhcnqnPixwr9vIU6j
 tfsnDSsWYPYqBgZjAnSNHRwDSESMinanHEYcMKmrRo+U6JOWKZv/TR/6V+2bBiX4Y4rH
 TD2y7cVa2AfxvG6gWCZnqHzU5pvBOB0rf1304hf7YYQsFftyJpDyxqufWg2e4+hG0N0G
 E0cq21/rdZ2BIvj5v54wNZqv6vhSB+8f0Edjh8p03D1xeYWyk7SRRa++LBAosDH/kazT
 2Ltg==
X-Gm-Message-State: AOJu0Yyp0gXYMnJ3zcOSfKzM8w5jlzc52f20I2H2K46tEtyuehywDr2C
 7+fo3hP3wISaYUrBgED6m+YDcqpBjRuXtoJ9cGVufrn6beMyTBXqFzKNPVBVwFaR8nT9hvSwnuh
 Fbhm/GddrYMLg2pfvPmNgjeBWtzswkNKXc8ai2K2OHA==
X-Gm-Gg: ASbGncvTs0uBl+k2Mcww0sGbT0EM9BvjY1zXI7eCDYwOWIZ/AKPbo3gpiSTGcQlBSbP
 ARkljeYGOX6fBSh+ul9XT6vIxh1eVOpoKUDURKqN1GCt/uusP7kYL9wsd426cv1FsL1uqjWa5WC
 IVrPjrjI3pVnALvXzQTDTDA94FaeDgbbgG+Mhqccvz/2zysSKpK+D5eicoZHRwDjPOoT1ZHsDAj
 MmNGL0=
X-Google-Smtp-Source: AGHT+IEBck/MV30OpP7zauoJtPQwdhhKl1RryUhYn77Slx9NWts9JdEKAnIjdWjTl6oOj2JgPpF3vNpmt10Gb9YxVsU=
X-Received: by 2002:a05:6402:5243:b0:607:2469:68bb with SMTP id
 4fb4d7f45d1cf-611e861d323mr14637241a12.33.1752569107731; Tue, 15 Jul 2025
 01:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250715083517.47556-1-philmd@linaro.org>
 <20250715083517.47556-2-philmd@linaro.org>
In-Reply-To: <20250715083517.47556-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 11:44:40 +0300
X-Gm-Features: Ac12FXzjjhrdEM3s4vS2aC_cZnGJmbX6yABIfexZ8h_JM9sDssupZ-bumnzVrjs
Message-ID: <CAAjaMXak7Pa_JBHvtXsuxXuDRDqVcmmvLWrW9q0vrBPXJVEj2g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] system/os-win32: Remove unused Error** argument
 in qemu_socket_unselect
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, Jul 15, 2025 at 11:36=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> @errp is always NULL. Remove it, as unused.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/system/os-win32.h | 2 +-
>  io/channel-socket.c       | 4 ++--
>  util/oslib-win32.c        | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 3aa6cee4c23..40712a948c3 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -172,7 +172,7 @@ static inline void qemu_funlockfile(FILE *f)
>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
>                          long lNetworkEvents, Error **errp);
>
> -bool qemu_socket_unselect(int sockfd, Error **errp);
> +bool qemu_socket_unselect(int sockfd);
>
>  /* We wrap all the sockets functions so that we can set errno based on
>   * WSAGetLastError(), and use file-descriptors instead of SOCKET.
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3b7ca924ff3..6ee6217e7ac 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -454,7 +454,7 @@ static void qio_channel_socket_finalize(Object *obj)
>              }
>          }
>  #ifdef WIN32
> -        qemu_socket_unselect(ioc->fd, NULL);
> +        qemu_socket_unselect(ioc->fd);
>  #endif
>          close(ioc->fd);
>          ioc->fd =3D -1;
> @@ -890,7 +890,7 @@ qio_channel_socket_close(QIOChannel *ioc,
>
>      if (sioc->fd !=3D -1) {
>  #ifdef WIN32
> -        qemu_socket_unselect(sioc->fd, NULL);
> +        qemu_socket_unselect(sioc->fd);
>  #endif
>          if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
>              socket_listen_cleanup(sioc->fd, errp);
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index b7351634ece..7ac3482d449 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -180,7 +180,7 @@ static int socket_error(void)
>  void qemu_socket_set_block(int fd)
>  {
>      unsigned long opt =3D 0;
> -    qemu_socket_unselect(fd, NULL);
> +    qemu_socket_unselect(fd);
>      ioctlsocket(fd, FIONBIO, &opt);
>  }
>
> @@ -313,9 +313,9 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventOb=
ject,
>      return true;
>  }
>
> -bool qemu_socket_unselect(int sockfd, Error **errp)
> +bool qemu_socket_unselect(int sockfd)
>  {
> -    return qemu_socket_select(sockfd, NULL, 0, errp);
> +    return qemu_socket_select(sockfd, NULL, 0, NULL);
>  }
>
>  int qemu_socketpair(int domain, int type, int protocol, int sv[2])
> --
> 2.49.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

