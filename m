Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C711D2A544
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kS-0002k8-07; Wed, 16 Oct 2024 15:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kN-0002gM-Ad
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kL-0003pk-7u
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ca7fc4484so1177025ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107108; x=1729711908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dv6u2nNWkqx2QinOJ+QPs2qTyVh0lqH2PTx6QeDWZY8=;
 b=uSSZKaA6+KJoidJNDTv/ELK+EPe5RsWQVJwsPRivPBZRShEL390guUPWVyl5Qd95sK
 51M9pqmQI0qv2O/bNIthBy6nvDE6FSckKb6iB7sKF/5fozv2aYfa9FxnOXR+i0e+Vaqe
 nG6D3XcotDqwZOxukONEB4pJxhGDUk17R87WE9Mehehi6CRcTvN4UYOWgBeGjlGvyQpm
 T1ydfoCD+0rtbgs8dvTDHX2tLbRnMf/OkbbH72uw0GrdliIeEdmXm6By3neiZ/O/eZRd
 OtNIvS1Lq42kzgle6sHk7iSyHIQoIHQ2BtFGN7a+iguP3RXCITVG3eN/KhxIR4v/A8ze
 O7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107108; x=1729711908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dv6u2nNWkqx2QinOJ+QPs2qTyVh0lqH2PTx6QeDWZY8=;
 b=L/F2I9dZ88VA4wJt9HKqQ+9/qgICVsUDuh2YVEGa7pm4x+RHTBjrxJ3qZT5N0/q1Ob
 VW9GDFaRlHSeScesLYa8wHy8skgwhycujwYAO1Agu/+kcSPDZZzN2mcua6X4fb+IjwMJ
 xFkL9OQ8imMHmlz0AXvln3DFW/KZgnyGqrzXHIJLKbH7+ZkyUIeeRlGz37u2Un76IRAR
 TCpjf2V/g9Z9W+Yfk38flDl59AOb1Yx0EKkPThnhWPgMKJEHXjlfxwPN9lWVfsdTDtL+
 no+kuWUsySjfMDaPE4hdqxaDhR6GoDXLCE8kNO09IWK6Kzn1DXDtdbaRjdm1McHWxhrH
 QkLQ==
X-Gm-Message-State: AOJu0YzuPRwe9NXaCLm5HFn5TbUiTDztjsYkq93pZyO+BJ9+rVp6Tp4v
 Nb/iX86NgBI9SyPQ4W6oBZcDZ1kfAJ9/EyUUI6OmXYh1ZEcN5ZlveMZB2eJjPZK8CJ8VT1txBfN
 L
X-Google-Smtp-Source: AGHT+IHaQFiBfzvUIDNvwSB2b1zGWSUyJZ1z1I26rQzi477sEDzFKVtRgQILd86PCKIvDmzkRR6Dfw==
X-Received: by 2002:a17:902:e80d:b0:20c:7d7d:7ba8 with SMTP id
 d9443c01a7336-20cbb22f1e8mr232167085ad.46.1729107107502; 
 Wed, 16 Oct 2024 12:31:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v6 09/14] tcg/riscv: Accept constant first argument to sub_vec
Date: Wed, 16 Oct 2024 12:31:35 -0700
Message-ID: <20241016193140.2206352-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Use vrsub.vi to subtract from a constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h | 1 +
 tcg/riscv/tcg-target.c.inc     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 97e6ecdb0f..d8ce5414f5 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -25,6 +25,7 @@ C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I2(v, v, v)
+C_O1_I2(v, vK, v)
 C_O1_I2(v, v, vK)
 C_O1_I2(v, v, vL)
 C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ce8d6d0293..1ce2f291d3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2350,7 +2350,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_sub_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
+        if (const_args[1]) {
+            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
+        } else {
+            tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
+        }
         break;
     case INDEX_op_and_vec:
         set_vtype_len(s, type);
@@ -2565,7 +2569,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
-        return C_O1_I2(v, v, v);
+        return C_O1_I2(v, vK, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
     case INDEX_op_cmpsel_vec:
-- 
2.43.0


