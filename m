Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58355C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5e-0005qr-6p; Wed, 24 Apr 2024 19:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Z-0005oc-18
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:45 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5W-0003Rt-Ur
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:44 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-60275a82611so328313a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001500; x=1714606300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=anHznBY/Cz4MfTk0yCQsZvoF8eFCJyevU6fe4oFhrBI=;
 b=GramDGr7IoCp6j4ysld0JeI0MR8LABxyBDhYVc7wN/tmo6RBFTw+gNIqoCNzFS/43H
 i1QoWrpv6u7w6AC94J+g8MFZVAH9H1HFZqPk5MZd5fBPZV+Kb6QVb2/ZTMAfsj8H8sa4
 JQDO0AFriswPfrJXSBhlpoWFUuH988Q9da8A45WLv9phIqXrl2hvb3N3zQlcMqvUBRIT
 iEAAQ2JRKTMy+f06wECG8u7kVPhn70IZ9mHMbKJW6kP+MiuVwRRPbZzFYP4tJFZSwANQ
 KnpExNr19Bbe2E2Mh6DNkry5+9+d2LZsqKgHWJzT9FrdArqSEsxxfulYsJUr1QHMg29F
 Th/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001500; x=1714606300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anHznBY/Cz4MfTk0yCQsZvoF8eFCJyevU6fe4oFhrBI=;
 b=of6zHvFpPQRb2/6hr45NHrdJfiZx09VMYXuLxpq2PQUt8KS1oUkCoOmS+OmlF7JAGr
 hqoMX/OCJX5CF+CkwY9mf3GPsVX0pCScp1Rs30/3sn1bgVtXeKJ4059RnGEyzmenQ0Iy
 riArBhboVDdx1F5vEZkwhsllfZiMx8RuxsFTB9nz4KZPpgk3tL/Q4XsC+szZzJmjpln5
 Cc981nvyfw9PvW973kGTM0t0R/ueCCzpTQhHl2AuWb3z7I5LSFiASkN1cM/QgbmTOUcc
 1W2CxovjblcHQ4M2u4KqmHUz11eSCrJv9QTiZ4qFcjXdp6r+1jji+QDPL5SpEs/T8yZ3
 qmkQ==
X-Gm-Message-State: AOJu0YznwJHlcRQo6csL4afh4WR4GWJ8B0vmKaq/l2EpLNRVbqORBVac
 gqW7Nky0g/2GhUm8U5hd/XY2urUavISWPCPFg9qD41NomAUqZHm6/l0Rae+AHG9u81RVwrwYGJX
 X
X-Google-Smtp-Source: AGHT+IH7pDBnjoALyZdmZ9uCcvwfyfaKrj+uXsFip5REYCUDz+b/MXKyC3J3vLnnLwJJq/JOaTQHTw==
X-Received: by 2002:a17:90b:f17:b0:2a2:937e:f958 with SMTP id
 br23-20020a17090b0f1700b002a2937ef958mr3713406pjb.40.1714001500260; 
 Wed, 24 Apr 2024 16:31:40 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/33] accel/tcg: Record DisasContextBase in tcg_ctx for
 plugins
Date: Wed, 24 Apr 2024 16:31:06 -0700
Message-Id: <20240424233131.988727-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      | 1 +
 accel/tcg/plugin-gen.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 135e36d729..2a1c080bab 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -537,6 +537,7 @@ struct TCGContext {
      * space for instructions (for variable-instruction-length ISAs).
      */
     struct qemu_plugin_tb *plugin_tb;
+    const struct DisasContextBase *plugin_db;
 
     /* descriptor of the instruction being translated */
     struct qemu_plugin_insn *plugin_insn;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3db74ae9bf..94bbad6dc7 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -329,6 +329,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
+    tcg_ctx->plugin_db = db;
     tcg_ctx->plugin_insn = NULL;
 
     return ret;
-- 
2.34.1


