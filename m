Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A62C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M8U-0006lU-8o; Thu, 17 Sep 2026 20:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8N-0006jg-N5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:20 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8K-0004ui-Qn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:19 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1047653a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690035; x=1790294835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ir+Amid76CJDBxcDpBtxUQFPmnGvNXoJ4vUbradoghY=;
 b=J6xk+1taRcptJGk1R9ymBHH10pGHOUxRL2qRdlsuOhOQSCkR9umREtzP7gPu7u1vjg
 gK3aq7KuVoyFlXOqujBZUQahAAUX7Do14nppnYdWgGcHPDfJ7d9UAu7+J8Q05z5iUWF+
 3Mkz8iBTN8IQRygQoyKxUHYhhRrDSMOgPxDc64Apcm4BnrAQHLsOHc6KjfWAjdut+s7P
 ZvR1dWQ0uqKtdbxrWmdOIQubYYpDC+qo5Xa3Pz3yK5gO841UdIdRaFW6DQvnxvlBsmCP
 6kttmuv603H+I4kogSLx1r8BD3wjnlEdSrQMOjqalK0dYNKf8S1mDH8nE827YfYYmDk0
 HZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690035; x=1790294835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ir+Amid76CJDBxcDpBtxUQFPmnGvNXoJ4vUbradoghY=;
 b=A+E4I2Xl3NyCcGeWjl1miHdTMB/+6ep6fcgRwh+MV/453FT648L1AhnmFSIr6e1Puc
 autX+Oe3R5BI8gGyeDE1GKVt2lNNenBuW1BF1qbb/GoEc3pKD5NZTpDXqJG2/RR41sOZ
 UfASsxIHdMRUCD0J67i5kKIdNHUCoXXItPg4lMWqg8e8M0jsbZbOB3Ax1ZeMe7ZKe+pI
 rZtzpl8Gtt2OnLwSfMcywhmkEC/3ZKAAxTWgW3dK+fNWKc/bcQmP5uTDzhDQ3PjaZSe8
 zvrx6zqJhZXAVQCqTl2D2jw/5QXRMr+cqpj4n9q7TDwlYmGP0hcq3H2V4K1VAM2pBMaQ
 33dg==
X-Gm-Message-State: AFuF++m8t7ic8c5QNK7tbItkrPBRonlan/4MM+2D/5MqXdVFgirWpevD
 MsIfU0Ky6fw54Bn9au/gRx+3ZCuoDDaxccT2/S46OusHjOKy9d6SnVocyquxjPMx5xM=
X-Gm-Gg: AYBFou3w9NRWYtZ1k1inzjF8xhPP6aDZksNvGDlEJS0IvGTkw9r82NkBKxQenEqXp7t
 q7LsUaVBK5Itrt8BXG55TmAcTVPRpYOSxASuIQUJuCXN4Xt1/+4vpvgIb/dF8eQQM5y1vNtSTXm
 JNmFSfVqVX5CbCxAt9/BqC5HffKqumuCCv5wZSBXAUmTtKcjHG95Q6dxT+OTvvbtA6E681+LCBm
 zGyrmoE84SJEh4JiFnrfznBxWgkEW1bmULMPATSnxGB5s6FQSzKP4h/khBx4ASqkFRyM6NEPyEK
 RhCdMkVB0eFJMUuSbYDhgR2Y4zJY761/aYTI5MbyVWs91nKubwleze3ykIga8RsdOiwrtxd1YO0
 /mE478zHM/mg9jEbRb10KYwUDfKOeh3NVzbO8yZCv3j6TZ8pQlhGdzQ0zuveryIcVlmqxbgjmax
 /acHHt7xihqRKT/J+4u//fk0PNaF/z56C6MIOdIMK62kbrl1IyJGtru16k/midOw7Za3nqqIXep
 qOkdsToWJMq2YI9JwK00+irBpEq2JTx
X-Received: by 2002:a17:90b:57e6:b0:39e:58d8:f899 with SMTP id
 98e67ed59e1d1-39e58d8fa69mr384832a91.35.1789690035270; 
 Thu, 17 Sep 2026 17:07:15 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm20328212eec.28.2026.09.17.17.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:07:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5/8] hw/hexagon/virt: use unique QOM name
Date: Fri, 18 Sep 2026 08:06:36 +0800
Message-ID: <20260918000640.1001-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918000640.1001-1-luoyonggang@gmail.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x536.google.com
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

Set TYPE_HEXAGON_VIRT_MACHINE to MACHINE_TYPE_NAME("hexagon-virt") so
Hexagon virt no longer collides with other virt-machine types in one
process. Keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/hexagon/virt.c         | 1 +
 include/hw/hexagon/virt.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 64d8366d27d..04591066bef 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -359,6 +359,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Hexagon Virtual Machine";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_init;
     mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v68");
     mc->default_ram_size = 4 * GiB;
diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
index 4ca2f1ef859..523c4858036 100644
--- a/include/hw/hexagon/virt.h
+++ b/include/hw/hexagon/virt.h
@@ -26,7 +26,7 @@ struct HexagonVirtMachineState {
 
 void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
 
-#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("hexagon-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
 
 #endif /* HW_HEXAGONVIRT_H */
-- 
2.52.0.windows.1


