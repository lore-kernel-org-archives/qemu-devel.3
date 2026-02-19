Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C30E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57j-0000PP-Bq; Thu, 19 Feb 2026 09:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57f-0000Ni-Jx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:20 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57c-00032i-Bf
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:19 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso8068015e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511701; x=1772116501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AeTxyxPl8LpE2VymYK8BbXAEvEM1cSusvtLGqxUHFw=;
 b=mYhu+2th7NbL1xJ97To50qUND7cZyVTaz3gYJnhWKj923m+WIeITTZK6o2VzmzDI7o
 Y39G4BZkyOKH8I/VivinDuVSZg1uHwRgFOCYXULnLgXglGwT27Za9CROf3wduvn2uUM5
 ummyl5/T9+Y2q87bvI7TLXPHsSLF7EmXBgxrbBQIZ5Vr+28YoJLqIJku+5oMb/NvhHSo
 8lp/7T35xO7VGNbP/uVjiqIdfXeDRWvxNYyEX1yBIDORwAWybAncCM6hK0b+bOWOuBdh
 /q/xuzmfW5BhIoifJ1MqZuPOmnzTtMXxk6n6Jnr66D5MJNgkPQ4AfLkTYIzH+HPu2JYu
 B2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511701; x=1772116501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1AeTxyxPl8LpE2VymYK8BbXAEvEM1cSusvtLGqxUHFw=;
 b=KitoO0Rhp4vudtJ/t81QYzDiQs6ALpHN6WO75cq8l9lkeGje1vJc+ixm/nomV0HOlH
 BO3KBygTDybXe3hvMyEUQUmODR5vorxb+RhPT4DsKw20VvybLuMo1+Ee2yz8uFv6VpN2
 2LsC/xUhZdilj8mNwvtUiiZUc7uXm2ynn4Raoe4l0KeSL/Z/+aTPZAs12eQyQcLEwKou
 LvZwD21/Qch4Kq8HlhvFUyGFXQbjtfURPAPDfwqN1yao+rDH8v5+cYnz/N42v3LzTRic
 +PhE0ULh09WnBBgeRe71B58QsKP2hVwEtMhlp+8K0Uwm94JgMgj7VGUowFpfdiZZ0Qm7
 Hkcw==
X-Gm-Message-State: AOJu0YwuAxPqSoxIJl6qyCtGHtnmP267W3Npq8IYprBPx8RIWnO77Rgl
 slDpyZfibIct4zhuQ5KCtwyumB3m77n18xdY6cdXoBJyV4cx2xtXXRyQ6Y8NoKiG
X-Gm-Gg: AZuq6aInrYWJelmn96u5bjCN9cVl5CvGIrkgXF5mk/IItPOMS1nBcBZjPjCjaHAKL2o
 ddt0k8kUGNBv2IeC81wW1xGnxjnLN0pY1w4RcsvlnLqMeE2kQjrk616Z8Nsi165a4SFgsSmNNSB
 3rfTk3vJKyXZSUmxP9bTaAPXvzonbYuDMoNmzHgtGF5ahA4J5Z2vKbNlEetaYtMpywKq+kcOuML
 KDV+NFIhZKknefi7FHoc8fkujID/koxgP2qLkrND3u/oXusZMReEBIrbeLLon+P3YKq/h8C8xu4
 drjBNtXTXAVSNs+mq5VvNXlF93BH6TNJqMMxllnwYyxSAINuK9BfkhS/6qf+9UMBNjtAD1kOg8m
 Mcls59G+MB7sGV7f9QXjX5CX+dfscohS7We9vPs+qd635E1YwxvDgUUI/QUgsHgJUf1iAeZe6OL
 /UuhcwqUYqKTPlcq2367A5fRW4uXOlpJygSdkeiVIl8NP8swLTKS5jyT4v9/9PS80X8ozG
X-Received: by 2002:a05:600c:450c:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-48398ae4a01mr102282065e9.25.1771511700771; 
 Thu, 19 Feb 2026 06:35:00 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:35:00 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 17/33] hw/core/fdt_generic_util: realize cpu clusters
Date: Thu, 19 Feb 2026 15:33:16 +0100
Message-ID: <20260219143332.3316679-18-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Realize cpu clusters at the end of fdt machine creation
process, as they need to be created after cpu's nodes
are realized.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 63390e2f17..3179248142 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -157,6 +157,16 @@ static void fdt_init_all_irqs(FDTMachineInfo *fdti)
     }
 }
 
+static void fdt_init_cpu_clusters(FDTMachineInfo *fdti)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+
+    while (cl) {
+        qdev_realize(DEVICE(cl->cpu_cluster), NULL, &error_fatal);
+        cl = cl->next;
+    }
+}
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     char node_path[DT_PATH_LENGTH];
@@ -172,6 +182,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
         while (qemu_co_enter_next(fdti->cq, NULL)) {
             ;
         }
+        fdt_init_cpu_clusters(fdti);
         fdt_init_all_irqs(fdti);
         memory_region_transaction_commit();
     } else {
-- 
2.43.0


