Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A93C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJe-0000RU-9p; Fri, 20 Jun 2025 13:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJb-0000RG-TK
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJa-0004Bv-At
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so11224865e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439648; x=1751044448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eK2RBwA1vSwFH9em0YNn78on4UqtxDIiJ5tRw+dlaOM=;
 b=aHKn8/Nq9OF8cyKTCDUR4+zwu6M7iVmJ6240F8j6EjfVemS+123xRcXM8ZXkmWFMkO
 dSfmYIn6LTCCCYoV3N0LCQWpq7OAVjnwKE6+0UntCqevD/uO/j6GnOBudXBjnLDbyz+K
 mhRWo6TA1VUtUdODoFEmUb2oAG0aslNC6wjDicPI5cxIO34xMBSQUYSIwWoFsomWl2RX
 Vh4kVip3PTCNdkYsJlCb3oCrSbocaOgomveyXlGLHdN/ynbRgeVHIOpmO+M1E/gxw+bf
 OJLGp/T60XYZRfm9LHCdIjoXYHIU/E9WNO/pmDkR1lbR2bByX3Ch7rEsVLzkThhPXugL
 /d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439648; x=1751044448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eK2RBwA1vSwFH9em0YNn78on4UqtxDIiJ5tRw+dlaOM=;
 b=KGnEP/o5pAkXrYUKBU/CjtaoBxV+TBLeaa9YhK2qECZvWosfUROa5E5oYTHQZOH3j3
 9gOqMPtXN1qqhtZsdAgyOV5jZHJ8mDeXJlbIQApqpDDFflZ26ASMtMuhPXua8bP7pOoE
 DNG2YWSZmJWGi5UFEkCUHcvIQiqBtB6xwQ/EWJ4hXx5RcpuazQUR8iFygyPGNYAb0A6u
 95HpklFUPq1Voyavh6Iml/oMgDJJZkf1NQLsMZ7M06byQKQV7Dbz0IdkB+jvPVM1tZZc
 hSb+xlxsn2IuqNWJt5vZPd8N7Nv891cd4K11afDXtusAwJiJjM6gC8it4AuTd6vBgpC4
 fwHw==
X-Gm-Message-State: AOJu0YzUzXv1GbFYRxLqkQtPYgK0FT+Z1hsqIsame1AWR8o73EV9YkWm
 l0cmSun4LDYdxIaEXxKSh4vCBDYwSMGJPm5lEHqyD22nDeelJN0U/jz7lEeAEnwKKE7LdpceMnx
 25wDqfNU=
X-Gm-Gg: ASbGnct11ilx+qpXBB/wb2HoUMekLskgvuRPckicdLQ141Mud+yVqVmzTFmrp575MSD
 0IJU7GN5SPhm4lGox3M1Cdd2SHSfxgM1A1SlJhjmwjtAdwcsS3wEOfmA/Pol30EqDdNin/iRcN6
 JtkPoUw5VHjKCHtgEtiCY1QW05S9tZAUDzopP+LV3mgx8aBGRtn1V/wtoThYih+frFH+c1l8r1h
 TEx05uyKbHlIQhfNJOR2nRqE7onEWm/8ufs4bSZVbxsiy+MHciH9KO8l24n0mTc9r6gM1TeXR9H
 WfFbgqxHbF4JK7jfOBMMmWnK8DQSpH6k+MaXBxvAQPA6ud1PfEExnJGcbFrl9X8OF639T8bGfuY
 X2pwm+eYrx5KHXCHlMsSFvFL5pjuih5ul0m/M
X-Google-Smtp-Source: AGHT+IH7hgkMOcul3sOf2bUAwC2Hj0fodlajjbyqHS81pyc5VWoPPpsXqrQ59vCDB4hXEu5JwPdVpw==
X-Received: by 2002:a05:600c:1f14:b0:453:5d8d:d1b8 with SMTP id
 5b1f17b1804b1-453659c4169mr38300575e9.30.1750439647916; 
 Fri, 20 Jun 2025 10:14:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97adf3sm64326515e9.8.2025.06.20.10.14.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 05/48] accel/kvm: Reduce kvm_create_vcpu() declaration
 scope
Date: Fri, 20 Jun 2025 19:12:58 +0200
Message-ID: <20250620171342.92678-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
index a31778341c2..aeb75e1602c 100644
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


