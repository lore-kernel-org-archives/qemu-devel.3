Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E65C44507
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnh-00017i-DY; Sat, 11 Jul 2026 18:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnf-00014B-8d; Sat, 11 Jul 2026 18:03:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnd-0000EY-IV; Sat, 11 Jul 2026 18:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=fJjD9xWydlVpgE6rdohPTQy0ExdJtZ/U3fgNqChL0eQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QX6Mjd0fajeVeQonU2KtMqmMLjke5GYS+4HawTwpnh6TAZez4JBN4jLiNWZvzDxgx
 aqD6v8dsajLO9vmPC5IAY6V6nw2dG4uqc9G9RQvvE3aO5D6In627XHkonZF1RnfNL/
 rZ+YO9pBY17bda6De14NU3Xqh8OBJun0aJh000RJ+y/KMd0CNKP85XT9qXCJPCNVbF
 Qf1/9LybWvsdxUBFihlLK79n0d2FJuoOwQqKck2v99KAnD8PQmfY4auPYl5MVHTUZX
 7mQ/1bAUQc5iN6YmE53YmkR006CFzy+Fiq8Tx4XcpBJPRKbGinsKKjaXRTx2X3680z
 Z46GUQD7QKB3Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E15E1C0AB9;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8FAA3EAF44;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A64F11333F; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Feifan Qian <bea1e@proton.me>, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 46/81] hw/display/ati: reset host_data.next in write
 handler after flush
Date: Sun, 12 Jul 2026 00:58:24 +0300
Message-ID: <20260711215904.3757-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

ati_host_data_flush() resets host_data.next only on its success path.
When it returns early (unsupported bpp, direction, src_source, or
src_datatype), next remains stale at >= 4. The next HOST_DATA write
then stores a guest-controlled dword at acc[4+], overflowing the
4-element accumulator array.

Fix this by resetting next unconditionally in the write handler after
calling ati_host_data_flush() or ati_host_data_finish(), and removing
the reset from inside ati_host_data_flush(). This ensures the write
handler owns the full lifecycle of the accumulator index regardless of
flush success or failure.

Cc: qemu-stable@nongnu.org
Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://lore.kernel.org/qemu-devel/Czyl6yVfL6sHl_o1kRk8N_LpwXMMRVhO9vgz1qCVJFagn9D4nHSKuiux39iOLty0Q3acxQq_FeovPhTQvSKus2htwjI9lTajLZmqovr0Wxs=@proton.me/
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <20260519023937.439077-2-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 3565faa0ace1f258789aafaf440ab55c3419df60)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0489995d00b..7d4e40a142c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1032,8 +1032,10 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->host_data.acc[s->host_data.next++] = data;
         if (addr == HOST_DATA_LAST) {
             ati_host_data_finish(s);
+            s->host_data.next = 0;
         } else if (s->host_data.next >= 4) {
             ati_host_data_flush(s);
+            s->host_data.next = 0;
         }
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 48498677c7e..8ef82bb87fd 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -452,7 +452,6 @@ bool ati_host_data_flush(ATIVGAState *s)
     }
 
     /* Track state of the overall blit for use by the next flush */
-    s->host_data.next = 0;
     s->host_data.row = row;
     s->host_data.col = col;
     if (s->host_data.row >= ctx.dst.height) {
-- 
2.47.3


