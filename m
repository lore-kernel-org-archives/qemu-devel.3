Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBCC54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJN-00030o-Ll; Fri, 15 Mar 2024 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJD-0002x9-Rz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:05 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ7-0000mP-Ts
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:03 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dffd764036so23015ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554276; x=1711159076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wurtzFqTOAUqad7j3dN96Y1gK8V7tm4jLC9zvYbsnSw=;
 b=VHRSitp0PaRKdlhLXq8aAOGV3LAcwS86Wz67sYdIWE8tqaocsGwM3CpStaswWrcZ9y
 XjeQcFknkZV1JNzxBpPMPSyOfVXmN5wSjp5JNmqrzmswFs7WVChqAWxDxozH2xtU0aFf
 rz1csP/ro8BsBBeEAoZaNOUqa3HQ5KTadYdm4Avuoym0FzIOAqDEOxvN01pTfDphLFuC
 7sle6AJ+6RMtVX5uxed1fqgLwhk8fOaLBy0g23b3Nb6O0+PWBlL7DrXCP5g3WOAjc1zF
 Uu0QpqBvRbtqlZMrZgTClc+04og5cQli9zo2ISwGa0w7YyvrB8h/jcUkLNdxAEhiZh9w
 CMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554276; x=1711159076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wurtzFqTOAUqad7j3dN96Y1gK8V7tm4jLC9zvYbsnSw=;
 b=KX4C8674pcYdNY/+787m8U61Jv4Pg2NaM+3LKg09ob0irKyZVTTZrykDa+tinsrVAq
 47WH3PtHW1Wu+eKOhQsgvIi+Rs17jtBl92TfSE62eR0uENvI1jYy9rupiS2sbfDooKuu
 5ZgV/U5H//IfcE/DDXec4stHy93EU0tjl98rIrHcL7tPb2mAygMFhFBwGR43BEsiiFgl
 QvHbspAwXgvWDQc7kk53FaV/abHa/ibjTkiK9dczasucbIWFNK+/9wxY9EMD4QeboSEO
 Mzj8iZECW/QdPoels0xcsEjidxwM9h9ep7z+in5ZUL+3R/ncQl3y4M0QVri3pkdVkP/T
 f0CQ==
X-Gm-Message-State: AOJu0Yz9WJ6ISmZs6MXBl699ShBq1IFvztZZEehnUQ5/EWhkm5m+MgDf
 jSC5shZ3c30ELzPKyWiwJuFw5BMZbmSaPFmTdixPMDQDRaJrREH5wwXxqzGWDu5oyuXFZpdR8Hb
 5
X-Google-Smtp-Source: AGHT+IF1sp00SJ4E7IcIZ6iIu2Moz23Xf1a0uPgz5y9WOuxzOdkq5C9ZiJF0xQPA5MCGDsdkpFUHew==
X-Received: by 2002:a17:902:f68b:b0:1dc:af70:9f78 with SMTP id
 l11-20020a170902f68b00b001dcaf709f78mr7915128plg.46.1710554276419; 
 Fri, 15 Mar 2024 18:57:56 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 16/22] plugins: Introduce PLUGIN_CB_MEM_REGULAR
Date: Fri, 15 Mar 2024 15:57:14 -1000
Message-Id: <20240316015720.3661236-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 669e343cfb..6f0731b479 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -367,7 +367,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
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


