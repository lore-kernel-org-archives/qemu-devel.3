Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA9AE6C61E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOqe-0000ih-7C; Tue, 03 Dec 2024 04:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tIOqc-0000iR-BE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tIOqa-0008Jn-CZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733216729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqC84tCfRcU5j1vKHVK2+Laze3DjuCpNWlq6y+7XpjI=;
 b=C5ah7BAcEzhGaVkvn4VWge5HXiXvbUs6xO5xwwWBKXQ3ZRqaK2z2Eu8O/gbvyL+CAv2Jal
 0956inqnPVi9qWH/G5pHqfDMBjAN8R6vAb09UGHuYc0AhKSIZMlppid1m4lKX4y6pVNSdJ
 XAmF5MCBL1Lv+xh5EI+2akTBDKqvLpI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-IgBdJIwLOiazzeFuvfkJ2Q-1; Tue, 03 Dec 2024 04:05:28 -0500
X-MC-Unique: IgBdJIwLOiazzeFuvfkJ2Q-1
X-Mimecast-MFC-AGG-ID: IgBdJIwLOiazzeFuvfkJ2Q
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa50cf10593so368367666b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733216727; x=1733821527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqC84tCfRcU5j1vKHVK2+Laze3DjuCpNWlq6y+7XpjI=;
 b=kE+/d/MvbkL5ppf7R7go7FrdkvgWsu82cm6i0XyNYWEFgNZbSa9tINK0/yfTu74SDd
 kggI6OMykedzSoV7c1wB1xy+ArvCla5lob3fy2Pp3L3lYJj0X3ZOHVpK7nXJHf94ZizI
 L+IXx/YK0jByNcIHjY1l94Rsy/7xjTHW+1ZLn4Lkn7QZiLnjzQNtbrc9JHTCNcC+tpyb
 jM8+NYNGWhgWCNQKOfHjbwwQFEJm4OrgkZBD+I6hKyqdRkza9e8F7E/peGI1Objn8b2+
 g32ZjU9MguBmkr1fY8ILRDqMPnhLacV79A+/R5nRz80Z1Nng98YhttEcG9zuWvSCQYvj
 P1gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBaDjIY/zj+YJYLmixWuKQezEIVR87RHXXFPX3wHbibz7pHuUsLX9OT4VIPWaruN56one8fkOrsIPo@nongnu.org
X-Gm-Message-State: AOJu0YwmdbFnC6hXxxYtB0NhKfm+UGQCLWUcIMgbsg8LZ/TwenrfGD9F
 JwTAoJciCVAltsZi5qhudGPgG0BsJccDPm93OXA40rfkBG5/yhn7rwvyuA3Nd0m9Ot2g5GXz9bb
 n7l0oaaeUq2sjHZRPw2tOOIRPedmKIBiVs0ERLRRpzThNUYUqWhglWTMg85+388f0Lcag5GQSil
 QUGJBsSIxfbQ+KKUeTYDrjZnNcFokVHZIxpmiRzg==
X-Gm-Gg: ASbGncsiy/tyH+pQUKXC6Fpx3rdyfg0O15g4V4bf+lgBrnc62Y6SH1AHyRjba7hprPz
 LWGZDv4TeRjAKKsNqCZAOJjFoXpMZs0752w==
X-Received: by 2002:a17:907:a08:b0:a9a:835b:fc8e with SMTP id
 a640c23a62f3a-aa5f7f3c3dfmr156215366b.54.1733216727194; 
 Tue, 03 Dec 2024 01:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoShn3X3F2LmvRV2WdlMdbhdai70KHx+hRhzpK2yJ+cDFi3vxcqz4P25idAtbB5ZeV5Wct4/kE0EWR9IoXteo=
X-Received: by 2002:a17:907:a08:b0:a9a:835b:fc8e with SMTP id
 a640c23a62f3a-aa5f7f3c3dfmr156213666b.54.1733216726799; Tue, 03 Dec 2024
 01:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-12-berrange@redhat.com>
 <544db3ce-f37b-4c09-85f5-b6ad96708292@redhat.com>
 <CAK3XEhMJLQ9TE+_pGHk=bkyV6GsDbC15VTavKgWHs75j7=7Big@mail.gmail.com>
 <Z069ThRGuxIH1YVt@redhat.com>
 <d721668a-3865-4846-ac00-bba1e55d37ab@redhat.com>
In-Reply-To: <d721668a-3865-4846-ac00-bba1e55d37ab@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 3 Dec 2024 14:35:15 +0530
Message-ID: <CAK3XEhOBufMCS9ovchPFSVS9M8g50RipaOMowMeUwrcMN19-yg@mail.gmail.com>
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

On Tue, Dec 3, 2024 at 2:20=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 03/12/2024 09.11, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Dec 03, 2024 at 11:09:14AM +0530, Ani Sinha wrote:
> >> On Mon, Dec 2, 2024 at 3:02=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
> >>>
> >>> On 29/11/2024 18.31, Daniel P. Berrang=C3=A9 wrote:
> >>>> This removes direct path manipulation to figure out the source dir
> >>>>
> >>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>>> ---
> >>>>    tests/functional/test_acpi_bits.py | 22 +++++++---------------
> >>>>    1 file changed, 7 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/t=
est_acpi_bits.py
> >>>> index 4de5fae37e..948b134b16 100755
> >>>> --- a/tests/functional/test_acpi_bits.py
> >>>> +++ b/tests/functional/test_acpi_bits.py
> >>>> @@ -41,7 +41,6 @@
> >>>>    import tempfile
> >>>>    import zipfile
> >>>>
> >>>> -from pathlib import Path
> >>>>    from typing import (
> >>>>        List,
> >>>>        Optional,
> >>>> @@ -122,7 +121,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disab=
le=3Dtoo-many-instance-attributes
> >>>>        def __init__(self, *args, **kwargs):
> >>>>            super().__init__(*args, **kwargs)
> >>>>            self._vm =3D None
> >>>> -        self._baseDir =3D None
> >>>>
> >>>>            self._debugcon_addr =3D '0x403'
> >>>>            self._debugcon_log =3D 'debugcon-log.txt'
> >>>> @@ -137,26 +135,22 @@ def _print_log(self, log):
> >>>>        def copy_bits_config(self):
> >>>>            """ copies the bios bits config file into bits.
> >>>>            """
> >>>> -        config_file =3D 'bits-cfg.txt'
> >>>> -        bits_config_dir =3D os.path.join(self._baseDir, 'acpi-bits'=
,
> >>>> -                                       'bits-config')
> >>>> +        bits_config_file =3D self.data_file('acpi-bits',
> >>
> >> I do not understand, Where is data_file coming from? AFAICS its not
> >> there in QemuBaseTest or QemuSystemTest or unittest.TestCase
> >> https://docs.python.org/3/library/unittest.html#unittest.TestCase
> >>
> >> what am I missing or failing to see?
> >
> > It is coming from patch 6 :-)
>
> Sorry, my bad, I put Ani just on CC: for this patch here, but he was not =
on
> CC: on the others :-/

Now it all makes sense :-)

>
>   Thomas
>


