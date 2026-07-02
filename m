Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C14FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHaW-00084k-8I; Thu, 02 Jul 2026 09:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHaV-00084B-4A
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHaT-00015a-AW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782999376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rR3wOaCqir41NboczA76GKl3LF8SZvplqqP5ybbjVs=;
 b=ek11kYKdaslO2sFsZL9Hs33A0Bfxm+w/12a1QkOMncwAt/XUzkEGVOJBkQBZP0ptcwLyUz
 S691BoTGSyCeXZo4a1gZ1D8bSlDTRMFjHLm+EsvEF7noZFvepfQQSWFN70jAUQfr/o0+U+
 8Ou6RCVuxcR1uXORWVEp2ipqvwo4nOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-QqBrvTwHO86RJHaOZCRSaA-1; Thu, 02 Jul 2026 09:36:15 -0400
X-MC-Unique: QqBrvTwHO86RJHaOZCRSaA-1
X-Mimecast-MFC-AGG-ID: QqBrvTwHO86RJHaOZCRSaA_1782999373
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-476608a9fefso477104f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782999373; x=1783604173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rR3wOaCqir41NboczA76GKl3LF8SZvplqqP5ybbjVs=;
 b=qwMtD1N9P+Hk1NnFMJvpPaqLNxt1B5rM2MC2dTSZ/+g6qsNX6exUrH8d12KSzgTv8b
 b9+GU0eyGbe+4SyGVQyYOTvcD2QcpyASl4K14bEF1kqLWUfI2NOCsHGDJ1vUhHb9Qece
 DHqpnjwA5eT1zPHd9GdRfzEfL7wyMeoZWy3xA31wk/PTPC756FvOaxpAP0Vca+JFFDKU
 36Uu9WsMYyTnxRnO1WtpX3MBP2oCS1roqAC4pNnJrEvRLGHpsCnq0zH4Q/L/XQeLy7zt
 qdGXvS82lx7yyAik6Hbpn5NaySI/Js1w+W3nVxoTJg6QBR5t8f5oLLRMcXkyEMe4jGF9
 IL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999373; x=1783604173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1rR3wOaCqir41NboczA76GKl3LF8SZvplqqP5ybbjVs=;
 b=Zk7VBOXQvzBFlFcBHnXaog/O9l8OrnnoeHyCnsgvjzb40PMPgdl00Hs4idZWaDBVoL
 pYpACqcPvx8uZ8fyhXkpyjsyh3ytUBHZabjotlZ7WI9qCqlkzXBSxBviOUkEYLgz9WD1
 70pX05BzlPAyb3TGQkJ7qryrPvt9pXbS5flWs5AJ5wg4phx+M6awQZNnvKJeMcPQiuZO
 ltGUXDG9vMuk4iamUcO/AM7lDZu3OhwNO5f+Brkk8M/qXWHe5ePaYCy6ySyKgs9F5XMa
 0Hv/LsPzTUQTcK+eGx4DoAL3pFNZnbmjXZIxZvNvZ/L0OpOOzje5cQnmaEQ/iDH3n3v5
 GOLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCOTBKVHz3TJqVn+wdKDtIURo3dRlLx8XdeZBv7bHmsk1zCw1MFZiXPzHE/Kyw+pSxTPXq6uDG3EzI@nongnu.org
X-Gm-Message-State: AOJu0YxAL6+LxPtVO2d0VB8VvnlOtQRFE3B6AHwPn8u8zYIoHR4z16BB
 Ju5UWT83iBlKMvuOUlvbYcKk5YMPvV/Y+ElGjxeZ7OGVR013LTvPxXty0JFNqaDaHyztFpLrPIf
 adTtqKzybG8MhmBcy7fJY9mnG4E39dtbu91H9PPjYBdp+pqH91zR9+bB1
