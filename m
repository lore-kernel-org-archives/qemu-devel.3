Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E08CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 04:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unrRd-0000XZ-AT; Mon, 18 Aug 2025 00:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unrG7-0005nm-NO
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 00:14:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unrG4-0002Bw-Dl
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 00:14:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-244581caca6so27580605ad.2
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755490447; x=1756095247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64+ahYFh4IwC51HUbhtOgwf0sNLEsCS04TzU9ll5HPo=;
 b=YtX+rVXs+nLRp2Wj6iuSD2Dhs0COJkCZQI9IT1CEFM8ekwBJwJZyUloas/s4LeDxH4
 XS/NvSmVpDubciR90rr6K3/ceQBwSgqJUZOruQLnPDMdBCLDbhJ2VEgShI6Ekq/UuRO2
 HC3NTVtppikhMFx5sjztVAc7bp91Dj0mMeNljlNh1b0matbPUsjtzhQtPkR2SBLYuPmT
 5vWshzRFan4jFeCKTRaTonSYVPGMgU2Q1RAR/45EBuMoGuDBGzsUgqHdQVyIIWcW1Ukt
 5MLEpUx8bEC2kpljt0xWbbg+OWhshwF1PIVDKiZQyzpL9R8qRrc173A2Aj+Ww4vz1Ffp
 frbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755490447; x=1756095247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64+ahYFh4IwC51HUbhtOgwf0sNLEsCS04TzU9ll5HPo=;
 b=NvaihxmaonoNXvZiK4fkZTqVBLlxKGkE2W1h/LcLxCNQg13U+NRfMg0qFs0FYIWJK+
 hscoYjYv2VpnHKxxROr+KFSC921Py35CUQOWD1h5cdrh56/LeDSFFZdz07e3U87aQbzJ
 5D+Fm2Bv+bJka+wIdX9pbFNYNWk/lTpQKqzBW5l+FwQY+XGO53Idz3CxlcvNxqcimwtM
 ggRmK+5o7soN+h0PRUekhUWrnLZRyRX46hfh1PVZEJ9uhGzrGZJLxQmzsbmVOWXETNYO
 AB/pHnvINojGaSO3GOPr/b2hpad5IDAHrkNtN64q2D4kooTPAjkJZJnRquyqUOnZ9tCF
 BWdw==
X-Gm-Message-State: AOJu0YynPvy+UDnGIHHJ+JfRidSCuYe7qRbKccO5awzIYf5qdqxVktQo
 CiO66M8XGL/X+mzzGuV3zpt2UIeR9Lbc3fAEQWgKaBPhd0LIU64K/kuDu80rV6hqYO21E+djkCH
 7oERfPyw=
X-Gm-Gg: ASbGncsT6E7wnvmF98am3i/TxT9v2998fMd696JyIXI4/QqV7BvBi4ClbbfjLOG7uPL
 4S7x7MG86pYwciqkYs7oY7XhIgrQlOdfX9A2WiVBnunJ9Jnqr2CJPrkroUuS7yoODFHxPcNr72O
 ya9AVTC3eKgwpGfRetWiXPJU2a2nDy1xzfZKkh4LFeJve9b+o7FzGcDkukRJRbxJugzHr69IJ+f
 F3K8hOxSLiaEGQATC7oKzCFB0d0JiuJuRrS4qdSYXmGd+Z7FZP+Nv9lzPUzvAX8FhKkVHRqOSf2
 bXm3NtrZZE901TwN41d63TSlINQRnRA7v51eVOZ8Zl7IEMUHbd75vZF4UvECbQQjG2q5YABCtdW
 1dzU2Qq2lCBFtuIBk2M8LVyxzT94tGkacHiWobFVCspISnGE=
X-Google-Smtp-Source: AGHT+IHrAdJ7dmciH2Py8pMjYvuvihH+V7uvt4TmGTyTFH0eaKLqq4XSUopGi+zLQaPMCnM1Vm5iqQ==
X-Received: by 2002:a17:903:1aae:b0:240:3909:5359 with SMTP id
 d9443c01a7336-2446d8dcccamr147351265ad.40.1755490446765; 
 Sun, 17 Aug 2025 21:14:06 -0700 (PDT)
Received: from localhost.localdomain ([206.83.122.207])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3232f8c8e4bsm5498344a91.2.2025.08.17.21.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 21:14:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org, philmd@linaro.org
Subject: [PATCH 1/7] target/arm: Introduce KVMID_AA64_SYS_REG64
Date: Mon, 18 Aug 2025 14:13:48 +1000
Message-ID: <20250818041354.2393041-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818041354.2393041-1-richard.henderson@linaro.org>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Allow us to create kvm ids directly, rather than going
through ENCODE_AA64_CP_REG + cpreg_to_kvm_id.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm-consts.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index c44d23dbe7..90d792ad42 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -180,4 +180,15 @@ MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_SHIFT, KVM_REG_ARM64_SYSREG_OP2_SHIFT);
 
 #undef MISMATCH_CHECK
 
+#define KVMID_AA64_SYS_REG_(crn, crm, op0, op1, op2)    \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
+     ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
+     ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
+     ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
+     ((crm) << CP_REG_ARM64_SYSREG_CRM_SHIFT) |         \
+     ((op2) << CP_REG_ARM64_SYSREG_OP2_SHIFT))
+
+#define KVMID_AA64_SYS_REG64(crn, crm, op0, op1, op2)   \
+    (KVMID_AA64_SYS_REG_(crn, crm, op0, op1, op2) | CP_REG_SIZE_U64)
+
 #endif
-- 
2.43.0


