Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BB3CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4e0-0001GV-6Q; Tue, 26 Aug 2025 21:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4do-0000Ez-2X
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4di-0007dy-Ag
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-32597b88f0dso2563706a91.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256866; x=1756861666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWwJXhspeKuxTriI/PhOD7a9dZ1dleThFKCakXmp7ro=;
 b=byVT5PDjqlNacq9YrXJfXQ9XI492RacOYwZcxN4kM3d4V4Tws4qS5551E48EM/ZX63
 3DoaijiiPB6Dd3ybncTWRNpwnd8v92Cv2eyDHwbh3VioGuceqCc5/sIOPvCEeMc1wDZl
 8aJVL5HpBhbv+xN32UaH5W8i88veT/jlLwX3SIKGQvkJH1P2T9nPxDD+Bi6NVLya9nIS
 rlHbvaBc7xaGwvIt0kX6XjYbOpWgAllES06VTVeoezA8SvN7bvPu2rQiBkbkozxd3ygZ
 SWdppyKBjftqKOKurqjyEAfyoeIdC8EyUxpPBKeDTKWunGq1ZauqpgrfRmgWMOpsiliE
 2OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256866; x=1756861666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWwJXhspeKuxTriI/PhOD7a9dZ1dleThFKCakXmp7ro=;
 b=KTYVjTm4vIDFNgQtWC7MrxHPjaP08Onvl94SSlYCpo7/3CiHOeBACY1gGMHdx6u6Uq
 kf4YG8IPsk/M9i9JhlLN93LTzKbA0bZYOAy8Lxrmir1F7cjisebypQs7okyzKpkOrYYx
 GwYoAxO8W4FK2ngdc5WoWd1FtgSfZEuJyahMxLYcNJj5q0vi5/Ds04ncIL0YXNDdBZWu
 QisEyo8RbdF5bKsK62af6sRLNtyVvS0lCX3Zaa7r6//PKH1dMgA/9MecxvFUg7UyGSei
 XGOlysQhW/H2wHyAPx5ICuLl25YQ58Ke+UQMjNCuOo67Bj24sEpW/T0AkWUSZDRPCjYE
 rOYQ==
X-Gm-Message-State: AOJu0Yy7/oDNUS+mxGsBxmpfHPLi7UENu0NppsQ1XBjfcfLDVyn7Q/Zz
 PuN9v1y8UVRQXCOS7ODABxB8qqIJVCLqQeAP/vRhVylYzsXsehhh1YZpp+JM9iMjc3hbkECUzb8
 4Zpn5M34=
X-Gm-Gg: ASbGncs/BCsQzz8Z8g09c3djEPrkKa/8LsuhaZ7N9wAOfGyCsR7yMpp3pSuUz8fqf0U
 X1MBmamtnO7HJB95pqHQdzDyvgpKJSWRcxnFwqM11xMlkYbTIShPvHV6WtzgV1kM54TnRU13LJ7
 Iyl1lP1YrwfmLA9eo8N9+ZLFKYAvYFZEBt2yubwQA2QhBuGNUcDErTJV1eNwPGVZXy7tyi3Wtba
 USHJ20lqIy7iCAy3vHQQKZhSiCFPRHGDnN4lxKrkgpHUABhP6YiehMwWNsVPt/vpAl0E6u+SDjB
 cHunbMBDZP2WE1jxyZSv0S+7JTVV39sRphD9p4iFFpBuxsjWMCF8TC4VtvJ2ItjwGfhddanLHXc
 ZECRDLQsN+33dRKKHWCHc0lnsQuJtyZVGA9ok
X-Google-Smtp-Source: AGHT+IHGnflg6ro0hYLty/fZGol0Lo78iQm3YJ4VpNnKKop0imUGN/zrXAFTav4asa/EaOeVmjsuzg==
X-Received: by 2002:a17:90b:53c8:b0:323:7e82:fcd with SMTP id
 98e67ed59e1d1-32517b2bba5mr24358351a91.37.1756256865662; 
 Tue, 26 Aug 2025 18:07:45 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 32/61] target/arm: Split out redirect_cpreg
Date: Wed, 27 Aug 2025 11:04:23 +1000
Message-ID: <20250827010453.4059782-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/arm/tcg/translate-a64.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 648463f44a..8303f0dac2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2455,6 +2455,19 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
     gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
 }
 
+/*
+ * Look up @key, returning the cpreg, which must exist.
+ * Additionally, the new cpreg must also be accessible.
+ */
+static const ARMCPRegInfo *
+redirect_cpreg(DisasContext *s, uint32_t key, bool isread)
+{
+    const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
+    assert(ri);
+    assert(cp_access_ok(s->current_el, ri, isread));
+    return ri;
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2603,9 +2616,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * fine-grained-traps on EL1 also do not apply here.
          */
         key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
-        ri = get_arm_cp_reginfo(s->cp_regs, key);
-        assert(ri);
-        assert(cp_access_ok(s->current_el, ri, isread));
+        ri = redirect_cpreg(s, key, isread);
         /*
          * We might not have done an update_pc earlier, so check we don't
          * need it. We could support this in future if necessary.
-- 
2.43.0


