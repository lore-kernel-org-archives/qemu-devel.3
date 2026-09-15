Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE8FC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vtr-0003yf-40; Tue, 15 Sep 2026 12:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6Vtq-0003yX-21
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:20:50 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6Vto-0000g0-IY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:20:49 -0400
Message-ID: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789489246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=INxU0D4tvlYktP1JSHtIL+7zhfvZn36WtZGmwiYzHUA=;
 b=N/8TuB/eIC8qaYtJbgrkSFU7MImravnYXcRCdFAeaQtkEKRiZaRet4mC7CvbQgQutzcORZ
 iVoNwYvXSNPHtazaZp5Vef/PJbA9f8EPIwUjQsgkdbUB8qYB3+ZGj1KSXmMhPcmGZyKAry
 RO/bZMsP6JA2VK7i22AF+g9NR8al+ks=
Date: Tue, 15 Sep 2026 19:20:46 +0300
MIME-Version: 1.0
Content-Language: en-US, ru-RU
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 marcandre.lureau@redhat.com, mark.cave-ayland@ilande.co.uk
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Subject: [PATCH] hw/display/tcx: use memmove instead of memcpy for overlapping
 blit memory regions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SWSA#34e3af79-c6c2-4ad2-986f-313c1ce28e5a

In `tcx_blit_writel()`, memory copying occurs within the same video RAM
buffers (`vram` and `vram24`) using source and destination offsets that
can potentially overlap during blit operations.

Using `memcpy()` on overlapping memory regions triggers undefined behavior
according to the C standard. Depending on compiler optimizations, this
can lead to graphical artifacts, memory corruption, or unexpected
behavior in the guest system.

Fix this by replacing `memcpy()` with `memmove()`, which explicitly
guarantees safe and correct behavior when memory regions overlap.

Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
---
  hw/display/tcx.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 2cfc1e8f..fb48a199 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -587,9 +587,9 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
                  }
              }
          } else {
-            memcpy(&s->vram[addr], &s->vram[adsr], len);
+            memmove(&s->vram[addr], &s->vram[adsr], len);
              if (s->depth == 24) {
-                memcpy(&s->vram24[addr], &s->vram24[adsr], len * 4);
+                memmove(&s->vram24[addr], &s->vram24[adsr], len * 4);
              }
          }
          tcx_set_dirty(s, addr, len);
-- 
2.43.0


