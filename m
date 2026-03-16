Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B88F506D4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28NR-0003RL-RN; Mon, 16 Mar 2026 09:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Mw-0002h8-OY; Mon, 16 Mar 2026 09:52:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Ms-0000C6-Qm; Mon, 16 Mar 2026 09:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773669141; bh=RrVPzh7rUh4qrx15NQ3Lut3i91tsnq8KLYKY2VIS4oo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BQm/tc5mcpsYBPnXWRaQS78idPYGVFXYrZ4ZmpN95JUzw7nhWW1MAj91890yc23Qz
 NmaE8ycGZbnhkKuCtQh/gPPQILV/psBp8g3YyIzKKqt6nmH0VN1nkEEhQ/2ZyF8+iG
 oqp1mkTnJq5RHLMWKVtEYoypVHaTjpKASAuzoM+cxUgYViMhhiCWerLzNQcEkKKIXr
 WjdNoH6PzFc4OeahqMFuO9EOVN+L41e/MYCd89wDn7u9Fd65tfjyXnRB5dgIgJGm4n
 1OFgp7lQfkAuxwrliyH8lJw4w+CI05g7fbrygatrd1YuGkzG6ZqK2dZ4WJEQxB8DWS
 /QDsGznhF8TAg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A959193EF7;
 Mon, 16 Mar 2026 16:52:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1037738093F;
 Mon, 16 Mar 2026 16:52:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 54/55] hyperv/syndbg: check length returned by
 cpu_physical_memory_map()
Date: Mon, 16 Mar 2026 16:52:21 +0300
Message-ID: <20260316135225.120094-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260316164931@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260316164931@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

If cpu_physical_memory_map() returns a length shorter than the one
that was passed into the function, writing the full out_len bytes
causes an access beyond the memory allocated to the guest; or in
the case of the MMIO bounce buffer, an out-of-bounds access in a
heap-allocated object.

Add a check similar to the one already in handle_send_msg(),
and take the occasion to remove repeated computations of
recv_byte_count + UDP_PKT_HEADER_SIZE and clarify that the
code does not write past out_len bytes.

Reported-by: Oleh Konko <https://github.com/1seal>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Fixes: CVE-2026-3842
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4f28b87fdd24df2049626106b7c24d0180952115)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index bcdfdf6af7..134dadb89e 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -193,7 +193,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
     uint16_t ret;
     g_assert(MSG_BUFSZ >= qemu_target_page_size());
     QEMU_UNINITIALIZED uint8_t data_buf[MSG_BUFSZ];
-    hwaddr out_len;
+    hwaddr out_len, out_requested_len;
     void *out_data;
     ssize_t recv_byte_count;
 
@@ -222,29 +222,28 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
     if (is_raw) {
         out_len += UDP_PKT_HEADER_SIZE;
     }
+    out_requested_len = out_len;
     out_data = cpu_physical_memory_map(outgpa, &out_len, 1);
-    if (!out_data) {
-        return HV_STATUS_INSUFFICIENT_MEMORY;
+    ret = HV_STATUS_INSUFFICIENT_MEMORY;
+    if (!out_data || out_len < out_requested_len) {
+        goto cleanup_out_data;
     }
 
     if (is_raw &&
-        !create_udp_pkt(syndbg, out_data,
-                        recv_byte_count + UDP_PKT_HEADER_SIZE,
+        !create_udp_pkt(syndbg, out_data, out_len,
                         data_buf, recv_byte_count)) {
-        ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup_out_data;
     } else if (!is_raw) {
-        memcpy(out_data, data_buf, recv_byte_count);
+        memcpy(out_data, data_buf, out_len);
     }
 
-    *retrieved_count = recv_byte_count;
-    if (is_raw) {
-        *retrieved_count += UDP_PKT_HEADER_SIZE;
-    }
+    *retrieved_count = out_len;
     ret = HV_STATUS_SUCCESS;
 
 cleanup_out_data:
-    cpu_physical_memory_unmap(out_data, out_len, 1, out_len);
+    if (out_data) {
+        cpu_physical_memory_unmap(out_data, out_len, 1, out_len);
+    }
     return ret;
 }
 
-- 
2.47.3