X-Gm-Gg: AfdE7cmF60OiSzftbmKViH0p3MXopCew6fRxEz81HGcbbpBrcXM8megUrvoOHk8C3Sd
 RmM+Ea6U9ocv5kmpcQrdFe91x/Wv5GPZU5zDtWQ4w8LEmbzwg94T+oZcUvGeIoXSmDqzDLki6vF
 EpCnxjyw+XnTpAwo7zpmGdkudLWJY/Epfg3CFZvaYGvHr13skyeNc3/Ww7t/7Leggcca0gIivsq
 +lYT6ty7MD5hc4oH0QoNBJoYK/t74KrIicsewOKqrhS94+e1oxj2kzKytQ1xF0CbqKexz3krId9
 C5HOkTxpVmK+Mbv0k9mkhSOIHJ5WwnfM+QONlMBn3OYWJ/GjxutDXuIRIFA53M5aEIIwzECyV5C
 3KyzjNeM4rs7rAwX2FczW/SKWIWGOu2ye5/1x9PfihL3w49+ks79ziP9MJlWOfLxG2N9XbXnXiA
 ==
X-Received: by 2002:a05:6000:26d3:b0:475:f0c2:75af with SMTP id
 ffacd0b85a97d-4774643eac5mr8474698f8f.26.1782999373277; 
 Thu, 02 Jul 2026 06:36:13 -0700 (PDT)
X-Received: by 2002:a05:6000:26d3:b0:475:f0c2:75af with SMTP id
 ffacd0b85a97d-4774643eac5mr8474641f8f.26.1782999372790; 
 Thu, 02 Jul 2026 06:36:12 -0700 (PDT)
Received: from rh.fritz.box
 (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb01sm9135980f8f.1.2026.07.02.06.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:36:12 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v4 1/3] arm: handle demuxed ID registers
Date: Thu,  2 Jul 2026 15:36:04 +0200
Message-ID: <20260702133606.34529-2-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702133606.34529-1-sebott@redhat.com>
References: <20260702133606.34529-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cornelia Huck <cohuck@redhat.com>

For some registers, we do not have a single ID register, but actually
an array of values (e.g. CCSIDR_EL1, where the actual value is
determined by whatever CSSELR_EL1 points to.) If we want to avoid
using a different way to handle registers like that for every
instance, we should provide some kind of infrastructure. Therefore,
add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
we already use for regular ID registers.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/cpu-sysregs.h |  9 +++++++++
 target/arm/cpu.h         | 12 ++++++++++++
 target/arm/cpu64.c       |  8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index 7877a3b06a..a4b9621a7e 100644
--- a/target/arm/cpu-sysregs.h
+++ b/target/arm/cpu-sysregs.h
@@ -20,20 +20,29 @@
 
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) NAME##_IDX,
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    NAME##_IDX,                                         \
+    NAME##_IDX_LAST = NAME##_IDX + NUM - 1,
+
 typedef enum ARMIDRegisterIdx {
 #include "cpu-sysregs.h.inc"
     NUM_ID_IDX,
 } ARMIDRegisterIdx;
 
 #undef DEF
+#undef DEF_MUX
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
     SYS_##NAME = ENCODE_ID_REG(OP0, OP1, CRN, CRM, OP2),
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    DEF(NAME, OP0, OP1, CRN, CRM, OP2)
+
 typedef enum ARMSysRegs {
 #include "cpu-sysregs.h.inc"
 } ARMSysRegs;
 
 #undef DEF
+#undef DEF_MUX
 
 extern const uint32_t id_register_sysreg[NUM_ID_IDX];
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 84d33e87dc..5668deee4c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -920,6 +920,18 @@ typedef struct {
         i_->idregs[REG ## _EL1_IDX];                                    \
     })
 
+#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs[REG ## _IDX + INDEX] = VALUE;                        \
+    })
+
+#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs[REG ## _IDX + INDEX];                                \
+    })
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2816735577..48a0421674 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -42,14 +42,21 @@
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
     [NAME##_IDX] = SYS_##NAME,
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    DEF(NAME, OP0, OP1, CRN, CRM, OP2)
+
 const uint32_t id_register_sysreg[NUM_ID_IDX] = {
 #include "cpu-sysregs.h.inc"
 };
 
 #undef DEF
+#undef DEF_MUX
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
     case SYS_##NAME: return NAME##_IDX;
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    DEF(NAME, OP0, OP1, CRN, CRM, OP2)
+
 int get_sysreg_idx(ARMSysRegs sysreg)
 {
     switch (sysreg) {
@@ -59,6 +66,7 @@ int get_sysreg_idx(ARMSysRegs sysreg)
 }
 
 #undef DEF
+#undef DEF_MUX
 
 void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
-- 
2.54.0


