Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A6CC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXbi-00042N-Ql; Fri, 21 Mar 2025 04:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tvXa2-0003AI-8s; Fri, 21 Mar 2025 04:18:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tvXZw-0007iy-KY; Fri, 21 Mar 2025 04:18:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7486A10549E;
 Fri, 21 Mar 2025 11:16:48 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2DE01D0FCC;
 Fri, 21 Mar 2025 11:17:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BFA7156BA9; Fri, 21 Mar 2025 11:17:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/3] docs: Explain how to use passt
Date: Fri, 21 Mar 2025 11:17:50 +0300
Message-Id: <20250321081751.1999498-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250321081751.1999498-1-mjt@tls.msk.ru>
References: <20250321081751.1999498-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=1.474,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

Add a chapter to explain how to use passt(1) instead of '-net user'.
passt(1) can be connected to QEMU using UNIX socket or vhost-user.
With vhost-user, migration of the VM is allowed and internal state of
passt(1) is transfered from one side to the other

Bug: https://gitlab.com/qemu-project/qemu/-/issues/2827
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/devices/net.rst | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 2ab516d4b0..a3efbdcabd 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -77,6 +77,106 @@ When using the ``'-netdev user,hostfwd=...'`` option, TCP or UDP
 connections can be redirected from the host to the guest. It allows for
 example to redirect X11, telnet or SSH connections.
 
+Using passt as the user mode network stack
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+passt_ can be used as a simple replacement for SLIRP (``-net user``).
+passt doesn't require any capability or privilege. passt has
+better performance than ``-net user``, full IPv6 support and better security
+as it's a daemon that is not executed in QEMU context.
+
+passt can be connected to QEMU either by using a socket
+(``-netdev stream``) or using the vhost-user interface (``-netdev vhost-user``).
+See `passt(1)`_ for more details on passt.
+
+.. _passt: https://passt.top/
+.. _passt(1): https://passt.top/builds/latest/web/passt.1.html
+
+To use socket based passt interface:
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Start passt as a daemon::
+
+   passt --socket ~/passt.socket
+
+If ``--socket`` is not provided, passt will print the path of the UNIX domain socket QEMU can connect to (``/tmp/passt_1.socket``, ``/tmp/passt_2.socket``,
+...). Then you can connect your QEMU instance to passt:
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] -device virtio-net-pci,netdev=netdev0 -netdev stream,id=netdev0,server=off,addr.type=unix,addr.path=~/passt.socket
+
+Where ``~/passt.socket`` is the UNIX socket created by passt to
+communicate with QEMU.
+
+To use vhost-based interface:
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Start passt with ``--vhost-user``::
+
+   passt --vhost-user --socket ~/passt.socket
+
+Then to connect QEMU:
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] -m $RAMSIZE -chardev socket,id=chr0,path=~/passt.socket -netdev vhost-user,id=netdev0,chardev=chr0 -device virtio-net,netdev=netdev0 -object memory-backend-memfd,id=memfd0,share=on,size=$RAMSIZE -numa node,memdev=memfd0
+
+Where ``$RAMSIZE`` is the memory size of your VM ``-m`` and ``-object memory-backend-memfd,size=`` must match.
+
+Migration of passt:
+^^^^^^^^^^^^^^^^^^^
+
+When passt is connected to QEMU using the vhost-user interface it can
+be migrated with QEMU and the network connections are not interrupted.
+
+As passt runs with no privileges, it relies on passt-repair to save and
+load the TCP connections state, using the TCP_REPAIR socket option.
+The passt-repair helper needs to have the CAP_NET_ADMIN capability, or run as root. If passt-repair is not available, TCP connections will not be preserved.
+
+Example of migration of a guest on the same host
+________________________________________________
+
+Before being able to run passt-repair, the CAP_NET_ADMIN capability must be set
+on the file, run as root::
+
+   setcap cap_net_admin+eip ./passt-repair
+
+Start passt for the source side::
+
+   passt --vhost-user --socket ~/passt_src.socket --repair-path ~/passt-repair_src.socket
+
+Where ``~/passt-repair_src.socket`` is the UNIX socket created by passt to
+communicate with passt-repair. The default value is the ``--socket`` path
+appended with ``.repair``.
+
+Start passt-repair::
+
+   passt-repair ~/passt-repair_src.socket
+
+Start source side QEMU with a monitor to be able to send the migrate command:
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -monitor stdio
+
+Start passt for the destination side::
+
+   passt --vhost-user --socket ~/passt_dst.socket --repair-path ~/passt-repair_dst.socket
+
+Start passt-repair::
+
+   passt-repair ~/passt-repair_dst.socket
+
+Start QEMU with the ``-incoming`` parameter:
+
+.. parsed-literal::
+   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -incoming tcp:localhost:4444
+
+Then in the source guest monitor the migration can be started::
+
+   (qemu) migrate tcp:localhost:4444
+
+A separate passt-repair instance must be started for every migration. In the case of a failed migration, passt-repair also needs to be restarted before trying
+again.
+
 Hubs
 ~~~~
 
-- 
2.39.5


