Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3DDCCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6onM-0000iE-M3; Thu, 09 Oct 2025 07:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6onI-0000hy-Mc
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6onE-0003Ly-Is
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760009200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpxEn3UEP4Xb7v+tcbBKCwyxtSVv9RdkNju7y3cMBC4=;
 b=S2cbh5//6gtOwjn7Lety8vfm2HTQrL7Y1s1WrXqVXpwghtQSIar5QI5zvrdGIXdm0pD8JO
 +/QBILVLtuoTN3DnINs3aYXOWrsbsyC5X4wYtTYZSk4S8mLklGeFVbLFoziYqyPkXsSH9z
 +Gtl2XzO5dNGg27QvKnlpSpHZLr+vCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-3sIeBpZWOD-Pmq0tR8xn4A-1; Thu, 09 Oct 2025 07:26:38 -0400
X-MC-Unique: 3sIeBpZWOD-Pmq0tR8xn4A-1
X-Mimecast-MFC-AGG-ID: 3sIeBpZWOD-Pmq0tR8xn4A_1760009198
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee13e43dd9so539341f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 04:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760009197; x=1760613997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpxEn3UEP4Xb7v+tcbBKCwyxtSVv9RdkNju7y3cMBC4=;
 b=GIIoiuHxrj2jE58Kro73Vl5jdTDP77xchkuvdkYBS9naqKW/eg877U4NhFA2Elm7od
 IChigGt1tbVO5Zo5xOQh0G2Uyea2gwHIBuwLRwoG3wmW1w0jyztWv7jqYaTMyjTfE2P3
 xA+iw//ilXRg5NxOSJo80RnrtyBUmsvEvgcnPaEOMiH1EbCzOzEPnqJEtET9IIdx4Xkf
 3U4fJQhTInlNRqo3gT82CKQZ7wVBLV3CiTk5bFqmywyJ80gIQTQ9JiKcaqtRihx/kSRf
 V583/R0gaZxcYQs5Utu+NnGxWAxgQKRPj/ihR9dPrlXA/soBrqQ0O9VH9tDOkwOLTwBb
 wpOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkcaXs7FT3wQeDg/oM6q1+A+BXSTVOho0/t/PRZpqgHmqZv+t9LJYscTfi6oQ+9W9tzGuH9P1ygbYN@nongnu.org
X-Gm-Message-State: AOJu0Yw1HmNad67esnJsX27lVNttneJfe5hLbviDKuG+eRSgjAsNR4Kr
 t18oBn4dalbFa+1jPdshQtwoefjfe3/2uZDPZetfdJWJ/NdsSe9SVkYyceGavhGxykGDYODMJZH
 BgZnOUw5ufIHYF3FxelhcHWBV16uPyEZ/M2Ecskg0FE4s17jL4dYFoWLZoLGbon/DlKBFau6cIE
 NZ8Qf85tRI/4tC7jlnEdMeVNdr9Nl0lYvfetF+aF0LdQ==
X-Gm-Gg: ASbGnct7GgItd8sCvKUP0WvhRCTH5yabr8sIZODvWFipSIzsDmZYEIohyd5WNqo+jch
 fRmiHKM70cnurtR1IqMAWYiooRZ+VXvmy/s9FLP1jqAQB1UKGcqJTGaTvhMRLaAYuSo7h1ye+u+
 OWS9mgIi0lGowbBHlbx0Ylj9fYFbtwTrnjQZku6+BlgxFOj6r4fHLKEbfUnvdM0CAxJurH67AyI
 fPZzT6KcwfrcTO8q7JtCSPAVbN19g==
X-Received: by 2002:a05:6000:40e1:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-4266e8de003mr4428011f8f.47.1760009197121; 
 Thu, 09 Oct 2025 04:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9GRvlridBsD5U3JMULzfSf+SoZ00BKFyJ2VuqFRHx9Mtl4s/IHhl3mQWi3gdIblEM25qvxVnnk3OTnJRv8wA=
