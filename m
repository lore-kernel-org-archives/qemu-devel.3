Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B92C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTe8-0003Ft-UW; Tue, 05 Mar 2024 07:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTd5-0001iZ-M4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcf-0001RG-CH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412e1b52934so13547985e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640614; x=1710245414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/FvadGGUwctE1IWDDn0kVOXWDaUBwNAKUX6TCu5fDg=;
 b=AALiLh2n7Byt94/QX+on1G8T0EIoEUKhThgE9yVhdNKuRyRbnRIFO/tl8BJssx0c8u
 asUD29Fe4hEODqA9pX/kUT1asUo1UN4ECNor0drAidRU64otNj06ept7Mvz7c7zA4AL6
 FRBBsU8WTHq6Ry5h0EkJCQszD6PYx1CKSuFo3WPUAeTNOGy4rVUSIrDbl7gKUg0dVJhv
 JdgmUa/YGLvB/9EGKrETofa54NBy3mDvuLruvDJWnjvFK2jHtBq0fghLUiWVvymgfZn8
 VQ7xd83VOX6EFyzsZqqpHzIHoq/FrQVa811mkadT24PZXp732DECAgcbwS8/zuHGXD08
 5ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640614; x=1710245414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/FvadGGUwctE1IWDDn0kVOXWDaUBwNAKUX6TCu5fDg=;
 b=Yc8ECGeDzUYGmEwexW9XIwFqsgYpeq1UY4Yk3+scyOeHQvNOlLD/NWVscY+q9Y6ncS
 AXm6L3R+Y7RlkGwqLaigCCzCPczgPUNw1FjspEfK4kJPVXrMtk8DzM2IAwTkCpr63O5U
 ZPUWWVwp1yCI9TfsRENRUX2Q85ILPeuRjRUXicYNWRNUscgQd7nAUi5YoCoXmZRXg92v
 kN7CnAA8JwY7VI53tQP2vJZ1NDZhSePkPU30xlQ8AK2rfgy4dgOuqs8LT2Jd3f2rTMkG
 ney/eAjMNxVt53BLeXSCIUoRTAJxEVWu5qhGYTaPckKz/x4eELQoLRusrOwTIs8Gu9ez
 gqRw==
X-Gm-Message-State: AOJu0Yw8pN3eXLsoez5ad9cbD/GfovaYYBuMNGxzA1u/CCXVVWBt79YL
 RtHg3B6Mk/Te+UPSmA0Mi+J90Za/XXpgvsf/WkHzpgW9ME7osDjvDnsQfsoOH+0=
X-Google-Smtp-Source: AGHT+IFRlWeZuoNQT4394axMB4M5A4PeGV9EvrVU80583K6WJL53zjPB2OtrAYcpUDFxlDs/3LsTvw==
X-Received: by 2002:a7b:cd05:0:b0:412:eaac:968a with SMTP id
 f5-20020a7bcd05000000b00412eaac968amr2114430wmj.16.1709640613787; 
 Tue, 05 Mar 2024 04:10:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hg5-20020a05600c538500b00412eeb017f0sm1196785wmb.34.2024.03.05.04.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5EDF65F7B5;
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
Subject: [PATCH 09/29] gdbstub: Introduce gdb_handle_query_supported_user()
Date: Tue,  5 Mar 2024 12:09:45 +0000
Message-Id: <20240305121005.3528075-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The upcoming follow-fork-mode child support requires advertising the
fork-events feature, which is user-specific. Introduce a user-specific
hook for this.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-9-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h |  1 +
 gdbstub/gdbstub.c   | 12 +++++++++---
 gdbstub/user.c      |  4 ++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 56b7c13b750..e6063835b1f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -196,6 +196,7 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
+void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2909bc8c69f..7be4418dcb5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1655,9 +1655,15 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len &&
-        strstr(get_param(params, 0)->data, "multiprocess+")) {
-        gdbserver_state.multiprocess = true;
+    if (params->len) {
+        const char *gdb_supported = get_param(params, 0)->data;
+
+        if (strstr(gdb_supported, "multiprocess+")) {
+            gdbserver_state.multiprocess = true;
+        }
+#if defined(CONFIG_USER_ONLY)
+        gdb_handle_query_supported_user(gdb_supported);
+#endif
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 866a25f9c06..c9e8b83d720 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -382,6 +382,10 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
     disable_gdbstub(cpu);
 }
 
+void gdb_handle_query_supported_user(const char *gdb_supported)
+{
+}
+
 /*
  * Execution state helpers
  */
-- 
2.39.2


