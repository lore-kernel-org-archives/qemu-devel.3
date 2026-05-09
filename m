Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83547CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLixX-0003Be-65; Sat, 09 May 2026 10:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wLixV-0003BV-D4
 for qemu-devel@nongnu.org; Sat, 09 May 2026 10:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wLixT-0002rm-9k
 for qemu-devel@nongnu.org; Sat, 09 May 2026 10:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778338029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+kItUMALMrVfS3dpS21UMuCChUOQfFK9xIiVko4lL0=;
 b=Hw4zO8wmaufFTRF4oSv+MppBPX8ckRjen2SXH/jnRwYeJOnx0xR7c6MrMGoI0NEc5wFxRM
 cfnmvVeJJGaBlDGNZHO582aqTK1geb9VO1Cvb5B2Uog33h1ml1PwQ0QMccbosMD9t3FlTc
 +zECL2gByVmx+L/Br/tyozr+GtyaThc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-NM3ayIAwNoKJnAS5uOVhlw-1; Sat, 09 May 2026 10:47:07 -0400
X-MC-Unique: NM3ayIAwNoKJnAS5uOVhlw-1
X-Mimecast-MFC-AGG-ID: NM3ayIAwNoKJnAS5uOVhlw_1778338026
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c82726f7b0bso260596a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 07:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778338025; cv=none;
 d=google.com; s=arc-20240605;
 b=Q9bqPXHpm0NOY6QEuUOPo1M16cGmd/OAT8DId2Y1rQnyOhAdkhQw0vrb4wAFf8wgEN
 sLxd+m+Nf0iUL63bxn177PljndoeG/1qh6tbR08YWJAjM5PbBwsqhJA4kZvM+FJwPCGA
 YwUKVGGZKzWupn/SAtECCXVxyaZ6H2vgf3bd5qTCSyanlugxXhJ6X+Pry1INcCewAn/t
 r5VtnLxRXeN9j8VysOBOBbSqsIv0vn62k4/2u9lJg7Dtl/hiG0JQ/NGPr5hyX/JKC/Fj
 UHQvegbGuL+xWELHEJ+1Nrf81YeJRnRRgmVWlfshJmL69pH4+wkhLhCLJmrPNo0BbiMh
 4fQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w+kItUMALMrVfS3dpS21UMuCChUOQfFK9xIiVko4lL0=;
 fh=02jnkWVY3rbSB8WszijT7jWeD6exb8TTJsZM0/CtVbY=;
 b=Kx4UwqE1AC3i8DRENSZwWPM5APJvGa2pZig7EbzQKnhqWvosaUJ/2jMVyXgXrBUGMG
 VLq0OewdtmrA54OkCovtdgakGFMCoKcJGc+59pqxYJub8vq+gpmWqjCyQ8xLjwEtRqrB
 oVhgIMpEZGDfKTRr+RiKI4JGGTHv524Ls8dZhG8SzTHfDbnRdskIOfB325zSDXs18sDk
 HWV2/b11kKmMP1yXf4GDllJ1TNsycNIW0GiBfOkZ4QrMvnd6yvZxyyGt8S5Vxzgy5geF
 aUp+EM4hrxBSdxuuOQpoF9fSk9gJxWNVBpojNoNKcwPF1WY8AizFmo+NbOaLXHJVmJtj
 N5Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778338025; x=1778942825; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+kItUMALMrVfS3dpS21UMuCChUOQfFK9xIiVko4lL0=;
 b=EaOzsAoVg53X1NQKxGwp3p97yaGXI0LceUhCplZUk2nl0OUlmh7HjhntvV4sb5GUpy
 RXFc/DaDYGAClHG+YXD56WvfjFL6ilA5VImQ87i/4Dqm/4C0KUGFm818k0/h5qolcSJo
 O4asAxfuTUweNtmbDILHcxu4fQa9RC/fYNmo7eHv5DUGXN0S5T662JYckOZThjx+3nlm
 i1gjs8eD/cg4yOqyyS3qHxV5pj4WmNtUXfQPBZXan0LFblBX74aRNGuDYB3FOlJQ+vDz
 qsZPRw5RvDtny/lyhNrGSt/IRILfOntUyAZMdBPPq7H5Q3IM284YRdhZV7IkhHl8vtri
 0P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778338025; x=1778942825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w+kItUMALMrVfS3dpS21UMuCChUOQfFK9xIiVko4lL0=;
 b=tL6lk4avKvUx4+fe4Fxro49LSjGOFgVtEf+gGEmqvnM+zH7f1v9E5aM6dEuW7nHfkc
 Zyi0D48vgykD1/f7RCwJv08/3/YI3NpsxTK3jhC7Qyawu6iektcrg7MQyh2fVHmFQIAT
 eYD8QUlUi4sfHbOVqZJIa06APes0+nvyz9TLq2FiMnpvdFNtHC536Dcnq8WGvtwJAbMS
 gAWU5ymgwf+7xaTWI/kJgUa68vM0g1nK8u81/C4TGQmMIJRnQWlvFSm5JY3WDTqBRDdq
 r9UeI3/MtMBotKjnM1OFn5PUGAlDNNup+FudR+RI3x1W0HHRBkRnIrzTJHrEPgblLrVv
 Yc6w==