X-Received: by 2002:a05:6000:40e1:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-4266e8de003mr4427990f8f.47.1760009196695; Thu, 09 Oct 2025
 04:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
 <20251008175811.GB181748@fedora> <aOdpofyFVoYVQc3D@redhat.com>
 <CABgObfYx8V+mUm-1eaimMeBmXyFiiBLBKWNc23_+HFXXFFb5sw@mail.gmail.com>
 <aOd5IFgFZG91izxG@redhat.com>
In-Reply-To: <aOd5IFgFZG91izxG@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Oct 2025 13:26:25 +0200
X-Gm-Features: AS18NWC_K6h10hrWwAgRgc7aIjjc5hDPaQAw5JRXJN6FfIuPQdC8JnpUjPE8mcA
Message-ID: <CABgObfZkEOj8HoPa8WFDw-AjHgsGskPr_ct3EmSxJyWJB1K0xQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 9, 2025 at 10:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Oct 09, 2025 at 10:22:43AM +0200, Paolo Bonzini wrote:
> > On Thu, Oct 9, 2025 at 9:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > > I've proposed removing them in favour of meson rules earlier
> > > this year:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg04920.html
> >
> > I mostly agree with the intent of integrating tests with the
> > configure/pyvenv/meson infrastructure, but I'd do things in a
> > different order:
> >
> > - split part of scripts/ into contrib/scripts/ to identify one-off
> > scripts vs. what is really used in the build process
>
> IMHO we should rather aim to eliminate contrib. We should either care
> about the contents, and find an appropriate home for it in tree & have
> ability to install it, or they should live outside QEMU git in their
> own home.
>
> We shouldn't encourage a "dumping ground" for stuff that we don't
> know what to do with.

I don't disagree but we have a lot of scripts like that:

scripts/analyse-9p-simpletrace.py
scripts/analyse-locks-simpletrace.py
scripts/compare-machine-types.py
scripts/dump-guest-memory.py
scripts/get-wraps-from-cargo-registry.py
scripts/python_qmp_updater.py
scripts/qcow2-to-stdout.py
scripts/qemu-gdb.py
scripts/qom-cast-macro-clean-cocci-gen.py
scripts/render_block_graph.py
scripts/replay-dump.py
scripts/simpletrace.py
scripts/u2f-setup-gen.py
scripts/userfaultfd-wrlat.py

and a bunch more that aren't .py so I didn't check them; plus entire
directories:

scripts/coccinelle/
scripts/codeconverter
scripts/coverage/
scripts/kvm/
scripts/performance/
scripts/simplebench/

Separating them would be useful.

> > - move python/scripts/ to scripts/venv/, adjusting python/tests
> >
> > - move tests/minreqs.txt to pythondeps.toml. switch from pip to mkvenv
> > in tests/Makefile.
> >
> > - unifying the test scripts for all of scripts/, as much as possible
> >
> > - integrate tests in meson, but keeping the shell scripts for now.
> > move python/tests to tests/python. add a custom_target() to do "mkvenv
> > ensuregroup tests"
> >
> > - move tox usage to .gitlab-ci.d, placing tox outside the configure
> > script instead of inside. this makes the QEMU venv a "child" of the
> > tox venv rather than the opposite, and allows more testing than just
> > running the linters
>
> If tox is outside, that seems to require that we re-run configure for
> each different python version we want to run tests with, which feels
> pretty undesirable.
>
> There's the (system) python version that we want to run the overall
> build system with, and then there are N other python versions which
> we want to be able to run linters against.

I think we do want to check that configure can set up a virtual
environment for all those versions of Python. Then we can use the
virtual environment to run the linters too.

In fact I'm not even sure we need tox. Thanks to mkvenv, we would be
using "configure --python" as a much cheaper substitute of tox. The
only thing that is lost is the ability to test all versions through a
single build tree, but I'm not sure the complexity is worth it.

Paolo

> > - remove testing-related parts of tests/Makefile
> >
> > Only then I'd look at opportunities for unifying all the settings and
> > moving away from the shell scripts
>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


