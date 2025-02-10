Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3557C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSL-0007hs-Ms; Mon, 10 Feb 2025 11:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRB-0004NK-8j
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR5-0001WV-I7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:07 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de74599749so2112103a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204101; x=1739808901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdv6BlsMATdrpGMkUawzyb+JI/nA7/PsR2TQFJvlMrU=;
 b=tOmD8Hckbb2Wit1UXynwN+dYkmUfd8ktr/6NXVn54s/2D/QNjV92J6tGOxrAPR29hZ
 SxyvO+olgFqtCvdyZhdB2QkIbpqItRm1HMbjYcksmUZt7tYSBJoGqh08CLfFMI1osbU1
 7WlipXKsbG1zmLR57WRZwhEPRzrqKY5k7UX+LEC4QVsCzcOWNg8SZL0zvFHvloM+b7nh
 QIgHgcaI6NKlqCZ0l5DAq7zrkfiTZVats2C735ZwxzWI85vPiXeZaElc37LQi20q4UAT
 xt9NHzMS+JNXgSgk7GSITR5Ff9Bw7bEYQLnr6BCdwn5vomTTDJxeck/yRRqa0rhy1Qb8
 pGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204101; x=1739808901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdv6BlsMATdrpGMkUawzyb+JI/nA7/PsR2TQFJvlMrU=;
 b=W1rT5eaCZDiwKLWAoWnZfwlnihDNZ9MZ/RbDlCNSDTZ6sV6NhqQntmbYeS4Dc8V7pW
 uHzVUfoJ48KpLk3In7cAKzOBBhK0i9HWKLBPPfAd2yB+nvKmuSmjXik/c3+BdJ1dIVEE
 pWMTOHIy0QIeeLDrSiQJ7jsSMg7AWpbZnVHK9Sjcx252MDIbDuDtWJZCaUBI6qAe+5rP
 VwTNOGfJR1ybxtZf+I/0i8ka85ZuWwpJpChgyymAq9CP5wGhRWXjImt9jJmcSGbJ9mTb
 LM7ebwpGlQ543a1D8nac1CSpFy9+YRJQaJCXGwwMnmTYttoy0PxJABTbYucG+zd/cln5
 CfCw==
X-Gm-Message-State: AOJu0YyXbWzNWW26ZA/keXFrZBVglaTwxPcS0F4ZXHijIf/ZI1fcBJg7
 phiLl+9MsKOIvmGwNXd7gv0mmYemJ+fTbvK0l+/6483a8poIUXLousYy5rKFA9Y=
X-Gm-Gg: ASbGnctdthe+PQNf6eLkz+tmetjnGdoVt/Zdwnc3JQrG/dkMUS7o6gdKoFD3Lc8ek2P
 rxR0pD4CF4NAT3sAqOpI6aWYE0mMh/rL4vhThEXKzvfn7nZ1GDzXwJ2Jp9+AxzdA1x+4tL5KqKO
 yYuCGX5clzfvOplkVpYqiPPDKDa7S3iVNZm4maSwC+NfX+4J3sTBPfD9bFSM19v6qVYibKA0H5v
 pQs2BE7s7uplimYOhuZZs5/2tl6nfBdHZSA8RtQqapf5OGlXalQIdRJnOuaIaquENzdGIchsgTD
 qSEiH+4N7FTWXXei9w==
X-Google-Smtp-Source: AGHT+IGOlWVt9GgZaRqmv6W3yYmBmaFrcCt0q9TzaiC+ikBC6vIrRSHSVAlIO08rHLvVqQ4moswPFg==
X-Received: by 2002:a05:6402:2392:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5de4b81d4d7mr11286653a12.13.1739204100989; 
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5fb0d738sm4925508a12.59.2025.02.10.08.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A6825FD70;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries)),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 05/17] tests/qtest: rename qtest_send_prefix and roll-up into
 qtest_send
Date: Mon, 10 Feb 2025 16:14:39 +0000
Message-Id: <20250210161451.3273284-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qtest_send_prefix never actually sent something over the chardev, all
it does is print the timestamp to the QTEST_LOG when enabled. So
rename the function, make it static, remove the unused CharDev and
simplify all the call sites by handling that directly with
qtest_send (and qtest_log_send).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-6-alex.bennee@linaro.org>

diff --git a/include/system/qtest.h b/include/system/qtest.h
index c161d75165..6ddddc501b 100644
--- a/include/system/qtest.h
+++ b/include/system/qtest.h
@@ -24,7 +24,6 @@ static inline bool qtest_enabled(void)
 }
 
 #ifndef CONFIG_USER_ONLY
-void qtest_send_prefix(CharBackend *chr);
 void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
 bool qtest_driver(void);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index df2e837632..503d441b48 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -565,7 +565,6 @@ static bool spapr_qtest_callback(CharBackend *chr, gchar **words)
         g_assert(rc == 0);
         res = qtest_rtas_call(words[1], nargs, args, nret, ret);
 
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIu64"\n", res);
 
         return true;
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ad67cd7645..a55d156668 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -94,7 +94,6 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
         g_assert(rc == 0);
         csr_call(words[1], cpu, csr, &val);
 
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
 
         return true;
