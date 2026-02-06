Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1298EB28D6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGZS-00077z-Dn; Fri, 06 Feb 2026 02:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voGZQ-00077r-Qz
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:48:04 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voGZM-00046L-Dq
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:48:04 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b885e8c6700so323117166b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 23:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770364079; cv=none;
 d=google.com; s=arc-20240605;
 b=SFY5BSxqbZwkXOPDGTVM4ef3IIKoVEVXqOYT/W2LAMjJAytSe4SdRr91dktwO5c+Sk
 c5tz6cIaVPcZuatvmVWmDxTB+jlDxxTxj1wgbbJ/CHHAnzVHfLp5Zij+4qnKOAQi+lEL
 s4NHXS4vqQRCx7RvkzgPBpzUUMKHOuqlCt6GilS5u+9RsbKmOILg6iXMR90z7aC74a0b
 APaXDzQ57aty6L8gxCMwgebP53phDGQYCYC9UdjDgNM3+QaYHMWHlXuttz7og+dhT+RL
 dRdcMB34pRe9RYOo7OVSstlXQpm9ag1DzPaFcstkRwbS2lTBqdQeyEslb0eXu7cnWYbR
 Omag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FulT5yyLtysENX34VY3rU9W3eTOixaW6VJZPIe9mAQc=;
 fh=Q60oc1Mwo+n6KVl0/HzulOCo07LbH2MP95czanFwixA=;
 b=cNa7olJ/mWqGwRS1/fvYTKP+PS9WvIdvacXu+wZZNu+toa+vDyfgGIHzHtXO/DooGw
 98W3xAF2fVoLqdh9wP0LVmlIOUSJGadrjX3oy4V3+Yi3ulXIPBbdZGTtVAqWc+EBz8gN
 ZPHZrlsEFeenVd6ZB/PeU9rXK9WIVPbJo8tOGz2ApLmZAiCpNsFMUDv7HQWgIN4T2Pk5
 LOkP/8xzJndEVohqtFADmsigzp71LDHv8fHLe+sbK7RU0nUxhVR7tAsZM+8uRHcZNSCU
 pcQoa+gkBLaoUu8i9WjOo8SPAfb5kCP2mpJ1Zffhp3DXBiyJHWPLlVuwx/QOmNENgPz+
 rALg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770364079; x=1770968879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FulT5yyLtysENX34VY3rU9W3eTOixaW6VJZPIe9mAQc=;
 b=mmcTPGcH8UZfuQ3sEf0xZlSKeCB7OxN0DK5VFpG7owlUTY3t5REWzCKJ1k0RGThFzW
 K2IQTgdVCOuRIZpaGE1htfjmbFwPXznI1Pg85tnIjp1kBKdHLliD8ORz+b47tO7Wfyaf
 XZ2NeouHVprQUSVIEBi5t9cDPW2xKNAbdjpFV+H+lWhSN3CCnANAT7f2ywrSADOoAOVv
 5R6huglV+FdnbDpHoVeCTNqBKj4B7n8vfqxgeoj4PqLvvhAEKyW/TbN0dwFZbXIX79p9
 ISueZT5gZ6BiU6TfR17OCj3VYdtnHT8YaQytQswdzqRs4GD8HJNUMR/ijJGWpcvUYx0f
 784A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770364079; x=1770968879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FulT5yyLtysENX34VY3rU9W3eTOixaW6VJZPIe9mAQc=;
 b=IabnUMsMYiSC4yfwIuuXNJUNDjC7+uIJ9buS3y5BQJI+4siRo3F3ZjHfsEJKPSleF/
 FZ5490K3fq57+n08Tz57TiclqIchv9wkMeoru3jtzCpAavc+paGK72X5v7WVq6txrebV
 xC04PyDVnrefEY7jc+pceaeFsCzucjdB9HBAWgy2fKGIzTWMOC0+Rb81D4rR7GyCVpwG
 CD+957MHVa17v6S0Qgrk4JhvGnaZSRvHo+4n3dU77L1PKFALIIfRjEEDOm+/A+QKAl3A
 /32RR8m13gnHF9T+bLt8yCN40iPFZAYq99cr2F2ETdzrRqYXdjMVAL+rjwGc5/89MWNk
 VbJg==
X-Gm-Message-State: AOJu0YyIJpJWX+Fk0K2GcCMzzKZyBbWRChNeqUB4E8b5utlR8AORSELZ
 nRbDH5I4XAfuDNwnFWbE9klGIe/T0X4ygb1OgMYehO0mpwkqhA+yuL1Ovo7pASojwfDMNqzq5gk
 RPo67bt7mKRAMBK7amCWOGFmegFInXt0=
X-Gm-Gg: AZuq6aJrr2lm95Jrs8XNNL8YqN0bAR2RuE01HFLlsKI/KVb0HYF9QKJgmxWNLk3t5Qj
 WdQpgFTdrJJ92N24NYwUV6QS6qHgHly3sps8HCisMNQnpf/ErplTaA5Fcsne1NeUIue5PZOuLW4
 nmzLmyzEsd1I6Q0vVeDXBC3WDCT/zSTO+lXsXpAIpbJ0p67H7vshp/bc3xw+Zx12Iv/3RL2rPch
 MJ2gW1BTAfcLY1hI0WQC8QxB8/JhEYx9jvydJtniaWBC90/FrM8RHPa0VvHJXn6XutYpWLS
X-Received: by 2002:a17:907:2d8d:b0:b73:7b97:5bfb with SMTP id
 a640c23a62f3a-b8edf308fb3mr96272666b.33.1770364078179; Thu, 05 Feb 2026
 23:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-13-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-13-57508b7389f6@web.de>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 6 Feb 2026 15:47:20 +0800
X-Gm-Features: AZwV_Qgjtm8mcU-hLkbfeOB09G7lS80y_-vnOAlcp3Cb5nn2P5p0L9CaW_fYjwI
Message-ID: <CAK3tnv+cYWJ5uxZs6vyamMF=H+56ABZWOg9ziWFDJbCRegx=XQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] Convert colo main documentation to
 restructuredText
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Feb 3, 2026 at 6:15=E2=80=AFPM Lukas Straub <lukasstraub2@web.de> w=
rote:
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

Thanks
Chen

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
> index 8e63e0a08fc7417036986f27c2d910eb99d8a96a..f645590b8b940919bdc84ad58=
5ee493f5452fc20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3855,7 +3855,7 @@ F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
>  F: tests/qtest/migration/colo-tests.c
> -F: docs/COLO-FT.txt
> +F: docs/system/qemu-colo.rst
>
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
> -This work is licensed under the terms of the GNU GPL, version 2 or later=
.
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
> -If the response packets from PVM and SVM are identical, they are release=
d
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
> -availability. When the primary node suffers a hardware fail-stop failure=
,
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
> -size should be the same as primary.qcow2. Again, you don't need to chang=
e
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
 "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } =
}
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
> +This work is licensed under the terms of the GNU GPL, version 2 or later=
.
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
> +If the response packets from PVM and SVM are identical, they are release=
d
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
> +availability. When the primary node suffers a hardware fail-stop failure=
,
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
>
> --
> 2.39.5
>

