Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3300C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDul-0005tA-4x; Fri, 11 Jul 2025 09:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu5-0004X8-1H
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu2-0003BB-N0
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a510432236so1586098f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240901; x=1752845701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTXqJiKgfiB3QVh055cqmNddLyPU05fki5TAKLA/ZXA=;
 b=bP4punfSNMliHszV4JtUpntRws9here+yeHCGzeZVXVC9O/uggG6U+jIBg9eZqLf88
 wbE6YA4CjjK/NZ6+pL9vwji6D+RbT44UVBripiGqIKv3rYThrKkoAjDaBYnhmpnXwfA+
 9uPfN/4HC8xEQpmiHpVm1UGbxkL+rbuLNB3xNvknsP0vxPC2CmFJEjbcrgudvdHellHB
 Mb3G0mnCzVEyutmVoWvGPcPUnDHvTlSnOwlG7pEoTF5laxI9a9q50GQJGNMkCyLHih7T
 NXTUnzo71g701OdAF2X/muXRcdwfQ39IinNfYqYQNrD6t9ZXWM9+TYdnkDWFjCCrS40K
 /5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240901; x=1752845701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTXqJiKgfiB3QVh055cqmNddLyPU05fki5TAKLA/ZXA=;
 b=E9xKkRiz22ZnTbnuFzEkdyeZb2eJGT1lOSeztSbqeJAs10ZzkPexsQJ5Rhlg8aqYjM
 3//u2/G4weiq8TXvrsg4CN6WaszOfhcjfu/XPeTjyyjYcMPEe3WnHRYFeggl3j2kKxe4
 J0JJe0g2anCxLF7rEYg4camMv6J8djLVIDe4WFRdgDuKMEXTRrVJbHhqfLjA/Icon4fb
 QKilj936lr2XnDRSJAsH7kqaru1mV/BJ7Dvx9qyrBCFcWkp9kQ1YHxA4Vrq3DcB/PM3U
 x1RpjBYmiYdljUX/tao1uZ2D+P21nzBQiAN2JNflNfVPifd4TD4qpfVvqJ6No880sg3m
 w7MA==
X-Gm-Message-State: AOJu0YzcGs7lYZ9yQZaFuhJGzyclBo8QuX0Q0RvzT/n4+1wU2oUmLISN
 7NdX4HuCaSL6nIuDlhQRusBUlzydT1e96ltCCRXACf1qDERt/QEFTwOKem64b7yDaBbXQk3im/5
 AwAm5
X-Gm-Gg: ASbGncuIEEiFM1zsVO0LssyI1I7bgdfgubyVxWDhdQxhnKA78598NUY9hElsKWLq1O3
 CF6qBCxtJ96ie7mBAcXlvyjAaPS6nDxhmwrxU03kRhnwSo3az4B3BDMAVZ682/cLEZ0c1a6ZNlo
 3zYjcI7z6DP1irZtKVqSlocY1W+ccNC/Xfw1C6Ag/5djlDdi9snL5d6dcnA2aWR5vsW2weBddPy
 KUy8tySx8xibKg6fSC3wwUdSmsor0HjHGZYGTqGozNpFv0ERpoOWnEQ5PB3fQ7aUzmj92+5jnYG
 SSJz9K7lciIBM9X24JatmvRjxVBO6JAmCwaMWfOTfj8yn+oWOGOuGTk5Edva7iMXCzlsaxqA+Gz
 ejLD482Nxx8jxu5f8GSEL1YQKclGa
X-Google-Smtp-Source: AGHT+IE3ZGbVoWSIwDYDfxvxpuao+ZOWXY94HhVG7gXy/mK6vcCN3d5Jcac2K/D1PuW2dV/Eel99lQ==
X-Received: by 2002:a05:6000:2089:b0:3a6:e1bb:a083 with SMTP id
 ffacd0b85a97d-3b5f2dd2e52mr2849125f8f.25.1752240900941; 
 Fri, 11 Jul 2025 06:35:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/36] target/arm/kvm: Add helper to detect EL2 when using KVM
Date: Fri, 11 Jul 2025 14:34:21 +0100
Message-ID: <20250711133429.1423030-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Haibo Xu <haibo.xu@linaro.org>

Introduce query support for KVM_CAP_ARM_EL2.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250707164129.1167837-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h  | 7 +++++++
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 7dc83caed5c..b4cad051551 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -191,6 +191,13 @@ bool kvm_arm_sve_supported(void);
  */
 bool kvm_arm_mte_supported(void);
 
+/**
+ * kvm_arm_el2_supported:
+ *
+ * Returns true if KVM can enable EL2 and false otherwise.
+ */
+bool kvm_arm_el2_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 34e57fab011..c93462c5b9b 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -47,6 +47,11 @@ bool kvm_arm_mte_supported(void)
     return false;
 }
 
+bool kvm_arm_el2_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8ab0d692d36..9fdf354f3bc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1763,6 +1763,11 @@ bool kvm_arm_aarch32_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
 }
 
+bool kvm_arm_el2_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
+}
+
 bool kvm_arm_sve_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
-- 
2.43.0


