Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C7C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whnBC-0002Qq-Gl; Thu, 09 Jul 2026 07:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whnBA-0002QC-8u
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whnB8-0006VS-G1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783597468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=QwkulsDvfDoWX/rVwfo7ZsGXanw+41LqOYKrND7Mexc=;
 b=fUV5gEcyBchQkX9okBrFgxezCV8JqhI4D8D6PcCHtEodDBvJPtWMba5p+pJ3MPN2HWIFQe
 q25WI+tiEyWjsV8RFDCbR6AeQa1zrfP0tWkWQFeXFflc/4WaEoufh7ERjSc5p3qewu1WFC
 7QXL9YhSR1Ok85hcDc7zGZN21yRGKEA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-OF0nRYYdOgWBZrXD3j5xNw-1; Thu,
 09 Jul 2026 07:44:25 -0400
X-MC-Unique: OF0nRYYdOgWBZrXD3j5xNw-1
X-Mimecast-MFC-AGG-ID: OF0nRYYdOgWBZrXD3j5xNw_1783597464
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 452E91955F2D; Thu,  9 Jul 2026 11:44:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F5BE3000C31; Thu,  9 Jul 2026 11:44:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 85E0F21E6920; Thu, 09 Jul 2026 13:44:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org, BALATON Zoltan
 <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Huacai Chen
 <chenhuacai@kernel.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: A few Machines crash when "no default audio driver available"
Date: Thu, 09 Jul 2026 13:44:19 +0200
Message-ID: <87o6gge6b0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
and MIPS machine fuloong2e crashes.

I run them like this:

$ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio

Backtrace:

    #0  0x00007ffff4a5432c in __pthread_kill_implementation () at /lib64/libc.so.6
    #1  0x00007ffff49fa15e in raise () at /lib64/libc.so.6
    #2  0x00007ffff49e16d0 in abort () at /lib64/libc.so.6
    #3  0x0000555555584ae9 in error_handle
        (err=0x55555836e8a0, errp=0x5555579c55c8 <error_abort>)
        at ../util/error.c:37
    #4  0x0000555556055670 in error_handle
        (errp=<optimized out>, err=<optimized out>) at ../util/error.c:301
    #5  error_propagate (dst_errp=<optimized out>, local_err=<optimized out>)
        at ../util/error.c:300
    #6  0x0000555555dbc754 in device_set_realized
        (obj=<optimized out>, value=<optimized out>, errp=0x5555579c55c8 <error_abort>) at ../hw/core/qdev.c:629
    #7  0x0000555555dbf9e9 in property_set_bool
        (obj=0x55555836eb50, v=<optimized out>, name=<optimized out>, opaque=0x555557b90f20, errp=0x5555579c55c8 <error_abort>) at ../qom/object.c:2484
    #8  0x0000555555dc2ec9 in object_property_set
        (obj=obj@entry=0x55555836eb50, name=name@entry=0x5555565a98c8 "realized", v=v@entry=0x555557b8faa0, errp=errp@entry=0x5555579c55c8 <error_abort>)
        at ../qom/object.c:1548
    #9  0x0000555555dc6ca1 in object_property_set_qobject
        (obj=obj@entry=0x55555836eb50, name=name@entry=0x5555565a98c8 "realized", value=value@entry=0x55555836e9a0, errp=errp@entry=0x5555579c55c8 <error_abort>)
        at ../qom/qom-qobject.c:28
    #10 0x0000555555dc3666 in object_property_set_bool
        (obj=0x55555836eb50, name=0x5555565a98c8 "realized", value=<optimized out>, errp=0x5555579c55c8 <error_abort>) at ../qom/object.c:1618
    #11 0x0000555555dbbfde in qdev_realize_and_unref
        (dev=dev@entry=0x55555836eb50, bus=bus@entry=0x55555834e0c0, errp=<optimized out>) at ../hw/core/qdev.c:284
    #12 0x00005555557988d5 in i2c_slave_realize_and_unref
        (dev=dev@entry=0x55555836eb50, bus=bus@entry=0x55555834e0c0, errp=<optimized out>) at ../hw/i2c/core.c:378
    #13 0x0000555555b6fe1d in musicpal_init (machine=0x555557f21520)
        at ../hw/arm/musicpal.c:1334
    #14 0x000055555572d1d2 in machine_run_board_init
        (machine=0x555557f21520, mem_path=<optimized out>, errp=<optimized out>)
        at ../hw/core/machine.c:1696
    #15 0x00005555559f9699 in qemu_init_board () at ../system/vl.c:2727
    #16 qmp_x_exit_preconfig (errp=errp@entry=0x5555579c55c0 <error_fatal>)
        at ../system/vl.c:2821
    #17 0x00005555559fd3fc in qmp_x_exit_preconfig (errp=<optimized out>)
        at ../system/vl.c:2816
    #18 qemu_init (argc=<optimized out>, argv=<optimized out>)
        at ../system/vl.c:3862
    #19 0x000055555558d899 in main (argc=<optimized out>, argv=<optimized out>)
        at ../system/main.c:71

