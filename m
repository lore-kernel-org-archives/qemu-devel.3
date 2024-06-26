Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97342C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbp5-00038p-M7; Wed, 26 Jun 2024 19:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp1-00037u-Ss
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp0-0000OA-BA
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:03 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so55240115ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719443580; x=1720048380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zs33WUET3TwShkJZi0v92Kdx2DNNU6JjJOAyINKhk/A=;
 b=n0Or9DdjfvPbekEtxWyOr75G1YMsVilhH2jw1uul4adaPCk3owzVLJwIgpXXfQMlLt
 G1SwQRkK1phO/TDGmRwzJom9DwJOIcp+0HQdqFBLpSdG9Lllr3OEwXxbvhAE4qP4fpdu
 ej12U2y7IwZE/6e74IJulOHFmzv8gdPMBoK4/ya7qSR9Cvs00OX5CZCceKo6QvB6ctCV
 gvlDJcUqB7Mi5g6rFaNLU9PXxVMjC74uWz1gl7MA5VI8+J9qdz8yqDeuzDpCdBxwmEkL
 ChQTezdtGgHIBp0yl0BW1Vi4zT8Pdx3UebJis6g3p8WGIMx4V3P5gsrLKBEzYO2U6ekw
 hajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719443580; x=1720048380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zs33WUET3TwShkJZi0v92Kdx2DNNU6JjJOAyINKhk/A=;
 b=CX0PXVNQnnPSDdIoP9002v8IeAYP0DyisFvCKOE0JW6AL3bVunhPMxjMke3DOB+PXV
 RE4K9Y/bbYis/GRZXOVv11SkJCLi6Bf94E+bNPRJxeJGcifZHrqSqf7IGQJZ6wV38QG3
 rbbtwUB1VUhdukHls4T9RB3wZ2UdXISjrDgNzgJnDLsVgkj1SjlYsRTBJQAo2uK2hwF8
 /GrHw7orpTnjksGp8HyBXkOHoeAlj4Mf85JSv3f6mBD3xOKmdReU6LuT4art0MIVtQKk
 1EnZYbiVrYxn6BNZeMYp3DDWBkaPge4Xdk13KM+PVVUvps4vn1VobXkTddqI06zlX630
 Yozw==
X-Gm-Message-State: AOJu0YxpQreVcbmecd5poTApUs8oCYyI56N42CgItnlN9YvLVwQFo5SF
 LLrOR4FeGzUbjMCmWkL7WhAl2l+ly277tKQq0nCGnEQNYgFLo1mj0CGXYq/pQiEbLwOXYAB0SfX
 mfno=
X-Google-Smtp-Source: AGHT+IEsfFw9YiaByLuzu6aiDzdQ0PqaouTqgeJ9vG0tgI2s8V6aBZH3f36ljcaphif/R0JyygI23w==
X-Received: by 2002:a17:902:eccb:b0:1f7:1ba5:85ff with SMTP id
 d9443c01a7336-1fa1d673c80mr136315375ad.57.1719443580340; 
 Wed, 26 Jun 2024 16:13:00 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac82cd3bsm478215ad.0.2024.06.26.16.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:12:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/7] plugins: fix mem callback array size
Date: Wed, 26 Jun 2024 16:12:49 -0700
Message-Id: <20240626231255.339353-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
References: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

data was correctly copied, but size of array was not set
(g_array_sized_new only reserves memory, but does not set size).

As a result, callbacks were not called for code path relying on
plugin_register_vcpu_mem_cb().

Found when trying to trigger mem access callbacks for atomic
instructions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b6bae32b997..ec89a085b43 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -85,8 +85,7 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     len = insn->mem_cbs->len;
     arr = g_array_sized_new(false, false,
                             sizeof(struct qemu_plugin_dyn_cb), len);
-    memcpy(arr->data, insn->mem_cbs->data,
-           len * sizeof(struct qemu_plugin_dyn_cb));
+    g_array_append_vals(arr, insn->mem_cbs->data, len);
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-- 
2.39.2


