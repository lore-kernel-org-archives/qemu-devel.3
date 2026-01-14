Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F5AD38FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg4Bh-0002jV-DG; Wed, 14 Jan 2026 11:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vg4Bg-0002ig-As
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vg4Bf-0006s2-1s
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768409857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKuRRDfifIqTYZG+coIjtsQP5wXxl7wQXzkYS36Y1yU=;
 b=Zw+ooI5EubN6tSa2AEGVZVVlcaLR0kAW+4Tckpva5FeBOmEuChBhvgIAJtA3cfVL4W3n4F
 krktwC30RF/jl/9tB+RebwJw6l49Q9aOx0umjlvwPvj8mMHGcwZTcNJ6nDp0jGYA87FzSD
 vWMaPIklo1sGKIvZa7O7Xm7lS9P+McY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-jpnbDk-KPdG91ZwVSLakrA-1; Wed, 14 Jan 2026 11:57:36 -0500
X-MC-Unique: jpnbDk-KPdG91ZwVSLakrA-1
X-Mimecast-MFC-AGG-ID: jpnbDk-KPdG91ZwVSLakrA_1768409856
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7900fc7033bso20857237b3.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768409856; x=1769014656; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKuRRDfifIqTYZG+coIjtsQP5wXxl7wQXzkYS36Y1yU=;
 b=K8op/ye3G7JLUU1oCiJCRVYRSAJm3u4pwPPDvpFinXTHMbAwIbTq13M0+Vxg02j5oC
 iQmVT+ihti1S10kbOrzzcNa4fzH93wlwEzGH7QvEchmo+O6ZWiPKwD9G7gmb7hY6mSZv
 nmpmi00Bu1Xbb39FMNpNMZr2wvNDaUgYzpJkrluElbASja3l0PlWkT3KZcLylAT4thly
 ZdXtwv7SWILIFLAki7pqv86q1ZY2gJA41NpZklaL4LiDpbldoFTYgc1Ggbi6aOIZLWsk
 JxrSju4fYbg+M5PV8qB9u61rYdQ36yUzC6JCP7hoR48zTkNOWbep4YANsOk6rJ7e5RyR
 B76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768409856; x=1769014656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKuRRDfifIqTYZG+coIjtsQP5wXxl7wQXzkYS36Y1yU=;
 b=B0wJ0ZSgUsvZEqnE0lb5NfxOb+k+15hNBei3g4xdz7xJ1tHi9KlIXH7aO3SKgBmT1L
 5ocqWWa3spFLq5ZF8GFl/y0kkEWb99E7dcEZSmI+DXG1KjjG58NrTgOS0NY/+SJJAH8J
 FxuylD6rNlsYqjZOAaQd/UHHLCVftfOPYlvvFF72LSMSQyXbJK5iJBbKUmOFcAD6hX7G
 WaipwdYir3/HWLzQjcvypzWrNGI/WvyM2qCBQECqsCe/zd6RhAx2xIBD4adQEM0PIyxw
 9qWrkmb2az1+gw5/xemUlm28e6wAKNi5b6x9n3V3Llmtuw/6BPXUG3QDawmtgYhyEamT
 3iRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoHfFuO6MCIdCLc2TBT+319GuOnYkcSjDWX7RJK/ri7SZgAhgDWgEiAupo4B5pawg2nDZAB6l7mGQa@nongnu.org
X-Gm-Message-State: AOJu0YzkBYGcFWN8aAcHiyneeTg6vZAtqhMiFpooFvj2o5BDrTbrZtEe
 sIX4Ty0QojyzXz9YPA7DapJiccwX23makheX/BfNtzWCoFTZg7QCoTBqBU80RjGlf65ShP2jGJ9
 StomE7v85q2qxU/cGrngka+EAumWKFXilIaJuOriBDatu4cT/8jrqWa0s/9yHhPrD76RDmAz0hl
 AricM9d7W3unNqv9QmEPwbyfRmWa6RyU8=
X-Gm-Gg: AY/fxX5d/8251cmmUNgUiiZNI4QHLgUHeSoe8NvO869YkB/nKhXv1dAAchGAM08POkC
 PlvbyaqRqdBUDc6oYOea3jQOIaN7DCph6VDHjMXS9pwrv4CBN6pSxwVworDB62Cv2PNJF09UaRu
 sZj8kgLD1u6zEUEgQO21oFky/+Gnq3Y5T8XyKgjLhQLUI6Lr6DORxOo3eQrk9mmBa7S6c5VzVB4
 YN0ctc8cAhT98UUFM78bUDAXA==
X-Received: by 2002:a05:690e:1c1c:b0:644:50c7:a50a with SMTP id
 956f58d0204a3-6490a67e8f3mr67774d50.32.1768409855007; 
 Wed, 14 Jan 2026 08:57:35 -0800 (PST)
X-Received: by 2002:a05:690e:1c1c:b0:644:50c7:a50a with SMTP id
 956f58d0204a3-6490a67e8f3mr67722d50.32.1768409854047; Wed, 14 Jan 2026
 08:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-2-berrange@redhat.com>
 <750a94b8-2209-4c3e-bf69-761f33b0498c@redhat.com>
In-Reply-To: <750a94b8-2209-4c3e-bf69-761f33b0498c@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 14 Jan 2026 11:57:23 -0500
X-Gm-Features: AZwV_Qid4n2AqlKmlRUpXod7CIS5IZIvKw5T3UEL7UKXBXz5fDL3lna_5wU7nRA
Message-ID: <CAFn=p-brRTbhYHEs63Ubzw47-7wx3PwMX+RBaPFfpHROBiFyfA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] Revert "python/aqmp: fix send_fd_scm for python
 3.6.x"
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 13, 2026 at 2:17=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 12/01/2026 21.40, Daniel P. Berrang=C3=A9 wrote:
> > This reverts commit a57cb3e23d5ac918a69d0aab918470ff0b429ff9.
> >
> > The current code now only requires compatibility with Python
> > 3.8 or later.
> >
> > The conditional usage of 'sendmsg' on the async IO socket
> > wrapper will generate a deprecation warning on stderr
> > every time send_fd_scm is used with older Python versions.
> >
> > This has the effect of breaking the QEMU I/O tests when run
> > on Python versions before the 'sendmsg' wrapper was removed.
> >
> > Unconditionally accessing 'sock._sock' ensures we never use
> > the asyncio socket wrapper, and thus never risk triggering
> > deprecation warnings on any Python version
> >
> > Most notably this fixes the QEMU block I/O tests on CentOS
> > Stream9 that use "sendmsg" for FD passing, which otherwise
> > generate deprecation messages breaking the expected output
> > comparison.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   python/qemu/qmp/qmp_client.py | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

OK, please merge this with my blessing and I will worry about the
standalone repo afterwards.

Acked-by: John Snow <jsnow@redhat.com>


