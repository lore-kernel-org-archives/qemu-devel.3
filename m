Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96848C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb75-0007BB-Gs; Mon, 29 Jan 2024 18:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6g-0006BQ-DF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:09 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6e-0005BT-8f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d7393de183so15236855ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571119; x=1707175919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgwxZ+7gYByz1ukIozRlYZNVczP1+9iCeAmnhFmDKhE=;
 b=WhsdKq738X8cuF0MVSD6Sk+GSiR5qckCgRfnFzFormDAWg6B3sjEEPsyZGLWUy+hKj
 QLrgJkkO8FK/hoe7JM8o/PcmQJGa2P4Z2MFOoq7oqPc41Mbj8ejPd5ocYAH2IzbNWRuj
 ofbFsfiJbiUlkn5p5jHsjoArJHSQeYrffYOqpWDjGQspFOg8HCXIgHXirpVkF2qyBcZm
 lysMOiTp1o8O58qqL0wzhcJMaWT9J9NsfwMURLXEiUhGMgtnN6EN7SXTTAYAt3+Sr+kA
 Cz59ZwwyJzJ7L7+2BK5lnBLDnYt+So2HOBHQsw21mQFzDWTx4P+RkBtDXk5PgFEZPpA5
 2zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571119; x=1707175919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgwxZ+7gYByz1ukIozRlYZNVczP1+9iCeAmnhFmDKhE=;
 b=RWZ/7ANXDuOoYPwd7V0+u/RTEQrSXrHWtrvlBwVqnXuWbKRYMdnRWs8nur65U7WCxT
 4+SY71G5o8GjbPQBEn2VFW7Dqvm7XIiVlWDPj+mBQICDhcI4eF4eC+8qzNgcaBK2eUZM
 5AAyqiHUYx4H6ynTRc+8ISbPxBdDRWjDeGzfboz7Xynr+VU3v3F8jzlUd3CDtYIA13oj
 Qeg1bKpG6d9ASYRXeXp0tSvEt38d6o8X56lHXjHhC+RLOIsIdugPxtlL9pe5y5Y52hEy
 sAPva2WbNOARGkUe3h4QuHX9rHdSodWQQOIXt06Lc0iyR8vq545fPPWO491dhrZqoYS/
 mpDQ==
X-Gm-Message-State: AOJu0YxFBlSmbOEP/R9KcMNK1j6dw/Mw3hGXmKFXGGQoc9PxKZ3jREwi
 7lcGNgL2D20eVyYjV2qrCyxY7q+VZpcYp/yncvq+8VWhwsi6kIrvNpwIMH8g+LkOUzW7phP591c
 9dQ8=
X-Google-Smtp-Source: AGHT+IH88gzlwmP3zEpvFx2u6Nc5G3cPUR0cntO3vMp616r3xWyP117B3A5XYG3l2V1vwGOQ4mdsPg==
X-Received: by 2002:a17:903:230a:b0:1d7:3121:ffd1 with SMTP id
 d10-20020a170903230a00b001d73121ffd1mr4385544plh.13.1706571119112; 
 Mon, 29 Jan 2024 15:31:59 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 31/33] target/xtensa: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:41 +1000
Message-Id: <20240129233043.34558-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/xtensa/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 62020b1f33..79f91819df 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -74,6 +74,11 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #endif
 }
 
+static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return xtensa_get_cring(cpu_env(cs));
+}
+
 #ifdef CONFIG_USER_ONLY
 static bool abi_call0;
 
@@ -252,6 +257,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work = xtensa_cpu_has_work;
+    cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
-- 
2.34.1


