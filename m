Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662D7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQB-0008Hk-Oq; Wed, 12 Aug 2026 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAP7-0005pY-BE; Wed, 12 Aug 2026 10:58:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAP5-00013k-AD; Wed, 12 Aug 2026 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=j+q5dKNPbW9N8LA2Yq/3o5x/kP7r1B0o49ZUBuRn5k0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tMxTN9+Lplgypkydx50XuojvX3L0DteJUj4gaTZdyfEhH7nLJj1Al5gZjihVPmTJZ
 3ZVEckXL/dYvlfP5z7alDFiTeokCbzilJpaEd8/Vv6VnuT4LhkDGpcVPSMJ8HVsjiK
 /iw56loWuekUdQVu9Govp9Aol70pAj/BZXRgtN7GpRJEUQn0zD7W+Az96INQhRYRnR
 I6j4UPIUZJDQFktrcdrg9+IMBTq1aklaHm774MgegRFV0FcCr84MIU1lORVTQGPQIM
 60EsveIWSqvVUoOYDpGELS651ACqmFSkhsylixYQfQkoEsjUR1cdAzY7G/PphhZdbu
 xhPcMQUCUaquw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D011E1CA64F;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 36E6D409D91;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9676F2F9F9; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 075/120] hw/net/igb: recalculate rx_desc_len on
 migration load
Date: Wed, 12 Aug 2026 17:48:58 +0300
Message-ID: <20260812144955.649205-75-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

rx_desc_len is migrated as a raw uint8_t from the stream but is a
derived value. Currently igb_rx_use_legacy_descriptor() is a stub
that always returns false, so rx_desc_len is always set to
sizeof(union e1000_adv_rx_desc). Recalculate it in post_load to
prevent a crafted migration stream from setting an invalid value.

Cc: qemu-stable@nongnu.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260722112449.1386162-3-lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 1e5efe6d93701d6b2b05b62822c02eee935490b5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 45d8fd795b8..2a488390735 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4548,5 +4548,7 @@ igb_core_post_load(IGBCore *core)
     igb_intrmgr_resume(core);
     igb_autoneg_resume(core);
 
+    igb_calc_rxdesclen(core);
+
     return 0;
 }
-- 
2.47.3


