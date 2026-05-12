Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68318CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGf-0002nP-Sa; Tue, 12 May 2026 17:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEJ-0007DB-D6; Tue, 12 May 2026 17:01:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEG-0006Q4-8d; Tue, 12 May 2026 17:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619277; bh=HBbppBk0F1Eq2yDKj74u9HuKV/1aqIdP6hioL/w2gdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZtKogPtj+zvggF1vGPyjDvfILf43E7i+CsTVf4i8NRwe40bfPtgH6kH+AjKf1Quah
 czhvhZd+mZCMK6JHjnXW9IhDVlh1MCbyDOizT0qS0Ni14qFDyLk5FCaqneqHwqJUHr
 9QhkcqS2KEY1RR/MY/nC4rxagA5vqKow9n0PjpBiEtcCfRVKkZyZySlb91lY9jmaZb
 A8PqbOEPR8O6YAZgta72NJgMK7RTGAthl0allLyHvmruAlO9xeIp9IoAaTOXGGTHHG
 UE2115ehsc6/jdHjc01QgRlh1N9zmSybHa17WdwRUL1/q/ssZE8/GUYihWwjASvwst
 xUhUlbqfsmSzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE19A1AA30F;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8C453ABC80;
 Tue, 12 May 2026 23:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 067/107] hw/misc: Fix the valid access size to the
 avr-power device
Date: Tue, 12 May 2026 23:53:54 +0300
Message-ID: <20260512205437.360850-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

Accessing the device with in non-single byte mode currently causes
QEMU to abort:

 $ echo "writew 0x800064 0x4142" | \
   ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
 [I 0.000000] OPENED
 [R +0.001784] writew 0x800064 0x4142
 qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58: avr_mask_write:
  Assertion `offset == 0' failed.
 Aborted                    (core dumped)

Set the valid max access size to 1 to fix the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260421082935.85995-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit c0306d2b8f45a708f7ab45c846bb24851d6e17f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index ac7b96f53e..1495ec5de4 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -73,6 +73,9 @@ static const MemoryRegionOps avr_mask_ops = {
     .impl = {
         .max_access_size = 1,
     },
+    .valid = {
+        .max_access_size = 1,
+    },
 };
 
 static void avr_mask_init(Object *dev)
-- 
2.47.3


