Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D414C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublsd-0007gj-12; Tue, 15 Jul 2025 16:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublay-000249-EY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublav-0002gF-04
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a528243636so3290044f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608737; x=1753213537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y4H7q6wtMebLP2FB4L+vyKN4sDObDDcyRkuxy6M8jq4=;
 b=Cr4GL49HyBtSB7fvwVUApXgWlUsWB8HrZMe9Ja7XUMbhOI+Br58D3LVGCJ/1zhhP2d
 EDN9yBfJkZJeKXx8rCirIC7s7dsUE9tHzIBakw4YjtDObqAI5xyUM8upWEQc9fzxg68c
 1Yk+hvkoxuaIf4U521UFoc03cUjrGfhYp28JyuGMdSIsLDFtlubmgHkYalGPvJo3BiX3
 k7kQyKyfumc7b/mbkf5072vIbLHBM399s1ovcun/3x7vPyCE82hqi6cALAxhDiflFmWq
 UN/ofZZj5P/nYeUQ/UBMkzcQKbw5NefjLw3KpzcS8yAce/am2oEC+P222tLJRd5aCbWd
 5Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608737; x=1753213537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4H7q6wtMebLP2FB4L+vyKN4sDObDDcyRkuxy6M8jq4=;
 b=iC6QZrgntnMSQXYNBw714xCwYSX3+o2v5DQeZZrFlR6/YOVQudyeDfOB16qWNpEvYG
 az9YIgYWTPyPCe+jS1+YxTBneSeSozx/Bh7SgdExuO3Gurru8PeAK1M8Xgjy/JH1opYK
 857W080Q5Hn1E7T7FSzh+HHAX4IsvhYaAE+AnQNxWL2m+HZBg5fqEtpPAoHjTSrZqOew
 B10ffGsZ3AQMgRwsWzLN00uzZywJYEuG8RDIFbUixdWyQXp4X3s3VBqiw8oMqGE5AoGp
 tKHvP9v5mEwFXEoZI30B4zX3gUHjpbnKuJsuNdwFf6VnlnzDCZJeJT0DNdqsjp+Bf256
 m3uw==
X-Gm-Message-State: AOJu0Yz+11ZmDhaL1AUEHM6AHc/WWunnoQZw4CAi7LtFVsjLsMFrxXkN
 HVogQow0lXRsCHvDKEGl45dzRsKdkZfLylTD1zL+xPhjb93MnGhG8/4oSyIF7pOjW741naGrbh2
 Zq/Jv
X-Gm-Gg: ASbGncvSUAJ2VXmnhk2n1yeOdm0NlwkwqaCpji36nQ2nKGC/MHxpFRY3OLOmIg1p+e2
 zjTIO5QJI1WqsJ0v8YmV+9GvZkGfwOLGPqlQWjYSqXsiC1N2dzRY1sblO14B7zA/LevaaEUgLax
 MWKDteBclpruwXFMN0lHPeVgdcP54XJI9vHplAhQAlB+DsWXr6WK7j1oOEp55VNO+vHU+nEQOJm
 d93Nd0QnW9C8kv48X2QATEU/kGy7VQsAeTbapLvXPXAq0QChshhp65pjSW4v+lTAMRqxdBFdUJW
 gtVn/YcEpW6hGk5vh4BeOll+UEjK8oIkjV1ojN+cBs7fblFyvy8CTOXKbhhmpSjo8YczXVK6g/f
 9vCip0rSDkMsgZs0I32tT6An0HJB7LK7JHLTisw+HNrjQQ/Lc22azz20TxtJUqH4+finBG7mdgp
 +MmQ==
X-Google-Smtp-Source: AGHT+IGzFn1iXXKcuAtIW+CAVAlkBf21xtLiltI0CRCZv/aO0rvOumkZPCsA0Z0Ehb0+Gn0xt6KOCw==
X-Received: by 2002:a05:6000:4a06:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b60dd53fe5mr366440f8f.20.1752608737512; 
 Tue, 15 Jul 2025 12:45:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d727sm16076581f8f.51.2025.07.15.12.45.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] qapi/machine: Add @qom-type field to CpuInfoFast
 structure
Date: Tue, 15 Jul 2025 21:45:03 +0200
Message-ID: <20250715194516.91722-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Knowing the QOM type name of a CPU can be useful,
in particular to infer its model name.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20250715090624.52377-2-philmd@linaro.org>
---
 qapi/machine.json          | 3 +++
 hw/core/machine-qmp-cmds.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index f80ba264b53..6d3a480bea3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -76,6 +76,8 @@
 #
 # @cpu-index: index of the virtual CPU
 #
+# @qom-type: QOM type name of the CPU (since 10.1)
+#
 # @qom-path: path to the CPU object in the QOM tree
 #
 # @thread-id: ID of the underlying host thread
@@ -89,6 +91,7 @@
 ##
 { 'union'         : 'CpuInfoFast',
   'base'          : { 'cpu-index'    : 'int',
+                      'qom-type'     : 'str',
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
                       '*props'       : 'CpuInstanceProperties',
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 1af0f29f7d3..b9e7eb64e02 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -48,6 +48,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         value->cpu_index = cpu->cpu_index;
         value->qom_path = object_get_canonical_path(OBJECT(cpu));
         value->thread_id = cpu->thread_id;
+        value->qom_type = g_strdup(object_get_typename(OBJECT(cpu)));
 
         if (mc->cpu_index_to_instance_props) {
             CpuInstanceProperties *props;
-- 
2.49.0


