Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FD1C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmoc-0000yB-52; Mon, 24 Mar 2025 14:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmob-0000xI-2i
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoY-0008Ng-Ab
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso1716559f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742841980; x=1743446780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/58CM7Dh+rZOrGRbi6LZSjetyigBShWpCAkZGEHO9xU=;
 b=F5UeRsf1srJ3vWTtXCMZZ/gB1IsMa9w9onjIEO7gA9jjDoRyObA1eFhSv8zrmJWFru
 goYRD9TXeWG/23L0b2PINcL16/vcvfAQHyTiVHWZHLfTosYvJk2G0X4nhfEZdunpgVre
 3p4tuf51riBR/OgTBrdDMOgh/EgvhRttudHRKz96MO7cpoQLD6PyXx2hQzyLeyKLxkff
 FmFHIldArD5aYYdm0lc9aMV/OGEvXXgpG5BVdeVEJgG4KEACjUl4YMEkd6FBN1KO3O4u
 TCgYrSpO5ZkqHGqfdkGD1BZq2INWGXzUb8rH/JeYhmAFopRixYUwa7SRGZ9FN34kWBDR
 eH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841980; x=1743446780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/58CM7Dh+rZOrGRbi6LZSjetyigBShWpCAkZGEHO9xU=;
 b=pfoGMFbmGmLP5SBpD2eBfdi1E4QKqfFXoAQAI3g72MxzrKJH6WFxRLuO777uflnP8G
 WzJGs71KgPMKfYstDaDvjWkijFM0zLDTeZhOgzt9Afgqr0bBW00gCYPB48oFszKMn2hX
 WLd4RZwdpfPqqX+hnVXmkyVhpvarghS0oN/CLiNRMvz6qk9Aq4weURg5huCiwyiGR7rd
 UMaYQzj0bWtCCYkK5MDlizjgYsAy4S7i0NztYnWNoRUTlva6KUbVb/CGbaZvMyck++MB
 Z03MzYu12vTDwCoqHzANE0ofcgRddk5z3jE75DbbfasJIYi+iKG9Hocya4W5aosmouKt
 ub+g==
X-Gm-Message-State: AOJu0YxnxKI3tk6+Zd4LJj4CLeHylq8MYHmXxHzYnfHKLN5dGFlui98r
 gWqF84QYpu9t3eNZ+EM8lVP/hV/G+tr4SU2OCrqoYp16HJycLgiosMQAGUd69/QxhQaXr9GGcGj
 D
X-Gm-Gg: ASbGncs3reaX7I0ifVNzg/FQjSxJp20D76A1zzYFcmK5li9rfLcV7LM6UPZbOHunUoY
 3AeZ1HyEvBOGc/LHYVjC93nJMo/RlU0fKMuh/LoXIsyBmogyDRW90qQviq0+tTuvQHRZOF26DIc
 jAAKY6Q8RjBxEzAYoHDxRX6m4QQUsPIViNtnRXimClOH2b0PV0zRJZsxTapDTXDn90dRb3/ObUb
 yC9FjWLGygtJBXdJbTP6jeH5UhhMjwk3tPCfGlHznSrBL5ryMXXw7v+JsV4BynMhIuiwi23XGMe
 Me5oz0hSXOdbcGGacOcA6y/NSPBY8S3HCPzNRDMicEjeIlfWwZgacAtiovzS3nfIrjREgzXGriZ
 vSi8vTlFeH+0VhBpF1QcV8dxR
X-Google-Smtp-Source: AGHT+IEcWGkRt9eLB+IrqS1EZnyrYhhBUTeNxSwNhEW80ot7T/DSa7KcrcnHiQFaBtmx20JvVsoOqA==
X-Received: by 2002:a5d:5f4b:0:b0:391:4873:792f with SMTP id
 ffacd0b85a97d-3997f937b48mr13735740f8f.45.1742841980396; 
 Mon, 24 Mar 2025 11:46:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65besm11796461f8f.65.2025.03.24.11.46.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:19 -0700 (PDT)
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
Subject: [PATCH-for-10.1 v2 1/7] cpus: Introduce CPUClass::list_cpus() callback
Date: Mon, 24 Mar 2025 19:46:05 +0100
Message-ID: <20250324184611.44031-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Some targets define cpu_list to a method listing their
CPUs on stdout. In order to make list_cpus() generic,
introduce the CPUClass::list_cpus() callback.
When no callback is registered, list_cpus() defaults
to the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/core/cpu.h | 2 ++
 cpu-target.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 54570d21aea..b633766ee8f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -102,6 +102,7 @@ struct SysemuCPUOps;
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
  *                 instantiatable CPU type.
+ * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @mmu_index: Callback for choosing softmmu mmu index;
@@ -150,6 +151,7 @@ struct CPUClass {
     /*< public >*/
 
     ObjectClass *(*class_by_name)(const char *cpu_model);
+    void (*list_cpus)(void);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     int (*mmu_index)(CPUState *cpu, bool ifetch);
diff --git a/cpu-target.c b/cpu-target.c
index cae77374b38..5947ca31a0a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -98,7 +98,13 @@ static void cpu_list(void)
 
 void list_cpus(void)
 {
-    cpu_list();
+    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+
+    if (cc->list_cpus) {
+        cc->list_cpus();
+    } else {
+        cpu_list();
+    }
 }
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
-- 
2.47.1


