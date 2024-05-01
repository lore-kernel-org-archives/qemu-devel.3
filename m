Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B69C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5r-0002gx-03; Wed, 01 May 2024 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5h-0002fD-M2
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:50 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5f-00027M-Og
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:49 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6001399f22bso4727218a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574266; x=1715179066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06SN57pqqKBY1c5MKLR3ZmhRP+7u+LpsRiqijEh2kh8=;
 b=M49hcT2zJ5et89r3aMjWgwr0yFGP8t6L+bCKHveNYR3nAUqbVCR9nSW2DtKR5XKKhQ
 kw+3uhKtFHDwXKLAESyKDtTwgh0VAaeWG77BGwCh/ALEhx8xJVrKJd0UD3FOykUOhvTW
 isV1o5alTQCxPvDViOcX64mRvosZdshkFTUqNvphE4Gs3RddWf2mn31Jfmi8YsRBBP8Z
 HRIFRJ/aJh8HM7FCU473FujwydmJvuzWZHy3DidWAPV53Kgbn6fudrJJJ3JQk+6pCQKq
 M3IfvYrTngkWnKU0jFcVNUR6sKjmC9q4kmNxbIdqLOU2EojRoUmYyDmiW24qVWW8jpUS
 eN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574266; x=1715179066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06SN57pqqKBY1c5MKLR3ZmhRP+7u+LpsRiqijEh2kh8=;
 b=fOs/jIPPoln+Luz9TN+2yNWnFAu3vyr9TJeicXPnHyO4xajn9Us6/zL3NOj9f4evyQ
 ebuvhDC0SWPcGYCG6XPwcg9sdI0JFNaqR10fiw2Ie9ghxCGauBH5PcOgOwilVMZ3SjW+
 URLKMmsDiJ5TZqZNHCJOJW9D9Y1Dn3hSguzVj66Jcue/HTp0LwDtE7ra0CYEPSWk3jua
 8E7aktTAz2nsD2ok/rAOWxtymHnQge87TS084N6V7cNnfjcVyY/PL7ihX9B289Fvhl8l
 XYXkKo8pBNVYR88Xbm/RE39vscYHpZ5Glo0q+KvXGGF6wqCQhExGEQbFT7gun/z62YHh
 tw1Q==
X-Gm-Message-State: AOJu0Ywow2HO28DnBXXD1Kkpsma7a1UqkE1g2X8C7BarK/Lou8q1YvC3
 q+fidx/7uxbZH5l3Vi1PJZfk7wGp16aJTw5S16UiwcnhI7BuQ551WgDh2QkOAMQ073QOMjt1rAM
 6
X-Google-Smtp-Source: AGHT+IF8tnnqrQhCsU9d3A35+WEdrDJTtZxfhMjhEA96msIKUPgcGV/LGzHVzYWGhFv5im0NvrRudg==
X-Received: by 2002:a17:903:244d:b0:1eb:4950:554f with SMTP id
 l13-20020a170903244d00b001eb4950554fmr3360916pls.22.1714574266222; 
 Wed, 01 May 2024 07:37:46 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/20] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
Date: Wed,  1 May 2024 07:37:24 -0700
Message-Id: <20240501143739.10541-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

TCGHelperInfo includes the ABI for every function call.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h |  1 +
 plugins/core.c        | 51 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 5676ab5ef2..d0d830bfc0 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -93,6 +93,7 @@ struct qemu_plugin_dyn_cb {
     union {
         struct {
             union qemu_plugin_cb_sig f;
+            TCGHelperInfo *info;
         } regular;
         struct {
             qemu_plugin_u64 entry;
diff --git a/plugins/core.c b/plugins/core.c
index 837c373690..b0a2e80874 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -338,12 +338,26 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
+    static TCGHelperInfo info[3] = {
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        /*
+         * Match qemu_plugin_vcpu_udata_cb_t:
+         *   void (*)(uint32_t, void *)
+         */
+        [0 ... 2].typemask = (dh_typemask(void, 0) |
+                              dh_typemask(i32, 1) |
+                              dh_typemask(ptr, 2))
+    };
 
+    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    /* Note flags are discarded as unused. */
-    dyn_cb->regular.f.vcpu_udata = cb;
     dyn_cb->type = PLUGIN_CB_REGULAR;
+    dyn_cb->regular.f.vcpu_udata = cb;
+
+    assert((unsigned)flags < ARRAY_SIZE(info));
+    dyn_cb->regular.info = &info[flags];
 }
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
@@ -352,14 +366,39 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata)
 {
-    struct qemu_plugin_dyn_cb *dyn_cb;
+    /*
+     * Expect that the underlying type for enum qemu_plugin_meminfo_t
+     * is either int32_t or uint32_t, aka int or unsigned int.
+     */
+    QEMU_BUILD_BUG_ON(
+        !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
+        !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    dyn_cb = plugin_get_dyn_cb(arr);
+    static TCGHelperInfo info[3] = {
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        /*
+         * Match qemu_plugin_vcpu_mem_cb_t:
+         *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
+         */
+        [0 ... 2].typemask =
+            (dh_typemask(void, 0) |
+             dh_typemask(i32, 1) |
+             (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
+              ? dh_typemask(i32, 2) : dh_typemask(s32, 2)) |
+             dh_typemask(i64, 3) |
+             dh_typemask(ptr, 4))
+    };
+
+    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    /* Note flags are discarded as unused. */
     dyn_cb->type = PLUGIN_CB_REGULAR;
     dyn_cb->rw = rw;
     dyn_cb->regular.f.vcpu_mem = cb;
+
+    assert((unsigned)flags < ARRAY_SIZE(info));
+    dyn_cb->regular.info = &info[flags];
 }
 
 /*
-- 
2.34.1


