Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D407ECCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 05:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6jQH-00062T-6t; Thu, 09 Oct 2025 01:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6jQ9-000627-NN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 01:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6jQ5-00054e-Dy
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 01:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759988546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8LTEQnUajLca63w2yUdz6g2pijb8Z7LsQjOZ8AGWX0=;
 b=LPAFyNXWpxJ/STDIGv6OzLEA34HYmf7oxR1K5y390VRaKeNGYcSYW7YuIaDWfLLGii18fd
 lNw8ijqznwmt3LPwXw62KM9CnbdtD/NJmLNzhzWuwE9dhm1Z9QA8UYMJUrIxZur69efWp9
 gjhKmwI5CLxVtC1aYRs62lT3oS3kTtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-BEt2Gxy-NFWEPIot1Uinmw-1; Thu,
 09 Oct 2025 01:42:22 -0400
X-MC-Unique: BEt2Gxy-NFWEPIot1Uinmw-1
X-Mimecast-MFC-AGG-ID: BEt2Gxy-NFWEPIot1Uinmw_1759988539
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3F19180057D; Thu,  9 Oct 2025 05:42:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6608C1956056; Thu,  9 Oct 2025 05:42:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EC5E21E6A27; Thu, 09 Oct 2025 07:42:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,  "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,  "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>,  "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,  "eric.auger@redhat.com"
 <eric.auger@redhat.com>,  "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>,  "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>,  "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,  "rafael@kernel.org"
 <rafael@kernel.org>,  "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>,  "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>,  "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>,  "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,  "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>,  "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>,  "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>,  "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>,  "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>,  Karl Heubaum
 <karl.heubaum@oracle.com>,  "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>,  "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>,  "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>,  "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>,  "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>,  "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,  "maobibo@loongson.cn"
 <maobibo@loongson.cn>,  "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,  "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like
 Feature for ARMv8+ Arch
In-Reply-To: <6A8391B8-5E75-49B0-834B-00183BA4CF3E@oracle.com> (Miguel Luis's
 message of "Wed, 8 Oct 2025 16:04:11 +0000")
References: <20250930224037.224833-1-salil.mehta@huawei.com>
 <871pndlgi7.fsf@pond.sub.org>
 <6A8391B8-5E75-49B0-834B-00183BA4CF3E@oracle.com>
Date: Thu, 09 Oct 2025 07:42:10 +0200
Message-ID: <87bjmgiqbx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Miguel Luis <miguel.luis@oracle.com> writes:

> Hi Markus,
>
>> On 8 Oct 2025, at 12:33, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> Salil Mehta <salil.mehta@huawei.com> writes:
>>=20
>> [...]
>>=20
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> (VIII) Repositories
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>=20
>>> (*) Latest Qemu RFC V6 (Architecture Specific) patch set:
>>>    https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v6
>>=20
>> Does not compile for me (x86_64 box running Fedora 41):
>>=20
>>    [...]
>>=20
>>    FAILED: qemu-system-loongarch64=20
>>    cc -m64 @qemu-system-loongarch64.rsp
>>    /usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.re=
l+0x50): undefined reference to `vmstate_cpu_ospm_state'
>>    collect2: error: ld returned 1 exit status
>>    [6757/7232] Linking target qemu-system-mips64
>>    [6758/7232] Generating docs/QEMU manual with a custom command
>>    FAILED: docs/docs.stamp=20
>>    /usr/bin/env CONFDIR=3Detc/qemu /work/armbru/qemu/bld/pyvenv/bin/sphi=
nx-build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=3D10.1.50 -Drelease=
=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html -d /w=
ork/armbru/qemu/bld/docs/manual.p /work/armbru/qemu/docs /work/armbru/qemu/=
bld/docs/manual
>>    /work/armbru/qemu/docs/../include/hw/qdev-core.h:190: warning: Functi=
on parameter or member 'admin_power_state_supported' not described in 'Devi=
ceClass'
>>    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum v=
alue 'DEVICE_ADMIN_POWER_STATE_ENABLED' not described in enum 'DeviceAdminP=
owerState'
>>    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum v=
alue 'DEVICE_ADMIN_POWER_STATE_DISABLED' not described in enum 'DeviceAdmin=
PowerState'
>>    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum v=
alue 'DEVICE_ADMIN_POWER_STATE_REMOVED' not described in enum 'DeviceAdminP=
owerState'
>>    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum v=
alue 'DEVICE_ADMIN_POWER_STATE_MAX' not described in enum 'DeviceAdminPower=
State'
>>    1 warnings as Errors
>>=20
>>    Warning, treated as error:
>>    kernel-doc 'perl /work/armbru/qemu/docs/../scripts/kernel-doc -rst -e=
nable-lineno -sphinx-version 7.3.7 -Werror /work/armbru/qemu/docs/../includ=
e/hw/qdev-core.h' failed with return code 1
>>    [6759/7232] Linking target qemu-system-i386
>>    FAILED: qemu-system-i386=20
>>    cc -m64 @qemu-system-i386.rsp
>>    /usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.re=
l+0x50): undefined reference to `vmstate_cpu_ospm_state'
>>    collect2: error: ld returned 1 exit status
>>=20
>>    [...]
>>=20
>>    [6874/7232] Linking target qemu-system-x86_64
>>    FAILED: qemu-system-x86_64=20
>>    cc -m64 @qemu-system-x86_64.rsp
>>    /usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.re=
l+0x50): undefined reference to `vmstate_cpu_ospm_state'
>>    collect2: error: ld returned 1 exit status
>>=20
>
> I=E2=80=99ve had that same issue although it got compiled for me adding A=
CPI_CPU_OSPM_INTERFACE for MICROVM:
>
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 3a0e2b8ebb..29d9b09486 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -133,6 +133,7 @@ config MICROVM
>      select VIRTIO_MMIO
>      select ACPI_PCI
>      select ACPI_HW_REDUCED
> +    select ACPI_CPU_OSPM_INTERFACE
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select USB_XHCI_SYSBUS
>      select I8254
>
> Miguel

Thanks for the hint.  I additionally need a similar change to
hw/loongarch/Kconfig, and comment hackery in hw/qdev-core.h.

>
>>    [...]
>>=20
>>    ninja: build stopped: cannot make progress due to previous errors.
>>    make: *** [Makefile:168: run-ninja] Error 1
>>    make: Target 'all' not remade because of errors.
>>    make: Leaving directory '/work/armbru/qemu/bld'
>>=20
>> [...]
>>=20


