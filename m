Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C88C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jOP-0001UL-Dl; Wed, 16 Sep 2026 02:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x6jOG-0001NL-B8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x6jOD-0005im-Mm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789541103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IT2q7r9au3xZq+R/8gZPqbsODSa8o5IufkD4WhoJESs=;
 b=R+hKrgAFBl05HR3S6cALpIX6aQOyG5W0pkYZH4+HJoPmngkRKjwIlwOK2MWI5vmoRI2PpV
 O3Uu1J4WJZKYSrBmjwpQ+dLvzSDByo9kbsRGET5pbksK5cHNN/B0s8/NviLBz4414y4MMb
 XTD+QyHw4NqAf6oipZO028PZVcdYq2s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-AU_HUj1SMpCUdx8KRkprsQ-1; Wed, 16 Sep 2026 02:44:59 -0400
X-MC-Unique: AU_HUj1SMpCUdx8KRkprsQ-1
X-Mimecast-MFC-AGG-ID: AU_HUj1SMpCUdx8KRkprsQ_1789541099
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b80835d5so6718863a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 23:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789541099; cv=none;
 d=google.com; s=arc-20260327;
 b=NlFA6229mlCjGaQpzqNikI93HjEFF+sY//AxbQZrBo3IUJtCe+Qlajvsmvi+vGF/df
 F+26j+dmbaRkv3DB4VOp6FAr3w5DON0srONC09s3QRqqLx2V8THU2lrdK44i/KIMbg/Q
 AilwOU4sVNuFV7efB7pLeRoybn2c/fuSoTgFo1hCB3+hD4euEclRMFzn5Tqzg8s27RBl
 deL1GZbzYLgFDsvqb2cNh2NrUjOnn2qfz/2ohR2JzCh2XBkHOuHZkWbhi/khMJmZ5CzS
 N46w2Osk2R8aVmZTrQxSXyPMR5qkbRckFzM1TN19YMDm60Kio+Oqz4imaunA1r6LlO5h
 JsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IT2q7r9au3xZq+R/8gZPqbsODSa8o5IufkD4WhoJESs=;
 fh=WMoLIo0zT//p3Nhbl2OdoA2aLbDcQ3+SGDsfedwbmac=;
 b=jQQPFHmhVLZB0hS0Fpi3aTUFsLS6F26lyBEwAVrLtkAhw4JA6bkYb0rp4/Ros4o5Zn
 nJ9qa9+eyDPVeOBsuZHKBddyy0XorgAuZJviil0a1ix7xk7/NqTnSQBUjdCqrnwXUQDN
 Jw0nF4avvEdimSj+ucSccCB8/q2ho0ikftDBA0OwUDIaX5tBN1bofS7K1vkx37GRcN4D
 LNU/Usi5oaCnrFUF3ed2Zw8aoNWnmhEMvozzpLd8nzwlFT9I6/sPI0kFcQa/Lml+eXPX
 Me4oCmU6wXfMYWtJCrHuemoY8uXDhNjBoaF0BgyEGNPq4eLPZ4RCb8p6wB77Av/5I8VW
 ZFCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789541099; x=1790145899; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IT2q7r9au3xZq+R/8gZPqbsODSa8o5IufkD4WhoJESs=;
 b=TtLbUDGcRvOGgHZa2P/NsDw50E0DVSwqB7Z9m3lxhkxafLA3ZugipBMW18pUg9jAvM
 VekC3bzOAtRisyEUXtakNcmKmC225YH7iGemDbG125mcNfl2c4lpYqpdRjzA0y36xldi
 kqaLm3s7++6g83V96vdSgOcJFuFEaMnXlcRqs/TnjDlvkMDGvJ5c05TrLBBgpAwebqMk
 p51s4cTJGf0Qcu6H2Egx1+3dt3qWWw1LzX3QayWxUbdyqtmNPmwcQTMtvHUT3s/llSrw
 bNtuPpPgJFZoIDidyzybVyMmXA7HVrXIrugWO5HNgtXFh6yefk0b36UVv/CRPXCpFpsK
 BcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789541099; x=1790145899;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IT2q7r9au3xZq+R/8gZPqbsODSa8o5IufkD4WhoJESs=;
 b=C3c0I0zFCcyEPt16UFKifNNOiqFbqC8OUNqPO6X24wep9vEPAqulZhC3uQ3iXtt3IL
 PKHBj4otTtCsyb7VMvJF3t79zU0EUReTuAnJQYtUEXqFNQqYADADexlWgCVYBXnycjHJ
 Wq1mqP0gAkZN5EAnpi/v3Ga2qa710LtVg9ow1Tw/maxkq57ZbX+kjyFgBni4ZHBYSTvs
 Hj0vv91QEKZ4OZ2jDbEr0WFtwmYJv8ioAd1ptlfHWZRHap3Bil+h7AXIvjg+OkgB/mhe
 MmfEnENpjcOgv7ZpL0me7aH0jIU6XQWQpQQoi4Ewn204qUu6ZvnDietlVZvt59mX5uO9
 SZhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwty4LExi9lBgpHsbb4Sm3ENKg5QtBWmarFgTsGUAvdnQNAKs1Tnd4yIts6zoD+8nwfDWUAeLMoZGkv@nongnu.org
