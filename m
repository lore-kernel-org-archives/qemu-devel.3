Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508F7C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6y-0006RM-Hr; Mon, 29 Jan 2024 18:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6X-000616-7I
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:56 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6V-0005AR-Ay
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:52 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d7858a469aso17979495ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571110; x=1707175910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qf+wyN5J4o2IlILveqXJ48lvGZmT4w00Bti8er4chv4=;
 b=xFCqZCV6lKvMyyf4v1iDiX2uy5qvLW2xpXUlpdradZLSMCfyura/m2ihRtasXtCJSF
 0kdyKl0yet0Eo/yXuUlzgeBfWLasJdbDIvDk1tUd/wAZAXE1WFicNtgcfTwTHEdnCR0i
 osHLEzPhyxmxxpB0hvQY5BzulmYDwwnNRC9Z+hLJvJwzs3LgHt56xAj9IceZEHOzLf7V
 I1+UpTJY7piGKia9ot8A+WQcUdg58p8JmW8rVs/E2BqggkuJ0vl9GCS/BKo9JODVFRE+
 lzqNDzTQtctz1UTRVqeMmAx6Rnby47/hPPZ2V28pd4gf5T0HaEpZaAZaXieiLK7HzXa6
 l15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571110; x=1707175910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qf+wyN5J4o2IlILveqXJ48lvGZmT4w00Bti8er4chv4=;
 b=Apwo5318h0fHlK5uIeUaY2ZDhFzg0cKJaknrhymtlYx3oF/NhCSiH35Ml6zHafnPy4
 t0/JnmNapRF28Ns2TFX2RIoCPYJ6Fg9NjUBg2nXVutkUfp6dCnx+OxrOOiN8IWuSp5Sr
 liTGVtU4HfCMudjA+XiwFk4lxw9hVmCzO8Z0xQaUQ4X2B5D4j1CAK/HHTsa9xqFXA/lo
 lAPUsFUAdab0MnJY+SpJlZAjgtm9h9vP1Wi3J2Db909d1w9bZ7DUfTRDi974uTn/4dWp
 0gdkqsIEWSwfzsd6vEXJWvri2qSTyMX1qDbxXhz9hZ1aXFYurvvYEvmQReuceyeHEbs/
 On1Q==
X-Gm-Message-State: AOJu0YyIV1Rr74LK/U+Xx9MIOtDA2FkuOeIfQHAkGmBby2eGRVgSAQlH
 qoUQiZIpdJKHLe8ssIyruhsqq84Hw9g3ojHnmKBsAck0/fxnGe+OcsjFfwvs3LUskXuFybRsNBE
 sRbA=
X-Google-Smtp-Source: AGHT+IEESU7GSsdJsPn0N2JKg/IIvAKlC32hpaD4ilS3NkZisM7LcwynTdjcrcQPIgbBdU3HpbnNZg==
X-Received: by 2002:a17:902:e845:b0:1d7:5d88:f9a6 with SMTP id
 t5-20020a170902e84500b001d75d88f9a6mr4079468plg.50.1706571109803; 
 Mon, 29 Jan 2024 15:31:49 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 27/33] target/s390x: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:37 +1000
Message-Id: <20240129233043.34558-28-richard.henderson@linaro.org>
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
 target/s390x/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7f123863dc..49a2341acc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -142,6 +142,11 @@ static bool s390_cpu_has_work(CPUState *cs)
     return s390_cpu_has_int(cpu);
 }
 
+static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return s390x_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 {
     S390CPU *s390_cpu = S390_CPU(cpu);
@@ -352,6 +357,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     scc->reset = s390_cpu_reset;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
+    cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
     cc->set_pc = s390_cpu_set_pc;
-- 
2.34.1


