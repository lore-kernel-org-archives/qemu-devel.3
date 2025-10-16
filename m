Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2646CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0b-0008Dc-FI; Thu, 16 Oct 2025 08:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyX-0005Ae-OE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyI-0000Qe-QO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso7643445e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617240; x=1761222040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Rl3dz6Wv7naCqZaM6ykMiA9Vef988oy/ygzHOFB8Ek=;
 b=I/vR6wlU/MfQpK8PqDFWTFN7x1lRV/+nyJdra7jYnhAL2jHVUK3YNI8/9M3VSrMpKv
 3YJosk52kMd6GlXrJS6bemAmik1xhcjCy0Yp+nyEUaAMh9Er54jY9b7JFzH6NNR5cyEq
 CFkJ66brmCCXd8gDPwMGdV5NhB7CLNE9RLe0DLd5gDKdmYj/TqV4FWeBpZdLzkpRcXh9
 JU7PTvXw1TZsE0q2FLnN9XBCEgvda3oWk1ymDGJUOXZu4oXOKgfzi3yeggKa/6DERrJg
 P5vCeDsV0gTn5FVsyi2hrVdY/dlluXEwh8jJJTHqNen096FtLoMYVco4w6UYVjGFsyw+
 RQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617240; x=1761222040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Rl3dz6Wv7naCqZaM6ykMiA9Vef988oy/ygzHOFB8Ek=;
 b=lBiCbCBTRDYTIX7PFt4Dmqgz9WlScnjUQWjvb6mAtqOK8qjow3dOYyHdHst7eoMTf4
 ROfs9uZuyVHzeqbyS2v11QctcJXptzg6mxVIttZ4/gtd8SfnqSiH92VYdVfTcvstbmYz
 iZ1/DdWnI+A0rlR4UgWvzsbolSsGxPm7e50Dk6ozchTt9XVoOb6SQec8qTufxOT44846
 u6WE8RI2K+CA1lFeR9gGCBIPKS/FTkDjN/YowDc2DmahTx2PwfHCU2ptGqzIpUz65v9J
 VNwqVUnLTmz8s21dVjiskWliWXyJAkIsu9mJfR3Z0sxscuzA0ZovZ9J12Kz//BREmigS
 tMMQ==
X-Gm-Message-State: AOJu0Yy3GmYnDXxdW4bJCGZLrMXa4B44VsrRPGl3IrKPwKuF5mEIaoyd
 0nZ4ViiyCvDYO8Xr4nGM4A68AJWadQtM3REt2mQgMw/Z/J3CG3ifeVo5iRMwElCULZDCJ0fBrCy
 FwO8rhCo=
X-Gm-Gg: ASbGncuXX+CJ6mRyKURcBWuqM1JKi/BSCtqHaJt7CUkgkUbQ4joyDSEGv6cPmcuF6K0
 Cq8RBgzLt6t/MW4fp7qUC3FHy4S9ZJrBHiIKdMAzUfpr7Qxv/G6aE6zzFedEV+RU8eTe4+LYykT
 R/GjAgkO+zKnMOG6chLuLN4t78CoKkvsYkZvMJm6gmNEvMHR9NQNHu095+dL5jhcmXbxnHGucWk
 LpjIT69YwD+s8zXfsFcjeA0d913a83AxyqurxERXvm8Lh0kF+UEwBE/oKhJX7DsqJHEAhGeaHr6
 Ct1PxXomtSedk95tWPT/tWIr+gH0KAgkHFqan2fK7loSNovJR6lxboiYavy5CwqMUMBF0wZTTue
 pJEBsZlXuug1fyzzp0atXdJ+IXmloaB/7Z2OkrntRbswPL7d/2OKom0EeMaghjwlkYy25lUais8
 kRG6pYv0oWqYZxo8i21plY76bNUhYAnOo8lq0MXajO70u74JzhcCG2V2RijokE+Kad
X-Google-Smtp-Source: AGHT+IE5YZASLXuTIIK8l8Bit6Jh5rxmWgd/ouBjyPzrtVjefnPCWexQgqqxeq07q0vjpdb8fjxRvw==
X-Received: by 2002:a05:6000:604:b0:408:9c48:e26c with SMTP id
 ffacd0b85a97d-4266e8e0b99mr20542479f8f.62.1760617239946; 
 Thu, 16 Oct 2025 05:20:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm35272387f8f.1.2025.10.16.05.20.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/75] target/tricore: Inline tcg_gen_ld32u_tl()
Date: Thu, 16 Oct 2025 14:15:22 +0200
Message-ID: <20251016121532.14042-67-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The TriCore target is only built as 32-bit, so tcg_gen_ld32u_tl()
expands to tcg_gen_ld_i32(). Use the latter to simplify the next
commit mechanical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-9-philmd@linaro.org>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 112a1b9a12e..2cfd2e5b8df 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7959,7 +7959,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
             tmp = tcg_temp_new();
             l1 = gen_new_label();
 
-            tcg_gen_ld32u_tl(tmp, tcg_env, offsetof(CPUTriCoreState, DBGSR));
+            tcg_gen_ld_i32(tmp, tcg_env, offsetof(CPUTriCoreState, DBGSR));
             tcg_gen_andi_tl(tmp, tmp, MASK_DBGSR_DE);
             tcg_gen_brcondi_tl(TCG_COND_NE, tmp, 1, l1);
             gen_helper_rfm(tcg_env);
-- 
2.51.0


