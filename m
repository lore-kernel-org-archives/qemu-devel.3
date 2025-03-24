Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CF5C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn11-000144-DM; Mon, 24 Mar 2025 14:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0z-00012v-Bc
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0w-0001Qy-Kj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2823624f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842748; x=1743447548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhAN9Lyj4bqTf4UUrdE+Pmn+JYUm8J4DDJYtyAVBykw=;
 b=tsbZ9IDWQzEi9TLyUBrySZJb04NukdaXjn4GluRc3gmMINqEcvuyn7WpqVKG0Wh9zr
 1U7PegJc7y0DLjQDFMS1ZcGfK1GWoktTQYGR/ifnCzOthTuLFXrEpYxAAAwtad5LLu07
 cMgKvVItVlxkbTtVyUeEjdBcf720BPeMXgaFDH8eBTd5hsxttiPwTyQ/ZotJbCZwkyxd
 yLMOTJCZIpaJKRhafHha8aPYTOh3AvMxUpSxH9+fp2P7sdK3tQ5qcTvwzJFruuRcBHpr
 t1EP3KrNiM6ma/W4NRKWeJcQ6PUZMyGq9o8vmWaOjc8eQ7nILWbsuWfwkNRrAV37iDLn
 mNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842748; x=1743447548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhAN9Lyj4bqTf4UUrdE+Pmn+JYUm8J4DDJYtyAVBykw=;
 b=pSfv4mMD/fkGFfmUOlUTs7/1DHdNdKp/mYhMMOZ/iYGKB8+S7UvzOu8T3+UvDOxBRQ
 yxDFJMzkriW7iHVZHY7eF4QNBt0kvr+IrTHz0nzOXDiSKqmB2zRPGMKBBNNlE4xK/5Sg
 TRM33bDMeHKJ090BcCkjczbfKi9k/lefZR2fRKZawZ8VbWw3/URXBjpndY2v505ROYA5
 4X1E6D/VlJk1hIqeYwzgoyd/uQdYTFmPC4WwL6z8rZiAXsV0PQAQjNxHLt6y8vonqoXl
 qQ5XMQlf9kM9hYj6CKc53eaXg0XBpC7rIn3UKHRGrm1+nNSdWv8SPt0OooA60JfZ2hMq
 KlzA==
X-Gm-Message-State: AOJu0Yz+wHZlClHGG0emVHN4/dmz0o/oNbcYvjd3m20N4t3t+cdjLm2r
 r8jsEsHqVl+dGmykcmAVGkVHICEqv1MvXYUUD4H+S+yPltxpfnP/Xv0IKKI0dWb9Fqs8bxlZP/3
 4
X-Gm-Gg: ASbGncss1T84fODfoeoxZaSrFd9I6aT/Oz4p3fv7dddn5JfsmraffQdKPj7bqOrOCAa
 Ho3xU/FD2WyMMepTtUlAkYxQ86+3SVkM7IfVCrAqtXlO5bKALxFN9iPPZskKEVm9AA6bzEOJpm0
 i7WAyq2MC4yHQWevAoFlK3nbyQPVEMkb8y3TRsJz+5U6vMHFe8PO7CrRIa/1eLa/FtQnQ1b68RG
 By/JbcZRJQPvfsyQTLrPl7a3TvljlT9kVaZ/5UipAJkGaaJUDhorXR1aFFqv/EJ8sbO0Vw32ZQo
 XGr3yM59Al+/xPlxEPViM5imRYhxMO8gYRS10xsYlmwjKzY7gwLzIuBfJd/QcIobCLT42Hu+NO6
 p9+SgtHnA3NjXJxlCuY+E38hT
X-Google-Smtp-Source: AGHT+IHSXq7aBGYSHo2L/NTUy+C5NUrNhAlF0hx0ukZe2EkKi39RyxMiiCSlj20y5DIqxApvQU45vQ==
X-Received: by 2002:a5d:5f85:0:b0:390:d6b0:b89 with SMTP id
 ffacd0b85a97d-3997f93c41fmr11979681f8f.50.1742842748242; 
 Mon, 24 Mar 2025 11:59:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b25c9sm11542529f8f.42.2025.03.24.11.59.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:59:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 5/7] target/s390x: Declare s390_set_qemu_cpu_model/cpu_list
 in cpu_models.h
Date: Mon, 24 Mar 2025 19:58:35 +0100
Message-ID: <20250324185837.46506-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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


