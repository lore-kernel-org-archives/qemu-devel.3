Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84843C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9n58-0007lC-18; Wed, 22 May 2024 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9n56-0007kv-Fg
 for qemu-devel@nongnu.org; Wed, 22 May 2024 10:36:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9n54-0004ep-Pi
 for qemu-devel@nongnu.org; Wed, 22 May 2024 10:36:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57342829409so1856095a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716388597; x=1716993397; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF9bKq9BWSmmubHeSpqilwRxYSVYHtpS3zc9D14Pbwg=;
 b=uxjui4qzlxffspojBUuc29vDuAwIqc3zJnCpMkRkGTezxeTwSEWECwV4EzQ3B/GwYH
 01ZeJtXPEiuEKy4M1Yy2tqlCL7Dbj2UfyH20PX+8mRn6Ot0oS6/wOCygWH0A5nw+YbLd
 3BoUV5vrTiiSGZSDSHTlicGIh3hdp2I8Mh8vr0j3PE0nSvDmLwa9t25gtAgPj5VToWCN
 zdEeDT45I46gTLthhlZPpyKEVS9NrwZsYXOQGVNWAb/9wzCih1bye0oS0F1C8/Jc8cG9
 Z+5PkBwqCS8VJkDZ0qI8rztFtY71PVn6Get+Ua27WvCGwSeUXMw+c3WlWKJjH2R0zmY9
 P1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716388597; x=1716993397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UF9bKq9BWSmmubHeSpqilwRxYSVYHtpS3zc9D14Pbwg=;
 b=CH/dlQz3eaeZqnVjbLXVrh2yuOqdEJBz0RasweB8dyz2BX70klVfUhC/LsIwMgRmnj
 1rN6CAvkkC5TCsc00v8B4RE/P2Otb4+yTPx1ElVR/1hSZdwjYuksyv2gQyfIBBDruc0L
 wkM0xhHWJXgVbTINNZtTCyW+pbyBvGWsuvG5EVAm7l/ulJ86g3jBHKGfqNOWgxWqfFjt
 0wtw5WIig0Xazghb050TURro8Rqq87SzBncRDmN5dOyUfR1XfliLScRJuQJOrvzSxfi8
 lxMeLwGQb9DMk5K0mFlCrdAqOpDX5gDb1OJo+Mz+Ji0orwuVyCFzX3Vj7MAaWiXizyxO
 Y/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYj8mTw0rvhnwPq8nlkUhOl3OR3bRpWorxqS9gbeBXRayFuDI91sfVUvn2nZiwVMIJ6MAVTA28hbpSrDRGPuQGdlWpcVc=
X-Gm-Message-State: AOJu0YxbRLbICcSI7ywgzYXV8bSSLgieaQwWOWjSRuPz5k4eACV2iRCk
 QHxA39ASUgqUGXEJSqSOcl/9rXsmsbL272L2gpaOLsRkYSivGz97asD9E4oUQ+ol0woB7i5wSRj
 PJ6whh/3qanZLQk6vPcHBk/alojdrpKdCU79INQ==
X-Google-Smtp-Source: AGHT+IEm014TELzRgAVgykXsKHQomllMf10ZW08oX2RL+vKKe6qcOJONt466u77su6lgaKE+TJTDJ6Gr9RwYU/TysEI=
X-Received: by 2002:a50:8d46:0:b0:572:a7c8:f12b with SMTP id
 4fb4d7f45d1cf-5783113d2fdmr1984546a12.13.1716388596985; Wed, 22 May 2024
 07:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-1-c429de860fa1@daynix.com>
 <CAFEAcA_Sm=j_Q-gP=gaAKpmaMwA1-rO+JLAijzzuuhQOEFyfXA@mail.gmail.com>
 <Zk3bXNAIGnhbEUnK@redhat.com>
In-Reply-To: <Zk3bXNAIGnhbEUnK@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 May 2024 15:36:23 +0100
Message-ID: <CAFEAcA9xVf4iOGVKZjhu8YRrTXtgxD5CFvcthVr1sOrin1-vJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qemu-keymap: Free xkb allocations
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 22 May 2024 at 12:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, May 22, 2024 at 12:35:23PM +0100, Peter Maydell wrote:
> > On Wed, 22 May 2024 at 11:49, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
> > >
> > > This fixes LeakSanitizer complaints with xkbcommon 1.6.0.
> > >
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >  qemu-keymap.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/qemu-keymap.c b/qemu-keymap.c
> > > index 8c80f7a4ed65..7a9f38cf9863 100644
> > > --- a/qemu-keymap.c
> > > +++ b/qemu-keymap.c
> > > @@ -237,6 +237,9 @@ int main(int argc, char *argv[])
> > >      xkb_state_unref(state);
> > >      state =3D NULL;
> > >
> > > +    xkb_keymap_unref(map);
> > > +    xkb_context_unref(ctx);
> > > +
> > >      /* add quirks */
> > >      fprintf(outfile,
> > >              "\n"
> >
> > This is surely a sanitizer bug. We're unconditionally about
> > to exit() the program here, where everything is freed, so nothing
> > is leaked.
>
> I'm not sure I'd call it a sanitizer bug, rather its expected behaviour
> of sanitizers. Even if you're about to exit, its important to see info
> about all memory that is not freed by that time, since it can reveal
> leaks that were ongoing in the process that are valid things to fix.
> To make the sanitizers usable you need to get rid of the noise. IOW,
> either have to provide a file to supress reports of memory that is
> expected to remain allocated, or have to free it despite being about
> to exit.  Free'ing is the more maintainable strategy, as IME, supression
> files get outdated over time.

I think if there's still a live variable pointing to the unfreed
memory at point of exit the compiler/sanitizer should be able to
deduce that that's not a real leak. And if you believe that these
really are leaks then you also need to be fixing them on the early
exit paths, like the one where we exit(1) if xkb_keymap_new_from_names()
fails.

I don't object to this change, but I think that if the sanitizer
complains about this kind of thing it's a bug, because it obscures
real leaks.

-- PMM

