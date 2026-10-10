Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B12CCA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFRDb-0001hz-IX; Sat, 10 Oct 2026 03:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDT-0001bf-Eg
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:10:00 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDR-0001B2-4O
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:09:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso255469f8f.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791616195; x=1792220995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6z90lw1XaEosdcXqk+KR1eAhu30BjyibiuTA1LqnWCE=;
 b=lH57ZXCopeyy4HmJFS3WeyeDnH3vIdOO05fYpZ2LFH000euDS7J0PNdvxfDYGp+Hcj
 vkjINT+6X5vVSpBtyn6Gu3pKwc3rlSdxqgKLWvwM90TX+vYBeLfHOHYUZa4ZNNXvmHL8
 JaXjekRBKNLGtBtHgIfrhK8PJxB3bjnfeyn8tcWqajULpSCommQtb3K3GJdASISkkqr+
 nEkVZn52gtnsR5n7mmz30jTnsw2PZZKlNrLjUfB26hjSdj622RpS5N7yJ2zis7xrDi2o
 TtN6fNCv2tyd1m43lG1zGiz5hx/37JQ5gXAn0chniSvKLU3B6KCNuWiytGlNS9L9lI0I
 241Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791616195; x=1792220995;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6z90lw1XaEosdcXqk+KR1eAhu30BjyibiuTA1LqnWCE=;
 b=KVMrUzgaNVDkB23uaL7f7cPjVaUoVC7yG4NU1zTDdjGZz024d32QDraZOXkHXvUqy6
 7oOAQqThD2ngJzp/46mvYZ+eOiRXm5AGnpZZ53u58F5w+eFwA5ahgy+QMmaaYBsTLnFW
 H5Q9q2MGfwaUnczmmQuAV58243yrf2Q6ewCC8BXlHFC9GcxftJsDcSdaaOw5BD6aP+Qg
 5dVS0Y++1gop1uVFK5T/n01SGkR0igFyQqxjrUBtLqjuzRcMDD5nybAv2Qo/CkrgqwbG
 iMAS/4HpdGdtzW5JhoE8YTuTLlT9s+M4qGlFmkZ9YujspbaqhepWidwokugEkoH3JNQR
 Ez8Q==
X-Gm-Message-State: AFq9FYKvadb/6agxQMCB4qGSZ1ygRUJfgOqqjW5Z0fk8Ya8NynYxrQON
 CjW2UDGle3wjh4UBlYwN/L4FNJsbWUn3Qj8rTqjT/7o+G4JcqYt8wbbln+a0U1Ier14tKiFhnjR
 1+oK/VNw=
X-Gm-Gg: AYBFou2uUHsUl59nP8CZ1S7pBg7IQG1mbF66wQfgirkm/YS3ERH9Gej7rGww1l5B8Sc
 78TTsPBcCXMonmPmv2WOWkuzESITgistdNdE91cSzdHohSS+FZvfmoZBV+nWNPDhXmgGoKMauET
 k9LTZN+rS8vxkU67BO3ErivkwDQD7VeCJE3yqdoqyDps7WFfgJGHuwcBdMUSP9TNHgp+kzIbmYP
 2hflOaYUSUqrf5BcSs9Vjd6lLIWISZsmX8biyeEOf/7qf/hN2u96GZtY+b340yviEKAWX3+GAej
 NUnGj5uP3BYYDQ6QJiM4u0DNMeeXKN4DUI/d0oxGM0/wKGUQYh854lBXZSgHksDiUo1PcVaL28E
 J9Pm90vOddJ6f2dXuPxl26MFY360luQV0fFxQotdldiK0FIjEItLUQdriKRLgVhkoLeprNbehBB
 N5hcosigstejkTV3nzqVJhQxkVBhyeLzt4XVSc2mmokrr3tJXU5+ZRhTZV8rlBrruW+QSV4Bc8+
 uO4/ii91Mh7YfTveIFghg==
X-Received: by 2002:a05:6000:2505:b0:48b:123e:2f60 with SMTP id
 ffacd0b85a97d-48dbace0bb1mr7759353f8f.39.1791616195336; 
 Sat, 10 Oct 2026 00:09:55 -0700 (PDT)
Received: from stoup.local ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm7662252f8f.36.2026.10.10.00.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 00:09:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 1/6] target/arm: Rename isar_feature_aa64_idst
Date: Sat, 10 Oct 2026 09:09:47 +0200
Message-ID: <20261010070952.323466-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010070952.323466-1-richard.henderson@linaro.org>
References: <20261010070952.323466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename from isar_feature_aa64_ids to match the feature name: FEAT_IDST.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a9eebb45564..2fc1bf02cbe 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1403,7 +1403,7 @@ static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, FWB) != 0;
 }
 
-static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_idst(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index af56eff9f18..6a673e5ae6e 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1136,7 +1136,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         break;
     case CP_ACCESS_UNDEFINED:
         /* CP_ACCESS_UNDEFINED is never direct to a specified EL */
-        if (cpu_isar_feature(aa64_ids, cpu) && isread &&
+        if (cpu_isar_feature(aa64_idst, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
              * FEAT_IDST says this should be reported as EC_SYSTEMREGISTERTRAP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d5b11e2da9..0c712e7ac2e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2675,7 +2675,7 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
      */
     uint32_t syndrome;
 
-    if (isread && dc_isar_feature(aa64_ids, s) &&
+    if (isread && dc_isar_feature(aa64_idst, s) &&
         arm_cpreg_encoding_in_idspace(op0, op1, op2, crn, crm)) {
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
     } else {
-- 
2.53.0


