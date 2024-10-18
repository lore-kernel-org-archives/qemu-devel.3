Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B43D3000F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1npD-0007ou-Jp; Fri, 18 Oct 2024 10:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1npB-0007oQ-Py
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1np9-0007vn-V1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729261167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJOSYBHAZch2hYcvcBohsQccqRoQwkaRO0O84tEZW2M=;
 b=AMpApmXsURhVQMTVsAjYz62lfvc2gaflGCvbj2nP66S5IpYDH0Hesl202XJ9VjCEQUGn56
 U3iEDbmtbbxSGHs6TzEYlTMQfYK4lhEX1RXZBwIuLOGxX9+khtGBlIShJTOxGB4bJdYnXi
 l12IvPqCiGeULbMw97g1VSpf24JTJTE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-jlPv5qLRPbaV7OFmGN-bVQ-1; Fri, 18 Oct 2024 10:19:25 -0400
X-MC-Unique: jlPv5qLRPbaV7OFmGN-bVQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so1112177f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261164; x=1729865964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJOSYBHAZch2hYcvcBohsQccqRoQwkaRO0O84tEZW2M=;
 b=b2t/t3LlzC5oQekYk5/VGOzqfMGDPE2aNLKOcLVn9fhP2dOPbqusaxhPmy9MSyXl0e
 dWRHn9Ukit9V7My7FKgArhq0sFbkzj/XAGvH9mz1vt3PMxXVTT2zknuRhGJX8eWiUJjG
 jKXBFCJFoyuLaWq8l/Q8US9vj+a6qzpNYyiXQaN054VwSBq/KPfdaeQcyiof+0gL6Jri
 05IXQ5HsTtx7jABDztU00tSI+X9p/MuHABFws33Wb+rztHR/K/2yIr/GHbsgn03k8+mi
 /P+m60wIBU1ckm9ln1Y0g8iULDTG8r+mA6GKntxu8iwy2fVUGFNQQsrCiGnQ6IWHl0mm
 LUVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoe8o70lLKeyI9EtdBvntsocIELyff6cFYtIdJ0JKjTuPHRrBeGO5CAf/OZzKaNnbLYW8YVkBudXkP@nongnu.org
X-Gm-Message-State: AOJu0Yw6JNZTnCMCxNqsaQjyfgwEJNbS7AF+47M9Esm2giv1qSunnuGI
 aUwP+U/1YoZW/eo5g9l32RDyKxrXZTRzde7f2lXiI7tmp3v3cPxShlGbsaI0Cs+JIDVuSf18ZTF
 xIUx43wAsy2zoPX/bF2P3K8dJKSSNzgFabtJVSM9Yg+bfJ7ge2Uxk
X-Received: by 2002:a05:600c:4fd4:b0:431:5f1b:a7c4 with SMTP id
 5b1f17b1804b1-431616ad74cmr19220385e9.34.1729261164381; 
 Fri, 18 Oct 2024 07:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY5/kTEFzyh7grd2Gu5Y+US50j6UCRJ6Ucx+9qSxguTt45KZ951RtWVGt6B0CTJ2MpuF/GbA==
X-Received: by 2002:a05:600c:4fd4:b0:431:5f1b:a7c4 with SMTP id
 5b1f17b1804b1-431616ad74cmr19219985e9.34.1729261163960; 
 Fri, 18 Oct 2024 07:19:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e11425sm25668095e9.28.2024.10.18.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:19:23 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:19:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 linuxarm@huawei.com, gustavo.romero@linaro.org
Subject: Re: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Message-ID: <20241018161920.20524a97@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZxHuVC0uDL7kEB2i@intel.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>
 <ZxHuVC0uDL7kEB2i@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 18 Oct 2024 13:12:52 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Salil,
