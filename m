Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B11C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9t4-0000h9-0C; Tue, 21 Jul 2026 08:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm9t2-0000gw-4y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm9sz-0000Vh-O2
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784638066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZp1mpbmLsX0yiVu0eQsF0NvZEZvFN7lA1CPYRYhcYc=;
 b=ff2Dxjb3hCpTK1/B0YqkqGVuIv4F/iFjknyZZu9FPp3+C/E5Nm6iJYQSzmtynDmhiVrOk4
 QEBknG7gEaPhsiAkQgjcFvMMKP4o9TGsQ16A/m1Y54CGnMBShetMtIpREZSFqG5X+WWdwL
 zApxBIgFlEnwVJ4UXvE7KI3Xbqt3kBM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-TriVhH4tOjyQrXHyBKgDNg-1; Tue,
 21 Jul 2026 08:47:43 -0400
X-MC-Unique: TriVhH4tOjyQrXHyBKgDNg-1
X-Mimecast-MFC-AGG-ID: TriVhH4tOjyQrXHyBKgDNg_1784638062
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05104195F171; Tue, 21 Jul 2026 12:47:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CF841800352; Tue, 21 Jul 2026 12:47:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF38021E6920; Tue, 21 Jul 2026 14:47:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RESEND PATCH V10 00/15] iothread: Support tracking and
 querying IOThread holders
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 17 Jul 2026 01:20:41 +0800")
References: <20260716172108.87700-1-zhangckid@gmail.com>
Date: Tue, 21 Jul 2026 14:47:38 +0200
Message-ID: <87v7a8o6fp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

With this series applied:

    $ qemu-system-x86_64 -S -display none -chardev id=chr-mon0,backend=stdio -object monitor-hmp,id=mon0,chardev=chr-mon0 -chardev id=chr-mon1,backend=socket,path=test-hmp,server=on,wait=off -object monitor-qmp,id=mon1,chardev=chr-mon1
    QEMU 11.0.90 monitor - type 'help' for more information
    (qemu) q
    **
    ERROR:../iothread.c:99:iothread_unref: code should not be reached
    Bail out! ERROR:../iothread.c:99:iothread_unref: code should not be reached
    Aborted                    (core dumped) qemu-system-x86_64 -S -display none -chardev id=chr-mon0,backend=stdio -object monitor-hmp,id=mon0,chardev=chr-mon0 -chardev id=chr-mon1,backend=socket,path=test-hmp,server=on,wait=off -object monitor-qmp,id=mon1,chardev=chr-mon1

Stack backtrace:

    #0  0x00007f182873832c in __pthread_kill_implementation () at /lib64/libc.so.6
    #1  0x00007f18286de15e in raise () at /lib64/libc.so.6
    #2  0x00007f18286c56d0 in abort () at /lib64/libc.so.6
    #3  0x00007f182ac53482 in g_assertion_message[cold] ()
        at /lib64/libglib-2.0.so.0
    #4  0x00007f182acc1447 in g_assertion_message_expr ()
        at /lib64/libglib-2.0.so.0
    #5  0x000055ffa06cb50e in iothread_unref
        (iothread=0x55ffdb3bd740, holder=0x7ffc6152d8c0) at ../iothread.c:99
    #6  0x000055ffa06cc13a in iothread_put_aio_context
        (iothread=0x55ffdb3bd740, holder=0x7ffc6152d8c0) at ../iothread.c:444
    #7  0x000055ffa07d9af6 in monitor_cleanup () at ../monitor/monitor.c:679
    #8  0x000055ffa047ca8c in qemu_cleanup (status=0) at ../system/runstate.c:1046
    #9  0x000055ffa07fccb7 in qemu_default_main (opaque=0x0) at ../system/main.c:51
    #10 0x000055ffa07fcd64 in main (argc=12, argv=0x7ffc6152da98)
        at ../system/main.c:93


