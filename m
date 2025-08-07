Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE3DC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 21:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk8Rc-0008KZ-S2; Thu, 07 Aug 2025 17:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8RP-0008I4-M2
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8RN-0006uH-Mb
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754603183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33BiKZoJcHL7UF/G76qB++Xc8DI2mugrDy+Qj4VM8J0=;
 b=cVZlj3NS8OUMm2MIBaKxJEUzItD6AIHMB6POPPYtVVEuw338XKCWPeUCgU3i8sZlumantb
 LRVL/5Df366tyrUzGh66zcoB3gMRUlIOWFTi997C8Rt6kPkkhuw6Nw/UTQQK0Q6G07jdda
 eJelrqaM+i07gIO6UcAZ/134XACxfIk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-0CI9St5-PaSva5-qaX7mkg-1; Thu, 07 Aug 2025 17:46:21 -0400
X-MC-Unique: 0CI9St5-PaSva5-qaX7mkg-1
X-Mimecast-MFC-AGG-ID: 0CI9St5-PaSva5-qaX7mkg_1754603180
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4227538a47so1142640a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 14:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754603180; x=1755207980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33BiKZoJcHL7UF/G76qB++Xc8DI2mugrDy+Qj4VM8J0=;
 b=Lf2o2VUpWXdLTprgLPiGHqoTSguZWgFXGL7KK2BcyXif+zUksJBJNcuTLJSEl3kzi1
 VLig15qV4d0M0rPG8ufBnpyT3YvmVGUUb9H5sgZrGveiPwDMze+x33FFoFPRIN9kuCPP
 xtacJxR4JJS1WUQl5QJ5NGb+Z4ZKNOq9RitVQof0vlOaZkFUHc9OnVOpedqu17nXUBJT
 k4vbZOMMpa6RoL7d+l7e2d7QnhzZwfqjDQrDO6hEapPvgmbeFoJPIc+jqszBRqGxJfnX
 Z9q03ogTGr5eS9icYuRGqMp70h6maYpgHstHytkZZKE+Cb683ZSiuf213JdYKis2fg7u
 XO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEV88Ob5ym0HA0zbTRYi59+4RUUOJE+GWljFbby5FlRX9TM1yvZastC0l/KmxwrlC3yWRqEG0xuPmh@nongnu.org
X-Gm-Message-State: AOJu0YzoA/qxZWztA5MTD353KT6BadSnH0XTMZmNrPPJquKpfsoIaFAA
 EkMlnxNR6A50NVZI+WYioRLk5I8TdlWPqIVG3RI10MNJ6n/rVxNia/VQv0wPJAA3xEKQynvrlwf
 Mf939toPDrPg+TmwcBSIa5+u2OXEinhxhbvMh9IMLlHnsxVNz7mKnFp2Ls65GWcBOwdwOBLkQQy
 Gqld9an4LwzD2QF4JduGDLle0ef6Y7D5g=
X-Gm-Gg: ASbGncuemImqTuD61N6P2A9rlZjASE9gXKvzHAHlu663OIHti54IGBFAyzK8wbbS6mF
 F3P37grIUaXtlCyiNIItMw0Nbe4P//Hw6Gfa15Ozl8Id5Mh71G0sDXdbD1xSSB+gbv8TnmpdTKi
 Jmejbi2yR6aLyfjb5jRnBgQsC6HLevDe82NgaHoS8cPiAXRCO5JvtP
X-Received: by 2002:a17:90b:1f84:b0:313:b1a:3939 with SMTP id
 98e67ed59e1d1-32183a079c3mr859842a91.15.1754603180436; 
 Thu, 07 Aug 2025 14:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNXabEPtDpc8phSm60XcxkJGIBHHb2g+USCKP86Y6akOLAARqi8lSxyu+96rVdTDioQEVaddThEWHBo4fQmbg=
