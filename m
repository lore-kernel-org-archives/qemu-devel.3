Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0513FC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmV4U-0006Kb-N5; Wed, 22 Jul 2026 07:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wmV4R-0006GO-UF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wmV4Q-0005qV-8k
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784719501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTXbPGjY1+bQiM/reVOT9vL1o1GJWS55v/PGrJ2mhzU=;
 b=AbMjHaTMr4yGo939K9+mSftdno160XV/WtYRNyK8CMLA1SR/mUp9I+wvVM6y1GII3166UQ
 wtREedIzhRTWOeUmVzPWfnvDA1YjE8nkiuZiGD9up6BXIARirTgfbUGnpCtxGsQax5FjG1
 yrtlumShEqyRy99NtuwvcV8hJIadrto=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-T2gy-bNfMm278SyIUFuDOA-1; Wed,
 22 Jul 2026 07:24:57 -0400
X-MC-Unique: T2gy-bNfMm278SyIUFuDOA-1
X-Mimecast-MFC-AGG-ID: T2gy-bNfMm278SyIUFuDOA_1784719496
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5ED21800668; Wed, 22 Jul 2026 11:24:55 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFDA81800626; Wed, 22 Jul 2026 11:24:53 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] hw/net/e1000e: recalculate rx_desc_len on migration
 load
Date: Wed, 22 Jul 2026 13:24:48 +0200
Message-ID: <20260722112449.1386162-2-lvivier@redhat.com>
In-Reply-To: <20260722112449.1386162-1-lvivier@redhat.com>
References: <20260722112449.1386162-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
---
 hw/net/e1000e_core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 46e156a5ddc2..b87a9f167a71 100644
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
@@ -3557,5 +3563,7 @@ e1000e_core_post_load(E1000ECore *core)
     e1000e_intrmgr_resume(core);
     e1000e_autoneg_resume(core);
 
+    e1000e_calc_rxconf(core);
+
     return 0;
 }
-- 
2.54.0


