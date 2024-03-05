Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E9CC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTe2-00038u-5e; Tue, 05 Mar 2024 07:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTd5-0001iV-MR
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcf-0001RQ-EM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412ecc1064cso4581355e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640614; x=1710245414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eN1w3VZA32Wi8fJgCeFoCtnvrPmKwuzv+ibyU3+3o6o=;
 b=BYZvPV/POC2s7JrzoSfCGWx4C2ATR+TzSETRejEefvUV9xkw2+trUwz1DT55H2+6tt
 BebBE4fz/8Z5duJmZKK+XoVvHVBcy3DoV35pzku8nqXufhwEh3yubslIYxiUku+DVOf8
 DxZQzZD5mos9p6PYwxxvkLtyBLwRJ4mdO1G14LPClRMc30o5NDchhQRpje4t5UuiU0rb
 1QKT+nt4usCqEuaEfiY8rAvdHgD+SxfuNtg9iykBP8ZI/6hxxqRVoGF9mbhuR3sAwj32
 dt55YwrGmhtz/Gm+UFTk9Y83tuAI0ns8WnGY9wRaSrUAIj6mgH3I0iEcJQ7kdVbykr0H
 SDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640614; x=1710245414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eN1w3VZA32Wi8fJgCeFoCtnvrPmKwuzv+ibyU3+3o6o=;
 b=RFNu/6EJ67/n7Oz77oFIUBtG9gsvioNsHGeB+eBehgrcN05K3CVQolMSeJMghIB3i+
 BWUScmgMigYKLyeSdzpYtfj30KnCv9xgQ4cRdiwccGsLePLHaDRWl6zBgj14NXWZ+hZI
 RXinlFJstKjaqXrDVcbm+FZb2p0Z2cygD6BZvF5roQMiGBGIv623/i1DAcVQNI/aJs+M
 VIZW/XmeIYTQTufCX2ZuKe5Xcg9sjHLnprY1xIEJ/k/ngEVqRyHtDuV1n/oJqG2qH7d4
 nAZvKpEU+6T6u1TFrPWOgUjAajTc1kxqjWfQQ9NRYURpc4rk4VrYza2Qyt0UK/9+mShz
 vyOw==
X-Gm-Message-State: AOJu0Yz2R5Ec06bgnUgX2R8EYGsHAjLVRosjaxBT1WcgaK4UciMm/0kg
 d4piLckg3sVfIbIXqZqYSAimL7NXbmOdPJKxuXmhovSb88I8iD3omKCaxq/ipGg=
X-Google-Smtp-Source: AGHT+IEVuEapc/2m/rYMnypstBHkreGm3a0DZAqtHtnVmJWeGeXufNpTmF9IPZPtexy/OrRqPDeUBw==
X-Received: by 2002:a05:600c:4fcf:b0:412:ebfe:68fe with SMTP id
 o15-20020a05600c4fcf00b00412ebfe68femr1410832wmq.35.1709640614053; 
 Tue, 05 Mar 2024 04:10:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c3ac800b00412e84e59d8sm3851590wms.44.2024.03.05.04.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A5E65F9CF;
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
Subject: [PATCH 11/29] gdbstub: Introduce gdb_handle_detach_user()
Date: Tue,  5 Mar 2024 12:09:47 +0000
Message-Id: <20240305121005.3528075-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
actions when GDB detaches from the stopped parent or the stopped child.
Introduce a user-specific hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-11-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h | 1 +
 gdbstub/gdbstub.c   | 6 ++++++
 gdbstub/user.c      | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index b4905c7181a..b4724598384 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -198,6 +198,7 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
+bool gdb_handle_detach_user(uint32_t pid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 3eb93162aa8..17efcae0d0e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1024,6 +1024,12 @@ static void handle_detach(GArray *params, void *user_ctx)
         pid = get_param(params, 0)->val_ul;
     }
 
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_detach_user(pid)) {
+        return;
+    }
+#endif
+
     process = gdb_get_process(pid);
     gdb_process_breakpoint_remove_all(process);
     process->attached = false;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index b048754c4f8..1a7b582a40d 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -391,6 +391,11 @@ bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
     return false;
 }
 
+bool gdb_handle_detach_user(uint32_t pid)
+{
+    return false;
+}
+
 /*
  * Execution state helpers
  */
-- 
2.39.2


