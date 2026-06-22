Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61577CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbf8p-0002Oa-I2; Mon, 22 Jun 2026 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wbf8m-0002N3-Lq
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wbf8j-0007vY-J2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782136600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkMffPovnZlGeD50GCpbLJdSgQdWfm1vJ5UbJhCKZO0=;
 b=IrHJ2XzFyPWoYJsK5tzQ2UqZzkCb1OVKvyUMvfI0PJO7UmiKmgk3DGrEbSW2NuyCGBvr3h
 zw/FIlSt/rSJgS+N085oc0Eu/VlELqJxXz01fp9Bd4fu+EQg0BAOuFHFMMn804U37AS2I3
 ++iZ40CM1loYt0fK7RPlBTIbYuB1C+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-WO6wt2dnPD-ciN92cQ9YEw-1; Mon, 22 Jun 2026 09:56:39 -0400
X-MC-Unique: WO6wt2dnPD-ciN92cQ9YEw-1
X-Mimecast-MFC-AGG-ID: WO6wt2dnPD-ciN92cQ9YEw_1782136598
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46067399d5dso2263907f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782136598; x=1782741398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkMffPovnZlGeD50GCpbLJdSgQdWfm1vJ5UbJhCKZO0=;
 b=r4T7umfICmyUzxNkisBRdIhpwDT6tQGtQwzqoOJZT09xMF04iKQ1qdEMucLyHEW7iB
 mPLmI5yNseqOXt3bnnkUu0yGUpoJc3byttD+OUnNX2sLGNYVvkTt1IxTi7JEZGbJP63g
 bB311C8DfJZ/ddOCEh9LZFZLy+sczWdLGQRcebNxunKYAMrw+hM6fPADVGb5YeNR9Lxl
 VKxNTGindGYWTx4VGbWqC6C/4oq1nJWSTxMw1UuFH+zz/pHi3e0/oL6QALArDqMOkHVl
 p7z+1G9GKe+HPwxXNezkqMZ4WDNSpG60RO52flSlRKN3Fp57N4VJx6GPOjxWqCjy1prf
 h8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782136598; x=1782741398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AkMffPovnZlGeD50GCpbLJdSgQdWfm1vJ5UbJhCKZO0=;
 b=gmyv9vZjA0FbhJCknqCv3GnFtv/dsrFV+BjdVuo5sMqcNOyeZgEB4YB+tKT47ZSEH5
 ePeukhdiLo9P6l1vJ5FaLAm0V3q/1FIdYu9UUNgs97Xce1JA11qkVXT6GSz6FCPa/Mpu
 Fr9MZHLDwvV9Kireq6wiuTf3PF7FCwG1h0V4IgvVdr7B4zgPQHrOjczUxLL2zWMedGK2
 gJ09bfnfWpYQztKrcb620SweBJyws6F1MfoyDjagw6ujXELNLbIVwz/N7+qZDyWYwJhn
 pLo2AUq5VkcsrEsEfJDWbmfvptR1kB+HTJ9yndvPMUIEEv+yLXjXXDNjL74U4dcGn/d5
 ybDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpq7GPV5qOd8871aTCJYI2gD5a9g+sKOJz2iDkQsJhztA1hz8jG0qAetXowSE/rpld40ehTIpoaLdou@nongnu.org
X-Gm-Message-State: AOJu0Yw9p7Qffyx1yajSEVWhzlo+9mlnlk8fj08s92aSw8cWRah/oPv/
 d5dvtemJhoI39C73NEWAJnwfLgI99+n/qRbL3QAaFZRiH5T77nKzuTBI4NrlRz2wc1RBc8XikLA
 l+6aT+Zs6+WEAPPXiVRczWMqHK9xrzvlPpGUmvv1eXdxHrDS807NYQBsf
X-Gm-Gg: AfdE7clkkKMPoSryhFvs4mNAJUbpr7Jl7zOXC2/RsejH6DFLIZl0Beo/jXhkCVzocTG
 i4YCYtm/kOJYqUepRNW6GIhRUPwwamKBoKeSaeq8B9atNwYFDL+X9uYsNQRuww7AzKGuZWQPeb6
 CVbT4srhhqtLtPnfiDHSWCrk0yEtI4AeEJ+g36BxTj9BZQ7+KaIaoC1UhzHJdlhfk/ugJTDqbgL
 +RH5hjStijbGOPSdLmiR2MXqn53pmflDlRcwNaVXZYH7kz2Nd4xWO6Idu9PfXcKXqi/x26PiJ5Q
 apAzv2sa5xmFIsL4baKRiigix/sPywEp/+4aITNVVNwOuvpHOItOyWUr7bpEBe8CUHmKGbpiSyy
 PAUSjkt5EKe13GNxM/6+OmtOnUs675VewkGbpV7OPiW5wTBAutCmeSfvMbc0mQ2Y8is/E13QcsW
 Q=
X-Received: by 2002:a5d:598d:0:b0:46a:45d:2bed with SMTP id
 ffacd0b85a97d-46a045d2c13mr2308448f8f.8.1782136597767; 
 Mon, 22 Jun 2026 06:56:37 -0700 (PDT)
X-Received: by 2002:a5d:598d:0:b0:46a:45d:2bed with SMTP id
 ffacd0b85a97d-46a045d2c13mr2308400f8f.8.1782136597308; 
 Mon, 22 Jun 2026 06:56:37 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm25162303f8f.1.2026.06.22.06.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:56:37 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 1/3] arm: handle demuxed ID registers
Date: Mon, 22 Jun 2026 15:56:25 +0200
Message-ID: <20260622135627.40573-2-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622135627.40573-1-sebott@redhat.com>
References: <20260622135627.40573-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 31a5567c95..fe0046b02e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -919,6 +919,18 @@ typedef struct {
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


