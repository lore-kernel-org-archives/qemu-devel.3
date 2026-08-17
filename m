Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426B4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxXp-0000KW-Db; Mon, 17 Aug 2026 09:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXi-00008o-6f; Mon, 17 Aug 2026 09:38:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXg-0007og-Av; Mon, 17 Aug 2026 09:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=4+WEB+LQy0Tc32kqtCUaVfnGSocnc7jKnrircHxryB4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R2Nuert05EYiXeR/JaJg4gRh9NmeOpuoCZF0r0dw4lSrrxBcOyv/eLuHxKuP/FTd9
 02aNp+2pejzgoNIIXDj24CA4vHLLF1RtSL1y60zaD8gM7td0jlVVm3zIIEokTQmm+I
 ZkmMroIL/Nlm75LXAS2vuymWvwfurN+nkwRq0ZpLQ73Y4k6QUl0xQRjEjMXwKquWEP
 o22GvgLdnt5nBj14c7hC4n5B4lIOuSeoWoppiXAKFKRu3Ox8aoyYM42yS0NOtD1yJn
 laeiJBPBR370AF3B/REXd2kVp+tLWEGIGHY93rxmQMRXFgdZhyy7zCBMxa3XI0vEv9
 2wRQNPoo+tpug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 95E7B1CBCD4;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D093E40D431;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E24FE30FB2; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Guo <guobin@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 133/135] hw/block/pflash_cfi01: Restore ROMD mode
 after migration
Date: Mon, 17 Aug 2026 16:34:43 +0300
Message-ID: <20260817133451.2384630-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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

From: Bin Guo <guobin@linux.alibaba.com>

pflash_post_load() did not restore the ROMD mode of the memory region.
Although cmd and wcycle are migrated, the destination retains the
default ROMD = true from realize.  When the source was in a non-array
mode (e.g. ID read, cmd = 0x90), reads on the destination bypass
pflash_read() via the ROM fast path and return raw storage bytes
instead of the command-specific response.

Derive ROMD from the migrated cmd/wcycle in pflash_post_load.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4042
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMD: Including review comments from
 https://lore.kernel.org/qemu-devel/CAFEAcA-P6RH7nJK0KQ1H8576ULFA7nocB0EkhhZf6Rw3g0WCag@mail.gmail.com/

 Confirming that this is correct is a bit tricky. It relies on:
  * when we set romd mode to true we also set wcycle = 0, cmd = 0
    (which we do, in reset and in the mode_read_array code)
  * when we set romd mode to false at the top of pflash_write(),
    all paths out of that function either go through the
    mode_read_array path, or else update pfl->cmd to something
    non-zero
  * nowhere outside pflash_write() udpates cmd or wcycle except
    for the "clear them to 0 and set romd mode" places

 This is almost but not quite true. In pflash_read(), the default
 case for the pfl->cmd switch sets wcycle = 0 cmd = 0 but doesn't
 change the romd state. Luckily the "this should never happen"
 comment is true -- there's no way to get a pfl->cmd that falls
 into the default (except for being deliberately fed a bogus value
 via inbound migration).
]
Message-ID: <20260803041808.58174-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

(cherry picked from commit 60d010f66f2ad7c15388a605e6f1a2114dc60185)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index b5ea927f360..72b29708fff 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1038,6 +1038,16 @@ static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI01 *pfl = opaque;
 
+    /*
+     * ROMD mode is not in the VMState; derive it from the migrated
+     * cmd and wcycle.  Only (wcycle == 0, cmd == 0x00) is read-array.
+     */
+    if (pfl->wcycle == 0 && pfl->cmd == 0x00) {
+        memory_region_rom_device_set_romd(&pfl->mem, true);
+    } else {
+        memory_region_rom_device_set_romd(&pfl->mem, false);
+    }
+
     if (!pfl->ro) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                         pfl);
-- 
2.47.3


