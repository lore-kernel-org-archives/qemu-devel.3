Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE4C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyD-0005Op-4t; Tue, 28 Jul 2026 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyA-0005LN-9Y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy8-00031k-CH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so3814787f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241894; x=1785846694; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gUUiNLWtaOE76P9Ld8dPEc8PLTGOYX0cCZJT6bvTEgk=;
 b=NouFk9+vnaJUcPHpR378lcyTyXRgUV0m7mooFEfl2a16PJDosGH2/M+bBX45xssljX
 0E3qB03usZAEAsZmR9EssERx+I2QZqdA9zHc2ufXa6xw6WmSheVjSDH/OJAzzBDIbKW5
 dGLcmsgioOLZBVMUyLkq4m66jgXt1DCBn8U5MQnz8TnBs8KHjaZj6E7CzHs2Vn54sRjW
 6rJK2NNhJehv+JcsUXXtD0Knk/bkZvb3j2hKsf8kvCJDcF3pm+DxumhFXaTgAsRZX+hw
 47xHQGUxFBkPr8AmbO+vZlilzBcms0DUWukQb47YYSMAoPGFDc37IaBYTiQflgomiZRA
 mC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241894; x=1785846694;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gUUiNLWtaOE76P9Ld8dPEc8PLTGOYX0cCZJT6bvTEgk=;
 b=J1ArvzRpEKeRIEqjQeAuqH6H9eRgwulG2MKtieDrUofweoQ8WqtBbbGJqQ9p3i24mS
 OldssSbCvgGXr3tbZ5PWEkNQZVsCsBpSdnVIlEi8IgWk9kc5eS6s6utkuPC+twqsmzKJ
 PLAkZyEJKqSwDqNYxwjOFXLYCFcJDHVJAnUeXKHtnA2hvXWDyR7Nve4uHbFWUvWvMF1F
 nhdsYMmEbAgQFoSvg4IZcrbz+FFJkNY43Dsl04OCB/yrP4EwAI5dFsRUTPXt3NizmOfz
 vTOEdZSLCY9K/x6UC9y3vo4fcqEY2oEGH66WCPK/UEogWl7RSt0WWgTu5eB+sZv0ZCQa
 D0iQ==
X-Gm-Message-State: AOJu0Ywg0auTtn5DBc5v0sfQPpypz6nEGrxie2Cc477v4HNOvXzn5hw1
 2cuUgdgEBlKOztOvE3fxybsOvhHQaD3EqzYd1gJGQniFG85c519+GjBvSshlKiAhp70yUKIZUMT
 +wydZ
X-Gm-Gg: AR+sD11zP+O2bi+TcYKOw2W64S132yYiObdFweyIN8y81YMtmMr+AqfC9tN/WdmKAkv
 jBXLFfB20r0XO/St0Q8PIuo43rq1OzLSodzTJ7XJx1KumPViQ2yQUfTKCU7ql05u+YWBegvGmFT
 mgbuwNb0C8ydumEyzxINAn9cruuR5AMi8ciFpPgzgLRF+QfZdb3BLifMAE4lMnW33HbAcCZ7Kr3
 t6HETa77unzmeXMn2n5WEgzaGII7OyCshGWtwuUdPc9zpe43qoZ+Q8Pmfg0Igror2mOgL/0HBiJ
 t6IAQnE9/+z2mf5yEJjb/YiShsjKoHcltFKc05cja9fyU+L/uplSdSFNkFtjFv/YaBbkF8JffSn
 UIU4JOx4uBd1XK40ok0z8z6slXNc/TExnfDB59E/I7xs2hJX3ehbaL8H9QEvUx6oRFgkSqj9Esy
 MmVNLSt4nV+dvMlgYliCiuxGiCSA64KSwCkSsJjfJdXIAcWeLkBVzBwZZoIQpz6oZ5kRwomy/ZD
 tO2CBcrj08=
X-Received: by 2002:a05:6000:25f9:b0:47f:73fb:daa1 with SMTP id
 ffacd0b85a97d-47fb1e8e7efmr2532926f8f.19.1785241894283; 
 Tue, 28 Jul 2026 05:31:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] hw/net/can/flexcan: Use mbs[] array for FIFO pop
Date: Tue, 28 Jul 2026 13:31:12 +0100
Message-ID: <20260728123127.1711653-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Implement FIFO entry shifting using the underlying `mbs[]` array instead
of the overlapping `fifo` union view. This makes it explicit that the
operation copies within a contiguous mailbox array and avoids Coverity
CID 1662971.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260723070059.6332-2-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index da36d10bd33..3a97edf7a4d 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -879,22 +879,22 @@ static bool flexcan_can_receive(CanBusClientState *client)
  */
 static void flexcan_fifo_pop(FlexcanState *s)
 {
-    if (s->regs.fifo.mb_back.can_ctrl != 0) {
+    if (s->regs.mbs[0].can_ctrl != 0) {
         /* move queue elements forward */
-        memmove(&s->regs.fifo.mb_back, &s->regs.fifo.mbs_queue[0],
-                sizeof(s->regs.fifo.mbs_queue));
+        memmove(&s->regs.mbs[0], &s->regs.mbs[1],
+                sizeof(s->regs.mbs[0]) * (FLEXCAN_FIFO_DEPTH - 1));
 
         /* clear the first-in slot */
         memset(&s->regs.mbs[FLEXCAN_FIFO_DEPTH - 1], 0,
                sizeof(FlexcanRegsMessageBuffer));
 
         trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 1,
-                               s->regs.fifo.mb_back.can_ctrl != 0);
+                               s->regs.mbs[0].can_ctrl != 0);
     } else {
         trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 0, 0);
     }
 
-    if (s->regs.fifo.mb_back.can_ctrl != 0) {
+    if (s->regs.mbs[0].can_ctrl != 0) {
         flexcan_irq_iflag_set(s, I_FIFO_AVAILABLE);
     } else {
         flexcan_irq_iflag_clear(s, I_FIFO_AVAILABLE);
-- 
2.43.0


