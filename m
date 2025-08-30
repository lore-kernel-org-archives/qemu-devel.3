Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C327FCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNzu-0000JO-LC; Sat, 30 Aug 2025 12:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERa-0007Y6-75
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:07 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERX-00052S-QJ
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:05 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so2718916a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532881; x=1757137681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxayGpcvk1WgEIrwtrnI87HtMykvmuTE7R78plec4rY=;
 b=n7NH24F+Q90iRqf0FN8wow7/sL3BNTM+jKpOF6u9hj4wVPTqN29RFNMu3VcBJEBOV0
 2WTxtsKI0oGBoi7kfUJwn3PEHsn1gScg0pJg+WO6HeLD9SOLEvtIoU0vL1NYgODePTKh
 z+EgPn4Pu6wxl6+g9JYLMym8dq2pbWc0QiUZ53k4WsuYctsUNbcBl0Ni2up1ltRkv4gB
 kTk6aHYKfbzj8FtdoLLNq5gF2BmIQ8g4hjGEZalxI4/s2AhZuhztTuRY6WYldRtoc3pq
 jhM8vJZM1MGvYN0RSSjbJeK5B1wDDucAhjWWy/4izxa6X6hZXttd2k1dhLzmyZbIa5Vp
 9G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532881; x=1757137681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxayGpcvk1WgEIrwtrnI87HtMykvmuTE7R78plec4rY=;
 b=WmgUsoSCaDy3Af8MdLHs0MbPvYPdYLNIseKuF3apcxKyyL5McDB3NF2B29R56qff7j
 gf+Q4dfI6kbCZabtyaOWm+isKBHVHiRoVMZTzCbQrdqYcm3NeZpxP4dEUc4PgSazjkjD
 IMrAaYMQ+TwhvUf7X8BdSBUL3kZa2MDRXco5dDYvmLN+c9P7PgylsGSwpAFcoZAgLAUj
 8QM8n6obG4dOLBCSKZIA02E4uy1pdSGuaTDBgsTPpStEzpEmneNUdXpcGZxkzg+lLyPx
 75EDH6TCgruxZBW3aAIF11Xpc0PaMm9JsQn3qY/fLMCcbTyot3R9MSvHl/sOxvBKSABA
 1wXA==
X-Gm-Message-State: AOJu0YwA/AF343dNVha8U4F/ZUUOHPs6QD88bJ8leypjC1/1lZiSEAPz
 64vfOxORKJ6N12tAP7F/grW1rTdADZ0Fz2C165DTgyk1Gm6OLvjU84XaVw8Ew0qmZ54k1C1yG45
 B0bIZ8jw=
X-Gm-Gg: ASbGncuOsDF/3D4LYRKiiGIMpcWL8L+ZwMMgd3RCRm4YVqXe5NEjGJ6pBBLZ2/XckZW
 YhmntAcyU6kc0iaBnS5Bt7iry45zIPgVDaBWnch/kzHXKUgvuXXKqhWy9+M63RVTp9QBDCZprFd
 czL3i/MPzrxAg/agdmFzJ535WdBF+m1Gvc7RgqJWjg62kv9SYwwOyfqMigMkSWdTZoobfXeXaKE
 95RvSQviHFdWGLRNyIVwhfs/teF5hZtl+VysBaQJnbSOaBlWqzsKGyDMQc4cBBgzh5oVPnEJOWt
 bqTdZX1ZpqbWGzAh50NOef8fyvgU6EniVTkhkRmbfoJHWVRKhRCLNwxVh1lASbbg8q1rD87/hO6
 tmJgkDj6ka/Mv1ISoDtJ/GhIPa12aJzI3GFfJiXPwJa/2PfNbI7D18A7+B0fi08TTslXxFovDjQ
 ==
X-Google-Smtp-Source: AGHT+IEXpPWtC2AejPF9MJkQbi8YS8db2lLdXdenwNcXAFltjaCvNKIzeprWTP8sQDz/Z0oV4YEYpA==
X-Received: by 2002:a17:903:41c9:b0:249:1128:582f with SMTP id
 d9443c01a7336-2493ef4eedbmr21409455ad.17.1756532881444; 
 Fri, 29 Aug 2025 22:48:01 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:48:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 73/84] target/arm: Enable FEAT_GCS with -cpu max
Date: Sat, 30 Aug 2025 15:41:17 +1000
Message-ID: <20250830054128.448363-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
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

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 76193826ce..8ebb0a91db 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1206,6 +1206,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4b07af9eac..21c187a464 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -73,6 +73,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
-- 
2.43.0


