Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B972CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOWF-0001I3-Q9; Sat, 30 Aug 2025 12:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3z6SwaAgKCigFLMPPMIVKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--bhillier.bounces.google.com>)
 id 1urhh7-0008Nu-2Q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 14:49:57 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3z6SwaAgKCigFLMPPMIVKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--bhillier.bounces.google.com>)
 id 1urhh5-0005Vz-Ac
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 14:49:56 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-248942647c5so24239405ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756406991; x=1757011791; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eZmDu3jdm85zT/kkoUu6drjP5lcoEw7fmNxr6cvxvOc=;
 b=xIoPD+cqITqybP+7BMN73F3CzbXoLpDUOhVtvJJb/WhY+dg4DPJvI7+uPfMyVXG0hS
 n/N8QcPg5LgScGIwxURr3CdDKTmjYLAdwDxAHYeoLB/6zfVJNcrujPBaQZKgpYZhQOjr
 dh6w1+ZAFP4l/UjSzz0GP2MspTS4YrKGCRhCFYyxgZdUe1ucCgYuW1l2ZQ3uuufAmyp9
 Bx09XaKW5EBUzY+qI+BQxG42wHCeUhReMtC6/pcB9XsjaQbsALZWbB8nS91vAriH3QJN
 D1NM4ItAOmj78V1MxuqIUJO7fdfwYIH+nde/P6wvfbwcOLadWFHYSK1c32ioFhwegJ10
 fE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756406991; x=1757011791;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eZmDu3jdm85zT/kkoUu6drjP5lcoEw7fmNxr6cvxvOc=;
 b=uK8o6/izxi04gbZswSVg55QWEWsedvyyOYLqz9ECEJVim+3mAqOePGLL50xu3z8Qi1
 ZZdM6EnTVjDSvy5Kmay+k5kcVuOt7kwIjFZ8lCkkQWZzWvSY8micpDZ8/lHD6y0pXPUQ
 UcHQr6+DEHOyT2zoqDsEnaxGx8DurwrYlsIppyH0hHlWr+sUyl4OEe4XNTNvmiKjm2Do
 4FQH8nJW1gUUWefxfD+3QLDY6l3Rf+CLhvVwPES4tit5TecH2Hdi4h8E/ABlrdeESHUb
 1TeICYVv805K87rGm1+IWzrzwPEuuN0dM6ia3xn3vDXnpDy5EYVS64+7nVQhSIPMqt9V
 y9sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzq6G7vo1nBHIZgWysG0QrAmNLWwpeDvQY48Y0mwcubMS27MRrnOJKG3GrEISkpgtdD4vTIVXizvUY@nongnu.org
X-Gm-Message-State: AOJu0Yx0qWdk2Mqv1f3WTdyeF6wHuZW6ZB6HKl2XI1aAf6XbNGiL2Vf9
 JjHUTKH7FphovupMlrcRUdsGAzh21drZwOqGHlRj9hgDf94BpV6PaJfjO/Unwrq1OKCIPCGPw5Y
 Ey/NtyRx59KzSYQ==
X-Google-Smtp-Source: AGHT+IFFN1RUSe+6N2gyNpYf2PINpcV8AlhKuNHHRTeOId8d2OcXFzH4KBrNVJtnpd8mKrZF9+Ii9+tFlpdVSg==
X-Received: from plhy6.prod.google.com ([2002:a17:902:d646:b0:240:11bf:3c68])
 (user=bhillier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:11c7:b0:246:ac9e:6fbe with SMTP id
 d9443c01a7336-2487539f6aamr133968785ad.10.1756406991128; 
 Thu, 28 Aug 2025 11:49:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 18:49:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828184939.3140841-1-bhillier@google.com>
Subject: [PATCH v2] hw/sensor: add stub for ADM1266 blackbox
From: Ben Hillier <bhillier@google.com>
To: wuhaotsh@google.com, kfting@nuvoton.com
Cc: philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3z6SwaAgKCigFLMPPMIVKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--bhillier.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Titus Rwantare <titusr@google.com>

This patch fixes a bug that causes a kernel panic when calling ADM1266_BLACKBOX_INFORMATION.

Log Message:

adm1266 5-0042: Could not read blackbox!
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: adm1266_nvmem_read+0x168/0x170

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 9017ce6116..cd11526c2b 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -75,6 +75,7 @@ typedef struct ADM1266State {
 static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
 static const uint8_t adm1266_ic_device_rev[] = {0x08, 0x01, 0x08, 0x07, 0x0,
                                                 0x0, 0x07, 0x41, 0x30};
+static const uint8_t adm1266_blackbox_info[] = {0x04, 0x00, 0x00, 0x00, 0x00};
 
 static void adm1266_exit_reset(Object *obj, ResetType type)
 {
@@ -125,6 +126,17 @@ static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
         pmbus_send(pmdev, adm1266_ic_device_rev, sizeof(adm1266_ic_device_rev));
         break;
 
+    case ADM1266_BLACKBOX_CONFIG:
+        return 0;
+
+    case ADM1266_READ_BLACKBOX:
+        return 0;
+
+    case ADM1266_BLACKBOX_INFORMATION:
+        pmbus_send(pmdev, adm1266_blackbox_info,
+                   sizeof(adm1266_blackbox_info));
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: reading from unimplemented register: 0x%02x\n",
@@ -154,6 +166,9 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
         pmbus_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
         break;
 
+    case ADM1266_BLACKBOX_CONFIG:
+    case ADM1266_READ_BLACKBOX:
+    case ADM1266_BLACKBOX_INFORMATION:
     case ADM1266_SET_RTC:   /* do nothing */
         break;
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


