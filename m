Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A049C3600E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 11:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txlPl-0000PP-He; Thu, 27 Mar 2025 07:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txlPj-0000Oy-L6
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 07:28:47 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txlPh-000774-DI
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 07:28:46 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22622ddcc35so24265005ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743074923; x=1743679723; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=U/JXAmLgWTRI8yQPinWvWYgmGiBzmhZrTg7DO/hG6pk=;
 b=np8xY6TPzab746GR3HstAN9HE4zpAp0i9yGEViqTv3J3dvzOsP1ORxMEmyuRpb1aC8
 sUKvv8igMNnr01ZeTOJoUxjv+igvjl0wCbzQhhy6jFHBwxKgKoU+5uKLcmjiPqCk83q2
 vmLs7r5JRSKevxsHm2xSMpO7wSeZAjHXY5UWlqQcgjWpebPZ3QGud4tmNCSy8WJZeYmt
 YpqRTSwRAO5Q9gZSdswWx+M4fDPrMJjP267HfNr5Tean/EN2jbwBn/D7l0A4il48EMWz
 e/l/MWF6IU4OBzmXA2okWtDPcznUimoYbtkWiE7cv+znv6yngeSI75Wozqn8tYB6X9am
 8LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743074923; x=1743679723;
 h=content-transfer-encoding:cc:to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=U/JXAmLgWTRI8yQPinWvWYgmGiBzmhZrTg7DO/hG6pk=;
 b=XhMdnE9ZMHq9SEiFnmSX89+Kp8k7bPPvUCng4WTEQta58INJdu8S8R/rLUJvI0Hi6Z
 KlN7G0zSd088F83WyJjJH8pFRqNI+932LUpYAwm5gChDmV5szLZNU3vWJ8Bur/bBALZv
 gn6mtxX60IpMjCitIqzTomBFpioBorzMVdPlTgqGzw5T5gfZnphdiWFZKVPVGFm7YIOS
 /URsKrl1Y2GC/y7QkhuB/AdtO9vdyruHzhYGWV+3jz0BlFt7zZ42W7RoxGdLx/H1T4Gq
 Ybl9KYVZ1HoOE0gIXUpiqBsxGhGh40l7TqFBl6Se83ZB4HNfTuN5Sf9l4Y8EWtAltUJw
 r/Hg==
X-Gm-Message-State: AOJu0Yy8JP+fMkj2BIdteZuXXKjGxM/fh3uuG7uoOJe4Dg0kv1UFN03S
 giR59w1jSAUahGDx0Tn9Za0/BIMH2Z9kBekHWayJOrA6a8eoTYWUU4tl/w==
X-Gm-Gg: ASbGncvtK22+5ULdvm1p12irQrMD2fffjyj/yzACgh55cpVLyLyMc8QRKRXpWPlutco
 03w5VPt6esjcl6yAOqHJyPjjD3Q6gShMyZgyEFo1WW5yasXbjS9bGSKaqVjtBoiz6e1ME+X10gT
 VKD380MNYwBK5KIwDd+8O8NRdPUz108JlXWotvG49IEpldNeBZp7P/aTNs+VNWMl/m1ph1yU3Oa
 3ldcJdsAKnQ36SqWqB2OVQThlRxuevkIbWBAzczV7KDqoBZUJPa/0gnwTsK/50OXxkUDbb254RO
 vuGEeclT/W/JbEDu9SBadQyr+3O9Nh5dfocMT9l9akV8HM3jhMrDkP40EGI9wque
X-Google-Smtp-Source: AGHT+IFWqXW92VTGjKPKmDWb6ua2PJWzDo5BHr2xGztxbrhRsX21o4UycTQR+uMnJNX52SRHAHWJ/w==
X-Received: by 2002:a05:6a00:1410:b0:736:55ec:ea94 with SMTP id
 d2e1a72fcca58-739610ca9c2mr4616647b3a.20.1743074923083; 
 Thu, 27 Mar 2025 04:28:43 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.229])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390615654esm14384521b3a.130.2025.03.27.04.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 04:28:42 -0700 (PDT)
Message-ID: <551d9eaf-dce0-4cf0-95b1-d2347bfaa1a6@gmail.com>
Date: Thu, 27 Mar 2025 19:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/net/e1000: fix memory leak in timer_del()
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

ps: Sorry for the mistake in subject of the previous mail.

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

