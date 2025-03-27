Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040F5C3600E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txkpP-0000N1-Tb; Thu, 27 Mar 2025 06:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txkpN-0000MS-KX
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:51:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txkpL-0000h7-AF
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:51:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2264aefc45dso22845395ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743072669; x=1743677469; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BoZKhiYdB7y0VsWGB1lwV+BmgJ4aOh0AR7Uj+91th2Y=;
 b=fUC5DyvakFd7tzI5Q+/YjpQmmuWfF/yuwikvy0JjwfksgTfP8ysAx7/JQyi0RCsM7Z
 0mv9Kx9My+474Rao6vRomXG3zdy/yU6vQVH4sVaIgJ3CReqy8WP3r/Qu8KiL2lsiFkKj
 StvzoJnCbcgy/cWpxbtc+9Gs/EhuYGxUi7OqJdh3t8OE8zp1NiUtbpeeE2N+uTopg8dV
 eAfC/9TB8uF5KEGks3Gb782CJRmzT6Dt95GI6ns6PoPRUwOr/jlG3hEgYyXkbGJww+5m
 PUhp3OC1AcwGXUI/dukeXlGRNSaHWlKRubrgZeAE/qkzC7viYeIsnu57CVN+M98eXlbz
 uviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743072669; x=1743677469;
 h=content-transfer-encoding:cc:to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BoZKhiYdB7y0VsWGB1lwV+BmgJ4aOh0AR7Uj+91th2Y=;
 b=WRiypSSP9RP+2jdAafSGAP3x6/Q4qUPnu2akHt2dmt32yl9YIsoTfd6shTJoSCoRPn
 qFdWMvoC0AT0+ErlyB2lSMFZ3z61HbAtHvoOw2rPe7ficnxo4PM/FDzvVdmklYmfwNej
 CVtSelS4uBvfL28NLXrZUNgkxiEJ10iZD+T9mP59fAzUUf0X/fLA8FqRM8Jn6AmGO1CZ
 KIxCCDbflRHI8BH/oC00JAUo1ql4xFVddCKUUS9CnJZRzI5iCkcV7kyY5ysIT2IE5coN
 dgAUGvT+mK5adkbYIHP86xyAZLDd/ImaOcGfMj/s3XVfitH1wocaJxjn8zQjtFEcAI4/
 zRsg==
X-Gm-Message-State: AOJu0YwuHRU1Yx1wPHE92VrdRh1vXePIrKkHf5Jbym6zE/tM167mxwFt
 LJJwmulOyRJK5s3LMncnyFSYkQJIBrsOUbKSHUHUdhtCGmKnl+UJq2Q2zQ==
X-Gm-Gg: ASbGnctDuG5eNP3ahz0djUtrAvReIYNJDvh5xmXMKQvzF2jbwgWuiXXP9hOCIZ76wyn
 ny8vhwORaLUntSGbhV7U4F/enAFXE0gK23d9Z24+sdQR3noxmtdbDPRw8apExkJ1MBssPpfcLFe
 izRIHJ7+A/I1XSHPeNHYDSG52y2lhdppA1C+QEbomA8FZcNNRpet2aRM9NkZWHouf3qYhmJqiiS
 grA9zSgS6z0vPaHQ4eLEEpin6ffMHw8aUL7dMMkIt3/khcrlLzq+PA6mvT4ixZeM9VI4zl5MTgH
 WT8dcyOFIrtx4UeWFxaUc5vDuWXXuFUCNw+OuEf4boFQKNDYlGXkHU3bqoayAarp
X-Google-Smtp-Source: AGHT+IH10qg1boEfgWWdKWuo08B7c/SIHxLOUqQi0gL/0DyE1TIDJM0G1KsOQf58m5oSjyyT9tYWDA==
X-Received: by 2002:a17:902:fc46:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-22804840f08mr53051815ad.19.1743072669050; 
 Thu, 27 Mar 2025 03:51:09 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.229])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b596sm126114915ad.16.2025.03.27.03.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 03:51:08 -0700 (PDT)
Message-ID: <55d118e8-d3aa-41f9-a4a4-cffed1c30e78@gmail.com>
Date: Thu, 27 Mar 2025 18:51:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/net/virtio-net: fix memory leak in timer_del()
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,
This patch addresses a memory leak bug in the usages of `timer_del()`.
The issue arisesfrom the incorrect use of the ambiguous timer API 
`timer_del()`, which does not free the timer object. The leak sanitizer
report this issue during fuzzing. The correct API `timer_free()` freed
the timer object instead.

In addition, I'd like to ask for a way to fix all 100+ wrong usages. In my
opinion, the best way to fix this is to hide to `timer_del()` API and
eliminate all usages of it.

Signed-off-by: Zheng Huang <hz1624917200@outlook.com>


---
 hw/net/e1000.c       | 6 +++---
 hw/net/e1000e_core.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 3d0b227703..5dddf9e0a7 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -379,9 +379,9 @@ static void e1000_reset_hold(Object *obj, ResetType type)
     E1000BaseClass *edc = E1000_GET_CLASS(d);
     uint8_t *macaddr = d->conf.macaddr.a;
 
-    timer_del(d->autoneg_timer);
-    timer_del(d->mit_timer);
-    timer_del(d->flush_queue_timer);
+    timer_free(d->autoneg_timer);
+    timer_free(d->mit_timer);
+    timer_free(d->flush_queue_timer);
     d->mit_timer_on = 0;
     d->mit_irq_level = 0;
     d->mit_ide = 0;
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2413858790..61fdc8a3e9 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -127,7 +127,7 @@ static inline void
 e1000e_intrmgr_stop_timer(E1000IntrDelayTimer *timer)
 {
     if (timer->running) {
-        timer_del(timer->timer);
+        timer_free(timer->timer);
         timer->running = false;
     }
 }
@@ -360,13 +360,13 @@ e1000e_intrmgr_fire_all_timers(E1000ECore *core)
     int i;
 
     if (core->itr.running) {
-        timer_del(core->itr.timer);
+        timer_free(core->itr.timer);
         e1000e_intrmgr_on_throttling_timer(&core->itr);
     }
 
     for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
         if (core->eitr[i].running) {
-            timer_del(core->eitr[i].timer);
+            timer_free(core->eitr[i].timer);
             e1000e_intrmgr_on_msix_throttling_timer(&core->eitr[i]);
         }
     }
@@ -3452,7 +3452,7 @@ static void e1000e_reset(E1000ECore *core, bool sw)
 {
     int i;
 
-    timer_del(core->autoneg_timer);
+    timer_free(core->autoneg_timer);
 
     e1000e_intrmgr_reset(core);
 
-- 
2.34.1