X-Gm-Message-State: AFuF++m0Z5dwXtk/+mnxLCID1YWiUbsiehq6Tzb1JPfbWC+Sq2GkNZ/F
 Uyo8FRZUTeAjLxGANVGMonuMXLrx+Tmia65zLdfWBLz2jKOjC2acQ9441i+UYI3c4EBJdmYwQpn
 xE2l41qskkgyV8LEo0wiuMO6uZK7MN4v3QORCa33WcncUC0j5+RsFJiDuYQmz3ooIpZKE5qq6Mo
 yPAXnCHjay/fKTiIY8gaML95vHxl5CDKw=
X-Gm-Gg: AYBFou0eke6AWtHsSK+0q+jxx3dS12kSN4flpYEe6h9feYKhVXhRO9IqMgufxh77Nqh
 yuL40InwbtetBq/7tKlak7twK6ikOXDKs+JRU9VQckVDf3//L6pp77s+PLceiWNvEAvTKmp2rqA
 T/i1fCCe0lqP7GOrg8RGVIkB88kV2TbPrfnexHwjLhRg2b8TFXQ0/K46eWWymOyKWT98sIyBqvT
 CuLwOGl+ghGan3VJUFgy5OEraFuz2NfoPhWS0DA6ulE/xJUbb8CxDYCA0fGbmg0AWnqoYThNNUs
 ag==
X-Received: by 2002:a17:90a:a8f:b0:39e:234a:f071 with SMTP id
 98e67ed59e1d1-39e234af2a6mr1665263a91.19.1789541098688; 
 Tue, 15 Sep 2026 23:44:58 -0700 (PDT)
X-Received: by 2002:a17:90a:a8f:b0:39e:234a:f071 with SMTP id
 98e67ed59e1d1-39e234af2a6mr1665242a91.19.1789541098272; Tue, 15 Sep 2026
 23:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-11-den@openvz.org>
 <e22f13f9-5cfa-48aa-bc37-bb9bb2d1c5ba@redhat.com>
In-Reply-To: <e22f13f9-5cfa-48aa-bc37-bb9bb2d1c5ba@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 16 Sep 2026 10:44:46 +0400
X-Gm-Features: AcwNN1X4exfFwyqGmQBGKZvYg5zyoQOvVPQIEe5qpCRzZU8TTx5FjFDpcJuSOQM
Message-ID: <CAMxuvaxQ5OnE3pGQpwaJzTK=ELMZr=3W1QzMLR3wrsxPMjiPrw@mail.gmail.com>
Subject: Re: [PATCH 10/10] tests/functional: cover the BQL watchdog
To: Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Sep 16, 2026 at 8:58=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 15/09/2026 22.34, Denis V. Lunev wrote:
> > From: Denis V. Lunev <den@openvz.org>
> >
> > Hold the BQL from the main thread and check that the watchdog says so.
> >
> > human-monitor-command is not a coroutine command, so a write issued
> > through it runs to completion under AIO_WAIT_WHILE() in the main
> > thread, which keeps the BQL for as long as the backend takes to answer.
> > Point that at a null-co node with a latency ten times the deadline and
> > the hold is both long enough to report and short enough to end on its
> > own.
> >
> > Arm the watchdog after launch rather than on the command line, because
> > machine creation takes the BQL in bursts of its own and a deadline this
> > short is meant for the hold, not for startup.
> >
> > Check the quiet case too. A counter that stops distinguishing a held
> > lock from a free one would report a hang on a healthy qemu, and that
> > failure is invisible to a test that only looks for the report.
> ...
> > diff --git a/tests/functional/generic/test_bql_watchdog.py b/tests/func=
tional/generic/test_bql_watchdog.py
> > new file mode 100755
> > index 0000000000..193dad15e3
> > --- /dev/null
> > +++ b/tests/functional/generic/test_bql_watchdog.py
> > @@ -0,0 +1,60 @@
> > +#!/usr/bin/env python3
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Test the BQL watchdog against a main thread blocked on IO.
> > +#
> > +# Copyright (C) 2026 Virtuozzo International GmbH
> > +
> > +from qemu_test import QemuSystemTest
> > +
> > +deadline_ms =3D 100
> > +hold_ns =3D 1000 * 1000 * 1000
> > +
> > +
> > +class BqlWatchdog(QemuSystemTest):
> > +
> > +    def setUp(self):
> > +        super().setUp()
> > +        self.set_machine('none')
> > +        self.vm.add_args('-nodefaults')
> > +        self.vm.add_args('-blockdev',
> > +                         f'driver=3Dnull-co,node-name=3Dnull0,size=3D1=
048576,'
> > +                         f'latency-ns=3D{hold_ns}')
> > +        self.vm.launch()
> > +
> > +    def arm(self, ms):
>
> Maybe it's just me (so feel free to ignore this comment), but when readin=
g
> "arm" I'm thinking of qemu-system-arm ... maybe call the function
> "enable_wd" or so instead?
>
> > +        self.vm.cmd('qom-set', path=3D'/machine',
> > +                    property=3D'bql-watchdog-ms', value=3Dms)
> > +
> > +    def hold_the_bql(self):
> > +        """
> > +        human-monitor-command is not a coroutine command, so the write=
 runs
> > +        to completion under AIO_WAIT_WHILE() in the main thread, which=
 keeps
> > +        the BQL for as long as null-co takes to answer.
> > +        """
> > +        self.vm.cmd('human-monitor-command',
> > +                    command_line=3D'qemu-io null0 "write 0 4k"')
>
> HMP has recently been made optional, you likely need a
> self.skipTestIfNoHMP() somewhere now to make sure that this test does not
> fail if HMP has not been compiled into the binary. See also:
>
>   https://gitlab.com/qemu-project/qemu/-/commit/6a0195cd57b231c2047232c8

Better yet, use QMP, amd x-qemu-io.
thanks


