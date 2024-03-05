Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0A3C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTeZ-00048B-It; Tue, 05 Mar 2024 07:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTdJ-0001uV-GG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:03 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTch-0001SW-8i
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:48 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d26227d508so64868261fa.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640616; x=1710245416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJzWza4vI5yWejE/TYAdmrx2G3TCvmG5gLCl8zQLNCk=;
 b=yUKXzgXmMloK5w6WEn88L/LaegaWwKuVmI6/BeQjXSxHBxt48WsvsIox6KAgfQesNW
 q8zPsU2MoTgY0+lDQMgPp+xw99ldvcMlmK6wkOSwWjf+G7H8GNUlmlMP9wo7XkJELEE4
 7m1fi0fuEkQJVNK6SOalbfr2QRbMFXlocsDTlofaYdl+cYk2ceu9SwFeGckLyEo61RRY
 7WqAOPVjqA9QuJXGcxk8wC3wjFxheoKDWxaW2eT65ymkjWbAQpr+HGtZl1nVnYX/FGfP
 gh+kEgKkHNNHKboYb0TOd194l+eiyNjY49HrnLoYMxsu0LZKGA7vD/4uPiHmrmIisc3X
 VpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640616; x=1710245416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJzWza4vI5yWejE/TYAdmrx2G3TCvmG5gLCl8zQLNCk=;
 b=mPZILIJufqDE1RBphbFrp6yD9NNEKNMXm8BDfygv10WOKXX33Pzb/H3jo9Kbq4xikc
 CuPgSAXzKu+E9gDkh1RQ2OGMRdjT2V2m+m9ovPW1J7mI1F2gwv81oim+HbYoQUpXVSB+
 nA6EBVwJTMjMyRjKHlHQMcpsqjOw25VII7hGPM8Z6fwVh1sNfyZXyUyvHXOm6lJjP8qI
 ItFGoHH2BtPhfMHaktRW5DnYFG/05bqklQVNORS4JfkXHEsJJWddRaM4Q4f8/dx+o8qm
 iPJbdvLW17FfmNI9XIRfBG1mmyJa59x6jV1SG7jcaVMv9byOxfEfyPNly8aPhRO+7CNd
 Zjhw==
X-Gm-Message-State: AOJu0YxbNIurlq+RMhMSRQ3F4MQgKKa0HZ4R2wuIfnawR4wqMpO5XbW7
 E5Tu1oLrju1JWGFkUjiTCvtxx/o+PJx62BEvGc3wm9yDA3UspB+uCjlyLYwiLZI=
X-Google-Smtp-Source: AGHT+IGtvfi5YTHGExZQ/HVfvB/kBsA0r2Osi15Bw5ChEcGTzPSLzircQ+DfYNa7xka4HyfK+AilSA==
X-Received: by 2002:a05:6512:1054:b0:513:4ad9:a7ef with SMTP id
 c20-20020a056512105400b005134ad9a7efmr1316093lfb.52.1709640615995; 
 Tue, 05 Mar 2024 04:10:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b004128f41a13fsm17794983wmq.38.2024.03.05.04.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 755565F9CE;
 Tue,  5 Mar 2024 12:10:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 10/29] gdbstub: Introduce gdb_handle_set_thread_user()
Date: Tue,  5 Mar 2024 12:09:46 +0000
Message-Id: <20240305121005.3528075-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support needs to perform certain
actions when GDB switches between the stopped parent and the stopped
child. Introduce a user-specific hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-10-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h |  1 +
 gdbstub/gdbstub.c   | 11 +++++++++--
 gdbstub/user.c      |  5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index e6063835b1f..b4905c7181a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -197,6 +197,7 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7be4418dcb5..3eb93162aa8 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1099,6 +1099,7 @@ static void handle_cont_with_sig(GArray *params, void *user_ctx)
 
 static void handle_set_thread(GArray *params, void *user_ctx)
 {
+    uint32_t pid, tid;
     CPUState *cpu;
 
     if (params->len != 2) {
@@ -1116,8 +1117,14 @@ static void handle_set_thread(GArray *params, void *user_ctx)
         return;
     }
 
-    cpu = gdb_get_cpu(get_param(params, 1)->thread_id.pid,
-                      get_param(params, 1)->thread_id.tid);
+    pid = get_param(params, 1)->thread_id.pid;
+    tid = get_param(params, 1)->thread_id.tid;
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_set_thread_user(pid, tid)) {
+        return;
+    }
+#endif
+    cpu = gdb_get_cpu(pid, tid);
     if (!cpu) {
         gdb_put_packet("E22");
         return;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c9e8b83d720..b048754c4f8 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -386,6 +386,11 @@ void gdb_handle_query_supported_user(const char *gdb_supported)
 {
 }
 
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
+{
+    return false;
+}
+
 /*
  * Execution state helpers
  */
-- 
2.39.2


