Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B1AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbca-0006gY-26; Tue, 15 Jul 2025 05:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbcW-0006ee-8u
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbcQ-0005t4-MU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so17470515e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752570391; x=1753175191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhBy/4ghzdrQ703StLbYqMKbdncodWy2li2u96R/420=;
 b=gltYrOeAX3s4KdW4CJasjuGqD9dvzXz6PvkthIuSoVUmAK044jfa5fN7n3N01ATonW
 938ejI2huQZv5kCi1LaHHxBOO9ppFbJp5FtH9EQwUM+3IBpHLzFLBYQSiOzRXtu+wKfG
 0hwWz6arMrWrkNGcwAMJl3tiZpq3+rzqhTx7nxg+LLrH3D5IydOn6BbxFDHUta7RLnGz
 4UL6Mnec/YzafBW1DqZ/bLy1eGMgKnmcayDPIbtNvLbOzLvBVROJOzlLhQVIShU4aQUv
 58/8PD5VaxgR+EtPWexvAWh625/T8YrG+11pMsTRHt9VMod+DoweH7mVsIryN1CQ8xM7
 vrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570391; x=1753175191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhBy/4ghzdrQ703StLbYqMKbdncodWy2li2u96R/420=;
 b=cIbJn0kloV3d83ksto1VK+dmPr37+e+Kl7r2nWhpNwVpL7vZfzZMYshxrysLLSnfOV
 oG58+9cFTfmDb9C3bBv1YzdD6IuxnLwP6Ir8X1dwMJb5G4/fr78kmubtsfXRb/BHPCeu
 pPyQf2lr/2JPpfdyaoZ4R0K7cZladMocpxpkygu50C0xIIrQSuchtvzmQN4W4Bta3Yzh
 meLaNq5XN7lLLxax6pSLorwtUuBj/eT30s+i5rjBxRpHLEQFXjZE0B1bwV45sao64djN
 fI318OFeiUN4pmHDBIv8sudRJJScEOlwg1PK+05S03IqP3HhZA1v0Yp7pjx0Uav3UXtS
 yL4w==
X-Gm-Message-State: AOJu0YwJqcs8SdCW0Ckr7r54zuyzg9MXBFluBvn+Uh+N+cLnrDFPui8Y
 wxpeDWLR2vlHLbMfELv0G29aFZnonSvToT9lYdtzvnqRCL7m3C/KxGBYN8huDLg9WKCGm3i5EsM
 TjPCO
X-Gm-Gg: ASbGncuSSWtMmOLWtJ1e994AtvzHTjmjk7YNi0CRW9o9gGXHwRpHI/tUAJlOQq7Z2iF
 r/B7KYesLWKUp0l+u2vjBRBWdNiL8i6q/T33pNU7IJCjyDPplerbkpq8k2rwtOZ223h9zgAljGG
 o2d97W/bYjHOtr/xcQBvnRVAls5D6vEEWFjLML64qhxTuqYnIBvM5BOcohiPF2D8l8/ex8+c459
 fqzQQfdz639DGpRjE/a+qeUjF6uvNhwSGzH4LUqy2fJ4z1Wl3HkaidWppU1avkChIaPvn7/ZoTL
 gDHSiAeUHpO0Omo4VUCZw6GawOdgOxrvlRyFG7635VB0KYb1GFIimyzAiLFE+pwB+BMsSUeO3to
 TtgAXTWWTGEqQrEvKJjfZ98hHGsEvuZZTwd8XNvJPz6cOZVa0RVymL+FOTtm5FTJLFpPbRAgGzG
 1eRQ==
X-Google-Smtp-Source: AGHT+IGll0D0e+/kM74h6la/a99t+T3M14QB1SLlRaKPJ1Oxr45tWdR/JpdbVl/o02g4dLweJPy9ag==
X-Received: by 2002:a05:600c:4684:b0:453:5fde:fb5b with SMTP id
 5b1f17b1804b1-454f4255f4dmr148259215e9.19.1752570391473; 
 Tue, 15 Jul 2025 02:06:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456278a4460sm10121405e9.1.2025.07.15.02.06.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 02:06:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v7 1/2] qapi/machine: Add @qom-type field to
 CpuInfoFast structure
Date: Tue, 15 Jul 2025 11:06:23 +0200
Message-ID: <20250715090624.52377-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715090624.52377-1-philmd@linaro.org>
References: <20250715090624.52377-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
---
 qapi/machine.json          | 3 +++
 hw/core/machine-qmp-cmds.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index f712e7da6d6..a3f6fcec4d3 100644
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
index d82043e1c68..5655bfcfee4 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         value->cpu_index = cpu->cpu_index;
         value->qom_path = object_get_canonical_path(OBJECT(cpu));
         value->thread_id = cpu->thread_id;
+        value->qom_type = g_strdup(object_get_typename(OBJECT(cpu)));
 
         if (mc->cpu_index_to_instance_props) {
             CpuInstanceProperties *props;
-- 
2.49.0


