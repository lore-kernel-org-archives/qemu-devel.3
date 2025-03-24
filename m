Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2491FC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmox-0001T7-Vg; Mon, 24 Mar 2025 14:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmow-0001Nu-0F
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmou-0008Rf-2w
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso4509432f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842001; x=1743446801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhAN9Lyj4bqTf4UUrdE+Pmn+JYUm8J4DDJYtyAVBykw=;
 b=PQjm1zhdzEZI8lOxVMowPz314WIqOqwo0bH1v8NgqUQZoRcrOg+3BmQk0a/F9TP1Sd
 OhGp6WKNg8Z49vAhtq0VgfOk+XWuYEXEJRVneFqOWPWjRcv09EVJd0bzsPaovMnwoKHD
 impMbzsegyDhCqEzHr0RbFuuQrQCWJOZ+dDYOG8DCyoWIb+sLy3/nMgrpndNCqT+VBcT
 sGsyxoNwDyMSiAAPDxEr+pXdApGioNJlXry917JH4iX6eOJGoYM8YubCr1DeQouZryqq
 sSPJAov/tVeIJhDDfb36lfeLjxBi3oeVX3PHoU8/7D7ihvYcX/BY30JHxf1Gg/Jz6xbn
 XWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842001; x=1743446801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhAN9Lyj4bqTf4UUrdE+Pmn+JYUm8J4DDJYtyAVBykw=;
 b=qd4qeNtsxzS6W7GN/02XnUL4F/j8fHKidmFWWSZOau18e+jVBJOCwjgV2+xO0f1e8G
 0YQrKsqLjDBQaRCg/7qFkKPevxTXmR/xP70pUGQv1hNcY73t+k/J1OMFyK//+JKTQb2c
 ZrmyEv9yae7azs9451kLgJw27L/Cqz5BlbIjmB03BRyQJTSNW6AMEZflfMh0XilE9YS3
 fwDNDqkmShU/rwFsQk4fih201kAc8qCNcOUiRudh53dlXjB7pPue4xbq9fLVdYInBW6a
 tcSz6u/dkak/Ef7apb1cEDeKEQQbxBpMhEyk8FsLpRH/ucPHGKiZFar1RJvh9fZF1rHy
 WTWA==
X-Gm-Message-State: AOJu0Yw2r/w2tDuy+rv05ABcsvIE6BS4QqeI4+/db3c3KIlKp6ZVPeKs
 XFpqLXO0oa+Xzkb3be+ISbohrnzDIEP1LovXibwUgmgWOpYRwrA90iaGaDepDtkCQmRM8HVO5aL
 +
X-Gm-Gg: ASbGncs7aWxnB9Zm+mjMYHSL7rftvu6ojhji6SK0xHfhinbzMUSv8nG8fw6aUHHWpMU
 FNhg3oFEf7ceQUk/J5Y6E+khEYDJabed5xgm8DmPPniGoGjUlAWqComEMnnpjnELxC956PuQoJQ
 aoBHiMnqx12zO1ATSh9Ia4OUJV4F7W/xo8GKcGT6mTuu4Um22OThGXe3qX7aZAxluyYXLDwRETk
 7+zQy1ftQL09GHA9+WY3jGScXM8JT6PBBju7bDHCXywTTi+rpxiBytyCwjZlSkiDNNnjlZ3l9Zx
 DtGP+7GiqjlM0NxMAH3b4mbK0rRbtO8I6i6lLNFIO2aPoK2YJ9JlV/z1R4WwvCaki7dXN8Uzz9O
 tmRQfkRw5ETYYCFR6rUkxFUbF
X-Google-Smtp-Source: AGHT+IGzDwu9wh9t/TNevUL6JGccIan0lMFDcdDpPo+R78MSOg80QE6UQ8bxNzPtw/RPXamEKi5wtA==
X-Received: by 2002:a5d:5886:0:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-3997f940d74mr10501324f8f.49.1742842001207; 
 Mon, 24 Mar 2025 11:46:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdb03e9sm129423165e9.33.2025.03.24.11.46.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 5/7] target/s390x: Declare
 s390_set_qemu_cpu_model/cpu_list in cpu_models.h
Date: Mon, 24 Mar 2025 19:46:09 +0100
Message-ID: <20250324184611.44031-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Both s390_cpu_list() and s390_set_qemu_cpu_model() are
defined in cpu_models.c, move their declarations in the
related "cpu_models.h" header. Use full path to header
in s390-virtio-ccw.c file.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.h         | 4 ----
 target/s390x/cpu_models.h  | 3 +++
 hw/s390x/s390-virtio-ccw.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b7992deda6..8dd1936e3e2 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -900,11 +900,7 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
 }
 
 
-/* cpu_models.c */
-void s390_cpu_list(void);
 #define cpu_list s390_cpu_list
-void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
-                             const S390FeatInit feat_init);
 
 
 /* helper.c */
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 71d4bc2dd4a..f701bc0b532 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -113,6 +113,9 @@ static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 }
 S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
+void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
+                             const S390FeatInit feat_init);
+void s390_cpu_list(void);
 
 bool kvm_s390_cpu_models_supported(void);
 bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 75b32182eb0..4f11c75b625 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -35,7 +35,7 @@
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/ap-bridge.h"
 #include "migration/register.h"
-#include "cpu_models.h"
+#include "target/s390x/cpu_models.h"
 #include "hw/nmi.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
-- 
2.47.1


