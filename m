Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC09E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdsY-0005Jw-Q4; Wed, 18 Feb 2026 04:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vsdsY-0005Jo-2Y
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vsdsW-0002Z5-2R
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771406987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xc2Pyhecf3H7fGJ/LhD+J1bOjuZ/GPkj7TLL+RQFo2o=;
 b=F4EFjRNbY+PzahWc8IXuj9IWOwV+aMAuqNfaVIiQkwd0wRZ7xzMu0ekj/ekAJbBWPuq8/R
 hWeqvFjGIpjibGKJ0O0VUlszvk3z88ti221aXrp0145qH9dSqSPsuH/e0LSTmclbLsuSD+
 CeBFU/qOIuK9rjpx3tVFtcGnEZa0Hsg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-oMnphy1-Ot69cu9U9q0bCA-1; Wed, 18 Feb 2026 04:29:45 -0500
X-MC-Unique: oMnphy1-Ot69cu9U9q0bCA-1
X-Mimecast-MFC-AGG-ID: oMnphy1-Ot69cu9U9q0bCA_1771406984
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836e35292cso39308465e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771406984; x=1772011784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc2Pyhecf3H7fGJ/LhD+J1bOjuZ/GPkj7TLL+RQFo2o=;
 b=LMPpT2muyug1dDXNsLHy5dWdERKBK/hHSIL3Doee8m+Yyc93+Vw2VWEtvzsOWHQBY4
 nAt/PRB6C9LplwbxhMMPBkF2q9ReH+pd3R/iPATMoxAg09xdGg7SSkjVJdjUhlYehvUn
 kCwwdtShtmYOvQl3Auj7/rhWGNAWHlme7dLObodg0Kshhgfw2d+tdtPVrP4PC6+c/Fho
 0TGI5XiTxMyyRug8zMPcRJ+R8cH6h1WaxpuxWSYL5jfpE5bgZgkinyzKgx1o41oMqudu
 ErUxIgBxR65Pr8ZClFojSQsLGRg8GgpTV5sbnvqG5bmrqIQY6AZ/R1Y9CBYRZ2mRaH0U
 EVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771406984; x=1772011784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xc2Pyhecf3H7fGJ/LhD+J1bOjuZ/GPkj7TLL+RQFo2o=;
 b=YUPK77EkLmpaKYE1FO1c/PUnRrBL+qQEh2iRw2yIH9PpoUDP3ugzgV+oEziQXyXjge
 PAAT64wnRDn1Vjw1HpfgSJSsX9c/5dyTAaR6ZIQ3zxSFHijQCx7y/AQA17mBNxnqnTr6
 KWfdYyc03TjDhdU4m8GroDOp2JBU2gkCiDW+c/fodgnjmv5hdioHYv0GC3ZGgMG57uv4
 TrnCxu2wqaqydbzWg+IU5TgEKhKecr4OIO/TvK7+xvKn7c0rG3fwwJub8yRDFDn/RQxe
 HjwVhtCmYfUv7GiljgM+/v4k2sEoQUnDrkBo4ax/rL5mUIA0sgfwvnRSJndg9WlvCpZl
 Wa0Q==
X-Gm-Message-State: AOJu0YxcK9v6wrGK9RPJY4neAF5a5Rw5oMIahhzZTaidFhH29t3xV0A3
 P2P7yxpTBOWHaPz2wWLDcLNZsw/EzywlM67jbWBMQXd6nSzIqkyLmCGibGn+//yFkWyOQUKm0wO
 KBT7NqB6TJrRgV1bRkVJLxjnhWqF+sxmhm4QAm3gUCTeqnhActDH6/Kwz
X-Gm-Gg: AZuq6aLA+b4tlsQsPLUhEAtVNj0FwAVqXdxSLVU48SG+1YaH098T0itVvY/OT08EKgr
 75uhmcrCeCr9khUDNbYVLu0yUhU35uZ7XowY8WWSmZRS7y4u4bbOuU+DMNii9JPZK1dMMqolqX8
 gXHF/c6e6ZpaPdhRo+9H94RPLUwbH/NcOMB5PF3sNuxIyJMY5WfiazvSoLjcPOTcLRrRaWqX5Kj
 PT/xxbfE4cOQYg5Hx6i0uVlojTk0MEH0/q6yjdY6tGzSznnxGJK0vfJ/5EtPNmsYpffM16ZkpnJ
 dm5ZpfoyJIHNsZKbKBtTldUnIqD627QXs97D+OY7Z+0vDfVBWtdFTo7Ey5Hjochle64aaO9Im5m
 ymvQ8Ag==
X-Received: by 2002:a05:600c:6211:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-48373a09741mr296250595e9.10.1771406984179; 
 Wed, 18 Feb 2026 01:29:44 -0800 (PST)
X-Received: by 2002:a05:600c:6211:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-48373a09741mr296250035e9.10.1771406983601; 
 Wed, 18 Feb 2026 01:29:43 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm552324305e9.8.2026.02.18.01.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 01:29:43 -0800 (PST)
