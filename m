Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45492CCD1BC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHm-0008M0-NF; Tue, 21 Oct 2025 16:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHk-00089X-Bq
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHf-0001A3-HD
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so40256245e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079708; x=1761684508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lWr7qEOB0Wvdd9KbFII+oaJFwDA5Ps8upXl6LmkSiEU=;
 b=wIuaSOFIMQaxhZ4Ji8o+gPYgYDw9HI35ItrMHm6q0VuZM2d4lVrx10tKwMIj6eg8jf
 lLQ5OQf5Quhj3aCeih2/fh+jJu2VR5bQ1Rg9ioJ7Pa6mW3pTzPoSIhvZThSjnYhVJMwK
 0gE/5cSex0gBYWOyoufxtu60fERw/vMPgGcUBa9k4yK9SxfVtpgFp50FMFgKg9t4HXE0
 YUY13PnUTP2QQU2qRAomIMGy53v8G9EGH8dWJCRDofQP8y4t5NkzBlv93TKAEd489mM1
 Vb+s5O9mqI27o5Tnb9DnwXtssGWkKDPUrxHpNF6MPhM58ZyPp9SDsqmomwfochTgqbf1
 222A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079708; x=1761684508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWr7qEOB0Wvdd9KbFII+oaJFwDA5Ps8upXl6LmkSiEU=;
 b=q1PvG8VdECJR+aDmspxFdPY5YpEhrW+Qcn54pdjRudERcwCNG7ji2IhsnImAmNdzoS
 lSnUpP8wg7RFN079cizAcGeTeNrRIU5x1i2EJfPvIsiber5D0y934z/L6dCrkjsJRmQD
 zphwE4+Nz3n0Jqdc3gha2Qdioq+9K10SDlWuNac4a5OwgER9+unocN9WYWorNkm5gfFO
 boiburhPCqIdPaFk7zXvkOOXlA8dnGrMZskga2p4Fq+mQd432YpFrTC1msM2CClC25ax
 OpCWV31SugFC0R+bn1uH3uvIgL2AOYcrGCrGRAvKguEJEK/Em9mgosDVQtxf6HZ7ZAI5
 iI4w==
X-Gm-Message-State: AOJu0Yz61aRotw9Ev0JwLV3DKQcTZJ2z9CRtN0l4uS2aifPuQbA21vN3
 nr2objT26GyM9A7IMzrR6L0Dc6+n7reyT+59FhjHfW6ytgDe9uze9SgGxuCGttTgf5BEsL3LsYC
 b+qUB2OI=
X-Gm-Gg: ASbGncs/Yco7V6Rl4sqtzlxP3lVcSmRlTZx2iJj+UBeJNTPq+FIr0MQ+ADk6/pTnigo
 OxRL73X9CfxP4JNLLL9auZwNH2TFcE26KkTHlwUtUAT8n+lN5KrXXZ4tDTvx56WpJeogfbyfIjS
 5JvI/mj4lbRuE4OdicUMi1a7YccFNTzz3Tsb2XqfOLJFnwJq0+c+a+9wgEkuPAob99gBGpWyr+W
 mj5FlOjRqJtWr3mSJHiP/7koRTqN652LP05JJ9PlkWoby1AWh7b//ETTR+Vb90ms+2uDUe6CYAt
 8s0r6XQxGaFzhBslhzN89Q0TEamOQgXXz7nfOJMnj8NYuHygD1JRd4ERzRffJuChPqu43CUUVJD
 duzgcYMWrQ9YFqp8pxzoE16YWSIYvDd6GOuTnWqp00gqa7D74B96dhvi4XVZGvDfJo60qvSkd7b
 5udhUDduUeqN08Rh3YIsCnLK9JR6c1wugAN9MAKdC+BO7O698bMlCiKmJg1u0Q
X-Google-Smtp-Source: AGHT+IHktbrj0wKz0uueX9HDEMPfrSrxwKAIdGEAQhgBb6Dka2ESQ9O2jE00dpxIS4WpA0CKySfQlw==
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-471178a236cmr128546155e9.10.1761079708023; 
 Tue, 21 Oct 2025 13:48:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3ecsm10317625e9.2.2025.10.21.13.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/45] hw/core/register: add the REGISTER_ARRAY type
Date: Tue, 21 Oct 2025 22:46:32 +0200
Message-ID: <20251021204700.56072-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Luc Michel <luc.michel@amd.com>

Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
RegisterInfoArray struct. When `register_init_block' is called, it creates
a REGISTER_ARRAY object and parents it to the calling device. This way
it gets finalized when the device is. The memory region is parented to
the REGISTER_ARRAY object to ensure correct finalizing order.

The finalize function of the REGISTER_ARRAY type performs the necessary
cleaning that used to be done by `register_finalize_block'. The latter
is left empty and will be removed when all the register API users have
been refactored.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Message-ID: <20251017161809.235740-3-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/register.h |  4 ++++
 hw/core/register.c    | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 4d13ea183c7..65c82600e06 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -83,6 +83,8 @@ struct RegisterInfo {
     void *opaque;
 };
 
+#define TYPE_REGISTER_ARRAY "qemu-register-array"
+OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
 
 /**
  * This structure is used to group all of the individual registers which are
@@ -96,6 +98,8 @@ struct RegisterInfo {
  */
 
 struct RegisterInfoArray {
+    Object parent_obj;
+
     MemoryRegion mem;
 
     int num_elements;
diff --git a/hw/core/register.c b/hw/core/register.c
index 2553cb15aba..1612ad174f9 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -245,10 +245,16 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
                                               size_t data_size_bits)
 {
     const char *device_prefix = object_get_typename(OBJECT(owner));
-    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
+    Object *obj;
+    RegisterInfoArray *r_array;
     int data_size = data_size_bits >> 3;
     int i;
 
+    obj = object_new(TYPE_REGISTER_ARRAY);
+    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
+    object_unref(obj);
+
+    r_array = REGISTER_ARRAY(obj);
     r_array->r = g_new0(RegisterInfo *, num);
     r_array->num_elements = num;
     r_array->debug = debug_enabled;
@@ -267,7 +273,7 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         r_array->r[i] = r;
     }
 
-    memory_region_init_io(&r_array->mem, OBJECT(owner), ops, r_array,
+    memory_region_init_io(&r_array->mem, OBJECT(r_array), ops, r_array,
                           device_prefix, memory_size);
 
     return r_array;
@@ -309,15 +315,27 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                data, ops, debug_enabled, memory_size, 64);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
+static void register_array_finalize(Object *obj)
 {
+    RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
+
     g_free(r_array->r);
-    g_free(r_array);
 }
 
+void register_finalize_block(RegisterInfoArray *r_array)
+{
+}
+
+static const TypeInfo register_array_info = {
+    .name  = TYPE_REGISTER_ARRAY,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(RegisterInfoArray),
+    .instance_finalize = register_array_finalize,
+};
 
 static void register_register_types(void)
 {
+    type_register_static(&register_array_info);
 }
 
 type_init(register_register_types)
-- 
2.51.0