X-Gm-Message-State: AOJu0Yx1826bI2NTTWHY6SCO/zlYtemotafLWsMhIb/KW2uUhtDc/wLe
 9vMhyg4GcIaLy8jl/d8bTQcWRUr57h2gy33qASNXA4ctGkkN08NOSA/S+VSLF+eIB7Idnvj9gDR
 7ICTehaIM8KX7ZDaROdYVLxZFwqcYxViRZllkSNCC1mRouSfQaZS76M/Nznfu5+BUEkFKAE77Ln
 vdEf8zU6BgLlH0LK7FK4CDNLxEpac6keFPnJ2ASl8=
X-Gm-Gg: Acq92OEMc147+oOwiHT0BCeoXxL0c5eyXEeV5vs1ItUyjQrv7r5mPEjKkQo/HlzeooV
 ASqMLhbkGlnhcq6VylZNeSjB1BHN+fYZopXE72as3//y1fLmDz7QVWYxAPQ8I9zLU4/P1hrR3uX
 Oz+AX1Lpx3Rr8QAxqnLaGslk5p3KP93gOaFUB9N53p2J6SvdOsuy2MJ+riFwbhMyD3+HmaaYjww
 px62GrLX2JUm/TAPV/AMHlXrUiZ5OIyL6dFEZNQRpwWq0MpbaDx2y6/jTkpnPcfgfaZ8LMo5qil
 HR491WM+DRpGyYJIi1iob6s=
X-Received: by 2002:a05:6a20:958f:b0:3a2:dabf:feed with SMTP id
 adf61e73a8af0-3aa5a72c4d7mr19394407637.3.1778338025328; 
 Sat, 09 May 2026 07:47:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:958f:b0:3a2:dabf:feed with SMTP id
 adf61e73a8af0-3aa5a72c4d7mr19394381637.3.1778338024856; Sat, 09 May 2026
 07:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260509094801.111103-1-i@uchout.moe>
In-Reply-To: <20260509094801.111103-1-i@uchout.moe>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 9 May 2026 18:46:52 +0400
X-Gm-Features: AVHnY4LbA4CoxRgogZOsXR0a5H8MDzohZe2_nRA8E1r3PmSpMzUDkZVSdLfErVQ
Message-ID: <CAMxuvayTSuoe5xE2y==B=vTbCGWrr2YMOgds42+7QD8BRdeWDg@mail.gmail.com>
Subject: Re: [PATCH] qemu-options: document -chardev dbus
To: uchouT <i@uchout.moe>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, May 9, 2026 at 1:48=E2=80=AFPM uchouT <i@uchout.moe> wrote:
>
> Document the dbus backend introduced in commit 3e301c8d7ef0 ("ui/dbus:
> add chardev backend & interface")
>
> Signed-off-by: uchouT <i@uchout.moe>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qemu-options.hx | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5566da41a3..59ff62aa7b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4077,6 +4077,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>  #if defined(CONFIG_SPICE)
>      "-chardev spicevmc,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPA=
TH][,logappend=3Don|off]\n"
>      "-chardev spiceport,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DP=
ATH][,logappend=3Don|off]\n"
> +#endif
> +#if defined(CONFIG_DBUS_DISPLAY)
> +    "-chardev dbus,id=3Did,name=3Dname[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
>  #endif
>      , QEMU_ARCH_ALL
>  )
> @@ -4088,8 +4091,8 @@ The general form of a character device option is:
>      Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub=
``,
>      ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
>      ``pty``, ``stdio``, ``braille``, ``parallel``,
> -    ``spicevmc``, ``spiceport``. The specific backend will determine the
> -    applicable options.
> +    ``spicevmc``, ``spiceport``, ``dbus``. The specific backend will
> +    determine the applicable options.
>
>      Use ``-chardev help`` to print all available chardev backend types.
>
> @@ -4396,6 +4399,15 @@ The available backends are:
>
>      Connect to a spice port, allowing a Spice client to handle the
>      traffic identified by a name (preferably a fqdn).
> +
> +``-chardev dbus,id=3Did,name=3Dname``
> +    ``dbus`` is only available when D-Bus display support is built in.
> +
> +    ``name`` name of the chardev as exported on the D-Bus display
> +    interface
> +
> +    Export the character device on the D-Bus display interface, so that
> +    a D-Bus client can connect to it.
>  ERST
>
>  DEFHEADING()
> --
> 2.54.0
>


