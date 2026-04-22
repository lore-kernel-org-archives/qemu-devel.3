Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7445BF9EDD9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFYO4-00019a-GD; Wed, 22 Apr 2026 10:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFYNu-00012A-Cp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFYNq-0006cM-3T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776867401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=FcYwuI6RUcft5wl++8jvcpjhm2bXdFgsmhz2obnAAQU=;
 b=YSn9DzwZN6SYe8o81ZRctj1tMwCzbYVUBdg9XvQDOqa6LKRRCRjvTurTS2Q258TDndQCvp
 6M/a20UJOBo1mFuy3Ri4fv2bzye3zS41ZKqz79LHYwTjeup6GJRNewAUj/XmzyVHeEhq4u
 nbNMwJYFZEt783XT2ryK52wNg0p3Q4g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-dovvXEJLMPugGUN_ZXRBGA-1; Wed,
 22 Apr 2026 10:16:38 -0400
X-MC-Unique: dovvXEJLMPugGUN_ZXRBGA-1
X-Mimecast-MFC-AGG-ID: dovvXEJLMPugGUN_ZXRBGA_1776867397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E429B19540E3; Wed, 22 Apr 2026 14:16:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A19A180047F; Wed, 22 Apr 2026 14:16:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA89F21E6A28; Wed, 22 Apr 2026 16:16:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhangckid@gmail.com, lizhijian@fujitsu.com, jasowang@redhat.com,
 arei.gonglei@huawei.com, zhenwei.pi@linux.dev, pbonzini@redhat.com,
 peterx@redhat.com, philmd@linaro.org, marcandre.lureau@redhat.com,
 berrange@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com
Subject: Several QOM objects crash on introspection
Date: Wed, 22 Apr 2026 16:16:01 +0200
Message-ID: <87a4uvw066.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QMP command qom-list-properties crashes for the following object types:

    colo-compare
    cryptodev-backend-lkcf
    memory-region-portio-list
    qemu-fixed-text-console
    qemu-graphic-console
    qio-net-listener
    x-remote-object

Testing gap: tests/qtest/device-introspect-test.c guards against such
bugs in devices, but not non-device objects.

Example crash:

(gdb) r
Starting program: /home/armbru/bin/qemu-system-x86_64 -S -display none -qmp stdio
[...]
{"QMP": {"version": {"qemu": {"micro": 94, "minor": 2, "major": 10}, "package": "v11.0.0-rc4-14-gcb2bd9a2e6-dirty"}, "capabilities": ["oob"]}}
[New Thread 0x7fff6b61d6c0 (LWP 2882851)]
{"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
{"return": {}}
{"execute": "qom-list-properties", "arguments": {"typename": "colo-compare"}}
upstream-qemu: ../util/qemu-thread-posix.c:96: qemu_mutex_destroy: Assertion `mutex->initialized' failed.

Thread 1 "upstream-qemu" received signal SIGABRT, Aborted.
0x00007ffff49c33cc in __pthread_kill_implementation () from /lib64/libc.so.6
[...]
(gdb) bt
#0  0x00007ffff49c33cc in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007ffff496915e in raise () at /lib64/libc.so.6
#2  0x00007ffff49506d0 in abort () at /lib64/libc.so.6
#3  0x00007ffff4950639 in __assert_fail_base.cold () at /lib64/libc.so.6
#4  0x0000555555ee3187 in qemu_mutex_destroy (mutex=0x55555761d4a0 <event_mtx>)
    at ../util/qemu-thread-posix.c:96
#5  0x0000555555a18c65 in colo_compare_finalize (obj=0x55555887e4f0)
    at ../net/colo-compare.c:1423
#6  0x0000555555c8bb31 in object_deinit
    (obj=0x55555887e4f0, type=0x555558053a90) at ../qom/object.c:715
#7  0x0000555555c8bbab in object_finalize (data=0x55555887e4f0)
    at ../qom/object.c:729
#8  0x0000555555c8ce2c in object_unref (objptr=0x55555887e4f0)
    at ../qom/object.c:1232
#9  0x0000555555de8d38 in qmp_qom_list_properties
    (typename=0x5555581ef450 "colo-compare", errp=0x7fffffffd8a8)
    at ../qom/qom-qmp-cmds.c:282
#10 0x0000555555e90311 in qmp_marshal_qom_list_properties
    (args=0x7fff64003150, ret=0x7fffeccccda8, errp=0x7fffeccccda0)
    at qapi/qapi-commands-qom.c:326
#11 0x0000555555ecdd9e in do_qmp_dispatch_bh (opaque=0x7fffecccce40)
    at ../qapi/qmp-dispatch.c:128
#12 0x0000555555eff09b in aio_bh_call (bh=0x555558bee700)
--Type <RET> for more, q to quit, c to continue without paging--
    at ../util/async.c:173
#13 0x0000555555eff1e3 in aio_bh_poll (ctx=0x55555807f180)
    at ../util/async.c:220
#14 0x0000555555ede0d0 in aio_dispatch (ctx=0x55555807f180)
    at ../util/aio-posix.c:390
#15 0x0000555555eff6f4 in aio_ctx_dispatch
    (source=0x55555807f180, callback=0x0, user_data=0x0) at ../util/async.c:365
#16 0x00007ffff6deb323 in g_main_context_dispatch_unlocked.lto_priv ()
    at /lib64/libglib-2.0.so.0
#17 0x00007ffff6deb5b5 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#18 0x0000555555f01202 in glib_pollfds_poll () at ../util/main-loop.c:290
#19 0x0000555555f01290 in os_host_main_loop_wait (timeout=0)
    at ../util/main-loop.c:313
#20 0x0000555555f013c1 in main_loop_wait (nonblocking=0)
    at ../util/main-loop.c:592
#21 0x0000555555993773 in qemu_main_loop () at ../system/runstate.c:945
#22 0x0000555555e0d468 in qemu_default_main (opaque=0x0) at ../system/main.c:50
#23 0x0000555555e0d522 in main (argc=6, argv=0x7fffffffdd58)
    at ../system/main.c:93


