Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3938CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1A8-00050G-I2; Wed, 29 Oct 2025 04:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1A3-0004jr-RD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:04:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE19t-0003id-9k
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:04:03 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so3870334a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761725030; x=1762329830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Br8E+AWpSy3dJekVdYJJsvfvPRbB6v5tjS3jqJvZCM=;
 b=Le6R2HNSOn8tzkCYgsXKwp/v4gjAK9fJT4mRGGIwKARKf/tp2Plfw5pEKu7dMygCPZ
 822vtUroPvCSI+x12N3X9bcAMnDTN0rOVewqxk1vEWTEZv9nOdeOThh3MlBIPoPx3LjO
 JHU3SLWpKWAUfGqUOu0cJChV+rvCQOa5D3joPP0VhgnAWCluBIofRw8s+SoYcjmOg96r
 u/LGG4gjdp3XgzTCWAfTgtMtlGvlvTLjUz16fmgroPwYODqpXHrjlVj61bvcMPPqPt6m
 REyM/fnCPv+6U5KW9V76x41dwNb5PTz/oZgWkR0i3B4Z7nbn8vpEwpZyxETwwayn+bdU
 mFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725030; x=1762329830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Br8E+AWpSy3dJekVdYJJsvfvPRbB6v5tjS3jqJvZCM=;
 b=hg6BryM06AnjSf8oV0NE83TGiDXw+EEi39EAFcAoffg1Bi++DcgDQdWOujdXSUNDoH
 1XWwiwUohY+CTOE4/4j3rF5KmWifSlXKAdmm1LY9YwxGyjFLFUe5hC1uTw6WDt1bwJXu
 LoUio0bT9edyLZVsiNzXAzseqhv853X6EPuqGLriqfO6CGTWmw1j1qJ1eyJ537ZjRHQL
 U2M+jKfBRaQBcw633Icpw4FqAjQYCnolA71Uj8QZaKMswsfohpeNKfJGIVr6VvN8sh4i
 O7gImAwFwuBLPGqtvDxYT+hS/RoEKqB8BaVL810h44OmUK0VEKtrLSdXd+t1EwfyEpkw
 HX0w==
X-Gm-Message-State: AOJu0Yy7QRuend903IuzeJdtiza1pZADk8cQQDZY0wa9DgjiEnMEN3AR
 2tkbu+Y9BLemeBtmFFNs4r8q4A5CwB+r15e0pcQ0TMJYmR52aEVhsk97K4mWWGoYPgCpyJNOK43
 OPYh1fJ5VsI596inLQyDVfCZwRWeMzXh/SBiqtHw4Zg==
X-Gm-Gg: ASbGncvEI4A8RLAot9qgVktpD4qZY3f/qYRMUilrVCGlfICl8xYZGM9hf8016377Wm0
 X8/RhAklsUtI7fEnhFZ+3U05p0Tlp+38+aWkpiSqTiFoFTDGEs9G4Q9pvu8XSpmrHtVthu+c3cu
 qpM+OBXkJgS0DNjBc/VWKNQbqDkm7uwcQwDlwaQ3IPe642eM+od0u+WgceUsAjwMpYOUZfy+VOo
 jKG5km2PPOWcWSL3OWFasr1e+Ymrx8kPj+7Nyn/bOyrUSeXYk7kgRdzeGvS
X-Google-Smtp-Source: AGHT+IHxQ+sNjpcaC/jRVlw5MNECnJ34Mz24SAhjYMOtqlK2Wx4Imr3WPxk1XhGj0nwN9eM7DbkG0V3cFEDBEj4SeHM=
X-Received: by 2002:a05:6402:510c:b0:63c:3cd8:72df with SMTP id
 4fb4d7f45d1cf-640442518a0mr1516204a12.17.1761725030375; Wed, 29 Oct 2025
 01:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251028165236.3327658-1-peter.maydell@linaro.org>
In-Reply-To: <20251028165236.3327658-1-peter.maydell@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 10:03:24 +0200
X-Gm-Features: AWmQ_blTls_UGRPWmE-OSgb0IK5VvmHVKacCYih1qygsYquVT7XmsiC90wApj8A
Message-ID: <CAAjaMXYu3tL+8HTCQA5Fv_XaFTQStF2TQinGKyaqVp87M_Rugg@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/testing/fuzzing: Note that you can get qtest
 to read from a file
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, Oct 28, 2025 at 6:53=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> It is possible to get qtest to read fuzzer reproducers from a file
> rather than directly from stdio; this is useful when you want to run
> QEMU under gdb to debug the failure.  Document how to do this, which
> was previously only written down in the commit message for
> 5b18a6bf44b9 ("chardev: Allow setting file chardev input file on the
> command line").
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I got bored of looking up the commit message in the git log
> every time :-)
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  docs/devel/testing/fuzzing.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.=
rst
> index c3ac084311b..c43f815f320 100644
> --- a/docs/devel/testing/fuzzing.rst
> +++ b/docs/devel/testing/fuzzing.rst
> @@ -263,6 +263,15 @@ generic-fuzz target.
>
>  - Report the bug and send a patch with the C reproducer upstream
>
> +QEMU can also read the reproducer directly from a file rather than
> +from standard input::
> +
> +    $QEMU_PATH $QEMU_ARGS -qtest chardev:repro \
> +      -chardev file,id=3Drepro,path=3D/dev/null,input-path=3D/tmp/reprod=
ucer
> +
> +This is useful if you want to run QEMU under a debugger to investigate
> +the failure.
> +
>  Implementation Details / Fuzzer Lifecycle
>  -----------------------------------------
>
> --
> 2.43.0
>
>

