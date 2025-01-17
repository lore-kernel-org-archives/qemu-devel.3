Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA15C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr6E-0008Jz-Mw; Fri, 17 Jan 2025 13:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5p-0006D6-31
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:17 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5n-0000Kr-4y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:16 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so4238354a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138553; x=1737743353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBsqQj8rQBpzTgQIoyJGX8gEHYch3blKkFbgri8rIlE=;
 b=rUDKe1cmxStgtO2G+OESB4FXvkI+9pnfm2RONz2YPe75eYaa732us2qrtJ0itSOQta
 MYcwRV5n/qWpq1AKcj5Q1ZmxEK8vrf6/8t17x1f5Gjd271LOzmfamypkR0AjZgR0i1kO
 x8VXf8ubP3mmAtGVm5GA7VImkz8dymmCLH1ctFcV6dUHkXHMD1DOMgDzPTocZRCK0Qzh
 dzCCWV1RkEC1Y2OGoRTbUeMizPJT66i+ZkW9XhwM7kzg/kqrLftmC9lrA3D5U84Jgi+A
 sOMAMtyv7f9gK1m/eiD37AtVa8+Wtp2fFwKLHJ3G+MXApSIRofFirIzlFO2GZm4Cizoz
 RVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138553; x=1737743353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBsqQj8rQBpzTgQIoyJGX8gEHYch3blKkFbgri8rIlE=;
 b=RJGgSfYwBiWQOoHu6+EbnHFwYexjn6oFQ0I01hBuS99RxVUNVgYCl4gRgipudfv5cK
 dFTTnnHW4wkG4lrQ+revxQJIO2nK0dpPv0IfNcIC970G6ox1FoxN9Y0IlfxpgdUaXkUL
 +V91yEIYqlzAgobGuv9kK10szVcg4BTOY5JO6Ru3peRXM3T5BgDZd2/tf2tyaMXllQ+y
 3bBexU0tnsAntn+Y9QGgNlXmACalXei/JDvx92X8ec5z5ZyxBaA1DLCk+WaggLZqr6kx
 3Cc+gEEQdXut1Z0qdM3EgZvlV+OS3hIe7d/XUVRE/6gid3mT2f81YFkLnxYG4H24e7GV
 p0UQ==
X-Gm-Message-State: AOJu0Yw/4aecUbNzCoHvx0/LiVGqOj8XQdGBiswq07CS74HpbN4s7j3W
 f+W4/7Cpe1k07RTrY+Xfo0iImmSWs6W5+7BbV0SLu8y9GJ3Mm39ivIzt1ik1hRL1/52qHXu+EaW
 j
X-Gm-Gg: ASbGncu9qpbaR3Peu1LecOKcWE94Z2F+QFVtor9r+CaovElfIwz6DsiVFsPW+kvfKUg
 TVbQidTdAM/xhDrTTq26WfQZCMnazIM7ivw+3fgKFVk2gWpamPZRR9KHFbRbHPNfs6HdolDUeEL
 OTYd0rR8s2a936+YGW4gYsf/jhylzqi8sxmJsYxU+vnpTdp/u9sbWVwSanE9kMupJLnEedkWHT9
 oImA8G6RINAyDkkPlnhvA/Sz7HNo7lpcH1dYFEPllrR/65NVIwQY5d978g5lTo48PPS6GTAPWZd
 KrRxIUZmPK1bOIQ=
X-Google-Smtp-Source: AGHT+IEdvfEzEPmLZ3e50dZmWBw3rZOvXfFqtAGWskfFcram+nf8u02gyYylDqWT41QPxuKosnlwww==
X-Received: by 2002:a17:90a:c888:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-2f782c90095mr5672794a91.11.1737138553521; 
 Fri, 17 Jan 2025 10:29:13 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 66/68] tcg: Document tb_lookup() and tcg_tb_lookup()
Date: Fri, 17 Jan 2025 10:24:54 -0800
Message-ID: <20250117182456.2077110-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

These similarly named functions serve different purposes; add
docstrings to highlight them.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250116213214.5695-1-iii@linux.ibm.com>
---
 include/tcg/tcg.h    | 41 +++++++++++++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c | 15 ++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e7ddf979f6..1d1d668f52 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -638,10 +638,51 @@ void tcg_region_reset_all(void);
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
 
+/**
+ * tcg_tb_insert:
+ * @tb: translation block to insert
+ *
+ * Insert @tb into the region trees.
+ */
 void tcg_tb_insert(TranslationBlock *tb);
+
+/**
+ * tcg_tb_remove:
+ * @tb: translation block to remove
+ *
+ * Remove @tb from the region trees.
+ */
 void tcg_tb_remove(TranslationBlock *tb);
+
+/**
+ * tcg_tb_lookup:
+ * @tc_ptr: host PC to look up
+ *
+ * Look up a translation block inside the region trees by @tc_ptr. This is
+ * useful for exception handling, but must not be used for the purposes of
+ * executing the returned translation block. See struct tb_tc for more
+ * information.
+ *
+ * Returns: a translation block previously inserted into the region trees,
+ * such that @tc_ptr points anywhere inside the code generated for it, or
+ * NULL.
+ */
 TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
+
+/**
+ * tcg_tb_foreach:
+ * @func: callback
+ * @user_data: opaque value to pass to @callback
+ *
+ * Call @func for each translation block inserted into the region trees.
+ */
 void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
+
+/**
+ * tcg_nb_tbs:
+ *
+ * Returns: the number of translation blocks inserted into the region trees.
+ */
 size_t tcg_nb_tbs(void);
 
 /* user-mode: Called with mmap_lock held.  */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d48b82a932..8b773d8847 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -249,7 +249,20 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
-/* Might cause an exception, so have a longjmp destination ready */
+/**
+ * tb_lookup:
+ * @cpu: CPU that will execute the returned translation block
+ * @pc: guest PC
+ * @cs_base: arch-specific value associated with translation block
+ * @flags: arch-specific translation block flags
+ * @cflags: CF_* flags
+ *
+ * Look up a translation block inside the QHT using @pc, @cs_base, @flags and
+ * @cflags. Uses @cpu's tb_jmp_cache. Might cause an exception, so have a
+ * longjmp destination ready.
+ *
+ * Returns: an existing translation block or NULL.
+ */
 static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
                                           uint64_t cs_base, uint32_t flags,
                                           uint32_t cflags)
-- 
2.43.0


