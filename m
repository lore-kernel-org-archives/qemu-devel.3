Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29FCF3C24C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLf-0007DU-3b; Mon, 09 Mar 2026 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLU-00077I-SP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLQ-0008CF-HJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15FDE5BDF0;
 Mon,  9 Mar 2026 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8OnIjR5u/OzUFUYJSThemAXkKhJyODkufc4vRWFuFA=;
 b=tLpfyzwJaV47Pk9LqD5yb4+C4bJwrXFBJZft9AlrBLz9EPQiSMUXba2UkL2CooDLCDYt39
 6Z0oxFlfhTkFcimATQWSRa9iQBnSwOFtFd5s5dvXEFuqM1No+CbxLhZUtpnEnogZa2h8U2
 S8vjm4nRHUhVUivTTeiZ2Dk6GicfbwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8OnIjR5u/OzUFUYJSThemAXkKhJyODkufc4vRWFuFA=;
 b=BMBmnWa9m8Z+pPmh2aLelX4sEstn/1FY4Wctf3ysO4yAot06CI14qi9pgIEmifVPmkNJ7Y
 sz5nEo0POMFzPjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8OnIjR5u/OzUFUYJSThemAXkKhJyODkufc4vRWFuFA=;
 b=tLpfyzwJaV47Pk9LqD5yb4+C4bJwrXFBJZft9AlrBLz9EPQiSMUXba2UkL2CooDLCDYt39
 6Z0oxFlfhTkFcimATQWSRa9iQBnSwOFtFd5s5dvXEFuqM1No+CbxLhZUtpnEnogZa2h8U2
 S8vjm4nRHUhVUivTTeiZ2Dk6GicfbwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8OnIjR5u/OzUFUYJSThemAXkKhJyODkufc4vRWFuFA=;
 b=BMBmnWa9m8Z+pPmh2aLelX4sEstn/1FY4Wctf3ysO4yAot06CI14qi9pgIEmifVPmkNJ7Y
 sz5nEo0POMFzPjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AB993EEF2;
 Mon,  9 Mar 2026 13:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MHYgDC7GrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:07:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Zhang Chen <zhangckid@gmail.com>
Subject: [PULL 15/22] Convert colo main documentation to restructuredText
Date: Mon,  9 Mar 2026 10:07:20 -0300
Message-ID: <20260309130730.20526-16-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de,gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260302-colo_unit_test_multifd-v11-14-d653fb3b1d80@web.de
[replaced license boilerplate with SPDX line]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS               |   2 +-
 docs/COLO-FT.txt          | 334 -----------------------------------
 docs/system/index.rst     |   1 +
 docs/system/qemu-colo.rst | 359 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 361 insertions(+), 335 deletions(-)
 delete mode 100644 docs/COLO-FT.txt
 create mode 100644 docs/system/qemu-colo.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 5469cd373a..cdc8e780a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3887,7 +3887,7 @@ F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
 F: tests/qtest/migration/colo-tests.c
-F: docs/COLO-FT.txt
+F: docs/system/qemu-colo.rst
 
 COLO Proxy
 M: Zhang Chen <zhangckid@gmail.com>
diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
deleted file mode 100644
index 2283a09c08..0000000000
--- a/docs/COLO-FT.txt
+++ /dev/null
@@ -1,334 +0,0 @@
-COarse-grained LOck-stepping Virtual Machines for Non-stop Service
-----------------------------------------
-Copyright (c) 2016 Intel Corporation
-Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
-Copyright (c) 2016 Fujitsu, Corp.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
-This document gives an overview of COLO's design and how to use it.
-
-== Background ==
-Virtual machine (VM) replication is a well known technique for providing
-application-agnostic software-implemented hardware fault tolerance,
-also known as "non-stop service".
-
-COLO (COarse-grained LOck-stepping) is a high availability solution.
-Both primary VM (PVM) and secondary VM (SVM) run in parallel. They receive the
-same request from client, and generate response in parallel too.
-If the response packets from PVM and SVM are identical, they are released
-immediately. Otherwise, a VM checkpoint (on demand) is conducted.
-
-== Architecture ==
-
-The architecture of COLO is shown in the diagram below.
-It consists of a pair of networked physical nodes:
-The primary node running the PVM, and the secondary node running the SVM
-to maintain a valid replica of the PVM.
-PVM and SVM execute in parallel and generate output of response packets for
-client requests according to the application semantics.
-
-The incoming packets from the client or external network are received by the
-primary node, and then forwarded to the secondary node, so that both the PVM
-and the SVM are stimulated with the same requests.
-
-COLO receives the outbound packets from both the PVM and SVM and compares them
-before allowing the output to be sent to clients.
-
-The SVM is qualified as a valid replica of the PVM, as long as it generates
-identical responses to all client requests. Once the differences in the outputs
-are detected between the PVM and SVM, COLO withholds transmission of the
-outbound packets until it has successfully synchronized the PVM state to the SVM.
-
-  Primary Node                                                            Secondary Node
-+------------+  +-----------------------+       +------------------------+  +------------+
-|            |  |       HeartBeat       +<----->+       HeartBeat        |  |            |
-| Primary VM |  +-----------+-----------+       +-----------+------------+  |Secondary VM|
-|            |              |                               |               |            |
-|            |  +-----------|-----------+       +-----------|------------+  |            |
-|            |  |QEMU   +---v----+      |       |QEMU  +----v---+        |  |            |
-|            |  |       |Failover|      |       |      |Failover|        |  |            |
-|            |  |       +--------+      |       |      +--------+        |  |            |
-|            |  |   +---------------+   |       |   +---------------+    |  |            |
-|            |  |   | VM Checkpoint +-------------->+ VM Checkpoint |    |  |            |
-|            |  |   +---------------+   |       |   +---------------+    |  |            |
-|Requests<--------------------------\ /-----------------\ /--------------------->Requests|
-|            |  |                   ^ ^ |       |       | |              |  |            |
-|Responses+---------------------\ /-|-|------------\ /-------------------------+Responses|
-|            |  |               | | | | |       |  | |  | |              |  |            |
-|            |  | +-----------+ | | | | |       |  | |  | | +----------+ |  |            |
-|            |  | | COLO disk | | | | | |       |  | |  | | | COLO disk| |  |            |
-|            |  | |   Manager +---------------------------->| Manager  | |  |            |
-|            |  | ++----------+ v v | | |       |  | v  v | +---------++ |  |            |
-|            |  |  |+-----------+-+-+-++|       | ++-+--+-+---------+ |  |  |            |
-|            |  |  ||   COLO Proxy     ||       | |   COLO Proxy    | |  |  |            |
-|            |  |  || (compare packet  ||       | |(adjust sequence | |  |  |            |
-|            |  |  ||and mirror packet)||       | |    and ACK)     | |  |  |            |
-|            |  |  |+------------+---+-+|       | +-----------------+ |  |  |            |
-+------------+  +-----------------------+       +------------------------+  +------------+
-+------------+     |             |   |                                |     +------------+
-| VM Monitor |     |             |   |                                |     | VM Monitor |
-+------------+     |             |   |                                |     +------------+
-+---------------------------------------+       +----------------------------------------+
-|   Kernel         |             |   |  |       |   Kernel            |                  |
-+---------------------------------------+       +----------------------------------------+
-                   |             |   |                                |
-    +--------------v+  +---------v---+--+       +------------------+ +v-------------+
-    |   Storage     |  |External Network|       | External Network | |   Storage    |
-    +---------------+  +----------------+       +------------------+ +--------------+
-
-
-== Components introduction ==
-
-You can see there are several components in COLO's diagram of architecture.
-Their functions are described below.
-
-HeartBeat:
-Runs on both the primary and secondary nodes, to periodically check platform
-availability. When the primary node suffers a hardware fail-stop failure,
-the heartbeat stops responding, the secondary node will trigger a failover
-as soon as it determines the absence.
-
-COLO disk Manager:
-When primary VM writes data into image, the colo disk manager captures this data
-and sends it to secondary VM's which makes sure the context of secondary VM's
-image is consistent with the context of primary VM 's image.
-For more details, please refer to docs/block-replication.txt.
-
-Checkpoint/Failover Controller:
-Modifications of save/restore flow to realize continuous migration,
-to make sure the state of VM in Secondary side is always consistent with VM in
-Primary side.
-
-COLO Proxy:
-Delivers packets to Primary and Secondary, and then compare the responses from
-both side. Then decide whether to start a checkpoint according to some rules.
-Please refer to docs/colo-proxy.txt for more information.
-
-Note:
-HeartBeat has not been implemented yet, so you need to trigger failover process
-by using 'x-colo-lost-heartbeat' command.
-
-== COLO operation status ==
-
-+-----------------+
-|                 |
-|    Start COLO   |
-|                 |
-+--------+--------+
-         |
-         |  Main qmp command:
-         |  migrate-set-capabilities with x-colo
-         |  migrate
-         |
-         v
-+--------+--------+
-|                 |
-|  COLO running   |
-|                 |
-+--------+--------+
-         |
-         |  Main qmp command:
-         |  x-colo-lost-heartbeat
-         |  or
-         |  some error happened
-         v
-+--------+--------+
-|                 |  send qmp event:
-|  COLO failover  |  COLO_EXIT
-|                 |
-+-----------------+
-
-COLO use the qmp command to switch and report operation status.
-The diagram just shows the main qmp command, you can get the detail
-in test procedure.
-
-== Test procedure ==
-Note: Here we are running both instances on the same host for testing,
-change the IP Addresses if you want to run it on two hosts. Initially
-127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
-
-== Startup qemu ==
-1. Primary:
-Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all hosts.
-You don't need to change any IP's here, because 0.0.0.0 listens on any
-interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
-instance.
-
-# imagefolder="/mnt/vms/colo-test-primary"
-
-# qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=on -m 512 -smp 1 -qmp stdio \
-   -device piix3-usb-uhci -device usb-tablet -name primary \
-   -netdev tap,id=hn0,vhost=off,helper=/usr/lib/qemu/qemu-bridge-helper \
-   -device rtl8139,id=e0,netdev=hn0 \
-   -chardev socket,id=mirror0,host=0.0.0.0,port=9003,server=on,wait=off \
-   -chardev socket,id=compare1,host=0.0.0.0,port=9004,server=on,wait=on \
-   -chardev socket,id=compare0,host=127.0.0.1,port=9001,server=on,wait=off \
-   -chardev socket,id=compare0-0,host=127.0.0.1,port=9001 \
-   -chardev socket,id=compare_out,host=127.0.0.1,port=9005,server=on,wait=off \
-   -chardev socket,id=compare_out0,host=127.0.0.1,port=9005 \
-   -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0 \
-   -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out \
-   -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0 \
-   -object iothread,id=iothread1 \
-   -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,\
-outdev=compare_out0,iothread=iothread1 \
-   -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
-children.0.file.filename=$imagefolder/primary.qcow2,children.0.driver=qcow2 -S
-
-2. Secondary:
-Note: Active and hidden images need to be created only once and the
-size should be the same as primary.qcow2. Again, you don't need to change
-any IP's here, except for the $primary_ip variable.
-
-# imagefolder="/mnt/vms/colo-test-secondary"
-# primary_ip=127.0.0.1
-
-# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
-
-# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
-
-# qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=on -m 512 -smp 1 -qmp stdio \
-   -device piix3-usb-uhci -device usb-tablet -name secondary \
-   -netdev tap,id=hn0,vhost=off,helper=/usr/lib/qemu/qemu-bridge-helper \
-   -device rtl8139,id=e0,netdev=hn0 \
-   -chardev socket,id=red0,host=$primary_ip,port=9003,reconnect-ms=1000 \
-   -chardev socket,id=red1,host=$primary_ip,port=9004,reconnect-ms=1000 \
-   -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0 \
-   -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1 \
-   -object filter-rewriter,id=rew0,netdev=hn0,queue=all \
-   -drive if=none,id=parent0,file.filename=$imagefolder/primary.qcow2,driver=qcow2 \
-   -drive if=none,id=childs0,driver=replication,mode=secondary,file.driver=qcow2,\
-top-id=colo-disk0,file.file.filename=$imagefolder/secondary-active.qcow2,\
-file.backing.driver=qcow2,file.backing.file.filename=$imagefolder/secondary-hidden.qcow2,\
-file.backing.backing=parent0 \
-   -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
-children.0=childs0 \
-   -incoming tcp:0.0.0.0:9998
-
-
-3. On Secondary VM's QEMU monitor, issue command
-{"execute":"qmp_capabilities"}
-{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
-{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "data": {"host": "0.0.0.0", "port": "9999"} } } }
-{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable": true } }
-
-Note:
-  a. The qmp command nbd-server-start and nbd-server-add must be run
-     before running the qmp command migrate on primary QEMU
-  b. Active disk, hidden disk and nbd target's length should be the
-     same.
-  c. It is better to put active disk and hidden disk in ramdisk. They
-     will be merged into the parent disk on failover.
-
-4. On Primary VM's QEMU monitor, issue command:
-{"execute":"qmp_capabilities"}
-{"execute": "human-monitor-command", "arguments": {"command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
-{"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "replication0" } }
-{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
-{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
-
-  Note:
-  a. There should be only one NBD Client for each primary disk.
-  b. The qmp command line must be run after running qmp command line in
-     secondary qemu.
-
-5. After the above steps, you will see, whenever you make changes to PVM, SVM will be synced.
-You can issue command '{ "execute": "migrate-set-parameters" , "arguments":{ "x-checkpoint-delay": 2000 } }'
-to change the idle checkpoint period time
-
-6. Failover test
-You can kill one of the VMs and Failover on the surviving VM:
-
-If you killed the Secondary, then follow "Primary Failover". After that,
-if you want to resume the replication, follow "Primary resume replication"
-
-If you killed the Primary, then follow "Secondary Failover". After that,
-if you want to resume the replication, follow "Secondary resume replication"
-
-== Primary Failover ==
-The Secondary died, resume on the Primary
-
-{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "child": "children.1"} }
-{"execute": "human-monitor-command", "arguments":{ "command-line": "drive_del replication0" } }
-{"execute": "object-del", "arguments":{ "id": "comp0" } }
-{"execute": "object-del", "arguments":{ "id": "iothread1" } }
-{"execute": "object-del", "arguments":{ "id": "m0" } }
-{"execute": "object-del", "arguments":{ "id": "redire0" } }
-{"execute": "object-del", "arguments":{ "id": "redire1" } }
-{"execute": "x-colo-lost-heartbeat" }
-
-== Secondary Failover ==
-The Primary died, resume on the Secondary and prepare to become the new Primary
-
-{"execute": "nbd-server-stop"}
-{"execute": "x-colo-lost-heartbeat"}
-
-{"execute": "object-del", "arguments":{ "id": "f2" } }
-{"execute": "object-del", "arguments":{ "id": "f1" } }
-{"execute": "chardev-remove", "arguments":{ "id": "red1" } }
-{"execute": "chardev-remove", "arguments":{ "id": "red0" } }
-
-{"execute": "chardev-add", "arguments":{ "id": "mirror0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.0.0", "port": "9003" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare1", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.0.0", "port": "9004" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9001" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare0-0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9001" } }, "server": false } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare_out", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9005" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare_out0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9005" } }, "server": false } } } }
-
-== Primary resume replication ==
-Resume replication after new Secondary is up.
-
-Start the new Secondary (Steps 2 and 3 above), then on the Primary:
-{"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-id": "resync", "target": "nbd://127.0.0.2:9999/parent0", "mode": "existing", "format": "raw", "sync": "full"} }
-
-Wait until disk is synced, then:
-{"execute": "stop"}
-{"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
-
-{"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
-{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
-
-{"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire1", "netdev": "hn0", "queue": "rx", "outdev": "compare0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "iothread1" } }
-{"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev": "compare_out0", "iothread": "iothread1" } }
-
-{"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {"capability": "x-colo", "state": true } ] } }
-{"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.2:9998" } }
-
-Note:
-If this Primary previously was a Secondary, then we need to insert the
-filters before the filter-rewriter by using the
-""insert": "before", "position": "id=rew0"" Options. See below.
-
-== Secondary resume replication ==
-Become Primary and resume replication after new Secondary is up. Note
-that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
-
-Start the new Secondary (Steps 2 and 3 above, but with primary_ip=127.0.0.2),
-then on the old Secondary:
-{"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-id": "resync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existing", "format": "raw", "sync": "full"} }
-
-Wait until disk is synced, then:
-{"execute": "stop"}
-{"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
-
-{"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.1,file.port=9999,file.export=parent0,node-name=replication0"}}
-{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
-
-{"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire1", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "rx", "outdev": "compare0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "iothread1" } }
-{"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev": "compare_out0", "iothread": "iothread1" } }
-
-{"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {"capability": "x-colo", "state": true } ] } }
-{"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
-
-== TODO ==
-1. Support shared storage.
-2. Develop the heartbeat part.
-3. Reduce checkpoint VM’s downtime while doing checkpoint.
diff --git a/docs/system/index.rst b/docs/system/index.rst
index d297a95282..bb948e2993 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -42,3 +42,4 @@ or Hypervisor.Framework.
    nitro
    vm-templating
    sriov
+   qemu-colo
diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
new file mode 100644
index 0000000000..7c771030a1
--- /dev/null
+++ b/docs/system/qemu-colo.rst
@@ -0,0 +1,359 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Qemu COLO Fault Tolerance
+=========================
+
+| Copyright (c) 2016 Intel Corporation
+| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+| Copyright (c) 2016 Fujitsu, Corp.
+
+This document gives an overview of COLO's design and how to use it.
+
+Background
+----------
+Virtual machine (VM) replication is a well known technique for providing
+application-agnostic software-implemented hardware fault tolerance,
+also known as "non-stop service".
+
+COLO (COarse-grained LOck-stepping) is a high availability solution.
+Both primary VM (PVM) and secondary VM (SVM) run in parallel. They receive the
+same request from client, and generate response in parallel too.
+If the response packets from PVM and SVM are identical, they are released
+immediately. Otherwise, a VM checkpoint (on demand) is conducted.
+
+Architecture
+------------
+The architecture of COLO is shown in the diagram below.
+It consists of a pair of networked physical nodes:
+The primary node running the PVM, and the secondary node running the SVM
+to maintain a valid replica of the PVM.
+PVM and SVM execute in parallel and generate output of response packets for
+client requests according to the application semantics.
+
+The incoming packets from the client or external network are received by the
+primary node, and then forwarded to the secondary node, so that both the PVM
+and the SVM are stimulated with the same requests.
+
+COLO receives the outbound packets from both the PVM and SVM and compares them
+before allowing the output to be sent to clients.
+
+The SVM is qualified as a valid replica of the PVM, as long as it generates
+identical responses to all client requests. Once the differences in the outputs
+are detected between the PVM and SVM, COLO withholds transmission of the
+outbound packets until it has successfully synchronized the PVM state to the SVM.
+
+Overview::
+
+      Primary Node                                                            Secondary Node
+    +------------+  +-----------------------+       +------------------------+  +------------+
+    |            |  |       HeartBeat       +<----->+       HeartBeat        |  |            |
+    | Primary VM |  +-----------+-----------+       +-----------+------------+  |Secondary VM|
+    |            |              |                               |               |            |
+    |            |  +-----------|-----------+       +-----------|------------+  |            |
+    |            |  |QEMU   +---v----+      |       |QEMU  +----v---+        |  |            |
+    |            |  |       |Failover|      |       |      |Failover|        |  |            |
+    |            |  |       +--------+      |       |      +--------+        |  |            |
+    |            |  |   +---------------+   |       |   +---------------+    |  |            |
+    |            |  |   | VM Checkpoint +-------------->+ VM Checkpoint |    |  |            |
+    |            |  |   +---------------+   |       |   +---------------+    |  |            |
+    |Requests<--------------------------\ /-----------------\ /--------------------->Requests|
+    |            |  |                   ^ ^ |       |       | |              |  |            |
+    |Responses+---------------------\ /-|-|------------\ /-------------------------+Responses|
+    |            |  |               | | | | |       |  | |  | |              |  |            |
+    |            |  | +-----------+ | | | | |       |  | |  | | +----------+ |  |            |
+    |            |  | | COLO disk | | | | | |       |  | |  | | | COLO disk| |  |            |
+    |            |  | |   Manager +---------------------------->| Manager  | |  |            |
+    |            |  | ++----------+ v v | | |       |  | v  v | +---------++ |  |            |
+    |            |  |  |+-----------+-+-+-++|       | ++-+--+-+---------+ |  |  |            |
+    |            |  |  ||   COLO Proxy     ||       | |   COLO Proxy    | |  |  |            |
+    |            |  |  || (compare packet  ||       | |(adjust sequence | |  |  |            |
+    |            |  |  ||and mirror packet)||       | |    and ACK)     | |  |  |            |
+    |            |  |  |+------------+---+-+|       | +-----------------+ |  |  |            |
+    +------------+  +-----------------------+       +------------------------+  +------------+
+    +------------+     |             |   |                                |     +------------+
+    | VM Monitor |     |             |   |                                |     | VM Monitor |
+    +------------+     |             |   |                                |     +------------+
+    +---------------------------------------+       +----------------------------------------+
+    |   Kernel         |             |   |  |       |   Kernel            |                  |
+    +---------------------------------------+       +----------------------------------------+
+                       |             |   |                                |
+        +--------------v+  +---------v---+--+       +------------------+ +v-------------+
+        |   Storage     |  |External Network|       | External Network | |   Storage    |
+        +---------------+  +----------------+       +------------------+ +--------------+
+
+Components introduction
+^^^^^^^^^^^^^^^^^^^^^^^
+You can see there are several components in COLO's diagram of architecture.
+Their functions are described below.
+
+HeartBeat
+~~~~~~~~~
+Runs on both the primary and secondary nodes, to periodically check platform
+availability. When the primary node suffers a hardware fail-stop failure,
+the heartbeat stops responding, the secondary node will trigger a failover
+as soon as it determines the absence.
+
+COLO disk Manager
+~~~~~~~~~~~~~~~~~
+When primary VM writes data into image, the colo disk manager captures this data
+and sends it to secondary VM's which makes sure the context of secondary VM's
+image is consistent with the context of primary VM 's image.
+For more details, please refer to docs/block-replication.txt.
+
+Checkpoint/Failover Controller
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Modifications of save/restore flow to realize continuous migration,
+to make sure the state of VM in Secondary side is always consistent with VM in
+Primary side.
+
+COLO Proxy
+~~~~~~~~~~
+Delivers packets to Primary and Secondary, and then compare the responses from
+both side. Then decide whether to start a checkpoint according to some rules.
+Please refer to docs/colo-proxy.txt for more information.
+
+Note:
+HeartBeat has not been implemented yet, so you need to trigger failover process
+by using 'x-colo-lost-heartbeat' command.
+
+COLO operation status
+^^^^^^^^^^^^^^^^^^^^^
+
+Overview::
+
+    +-----------------+
+    |                 |
+    |    Start COLO   |
+    |                 |
+    +--------+--------+
+             |
+             |  Main qmp command:
+             |  migrate-set-capabilities with x-colo
+             |  migrate
+             |
+             v
+    +--------+--------+
+    |                 |
+    |  COLO running   |
+    |                 |
+    +--------+--------+
+             |
+             |  Main qmp command:
+             |  x-colo-lost-heartbeat
+             |  or
+             |  some error happened
+             v
+    +--------+--------+
+    |                 |  send qmp event:
+    |  COLO failover  |  COLO_EXIT
+    |                 |
+    +-----------------+
+
+
+COLO use the qmp command to switch and report operation status.
+The diagram just shows the main qmp command, you can get the detail
+in test procedure.
+
+Test procedure
+--------------
+Note: Here we are running both instances on the same host for testing,
+change the IP Addresses if you want to run it on two hosts. Initially
+``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Host.
+
+Startup qemu
+^^^^^^^^^^^^
+**1. Primary**:
+Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all hosts.
+You don't need to change any IP's here, because ``0.0.0.0`` listens on any
+interface. The chardev's with ``127.0.0.1`` IP's loopback to the local qemu
+instance::
+
+    # imagefolder="/mnt/vms/colo-test-primary"
+
+    # qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=on -m 512 -smp 1 -qmp stdio \
+       -device piix3-usb-uhci -device usb-tablet -name primary \
+       -netdev tap,id=hn0,vhost=off,helper=/usr/lib/qemu/qemu-bridge-helper \
+       -device rtl8139,id=e0,netdev=hn0 \
+       -chardev socket,id=mirror0,host=0.0.0.0,port=9003,server=on,wait=off \
+       -chardev socket,id=compare1,host=0.0.0.0,port=9004,server=on,wait=on \
+       -chardev socket,id=compare0,host=127.0.0.1,port=9001,server=on,wait=off \
+       -chardev socket,id=compare0-0,host=127.0.0.1,port=9001 \
+       -chardev socket,id=compare_out,host=127.0.0.1,port=9005,server=on,wait=off \
+       -chardev socket,id=compare_out0,host=127.0.0.1,port=9005 \
+       -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0 \
+       -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out \
+       -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0 \
+       -object iothread,id=iothread1 \
+       -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,\
+    outdev=compare_out0,iothread=iothread1 \
+       -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
+    children.0.file.filename=$imagefolder/primary.qcow2,children.0.driver=qcow2 -S
+
+
+**2. Secondary**:
+Note: Active and hidden images need to be created only once and the
+size should be the same as ``primary.qcow2``. Again, you don't need to change
+any IP's here, except for the ``$primary_ip`` variable::
+
+    # imagefolder="/mnt/vms/colo-test-secondary"
+    # primary_ip=127.0.0.1
+
+    # qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
+
+    # qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
+
+    # qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=on -m 512 -smp 1 -qmp stdio \
+       -device piix3-usb-uhci -device usb-tablet -name secondary \
+       -netdev tap,id=hn0,vhost=off,helper=/usr/lib/qemu/qemu-bridge-helper \
+       -device rtl8139,id=e0,netdev=hn0 \
+       -chardev socket,id=red0,host=$primary_ip,port=9003,reconnect-ms=1000 \
+       -chardev socket,id=red1,host=$primary_ip,port=9004,reconnect-ms=1000 \
+       -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0 \
+       -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1 \
+       -object filter-rewriter,id=rew0,netdev=hn0,queue=all \
+       -drive if=none,id=parent0,file.filename=$imagefolder/primary.qcow2,driver=qcow2 \
+       -drive if=none,id=childs0,driver=replication,mode=secondary,file.driver=qcow2,\
+    top-id=colo-disk0,file.file.filename=$imagefolder/secondary-active.qcow2,\
+    file.backing.driver=qcow2,file.backing.file.filename=$imagefolder/secondary-hidden.qcow2,\
+    file.backing.backing=parent0 \
+       -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
+    children.0=childs0 \
+       -incoming tcp:0.0.0.0:9998
+
+
+**3.** On Secondary VM's QEMU monitor, issue command::
+
+    {"execute":"qmp_capabilities"}
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "data": {"host": "0.0.0.0", "port": "9999"} } } }
+    {"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable": true } }
+
+Note:
+  a. The qmp command ``nbd-server-start`` and ``nbd-server-add`` must be run
+     before running the qmp command migrate on primary QEMU
+  b. Active disk, hidden disk and nbd target's length should be the
+     same.
+  c. It is better to put active disk and hidden disk in ramdisk. They
+     will be merged into the parent disk on failover.
+
+**4.** On Primary VM's QEMU monitor, issue command::
+
+    {"execute":"qmp_capabilities"}
+    {"execute": "human-monitor-command", "arguments": {"command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
+    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "replication0" } }
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
+
+Note:
+  a. There should be only one NBD Client for each primary disk.
+  b. The qmp command line must be run after running qmp command line in
+     secondary qemu.
+
+**5.** After the above steps, you will see, whenever you make changes to PVM, SVM will be synced.
+You can issue command ``{ "execute": "migrate-set-parameters" , "arguments":{ "x-checkpoint-delay": 2000 } }``
+to change the idle checkpoint period time
+
+Failover test
+^^^^^^^^^^^^^
+You can kill one of the VMs and Failover on the surviving VM:
+
+If you killed the Secondary, then follow "Primary Failover".
+After that, if you want to resume the replication, follow "Primary resume replication"
+
+If you killed the Primary, then follow "Secondary Failover".
+After that, if you want to resume the replication, follow "Secondary resume replication"
+
+Primary Failover
+~~~~~~~~~~~~~~~~
+The Secondary died, resume on the Primary::
+
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "child": "children.1"} }
+    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_del replication0" } }
+    {"execute": "object-del", "arguments":{ "id": "comp0" } }
+    {"execute": "object-del", "arguments":{ "id": "iothread1" } }
+    {"execute": "object-del", "arguments":{ "id": "m0" } }
+    {"execute": "object-del", "arguments":{ "id": "redire0" } }
+    {"execute": "object-del", "arguments":{ "id": "redire1" } }
+    {"execute": "x-colo-lost-heartbeat" }
+
+Secondary Failover
+~~~~~~~~~~~~~~~~~~
+The Primary died, resume on the Secondary and prepare to become the new Primary::
+
+    {"execute": "nbd-server-stop"}
+    {"execute": "x-colo-lost-heartbeat"}
+
+    {"execute": "object-del", "arguments":{ "id": "f2" } }
+    {"execute": "object-del", "arguments":{ "id": "f1" } }
+    {"execute": "chardev-remove", "arguments":{ "id": "red1" } }
+    {"execute": "chardev-remove", "arguments":{ "id": "red0" } }
+
+    {"execute": "chardev-add", "arguments":{ "id": "mirror0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.0.0", "port": "9003" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare1", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.0.0", "port": "9004" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9001" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare0-0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9001" } }, "server": false } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare_out", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9005" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare_out0", "backend": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.0.0.1", "port": "9005" } }, "server": false } } } }
+
+Primary resume replication
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+Resume replication after new Secondary is up.
+
+Start the new Secondary (Steps 2 and 3 above), then on the Primary::
+
+    {"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-id": "resync", "target": "nbd://127.0.0.2:9999/parent0", "mode": "existing", "format": "raw", "sync": "full"} }
+
+Wait until disk is synced, then::
+
+    {"execute": "stop"}
+    {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
+
+    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
+
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire1", "netdev": "hn0", "queue": "rx", "outdev": "compare0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "iothread1" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev": "compare_out0", "iothread": "iothread1" } }
+
+    {"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.2:9998" } }
+
+Note:
+If this Primary previously was a Secondary, then we need to insert the
+filters before the filter-rewriter by using the
+""insert": "before", "position": "id=rew0"" Options. See below.
+
+Secondary resume replication
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Become Primary and resume replication after new Secondary is up. Note
+that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
+
+Start the new Secondary (Steps 2 and 3 above, but with primary_ip=127.0.0.2),
+then on the old Secondary::
+
+    {"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-id": "resync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existing", "format": "raw", "sync": "full"} }
+
+Wait until disk is synced, then::
+
+    {"execute": "stop"}
+    {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
+
+    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.1,file.port=9999,file.export=parent0,node-name=replication0"}}
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
+
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire1", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "rx", "outdev": "compare0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "iothread1" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev": "compare_out0", "iothread": "iothread1" } }
+
+    {"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
+
+TODO
+----
+1. Support shared storage.
+2. Develop the heartbeat part.
+3. Reduce checkpoint VM’s downtime while doing checkpoint.
-- 
2.51.0


