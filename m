Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2CDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODGM-00006L-G8; Thu, 19 Dec 2024 04:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tODGK-000064-4F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:56:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tODGI-0006Mc-5B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734602164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mpMMVJZMXsFFgWtKqG1jVEAHUrlSUxk9h1r1mO9+0g=;
 b=guZSbHvKVrAlefcjnsC03C3OUGkgfJv74qWGve9Cqiantb3aaDynrfMv2QPEAnqAMw6tMl
 vLi2DawZABxGM7uTlihpcFwrIDhhyCKm0sGbct/pkjA+6GytqX7pdmQvuAnPoFQRAcglSk
 Dn20w+WPv2l3e0lNuSw9VvnOsaDqTog=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-SgEc7G6COQ6yHk0Y4QW3lQ-1; Thu, 19 Dec 2024 04:56:01 -0500
X-MC-Unique: SgEc7G6COQ6yHk0Y4QW3lQ-1
X-Mimecast-MFC-AGG-ID: SgEc7G6COQ6yHk0Y4QW3lQ
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7fd4e26676dso611561a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734602161; x=1735206961;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mpMMVJZMXsFFgWtKqG1jVEAHUrlSUxk9h1r1mO9+0g=;
 b=b2q2BSBg0FdCWVyMTdyrHdSMBh19MCEoyoAsuPad2gCrySey+qlQkgI3U1vHZir6uH
 ikvFAYcnUs7X2+6Yx0X+Y9+IjYHsJXNve9A8QoOz2jCYzm41+fMj3UqgQjWn0AEmL24H
 KPquG1+cwty1Pm2SVqUj3DQZyfNLMIa9nhtesQUzyh1ipY4bpGPfIKp0CmghIsgTKPbe
 DBzIv895wEosWZR0wiXV1tQhN5Mc/c/j8zcIWWuPDQgB5s2tfLRAWiy1jAnukZ2tXMtt
 4jWluyz8g62q9rQSeP2AbRgKPuVIruiDVdu7scRFLmC09WhnFGuZLs+nqhhFfIFpvTmn
 pirQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTM5E3VoOjNU4dgS9zjyTGL0OkCW23hEBQqBAjZS+bDPLMry9wGf7GSVfuG1mnFFySwwsE+OLx2soN@nongnu.org
X-Gm-Message-State: AOJu0YzgBxdHR5vTIaiUU5kzm49HeYgoKKzoIx6NOlnvO43goUSQ/I0r
 Pb/7fIjvmfcUH3bLFVhNr5XTqm4TKzCMimsOMMlvFeRiAZi2C0iQjqnKBN7YTiFxJSBkbZU7nxf
 dhrI6iaU47eavXGC8HGVMUouISQDbJthc0XIzubZcX2Qx9ut09lFf
X-Gm-Gg: ASbGncuFyiReqMl/wydbcimYPMEs/D6a+z6rt3foQwzOytkAtEa5RXsiq0SX7G/OIJt
 uraKEkEXm8USoNLd8Ng8EhERwnWSLdpZvk0YKP4fHrTeT9/87HlSvNyGPEfqHUlScVF5/gDfaZJ
 1wRcW+zdABZWdDciDlQWDIbVV4+7M3wCrhzk24DGoPS0or8g/gG6vR8uHmfoPBmWdxdjdPGHEAw
 uQYnxt3OzqEQABLI1MaovoF0PsqhSE+HcBk3z9dDPtCF6Sbawr8kLusDEaf2M+j2fBdMQbS8w==
X-Received: by 2002:a05:6a20:d80b:b0:1e1:f281:8d36 with SMTP id
 adf61e73a8af0-1e5b47fc194mr11264858637.10.1734602160709; 
 Thu, 19 Dec 2024 01:56:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/joEDmZ9yh4JWiYG9j0p3gGKi3RCg0ITK4ougL54TLQJrVsPVoUg5oPkF6ox9kvE6M6B83A==
X-Received: by 2002:a05:6a20:d80b:b0:1e1:f281:8d36 with SMTP id
 adf61e73a8af0-1e5b47fc194mr11264832637.10.1734602160362; 
 Thu, 19 Dec 2024 01:56:00 -0800 (PST)