>=20
> On Mon, Oct 14, 2024 at 08:22:04PM +0100, Salil Mehta wrote:
> > Date: Mon, 14 Oct 2024 20:22:04 +0100
> > From: Salil Mehta <salil.mehta@huawei.com>
> > Subject: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled} st=
ates
> >  in ACPI _STA.{PRES,ENA} Bits
> > X-Mailer: git-send-email 2.34.1
> >=20
> > Reflect the ACPI CPU hotplug `is_{present, enabled}` states in the `_ST=
A.PRES`
> > (presence) and `_STA.ENA` (enabled) bits when the guest kernel evaluate=
s the
> > ACPI `_STA` method during initialization, as well as when vCPUs are hot=
-plugged
> > or hot-unplugged. The presence of unplugged vCPUs may need to be delibe=
rately
> > *simulated* at the ACPI level to maintain a *persistent* view of vCPUs =
for the
> > guest kernel.
> >=20
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  hw/acpi/cpu.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >  =20
>=20
> It seems this patch changes ACPI table layout and then breaks current
> ACPI table qtest. I'm not sure how to do such modifications. Maybe you
> should first disable the related checks, then modify the code, update
> the qtest, and finally re-enable the checks for qtest. This can help
> to avoid any qtest failure due to this patch?

see comment at the top of tests/qtest/bios-tables-test.c

>=20
> I think it should get Igor's advice on this. :)
>=20
> Attach the error I met:
>=20
> =E2=96=B6   2/920 ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_a=
sl: assertion failed: (all_tables_match) ERROR
> =E2=96=B6   3/920 ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_a=
sl: assertion failed: (all_tables_match) ERROR
>   2/920 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test              =
                  ERROR            1.24s   killed by signal 6 SIGABRT
> >>> G_TEST_DBUS_DAEMON=3D/media/liuzhao/data/qemu-cook/tests/dbus-vmstate=
-daemon.sh ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1 MESON_TEST_ITERATION=3D1 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_e=
rror=3D1:print_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_BINARY=3D./qemu-=
system-i386 MALLOC_PERTURB_=3D142 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on=
_error=3D1:print_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_STORAGE_DAEMON=
_BINARY=3D./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=3D./qemu-img =
PYTHON=3D/media/liuzhao/data/qemu-cook/build/pyvenv/bin/python3 /media/liuz=
hao/data/qemu-cook/build/tests/qtest/bios-tables-test --tap -k =20
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
> stderr:
> acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-VRT5V=
2], Expected [aml:tests/data/acpi/x86/pc/DSDT].
> See source file tests/qtest/bios-tables-test.c for instructions on how to=
 update expected files.
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-TTT5V2.dsl, aml:/=
tmp/aml-VRT5V2], Expected [asl:/tmp/asl-XXM5V2.dsl, aml:tests/data/acpi/x86=
/pc/DSDT].
> **
> ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion fail=
ed: (all_tables_match)
>=20
> (test program exited with status code -6)
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
>=20
>   3/920 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test          =
                  ERROR            1.25s   killed by signal 6 SIGABRT
> >>> G_TEST_DBUS_DAEMON=3D/media/liuzhao/data/qemu-cook/tests/dbus-vmstate=
-daemon.sh ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1 MESON_TEST_ITERATION=3D1 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_e=
rror=3D1:print_summary=3D1:print_stacktrace=3D1 MSAN_OPTIONS=3Dhalt_on_erro=
r=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_=
STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=
=3D./qemu-img PYTHON=3D/media/liuzhao/data/qemu-cook/build/pyvenv/bin/pytho=
n3 MALLOC_PERTURB_=3D41 QTEST_QEMU_BINARY=3D./qemu-system-x86_64 /media/liu=
zhao/data/qemu-cook/build/tests/qtest/bios-tables-test --tap -k =20
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
> stderr:
> acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-D5K5V=
2], Expected [aml:tests/data/acpi/x86/pc/DSDT].
> See source file tests/qtest/bios-tables-test.c for instructions on how to=
 update expected files.
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-G6K5V2.dsl, aml:/=
tmp/aml-D5K5V2], Expected [asl:/tmp/asl-AQD5V2.dsl, aml:tests/data/acpi/x86=
/pc/DSDT].
> **
> ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion fail=
ed: (all_tables_match)
>=20
> (test program exited with status code -6)
>=20
>=20
> Regards,
> Zhao
>=20
>=20


