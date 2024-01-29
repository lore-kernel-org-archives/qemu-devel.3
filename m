Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9710C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6D-0005qU-Hp; Mon, 29 Jan 2024 18:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb69-0005ll-V8
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb68-000561-Bj
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:29 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d8ef972451so6312775ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571087; x=1707175887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6rIUVmiCr2QYJOV/5BC5dQis1VA2kzsAKeuwEUc9C4=;
 b=ZfNd6T1jpdTRlXn2WntN3L60w9JklpPPdWBlBjCm5L94DcfjHABBKp26Tz5yMBpJlP
 6AoXAwvq7B+3NoBPjGotAvp2AzijY55j7YS3QBxOoLUNdpRj7n7kDu0Qe+fG0yal94eC
 I2Ar1AKANkYVcA83C6qSY638WwhbkHrnrHt5JyBsHd4eS0ktFqmJsaHOS864lT1mjMlp
 58Bbj+f+GVT972zKG4P/7BJbvRpJlLAHwe2zU7XYaDIY+1fp7O3spRypSoE0BblnnSk4
 inyE4K1MRYOpUimuZ6vOXfq+R+Vh2dtzTZpmLZGH0FICgA6R0TRB4TJ/O4NXC2Cns8X5
 UbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571087; x=1707175887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6rIUVmiCr2QYJOV/5BC5dQis1VA2kzsAKeuwEUc9C4=;
 b=Rirh/Hvval5lo8ETXGFJ8VCfARGNyCttQHVoV+VVe7stwYglhK5RetMkL4g+ql07Br
 aJ2iOs/eryNoDkR7Qapv5AirPTe9yhM9VT9A8Q1Mbz0PzhZuhrHuui3/3dmr9dzpprM1
 y3+n+s0wBFplEA1AOHSDTnAo5dZaCK8ZHOQFzxXYiWlyl8DycWruzRQROyiAa3ao5ggG
 0xBTR5WXC0fakWaokAvGt9QCYs/xoown8q5PiuQ9Q9lP6r1BjK/dqwdaQu+ahnjiCpV+
 q20lTCLVdyQthnp4gUEIrw/VguS3hhfYyGWs1VUkPlqfubl7pso6OpfZEDWatoQWiJDj
 oGOw==
X-Gm-Message-State: AOJu0YxTtUxfqFvLEbXQVrr9gzl5zE6bol2jQfhyP4/ALARqTKAnEZaf
 /vrGWUDWSe3Ob2jimQC+PrlOJEts+D3Escl5Nlk87eWnpUgmGkicbGa9iRGft/3gC+YA0rK+mBE
 ur/g=
X-Google-Smtp-Source: AGHT+IHUSfkkN9KgUeYMQmd5SAu6t/MoP0bLGRUnDfEOxFGo6yWeCEtmfTFACEyh7eNqIFcJ/30UNw==
X-Received: by 2002:a17:902:d4d0:b0:1d3:45c8:bc0f with SMTP id
 o16-20020a170902d4d000b001d345c8bc0fmr4325004plg.46.1706571087108; 
 Mon, 29 Jan 2024 15:31:27 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 17/33] target/mips: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:27 +1000
Message-Id: <20240129233043.34558-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/mips/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index df544ab39b..d644adbc77 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -182,6 +182,11 @@ static bool mips_cpu_has_work(CPUState *cs)
     return has_work;
 }
 
+static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
+{
+    return mips_env_mmu_index(cpu_env(cs));
+}
+
 #include "cpu-defs.c.inc"
 
 static void mips_cpu_reset_hold(Object *obj)
@@ -579,6 +584,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
+    cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
-- 
2.34.1


