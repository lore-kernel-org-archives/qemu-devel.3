Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFBC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0f-0007Cm-FR; Fri, 25 Apr 2025 17:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0d-0007CJ-Og
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:54:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0b-0000I6-Pe
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:54:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2753618b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618096; x=1746222896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3uRu+kpkguZ1n+Vfu42Yz2M9RXna5xodr+32+5gywo=;
 b=VQmClUtVdBKSuchIAiTVkYuEcjo2hP6XIMP/4gal96Yba57vuZMO+56Dwol+vt+DRc
 lKsudZ6t/U2BE4QgqimFpHI6AtUFEQBOQzWGe65hkFSYkFeGMgX3zUC9kQcAQ7Yao7Nt
 iHujEaTDqgUQlMbO5xkF5n/TsXOUyGEQ07vqhkIYQPYkgociAvgXKXExcDb+hQ3MUdVt
 mzXPT/XuSmAxk4av6DhctfQV3Mgdp9r3myBXfZAJYOTA/8iQ/j7lv8sZh6/N+xIG0yPh
 9rXfTlOFXuKgD1v69X/DxUVb3+3jUVxoVmMtceJ0Z8QiBGIpe7Q+jWrgLbrBHvG3mYiX
 w3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618096; x=1746222896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3uRu+kpkguZ1n+Vfu42Yz2M9RXna5xodr+32+5gywo=;
 b=S8qFhEKT/V194ayOmg0iaYL6o3Eg57E06+W1JV5SDorEfucmnYo/xIWxYCvzjpcR+b
 qzB3OvR7PXALyTy/ml6YHLp/eGgC1fsnzMmoPEKx+V/7To6K1HIIO5YZi52mqiB4NsDH
 IlbMKaz61YQOgMKISeP4bfTObVWSWEHVojadlB3h5LaC1/9aPg1O81gAGGlmcZjiohnb
 a+zH58Yvdv0Kpsndnk4qxhn7dO9BMJUlJvEsKKLdV9bSI9pgCVShnduPorU60ADwrJXO
 psN1akloridkW+vFkmfz18hE/i5Id9KnO09f1el/4vBva8ttF5TITTzwlQtIfXQfsthi
 tiqg==
X-Gm-Message-State: AOJu0Yw+2cbotoEEiP1Qz2EszOUTsndSlakYZk7QvOkTM5OlVayoOy82
 gGO9RvmnmhdmdLML8B2a+JZvgDLdD94q+jjSSyna8Ojyz/D04h+YlE01CoRM6wsYUPPwWdCJvSn
 /
X-Gm-Gg: ASbGnctDrmVphyYeDus8aMYyatJ/ftBMu7ZGWsO+XUiJG1nQPdllFbB6YoiVRWLUq7I
 IiTG0b+g5DhFcH+np7Cq7NbBxL07iu7LRZejNLo7hv28435pUanj7+3cO+ggigLgT/FowWB6ISs
 t7c3ubQQxRtWC/tjIpfKF+rR54xvBTG6RPH/wflnDCQzq6HgkWE7BpMWJHYNDsmK7Ok8IAO3ZFJ
 0Fj5ju9HKuQthpR7pMPWoQ647UQdiky+gMlcHU3HpW9vwwBlpPbfjkCcEQnrFA4TaV+/FY+Smmm
 VJ1vNzdRCcOd5OHADM9SqkS09/WGgVkE+RpNNiRqGLYox5zAN7PUp75bnp5Zoi1Vyde/fD95L3+
 Id7zEUY8hZw==
X-Google-Smtp-Source: AGHT+IEJxsMv9z58vomNmAvWrCWu11NmsyMAp5+qlshkMP4Y6iO57OCAJaUiVAKTlmCDjU8YGJpgpg==
X-Received: by 2002:a05:6a00:179e:b0:736:476b:fcd3 with SMTP id
 d2e1a72fcca58-73fd9145c92mr6246199b3a.24.1745618095741; 
 Fri, 25 Apr 2025 14:54:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 001/159] tcg/loongarch64: Fix vec_val computation in
 tcg_target_const_match
Date: Fri, 25 Apr 2025 14:52:15 -0700
Message-ID: <20250425215454.886111-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Only use vece for a vector constant.  This avoids an assertion
failure in sextract64 when vece contains garbage.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cbd7642b58..740b7c264d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -211,12 +211,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
-    int64_t vec_val = sextract64(val, 0, 8 << vece);
-    if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
-        return true;
-    }
-    if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
-        return true;
+    if (ct & (TCG_CT_CONST_VCMP | TCG_CT_CONST_VADD)) {
+        int64_t vec_val = sextract64(val, 0, 8 << vece);
+        if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
+            return true;
+        }
+        if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
+            return true;
+        }
     }
     return false;
 }
-- 
2.43.0