diff --git a/system/qtest.c b/system/qtest.c
index bb1efba9fd..28b6fac37c 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -265,7 +265,7 @@ static int hex2nib(char ch)
     }
 }
 
-void qtest_send_prefix(CharBackend *chr)
+static void qtest_log_timestamp(void)
 {
     if (!qtest_log_fp || !qtest_opened) {
         return;
@@ -282,7 +282,7 @@ static void G_GNUC_PRINTF(1, 2) qtest_log_send(const char *fmt, ...)
         return;
     }
 
-    qtest_send_prefix(NULL);
+    qtest_log_timestamp();
 
     va_start(ap, fmt);
     vfprintf(qtest_log_fp, fmt, ap);
@@ -301,6 +301,7 @@ static void qtest_server_char_be_send(void *opaque, const char *str)
 
 static void qtest_send(CharBackend *chr, const char *str)
 {
+    qtest_log_timestamp();
     qtest_server_send(qtest_server_send_opaque, str);
 }
 
@@ -324,7 +325,6 @@ static void qtest_irq_handler(void *opaque, int n, int level)
     if (irq_levels[n] != level) {
         CharBackend *chr = &qtest->qtest_chr;
         irq_levels[n] = level;
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "IRQ %s %d\n",
                     level ? "raise" : "lower", n);
     }
@@ -380,19 +380,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         is_outbound = words[0][14] == 'o';
         dev = DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
-            qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Unknown device\n");
             return;
         }
 
         if (is_named && !is_outbound) {
-            qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Interception of named in-GPIOs not yet supported\n");
             return;
         }
 
         if (irq_intercept_dev) {
-            qtest_send_prefix(chr);
             if (irq_intercept_dev != dev) {
                 qtest_send(chr, "FAIL IRQ intercept already enabled\n");
             } else {
@@ -419,7 +416,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             }
         }
 
-        qtest_send_prefix(chr);
         if (interception_succeeded) {
             irq_intercept_dev = dev;
             qtest_send(chr, "OK\n");
@@ -438,7 +434,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         dev = DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
-            qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Unknown device\n");
             return;
         }
@@ -457,7 +452,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         irq = qdev_get_gpio_in_named(dev, name, num);
 
         qemu_set_irq(irq, level);
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "outb") == 0 ||
                strcmp(words[0], "outw") == 0 ||
@@ -480,7 +474,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else if (words[0][3] == 'l') {
             cpu_outl(addr, value);
         }
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "inb") == 0 ||
         strcmp(words[0], "inw") == 0 ||
@@ -501,7 +494,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else if (words[0][2] == 'l') {
             value = cpu_inl(addr);
         }
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%04x\n", value);
     } else if (strcmp(words[0], "writeb") == 0 ||
                strcmp(words[0], "writew") == 0 ||
@@ -537,7 +529,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 8);
         }
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "readb") == 0 ||
                strcmp(words[0], "readw") == 0 ||
@@ -571,7 +562,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                                &value, 8);
             tswap64s(&value);
         }
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
         g_autoptr(GString) enc = NULL;
@@ -593,7 +583,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%s\n", enc->str);
 
         g_free(data);
@@ -613,7 +602,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
         b64_data = g_base64_encode(data, len);
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
 
         g_free(data);
@@ -649,7 +637,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                             len);
         g_free(data);
 
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "memset") == 0) {
         uint64_t addr, len;
@@ -673,7 +660,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             g_free(data);
         }
 
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     }  else if (strcmp(words[0], "b64write") == 0) {
         uint64_t addr, len;
@@ -705,10 +691,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                             len);
 
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "endianness") == 0) {
-        qtest_send_prefix(chr);
         if (target_words_bigendian()) {
             qtest_sendf(chr, "OK big\n");
         } else {
@@ -726,7 +710,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                                             QEMU_TIMER_ATTR_ALL);
         }
         new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "%s %"PRIi64"\n",
                     new_ns > old_ns ? "OK" : "FAIL", new_ns);
     } else if (strcmp(words[0], "module_load") == 0) {
@@ -734,7 +717,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         int rv;
         g_assert(words[1] && words[2]);
 
-        qtest_send_prefix(chr);
         rv = module_load(words[1], words[2], &local_err);
         if (rv > 0) {
             qtest_sendf(chr, "OK\n");
@@ -752,13 +734,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         ret = qemu_strtoi64(words[1], NULL, 0, &ns);
         g_assert(ret == 0);
         new_ns = qemu_clock_advance_virtual_time(ns);
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "%s %"PRIi64"\n",
                     new_ns == ns ? "OK" : "FAIL", new_ns);
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "FAIL Unknown command '%s'\n", words[0]);
     }
 }
-- 
2.39.5


