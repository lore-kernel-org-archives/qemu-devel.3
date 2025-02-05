Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334BBC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 11:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfdRk-0004g5-OD; Wed, 05 Feb 2025 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRR-0004R5-TC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:37 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRN-0003yx-OU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:36 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361c705434so49185625e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738754372; x=1739359172;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKMFjIgxVL3VZsT6p8l1ocQBfJI6oRsr6VGKtkFAZvk=;
 b=Ok+2U0Krwx19GDHDs6qsVaMgTxZ0rkN2PYplyLuuqCyq3IFFdgmyzAZ41oYzmdtiEc
 gqvcdPJ4mxX508n22IuHlKWNd1ZXti/dipW1v8Kk6cZPEyq1U9wMoMAx8fMYM0ubhxRf
 icwZhXw0Io8hjPB627lOw1wqCUHxVN4HN0KYjRxpnbBt0Z6D7XxTbOkHTwbHJNyCHkZf
 b6JYu07Xhh0cirs2YkTDv64G7MzymDGdtNorqcT1zYNnXx9LrDlMlNWZ0WE2jBXzvK2R
 wQ9no4J7WyS0etY0OgmIdeN2cDwcI8Ld+K6o1DBJ5CFNeg37VJveHV/4Ws7+DJ45uPVa
 +5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738754372; x=1739359172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKMFjIgxVL3VZsT6p8l1ocQBfJI6oRsr6VGKtkFAZvk=;
 b=Zl/SDMNRK7nZO3VB7CBjuem5jVzpRRQs04V8PVeDpf8nnwh3wc4xmvzbbxJgPG6mxB
 JRShvRrM9wKxtDCi6RWSNyeoMrv8RSHHhwRI6/Dt1SXHFwcK1Nr3MDraE/QbSzs65oUC
 CEIFCYgfNe+MQ9768w07aBZ2d7cRbpLO2FqORsTxTQvQNWE9rsYwIhKZd3KwccTqkBBs
 6D9BkPMggmffyerKKj9/Sn5JkSpGWNsgI6vmh9/uolmEzRVagt+UaRH3P7E1VrdjqAXO
 qQtpDBHDZ6QxmSgQfkfFOUSD8OfjHnHLuMof/C8lzgFHsVQr0yte518Gd3kNLeK3iMFK
 7IIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE2TacGatDl6u3KwKdSFi6Q0Hb7uMXWkP8rbPrJYhbcVGJ9E2IWmLhwksVu1zbT2Max4sK2hIP2BeC@nongnu.org
X-Gm-Message-State: AOJu0Yxs9fmd1DXW5fmeeLvn/wLVvyodrbbu8q1DaCNGZ72sXjU0Z5gm
 AW/ZmRg4Xb4lBaBmSVSd+cHYB4yxKbTLP6wPUxu41YmJL2wcWkuscdtGry4gp1o=
X-Gm-Gg: ASbGncuDs/mxEpRTMMA2j/jtk2dKT+/THUjT89gDxpk99GoklhKK8qi8vyDxjzi3hFV
 mE4lfdlY5hscL+Sm1c4Ose+SNEyAcKnfP6Qu6hlf7vBr72Rs0juxephTXL8Kw/5WeBtx/6Q7xEq
 wYlxvEnRlj1vXHyJO1ndRe8GkeDFhusxyHxy1mGshm6sKvkpjGi6gDebRLMJo92sIj5uYiMhxa5
 7tQZ0XVH1HDYrWWiXtMELGt8xFTjPvN9562V6euGBLVo2WFz7L80YC7Sqa2WI9v0VdevNuqcB7H
 OSjwznfTlciJRZiDGjeBskbEL8k=
X-Google-Smtp-Source: AGHT+IGwS7Bh3clFyeFg8O3LWv/Oj1m6GM+zuCbfu6TGDJ/LANzdRrIpFXcgwzOCO0Ud/qXWYJsP9A==
X-Received: by 2002:a05:600c:4586:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-4390d43da00mr18586955e9.15.1738754372146; 
 Wed, 05 Feb 2025 03:19:32 -0800 (PST)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93382dsm18256575e9.4.2025.02.05.03.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 03:19:31 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v6 6/7] target/riscv: machine: Add Control Transfer Record
 state description
Date: Wed,  5 Feb 2025 11:18:50 +0000
Message-Id: <20250205-b4-ctr_upstream_v6-v6-6-439d8e06c8ef@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a subsection to machine.c to migrate CTR CSR state

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index d8445244ab251e23c07877d9f2a7c1c08f09d736..889e2b6570132950c25df6395794875df604cd11 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -300,6 +300,30 @@ static const VMStateDescription vmstate_envcfg = {
     }
 };
 
+static bool ctr_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr;
+}
+
+static const VMStateDescription vmstate_ctr = {
+    .name = "cpu/ctr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ctr_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.mctrctl, RISCVCPU),
+        VMSTATE_UINT32(env.sctrdepth, RISCVCPU),
+        VMSTATE_UINT32(env.sctrstatus, RISCVCPU),
+        VMSTATE_UINT64(env.vsctrctl, RISCVCPU),
+        VMSTATE_UINT64_ARRAY(env.ctr_src, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_UINT64_ARRAY(env.ctr_dst, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_UINT64_ARRAY(env.ctr_data, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool pmu_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -450,6 +474,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_jvt,
         &vmstate_elp,
         &vmstate_ssp,
+        &vmstate_ctr,
         NULL
     }
 };

-- 
2.34.1