X-Received: by 2002:a17:90b:1f84:b0:313:b1a:3939 with SMTP id
 98e67ed59e1d1-32183a079c3mr859820a91.15.1754603180086; Thu, 07 Aug 2025
 14:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
 <f208a06d-2dfe-4cce-a848-938b3e3b6a31@redhat.com>
In-Reply-To: <f208a06d-2dfe-4cce-a848-938b3e3b6a31@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Aug 2025 17:46:08 -0400
X-Gm-Features: Ac12FXxbBCQdRCavY2f_yYs_CRipH4EIwduS9TxYrlf1n5QybBCrF5ho8UhVOMM
Message-ID: <CAFn=p-aZA0_DhBEFohK6TS=xev459S2YGPm9N3X5w+QDi0noEA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Thu, Jul 24, 2025 at 3:47=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 21/07/2025 22.38, John Snow wrote:
> > On Thu, Jul 17, 2025 at 4:44=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> ...
> >> Am I holding it wrong?
> >>
> >>    =E2=9E=9C  ./pyvenv/bin/python ../../tests/functional/test_aarch64_=
virt.py --help
> >>    Traceback (most recent call last):
> >>      File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/=
test_aarch64_virt.py", line 16, in <module>
> >>        from qemu_test import QemuSystemTest, Asset, exec_command_and_w=
ait_for_pattern
> >>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init_=
_.py", line 14, in <module>
> >>        from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTes=
t
> >>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcas=
e.py", line 26, in <module>
> >>        from qemu.machine import QEMUMachine
> >>    ModuleNotFoundError: No module named 'qemu'
> >>
> >> I thought the point of the venv is we had all the modules we need
> >> automatically available to the PYTHONPATH?
> >
> > As Thomas points out, "qemu" is special since it's already in the
> > tree. There has been some dragging-of-feet by yours-truly because
> > installing the "qemu" module by default when running configure
> > introduces a considerable startup lag time, and the module is not
> > actually needed for the simple configuration and building of QEMU -
> > only testing.
> >
> > It's something I want to fix, but must admit to being a bit stumped as
> > to how I will bridge that gap long term. Currently, all of the modules
> > we need are in the tree with no dependencies, so it can be fixed with
> > a simple PYTHONPATH hack. However, if I actually remove the QMP
> > library from the tree like I have wanted to, then we need pip to do a
> > real install and process dependencies, and this creates some
> > complications and extra startup lag.
>
> Wouldn't it be possible to add the module as a wheel in python/wheels/ ?
> That's maybe the easiest solution, isn't it?

The qemu.qmp wheel, yes, because it's purepython. The part I am
worried about is that by removing qemu.qmp from the tree, you cannot
just use the PYTHONPATH hack anymore to use the remaining in-tree
goodies, namely the machine module used extensively throughout
testing, because they will now rely on an external dependency.

Normally, you'd just install the in-tree stuff like any other package
and pip would take care of the qemu.qmp dependency. As handled through
mkvenv, it would search our vendored wheels directory in the process
and use that wheel, it's not a big deal.

The tricky part in my head is that this "pip install" of the in-tree
goodies takes a few seconds because pip is quite slow - it technically
has to "build" the package before it installs it, so it adds some lag
time.

Since qemu.qmp isn't actually needed to configure or build QEMU, I
thought it'd be inappropriate to add it to those dependencies - and
inappropriate to enforce a 3-4 second hit on every configure call
whether or not you intend to run tests afterwards.

I'm sure it's solvable, I just tried once a while back and hit a wall,
got distracted, and haven't revisited it yet... Maybe a good
rubber-ducking session would help.

>
> > Naively, I think adding a "just in time installation of testing
> > dependencies" when you go to run a testing command from "make XXXX"
> > might be sufficient for us, possibly in conjunction with a configure
> > flag that lets you pre-load testing dependencies.
>
> We could likely re-use "make check-venv" for the functional tests ... it'=
s
> already installed in that case. However, you then still have to remember =
to
> call it first before you can run a test directly, without the Makefile wr=
appers.
>
>   Thomas
>