Date: Wed, 18 Feb 2026 10:29:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
Message-ID: <20260218102941.6c906e7e@imammedo>
In-Reply-To: <CAK3XEhNNRDRyg5hNUwpoYo8KS2CbyPEBHnzqjFH1zY8jjFhwCg@mail.gmail.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <CAK3XEhNNRDRyg5hNUwpoYo8KS2CbyPEBHnzqjFH1zY8jjFhwCg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 16 Feb 2026 13:09:30 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> On Fri, Feb 6, 2026 at 6:44=E2=80=AFPM Igor Mammedov <imammedo@redhat.com=
> wrote:
> >
> > Windows doesn't ship built-in TCO watchdog driver, and users are
> > forced to install vendor specific driver(s) if such exists.
> > However OS provides a generic watchdog driver that uses
> > ACPI WDAT table [1] to abstract actual hardware behind it.
> > The same applies to ARM version of Windows.
> >
> > This series adds
> >  *  WDAT table tailored for TCO watchdog that Q35 already
> >     has as part of ICH9 chipset and a knob to enable it.
> >  *  SBSA GWDT to arm/vit machine with WDAT table tailored
> >     for it and necessary tweaks to GWDT to make usable
> >     with WDAT driver.
> >
> > Guest OS support is present since Windows Vista and Linux since 2016[2]=
. =20
>=20
> I am confused. The linux documentation for arm64 says WDAT is not support=
ed
> https://www.kernel.org/doc/html/latest/arch/arm64/acpi_object_usage.html

IT probably should be fixed,
the WDAT support builds and actually works
and it's no different than x86 in respect that it's Windows specific ACPI t=
able.

Justification for using WDAT on ARM is the same as x86,
reuse a more generic driver that hw supports for the sake
of out of box Windows driver, instead of writing it for each
watchdog impl.

Yep, underlying hw watchdog abstracted by WDAT is limited
but if it is sufficient for typical usecase, there is not need to
for guest to ship hw specific driver.

=46rom QEMU pov, WDAT allows us to change used hw watchdog
without breaking guests. (i.e. if we decide to use another
watchdog, we can do so by starting from new machine type and
slowly phase out previously used one)

Thanks for review,
I'll respin series with your comments addressed.

>=20
> >
> > One can test it launching VM with following options:
> >    -machine acpi-watchdog=3Don
> > to trace access to TCO registers one can add to CLI:
> >     -trace "tco_*"
> > to trace access to GWDT registers one can add to CLI:
> >     -trace "sbsa_gwdt*"
> >
> > To verify that guest uses WDAT (both Windows and Linux would use it if =
present),
> >   * on linux make sure that watchdog service is configured/enabled
> >    (use wdctl to check what watchdog device to use and confirm that it's
> >     wadt based one) and then trigger kernel panic with command:
> >       echo c > /proc/sysrq-trigger
> >   * on Windows kill svchost process, running cmd in admin mode:
> >       taskkill /f /im svchost.exe
> >
> > Tested with WS2025 & RHEL9.6 & Fedore 43 (aarch64)
> >
> > git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2
> >
> > 1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> > 2) https://lwn.net/Articles/700524/
> >
> > PS:
> >  previous revision (q35 only):
> >  https://patchwork.ozlabs.org/project/qemu-devel/cover/20251030123750.1=
36175-1-imammedo@redhat.com/
> >
> > Also CCing SBSA folks to see if they are interested in adding it to the=
ir
> > reference machine
> >
> > Igor Mammedov (11):
> >   acpi: add API to build WDAT instructions
> >   machine: add "acpi-watchdog" property
> >   x86: q35: generate WDAT ACPI table
> >   tests: acpi: x86/q35: whitelist new WDAT table
> >   tests: acpi: x86/q35: add WDAT table test case
> >   tests: acpi: x86/q35: update expected WDAT blob
> >   arm: add tracing events to sbsa_gwdt
> >   arm: virt: create GWDT watchdog paired with WDAT ACPI table
> >   tests: acpi: arm/virt: whitelist new WDAT table
> >   tests: acpi: arm/virt: add WDAT table test case
> >   tests: acpi: arm/virt: update expected WDAT blob
> >
> >  include/hw/acpi/wdat-gwdt.h            |  19 ++++
> >  include/hw/acpi/wdat-ich9.h            |  15 ++++
> >  include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
> >  include/hw/arm/virt.h                  |   3 +
> >  include/hw/core/boards.h               |   1 +
> >  hw/acpi/aml-build.c                    |  14 +++
> >  hw/acpi/meson.build                    |   5 +-
> >  hw/acpi/wdat-gwdt-stub.c               |  16 ++++
> >  hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
> >  hw/acpi/wdat-ich9-stub.c               |  15 ++++
> >  hw/acpi/wdat-ich9.c                    |  87 ++++++++++++++++++
> >  hw/arm/Kconfig                         |   1 +
> >  hw/arm/virt-acpi-build.c               |  16 ++++
> >  hw/arm/virt.c                          |  26 ++++++
> >  hw/core/machine.c                      |  20 +++++
> >  hw/i386/acpi-build.c                   |  12 +++
> >  hw/watchdog/sbsa_gwdt.c                |   8 ++
> >  hw/watchdog/trace-events               |   9 ++
> >  tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
> >  tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
> >  tests/qtest/bios-tables-test.c         |  34 +++++++
> >  21 files changed, 510 insertions(+), 1 deletion(-)
> >  create mode 100644 include/hw/acpi/wdat-gwdt.h
> >  create mode 100644 include/hw/acpi/wdat-ich9.h
> >  create mode 100644 include/hw/acpi/wdat.h
> >  create mode 100644 hw/acpi/wdat-gwdt-stub.c
> >  create mode 100644 hw/acpi/wdat-gwdt.c
> >  create mode 100644 hw/acpi/wdat-ich9-stub.c
> >  create mode 100644 hw/acpi/wdat-ich9.c
> >  create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
> >  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
> >
> > --
> > 2.47.3
> > =20
>=20


