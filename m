Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE19DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfnrd-00007J-Tm; Thu, 29 Feb 2024 16:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfnrb-00004s-0X
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfnrY-00024K-7G
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709241755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=it+CtIQlk3o18x+CJIDj+Q+OorEziAbyIrIFFTk6w2o=;
 b=BRjwVYmNy7d23BM8S+63cubJrS3lgtA3TEfuzoYOaq3SMcQeDVhcL2n6ImtjNegNogUp0r
 1PY7ENsqVjHDc4ZxE7zJkdPj5aQ5u8qP7RxL/dGu3g1BKie7RHbXNia9E7ZdQt5Lth2Zwy
 kE6iUcS8vnoJ8imU48/jk0ZGF6OHz1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-oCAjYNcwPx6Z90mtuYdTww-1; Thu, 29 Feb 2024 16:22:32 -0500
X-MC-Unique: oCAjYNcwPx6Z90mtuYdTww-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e1d994f53so3623f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 13:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709241751; x=1709846551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=it+CtIQlk3o18x+CJIDj+Q+OorEziAbyIrIFFTk6w2o=;
 b=uMoc5BEaPRIx79WPUGczmzbsoeE0dHpGc3Sj6+8VHuZMzPLMK+zCcDm7nU0PjAmNpB
 dNCli8q04J70BgCStU7SYaA3jx3FSrwtBDOvkHTO+3xhDM6PX8jOUIl7P8k11UEAbJel
 9kVIi95UN3AEcbNLHlSvt/IGVgGgl93w6H3jANzeRzEeLUzNu1E707P/BRcT/INXRSq1
 TcGrc8TQyKY2zF9QObMnqdRl782HKH+8cBsL5/LHiPM9mVSx2Hg3MDvStDzVUTtF3xLD
 nchdVjXuHQoesyslFdRr6sbUi6Ryxkxc59kjGbnvECcFnEfHOxXM1Yymp5BkMKV96v5Z
 I/yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFOGB1U6YQeTJQr14yEelovU/uoYYPESHuolmAnKW5UhTDhSh4ptW39DQhtLyfiKRgTEjyKGHmRpCl1OtjVVZHCcAY/sE=
X-Gm-Message-State: AOJu0YwQVFhqgd7M4EuwZE1+AXAePaWRC11L0+ITc6+MHPw91Lq0T6eI
 HwMzUiDz9vwy49FstisJUF7fvCVLacg97AQPq96rXDkdvzSgh0thVMI5i5ebHarah5zkSZfSWGi
 5nid/MwK9GSSM96Je2tNnhGlMxUpIByNlEHsWvySjKht6/gvvEN0ZFPHVrNYLUD5Aq0SjUOIK7G
 iWW7jDU97+oJOQO7MVcW9hMm00KvE=
X-Received: by 2002:adf:f709:0:b0:33d:f1d4:37eb with SMTP id
 r9-20020adff709000000b0033df1d437ebmr144699wrp.9.1709241751703; 
 Thu, 29 Feb 2024 13:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvi3jGwM/lBbzoM5IZuDl/TVwHG6MCPJLzBrd6GEHpgM07EZyh4G+/JsWe8GT40HF+2/mxx9pPWsWRX7bF1KE=
X-Received: by 2002:adf:f709:0:b0:33d:f1d4:37eb with SMTP id
 r9-20020adff709000000b0033df1d437ebmr144695wrp.9.1709241751338; Thu, 29 Feb
 2024 13:22:31 -0800 (PST)
MIME-Version: 1.0
References: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
 <87frxb6w5m.fsf@draig.linaro.org>
In-Reply-To: <87frxb6w5m.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Feb 2024 22:22:19 +0100
Message-ID: <CABgObfbj4RvVw=WtKx3qDQSK74-KzqPuawVhfwHFasUshREByQ@mail.gmail.com>
Subject: Re: What is the correct way to add linker dependency to QEMU build
 system?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paz Offer <poffer@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 6:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Paz Offer <poffer@nvidia.com> writes:
>
> > Hi,
> >
> > I want to add library 'libdl' to be linked with QEMU build for a partic=
ular target (e.g. - qemu-system-arm).
> > Using meson I would typically do 'compiler.find_library(...)', and late=
r add the returned dependency to the binary
> > dependencies list.
> > However, in QEMU I understand that these configurations are done in
> > the './configure' file?
>
> No I'm pretty sure all the library finding is done in meson now:

Yes, indeed. The documentation lists the tasks of the configure script:

- detect the host architecture

- list the targets for which to build emulators; the list of targets
also affects which firmware binaries and tests to build

- find the compilers (native and cross) used to build executables,
firmware and tests.  The results are written as either Makefile
fragments (``config-host.mak``) or a Meson machine file
(``config-meson.cross``)

- create a virtual environment in which all Python code runs during
the build, and possibly install packages into it from PyPI

- invoke Meson in the virtual environment, to perform the actual
configuration step for the emulator build

Anything related to 1) building executables and documentation 2)
installing is done in meson.

Generally, non-Meson parts of the bulid system are limited to stuff
that has to be cross compiled. The exception is
contrib/plugins/Makefile (which I mention because you might be
interested in it as well), but that's just for documentation purposes,
so that it can be lifted out of the QEMU tree and used to build custom
plugins.

Paolo


