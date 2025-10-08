Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235DCCCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6TNB-0002FX-IP; Wed, 08 Oct 2025 08:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6TN9-0002Ax-N2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6TN1-00072r-OQ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759926847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMrX00pLYmBaJlEJ2HrID5Bf1Sa8ykCXsnKMZM/P1/o=;
 b=YNzTbgGCWiUpp4/U8JQ4AEhKV5zVR5MMnvYI6r9erM39NRoSTUAN49TzFq6iYXQhDPBzs7
 Md+J/APBpYhFtTZqLVpPmL4cbSfAWcWghth5WEBLRGLNMyqgtpWgf0BtXHpzsc10S0UE9R
 5aL6Uhjhvx1WjqUeCGLP1veLxKhXSt8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-WC5I18JJM2-QUKin5lEiqA-1; Wed,
 08 Oct 2025 08:34:04 -0400
X-MC-Unique: WC5I18JJM2-QUKin5lEiqA-1
X-Mimecast-MFC-AGG-ID: WC5I18JJM2-QUKin5lEiqA_1759926840
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A53219560BB; Wed,  8 Oct 2025 12:33:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B67C019560A2; Wed,  8 Oct 2025 12:33:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80E1A21E6A27; Wed, 08 Oct 2025 14:33:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-arm@nongnu.org>,  <mst@redhat.com>,
 <maz@kernel.org>,  <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>,  <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>,  <richard.henderson@linaro.org>,
 <imammedo@redhat.com>,  <andrew.jones@linux.dev>,  <david@redhat.com>,
 <philmd@linaro.org>,  <eric.auger@redhat.com>,  <will@kernel.org>,
 <ardb@kernel.org>,  <oliver.upton@linux.dev>,  <pbonzini@redhat.com>,
 <gshan@redhat.com>,  <rafael@kernel.org>,  <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>,  <gustavo.romero@linaro.org>,
 <npiggin@gmail.com>,  <harshpb@linux.ibm.com>,  <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>,  <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>,  <gankulkarni@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>,  <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>,  <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>,  <wangyanan55@huawei.com>,
 <wangzhou1@hisilicon.com>,  <linuxarm@huawei.com>,
 <jiakernel2@gmail.com>,  <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>,  <shahuang@redhat.com>,  <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like
 Feature for ARMv8+ Arch
In-Reply-To: <20250930224037.224833-1-salil.mehta@huawei.com> (Salil Mehta's
 message of "Tue, 30 Sep 2025 23:40:13 +0100")
References: <20250930224037.224833-1-salil.mehta@huawei.com>
Date: Wed, 08 Oct 2025 14:33:52 +0200
Message-ID: <871pndlgi7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Salil Mehta <salil.mehta@huawei.com> writes:

[...]

> ===================
> (VIII) Repositories
> ===================
>
> (*) Latest Qemu RFC V6 (Architecture Specific) patch set:
>     https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v6

Does not compile for me (x86_64 box running Fedora 41):

    [...]

    FAILED: qemu-system-loongarch64 
    cc -m64 @qemu-system-loongarch64.rsp
    /usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.rel+0x50): undefined reference to `vmstate_cpu_ospm_state'
    collect2: error: ld returned 1 exit status
    [6757/7232] Linking target qemu-system-mips64
    [6758/7232] Generating docs/QEMU manual with a custom command
    FAILED: docs/docs.stamp 
    /usr/bin/env CONFDIR=etc/qemu /work/armbru/qemu/bld/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=1 -j auto -Dversion=10.1.50 -Drelease= -Ddepfile=docs/docs.d -Ddepfile_stamp=docs/docs.stamp -b html -d /work/armbru/qemu/bld/docs/manual.p /work/armbru/qemu/docs /work/armbru/qemu/bld/docs/manual
    /work/armbru/qemu/docs/../include/hw/qdev-core.h:190: warning: Function parameter or member 'admin_power_state_supported' not described in 'DeviceClass'
    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum value 'DEVICE_ADMIN_POWER_STATE_ENABLED' not described in enum 'DeviceAdminPowerState'
    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum value 'DEVICE_ADMIN_POWER_STATE_DISABLED' not described in enum 'DeviceAdminPowerState'
    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum value 'DEVICE_ADMIN_POWER_STATE_REMOVED' not described in enum 'DeviceAdminPowerState'
    /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum value 'DEVICE_ADMIN_POWER_STATE_MAX' not described in enum 'DeviceAdminPowerState'
    1 warnings as Errors

    Warning, treated as error:
    kernel-doc 'perl /work/armbru/qemu/docs/../scripts/kernel-doc -rst -enable-lineno -sphinx-version 7.3.7 -Werror /work/armbru/qemu/docs/../include/hw/qdev-core.h' failed with return code 1
    [6759/7232] Linking target qemu-system-i386
    FAILED: qemu-system-i386 
    cc -m64 @qemu-system-i386.rsp
    /usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.rel+0x50): undefined reference to `vmstate_cpu_ospm_state'
    collect2: error: ld returned 1 exit status

    [...]

    [6874/7232] Linking target qemu-system-x86_64
    FAILED: qemu-system-x86_64 
    cc -m64 @qemu-system-x86_64.rsp
    /usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.rel+0x50): undefined reference to `vmstate_cpu_ospm_state'
    collect2: error: ld returned 1 exit status

    [...]

    ninja: build stopped: cannot make progress due to previous errors.
    make: *** [Makefile:168: run-ninja] Error 1
    make: Target 'all' not remade because of errors.
    make: Leaving directory '/work/armbru/qemu/bld'

[...]


