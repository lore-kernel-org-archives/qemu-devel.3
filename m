Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635EEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldN-0003i8-Dp; Wed, 24 Apr 2024 19:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldL-0003h0-6L
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:35 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldJ-0002co-Bd
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:34 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5f7fc45fe1bso337911a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999752; x=1714604552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vf2pglGQtHQjyWIwNLhivR5j/rpAVWzFiLJardZxKs4=;
 b=YIn7HrMbvpJw04PuEvtFlxoVmjGrGPUJlSmRqIfhUUCzczd6d9F+O7F2QsekiuIqVy
 2d6V3TRg4yiPnMRCE+3f82yJhuHObgHA5AN5J40d+c55fKlRrDP3rXuZU9dGyDelmfg5
 apCpNXx6HD/5xVZ1GzHAlRDi88kVQK3loFIdcfv4VNpsrmie+E/W7NiY5SwR84n8LdCO
 0XCo8LbZk+08DX5RpI+TDC0vj9HBG82WjevtRLQVBLJSyuDbM0qlYBo8OOctL9i3xjKl
 3A6cYoSzhYxng8wCuQPrvrFy2ojJFX+/ZmE21Xy6dLJxVg3dQYDQgBXVG8xS3nvRZIfE
 KS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999752; x=1714604552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vf2pglGQtHQjyWIwNLhivR5j/rpAVWzFiLJardZxKs4=;
 b=qWlKWv68u6Afva3Rn3/GTyRqJWxqAN2Xb9jAvp7j/0imcjv5n1mEjaT/wh+80MOS5B
 UIV2hkOm4UhAAsRs0uGh+r7/zBJIwIfwvdpN5TYEItE2DgbyFiQ530sygLQIiV60S2Ug
 VXStGhoDfbrEA861uE1B2UDNRBL+qVfRnkCYzPcRO1MHYKV1o3HGpYTAE8walMBd5Fz2
 IYiGlghaSkZbDaVEXblmziIkCSOczNKIkQqmPDZmaU2TzrUdUPiXnW7/4s380fHinvFj
 FSpeYjXMwwRt0LZwuRLnaMesLi0jGvR1Ytjz62tHU2UUi79TyqbU1b57iTXE+nPUgLLi
 sE2Q==
X-Gm-Message-State: AOJu0YyvenbAN4mz7r5K55ZX+olsGzdWNDos9DtX0q0tHnM6b699MuUw
 2Wm1yFmSgCs+rAOEtjxGoUBfcU4qKcxjJ1PJev3jV1ACp/pcsJsrr4FoqGKglB7uu9Wb9lRQtvR
 J
X-Google-Smtp-Source: AGHT+IEInMckfoDhMMy4JsvuaST+CIrgJ/NpwRAeTVviTUGibdHrBXzAY1ogkfAkuj7MubmgitP8Lw==
X-Received: by 2002:a05:6a20:bca8:b0:1a9:55bd:95f6 with SMTP id
 fx40-20020a056a20bca800b001a955bd95f6mr3505658pzb.31.1713999752041; 
 Wed, 24 Apr 2024 16:02:32 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/20] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
Date: Wed, 24 Apr 2024 16:02:09 -0700
Message-Id: <20240424230224.941028-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
index 143262dca8..793c44f1f2 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -92,6 +92,7 @@ struct qemu_plugin_dyn_cb {
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


