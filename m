Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752BFC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJka-0000w2-DV; Wed, 29 May 2024 09:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCJkY-0000vT-Od
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:53:54 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCJkW-0003Kc-GV
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:53:53 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so2343594a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716990831; x=1717595631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6rxSYbOuRPYsLDE6IcK50CGkiJo2ipEvMUNZXh/dz4=;
 b=LPhsjdvZWFcNvqmeL9tiQbVJ2gkyklIhYn4Q5LrAolBk/gFqGeWAiDyDqw6lE52Ix/
 yJDx+xTQn9OlDbf22Gas9DQPj9WzGQmOYjLFzNcom0RiflW3/Yy5XujiO70A5krFE2Ah
 S1pwk1x8+kLDeUvgKF9LaC8f2GwGW4jCl7kOKByhcaUI3mbIDJURQtBlqf6O68YbxLKD
 CnFR8wbHO7Yox5vWbaWCxjpG/3NoaufeK/1CsVtKmrP2zX3wNT9vrpG4ifiT0dX69Wtc
 jHG/NqgEx2MH1yJ3UtaMsHTo5UA00PweCUWVRuBKWMCn6ec49xQLHD8r5LflnA+5AYRa
 HU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990831; x=1717595631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6rxSYbOuRPYsLDE6IcK50CGkiJo2ipEvMUNZXh/dz4=;
 b=Q9uCQzVoJE3BPaMs2LCzXnwjq3K2BLVx4Taxba6jyL//MbUrva5GD9Dc/lXpdFpKNf
 U+HmE+zt/FJuFdHzbefDSLwqFcjAh2lOZxw5A5gxnvIRPWG/WfMcm63VJehbORhbsxP/
 q9a/qq1fAedLFHAXKBYV1+DOnKbLLFjP/yvbjoKTwXZuRgBXFwcw7v7EER76VIry6zQk
 Hdnea9N6y7oUOeLr9MO7N2Zn4AOpNyYryyMLbdUjttUoinyNEoSipaUf8GjHJB3hJNzv
 i+TWELPptkTAPzqdiG7zk5x3gFeyTNyuLbZ/Dno9m1w0lKXxCj9rJek7ZxeSicCre+1d
 wbLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRoO/uA+ettTICy9MGUb5/rD286Oot0x0vrOBXkjJr5gGYrT3sjV1se1Dr66ol9OLc/PbuQfDScZZivOlcbEyhYuBBmUo=
X-Gm-Message-State: AOJu0Yxs0BGsAkPGXmU/bCxxo/E86lQyHM3Olc/Ng8dnUC7VJpi+kUk0
 N5WhUYJPFcFndmaSaxRwoUGyYHQdKCUS+yD9pApjKVml1fBQypc7JPXGNSRM/83rPTLa3RZu4MZ
 1Nto8t5WsS/nb8plVZXwJNMGS70Ej380/KkJTXg==
X-Google-Smtp-Source: AGHT+IELuPxbzO0NfU0o1tOKNLw0BDamd8UNpohwneH/0t6JciS2bWzEgKO0yLlLFJkCnz1FxEg63yWyF03ZxTmLVpU=
X-Received: by 2002:a50:cccb:0:b0:572:6249:96bc with SMTP id
 4fb4d7f45d1cf-578519bdc7amr10368855a12.32.1716990830773; Wed, 29 May 2024
 06:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240529133106.1224866-1-thuth@redhat.com>
In-Reply-To: <20240529133106.1224866-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 May 2024 14:53:37 +0100
Message-ID: <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 29 May 2024 at 14:32, Thomas Huth <thuth@redhat.com> wrote:
>
> Casting function pointers from one type to another causes undefined
> behavior errors when compiling with -fsanitize=3Dundefined with Clang v18=
:
>
>  $ QTEST_QEMU_BINARY=3D./qemu-system-mips64 tests/qtest/netdev-socket
>  TAP version 13
>  # random seed: R02S4424f4f460de783fdd3d72c5571d3adc
>  1..10
>  # Start of mips64 tests
>  # Start of netdev tests
>  # Start of stream tests
>  # starting QEMU: exec ./qemu-system-mips64 -qtest unix:/tmp/qtest-121319=
6.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-1213196.qmp,i=
d=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -no=
defaults -M none -netdev stream,id=3Dst0,addr.type=3Dfd,addr.str=3D3 -accel=
 qtest
>  ../io/task.c:78:13: runtime error: call to function qapi_free_SocketAddr=
ess through pointer to incorrect function type 'void (*)(void *)'
>  /tmp/qemu-sanitize/qapi/qapi-types-sockets.c:170: note: qapi_free_Socket=
Address defined here
>  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../io/task.c:78:=
13

It's a pity the sanitizer error doesn't tell you the actual
function type as well as the incorrect one it got cast to
(especially since in this case the function and its declaration
are both in generated code in the build tree not conveniently
findable with 'git grep'.)

In this case the function being called is:
 void qapi_free_SocketAddress(SocketAddress *obj)
and it's cast to a GDestroyNotify, which is
 typedef void            (*GDestroyNotify)       (gpointer       data);
(and gpointer is void*)

and although you can pass a foo* to a function expecting void*,
you can't treat a pointer to a function taking foo* as if it was
a pointer to a function taking void*, just in case the compiler
needs to do some clever trickery with the pointer value.

So the wrapper function looks like it doesn't do anything,
but it's doing the permitted implicit-cast of the argument.

> Add a wrapper function to avoid the problem.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  io/channel-socket.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3a899b0608..aa2a1c8586 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -193,6 +193,10 @@ static void qio_channel_socket_connect_worker(QIOTas=
k *task,
>      qio_task_set_error(task, err);
>  }
>
> +static void qio_qapi_free_SocketAddress(gpointer sa)
> +{
> +    qapi_free_SocketAddress(sa);
> +}
>
>  void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
>                                        SocketAddress *addr,
> @@ -213,7 +217,7 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
>      qio_task_run_in_thread(task,
>                             qio_channel_socket_connect_worker,
>                             addrCopy,
> -                           (GDestroyNotify)qapi_free_SocketAddress,
> +                           qio_qapi_free_SocketAddress,
>                             context);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

