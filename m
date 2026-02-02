Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170F9E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvRR-0002Mi-N9; Mon, 02 Feb 2026 10:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvR1-0002K5-VZ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:01:53 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmvQv-0005Y4-Pj
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:01:50 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AC1B3E749;
 Mon,  2 Feb 2026 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770044503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fxMVeBwngWwPFhvG6QhsKxM9C8voeMckBQyIkmvURw=;
 b=kiaxlX6p7iAe4dLDyBTaC89GEmc399tbzGUzA8FCzSa8ZhFMvVIDm7oU/Lu3FcIjBzzg/v
 w0LMuuCO5pOZy3wvVDAv6WUo/nvY+EYNt0YnzHueFD7oLKJa9oHsX1E0WZ/6/8gCBRibq4
 9d4sZszhIwSyYt/6I1rhLpxfGtFM/HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770044503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fxMVeBwngWwPFhvG6QhsKxM9C8voeMckBQyIkmvURw=;
 b=JJD9NgzY7Oyt6UEpkdqlx5KcO7ppVDHMls92e+GVl8vzqddSA4VoRtfgBeDQa28F0iXbL2
 pPX6rUiDo4RxYwAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770044498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fxMVeBwngWwPFhvG6QhsKxM9C8voeMckBQyIkmvURw=;
 b=jgGchGOiItoRB082FV2KgvHx/64i8R3KRbhqxkRuxsK6ALryFpKjxOZ+dHsf6b/v358aDS
 jwb+WGXVSsFIS1AFpb8e0ZRNWQGzb4oEM8PJx5yPZl7QkL42tCg0h+PqM7rBuBctF6/byC
 pimUCttJNuTqUIL1yHnTscvyjwKyDF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770044498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fxMVeBwngWwPFhvG6QhsKxM9C8voeMckBQyIkmvURw=;
 b=vzdlcqazV6IJk7AUlfNv/aRp1Xn0vvU2Fzruv+w0LCzXZLea0cq52i49Xm2WtI/w3M6o0W
 PX3iJ3/q1Gd3s3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72A253EA62;
 Mon,  2 Feb 2026 15:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wXCxDFG8gGndcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 15:01:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 13/16] Convert colo main documentation to
 restructuredText
In-Reply-To: <20260130-colo_unit_test_multifd-v4-13-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
 <20260130-colo_unit_test_multifd-v4-13-7115ab6f0e77@web.de>
Date: Mon, 02 Feb 2026 12:01:34 -0300
Message-ID: <877bsvrxyp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 RCPT_COUNT_SEVEN(0.00)[11]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Lukas Straub <lukasstraub2@web.de> writes:

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS               |   2 +-
>  docs/COLO-FT.txt          | 334 ----------------------------------------=
--
>  docs/system/index.rst     |   1 +
>  docs/system/qemu-colo.rst | 360 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 362 insertions(+), 335 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ceb3ecb1d955a267018c70429de61e45abb7a7ba..b04a5fef47d26ef14842e8a2e=
2a674651e9215e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3854,7 +3854,7 @@ F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
>  F: tests/qtest/migration/colo-tests.c
> -F: docs/COLO-FT.txt
> +F: docs/system/qemu-colo.rst
>=20=20
>  COLO Proxy
>  M: Zhang Chen <zhangckid@gmail.com>
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
> deleted file mode 100644
> index 2283a09c080b8996f9767eeb415e8d4fbdc940af..0000000000000000000000000=
000000000000000
> --- a/docs/COLO-FT.txt
> +++ /dev/null
> @@ -1,334 +0,0 @@
> -COarse-grained LOck-stepping Virtual Machines for Non-stop Service
> -----------------------------------------
> -Copyright (c) 2016 Intel Corporation
> -Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> -Copyright (c) 2016 Fujitsu, Corp.
> -
> -This work is licensed under the terms of the GNU GPL, version 2 or later.
> -See the COPYING file in the top-level directory.
> -
> -This document gives an overview of COLO's design and how to use it.
> -
> -=3D=3D Background =3D=3D
> -Virtual machine (VM) replication is a well known technique for providing
> -application-agnostic software-implemented hardware fault tolerance,
> -also known as "non-stop service".
> -
> -COLO (COarse-grained LOck-stepping) is a high availability solution.
> -Both primary VM (PVM) and secondary VM (SVM) run in parallel. They recei=
ve the
> -same request from client, and generate response in parallel too.
> -If the response packets from PVM and SVM are identical, they are released
> -immediately. Otherwise, a VM checkpoint (on demand) is conducted.
> -
> -=3D=3D Architecture =3D=3D
> -
> -The architecture of COLO is shown in the diagram below.
> -It consists of a pair of networked physical nodes:
> -The primary node running the PVM, and the secondary node running the SVM
> -to maintain a valid replica of the PVM.
> -PVM and SVM execute in parallel and generate output of response packets =
for
> -client requests according to the application semantics.
> -
> -The incoming packets from the client or external network are received by=
 the
