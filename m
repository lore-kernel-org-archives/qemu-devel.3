Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2015BE6C609
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 05:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tILdH-0000TX-3O; Tue, 03 Dec 2024 00:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tILdE-0000T3-NC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 00:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tILdD-0000zc-4g
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 00:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733204368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE09bRY3Z5qzF1yJsQpqXG7p20Ne+pVMiR4seqkx+tU=;
 b=EjNJdnq0CMabHtigfI4JqCylVX6izXHlAc84FEneMUYRh5IPD5muBViwR5S1yMkQeEtMN2
 R5jW8InM2J71YJgNVM4J606925RcAY/hWWuOPFtpj+bWaTtjvqXfxNwu3qnWvJ1hpLkjNy
 QtqmyahOc1r+dUEQzqNgGidhzijHgSg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-scODmEYSPvu9YXH9oztA3g-1; Tue, 03 Dec 2024 00:39:27 -0500
X-MC-Unique: scODmEYSPvu9YXH9oztA3g-1
X-Mimecast-MFC-AGG-ID: scODmEYSPvu9YXH9oztA3g
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d09962822bso3404196a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 21:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733204366; x=1733809166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EE09bRY3Z5qzF1yJsQpqXG7p20Ne+pVMiR4seqkx+tU=;
 b=vh1flYwdrw4qij81V+NbLoO9rZ9N5GNXWeEysDeRqS3mRZ9QmlUqFVT84/DqqZ7sgg
 M1UIbQW1DfQYgAhDwPbtNsihk2GUI03aJ+Hb0XDAXRFghcfTiWzBQSPTiEC1TU0TpTdW
 2OP/oB02BsPGG7ZqtRhAJa4am2Vll1YaLGmUmmO4E2tCZtwz6wCERhN0jbxA9f0q45qr
 ot/JaobtF3lXJT0qNg/rAfa1zzxps5I9tLL0FHLktYfpNK6UCsUu6YQM9BkO3wXFiL+W
 PNrDovxhy4zIS27qNS8MhM67b+wu2AMBFgmMEcb1hEi7Rpa5kzXSK3riO9WrHRK4N/Yd
 BCdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM3khcrJlgO1IDusIQjhbeNazPyqVDdLauNRoUcwmFmti4hLtb7yrfh5mO+dJPrkgZyN8+chP6jhQx@nongnu.org
X-Gm-Message-State: AOJu0YxI76thwQimbEVVmUhDKewnJIzDeIsVfpbqZ/m5ngnRqDJSLQYn
 h03feYS1IMs83l7qHtYprm45jL20mhT2LqXicYAVAP4Z1UWH09RNAQz6Ke7xFkGXbgzOhV2ddAE
 C0M65K9/Wt16gI60f8kdae6wk4vHEkdsQhRMvlE3RmT4JVHhwrxdIPAUcqz6aiLESW8Zfgf6cov
 wbcx/RJpNRiVfeG63UFn/n0NdTOd0=
X-Gm-Gg: ASbGnct36X4levleD3eof3OUmhV1EcjhzvUvPkNapsjebBw36qwhMvIXxnAAD3PCBj1
 4URmJo7cZiBj8cu4uYLgwSfwCnnZJDI5Bkw==
X-Received: by 2002:a05:6402:40d5:b0:5d0:ca24:916b with SMTP id
 4fb4d7f45d1cf-5d10cb55ae5mr826791a12.11.1733204365891; 
 Mon, 02 Dec 2024 21:39:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8pNwALeCTEieiqOP146Lzeq3pcKzFSKCCOHYOfNAp5E+oZl75IguDkdQSwIfzgbEECsoTBLUG3BgnAL6bS7c=
X-Received: by 2002:a05:6402:40d5:b0:5d0:ca24:916b with SMTP id
 4fb4d7f45d1cf-5d10cb55ae5mr826771a12.11.1733204365521; Mon, 02 Dec 2024
 21:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-12-berrange@redhat.com>
 <544db3ce-f37b-4c09-85f5-b6ad96708292@redhat.com>
In-Reply-To: <544db3ce-f37b-4c09-85f5-b6ad96708292@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 3 Dec 2024 11:09:14 +0530
Message-ID: <CAK3XEhMJLQ9TE+_pGHk=bkyV6GsDbC15VTavKgWHs75j7=7Big@mail.gmail.com>
Subject: Re: [PATCH 11/22] tests/functional: switch over to using
 self.data_file(...)
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 2, 2024 at 3:02=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 29/11/2024 18.31, Daniel P. Berrang=C3=A9 wrote:
> > This removes direct path manipulation to figure out the source dir
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   tests/functional/test_acpi_bits.py | 22 +++++++---------------
> >   1 file changed, 7 insertions(+), 15 deletions(-)
> >
> > diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test=
_acpi_bits.py
> > index 4de5fae37e..948b134b16 100755
> > --- a/tests/functional/test_acpi_bits.py
> > +++ b/tests/functional/test_acpi_bits.py
> > @@ -41,7 +41,6 @@
> >   import tempfile
> >   import zipfile
> >
> > -from pathlib import Path
> >   from typing import (
> >       List,
> >       Optional,
> > @@ -122,7 +121,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=
=3Dtoo-many-instance-attributes
> >       def __init__(self, *args, **kwargs):
> >           super().__init__(*args, **kwargs)
> >           self._vm =3D None
> > -        self._baseDir =3D None
> >
> >           self._debugcon_addr =3D '0x403'
> >           self._debugcon_log =3D 'debugcon-log.txt'
> > @@ -137,26 +135,22 @@ def _print_log(self, log):
> >       def copy_bits_config(self):
> >           """ copies the bios bits config file into bits.
> >           """
> > -        config_file =3D 'bits-cfg.txt'
> > -        bits_config_dir =3D os.path.join(self._baseDir, 'acpi-bits',
> > -                                       'bits-config')
> > +        bits_config_file =3D self.data_file('acpi-bits',

I do not understand, Where is data_file coming from? AFAICS its not
there in QemuBaseTest or QemuSystemTest or unittest.TestCase
https://docs.python.org/3/library/unittest.html#unittest.TestCase

what am I missing or failing to see?


