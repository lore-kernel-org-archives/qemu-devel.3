Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF805C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8hn-00078U-08; Wed, 12 Aug 2026 09:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hg-0006V9-3b; Wed, 12 Aug 2026 09:09:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8he-0005d2-As; Wed, 12 Aug 2026 09:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=aLA7WMYAX/Goigp1N2VJIh5SuqL9k8PEfSORYrDVSl0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ug5RhKSvk7F0HVP+WcrbkLZ4j94dIDk/Zf7TYdcCwyjVaOV74/qPYtSeqpjBQ3hjj
 Fv9Kn1zTGoIRiWEUHUH4Qsgm0Y7K8bO1aGo3i+ye4rDq/4sd6A2YOUzxiCPXk4CHSN
 fI7dQ/wYP5BemhOcrYCS4Wl/lR+GQBltoGmF14e9BTIXznnEJ2l26RTMkfJC7+hYF3
 HqsuKzAosHIcITeiwbGI8VObkP3YdB7GgTG0Ejdhmyp0KdxRbuLt1tgf/rVEKtmLOZ
 03O3f6HHnrIF+WnyGn/oFvmBVjW491EANbgIZIDnKgLEQSeAHkg26CB8kD6BgS5/28
 AeU3oK6imn3Rg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3BCF01CA4BE;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 707AB409BA1;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 713A52F912; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 063/102] hw/net/e1000e: recalculate rx_desc_len on
 migration load
Date: Wed, 12 Aug 2026 16:01:38 +0300
Message-ID: <20260812130233.621965-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

rx_desc_len is migrated as a raw uint8_t from the stream, but it
is a derived value that can be computed from the register state
in core.mac[RFCTL] and core.mac[RCTL]. A crafted migration stream
can set rx_desc_len to an invalid value (e.g. 64), causing a stack
buffer overflow in e1000e_write_packet_to_guest() which copies
rx_desc_len bytes into a 32-byte stack union.

Recalculate rx_desc_len and other derived values from the register
state in post_load, ignoring the untrusted values from the stream.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260722112449.1386162-2-lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit b395a655ae0eb8d38c1e61a6bcaadb2e79326a5b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index a2df627119d..db60146f674 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1948,6 +1948,16 @@ e1000e_calc_rxdesclen(E1000ECore *core)
     trace_e1000e_rx_desc_len(core->rx_desc_len);
 }
 
+static void
+e1000e_calc_rxconf(E1000ECore *core)
+{
+    e1000e_parse_rxbufsize(core);
+    e1000e_calc_rxdesclen(core);
+    core->rxbuf_min_shift =
+        ((core->mac[RCTL] / E1000_RCTL_RDMTS_QUAT) & 3) + 1 +
+        E1000_RING_DESC_LEN_SHIFT;
+}
+
 static void
 e1000e_set_rx_control(E1000ECore *core, int index, uint32_t val)
 {
@@ -1955,11 +1965,7 @@ e1000e_set_rx_control(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_rx_set_rctl(core->mac[RCTL]);
 
     if (val & E1000_RCTL_EN) {
-        e1000e_parse_rxbufsize(core);
-        e1000e_calc_rxdesclen(core);
-        core->rxbuf_min_shift = ((val / E1000_RCTL_RDMTS_QUAT) & 3) + 1 +
-                                E1000_RING_DESC_LEN_SHIFT;
-
+        e1000e_calc_rxconf(core);
         e1000e_start_recv(core);
     }
 }
@@ -3556,5 +3562,7 @@ e1000e_core_post_load(E1000ECore *core)
     e1000e_intrmgr_resume(core);
     e1000e_autoneg_resume(core);
 
+    e1000e_calc_rxconf(core);
+
     return 0;
 }
-- 
2.47.3