> -primary node, and then forwarded to the secondary node, so that both the=
 PVM
> -and the SVM are stimulated with the same requests.
> -
> -COLO receives the outbound packets from both the PVM and SVM and compare=
s them
> -before allowing the output to be sent to clients.
> -
> -The SVM is qualified as a valid replica of the PVM, as long as it genera=
tes
> -identical responses to all client requests. Once the differences in the =
outputs
> -are detected between the PVM and SVM, COLO withholds transmission of the
> -outbound packets until it has successfully synchronized the PVM state to=
 the SVM.
> -
> -  Primary Node                                                          =
  Secondary Node
> -+------------+  +-----------------------+       +-----------------------=
-+  +------------+
> -|            |  |       HeartBeat       +<----->+       HeartBeat       =
 |  |            |
> -| Primary VM |  +-----------+-----------+       +-----------+-----------=
-+  |Secondary VM|
> -|            |              |                               |           =
    |            |
> -|            |  +-----------|-----------+       +-----------|-----------=
-+  |            |
> -|            |  |QEMU   +---v----+      |       |QEMU  +----v---+       =
 |  |            |
> -|            |  |       |Failover|      |       |      |Failover|       =
 |  |            |
> -|            |  |       +--------+      |       |      +--------+       =
 |  |            |
> -|            |  |   +---------------+   |       |   +---------------+   =
 |  |            |
> -|            |  |   | VM Checkpoint +-------------->+ VM Checkpoint |   =
 |  |            |
> -|            |  |   +---------------+   |       |   +---------------+   =
 |  |            |
> -|Requests<--------------------------\ /-----------------\ /-------------=
-------->Requests|
> -|            |  |                   ^ ^ |       |       | |             =
 |  |            |
> -|Responses+---------------------\ /-|-|------------\ /------------------=
-------+Responses|
> -|            |  |               | | | | |       |  | |  | |             =
 |  |            |
> -|            |  | +-----------+ | | | | |       |  | |  | | +----------+=
 |  |            |
> -|            |  | | COLO disk | | | | | |       |  | |  | | | COLO disk|=
 |  |            |
> -|            |  | |   Manager +---------------------------->| Manager  |=
 |  |            |
> -|            |  | ++----------+ v v | | |       |  | v  v | +---------++=
 |  |            |
> -|            |  |  |+-----------+-+-+-++|       | ++-+--+-+---------+ | =
 |  |            |
> -|            |  |  ||   COLO Proxy     ||       | |   COLO Proxy    | | =
 |  |            |
> -|            |  |  || (compare packet  ||       | |(adjust sequence | | =
 |  |            |
> -|            |  |  ||and mirror packet)||       | |    and ACK)     | | =
 |  |            |
> -|            |  |  |+------------+---+-+|       | +-----------------+ | =
 |  |            |
> -+------------+  +-----------------------+       +-----------------------=
-+  +------------+
> -+------------+     |             |   |                                | =
    +------------+
> -| VM Monitor |     |             |   |                                | =
    | VM Monitor |
> -+------------+     |             |   |                                | =
    +------------+
> -+---------------------------------------+       +-----------------------=
-----------------+
> -|   Kernel         |             |   |  |       |   Kernel            | =
                 |
> -+---------------------------------------+       +-----------------------=
-----------------+
> -                   |             |   |                                |
> -    +--------------v+  +---------v---+--+       +------------------+ +v-=
------------+
> -    |   Storage     |  |External Network|       | External Network | |  =
 Storage    |
> -    +---------------+  +----------------+       +------------------+ +--=
------------+
> -
> -
> -=3D=3D Components introduction =3D=3D
> -
> -You can see there are several components in COLO's diagram of architectu=
re.
> -Their functions are described below.
> -
> -HeartBeat:
> -Runs on both the primary and secondary nodes, to periodically check plat=
form
> -availability. When the primary node suffers a hardware fail-stop failure,
> -the heartbeat stops responding, the secondary node will trigger a failov=
er
> -as soon as it determines the absence.
> -
> -COLO disk Manager:
> -When primary VM writes data into image, the colo disk manager captures t=
his data
> -and sends it to secondary VM's which makes sure the context of secondary=
 VM's
> -image is consistent with the context of primary VM 's image.
> -For more details, please refer to docs/block-replication.txt.
> -
> -Checkpoint/Failover Controller:
> -Modifications of save/restore flow to realize continuous migration,
> -to make sure the state of VM in Secondary side is always consistent with=
 VM in