Died when device_set_realized() tried to propagate a "no default audio
driver available" error to &error_abort.

The error comes from audio_init().  Backtrace:

    #0  error_setg_internal
        (errp=errp@entry=0x7fffffffd730, src=src@entry=0x5555565cfd35 "../audio/audio.c", line=line@entry=106, func=func@entry=0x55555670a468 <__func__.3> "audio_init", fmt=fmt@entry=0x55555655ef38 "no default audio driver available")
        at ../util/error.c:96
    #1  0x0000555555ec18fc in audio_init
        (dev=dev@entry=0x0, errp=errp@entry=0x7fffffffd730) at ../audio/audio.c:106
    #2  0x0000555555ec1d36 in audio_get_default_audio_be
        (errp=errp@entry=0x7fffffffd730) at ../audio/audio.c:130
    #3  0x0000555555ec21c5 in audio_be_check
        (be=be@entry=0x55555836ebf8, errp=errp@entry=0x7fffffffd730)
        at ../audio/audio-be.c:15
    #4  0x00005555556fc57a in wm8750_realize
        (dev=<optimized out>, errp=0x7fffffffd730) at ../hw/audio/wm8750.c:628
    #5  0x0000555555dbc7c7 in device_set_realized
        (obj=<optimized out>, value=<optimized out>, errp=0x5555579c55c8 <error_abort>) at ../hw/core/qdev.c:514
    #6  0x0000555555dbf9e9 in property_set_bool
        (obj=0x55555836eb50, v=<optimized out>, name=<optimized out>, opaque=0x555557b90f20, errp=0x5555579c55c8 <error_abort>) at ../qom/object.c:2484
    #7  0x0000555555dc2ec9 in object_property_set
        (obj=obj@entry=0x55555836eb50, name=name@entry=0x5555565a98c8 "realized", v=v@entry=0x555557b8faa0, errp=errp@entry=0x5555579c55c8 <error_abort>)
        at ../qom/object.c:1548
    #8  0x0000555555dc6ca1 in object_property_set_qobject
        (obj=obj@entry=0x55555836eb50, name=name@entry=0x5555565a98c8 "realized", value=value@entry=0x55555836e9a0, errp=errp@entry=0x5555579c55c8 <error_abort>)
        at ../qom/qom-qobject.c:28
    #9  0x0000555555dc3666 in object_property_set_bool
        (obj=0x55555836eb50, name=0x5555565a98c8 "realized", value=<optimized out>, errp=0x5555579c55c8 <error_abort>) at ../qom/object.c:1618
    #10 0x0000555555dbbfde in qdev_realize_and_unref
        (dev=dev@entry=0x55555836eb50, bus=bus@entry=0x55555834e0c0, errp=<optimized out>) at ../hw/core/qdev.c:284
    #11 0x00005555557988d5 in i2c_slave_realize_and_unref
        (dev=dev@entry=0x55555836eb50, bus=bus@entry=0x55555834e0c0, errp=<optimized out>) at ../hw/i2c/core.c:378
    #12 0x0000555555b6fe1d in musicpal_init (machine=0x555557f21520)
        at ../hw/arm/musicpal.c:1334
    #13 0x000055555572d1d2 in machine_run_board_init
        (machine=0x555557f21520, mem_path=<optimized out>, errp=<optimized out>)
        at ../hw/core/machine.c:1696
    #14 0x00005555559f9699 in qemu_init_board () at ../system/vl.c:2727
    #15 qmp_x_exit_preconfig (errp=errp@entry=0x5555579c55c0 <error_fatal>)
        at ../system/vl.c:2821
    #16 0x00005555559fd3fc in qmp_x_exit_preconfig (errp=<optimized out>)
        at ../system/vl.c:2816
    #17 qemu_init (argc=<optimized out>, argv=<optimized out>)
        at ../system/vl.c:3862
    #18 0x000055555558d899 in main (argc=<optimized out>, argv=<optimized out>)
        at ../system/main.c:71


