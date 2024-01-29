Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F11C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb73-0006zd-Dw; Mon, 29 Jan 2024 18:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6f-0006BP-PN
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:09 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6d-0005BB-BJ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:01 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso3012380a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571116; x=1707175916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1GkbX/2RhRtI6NxAEXwoMhTS8WkrOI/cziGDkYfcrg=;
 b=vZJ3YOQQoepBeeuY41GiScFHKMLk6jXnROrxMH6JRgBTBTHxElDxkP3Q1obnwnUA0z
 t+mMDDTVGXt8M01E1W7qtK3WD3fSYRouPWJPJnAUF+44Fue8PyGg23Zkikktm2vnwb4W
 DylN1bMnaB5AtX02POFvqt1H6ADi5DYWme0WHmsfcdO97oIjPJWp4YrkEYNle4aqDsee
 QPcf4UrPhBCZZ9TQ00mwCx+/SF9Yfg32ddDth1syC0Qwop3bdFbHbdOj84FUh5zDDloZ
 GRZAp89XBj6nWZAA1HZLTW/pPgCu06NLPLUqZJaYrKXuc7ZQVhbE0+ZOn70qPhXmoX7c
 Ofyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571116; x=1707175916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1GkbX/2RhRtI6NxAEXwoMhTS8WkrOI/cziGDkYfcrg=;
 b=LgrYf+Gg4mvyEwHTjiogC4wt0aiUIlkyefdm15c1/yyQvu2NA5FnvlGGIaL3Vd56Vh
 H0hhHrnCTD/F+hnVvCXJwl1dEgD+/D4w0B8HZUS6QIAiOOSqcne96ykLunQZzZZ6mQv+
 GBZdRTr9zZFoZteylM0y8o4TS2gqZbSV8bs4XOr4jf/p9G8SpfU8EAh2JgkFd93TWGWK
 eBMp4Gy3Lw7sKFXefp9FvcMRqTNLvseZ8cJRLavf1Bz8MFHNLhKzZIOf9PbVNPT82hw/
 wGH/jGi5PBdfDh4AvqpV49MU1LnFji/nVHSqTJ5psJ4gTbdliO2KlwUsQkbSG87FDAuS
 eb8Q==
X-Gm-Message-State: AOJu0Yxqdte23aZRQpIgRgz2lqjlcjMC6uJGVmcp8g0GOCIfNeTLu//j
 vQoSGnkVo4NB6DLjuyRsQJ/lhBji6QKiz1wSOibQ/m+SnG/SQhbeRwdnAUbeXfwSbSVHJxaLhhK
 wfrs=
X-Google-Smtp-Source: AGHT+IE31FJGlfUU9Nw7XFRrnKwP/EuZ0pnortjIoE765F7Q95+6oxd+2dnIiF2s4yy4jG1CmRh03w==
X-Received: by 2002:a05:6a20:c108:b0:19c:b3e7:ed7d with SMTP id
 bh8-20020a056a20c10800b0019cb3e7ed7dmr1622712pzb.30.1706571116633; 
 Mon, 29 Jan 2024 15:31:56 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 30/33] target/tricore: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:40 +1000
Message-Id: <20240129233043.34558-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 target/tricore/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e6d91c74b5..74e8a22b86 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -89,6 +89,11 @@ static bool tricore_cpu_has_work(CPUState *cs)
     return true;
 }
 
+static int tricore_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return 0;
+}
+
 static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -194,6 +199,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
     cc->has_work = tricore_cpu_has_work;
+    cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
-- 
2.34.1


