Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81714CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kYF-0000BJ-Ep; Fri, 17 Oct 2025 09:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kYB-0000AV-QG
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXz-00081z-EF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so1306146f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707862; x=1761312662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bohEM9UlUebYg5TCW40RaN2S1kCYQfAGCU/82ulclMg=;
 b=V1tsaBAvgZH2GkJeE068sq4NZzl1R2r24c5M0mlD66FABgbX8wSE1UFg6haM/mlcUC
 qNePtlIwKGB8NCLCA7/xiemB1sGgtfXFHU7zaXW5BnOW7hC0qgs4w4rt54aVqfYoYO9b
 PX7FJLD494U6itaVdg1syXHAcFJNPxahL/YhHc1/J5ECUaGiBZ9oj/hE8zzvsMDe+jPK
 F51OnK0ZiaDogwxBXAuREamWhBXTSRCWl95KnYIPvav7obJNcjFFxVKyuVQDKDyUStvM
 ZnV6o0RuoVtEaa4/2jjsU3H806VjQrVp+KdmcafelXF+0QCro5h8kanXH6uIHTdrMUBD
 A7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707862; x=1761312662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bohEM9UlUebYg5TCW40RaN2S1kCYQfAGCU/82ulclMg=;
 b=vjufJ0TDyJo1108ROeqpjgyk1s+3kwWhVA13A5vNQ63whMLTDEoT29nNhlDhIH6Yd6
 PjgYzcbbV+VXMtB9sl8wC9lJAZUJthw2xV/XP/xIC3QlrWpIDuAMxbqN9TARA6Q4nSr/
 +NC5FFj2DoO7CHtrDc25hAacfSRjkAyq61h9xZCQOaFfeVANcZ9ey6Ycvf6xeIh8gRVj
 gQA1iCXOWVSYEUlgEyT7AAuqadAYhaGAWgNsPtXwXKJq8u0PJ6eX1PBoRmbEYCc1d8x3
 B2UbNlaXjnoAJx8VkRmwAgKGIEr9cMEbamOeL87yIqCWVbFTFyVjVYxSk2Y1lz4P7FcE
 cL/w==
X-Gm-Message-State: AOJu0YyaTFmNI9/K0itk02qqOFly4Mfc9hwg+uqHPvjuZuYsBu6WcnJy
 A7uKhoCMZXr26SIhONHDOeGvHiJ4T2ZzKHXx487lixZULlsAatKsqezcBnl9ET5ONFxruABIba0
 mFza4e9k=
X-Gm-Gg: ASbGncud1+LrJg3ISGODG1J8TE0Sk13jfmoMI/ZNFwNuvGfTEaOWd3Ow1OKZM+qQsKU
 0mktIfBYcyoAJs0d0UcTlXfPryQ/00v1ekGPYoNZLHEIHV/7DW6ON+e0ksEteFt0EX2lREqQnHR
 VLTi2tKWZQuBVrW1OMoas84bIP5nMn43jwIdPYNnqQ2R8vWb2ZveUYHTPQY0rKWLG9Vo+eau0H9
 RM/yAlx0ls83k7xmvUMPZl3YBXVlc5jGzN5IQneEmWEWZn68iqyxEtB9Sjgz6twQXgbUn5hsslH
 wMqFN4WPFQZpl9uAaLU72LoPOsbRTcZ8plnSMU6Zhp4AiM4NEVGSA/VjG41yxY4sxvig+m8WwU6
 fZ6MxV7Lv2x4qS2c3PCc/gk/wciSJJ2ZRLPB0olssQEF2tCqZgTXp8LhmPqJvkPpRwgFRQL1nAj
 kc24Hyt76bfdoTJBux/yUTpgu7wg9RuvkJS7Eh7t8NklxzF05bUA==
X-Google-Smtp-Source: AGHT+IHqDWp1P+x3Ya1r/WBGm3tSkclNfCesfNtURh9TP9OjbvDwELKcx5DmmiaoMLNO5HdZV1dOUQ==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:e276:5f43 with SMTP id
 ffacd0b85a97d-42704da64e0mr2312332f8f.18.1760707861815; 
 Fri, 17 Oct 2025 06:31:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426feeb7441sm10192262f8f.43.2025.10.17.06.31.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:31:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/12] hw/s390x/ccw: Remove S390CcwMachineClass::max_threads
 field
Date: Fri, 17 Oct 2025 15:30:00 +0200
Message-ID: <20251017133002.61410-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The S390CcwMachineClass::max_threads field was only used by the
s390-ccw-virtio-7.1 machine, which got removed. Remove it
as now unused, simplifying the s390_init_cpus() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/s390-virtio-ccw.h | 3 ---
 hw/s390x/s390-virtio-ccw.c         | 7 ++-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 526078a4e2b..db804db33c3 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -49,11 +49,8 @@ static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
 void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra);
 
 struct S390CcwMachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
-    /*< public >*/
-    int max_threads;
     bool use_cpi;
 };
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cf09b5c46e6..390d427dc41 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -75,12 +75,10 @@ out:
 static void s390_init_cpus(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     int i;
 
-    if (machine->smp.threads > s390mc->max_threads) {
-        error_report("S390 does not support more than %d threads.",
-                     s390mc->max_threads);
+    if (machine->smp.threads > 1) {
+        error_report("S390 does not support more than 1 thread.");
         exit(1);
     }
 
@@ -779,7 +777,6 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
-    s390mc->max_threads = 1;
     s390mc->use_cpi = true;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
-- 
2.51.0


