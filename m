Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C37ACA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRfu-0006hk-SI; Mon, 25 Aug 2025 03:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRfl-0006fu-A5
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:31:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRfi-0002T1-13
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:31:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-61a8c134533so8463459a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756107075; x=1756711875; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoYCQ1Zzi1zMkWPu85yEEKE4OX5nuRb+55rTKf0ZFFE=;
 b=znpbfZmQunh3D8Mf3mMVjAVi21j5VpzP2TWTK+ketwcFGrs/xo2tnUzQVbjnni7sl6
 KWKAKv2+pb1l4D5lJzNaiQKIwdeCb8by7bQWBx0gKomWxrm9cXprqGuk/yGNcogUJshc
 w98bN68gOuTk7yJepqNhzsVycw4/RKDPqq+kKLqWuIH/C8nx2HaU1Vq+SDjXaZubvTOI
 w0hjjAtxU6CNsDsaX/MEENtTpynsDlSTZ/O8GbJYJCvC86dh7Ut0aWWuSVZDrtlAIfyj
 nC3EU1TYsEz3HXGy4l7ydOb4cI7g3uANp/1BK8DztWQmEfDq3KjKS5S0w45+uYaawQQN
 2T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756107075; x=1756711875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoYCQ1Zzi1zMkWPu85yEEKE4OX5nuRb+55rTKf0ZFFE=;
 b=LsxNK61u5rB40PL0omcv7WvS291HtJRiTUuSMHJa2jDaOyvVrmpn5A1TLVMYwBDNbE
 MIOSDvL909keDWtS+ZBqPciRnh1/PITRI4++ztTvYrcRrJsteudtq3c5tDeppxjkHio8
 StGIwow7Oi2HqpT5BF2e05zzIXUJdExQIhqBxWb8Xsefcw6PLP3Yzz5nJMXaxsPA23Fw
 IOqVBBb6fXCXveKIxHit4ziV7z9xDUSDStYoO7p9g6ladcHY9JO7d6F+6hOHiu2CiFP8
 VVzzbRAHeOHkyvaQmCG2FiGGyFm8VRYuZ73EfDlTnRALnsjr7zOhbzxBMenv3iUczCGB
 B49g==
X-Gm-Message-State: AOJu0Yx24B9g61bBhDmhvurNez4TXSB8kx+JCa5W3D3TIS/MvXxXdCXg
 ztKdVk5dM919D9ZtH8XnDbCZsEZD8Wh0mmXf5UAUZbTtcvAh1+FnuHMHHhbFuxVzjf8D+dAOeE1
 Tt94K6wIbu8GvPrnec3A3hf09CA7spxFNrUjNVjlAVg==
X-Gm-Gg: ASbGncs/2JnYZ2pnqssYsRk/R9n3Ao6FyYBK4OnuJ1ow6Ikgo1TClKct65YFFMVu5zu
 QwpRMl7AAHMBHr7noXCca8ph6PET0Nd9/utDoGycF/A5v6xTRnC9hhrMHMolbe6ZX2FhOScJPGQ
 TEgM2i3mSMw62P8OGHmdQmnJTYADv529ddhNnhULvs/yKYcWC5dRnKQPsn271NtUn2tJrQ4eCWr
 fD+8Ash
X-Google-Smtp-Source: AGHT+IHpeEcFzwwJlwE7Ra7L+7vHpeUrD9QCXqLiH254mkIjpnaJ8qO5p7G93IjD+y10WN50T21dJSetHRJaQGGGh2s=
X-Received: by 2002:a05:6402:518d:b0:61c:3c58:7128 with SMTP id
 4fb4d7f45d1cf-61c3c587537mr4632165a12.18.1756107074702; Mon, 25 Aug 2025
 00:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250821094735.804210-1-thuth@redhat.com>
In-Reply-To: <20250821094735.804210-1-thuth@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:30:47 +0300
X-Gm-Features: Ac12FXxH_KlXhKf7I7gX3CxUYmh8yx_YAr9SLbNF32NoWJ5Wng4jdnct3OYlXyk
Message-ID: <CAAjaMXYt4UBS-2wB2OiSCE_DA77STWAjWvPdv=NtEGsUoSyFPA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Use more fine-grained locking when
 looking for free ports
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, Aug 21, 2025 at 12:49=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Currently, we have one lock that is held while a test is looking for
> free ports. However, we are also using different ranges for looking
> for free ports nowadays (PORTS_START is based on the PID of the process),
> so instead of using only one lock, we should rather use a lock per
> range instead. This should help to allow running more tests in parallel.
>
> While we're at it, also create the lock files without executable bit
> (mode is 0o777 by default).
>

(Unrelated to this patch but the file itself)

Hm. AF_INET supports binding to port 0 to connect to any available
port (see man 7 ip). Is this not portable?

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/qemu_test/ports.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_=
test/ports.py
> index 631b77abf6b..81174a61532 100644
> --- a/tests/functional/qemu_test/ports.py
> +++ b/tests/functional/qemu_test/ports.py
> @@ -23,8 +23,9 @@ class Ports():
>      PORTS_END =3D PORTS_START + PORTS_RANGE_SIZE
>
>      def __enter__(self):
> -        lock_file =3D os.path.join(BUILD_DIR, "tests", "functional", "po=
rt_lock")
> -        self.lock_fh =3D os.open(lock_file, os.O_CREAT)
> +        lock_file =3D os.path.join(BUILD_DIR, "tests", "functional",
> +                                 f".port_lock.{self.PORTS_START}")
> +        self.lock_fh =3D os.open(lock_file, os.O_CREAT, mode=3D0o666)
>          fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
>          return self
>
> --
> 2.50.1
>
>

