Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79FBC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJOf-0001Lv-GQ; Wed, 29 May 2024 09:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCJOd-0001KD-5o
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCJOa-0007Nw-ET
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716989470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qauMgQVPtCANJT4Nt7LxsGLPSOqkbefylp3+uMX4ihU=;
 b=gCAV/CiRdlkx7iXXgdkWd3VAwOS398PiX4xG5TeHfQodVQ8E2zshnKTl7rJhQNJvFIAxnx
 lhszB7ZuWBkUyjtCpckHO/RR2h1MhhoMt5sXi7GL01ym6TI+zOrFggfZeutXwlRaoKlBcF
 qoHdrtMsLFb1Hpw5HAC1NSa9Q6QRMUc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-bf6bpCfvPfu8_lUqwAZ44g-1; Wed,
 29 May 2024 09:31:09 -0400
X-MC-Unique: bf6bpCfvPfu8_lUqwAZ44g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 965DD3C025B1;
 Wed, 29 May 2024 13:31:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 646E5492BC6;
 Wed, 29 May 2024 13:31:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
Date: Wed, 29 May 2024 15:31:06 +0200
Message-ID: <20240529133106.1224866-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Casting function pointers from one type to another causes undefined
behavior errors when compiling with -fsanitize=undefined with Clang v18:

 $ QTEST_QEMU_BINARY=./qemu-system-mips64 tests/qtest/netdev-socket
 TAP version 13
 # random seed: R02S4424f4f460de783fdd3d72c5571d3adc
 1..10
 # Start of mips64 tests
 # Start of netdev tests
 # Start of stream tests
 # starting QEMU: exec ./qemu-system-mips64 -qtest unix:/tmp/qtest-1213196.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1213196.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -nodefaults -M none -netdev stream,id=st0,addr.type=fd,addr.str=3 -accel qtest
 ../io/task.c:78:13: runtime error: call to function qapi_free_SocketAddress through pointer to incorrect function type 'void (*)(void *)'
 /tmp/qemu-sanitize/qapi/qapi-types-sockets.c:170: note: qapi_free_SocketAddress defined here
 SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../io/task.c:78:13

Add a wrapper function to avoid the problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 io/channel-socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3a899b0608..aa2a1c8586 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -193,6 +193,10 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
     qio_task_set_error(task, err);
 }
 
+static void qio_qapi_free_SocketAddress(gpointer sa)
+{
+    qapi_free_SocketAddress(sa);
+}
 
 void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
                                       SocketAddress *addr,
@@ -213,7 +217,7 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_connect_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress,
+                           qio_qapi_free_SocketAddress,
                            context);
 }
 
-- 
2.45.1


