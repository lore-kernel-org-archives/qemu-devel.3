Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E97E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV39-0004cG-Aj; Wed, 08 Jan 2025 07:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuo-0000xt-1r
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:06 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuS-0007Ij-FT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:53 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so55351566b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338267; x=1736943067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJxt9IGDQlJ1+KQmlOP1oYH7KxpruLFwZ7bhPRqF6vE=;
 b=d6dY6x+o/flNolPwPLJpD5ZAhCaVvRfGkM1SSRAD+p+Wu6NXf+/7tGs65afq0a3jWR
 nRtkTPIBGYeGCaRhppOKbAH6wUMGSt18P0IsgGkNHWiHcjJ5WF9TZRYb1GC2aC/eT44k
 uzold2AZkiZZF5tdYwWdZ3pYoCLBil8xxz/Oh1CHoedbHApms0WpZoDhA0mhG0qC2eow
 1sBqE3Zj49dA+WKDmCxjD5HGXMllS44cQH1R9WuW717gteyTV4gDREBJj3XX5MEU23CZ
 /iHSQHLpJoHF8MAW3c4vfTWACIFGCOtNatHGc0ZBOI/W1bmlWc4dnHHLB3GfK+3iZXAF
 QbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338267; x=1736943067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJxt9IGDQlJ1+KQmlOP1oYH7KxpruLFwZ7bhPRqF6vE=;
 b=nPXleoNYiKQa++wSYMBs7PHr7Sn0lNBa9sLVweDPhN0u8evE/hqlrVdC5eAe/ENjZp
 SJZiKM5kgMcmy0ZtCTQsT9zbqtoU6aUa5N8uYQdjDOBCM8X2JUMAxKIcaJ5gjQtNjFh7
 iGtlldrMn2XrYwVFYTF9Jsadbjd7FqiaOM+3xKInKLhJ0Xqzflvs6TQ7JxcbfzaRdNG+
 4jANZKfJKYQrR9P7Eos2ylkOWdKJyZE7PSpG/i6TwHz36kTF2D5+7jTKlRdyWoG7Ufox
 CfULPlPTW9LRN4SKJYMCDq8+3cQ4fviBmliHNs9fKI6Ig5eeoz9+PJifpu7uvhPQLDZn
 jz2w==
X-Gm-Message-State: AOJu0Yxco4LtcWCBR8O0YwdrKXjyCtawS8qaBgfYi0O5i+uOsbzpa3oN
 yLgDm794eH9XKuZbE8sHtUMuXIqXCCNgbVGFkOqq6Q2ETqT7SNOaXQe3OTCas+w=
X-Gm-Gg: ASbGncvoxZiNmq0Y/9g1N39exQyY5MtCKtsLUziKglCtiakptJ8VeOvVO4FMReMcs0f
 cOTJwQRYhbDf+65YIHNXo4TViu5MEaQ2+utX1Zm+330hCiJTC6ljNhsxXdbW9+Q+5q+GYMTuH8V
 vgdvhMRD/+NkF0ew6ATelNypqn1+uCaV1AGA/ai49nKNWKtAu9AeFxV6AvcSlBzz4kh4T9S8g4s
 ckjoj7bNYrcW3z1LwDLnBYbie/f1sgDkqWgb1uf6iuBMRVYHuQy/P8=
X-Google-Smtp-Source: AGHT+IHmxOyO8rB2PgTM+0m9KNj2AgGoJ7W4PHxjaS9uv+nR+HBRkRK4YR3Bs16+63sO8OjYg6DSLw==
X-Received: by 2002:a17:907:7286:b0:aac:61b:a079 with SMTP id
 a640c23a62f3a-ab2ab6bede4mr189471466b.40.1736338266827; 
 Wed, 08 Jan 2025 04:11:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f012229sm2483312966b.133.2025.01.08.04.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:11:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F3BF5FB57;
 Wed,  8 Jan 2025 12:10:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 17/32] system/qtest: properly feedback results of
 clock_[step|set]
Date: Wed,  8 Jan 2025 12:10:39 +0000
Message-Id: <20250108121054.1126164-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2687
---
 system/qtest.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 99ef2042f6..e68ed0f2a8 100644
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


