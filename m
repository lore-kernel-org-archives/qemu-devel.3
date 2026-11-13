Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC7606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TS019Okw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjL-0001aY-7Q; Fri, 13 Nov 2026 08:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnnJ-0001sc-AG; Fri, 13 Nov 2026 04:42:05 -0500
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net ([206.189.79.184])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnnH-00022E-Gj; Fri, 13 Nov 2026 04:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=IcEUuNtag/5cwrbnt2gyrDZqhS2q2hpF7Q
 8fIK4/Tsk=; b=TS019Okw8ePgw3y/FsPkJFzvf9shdBqC+Ci0K8ucDM7mBWrjZZ
 rkHTuUoPVPM0N+ZdwDWyncFFDxZefKYz3epOh6EBB3JrJ5LAXxFk5hVD9sf4XKgc
 N5K9BpdJgrg2dc582rKvOm78fqtX4jxLz0fVo1hVQ1TodhIq15+QOZhV0=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQDXRzhZ2_ZqWAhCAg--.45084S5;
 Fri, 13 Nov 2026 17:41:57 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me,
 kwolf@redhat.com, hreitz@redhat.com, clg@kaod.org,
 peter.maydell@linaro.org, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, bin.meng@processmission.com,
 tangtao1634@phytium.com.cn, Chao Liu <chao.liu@processmission.com>,
 Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
Subject: [PATCH 4/4] hw/block/m25p80: fix page program address wrap
Date: Fri, 13 Nov 2026 17:41:43 +0800
Message-ID: <a7056e87c660a2b32e115faee800284cca1a014f.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQDXRzhZ2_ZqWAhCAg--.45084S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15GrW3AFy8ur13ArykAFb_yoW5WF1rp3
 WDJ3Zay348WrnxXws7Arn2van8uFs3A342k343KF1YvFsFg3W5tryftr1q93yrAryrtws8
 KFsIyF48Ww48KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
 c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GFWl
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE2Q6DUUUUU==
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=206.189.79.184;
 envelope-from=w-yf22@mails.tsinghua.edu.cn;
 helo=zg8tmja2lje4os43os4xodqa.icoremail.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:52 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

The flash wraps page program addressing within the page when the write
crosses the page boundary; otherwise a page-crossing program can
corrupt the following page. Correct the affected devices' page sizes to
ensure wrapping at the correct boundary.

Fixes: 82a2499011a7 ("m25p80: Initial implementation of SPI flash device")
Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/block/m25p80.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 15aba33bce..7205c48b1a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -194,8 +194,10 @@ static const FlashPartInfo known_devices[] = {
      * Atmel EEPROMS - it is assumed, that don't care bit in command
      * is set to 0. Block protection is not supported.
      */
-    { INFO("at25128a-nonjedec", 0x0,     0,         1, 131072, EEPROM) },
-    { INFO("at25256a-nonjedec", 0x0,     0,         1, 262144, EEPROM) },
+    { INFO("at25128a-nonjedec", 0x0,     0,         1, 131072, EEPROM),
+      .page_size = 64 },
+    { INFO("at25256a-nonjedec", 0x0,     0,         1, 262144, EEPROM),
+      .page_size = 64 },
 
     /* EON -- en25xxx */
     { INFO("en25f32",     0x1c3116,      0,  64 << 10,  64, ER_4K) },
@@ -289,10 +291,13 @@ static const FlashPartInfo known_devices[] = {
      */
     { INFO("s25sl032p",   0x010215, 0x4d00,  64 << 10,  64, ER_4K) },
     { INFO("s25sl064p",   0x010216, 0x4d00,  64 << 10, 128, ER_4K) },
-    { INFO("s25fl256s0",  0x010219, 0x4d00, 256 << 10, 128, 0) },
+    { INFO("s25fl256s0",  0x010219, 0x4d00, 256 << 10, 128, 0),
+      .page_size = 512 },
     { INFO("s25fl256s1",  0x010219, 0x4d01,  64 << 10, 512, 0) },
-    { INFO6("s25fl512s",  0x010220, 0x4d0080, 256 << 10, 256, 0) },
-    { INFO6("s70fl01gs",  0x010221, 0x4d0080, 256 << 10, 512, 0) },
+    { INFO6("s25fl512s",  0x010220, 0x4d0080, 256 << 10, 256, 0),
+      .page_size = 512 },
+    { INFO6("s70fl01gs",  0x010221, 0x4d0080, 256 << 10, 512, 0),
+      .page_size = 512 },
     { INFO("s25sl12800",  0x012018, 0x0300, 256 << 10,  64, 0) },
     { INFO("s25sl12801",  0x012018, 0x0301,  64 << 10, 256, 0) },
     { INFO("s25fl129p0",  0x012018, 0x4d00, 256 << 10,  64, 0) },
@@ -1675,7 +1680,15 @@ static uint32_t m25p80_transfer8(SSIPeripheral *ss, uint32_t tx)
     case STATE_PAGE_PROGRAM:
         trace_m25p80_page_program(s, s->cur_addr, (uint8_t)tx);
         flash_write8(s, s->cur_addr, (uint8_t)tx);
-        s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
+        if (s->cmd_in_progress == AAI_WP) {
+            s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
+        } else {
+            uint32_t page_size = s->pi->page_size;
+            uint32_t page_offset = (s->cur_addr + 1) % page_size;
+
+            s->cur_addr -= s->cur_addr % page_size;
+            s->cur_addr += page_offset;
+        }
 
         if (get_man(s) == MAN_SST && s->aai_enable && s->cur_addr == 0) {
             /*
-- 
2.53.0


