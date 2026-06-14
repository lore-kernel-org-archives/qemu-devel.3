Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FECCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 22:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYtDB-0005rO-3z; Sun, 14 Jun 2026 18:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wYtD9-0005qp-8F
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 18:21:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wYtD7-0006jd-GK
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 18:21:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso23391665e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781475704; x=1782080504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6CG/WgbatJUkWqqEVEYulvnsdB1l2zxTLovXt1zwR6Y=;
 b=fausyVPeelKBGUg3EIxm5rFDhusWjSKl3F1Hrg1WCBlkAcJ8zizPs4D20CfgS44oe8
 NKW5OhnLv6ffrbWks5h5zsgTV0WbvoaVXSLnlFXMPirXuI5+01LMhowOp5fzFz6472jd
 s9UiGJSdQ1solF9Yf1SBdnn8/B00q8gTcinKcQIe6fJ7xSZ7AtlJBV8dg318iGNWmpJC
 qGXpy1qyIjdsDGaxrPMLYTT9QNq/5/L01Cr2PzwMPFkgCbik6vMnetU774hxOej+Ryfv
 pd3jrZa9aulNQIre9ocOsyJSsfyUpGK2aN/Bm8iaJUEgeORG1SxufUQzf0bjGtKRsWx5
 iGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781475704; x=1782080504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CG/WgbatJUkWqqEVEYulvnsdB1l2zxTLovXt1zwR6Y=;
 b=dPqkx21nSTt9Iu8WghBx94cJImMcPoDFV49WUCbPx15CbVlTQz+Ahc81yKsBdzEiDu
 YDJoRwkfnAfaInovD4XvUehuZU0dwNQakSYv48XZvaFxMPUx996OhOfdESAYOo1n0aGQ
 dR+cYehOd9dv1sZpQuARwzbrmQ7ReJadE9JGMPEsTWlY2eRWOUKyt0y2gqyQD9FR2gm/
 Cf4TOJ4nwAY+MtWmqjiVwITKISJCN7nlzcrM4FhwBXg8SN6hf3Oe4uyPB8leLnM5V4F+
 KzdRHRFaJWSRyWsec+gvcfgbIptaAPsr6o1MHQAc6ToWeYYljF7Wrs6Z/TqxcUXMEz9v
 n0jg==
X-Gm-Message-State: AOJu0YwmzsRmEQQk2q7++oskAI5/ZhCQyWC3BLXqNXbyXkwoCNiw/MHB
 m9tC/umd55vtSEtyn5rH1U8eMvIy/Sw3tIi2Vgl0FbqJHlCcyV/XSbVyuxpCfhPp
X-Gm-Gg: Acq92OGsys0fHBtV9Ky6CehA1YE0DwRZ8zX2NLL/moJ9c8c/F/W8JUc3Rh2cEiVcr6d
 M6kFQPc99YXuLyairdL66RlY4oRv1WV7f0fAMaTn2PlvFtl1FRa2miPHrUYWckt+xqIjwEl44Fl
 Vfve30IoIQJwQV6JMKjXXcQfE0Z9gDqPhb6syXzCzN24zO8LhuMpbbMQpd+Da3FtLElTzZueeMR
 LlGUG5xqIX23PtLbRRX/45k0D4wikecuc5dyCs0aNcniMYTpYE4bemt6X2Rr5fMXKCMrezvbpsZ
 qQ30nFkofthhmJShKsvM2Uummpqr02rs/3hUzryDdgfp6IEKpFSoB9oAEQjTA0GVpKmTFkoDgpM
 3aDimGEO3ql/Z712sYP9/aCD8SGoYL8Q0JK/M37V/xo5M2jKvDnEjBcnqtZKQz7QAqL1m044dG5
 T6vXDPaxLMtjJ6ccPVbrD3/fnsmOt5snwlmCxnPyvJdNv0yIvGQ9HXI7mZXumOJl9TxwcRFLE8k
 YY8EGk=
X-Received: by 2002:a05:600c:4b13:b0:490:aef9:aa3b with SMTP id
 5b1f17b1804b1-49220104edbmr61113685e9.32.1781475703801; 
 Sun, 14 Jun 2026 15:21:43 -0700 (PDT)
