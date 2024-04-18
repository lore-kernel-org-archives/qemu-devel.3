Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B9BC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyY-0001jW-Pq; Thu, 18 Apr 2024 16:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyG-0001ac-DD; Thu, 18 Apr 2024 16:03:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyD-0005PR-6K; Thu, 18 Apr 2024 16:03:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 079295FE14;
 Thu, 18 Apr 2024 23:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 67541B93FA;
 Thu, 18 Apr 2024 23:02:25 +0300 (MSK)
Received: (nullmailer pid 952875 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, zhenwei pi <pizhenwei@bytedance.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 53/59] backends/cryptodev: Do not abort for invalid
 session ID
Date: Thu, 18 Apr 2024 23:02:13 +0300
Message-Id: <20240418200224.952785-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Instead of aborting when a session ID is invalid,
return VIRTIO_CRYPTO_INVSESS ("Invalid session id").

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none \
     -machine q35,accel=qtest -m 512M -nodefaults \
     -object cryptodev-backend-builtin,id=cryptodev0 \
     -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
     -qtest stdio
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  outl 0xcf8 0x80000820
  outl 0xcfc 0xe0008000
  write 0x10800e 0x1 0x01
  write 0xe0008016 0x1 0x01
  write 0xe0008020 0x4 0x00801000
  write 0xe0008028 0x4 0x00c01000
  write 0xe000801c 0x1 0x01
  write 0x110000 0x1 0x05
  write 0x110001 0x1 0x04
  write 0x108002 0x1 0x11
  write 0x108008 0x1 0x48
  write 0x10800c 0x1 0x01
  write 0x108018 0x1 0x10
  write 0x10801c 0x1 0x02
  write 0x10c002 0x1 0x01
  write 0xe000b005 0x1 0x00
  EOF
  Assertion failed: (session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]),
  function cryptodev_builtin_close_session, file cryptodev-builtin.c, line 430.

Cc: qemu-stable@nongnu.org
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20240409094757.9127-1-philmd@linaro.org>
(cherry picked from commit eaf2bd29538d039df80bb4b1584de33a61312bc6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index cda6ca3b71..2e792be756 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -416,7 +416,9 @@ static int cryptodev_builtin_close_session(
                       CRYPTODEV_BACKEND_BUILTIN(backend);
     CryptoDevBackendBuiltinSession *session;
 
-    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]);
+    if (session_id >= MAX_NUM_SESSIONS || !builtin->sessions[session_id]) {
+        return -VIRTIO_CRYPTO_INVSESS;
+    }
 
     session = builtin->sessions[session_id];
     if (session->cipher) {
-- 
2.39.2


