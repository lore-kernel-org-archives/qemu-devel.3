Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B987C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeO-0004cL-8O; Wed, 28 Feb 2024 07:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeM-0004Tq-SG
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeL-000352-2S
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so4677275e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121779; x=1709726579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahM/+kL0fDsDOWiFdIDq3kYt2sIQjOO/d/8sCwn+DTM=;
 b=DldCi9zTmuRrc1F0D5KPvWt3Hn7TVmNGnye1cL1LBnLfsTf01nanmGYhUY+jvmVIXL
 GNQHEA5p+FgYEvrYY/JSD48NrPci6ypUA3Z65qSOLg7+6SZXVjpiyk2+0Ba3yUWn/rkw
 Gnik6Fc1er5dMRZI3MDicEYf45Xj8UGBnZNAKHsYHyymJ7ziXb+IjfRNvfImCjIjd0dJ
 OFk6GGhtbYkwBW4nLjcTPg2JEWSOF0nI9JFntVipIzZsFpFbg0parfPVrtwx/bPiwGEB
 atc8258O2Km/oklpUyWYRZB6ZttYjNjM6SpY54w9KrsFDOLzpz3wuuVJoapozXDg5LA9
 6ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121779; x=1709726579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahM/+kL0fDsDOWiFdIDq3kYt2sIQjOO/d/8sCwn+DTM=;
 b=RNUmPgcoIYb9YMOq26bz78EZHZeeJ8Ma+eaTZeF2INDIbrV5Dys9uB9WEY5RNumGOP
 dxxZa5a0JjssbncTuyLJ5zOBVc7on0mm8mCabhfoJVN7zWSYj45bAKJ7le6BSJo1AhYh
 ZMYVxjFaFibDM0Er1ONnqDOGLetfTSYesEocH02dCLMuY+ppjKkfTPUkCtagTTLkX2o5
 EwDovzrIyis4jtpvf7abJjETwZKBvUA+COjRp0AhRHsjuFOfkYLfSsfSx7odTy15uB21
 BLvaHCz+GF/7h+F32Pta7++2a+VwxRInx+Lh5MwELAr/OwY8Yt5iPexNHbHXMK9dx+bJ
 j6tQ==
X-Gm-Message-State: AOJu0Ywh6PvJTPTZ62SczoPq+a6jpADifU1fGW8KN5rV6xcV+TjtaYk7
 NtCjiYGWuHUVVB2ZZ8fhBz2ZcZIZx4QGQjfUf+q1poRURbNGhB87n3aRZomwgWYEgFN+hsfP7Xu
 0
X-Google-Smtp-Source: AGHT+IFaYRwRfAog8wz6ZUgTpAn0iBwAL+oa7e7InsqiI7k02XhOzrX26TY0m1SQAO28LQf3JoALHA==
X-Received: by 2002:a05:600c:4f07:b0:412:a3f2:d641 with SMTP id
 l7-20020a05600c4f0700b00412a3f2d641mr2185224wmq.19.1709121779173; 
 Wed, 28 Feb 2024 04:02:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jj18-20020a05600c6a1200b004129e8af6absm1873676wmb.33.2024.02.28.04.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F08415F928;
 Wed, 28 Feb 2024 11:57:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/29] gdbstub: expose api to find registers
Date: Wed, 28 Feb 2024 11:56:53 +0000
Message-Id: <20240228115701.1416107-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Expose an internal API to QEMU to return all the registers for a vCPU.
The list containing the details required to called gdb_read_register().

Based-on:  <20231025093128.33116-15-akihiko.odaki@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-22-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index da9ddfe54c5..eb14b91139b 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -111,6 +111,34 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+/**
+ * gdb_read_register() - Read a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the read register will be appended to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * Return: The number of read bytes.
+ */
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
+/**
+ * typedef GDBRegDesc - a register description from gdbstub
+ */
+typedef struct {
+    int gdb_reg;
+    const char *name;
+    const char *feature_name;
+} GDBRegDesc;
+
+/**
+ * gdb_get_register_list() - Return list of all registers for CPU
+ * @cpu: The CPU being searched
+ *
+ * Returns a GArray of GDBRegDesc, caller frees array but not the
+ * const strings.
+ */
+GArray *gdb_get_register_list(CPUState *cpu);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index a55b5e6581a..2909bc8c69f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,32 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+GArray *gdb_get_register_list(CPUState *cpu)
+{
+    GArray *results = g_array_new(true, true, sizeof(GDBRegDesc));
+
+    /* registers are only available once the CPU is initialised */
+    if (!cpu->gdb_regs) {
+        return results;
+    }
+
+    for (int f = 0; f < cpu->gdb_regs->len; f++) {
+        GDBRegisterState *r = &g_array_index(cpu->gdb_regs, GDBRegisterState, f);
+        for (int i = 0; i < r->feature->num_regs; i++) {
+            const char *name = r->feature->regs[i];
+            GDBRegDesc desc = {
+                r->base_reg + i,
+                name,
+                r->feature->name
+            };
+            g_array_append_val(results, desc);
+        }
+    }
+
+    return results;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.39.2


