Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F58FC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdp-00043Z-96; Mon, 03 Feb 2025 09:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdX-0003nx-Ub
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:20 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdF-0002S6-N8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:19 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so854345466b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593660; x=1739198460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1O482OJIh050UUseeR+bYA6QoGKKDZRGYOAk/RFThQ=;
 b=ZIgKeMFbhbW4z/mtbAu8u2zY1rb+fKzdkxh79pY3Q+WAvCOBZckbdYzoOd+HCwCkPV
 QSmYXn+o9aspZAqFhflXdU5rHo2O5Ffx7suQnmMzp/LJJ8U71269l3tYn8AE1sZDHYql
 45kFFSnDZhJTjszzUhsqG1K9vCmFWv5jqTxRCQjZtin50pwYCIquNhc74IJz4W4XW/ef
 MYRhbKL+rRYvIvsXRuGVJHzmW/J0WEqZm79fv0XNmtgee0WftZce08JMhOS5Xia8qGs1
 +uob1GzxHR+LXHv16De5ZhyYAyTM9tLPcD+8gi6ai9Ck31+I6D/p/FUhzyrqHFMQXtDb
 AKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593660; x=1739198460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1O482OJIh050UUseeR+bYA6QoGKKDZRGYOAk/RFThQ=;
 b=m/eAA3MPgYNjdge0G9bow5Db7ExF/I/gCLv4Af7FVBKDUleHnPYcG7CoBAHqHfBD3+
 2tbolFjUAf1n348R3LobxzQnVCnPx+eAAQMgVIShv1ZM0x5ikzvwxHaVbVWXpIFB3fnv
 BZT5e8LHJx4i+CaT4/OcNF0c6oIpA2XgEwHZQADrNJG6v08cdusppVrotmk+C7if61iu
 8pmSzHf4b53U81hf20C3tnLPknAj+T4ia7uGj2aPLYQBZNG9+OT02aIjCh94TCNNkoOY
 430GZzRIXqslwcnNZzDzUF49FjHusXWOJn75b8a0PsB2ACpMFYgfZMYdRfxl3z4Wgi++
 +agQ==
X-Gm-Message-State: AOJu0YyNCQ5zqwhFPPx/pKklQAkAQwSziXHJuMZgA1K941G3TgJP1IPu
 fwcLre/qKMM2gNkahWV0dk8uxk+p0T8H+IE6KInEXPp3Aa539uhcBpgKD4fuBCA=
X-Gm-Gg: ASbGnctaXliTbc53PgvzU1vBWKONutrwRZoW3An1BZq0iiRGaNBwQAd3Y30pMIGO2Ow
 4k+9n6PhM1dnT1RZIvUh06ZWPr204+2jyMtcgGUJXTCIv2CO1XuNwTvCPfvAc9fMumJqNvYEqDP
 jYBrsWdxiV3Fj5jLh8WERehd3ro+TrYkH2xbr+5rus9qPek1LhoXaaidN5tus/bLf/JVqZ9Cu7d
 KWvD0ENR0y4SLT2ULpPyDjv66/IrrieL5D29842D8OOPKklJZAmiqG8cO90+ppJtu2ycCLL0u/T
 +eCUxMmXDlKtMzoDPg==
X-Google-Smtp-Source: AGHT+IGab3SCD85uoPPmeDJwS01muUZc175e7mJc3sQGYUDW3fAkncK2Pzl1jNLZMtqCfhZXqxt+rQ==
X-Received: by 2002:a17:906:478a:b0:aa6:94c0:f753 with SMTP id
 a640c23a62f3a-ab6cfd096f9mr2288818066b.33.1738593660035; 
 Mon, 03 Feb 2025 06:41:00 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a5621bsm779576466b.172.2025.02.03.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DBCA60BD2;
 Mon,  3 Feb 2025 14:40:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 14/18] osdep: Introduce qemu_kill_thread()
Date: Mon,  3 Feb 2025 14:40:44 +0000
Message-Id: <20250203144048.2131117-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a function for sending signals to individual threads. It does not make
sense on Windows, so do not provide an implementation, so that if someone
uses it by accident, they will get a linker error.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-6-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/osdep.h |  9 +++++++++
 util/oslib-posix.c   | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 112ebdff21..4397a90680 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -631,6 +631,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
 int qemu_get_thread_id(void);
 
+/**
+ * qemu_kill_thread:
+ * @tid: thread id.
+ * @sig: host signal.
+ *
+ * Send @sig to one of QEMU's own threads with identifier @tid.
+ */
+int qemu_kill_thread(int tid, int sig);
+
 #ifndef CONFIG_IOVEC
 struct iovec {
     void *iov_base;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 2bb34dade3..a697c602c6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -111,6 +111,21 @@ int qemu_get_thread_id(void)
 #endif
 }
 
+int qemu_kill_thread(int tid, int sig)
+{
+#if defined(__linux__)
+    return syscall(__NR_tgkill, getpid(), tid, sig);
+#elif defined(__FreeBSD__)
+    return thr_kill2(getpid(), tid, sig);
+#elif defined(__NetBSD__)
+    return _lwp_kill(tid, sig);
+#elif defined(__OpenBSD__)
+    return thrkill(tid, sig, NULL);
+#else
+    return kill(tid, sig);
+#endif
+}
+
 int qemu_daemon(int nochdir, int noclose)
 {
     return daemon(nochdir, noclose);
-- 
2.39.5


