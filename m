Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6D4C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldZ-0003qq-Sl; Wed, 24 Apr 2024 19:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldV-0003nU-DJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldT-0002ex-NZ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso425497b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999762; x=1714604562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzYzU7RypP3Y+HHaxfaYXazYrOjoOSxUmTQNH2aYDBw=;
 b=wnHVHkwpWJpnlQH+TRY5chaKvo5Vw3a8t/v2PIPTNbiosmKwfqgzPQ3H9mWOVI7bfS
 u99hkfFhki7OnNhbJ6gRetIEpC9GwPOhpGUSgiJmNg2f4bpmgF+QIfyqUk4Vc3EBTa5c
 7u41KiN7rTkO/vW3hMDRiMnQxd80YxJ1nEJj8fZoxGY5IEDiqjkbQr2nJKa3EplC5xbI
 NKVi2b6j4Rxsx4joD1rAlhI9n6G9rA4hYOfPd8WxcbmYxo4QVh7cK3P7z2XjDA2abYrb
 ApDTR7HwkAtw18fk11WPJTyiE83P6ch4OprFYM6/X9nLPBRDK4jGLpFMxUGavtVvuQyn
 7zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999762; x=1714604562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzYzU7RypP3Y+HHaxfaYXazYrOjoOSxUmTQNH2aYDBw=;
 b=JxelFJSbvJSEEC3pjlfJkgUkA41TPh0CyX3S0vH7zdocKR1YN4L8AyWI64lWy3xyVI
 aEnyiAnI9lkoT8K7R1BYDxtn9gNyFPgwRtn49IiU4nT0zTMkpyy7jZ/7EMbONMLkhNPx
 DyNbMt6SRdDzJB4AHqb4UnMja/hW6JbMULwOpYOH2mst9Ixv551nUaRJO2JrUcexOlCf
 j87wqirTnmI7nkLrbMmlv2HO0T4APWJKwGDXPP60QpYbtIi2JGUxYn3wHQHAAHRXSZY2
 1nSetBKRJQrpQWURK2/sDxC9qJdif/gf5Nt+Sz2tn8k4hhpulGUu94N5aGjgMpJC9Zhy
 HVIw==
X-Gm-Message-State: AOJu0YzjZnLGm9SADYIrLyaBiizMGbgJVgyWAXh1Xcgputm0oFDoiz1b
 ggO89miu+w7May7wmsoZ30A+vh8Z0Mi0lX2XnNJ9Euv6ppB+oavEnfViVNEHNKlKgydoMTa6w2r
 h
X-Google-Smtp-Source: AGHT+IHNSt71ej98x2UqLPn2djlCnj+8kjChr38g3WInp3/+0vp8jyDueCcjDljzJIkxQ/8OmekWbQ==
X-Received: by 2002:a05:6a20:4322:b0:1a7:89df:2707 with SMTP id
 h34-20020a056a20432200b001a789df2707mr4355966pzk.10.1713999762381; 
 Wed, 24 Apr 2024 16:02:42 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 15/20] plugins: Introduce PLUGIN_CB_MEM_REGULAR
Date: Wed, 24 Apr 2024 16:02:19 -0700
Message-Id: <20240424230224.941028-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Use different enumerators for vcpu_udata and vcpu_mem callbacks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 1 +
 accel/tcg/plugin-gen.c | 2 +-
 plugins/core.c         | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index cf9758be55..34498da717 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -67,6 +67,7 @@ union qemu_plugin_cb_sig {
 
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
+    PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE,
 };
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index e77ff2a565..c545303956 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -361,7 +361,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 if (cb->rw & rw) {
                     switch (cb->type) {
-                    case PLUGIN_CB_REGULAR:
+                    case PLUGIN_CB_MEM_REGULAR:
                         gen_mem_cb(cb, meminfo, addr);
                         break;
                     case PLUGIN_CB_INLINE:
diff --git a/plugins/core.c b/plugins/core.c
index b0615f1e7f..0213513ec6 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -391,7 +391,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    dyn_cb->type = PLUGIN_CB_REGULAR;
+    dyn_cb->type = PLUGIN_CB_MEM_REGULAR;
     dyn_cb->rw = rw;
     dyn_cb->regular.f.vcpu_mem = cb;
 
@@ -547,7 +547,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                 break;
         }
         switch (cb->type) {
-        case PLUGIN_CB_REGULAR:
+        case PLUGIN_CB_MEM_REGULAR:
             cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                                    vaddr, cb->userp);
             break;
-- 
2.34.1


