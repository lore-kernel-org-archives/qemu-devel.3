Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E57BCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0li8-0000la-9S; Mon, 22 Sep 2025 14:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgF-0005sP-Oq
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfS-00052B-OQ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-279e2554b5fso9293495ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567219; x=1759172019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=vqIXAnFIGgsJzYwp0FPmg6D65V4fwWISqtAYJTUC6xXmEoaZJ4PmHWViX+qc/i5HEP
 gFf8SzDtI9wHjjJALE285WK6oVq9SD0yWzqoFNxdqF88Mfr2Yp/CZifXLTSkItX61Tve
 YUeiMT+hJ4wl4Lf+flMC0urpyK+tfD4KJZC0pABvNuj0u0SbmPR3cLLvJy6JHPyX5QTC
 vCfRNlz7r7PguoLPTa9Bq/ptEKsSlDoIK8hDiScHQ5tzeZy9GrLmBApzoqz0+vgDrQ0i
 kyI+y6za0ax7oHMwg3jhhOFZHWzcycJCi7icKEPVcM/TMVGZkpOfW7Uez8lk+iT3WPEP
 UAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567219; x=1759172019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=FupFzLuzHzoLiXBDfkRuYymOLLRUYS4SvDFzg2YfUxkMr4opS4L5E7c7os3yR+n/fy
 Zo9y75Z311Td4lIMz+z0FRqSkVBxjzVma7K5c09/sTczuonFGXjQ6k8NBbbSnVVmvDhi
 h1AzSFE3g0KQYij9wS2tQA2RpNF+J/v6PHjgfLjyMU78shCNerpRf5hQjS/H1DKTNbmg
 uDWWsn/02jNsPPr/ME9IUlSW9BaahdBEB08Q6EOriYhabRePMZJN7rr8+CZ4jeZwh0dc
 /CDy0r2oJIkif7+aMeFb5HzzPn2D5PY9+/NZNTYOcZjcfFiUfV+E3a3Pk0lipfzto7PC
 hHxg==
X-Gm-Message-State: AOJu0YzhVuANRaasG/GhdMCDRoRKjVTjoG1koKqqeH233z1oGbvqDOqy
 mRk1B1xZrvJh3+JjAelkY5BYUGhgYHi0ibcbHJfzfyvL1niMfOW0e11L43gPdMNkippg96IsA+s
 nzoVy
X-Gm-Gg: ASbGncvZAGcso2Ac3DRssG0fH+iutBJSz+9PnZ2B5t5wO6YXe6Lql0CcbZdYvO8kZpF
 Yzz30EXpctQm9YtbXAAI2khk03Bw1Sdn0fcaCBQy3EEfGEMQqzN+QJLeGvas5S44E93TnlYosY4
 ge98OWGpO5brTx0q8wrODBciHL9PQGB1nDYF19xwGErjmHMNFSCbEEi4N/tOkT9BqbJqHcftlq/
 c0j1G0gQuS2pw/rvgU+79BNhDJHvMimzxXywZ+Ah+8vD+SVWVf71kbD95A9S/osg0Jvc14GjaaH
 NHNyCqNcP8Hl5eTHVvRL2Y66WC4JwKXNFIG99s2BAcWhw7IRg4zuzh6f3qaygBDbgm8TJfBXKb+
 d/yiMpTAc71jw05CjtT0FZI6+a98G
X-Google-Smtp-Source: AGHT+IHfLyg2uXsY34m+3iEe8uZlkCAerPVMhw7+qIV6BK8aSrGwu9MyjvtOp1PskSOEoOHRceQFEw==
X-Received: by 2002:a17:902:fc8f:b0:267:fa8d:29a6 with SMTP id
 d9443c01a7336-269b9cc7179mr167919305ad.25.1758567219026; 
 Mon, 22 Sep 2025 11:53:39 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 68/76] linux-user/aarch64: Release gcs stack on thread exit
Date: Mon, 22 Sep 2025 11:49:16 -0700
Message-ID: <20250922184924.2754205-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91210775ed..dfe114ceb3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9309,6 +9309,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                              FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
             }
 
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+
             object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             /*
-- 
2.43.0


