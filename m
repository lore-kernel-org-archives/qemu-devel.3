Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6862EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL7CO-00065p-Eh; Tue, 10 Dec 2024 15:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL7Bs-0003zn-25
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:50:44 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL7Bn-000372-Cj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:50:43 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso4196915e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863838; x=1734468638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmufaNphf2V1gjeMaS6HYVWY1pzqo9T3TKjafKi2Pnk=;
 b=UVQ8n7c0L02p6WP2pRRbzfu1rajSgjYqtxRA3jRDRHSukLDlE7FVXXfqSFpWs6U+/S
 w4IQb/pZ5zSv+DPIlbxzB5+OOKRuuTI1EvbdaMeIAb6zF5n+7/Fl1fGFyDq9JuyHhte5
 VrZIsiAz0wzPz2PzL0YNb0xqlcByiYd20z4kcvBSj3kfV/asPvAOYvoQDSOgXGD5oIkZ
 hlRreFVrWwLR0NdsSQQhc4GmoQuFZZOEDU9w2KB17XlgAsV9kwAFHpiMs8b1Emx9+4Uy
 QxjUQPpEbPi59usm/4pPmbZDiCqQw1YmvK3osh5NHZieNliQbItar/CE1A/v/tjmdHfP
 fcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863838; x=1734468638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmufaNphf2V1gjeMaS6HYVWY1pzqo9T3TKjafKi2Pnk=;
 b=HDmOAu0mGo81b/kFTJ5W8Nwb1AXAKoh1HkIyFfPiyNihhhE63GODCp1OAn68tBlKEz
 VTdm1Rh7/3V0E4SCdylff2vjU5ymd0bbLMrOrMTLmHVMnygy9wfnfViT2YgJE0hvreOs
 IivLvHhyj9RsctQAfTdSG+gaUOgQEkudGNIzTF4EPMxszlCi47W66B5tJQAj/HAaR0z5
 anXd+tQiZxznyoPgld9IgwxVtNKx2j0QYGoJAZ6L3BAQEiWSrzn6ZLw/7GltI9FnI1An
 uTJE77pO7o269dGWCkIJusNGoJsRYb+Mb2assO+FtKacwjqmMgJUXvJgt+mCQkKLLsmZ
 hy9A==
X-Gm-Message-State: AOJu0YwZZ9Rhgi1U+khGG3v5IekkzpLHVRwKvHs7C81EKBpzxMV86Dwk
 tWIWGoHS6gdn3DIuzJYgr1/4zC7bCJEbOLfH0deGwrvLdLhSXwCiilp5aPAhLlk=
X-Gm-Gg: ASbGncuJEoG3McOrrKAP/2SsfcxeHQDG6EklZoOY0b528nqs9rfYw2OsPRVJFbplRCj
 11gRGrZ9YHvaGm78SYeHQs1tt5Xb+ZOdO/uejK1GawwHfb5g7SIiFy3THrKQs4zWkOs+ZKd9xAC
 Yq/RMMwDxMzjLd+2MdakEuUNeBQnVGqu5VBgBiHGEsmYva9PbDp5r4o0z8UU5Ud4C6x8DLXOEfF
 V/GMfb0/c6Ke5WmZPBCVzS4UJHBGR5ZpV4UYOyYpytmm22W1Rij
X-Google-Smtp-Source: AGHT+IHkAlr+6kQjaQRIxwrd2oCXtoHUNcaJR6B1xJCz9IEp0SuUjqpRHbOLvCCfEAgfyRv9mpQFvA==
X-Received: by 2002:a05:600c:1c82:b0:434:f819:251a with SMTP id
 5b1f17b1804b1-4361c396f09mr1898885e9.9.1733863837644; 
 Tue, 10 Dec 2024 12:50:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-435ff2f46d3sm26878345e9.19.2024.12.10.12.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:50:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4F1060B86;
 Tue, 10 Dec 2024 20:43:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 18/20] system/qtest: properly feedback results of
 clock_[step|set]
Date: Tue, 10 Dec 2024 20:43:47 +0000
Message-Id: <20241210204349.723590-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Time will not advance if the system is paused or there are no timer
events set for the future. In absence of pending timer events
advancing time would make no difference the system state. Attempting
to do so would be a bug and the test or device under test would need
fixing.

Tighten up the result reporting to `FAIL` if time was not advanced.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2687
---
 system/qtest.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 12703a2045..d9501153a4 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -78,6 +78,11 @@ static void *qtest_server_send_opaque;
  * let you adjust the value of the clock (monotonically).  All the commands
  * return the current value of the clock in nanoseconds.
  *
+ * If the commands FAIL then time wasn't advanced which is likely
+ * because the machine was in a paused state or no timer events exist
+ * in the future. This will cause qtest to abort and the test will
+ * need to check its assumptions.
+ *
  * .. code-block:: none
  *
  *  > clock_step
@@ -710,7 +715,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             qtest_sendf(chr, "OK little\n");
         }
     } else if (qtest_enabled() && strcmp(words[0], "clock_step") == 0) {
-        int64_t ns;
+        int64_t old_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        int64_t ns, new_ns;
 
         if (words[1]) {
             int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
@@ -719,11 +725,10 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
         }
-        qemu_clock_advance_virtual_time(
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
+        new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK %"PRIi64"\n",
-                    (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        qtest_sendf(chr, "%s %"PRIi64"\n",
+                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
     } else if (strcmp(words[0], "module_load") == 0) {
         Error *local_err = NULL;
         int rv;
@@ -740,16 +745,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             qtest_sendf(chr, "FAIL\n");
         }
     } else if (qtest_enabled() && strcmp(words[0], "clock_set") == 0) {
-        int64_t ns;
+        int64_t ns, new_ns;
         int ret;
 
         g_assert(words[1]);
         ret = qemu_strtoi64(words[1], NULL, 0, &ns);
         g_assert(ret == 0);
-        qemu_clock_advance_virtual_time(ns);
+        new_ns = qemu_clock_advance_virtual_time(ns);
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK %"PRIi64"\n",
-                    (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        qtest_sendf(chr, "%s %"PRIi64"\n",
+                    new_ns == ns ? "OK" : "FAIL", new_ns);
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
-- 
2.39.5


