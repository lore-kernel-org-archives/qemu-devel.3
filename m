Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20939C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmoi-000151-7R; Mon, 24 Mar 2025 14:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmog-00012o-Kp
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmod-0008Ok-ME
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso21703345e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742841986; x=1743446786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVmEVjUsWOxsPo3u/Y0kR5E5YJmUOlp4odxRJhRKZMg=;
 b=IkDEr31D8WXmMtefQ2RFTYgl+7cXg4tPKfEJGfH7cY43HESBLxKFZjPzykoCRDJT5v
 WrH3uw09c8wf6skZDXSoRw/0gD+KcvTjKvsehDv+otPLu46mauI/+Gi3b9ocn1VXKt6J
 sOdWOHBJCuXZdvCfoLHzRPuFVtp4jXGVoQW2Mi536j/VUyidWESDPPXrsIQMogVHpXkt
 til+np31/scay/dED1SGHOMHgpp5TQbbJVaIQltUxb+M/1x9P8Au9pwVcSxNEEqpOCGA
 uS69Ih5zE++HXci3Znmmx5cy1aGqHAoURIW7a5rnkn693VYo54qt7sgaSs37Gw0b2thT
 Ipug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841986; x=1743446786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVmEVjUsWOxsPo3u/Y0kR5E5YJmUOlp4odxRJhRKZMg=;
 b=HUN564638srn/AkYrJCtcEaOIlWTtSJGqR06RGXkSFcaVsVaxDWhPhJCPU6KozsjEr
 WskV4Arj4l9H6/xCMl7xcyk4gg84W726JWi2FaFkMg/AhnOatDCY2WmYDubu0YZ+VILw
 xFoIi55J7XJf9Gg8G8c7P8RgPwo5GKa9ocga8kgMTT1nDSREaPLq4OMMKnJvtwdmmeO9
 yFYa0fm2dhIGLJkpk3OKD8JI4tENvuNIxlZNj5bn1LVgLUJpTRnbt5xagxkInC0L0AiN
 y0ne2Zd8El5f224UVyA/co6KMBWuzqQM1qSHDffB4vJ/aFuLJ35ByCscPrC6CW2/uU5i
 n6RA==
X-Gm-Message-State: AOJu0YyewkwUc3D4P5cFf9wAN+jrmsY7QTO740R1jyGc/IRPpyKT97BQ
 NTsWl7mqjbNFXE9p9FaS/P6p7A+1EXe4E+fXIxcLWJuhvJGgF+NnmzGrnUISoxSo2bZZgcvrDwL
 m
X-Gm-Gg: ASbGncsqCzC4OU3vGf+Ik9FeDgUXEGvNh4gvUUDWjt7IzQlmcsrTE5jutsEc+B+GL4L
 WFNOkFnDRDGkhLsAQrPqPwFro5kpfxmBBvSPU456TUUoJi66aE0NGjWo0M6N9yKZkY3XMts3MRq
 j9khdMiHgb+XC4mN5Zfv6AOf65j+kRTfj97TqGydkA2071dBrUXdtdyplkpAPCdx1LVhVYgxWxg
 v2CaU+MP4vJHc1eL9OY1kNYI4osMNzk98vIbn3lTpp+YzaqkY+OTL46o9hzBpkHQYZa0FvCadHN
 dd4CDf8PtpQa2pyyP7jznr9hiLZA3oiXH13fGH11iYybyF0mR/uPjiK0Up821VaFsh0Gz93JQcP
 Xv9r3EgUbu44cti2Z4FhZ4gee
X-Google-Smtp-Source: AGHT+IHXDlUKgKzUo6UNZg/EHyaXNGWm4g5qNyeMrQywuqeBrD7jm5+vRVtxWgq3QpyYZb4i1n3arg==
X-Received: by 2002:a05:600c:3b9c:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-43d50a4a7a7mr98114915e9.25.1742841985732; 
 Mon, 24 Mar 2025 11:46:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65f0sm11744102f8f.74.2025.03.24.11.46.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:25 -0700 (PDT)
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
Subject: [PATCH-for-10.1 v2 2/7] target/i386: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:46:06 +0100
Message-ID: <20250324184611.44031-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Register x86_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.h | 3 ---
 target/i386/cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..28011eff0a8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2367,7 +2367,6 @@ int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_gdb_init(CPUState *cs);
 
-void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
@@ -2561,8 +2560,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
 #endif
 
-#define cpu_list x86_cpu_list
-
 /* MMU modes definitions */
 #define MMU_KSMAP64_IDX    0
 #define MMU_KSMAP32_IDX    1
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba4..1f502587c96 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6305,7 +6305,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 }
 
 /* list available CPU models and flags */
-void x86_cpu_list(void)
+static void x86_cpu_list(void)
 {
     int i, j;
     GSList *list;
@@ -8924,6 +8924,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
+    cc->list_cpus = x86_cpu_list;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
-- 
2.47.1