Received: from user-Legion-Pro-5-16ARX8.. (cable-89-216-220-81.dynamic.sbb.rs.
 [89.216.220.81]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm28423476f8f.18.2026.06.14.15.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 15:21:43 -0700 (PDT)
From: imaginos <imaginos32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Titus Rwantare <titusr@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-arm@nongnu.org, imaginos <imaginos32@gmail.com>
Subject: [PATCH] hw/i2c: pmbus: NUL-terminate strings received via block write
Date: Mon, 15 Jun 2026 00:21:31 +0200
Message-ID: <20260614222131.5795-1-imaginos32@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=imaginos32@gmail.com; helo=mail-wm1-x332.google.com
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

The PMBus string registers (e.g. MFR_MODEL on the ADM1266) are writable
by the guest. pmbus_receive_block() can fill the destination field
completely, leaving no NUL terminator. When the value is later read back,
pmbus_send_string() calls strlen() on it, which reads past the end of the
array and returns a length that trips

    g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);

aborting QEMU. This is guest-triggerable.

Add pmbus_receive_string(), the write-side mirror of pmbus_send_string(),
which reserves the last byte of the destination so the stored value is
always NUL-terminated, and use it for the ADM1266 MFR string registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3388
Signed-off-by: imaginos <imaginos32@gmail.com>
---
 hw/i2c/pmbus_device.c         | 13 +++++++++++++
 hw/sensor/adm1266.c           |  7 +++----
 include/hw/i2c/pmbus_device.h | 10 ++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index b1f9843f52..7c65d8c8b5 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -142,6 +142,19 @@ uint8_t pmbus_receive_block(PMBusDevice *pmdev, uint8_t *dest, size_t len)
     return len;
 }
 
+uint8_t pmbus_receive_string(PMBusDevice *pmdev, char *dest, size_t len)
+{
+    uint8_t rv;
+
+    if (len == 0) {
+        return 0;
+    }
+
+    rv = pmbus_receive_block(pmdev, (uint8_t *)dest, len - 1);
+    dest[len - 1] = '\0';
+    return rv;
+}
+
 
 static uint64_t pmbus_receive_uint(PMBusDevice *pmdev)
 {
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 37d1cffd57..81545385a5 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -142,16 +142,15 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
 
     switch (pmdev->code) {
     case PMBUS_MFR_ID:                    /* R/W block */
-        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_id, sizeof(s->mfr_id));
+        pmbus_receive_string(pmdev, s->mfr_id, sizeof(s->mfr_id));
         break;
 
     case PMBUS_MFR_MODEL:                 /* R/W block */
-        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_model,
-                            sizeof(s->mfr_model));
+        pmbus_receive_string(pmdev, s->mfr_model, sizeof(s->mfr_model));
         break;
 
     case PMBUS_MFR_REVISION:               /* R/W block*/
-        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
+        pmbus_receive_string(pmdev, s->mfr_rev, sizeof(s->mfr_rev));
         break;
 
     case ADM1266_SET_RTC:   /* do nothing */
diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index f195c11384..4c4d3e5ae2 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -518,6 +518,16 @@ void pmbus_send_string(PMBusDevice *state, const char *data);
  */
 uint8_t pmbus_receive_block(PMBusDevice *pmdev, uint8_t *dest, size_t len);
 
+/**
+ * @brief Receive a Block Write and store it as a NUL-terminated string.
+ * Write-side mirror of pmbus_send_string(): guarantees dest is always a valid
+ * C string so later reads cannot run past the field. Use for string registers
+ * (e.g. MFR_ID, MFR_MODEL); use pmbus_receive_block() for binary blocks.
+ * @param dest - string buffer with enough capacity to receive the write
+ * @param len - the capacity of dest (the last byte is reserved for the NUL)
+ */
+uint8_t pmbus_receive_string(PMBusDevice *pmdev, char *dest, size_t len);
+
 /**
  * @brief Receive data over PMBus
  * These methods help track how much data is being received over PMBus
-- 
2.43.0


