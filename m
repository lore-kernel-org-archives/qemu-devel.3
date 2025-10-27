Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81543CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 01:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDBgn-0003aT-25; Sun, 26 Oct 2025 21:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDBgl-0003aL-N5
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 21:06:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDBgi-0007qP-G7
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 21:06:23 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59R16Ad4019750
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 10:06:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=q46nPEVbbYbxxaVL+aOn38bH3oHBYjztp3U/5psZTt4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761527172; v=1;
 b=MSTsPv9RWjzSaINbaport6kogneKV0N7Q+imb+AVZnLVIplinfdeghHPd7oV1D7K
 wijdA1+e4Ppor54Bs1tnw4L7nGPlZ4U3fleyStDO1HkcYumhq4eM22C3tKH08DRe
 Nelb0frH+R1wlB4OTvYLzUgDlZzgnfsJwrN40LDQ+GUeXu04i0LnVKthmVglf5cQ
 /25gkiQgH19WgIa+6kASTouJmrU4RpR2yYAuGp3Zj7b3uDsE8Fy7J1ElhFJrcDbH
 pMXyulnby4nEvqUbebEitzO5dkFaVqJpkkT752V/5/j5t3okkYg6qrXm61DoAU2M
 AWkRaGv0qGCjJxUCsNT4qw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Oct 2025 10:05:38 +0900
Subject: [PATCH] ds1225y: Fix nvram MemoryRegion owner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAGHF/mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3ZRiQyMj00pdg+SkVAtjE2ODRHMLJaDqgqLUtMwKsEnRsbW1AAs
 HVO1ZAAAA
X-Change-ID: 20251027-ds1225y-0cbe83430a78
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

s points to the MemoryRegion itself. dev points to DS1225Y, the real
owner.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/nvram/ds1225y.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index dbfd0d2e5369..0945e36652e9 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -126,7 +126,7 @@ static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
 
     s->contents = g_malloc0(s->chip_size);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &nvram_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(dev), &nvram_ops, s,
                           "nvram", s->chip_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 

---
base-commit: c85ba2d7a4056595166689890285105579db446a
change-id: 20251027-ds1225y-0cbe83430a78

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


