Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24CACA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNNo-0008J9-3D; Wed, 10 Sep 2025 12:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uwNNa-0008Ge-BZ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uwNNV-0005M3-Pn
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757520536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfEjeCYWrvNyNF/OH64pvA+w6HxCV9HCS/0vK2FiFU8=;
 b=gYNb9DjrrN8lfB0BL8+GAJ+oPLc5ilT/Ec/TpKoetx/YcLOEcOQUrwhtDNleoOTfIZYXHI
 DgAnpw0CTwM/CIpg2YpgGChdgGy6WnfOzTETt+iRv9C3jNHdsvKjo7hcbUc3gu26455K6e
 +s7/ICFmPlPpL+mJP/ybPlF9Wn97tlM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-cO_ZubgQPVetUqcFt0sGVw-1; Wed,
 10 Sep 2025 12:08:53 -0400
X-MC-Unique: cO_ZubgQPVetUqcFt0sGVw-1
X-Mimecast-MFC-AGG-ID: cO_ZubgQPVetUqcFt0sGVw_1757520532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCBC91935329; Wed, 10 Sep 2025 16:08:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.166])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE94318003FC; Wed, 10 Sep 2025 16:08:48 +0000 (UTC)
Date: Wed, 10 Sep 2025 18:08:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, hreitz@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: Re: Some iotests are failing with -luks
Message-ID: <aMGijXg9XIpbbn-v@redhat.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:
> 
>  Hi,
> 
> when running "./check -luks" in the qemu-iotests directory,
> some tests are failing for me:
> 
> 295 296 inactive-node-nbd luks-detached-header
> 
> Is that a known problem already?

Not to me anyway.

> FWIW, 295 is failing with the following output:
> 
> 295   fail       [17:03:01] [17:03:17]   15.7s                failed, exit status 1
> [...]
> +EWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
> +EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=6 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
> +EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=10 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
> +E
> [...]
> 
> etc.
> 
> 296 looks very similar (also a "qemu received signal 6" error),
> but the others look like this:

When it gets signal 6 (i.e. SIGABRT), that usually means that you should
have a look at the coredump.

> inactive-node-nbd   fail       [17:13:56] [17:14:04]   7.5s                 failed, exit status 1
> --- /home/thuth/devel/qemu/tests/qemu-iotests/tests/inactive-node-nbd.out
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-inactive-node-nbd/inactive-node-nbd.out.bad
> @@ -1,239 +1,64 @@
>  Preparing disk...
>  Launching VM...
> -{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
> -{"return": {}}
> +ERROR:qemu.qmp.qmp_client.qemu-223907:Failed to receive Greeting: EOFError
> +ERROR:qemu.qmp.qmp_client.qemu-223907:Failed to establish session: EOFError
> +Traceback (most recent call last):
> +  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 425, in _session_guard
> +    await coro
> +  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 250, in _establish_session
> +    self._greeting = await self._get_greeting()
> +                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 270, in _get_greeting
> +    msg = await self._recv()
> +          ^^^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 1009, in _recv
> +    message = await self._do_recv()
> +              ^^^^^^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 402, in _do_recv
> +    msg_bytes = await self._readline()
> +                ^^^^^^^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 977, in _readline
> +    raise EOFError
> +EOFError

Not sure what this is. It looks like the QEMU process failed to start,
maybe it didn't like some command line option. I would expect an error
message on stderr, but I'm not sure if qemu-iotests automatically
displays that in such cases. I thought that yes, but maybe I'm confusing
it with a different case.

> luks-detached-header   fail       [17:15:26] [17:15:38]   12.2s                failed, exit status 1
> --- /home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header.out
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/luks-detached-header.out.bad
> @@ -1,5 +1,55 @@
> -..
> +EE
> +======================================================================
> +ERROR: test_detached_luks_header (__main__.TestDetachedLUKSHeader.test_detached_luks_header)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "/home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header", line 139, in setUp
> +    res = qemu_img_create(
> +          ^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line 278, in qemu_img_create
> +    return qemu_img('create', *args)
> +           ^^^^^^^^^^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line 261, in qemu_img
> +    return qemu_tool(*full_args, check=check, combine_stdio=combine_stdio)
> +           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line 241, in qemu_tool
> +    raise VerboseProcessError(
> +qemu.utils.VerboseProcessError: Command '('/home/thuth/tmp/qemu-build/qemu-img', 'create', '-f', 'luks', '-o', 'iter-time=10', '-o', 'key-secret=sec0', '-o', 'detached-header=true', '--object', 'secret,id=sec0,data=foo', '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/detached_header.img2')' returned non-zero exit status 1.
> +  ┏━ output ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> +  ┃ Formatting '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/l
> +  ┃ uks-file-luks-detached-header/detached_header.img2', fmt=luks
> +  ┃ size=-1 key-secret=sec0 iter-time=10 detached-header=true
> +  ┃ qemu-img: /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luk
> +  ┃ s-file-luks-detached-header/detached_header.img2: Parameter
> +  ┃ 'detached-header' is unexpected
> +  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This one is surprising. I don't think anything relevant in the luks
driver has changed since the test was introduced. At the same time, the
code clearly has a problem when it tries to convert a QemuOpts
containing a "detached-header" option into a QAPI object when the schema
doesn't even have this option. Was this broken from the beginning? Would
have been for a year and half.

Kevin


