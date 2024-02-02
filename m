Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678CBC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSu-0001qU-I0; Fri, 02 Feb 2024 00:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSr-0001cb-Ch
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSl-00020W-Hu
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d7005ea1d0so316895a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853100; x=1707457900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2JMKKfNQPfNPstuhrU0oB7wgUlx1W4ZgVufmLvBqo8=;
 b=R2FDXTolRBD7lsNODVHIyGVDORnQNDLv0ZYIpHg2hc/sURMRCfbHj/xPgaHps+3BeN
 L/A1620MtN10mM2/lsmSu9ZaZbF01+twpAfVD3yc2bK+WA6svDpCedO8NcFHK1G/O5PF
 R4pRHW6p/b87zVU4SK7emmrSezcJmBM8CzKLwtPEieDm1OWiSSDZlk/cezv2CA9SI3tp
 tHcKsh97qrLLwYc4VaStwwvKFpeLub9elaNCuNC3VauibK358IMxIEqbgk7RM8URdb2X
 T9JRZFq879/FQYzexuW2tyRc+mvZWasKRj/InpjlsLsw8lF1GBMAs8wtTi3LZdCJAKAv
 tJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853100; x=1707457900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2JMKKfNQPfNPstuhrU0oB7wgUlx1W4ZgVufmLvBqo8=;
 b=QSohyZpgsDqWpwlGUnlp38/bEkwJr1AY3o1AGh6NFjp0hg9a2cWUOUEQucPcm/uZxq
 KlDcoPOEtBdJRONCMpSjb0z3vcLWTL87zgp3klTO3zhy7b75nxw6Lia33LlTH2Td/WVl
 uLu0pUo9Qvvc58CUPFGQVnJOCoqP6cC2EKVIbmxZXO0oAVTtUoe6c0S/V6f8U2oTXup6
 VSDB6J0VfzsKPyyasW5rJVG7IsQ8Uf0yImTlXGyt2JKsY53HhUnYottuGcl3r3cy2JAi
 jtEiUTpIkw/N9wqQf7fqHnYCOQRm6QxDMLiOD4HxaM5gJp537ZRx5bnqNxzjYkHdB0bK
 P98A==
X-Gm-Message-State: AOJu0YzkOZ8bKVc3U1JSZ1J2x9YDjo88v+gSMHXO7SKR/jXmvO7s3Pub
 nGMmjZD3byspMPpWkm7DGt6ZIneWbd4Bk686xLMF3lIpwySkSvsavr+hHeg95QoY1XO/EaTLp00
 aujg=
X-Google-Smtp-Source: AGHT+IHsVg/uUkpNSY3DhIsei/pVR1kS1Cl813WGodYJrYq0nH8oQKLC3eJO7QTdgtuZvp8T8FsVUA==
X-Received: by 2002:a05:6a20:401f:b0:19c:accf:b669 with SMTP id
 z31-20020a056a20401f00b0019caccfb669mr1659311pze.26.1706853099879; 
 Thu, 01 Feb 2024 21:51:39 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/57] target/s390x: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:06 +1000
Message-Id: <20240202055036.684176-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


