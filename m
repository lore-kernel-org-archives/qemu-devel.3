Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D281AC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 05:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubumc-00074L-Ui; Wed, 16 Jul 2025 01:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumZ-0006sg-Ff
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumX-0007rp-Q6
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:19 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7481600130eso7021023b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752644056; x=1753248856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtV+8U6r6cDalyfNmOH/gMyYclw6zVKJEtKnGE3JfIo=;
 b=BwqBE3OX/04m1sx1qTUD00RACP3t9HygfNYeRSEONXYWOMTVLhNOvjM1+SgpojLSsQ
 fHKSTEEFRQACP/yRV9UoAVNziJXXZtXIgs92tCZOiDDZiIQoGXhmkwIyAA34vREGr5at
 OC3FHUDv99q3f1CINke+N2IyxoMr5sDrnijE9eygahNWLB+oHxKZwucK0B686rdgUcxL
 Yg5gJcipVFEJTHkkvIUa9DI29eDALd+UV0t1b9LHNeFVHsBEu93xMeWalhZMzTWtgVdA
 5TuY1sTGzWnysZoXIzrP0EJRzJpACdQYrX4lCPKLHAKzMOxUvppHvjCdnlaliP6/fdVg
 oYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752644056; x=1753248856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtV+8U6r6cDalyfNmOH/gMyYclw6zVKJEtKnGE3JfIo=;
 b=R3+bkSSx8vWvV0LbPJlQRNZkeNEgiz76GQIp9SUFI0i1+9ZZH23Yu8kK5bzP8eqbMv
 aL919AceLJFnNRzbe7xkTaUvBbDRKNw8QrLSGaHh5KP5fZXZCGxsLlla2Skqn9IIqzai
 He4jaKrrlOBHP1YkBetbpbLGjc9tvlqU5UgjPFP9s89EeNZB6BWWzAOzqDAQH4cXsu2P
 rDhBJVhPYTMobyglnxUv8Fj+5cTLfU7mlnlX77IYRucU6U2RVZ1mCdjpWg5a92jA0Udb
 3+cLf5Y2g8wAGv4LbRvdayejrPozlHrlYUd2BQapy8kxu29Xv4z46q16ncoi/0bAjoXM
 ePIg==
X-Gm-Message-State: AOJu0YwdsTNkkh28kEMGFhm5a+Pv41DpdoOYZibFGGr0HS4a+86Velxl
 g/3Ghxg1n58J8f4jYLDXAFPD5Xgo0LKA/P1/rXPqt188pFEmGqiIo1fFrYERQ7K5XctLXaCD4/o
 fFmf6
X-Gm-Gg: ASbGncujMuArvVPC7KCklmGKoDFG4zl8kIoQmJg6sOmH1eK/ADkNCD+451xMTypyqQf
 y+hd5OeaicbC54QneOAtPRnMf0RxBCK85bDFk5DtKr0hfHivWZphndmu6GYSVPfD32mhiJ9U/jg
 Zd0DO004rkq1O+ucmDgQWaEMDmlQVNn/aKM3TpFjlEPEBIK3o/tuEpp3mhANX+vTkJXT4h6S/Oe
 CxjJJWZUlASULMUxm1XkIgDmLpt3sOBRKee/jJs0+ntXyPuns5MaasQ7EI4SSj024aj6oPq6tK1
 IfNqJvSWrlufUv8ndujgKb0Z0nnJZ01kx9oQGpxGCesJ9+mdpch7nLvoy2YYRvPEqBFuSELe1Nq
 e5y3ijy9OVXlO+W2qLjQdAQ==
X-Google-Smtp-Source: AGHT+IEzzm59LKTcy5TIr3J16GZfmyTzdXLT4TOGrDFr0a+Jokyn9yihXZqCJDVTaVIdTXf6pAHLvg==
X-Received: by 2002:a05:6a00:2e92:b0:748:ef3d:3247 with SMTP id
 d2e1a72fcca58-75724876e61mr1791665b3a.20.1752644056113; 
 Tue, 15 Jul 2025 22:34:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06aa6sm13790162b3a.62.2025.07.15.22.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 22:34:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/6] contrib/plugins/uftrace: add timestamp-based-on-real-time
 option
Date: Tue, 15 Jul 2025 22:34:05 -0700
Message-ID: <20250716053407.2814736-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
References: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

usage: timestamp-based-on-real-time=[on|off]

Instead of using number of instructions executed (which is per vcpu), we
use the wall time for timestamps. This is useful when tracing user mode
programs as well.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 58805b7884a..7bf658311b1 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -93,6 +93,7 @@ enum uftrace_record_type {
 static struct qemu_plugin_scoreboard *score;
 static uint64_t trace_sample;
 static bool trace_privilege_level;
+static bool timestamp_based_on_real_time;
 static CpuOps arch_ops;
 
 static void uftrace_write_map(bool system_emulation)
@@ -445,7 +446,25 @@ static void cpu_set_new_sample(Cpu *cpu, uint64_t timestamp)
 
 static uint64_t cpu_get_timestamp(const Cpu *cpu)
 {
-    return cpu->insn_count;
+    if (!timestamp_based_on_real_time) {
+        return cpu->insn_count;
+    }
+
+#ifdef _WIN32
+    /*
+     * On Windows, timespec_get is available only with UCRT, but not with
+     * MinGW64 environment. Simplify by using only gettimeofday on this
+     * platform.
+     */
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    uint64_t now_ns = tv.tv_sec * 1000 * 1000 * 1000 + tv.tv_usec * 1000;
+#else
+    struct timespec ts;
+    timespec_get(&ts, TIME_UTC);
+    uint64_t now_ns = ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
+#endif
+    return now_ns;
 }
 
 static uint8_t aarch64_num_privilege_levels(void)
@@ -849,6 +868,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "timestamp-based-on-real-time") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &timestamp_based_on_real_time)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.2