Received: from smtpclient.apple ([116.73.135.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e32f5f00sm811221a12.72.2024.12.19.01.55.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:55:59 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v3] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20241219093749.15794-1-anisinha@redhat.com>
Date: Thu, 19 Dec 2024 15:25:44 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <59FED971-E9B2-41DF-B898-8B683709E9FE@redhat.com>
References: <20241219093749.15794-1-anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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



> On 19 Dec 2024, at 3:07=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> VM firmware update is a mechanism where the virtual machines can use =
their
> preferred and trusted firmware image in their execution environment =
without
> having to depend on a untrusted party to provide the firmware bundle. =
This is
> particularly useful for confidential virtual machines that are =
deployed in the
> cloud where the tenant and the cloud provider are two different =
entities. In
> this scenario, virtual machines can bring their own trusted firmware =
image
> bundled as a part of their filesystem (using UKIs for example[1]) and =
then use
> this hypervisor interface to update to their trusted firmware image. =
This also
> allows the guests to have a consistent measurements on the firmware =
image.
>=20
> This change introduces basic support for the fw-cfg based hypervisor =
interface
> and the corresponding device. The change also includes the
> specification document for this interface. The interface is made =
generic
> enough so that guests are free to use their own ABI to pass required
> information between initial and trusted execution contexts (where they =
are
> running their own trusted firmware image) without the hypervisor =
getting
> involved in between. In subsequent patches, we will introduce other =
minimal
> changes on the hypervisor that are required to make the mechanism =
work.
>=20
> A functional test has been added to test basic device creation and =
failure mode
> in cases where the user tries to create more than one device.
>=20
> [1] See systemd pull requests =
https://github.com/systemd/systemd/pull/35091
> and https://github.com/systemd/systemd/pull/35281 for some discussions =
on
> how we can bundle firmware image within an UKI.
>=20
> CC: Alex Graf <graf@amazon.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> MAINTAINERS                         |   9 ++
> docs/specs/index.rst                |   1 +
> docs/specs/vmfwupdate.rst           | 119 +++++++++++++++++++++
> hw/misc/meson

<snip>

> #endif
> diff --git a/tests/functional/meson.build =
b/tests/functional/meson.build
> index 758145d1e5..ac495fd026 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -201,6 +201,7 @@ tests_x86_64_system_quick =3D [
>   'pc_cpu_hotplug_props',
>   'virtio_version',
>   'x86_cpu_model_versions',
> +  'vmfwupdate',
> ]
>=20
> tests_x86_64_system_thorough =3D [
> diff --git a/tests/functional/test_vmfwupdate.py =
b/tests/functional/test_vmfwupdate.py
> new file mode 100644
> index 0000000000..4ca203d53f
> --- /dev/null
> +++ b/tests/functional/test_vmfwupdate.py
> @@ -0,0 +1,36 @@
> +#!/usr/bin/env python3
> +#
> +# Check for vmfwupdate device.
> +#
> +# Copyright (c) 2024 Red Hat, Inc.
> +#
> +# Author:
> +#  Ani Sinha <anisinha@redhat.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest
> +
> +class VmFwUpdateDeviceCheck(QemuSystemTest):
> +    # after launch, in order to generate the logs from QEMU we need =
to
> +    # wait for some time. Launching and then immediately shutting =
down
> +    # the VM generates empty logs. A delay of 1 second is added for
> +    # this reason.
> +    DELAY_Q35_BOOT_SEQUENCE =3D 1

Sorry, sent too soon. This is not needed yet. Will remove in v4.

> +
> +    def test_multiple_device_fail(self):
> +        """
> +        Only one vmfwdevice can be instantiated. Ensure failure if
> +        user tries to create more than one device.
> +        """
> +        self.vm.add_args('-device', 'vmfwupdate,id=3Dfwupd1',
> +                         '-device', 'vmfwupdate,id=3Dfwupd2')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(),
> +                         r'at most one vmfwupdate device is =
permitted')
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()
> --=20
> 2.42.0
>=20