> -Primary side.
> -
> -COLO Proxy:
> -Delivers packets to Primary and Secondary, and then compare the response=
s from
> -both side. Then decide whether to start a checkpoint according to some r=
ules.
> -Please refer to docs/colo-proxy.txt for more information.
> -
> -Note:
> -HeartBeat has not been implemented yet, so you need to trigger failover =
process
> -by using 'x-colo-lost-heartbeat' command.
> -
> -=3D=3D COLO operation status =3D=3D
> -
> -+-----------------+
> -|                 |
> -|    Start COLO   |
> -|                 |
> -+--------+--------+
> -         |
> -         |  Main qmp command:
> -         |  migrate-set-capabilities with x-colo
> -         |  migrate
> -         |
> -         v
> -+--------+--------+
> -|                 |
> -|  COLO running   |
> -|                 |
> -+--------+--------+
> -         |
> -         |  Main qmp command:
> -         |  x-colo-lost-heartbeat
> -         |  or
> -         |  some error happened
> -         v
> -+--------+--------+
> -|                 |  send qmp event:
> -|  COLO failover  |  COLO_EXIT
> -|                 |
> -+-----------------+
> -
> -COLO use the qmp command to switch and report operation status.
> -The diagram just shows the main qmp command, you can get the detail
> -in test procedure.
> -
> -=3D=3D Test procedure =3D=3D
> -Note: Here we are running both instances on the same host for testing,
> -change the IP Addresses if you want to run it on two hosts. Initially
> -127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
> -
> -=3D=3D Startup qemu =3D=3D
> -1. Primary:
> -Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all ho=
sts.
> -You don't need to change any IP's here, because 0.0.0.0 listens on any
> -interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
> -instance.
> -
> -# imagefolder=3D"/mnt/vms/colo-test-primary"
> -
> -# qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -smp 1=
 -qmp stdio \
> -   -device piix3-usb-uhci -device usb-tablet -name primary \
> -   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-h=
elper \
> -   -device rtl8139,id=3De0,netdev=3Dhn0 \
> -   -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server=3Don,w=
ait=3Doff \
> -   -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server=3Don,=
wait=3Don \
> -   -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server=3Do=
n,wait=3Doff \
> -   -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
> -   -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,server=
=3Don,wait=3Doff \
> -   -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
> -   -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror=
0 \
> -   -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=
=3Dcompare_out \
> -   -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=
=3Dcompare0 \
> -   -object iothread,id=3Diothread1 \
> -   -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=
=3Dcompare1,\
> -outdev=3Dcompare_out0,iothread=3Diothread1 \
> -   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,v=
ote-threshold=3D1,\
> -children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.driver=
=3Dqcow2 -S
> -
> -2. Secondary:
> -Note: Active and hidden images need to be created only once and the
> -size should be the same as primary.qcow2. Again, you don't need to change
> -any IP's here, except for the $primary_ip variable.
> -
> -# imagefolder=3D"/mnt/vms/colo-test-secondary"
> -# primary_ip=3D127.0.0.1
> -
> -# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
> -
> -# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
> -
> -# qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -smp 1=
 -qmp stdio \
