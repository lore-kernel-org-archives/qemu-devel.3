Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A79CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJu-0002b4-Vq; Tue, 14 Oct 2025 16:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJZ-0002Ig-B1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ2-0005Me-Ji
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-27c369f898fso82858915ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472452; x=1761077252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRaxPSO4dMwTU7bjid4OQ5BAEwqmP9lcBzf0KnY7hNw=;
 b=TXT0UBMzoQikr/wZqxmK5Jc2b21TgbIpy1MPOLD8mXmA726t/rIclYjxpUyVjKkHnl
 iOxIBh+sSc4wi0pNys11M9pvoRhDnhPQqIjpnUMJ1vpCoES2d+BXpCgHN7aE6NRC7EHY
 WAosxUN9rY8noV4Wq9f1ikVEUUNX7W2kKalCZlBg6vnPAJDar7RGZDovWhjMNriiyB71
 4ZUpo8mjoi3kpw8e0do3PNpBJb4CXx9uFSAyBgHwVccutwGZS9a8/0LDRuS8fX/+lNyo
 CczkbnO/V43cDN+gOI04Rk59Hfwt4TSEtJH4iSagRwqZWhHtpL+DRlOgxF4fqe4B5iG7
 docQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472452; x=1761077252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRaxPSO4dMwTU7bjid4OQ5BAEwqmP9lcBzf0KnY7hNw=;
 b=BTpkIGshJvG4R8XukaZegOO3rWdF4uUbrbr5UfXhz9y/iGOxoLxATBwQMnlu9vT7Lc
 Dvhe1IgB/6O+mpEWd1sKsxk7qP0fJhTl8wq6OKB8KRAkB/8ttxUjsk1nslncl07ezs2t
 cXv2WdtlZtNPT3hEqgG0D4/u5iCHhOrDNYUpftDV5djEm+tlmBzY3sNztEhy4ZHET8LK
 3Nf7+oIc3gyiz32UehObVeR4fyIjjS5weKdd0gmjbVc3kU5mRTaMeghn4nWjIM17w1+X
 /Nh64VrCEB/xZuQoPWoe0Ucf+vEBB4mEBDcdGw1LBauv8iXvDnGjCQ81OuH5W2/D2qFm
 GoeQ==
X-Gm-Message-State: AOJu0Ywox8t+odYMrHb4V77JmdXnc2lVpCRj+Pt1O03jaawcQtrLTLbR
 v8rjpC7btQ5vG+y4Nr+v0M5X/cv4dpOeFBpL04Q+9/xXwJ9M7ekJ+DAMtpcGnhwiXyU+jwP6xE2
 yq89l18M=
X-Gm-Gg: ASbGncsY+7Vey1Aeavl3uD0bj+ns92r2zm6r4GqqSmsmLr0yTJLX49IXTmTxfwXNhqJ
 HLKPqB9jPNUHibEy97JRskPDHeOiCkN4XTvV41DOd3+AIM2PsGgSDptsI1GrWyLf81HmxUFBesl
 XKDSAzRGiuKwXh4k7c5cTvS/U5wGeIvpReK8jq+rOhx3nO3nmq5MsTJG5adotYd55uj5DXkkE/y
 PEfsqV1FG/pbR8cGa8aVY+EmfkfPIeVPdoPoPvgwe8HuWgZ/duQl8a+xukT1FQpsvvemNQoBUv1
 URY1hduLDxh6rGX19zkPlAKNkfSGGG63gCh14AlmEbuJlvlRxXBSR6q1CoZl4oAz111yQSnENgy
 ywScUnjVd+MbfNV7AMBU6YLdwqdxVPXZz0i3p+V0tvrXZKra6/Qw=
X-Google-Smtp-Source: AGHT+IEK9RR5sH8HJh2tDFhiar/aojYHHVRrKRHfotWTPFS1+LRx8AZwiu/DbcX5pJgV7hbxk/+eeQ==
X-Received: by 2002:a17:902:e784:b0:24b:270e:56c7 with SMTP id
 d9443c01a7336-290272155cdmr351352835ad.7.1760472452206; 
 Tue, 14 Oct 2025 13:07:32 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 18/37] target/arm: Introduce helper_{get,set}_cp_reg128
Date: Tue, 14 Oct 2025 13:06:59 -0700
Message-ID: <20251014200718.422022-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
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

Helper functions to invoke the write128fn and read128fn
methods of ARMCPRegInfo.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h    |  2 ++
 target/arm/tcg/op_helper.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 4636d1bc03..45bb87fbaf 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -90,6 +90,8 @@ DEF_HELPER_3(set_cp_reg, void, env, cptr, i32)
 DEF_HELPER_2(get_cp_reg, i32, env, cptr)
 DEF_HELPER_3(set_cp_reg64, void, env, cptr, i64)
 DEF_HELPER_2(get_cp_reg64, i64, env, cptr)
+DEF_HELPER_4(set_cp_reg128, void, env, cptr, i64, i64)
+DEF_HELPER_2(get_cp_reg128, i128, env, cptr)
 
 DEF_HELPER_2(get_r13_banked, i32, env, i32)
 DEF_HELPER_3(set_r13_banked, void, env, i32, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4fbd219555..9c7b18fe65 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1026,6 +1026,35 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, const void *rip)
     return res;
 }
 
+void HELPER(set_cp_reg128)(CPUARMState *env, const void *rip,
+                           uint64_t valuelo, uint64_t valuehi)
+{
+    const ARMCPRegInfo *ri = rip;
+
+    if (ri->type & ARM_CP_IO) {
+        bql_lock();
+        ri->write128fn(env, ri, valuelo, valuehi);
+        bql_unlock();
+    } else {
+        ri->write128fn(env, ri, valuelo, valuehi);
+    }
+}
+
+Int128 HELPER(get_cp_reg128)(CPUARMState *env, const void *rip)
+{
+    const ARMCPRegInfo *ri = rip;
+    Int128 res;
+
+    if (ri->type & ARM_CP_IO) {
+        bql_lock();
+        res = ri->read128fn(env, ri);
+        bql_unlock();
+    } else {
+        res = ri->read128fn(env, ri);
+    }
+    return res;
+}
+
 void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
-- 
2.43.0


