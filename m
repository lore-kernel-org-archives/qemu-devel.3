Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F77C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2bY-0001cz-9l; Wed, 02 Jul 2025 14:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bV-0001Us-Pl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bL-0001jU-8z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3277920f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482473; x=1752087273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=kNZPOKwe8U9iskwHOrTwN2LSOvV4PmBvTVrl2F6V/xzAXqc8Ywngun94J0wi7iDJ82
 x78HjgcYvgeKH81j0SHHvHCX8eY8R0c/W6sputWSGo4guQDpgsIm7zVQmr/BPMBFdRdb
 6A4hYzTt0j5iMQ+HBnxvTt+Zqcw8dUaUav1mB8Z8/0m00k7XOzTfS4VKYJ7YLFFqDV5c
 2DNSGIZ8NNE6UCGcIe0lnSYq98jLNlnF2bAtMfifyWCgotAAhb6OFY/6QWOWobvtpm2/
 4yPla+3ui5dDfljaYJ+k4Pacz78A6EjqP5LnrwMCfB2PzKAh4d6Ck4KTxZEP1eYigugH
 Rctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482473; x=1752087273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=hR44eiDH35lgw96SmrKsxphNsnVV6x3T/NxPy4Yu9/3L5RLt7ZxvJSL2wvG5ysaCW9
 H8mL2IRVRdgt8k+RliVuDrDZzw4bcUXufZ+03sZOmT0hRFHzB8X2CZ+iSfFBDIAMLwNm
 jxl9B1aL4rrAWminhaLjH1Q83g9vIW1ZRvgdk6KmlB5jvTFDJ5f5afurHgeuSAD8839o
 puJTnowLIQOoo3wdys/Dm9Sro6TE40Asuf8puqnWgiB0JK/Hzli7kDUFlOaVshgUmTox
 wJeC2pTtYqtY0oGu6MMwRhry/X9kii/XvnyCIOxo275lkPP+TqrWHR7DcVJ9FxnZAomZ
 vL3w==
X-Gm-Message-State: AOJu0Yx4rJozMjfZsidQpXKIA2XzOPFnZzvVTjszaaBoeS3shdNvOA3L
 VUmMHthAXz/zmvxd6rEZb3Mb0fsT0Xt3DavN8yyHAhfarGXYyZmfIOcbwI3PKNMfr92CvBkGQuA
 q5XRK
X-Gm-Gg: ASbGnctpY72ch46ouUvbKpuQGErARHhpBFPHeQXuDjkiCEyd9tqsggKACQK/qWfTnY5
 5/BpomuOpFa7MxSI8j/aVPgqF7ZIbsmgXbZMU3jVCa/DyvhpD0Rf3CJ1yBArQGt1R+CeEiA0pm6
 jNX7b3+hkUFaF5iHqm5llG1f09aoc/53NdJDc/NHYDAwBWG7RMHa4DDS4TiUbX6N9PqZ+LE7dPH
 6RISw2ceRJ2pBMSaoM5I/s+0DlOEEvVaJOD6iRxyDkm3psGuSFZ3eoP9/c7AnB0JY7RyOwXVBA6
 17MIcfW36M+Uqku/C1/SWaplHnxC47hSZcChSLsh3Mb4uQpFVVhjfr5pnQrPQKKmQiFyM8eMYFx
 Mb/kuadyTj7uvjh8dzy4AeN79N8/2UyB54vg4
X-Google-Smtp-Source: AGHT+IGhOWVCA/GtwJSG1AKi+Hd84LJnSX/lQi41cAsunon2TKagKaTx0uBPjZixIm2CjgJYn0tp6w==
X-Received: by 2002:adf:f1c7:0:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3b20095ce85mr2954669f8f.27.1751482473295; 
 Wed, 02 Jul 2025 11:54:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f44dsm16537392f8f.87.2025.07.02.11.54.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 08/65] accel/kvm: Reduce kvm_create_vcpu() declaration scope
Date: Wed,  2 Jul 2025 20:52:30 +0200
Message-ID: <20250702185332.43650-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

kvm_create_vcpu() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/kvm.h | 8 --------
 accel/kvm/kvm-all.c  | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7cc60d26f24..e943df2c09d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -316,14 +316,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
-/**
- * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
- * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
- *
- * @returns: 0 when success, errno (<0) when failed.
- */
-int kvm_create_vcpu(CPUState *cpu);
-
 /**
  * kvm_park_vcpu - Park QEMU KVM vCPU context
  * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d095d1b98f8..17235f26464 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -453,7 +453,13 @@ static void kvm_reset_parked_vcpus(KVMState *s)
     }
 }
 
-int kvm_create_vcpu(CPUState *cpu)
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+static int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
     KVMState *s = kvm_state;
-- 
2.49.0


