Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BBDC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn16-0001Dr-Ib; Mon, 24 Mar 2025 14:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn13-00019e-F5
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn11-0001Rb-Ew
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso33746455e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842753; x=1743447553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giTKQDxO89eOtpjts+wN77TEM8FZNJXhQbxAjblDYy4=;
 b=rbfkHjGAsqb9DHS3hh+UAhkXM4FOdr+UialGuOEzRRn8ZPj/K2Xv+uQn6W0lWeugDz
 3jfheh5mY5x7OsieBik3xtAxlj09CBoHWnnd+tv6hpcnzP063x5PA5SmI41k1t0jMMUi
 r7QdvY2q6huRWM/fx1HGa8GqyIWm20d08f5+C1ucLSbucNMxrafgUkJU7J+7iu1pAPJg
 fcHQJ+mWWM2LDjKKJpIrO7obczLqL+VU7V7KE7OaG9YJ+jUIPVDVaFrMN/dlMPN7h0DM
 qas2FKG7W0zFGy0T8XuQ3MyiUzFawBFP5gmm8SV5TayHlMaicGFJeNJt/0UkK5WSxO7d
 BvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842753; x=1743447553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giTKQDxO89eOtpjts+wN77TEM8FZNJXhQbxAjblDYy4=;
 b=RBisoBBJ2itwde7z60ceZdeWN5c5LFdDLr4bRev/IBZdArr4KhOzxVaOUiFocZJ37b
 WLIgyS9mB4QxSIKGS6cri6d1GaMIeaGu7fZGnmXZMQleHRA7HJuxTEEWrIWuFSsiPuGk
 SSQi4j45NpWhESQM3ktov6exrbPXxQSZDL03z5dCLoCr5mv0ifw9S2I2ZV32funsdhvj
 +OFmlQREv2ETjryzQ1PPeH0GooauBObM+IsPX0vUUvunf3tfkZAMq4mnZ5oX5xKdvxzh
 vSbmFRSL1Sf3gVU3NiaztHMDDCnAj9eY1bh5fgeg2OINl7LoUxtpin0bh1aqMyyxcGTk
 qViA==
X-Gm-Message-State: AOJu0YyRtd4y4MMiFK8mNJJiUoJfHSc7VHm4wOtvsDgqbIWaiiP/PYhm
 ie3JB9Fqq+2k8ZeI5txBTRKE4yq4Y3rgOHbRXit5CJPrh1rSeu7xkU9ra9ejC+bqsMNzmhPNAvI
 p
X-Gm-Gg: ASbGnctZI9kl8WeXeBQUJwO79VrW7BvkG0xx3EEMA8GPPLjU/oXZtZw+Iu9Z2+jyE5o
 gGejbYRiPy2ynjWRQcSWS4BvKBr/gyHKzX2enJ2WOSusWTUT50qaDHy0WBHiAvbswwcDiv/sNij
 LCU6Y8gYNaZe07z+FbkMg6KwN1+v2CWDfgxgDRnSAZp5IGSKzo/D/LvOgLT9XO/gBuNerROlpsX
 Td9rFRls9VI960m2iqE8q660yt+SGMxBSOuLJXIRmwBAeTcVFpFfRq0n+WfNTbjh6Ggt5jiuSQ0
 GuHc2v9QS3BC2fgNfO3t7ra8LEmN/OIL3d2fczTBuxa8++E6MsaHOdpzdhe1OcHQCLtMmGgbdwQ
 DKx61oTUw4fFC8ycZeDvyQsr7
X-Google-Smtp-Source: AGHT+IHqFyn0J8aXxtSR/k7U1GXNTEvPMBD+7DwptV9fmWCpbK+QdiMRb4/1BjDhkH46HUqMS6SG1g==
X-Received: by 2002:a05:600c:138a:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-43d509e38eemr131575315e9.4.1742842753375; 
 Mon, 24 Mar 2025 11:59:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43ecbsm178124395e9.10.2025.03.24.11.59.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:59:12 -0700 (PDT)
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
Subject: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:58:36 +0100
Message-ID: <20250324185837.46506-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Register s390_cpu_list() as CPUClass:list_cpus callback
and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.h | 3 ---
 target/s390x/cpu.c | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8dd1936e3e2..1012be35d25 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -900,9 +900,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
 }
 
 
-#define cpu_list s390_cpu_list
-
-
 /* helper.c */
 #define CPU_RESOLVING_TYPE TYPE_S390_CPU
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f75629ddc2..ac05e82f0ac 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -378,6 +378,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->list_cpus = s390_cpu_list;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
-- 
2.47.1


