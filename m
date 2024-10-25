Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EB2D0C5F4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GZf-0004Ns-CJ; Fri, 25 Oct 2024 05:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t4GZd-0004NV-N9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t4GZa-0001WA-Pq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729848333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hn9dLSsy2ZmrYYt6a3x8pCr3JGkLSAnQ0CDdX5NQXrA=;
 b=gK4F2g6ZeTKEotNMf/PUx+k02Ic0DUVVo4V2IMA9zDBvFGRCIyAVb8k0PEGVbb6NVqUhlE
 ZdI8L5X+4icr/gDYeik03lYMJilQHaljUwtIju2DyryhV6fsBLIFYKQVojN9Vfnf4slSLp
 vciTGFL6JqpuAG/VbNfi57ULwvdsPJY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-85fShx9mOKec45GD2sS9CA-1; Fri,
 25 Oct 2024 05:25:28 -0400
X-MC-Unique: 85fShx9mOKec45GD2sS9CA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F3AD19560AB; Fri, 25 Oct 2024 09:25:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 716A3300018D; Fri, 25 Oct 2024 09:25:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A5DB21E6A28; Fri, 25 Oct 2024 11:25:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Igor Mammedov
 <imammedo@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
In-Reply-To: <20241024165627.1372621-3-peterx@redhat.com> (Peter Xu's message
 of "Thu, 24 Oct 2024 12:56:25 -0400")
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-3-peterx@redhat.com>
Date: Fri, 25 Oct 2024 11:25:23 +0200
Message-ID: <87jzdwlekc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

Peter Xu <peterx@redhat.com> writes:

> X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> singleton so it guards the system from accidentally create yet another
> IOMMU object when one already presents.
>
> Now if someone tries to create more than one, e.g., via:
>
>   ./qemu -M q35 -device intel-iommu -device intel-iommu
>
> The error will change from:
>
>   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
>
> To:
>
>   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
>
> Unfortunately, yet we can't remove the singleton check in the machine
> hook (pc_machine_device_pre_plug_cb), because there can also be
> virtio-iommu involved, which doesn't share a common parent class yet.
>
> But with this, it should be closer to reach that goal to check singleton by
> QOM one day.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

$ qemu-system-x86_64 -device amd-iommu,help
/work/armbru/qemu/include/hw/boards.h:24:MACHINE: Object 0x56473906f960 is not an instance of type machine
Aborted (core dumped)

(gdb) bt
#0  0x00007ffff4e43834 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007ffff4df18ee in raise () at /lib64/libc.so.6
#2  0x00007ffff4dd98ff in abort () at /lib64/libc.so.6
#3  0x0000555555f75ef3 in object_dynamic_cast_assert
    (obj=0x555557e03960, typename=0x5555563c403e "machine", file=0x5555563c4018 "/work/armbru/qemu/include/hw/boards.h", line=24, func=0x5555563c4290 <__func__.7> "MACHINE") at ../qom/object.c:936
#4  0x0000555555d5db0f in MACHINE (obj=0x555557e03960)
    at /work/armbru/qemu/include/hw/boards.h:24
#5  0x0000555555d5e030 in x86_iommu_get_default () at ../hw/i386/x86-iommu.c:83
#6  0x0000555555d5e262 in x86_iommu_get_instance
    (errp=0x5555573d4918 <error_abort>) at ../hw/i386/x86-iommu.c:139
#7  0x0000555555f7c27c in singleton_get_instance (class=0x555557e00320)
    at ../qom/object_interfaces.c:371
#8  0x000055555612a842 in qmp_device_list_properties
    (typename=0x555557e001d0 "amd-iommu", errp=0x7fffffffda38)
    at ../qom/qom-qmp-cmds.c:147
#9  0x0000555555bf20b2 in qdev_device_help (opts=0x555557e001f0)
    at ../system/qdev-monitor.c:314
#10 0x0000555555bfe06d in device_help_func
    (opaque=0x0, opts=0x555557e001f0, errp=0x0) at ../system/vl.c:1208
#11 0x0000555556217186 in qemu_opts_foreach
    (list=0x55555729e5c0 <qemu_device_opts>, func=0x555555bfe04d <device_help_func>, opaque=0x0, errp=0x0) at ../util/qemu-option.c:1135
#12 0x0000555555c01d56 in qemu_process_help_options () at ../system/vl.c:2555
#13 0x0000555555c04d81 in qemu_init (argc=3, argv=0x7fffffffde28)
    at ../system/vl.c:3654
#14 0x000055555612ffae in main (argc=3, argv=0x7fffffffde28)
    at ../system/main.c:47


