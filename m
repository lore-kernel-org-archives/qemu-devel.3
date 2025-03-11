Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1A2C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzek-0004To-3H; Tue, 11 Mar 2025 09:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1trzeR-0003js-A0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1trzeP-0005Vi-5E
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DqcBxlg8Hjpmj4t9dy9ncx+Tsg1pr5JOIrqWaB9khV4=;
 b=WcAcSFnP171XK0RHV9x9e3V0WLb3XRdQx22B8F82AWhOpfIAHfcHfWyg4MYsaLyP2R7I8Y
 C4Zx/Uh/0QPYSebuTPX0RbqK7TyfVjtLK8fdfFRShfi0xAZsPoxWqnAmc2AvUeycUBefBH
 goRfhRZgscg3rpbjPhU8NqqTKToYSFo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-HcvNo1xsPnObZhwJ6vEUxQ-1; Tue,
 11 Mar 2025 09:27:20 -0400
X-MC-Unique: HcvNo1xsPnObZhwJ6vEUxQ-1
X-Mimecast-MFC-AGG-ID: HcvNo1xsPnObZhwJ6vEUxQ_1741699640
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 090BF180886A; Tue, 11 Mar 2025 13:27:19 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.32.254])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8608930001A2; Tue, 11 Mar 2025 13:27:15 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefano Brivio <sbrivio@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] docs: Explain how to use passt
Date: Tue, 11 Mar 2025 14:27:14 +0100
Message-ID: <20250311132714.166189-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.413, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a chapter to explain how to use passt(1) instead of '-net user'.
passt(1) can be connected to QEMU using UNIX socket or vhost-user.
With vhost-user, migration of the VM is allowed and internal state of
passt(1) is transfered from one side to the other

Bug: https://gitlab.com/qemu-project/qemu/-/issues/2827
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 docs/system/devices/net.rst | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 2ab516d4b097..a3efbdcabd1a 100644
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
2.48.1