> -   -device piix3-usb-uhci -device usb-tablet -name secondary \
> -   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-h=
elper \
> -   -device rtl8139,id=3De0,netdev=3Dhn0 \
> -   -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect-ms=
=3D1000 \
> -   -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect-ms=
=3D1000 \
> -   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred=
0 \
> -   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dre=
d1 \
> -   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> -   -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary.qc=
ow2,driver=3Dqcow2 \
> -   -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,f=
ile.driver=3Dqcow2,\
> -top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/secondary-active.q=
cow2,\
> -file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolder/se=
condary-hidden.qcow2,\
> -file.backing.backing=3Dparent0 \
> -   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,v=
ote-threshold=3D1,\
> -children.0=3Dchilds0 \
> -   -incoming tcp:0.0.0.0:9998
> -
> -
> -3. On Secondary VM's QEMU monitor, issue command
> -{"execute":"qmp_capabilities"}
> -{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ =
{"capability": "x-colo", "state": true } ] } }
> -{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "=
data": {"host": "0.0.0.0", "port": "9999"} } } }
> -{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writab=
le": true } }
> -
> -Note:
> -  a. The qmp command nbd-server-start and nbd-server-add must be run
> -     before running the qmp command migrate on primary QEMU
> -  b. Active disk, hidden disk and nbd target's length should be the
> -     same.
> -  c. It is better to put active disk and hidden disk in ramdisk. They
> -     will be merged into the parent disk on failover.
> -
> -4. On Primary VM's QEMU monitor, issue command:
> -{"execute":"qmp_capabilities"}
> -{"execute": "human-monitor-command", "arguments": {"command-line": "driv=
e_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.h=
ost=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicat=
ion0"}}
> -{"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "n=
ode": "replication0" } }
> -{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ =
{"capability": "x-colo", "state": true } ] } }
> -{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
> -
> -  Note:
> -  a. There should be only one NBD Client for each primary disk.
> -  b. The qmp command line must be run after running qmp command line in
> -     secondary qemu.
> -
> -5. After the above steps, you will see, whenever you make changes to PVM=
, SVM will be synced.
> -You can issue command '{ "execute": "migrate-set-parameters" , "argument=
s":{ "x-checkpoint-delay": 2000 } }'
> -to change the idle checkpoint period time
> -
> -6. Failover test
> -You can kill one of the VMs and Failover on the surviving VM:
> -
> -If you killed the Secondary, then follow "Primary Failover". After that,
> -if you want to resume the replication, follow "Primary resume replicatio=
n"
> -
> -If you killed the Primary, then follow "Secondary Failover". After that,
> -if you want to resume the replication, follow "Secondary resume replicat=
ion"
> -
> -=3D=3D Primary Failover =3D=3D
> -The Secondary died, resume on the Primary
> -
> -{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "=
child": "children.1"} }
> -{"execute": "human-monitor-command", "arguments":{ "command-line": "driv=
e_del replication0" } }
> -{"execute": "object-del", "arguments":{ "id": "comp0" } }
> -{"execute": "object-del", "arguments":{ "id": "iothread1" } }
> -{"execute": "object-del", "arguments":{ "id": "m0" } }
> -{"execute": "object-del", "arguments":{ "id": "redire0" } }
> -{"execute": "object-del", "arguments":{ "id": "redire1" } }
> -{"execute": "x-colo-lost-heartbeat" }
> -
> -=3D=3D Secondary Failover =3D=3D
> -The Primary died, resume on the Secondary and prepare to become the new =
Primary
> -
> -{"execute": "nbd-server-stop"}
> -{"execute": "x-colo-lost-heartbeat"}
> -
> -{"execute": "object-del", "arguments":{ "id": "f2" } }
> -{"execute": "object-del", "arguments":{ "id": "f1" } }
> -{"execute": "chardev-remove", "arguments":{ "id": "red1" } }
> -{"execute": "chardev-remove", "arguments":{ "id": "red0" } }
> -
> -{"execute": "chardev-add", "arguments":{ "id": "mirror0", "backend": {"t=
ype": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.0=
.0", "port": "9003" } }, "server": true } } } }
> -{"execute": "chardev-add", "arguments":{ "id": "compare1", "backend": {"=
type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.=
0.0", "port": "9004" } }, "server": true } } } }
> -{"execute": "chardev-add", "arguments":{ "id": "compare0", "backend": {"=
type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.=
0.0.1", "port": "9001" } }, "server": true } } } }
> -{"execute": "chardev-add", "arguments":{ "id": "compare0-0", "backend": =
{"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "12=
7.0.0.1", "port": "9001" } }, "server": false } } } }
> -{"execute": "chardev-add", "arguments":{ "id": "compare_out", "backend":=
 {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "1=
27.0.0.1", "port": "9005" } }, "server": true } } } }
> -{"execute": "chardev-add", "arguments":{ "id": "compare_out0", "backend"=
: {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "=
127.0.0.1", "port": "9005" } }, "server": false } } } }
> -
> -=3D=3D Primary resume replication =3D=3D
> -Resume replication after new Secondary is up.
> -
> -Start the new Secondary (Steps 2 and 3 above), then on the Primary:
> -{"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-i=
d": "resync", "target": "nbd://127.0.0.2:9999/parent0", "mode": "existing",=
 "format": "raw", "sync": "full"} }
> -
> -Wait until disk is synced, then:
> -{"execute": "stop"}
> -{"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
> -
> -{"execute": "human-monitor-command", "arguments":{ "command-line": "driv=
e_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.h=
ost=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicat=
ion0"}}
> -{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "=
node": "replication0" } }
> -
> -{"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id=
": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector",=
 "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector",=
 "id": "redire1", "netdev": "hn0", "queue": "rx", "outdev": "compare0" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "i=
othread1" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id"=
: "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev"=
: "compare_out0", "iothread": "iothread1" } }
> -
> -{"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ =
{"capability": "x-colo", "state": true } ] } }
> -{"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.2:9998" } }
> -
> -Note:
> -If this Primary previously was a Secondary, then we need to insert the
> -filters before the filter-rewriter by using the
> -""insert": "before", "position": "id=3Drew0"" Options. See below.
> -
> -=3D=3D Secondary resume replication =3D=3D
> -Become Primary and resume replication after new Secondary is up. Note
> -that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
> -
> -Start the new Secondary (Steps 2 and 3 above, but with primary_ip=3D127.=
0.0.2),
> -then on the old Secondary:
> -{"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-i=
d": "resync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existing",=
 "format": "raw", "sync": "full"} }
> -
> -Wait until disk is synced, then:
> -{"execute": "stop"}
> -{"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
> -
> -{"execute": "human-monitor-command", "arguments":{ "command-line": "driv=
e_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.h=
ost=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicat=
ion0"}}
> -{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "=
node": "replication0" } }
> -
> -{"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id=
": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", "que=
ue": "tx", "outdev": "mirror0" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector",=
 "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev": "h=
n0", "queue": "rx", "indev": "compare_out" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector",=
 "id": "redire1", "insert": "before", "position": "id=3Drew0", "netdev": "h=
n0", "queue": "rx", "outdev": "compare0" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "i=
othread1" } }
> -{"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id"=
: "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev"=
: "compare_out0", "iothread": "iothread1" } }
> -
> -{"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ =
{"capability": "x-colo", "state": true } ] } }
> -{"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
> -
> -=3D=3D TODO =3D=3D
> -1. Support shared storage.
> -2. Develop the heartbeat part.
> -3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 427b020483104f6589878bbf255a367ae114c61b..6268c41aea9c74dc3e59d896b=
5ae082360bfbb1a 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -41,3 +41,4 @@ or Hypervisor.Framework.
>     igvm
>     vm-templating
>     sriov
> +   qemu-colo
> diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..4b5fbbf398f8a5c4ea6baad61=
5bde94b2b4678d2
> --- /dev/null
> +++ b/docs/system/qemu-colo.rst
> @@ -0,0 +1,360 @@
> +Qemu COLO Fault Tolerance
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +| Copyright (c) 2016 Intel Corporation
> +| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> +| Copyright (c) 2016 Fujitsu, Corp.
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later.
> +See the COPYING file in the top-level directory.
> +
> +This document gives an overview of COLO's design and how to use it.
> +
> +Background
> +----------
> +Virtual machine (VM) replication is a well known technique for providing
> +application-agnostic software-implemented hardware fault tolerance,
> +also known as "non-stop service".
> +
> +COLO (COarse-grained LOck-stepping) is a high availability solution.
> +Both primary VM (PVM) and secondary VM (SVM) run in parallel. They recei=
ve the
> +same request from client, and generate response in parallel too.
> +If the response packets from PVM and SVM are identical, they are released
> +immediately. Otherwise, a VM checkpoint (on demand) is conducted.
> +
> +Architecture
> +------------
> +The architecture of COLO is shown in the diagram below.
> +It consists of a pair of networked physical nodes:
> +The primary node running the PVM, and the secondary node running the SVM
> +to maintain a valid replica of the PVM.
> +PVM and SVM execute in parallel and generate output of response packets =
for
> +client requests according to the application semantics.
> +
> +The incoming packets from the client or external network are received by=
 the
> +primary node, and then forwarded to the secondary node, so that both the=
 PVM
> +and the SVM are stimulated with the same requests.
> +
> +COLO receives the outbound packets from both the PVM and SVM and compare=
s them
> +before allowing the output to be sent to clients.
> +
> +The SVM is qualified as a valid replica of the PVM, as long as it genera=
tes
> +identical responses to all client requests. Once the differences in the =
outputs
> +are detected between the PVM and SVM, COLO withholds transmission of the
> +outbound packets until it has successfully synchronized the PVM state to=
 the SVM.
> +
> +Overview::
> +
> +      Primary Node                                                      =
      Secondary Node
> +    +------------+  +-----------------------+       +-------------------=
-----+  +------------+
> +    |            |  |       HeartBeat       +<----->+       HeartBeat   =
     |  |            |
> +    | Primary VM |  +-----------+-----------+       +-----------+-------=
-----+  |Secondary VM|
> +    |            |              |                               |       =
        |            |
> +    |            |  +-----------|-----------+       +-----------|-------=
-----+  |            |
> +    |            |  |QEMU   +---v----+      |       |QEMU  +----v---+   =
     |  |            |
> +    |            |  |       |Failover|      |       |      |Failover|   =
     |  |            |
> +    |            |  |       +--------+      |       |      +--------+   =
     |  |            |
> +    |            |  |   +---------------+   |       |   +---------------=
+    |  |            |
> +    |            |  |   | VM Checkpoint +-------------->+ VM Checkpoint =
|    |  |            |
> +    |            |  |   +---------------+   |       |   +---------------=
+    |  |            |
> +    |Requests<--------------------------\ /-----------------\ /---------=
------------>Requests|
> +    |            |  |                   ^ ^ |       |       | |         =
     |  |            |
> +    |Responses+---------------------\ /-|-|------------\ /--------------=
-----------+Responses|
> +    |            |  |               | | | | |       |  | |  | |         =
     |  |            |
> +    |            |  | +-----------+ | | | | |       |  | |  | | +-------=
---+ |  |            |
> +    |            |  | | COLO disk | | | | | |       |  | |  | | | COLO d=
isk| |  |            |
> +    |            |  | |   Manager +---------------------------->| Manage=
r  | |  |            |
> +    |            |  | ++----------+ v v | | |       |  | v  v | +-------=
--++ |  |            |
> +    |            |  |  |+-----------+-+-+-++|       | ++-+--+-+---------=
+ |  |  |            |
> +    |            |  |  ||   COLO Proxy     ||       | |   COLO Proxy    =
| |  |  |            |
> +    |            |  |  || (compare packet  ||       | |(adjust sequence =
| |  |  |            |
> +    |            |  |  ||and mirror packet)||       | |    and ACK)     =
| |  |  |            |
> +    |            |  |  |+------------+---+-+|       | +-----------------=
+ |  |  |            |
> +    +------------+  +-----------------------+       +-------------------=
-----+  +------------+
> +    +------------+     |             |   |                              =
  |     +------------+
> +    | VM Monitor |     |             |   |                              =
  |     | VM Monitor |
> +    +------------+     |             |   |                              =
  |     +------------+
> +    +---------------------------------------+       +-------------------=
---------------------+
> +    |   Kernel         |             |   |  |       |   Kernel          =
  |                  |
> +    +---------------------------------------+       +-------------------=
---------------------+
> +                       |             |   |                              =
  |
> +        +--------------v+  +---------v---+--+       +------------------+=
 +v-------------+
> +        |   Storage     |  |External Network|       | External Network |=
 |   Storage    |
> +        +---------------+  +----------------+       +------------------+=
 +--------------+
> +
> +Components introduction
> +^^^^^^^^^^^^^^^^^^^^^^^
> +You can see there are several components in COLO's diagram of architectu=
re.
> +Their functions are described below.
> +
> +HeartBeat
> +~~~~~~~~~
> +Runs on both the primary and secondary nodes, to periodically check plat=
form
> +availability. When the primary node suffers a hardware fail-stop failure,
> +the heartbeat stops responding, the secondary node will trigger a failov=
er
> +as soon as it determines the absence.
> +
> +COLO disk Manager
> +~~~~~~~~~~~~~~~~~
> +When primary VM writes data into image, the colo disk manager captures t=
his data
> +and sends it to secondary VM's which makes sure the context of secondary=
 VM's
> +image is consistent with the context of primary VM 's image.
> +For more details, please refer to docs/block-replication.txt.
> +
> +Checkpoint/Failover Controller
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Modifications of save/restore flow to realize continuous migration,
> +to make sure the state of VM in Secondary side is always consistent with=
 VM in
> +Primary side.
> +
> +COLO Proxy
> +~~~~~~~~~~
> +Delivers packets to Primary and Secondary, and then compare the response=
s from
> +both side. Then decide whether to start a checkpoint according to some r=
ules.
> +Please refer to docs/colo-proxy.txt for more information.
> +
> +Note:
> +HeartBeat has not been implemented yet, so you need to trigger failover =
process
> +by using 'x-colo-lost-heartbeat' command.
> +
> +COLO operation status
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +Overview::
> +
> +    +-----------------+
> +    |                 |
> +    |    Start COLO   |
> +    |                 |
> +    +--------+--------+
> +             |
> +             |  Main qmp command:
> +             |  migrate-set-capabilities with x-colo
> +             |  migrate
> +             |
> +             v
> +    +--------+--------+
> +    |                 |
> +    |  COLO running   |
> +    |                 |
> +    +--------+--------+
> +             |
> +             |  Main qmp command:
> +             |  x-colo-lost-heartbeat
> +             |  or
> +             |  some error happened
> +             v
> +    +--------+--------+
> +    |                 |  send qmp event:
> +    |  COLO failover  |  COLO_EXIT
> +    |                 |
> +    +-----------------+
> +
> +
> +COLO use the qmp command to switch and report operation status.
> +The diagram just shows the main qmp command, you can get the detail
> +in test procedure.
> +
> +Test procedure
> +--------------
> +Note: Here we are running both instances on the same host for testing,
> +change the IP Addresses if you want to run it on two hosts. Initially
> +``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Hos=
t.
> +
> +Startup qemu
> +^^^^^^^^^^^^
> +**1. Primary**:
> +Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to al=
l hosts.
> +You don't need to change any IP's here, because ``0.0.0.0`` listens on a=
ny
> +interface. The chardev's with ``127.0.0.1`` IP's loopback to the local q=
emu
> +instance::
> +
> +    # imagefolder=3D"/mnt/vms/colo-test-primary"
> +
> +    # qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -s=
mp 1 -qmp stdio \
> +       -device piix3-usb-uhci -device usb-tablet -name primary \
> +       -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-brid=
ge-helper \
> +       -device rtl8139,id=3De0,netdev=3Dhn0 \
> +       -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server=3D=
on,wait=3Doff \
> +       -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server=
=3Don,wait=3Don \
> +       -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server=
=3Don,wait=3Doff \
> +       -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
> +       -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,ser=
ver=3Don,wait=3Doff \
> +       -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
> +       -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmi=
rror0 \
> +       -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,in=
dev=3Dcompare_out \
> +       -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,ou=
tdev=3Dcompare0 \
> +       -object iothread,id=3Diothread1 \
> +       -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary=
_in=3Dcompare1,\
> +    outdev=3Dcompare_out0,iothread=3Diothread1 \
> +       -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfi=
fo,vote-threshold=3D1,\
> +    children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.dri=
ver=3Dqcow2 -S
> +
> +
> +**2. Secondary**:
> +Note: Active and hidden images need to be created only once and the
> +size should be the same as ``primary.qcow2``. Again, you don't need to c=
hange
> +any IP's here, except for the ``$primary_ip`` variable::
> +
> +    # imagefolder=3D"/mnt/vms/colo-test-secondary"
> +    # primary_ip=3D127.0.0.1
> +
> +    # qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
> +
> +    # qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
> +
> +    # qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -s=
mp 1 -qmp stdio \
> +       -device piix3-usb-uhci -device usb-tablet -name secondary \
> +       -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-brid=
ge-helper \
> +       -device rtl8139,id=3De0,netdev=3Dhn0 \
> +       -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnec=
t-ms=3D1000 \
> +       -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnec=
t-ms=3D1000 \
> +       -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=
=3Dred0 \
> +       -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=
=3Dred1 \
> +       -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> +       -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primar=
y.qcow2,driver=3Dqcow2 \
> +       -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dseconda=
ry,file.driver=3Dqcow2,\
> +    top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/secondary-acti=
ve.qcow2,\
> +    file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolde=
r/secondary-hidden.qcow2,\
> +    file.backing.backing=3Dparent0 \
> +       -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfi=
fo,vote-threshold=3D1,\
> +    children.0=3Dchilds0 \
> +       -incoming tcp:0.0.0.0:9998
> +
> +
> +**3.** On Secondary VM's QEMU monitor, issue command::
> +
> +    {"execute":"qmp_capabilities"}
> +    {"execute": "migrate-set-capabilities", "arguments": {"capabilities"=
: [ {"capability": "x-colo", "state": true } ] } }
> +    {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet=
", "data": {"host": "0.0.0.0", "port": "9999"} } } }
> +    {"execute": "nbd-server-add", "arguments": {"device": "parent0", "wr=
itable": true } }
> +
> +Note:
> +  a. The qmp command ``nbd-server-start`` and ``nbd-server-add`` must be=
 run
> +     before running the qmp command migrate on primary QEMU
> +  b. Active disk, hidden disk and nbd target's length should be the
> +     same.
> +  c. It is better to put active disk and hidden disk in ramdisk. They
> +     will be merged into the parent disk on failover.
> +
> +**4.** On Primary VM's QEMU monitor, issue command::
> +
> +    {"execute":"qmp_capabilities"}
> +    {"execute": "human-monitor-command", "arguments": {"command-line": "=
drive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drepl=
ication0"}}
> +    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0"=
, "node": "replication0" } }
> +    {"execute": "migrate-set-capabilities", "arguments": {"capabilities"=
: [ {"capability": "x-colo", "state": true } ] } }
> +    {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
> +
> +Note:
> +  a. There should be only one NBD Client for each primary disk.
> +  b. The qmp command line must be run after running qmp command line in
> +     secondary qemu.
> +
> +**5.** After the above steps, you will see, whenever you make changes to=
 PVM, SVM will be synced.
> +You can issue command ``{ "execute": "migrate-set-parameters" , "argumen=
ts":{ "x-checkpoint-delay": 2000 } }``
> +to change the idle checkpoint period time
> +
> +Failover test
> +^^^^^^^^^^^^^
> +You can kill one of the VMs and Failover on the surviving VM:
> +
> +If you killed the Secondary, then follow "Primary Failover".
> +After that, if you want to resume the replication, follow "Primary resum=
e replication"
> +
> +If you killed the Primary, then follow "Secondary Failover".
> +After that, if you want to resume the replication, follow "Secondary res=
ume replication"
> +
> +Primary Failover
> +~~~~~~~~~~~~~~~~
> +The Secondary died, resume on the Primary::
> +
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0=
", "child": "children.1"} }
> +    {"execute": "human-monitor-command", "arguments":{ "command-line": "=
drive_del replication0" } }
> +    {"execute": "object-del", "arguments":{ "id": "comp0" } }
> +    {"execute": "object-del", "arguments":{ "id": "iothread1" } }
> +    {"execute": "object-del", "arguments":{ "id": "m0" } }
> +    {"execute": "object-del", "arguments":{ "id": "redire0" } }
> +    {"execute": "object-del", "arguments":{ "id": "redire1" } }
> +    {"execute": "x-colo-lost-heartbeat" }
> +
> +Secondary Failover
> +~~~~~~~~~~~~~~~~~~
> +The Primary died, resume on the Secondary and prepare to become the new =
Primary::
> +
> +    {"execute": "nbd-server-stop"}
> +    {"execute": "x-colo-lost-heartbeat"}
> +
> +    {"execute": "object-del", "arguments":{ "id": "f2" } }
> +    {"execute": "object-del", "arguments":{ "id": "f1" } }
> +    {"execute": "chardev-remove", "arguments":{ "id": "red1" } }
> +    {"execute": "chardev-remove", "arguments":{ "id": "red0" } }
> +
> +    {"execute": "chardev-add", "arguments":{ "id": "mirror0", "backend":=
 {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0=
.0.0.0", "port": "9003" } }, "server": true } } } }
> +    {"execute": "chardev-add", "arguments":{ "id": "compare1", "backend"=
: {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "=
0.0.0.0", "port": "9004" } }, "server": true } } } }
> +    {"execute": "chardev-add", "arguments":{ "id": "compare0", "backend"=
: {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "=
127.0.0.1", "port": "9001" } }, "server": true } } } }
> +    {"execute": "chardev-add", "arguments":{ "id": "compare0-0", "backen=
d": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host":=
 "127.0.0.1", "port": "9001" } }, "server": false } } } }
> +    {"execute": "chardev-add", "arguments":{ "id": "compare_out", "backe=
nd": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host"=
: "127.0.0.1", "port": "9005" } }, "server": true } } } }
> +    {"execute": "chardev-add", "arguments":{ "id": "compare_out0", "back=
end": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host=
": "127.0.0.1", "port": "9005" } }, "server": false } } } }
> +
> +Primary resume replication
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Resume replication after new Secondary is up.
> +
> +Start the new Secondary (Steps 2 and 3 above), then on the Primary::
> +
> +    {"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "j=
ob-id": "resync", "target": "nbd://127.0.0.2:9999/parent0", "mode": "existi=
ng", "format": "raw", "sync": "full"} }
> +
> +Wait until disk is synced, then::
> +
> +    {"execute": "stop"}
> +    {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
> +
> +    {"execute": "human-monitor-command", "arguments":{ "command-line": "=
drive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drepl=
ication0"}}
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0=
", "node": "replication0" } }
> +
> +    {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror",=
 "id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirect=
or", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out=
" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirect=
or", "id": "redire1", "netdev": "hn0", "queue": "rx", "outdev": "compare0" =
} }
> +    {"execute": "object-add", "arguments":{ "qom-type": "iothread", "id"=
: "iothread1" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "colo-compare", =
"id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "out=
dev": "compare_out0", "iothread": "iothread1" } }
> +
> +    {"execute": "migrate-set-capabilities", "arguments":{ "capabilities"=
: [ {"capability": "x-colo", "state": true } ] } }
> +    {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.2:9998" } }
> +
> +Note:
> +If this Primary previously was a Secondary, then we need to insert the
> +filters before the filter-rewriter by using the
> +""insert": "before", "position": "id=3Drew0"" Options. See below.
> +
> +Secondary resume replication
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Become Primary and resume replication after new Secondary is up. Note
> +that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
> +
> +Start the new Secondary (Steps 2 and 3 above, but with primary_ip=3D127.=
0.0.2),
> +then on the old Secondary::
> +
> +    {"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "j=
ob-id": "resync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existi=
ng", "format": "raw", "sync": "full"} }
> +
> +Wait until disk is synced, then::
> +
> +    {"execute": "stop"}
> +    {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
> +
> +    {"execute": "human-monitor-command", "arguments":{ "command-line": "=
drive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Drepl=
ication0"}}
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0=
", "node": "replication0" } }
> +
> +    {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror",=
 "id": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", =
"queue": "tx", "outdev": "mirror0" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirect=
or", "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "indev": "compare_out" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirect=
or", "id": "redire1", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "outdev": "compare0" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "iothread", "id"=
: "iothread1" } }
> +    {"execute": "object-add", "arguments":{ "qom-type": "colo-compare", =
"id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "out=
dev": "compare_out0", "iothread": "iothread1" } }
> +
> +    {"execute": "migrate-set-capabilities", "arguments":{ "capabilities"=
: [ {"capability": "x-colo", "state": true } ] } }
> +    {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
> +
> +TODO
> +----
> +1. Support shared storage.
> +2. Develop the heartbeat part.
> +3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

