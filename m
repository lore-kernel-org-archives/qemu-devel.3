Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B19CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSdz-0007f2-0p; Tue, 19 Aug 2025 16:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSdt-0007eC-0q
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSdq-0004F9-OY
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755634149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mI2kca8nW62KXaJ/RZLWjNR3KNUZQNRZ+7RcDP8+avI=;
 b=PGK90ek1vb4++LxPKfM8LTVx06DxRxYIvYmfpLO9Nqu5C58yDgeMeoWheBihKD6ucO0/Th
 UoYObNCmCO7i3TdJI1ao2gjkGKUJWM0/iIw8pYOG2sET75aiHAf5ICHiuE1xJO0Zndqo5g
 fdJMseAH73Cz5gmj5OdFku/oLCaD8Jc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Nxsnr2PeNHuXJSx-DYO7Pg-1; Tue, 19 Aug 2025 16:09:07 -0400
X-MC-Unique: Nxsnr2PeNHuXJSx-DYO7Pg-1
X-Mimecast-MFC-AGG-ID: Nxsnr2PeNHuXJSx-DYO7Pg_1755634147
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-244581ce388so129579085ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 13:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755634147; x=1756238947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mI2kca8nW62KXaJ/RZLWjNR3KNUZQNRZ+7RcDP8+avI=;
 b=GUS43KmUaz5Q9XJAawtavSvwmhNcyRchbDTCOpUnx1a+tEBDc89vczF/eJcnkxQUG2
 cSrwfbxw/Eew1i8e2+txdg4dWKh2kUNOnQLuq+ZOciXjebkSK0h1nQ/S26ZB1yijZLIb
 OHb2Gb7DWm1+SL4F7Hoc0Blj8gcDS5QNyWMchtrre5bB2xRUe8Z+MP18wjNKVkAlQBHs
 FglBMlvAeirblgcVkXNYiOLanhlWLrVDk29T7gsFHVOgzKDKHkxbnHBmG0i5nPJI7SXv
 uebXv9kvH6tQh8mGjTZOJAXHn4ZC/5qbe8f4RafBNlRVLKBkTYYqAQ8fUtIjw3kzyJMT
 RocQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDwTzsRnTvdmVnnUjGzzEmJFSKOqK0BP0ssZm27z1qTey0oiO4ywGFOXbzin02CXAR0O8teeuS7BHb@nongnu.org
X-Gm-Message-State: AOJu0YyD3xvKZGDole0lx69m1q0RQtZafutGy9xD0SwROrZ9wrxeYF6B
 bgwCGxq5SdVMU4T0m7fQzDGBY4nzafuU1A0UriuklUE14fzfHRphuYGFTiO8dbAVbSmY8j/CP9q
 pFBtJ79E7hgNy6xe+ik2FNIKmeVm2AViJHZI557yq+z9LcqvGkCXRHZze3o0YN1mumHZo6tJqje
 ZWxvPWXbBkuLe0f1IX2vr9jRNo0tZ/WYs=
X-Gm-Gg: ASbGncs7lV393qbHmOEV5m5DCIUgZ4e8u9eMOhxCX4py+ElHWLwQQ42TWbv/J+tnHEu
 m9bvaAv1lecXL93zVha6lWB3lhb07eLFvZcy/+W9efKZwtnR8Yvo1zL08bcJSQVC36J/JTWgWxA
 9WEYRYRjU3Y2e+XByuPm6rAhM9AACaTI3jJ0gd6VgKONYNHx0UaJKZ
X-Received: by 2002:a17:903:4b24:b0:240:1850:cb18 with SMTP id
 d9443c01a7336-245ef286179mr2246515ad.53.1755634146707; 
 Tue, 19 Aug 2025 13:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1gU11wY8kYvzq6LbFbKxhO44a1oB+j0XbXoOR2NcnWz2J04l+Zk7nei6ltkIKMtmylRe7qCuHyH7gkLGVqZQ=
X-Received: by 2002:a17:903:4b24:b0:240:1850:cb18 with SMTP id
 d9443c01a7336-245ef286179mr2246335ad.53.1755634146411; Tue, 19 Aug 2025
 13:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-11-berrange@redhat.com>
 <05525b99-030b-4e6e-a7b2-c2086a799d33@redhat.com>
In-Reply-To: <05525b99-030b-4e6e-a7b2-c2086a799d33@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 16:08:54 -0400
X-Gm-Features: Ac12FXzxGQ8gOSXv3QKTL8qcENxxxd174Oc_Du4gZekd38YUgyQOFtfkPGBZxMw
Message-ID: <CAFn=p-bQmkd5-mqK5eyJ3z1vsBLtz=w=kwy2-m_gM-15sxk9-g@mail.gmail.com>
Subject: Re: [PATCH 10/14] functional: always enable all python warnings
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 11:15=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 15/07/2025 16.30, Daniel P. Berrang=C3=A9 wrote:
> > Of most importance is that this gives us a heads-up if anything
> > we rely on has been deprecated. The default python behaviour
> > only emits a warning if triggered from __main__ which is very
> > limited.
> >
> > Setting the env variable further ensures that any python child
> > processes will also display warnings.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Looks like 8, 9, 10 already got merged; skipping.

> > ---
> >   tests/functional/qemu_test/testcase.py | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/=
qemu_test/testcase.py
> > index 71c7160adc..2a78e735f1 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -19,6 +19,7 @@
> >   from subprocess import run
> >   import sys
> >   import tempfile
> > +import warnings
> >   import unittest
> >   import uuid
> >
> > @@ -235,6 +236,9 @@ def tearDown(self):
> >           self._log_fh.close()
> >
> >       def main():
> > +        warnings.simplefilter("default")
> > +        os.environ["PYTHONWARNINGS"] =3D "default"
> > +
> >           path =3D os.path.basename(sys.argv[0])[:-3]
> >
> >           cache =3D os.environ.get("QEMU_TEST_PRECACHE", None)
>
> Acked-by: Thomas Huth <thuth@redhat.com>
>


