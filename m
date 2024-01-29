Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780E0C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6M-0005wN-AQ; Mon, 29 Jan 2024 18:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6J-0005w8-GH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:39 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6H-00057o-Jt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d7431e702dso22461315ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571096; x=1707175896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdVwXO6aZnnqYTNIGGclZOCzzCuGYC0jnGIBlpxlAKQ=;
 b=IjbDVnp+1HcQO4sO77EBiS46eOsaoNAN3Gxy/6s2On4lLa3UJNZFUBsZWpmlG0O/TH
 Gdh4IA8wXF8bz47Rla0RMAX2giWCEb+p/Uljk65nyOdyeXyXxdactZsSi4e9aac2R72o
 HL61boj/g9dTaHCwPGIJWUCkLeLE64LCDAH9VE/DPw6d7AjUX2/yEMZIwJEBujKPzX7Z
 X6CCMt5Us3dR/IIgI2IAaiG1CuOd2ikLHQWUb39rPTscmibnN9YWoJaA9CtIN1UiqVBB
 xg+rlm/TxBVNTXtHozcS//3CjL4s+TZCkNwIXsv0jOhrpeRdUMwYKhkQqT+RX3JyB89x
 xdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571096; x=1707175896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdVwXO6aZnnqYTNIGGclZOCzzCuGYC0jnGIBlpxlAKQ=;
 b=BadVAn71Ekga1YKrVXzGU2O09iiw/5oB3YXSwdfpzVcQnDCdXVlK98NXvA/QtR1GZN
 Sq8knL2Ctpi7hbuWyg4IzHkfvewmwZ4Njm3GoUEuDZhfEghApFCmKIXdnf64/qJi9hDn
 +INpANxhr5KwmwXUslaxa1qMpsP6WhEKvWdZ3iYfOqoR9lqmcmtpgUFsyE0dbbDHqV5L
 f582aOTFvwBPjCK9wyVBmdk6WbztVbjPM3qn5Nay1IPSEmJDSJmFN5R3BDX4xV2c/UvI
 f1A3qlRzPxTx3Y509eJgfnJ+Pnjvq0UtZlsrH7Yj32io5Rvfo7sP0XmnUxjND9BCma+f
 S/2Q==
X-Gm-Message-State: AOJu0YwOR52CY1t1fckiKv0OP43eih53IhMT0wRJ4+USktnN9aPtR00v
 K/4/MyrCkkNpIkJGlzDXdpee6XT/DVYFdzf/wErQLI2lc0p0uOpw3wRKXaq1G7vMGe4YbQCnGqv
 m7hk=
X-Google-Smtp-Source: AGHT+IH//WZ3n2XQsowBZKT3WhSWGqJ26J4zPpazAfC60sGtCD8dw8Zg2kssVPvdf5QIijqdDAHNPA==
X-Received: by 2002:a17:902:8485:b0:1d7:396a:2188 with SMTP id
 c5-20020a170902848500b001d7396a2188mr3053942plo.12.1706571096158; 
 Mon, 29 Jan 2024 15:31:36 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 21/33] target/ppc: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:31 +1000
Message-Id: <20240129233043.34558-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/ppc/cpu_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 86c8031765..9931372a08 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7105,6 +7105,11 @@ static bool ppc_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ppc_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void ppc_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
@@ -7372,6 +7377,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = ppc_cpu_class_by_name;
     cc->has_work = ppc_cpu_has_work;
+    cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.34.1


