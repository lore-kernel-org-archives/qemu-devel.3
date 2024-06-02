Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD1C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 10:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDi9J-0005NM-Tf; Sun, 02 Jun 2024 06:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixinyu20s@ict.ac.cn>)
 id 1sDi9I-0005N7-Lt
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 06:09:12 -0400
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lixinyu20s@ict.ac.cn>)
 id 1sDi9G-0001fu-JF
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 06:09:12 -0400
Received: from lxy-MS-7D25.loongson.cn (unknown [114.242.206.180])
 by APP-05 (Coremail) with SMTP id zQCowACXJBLARFxmrInsDg--.57239S2;
 Sun, 02 Jun 2024 18:09:04 +0800 (CST)
From: lixinyu20s@ict.ac.cn
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 Xinyu Li <lixinyu@loongson.cn>, Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: [PATCH] target/i386: fix SSE and SSE2 featue check
Date: Sun,  2 Jun 2024 18:09:04 +0800
Message-Id: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXJBLARFxmrInsDg--.57239S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWftrWUGrW8ZrW8XF1fWFg_yoWDZwbEqr
 4Igr43Ja1UZrW2kFWUCry5JrW0qr93Aw4DZanrtas0vanrtrnxGF9rXF4xA3yjvr1Fqr18
 Ca97urWI9r4SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOa0PDUUUU
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: pol0x0t1xsi2g6lf3hldfou0/
Received-SPF: pass client-ip=159.226.251.84; envelope-from=lixinyu20s@ict.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xinyu Li <lixinyu@loongson.cn>

Featues check of CPUID_SSE and CPUID_SSE2 shoule use cpuid_features,
rather than cpuid_ext_features

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 27dc1bb146..0ec849b003 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2041,9 +2041,9 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     case X86_FEAT_PCLMULQDQ:
         return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ);
     case X86_FEAT_SSE:
-        return (s->cpuid_ext_features & CPUID_SSE);
+        return (s->cpuid_features & CPUID_SSE);
     case X86_FEAT_SSE2:
-        return (s->cpuid_ext_features & CPUID_SSE2);
+        return (s->cpuid_features & CPUID_SSE2);
     case X86_FEAT_SSE3:
         return (s->cpuid_ext_features & CPUID_EXT_SSE3);
     case X86_FEAT_SSSE3:
-- 
2.34.1


