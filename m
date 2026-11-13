Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F91606A33A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=kvgjF4UL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjF-0001UN-N6; Fri, 13 Nov 2026 08:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnnE-0001re-Ss; Fri, 13 Nov 2026 04:42:01 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnnB-00021R-DY; Fri, 13 Nov 2026 04:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=BhNMR/FRz2ZGwXKP9oUvq6S+TqUtEjfWRY
 0BsuDwE8g=; b=kvgjF4ULnsq4NPK0oz1gdXPxTiXucKfAIm3clr4rN58tgkF/rf
 okiIarI5XumMZI4D46LK8Am7kEC3K0wKdx6Irzx1rvEWL16YhLW4fziCaUlZhRL0
 Chjcx5Hm5aX29swj8ofSGqefIx+Oj3SGiIQO++JMEZf/zSvUQkrWea/5o=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQDXRzhZ2_ZqWAhCAg--.45084S2;
 Fri, 13 Nov 2026 17:41:47 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me,
 kwolf@redhat.com, hreitz@redhat.com, clg@kaod.org,
 peter.maydell@linaro.org, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, bin.meng@processmission.com,
 tangtao1634@phytium.com.cn, Chao Liu <chao.liu@processmission.com>,
 Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
Subject: [PATCH 1/4] hw/block/m25p80: fix erase past the end of the flash
 device
Date: Fri, 13 Nov 2026 17:41:40 +0800
Message-ID: <2b14e487c5719cb70f78515304293990c0abdccd.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQDXRzhZ2_ZqWAhCAg--.45084S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw18KFy7Cr4Dtr1xAr1kXwb_yoW8JF45pr
 1kWF45JrnagF1xWa1Sv3WSqr97CFn7Ga98Jws2934Fy390ga4IgrZxKFy5G34DJr1Sk3WU
 Zr90va1UCF95W3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUP014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
 AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE0tC7UU
 UUU==
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=w-yf22@mails.tsinghua.edu.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:50 -0500
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

Erase commands are addressed at the containing erase unit; the flash
ignores the low address bits, so an erase in the last erase unit of the
device must not extend past the end of the backing store.

Fixes: 82a2499011a7 ("m25p80: Initial implementation of SPI flash device")
Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/block/m25p80.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index baf798c6b5..2a882c392c 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -639,6 +639,19 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
         abort();
     }
 
+    /*
+     * The flash ignores the low address bits of erase commands and erases
+     * the containing erase unit. Reject requests whose erase unit is not
+     * entirely within the device.
+     */
+    offset &= ~(len - 1);
+    if (offset + len > s->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "M25P80: erase at 0x%x for %u bytes is outside the "
+                      "device (size 0x%x)\n", offset, len, s->size);
+        return;
+    }
+
     trace_m25p80_flash_erase(s, offset, len);
 
     if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
-- 
2.53.0


