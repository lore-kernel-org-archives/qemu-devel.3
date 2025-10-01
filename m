Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496FFCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGR-0005iD-BV; Tue, 30 Sep 2025 21:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFy-0005UQ-QD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFG-0008Bn-A5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so4399793f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280577; x=1759885377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QA9K9skWXs/r/1oOXj8qZ7/XkHpNtPZnS1Ie9dQypSg=;
 b=AAlGIlWniK4N1vwxtk3cvsXVPNMXZIYId/FV9PPvC50x2hC2KpL4HkgmA9Jo3wW+Ec
 sskeVjDbhMF1jfo3bbDGtgBoufnxHarEHAcvOwNHVp10usuQfFFXLDy317wndCNqV54L
 wA/novoAuHDVaEbIqgazVuUJJyRnsW/Ez3ceXq76MrLKF+WejrGV49i8FQPAXlw1Xe0c
 oAu4gL+JPkpjLJbXdb/dNybJ2OR491PPVVLFm/OMjmKdpl9RUkOsRcRPttXdT6l7yd6Y
 k72XF2wRCWHXE0F1mXCpvxWRWaIGmMeajpR5dNbpGdxui6TAbzCalyMsJkTtlXrPgNlE
 pcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280577; x=1759885377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QA9K9skWXs/r/1oOXj8qZ7/XkHpNtPZnS1Ie9dQypSg=;
 b=TE9YY01Gc+ffLzE9v1QlltOPWjVpLw7Smb6fHRO+YSp1WUWghKqdJYakOXCw9JSWF3
 XNtQZsJ9Hk/yFqvGW/3L6X2PXAAkvHE7IKjHdpLT2h4s9ThVjKvCr/LdmZbUMFZNN3QE
 yehVqqMx7JLdi5/lfOmXF/HlmDSacYMLprGtpVbMEOYoswEuy1LDlSBi81eNN2ROdWNP
 C6pb2wl1qRSKJIb3sbVZCtyrpPazKOhqmJG1Izb1xcb4Blnpq75oK8tOwmkNV5PZM5zU
 dO3T3DpnkGOC0t7zcxJhM0wKvookddFyvaNZ/Xe1lYCHtZviNzB62d+JmxJisgQIrEKW
 X3DA==
X-Gm-Message-State: AOJu0Yxqj/Z8xIEzzgNQdeNSGEgYl4wA0zN8YJnjWZALUR/MwwFyD1HL
 dsgWFAHL2nju1igRlx8/ctlki+9ULUdKRmqUxpZX9fX0OEDxTpZK2xjwSEAOezM6K0bgeDNRvZ5
 TG3SWYICArQ==
X-Gm-Gg: ASbGncukz2AYdk66B2aXVH6gt5AYj7e58GBpbADV6wWmQmWnLl6fvBJN6odmLigev1N
 sYu/1/5vtWOKe5kGG2wNmgm/T7U04xxpzGYmaxXB2CxdWr5KVnAAjFTtx5SSV7ERYwDwvNXB1j+
 fU11bDXWNJsEgwuXLGlvYormshD0soR4BAPAzySR7t5QsHkJgzdmR1BO/CxGw3CGINCDN6g2Syh
 dBIp86xTPvRI8dCkfXqAnSCttYJwL330xnBkmjkvEWP/nQPAQke02rlShUOQEDBYMaigZ5FLq+e
 jGCFr/AxLg10juBzRP5LDpO9QL6zyQRAafYe4AiEBpXGzm5rAglF2loAmf6xlbkp0N/BPF127/0
 PYYx2wlz58/Mtf2UMRtY+dZQZ7/0QeSqMqMtix6+EwCVI0LTkqahbhCp6r64mtG9f5iGdmiNujK
 5ZxZFG2OJNWPiBkqP1YpvYNVXXfuh1G1n/+7wk+uFS+3M=
X-Google-Smtp-Source: AGHT+IFThuu0ki8xLIEofWJj296f6f32+rIbtRYw4hrXRdchJwH+Ge/B0avOu62ues1Sp8GocB88Qg==
X-Received: by 2002:a05:6000:2c01:b0:3ec:b899:bc39 with SMTP id
 ffacd0b85a97d-42557a1b40dmr1065274f8f.58.1759280577175; 
 Tue, 30 Sep 2025 18:02:57 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:55 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 19/24] target/arm/cpu: Add the Accessor hook to fetch
 ARM CPU arch-id
Date: Wed,  1 Oct 2025 01:01:22 +0000
Message-Id: <20251001010127.3092631-20-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

ACPI 'acpi_cpu_{device_check,eject_request}_cb()' uses 'get_cpu_status()'
API to get the existing 'AcpiCpuOspmStateStatus' of the CPU being 'online'd or
offline'd' after VM has initialized. Later usesCPUClass::get_arch_id` to match
the CPU. Hence, we must add ARM CPU architecture specific accessor hook to fetch
`mp-affinity` programmed in the KVM host.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0ceaf69092..d147e786c1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2744,6 +2744,11 @@ static const TCGCPUOps arm_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
+static int64_t arm_cpu_get_arch_id(CPUState *cs)
+{
+    return arm_cpu_mp_affinity(ARM_CPU(cs));
+}
+
 static void arm_cpu_class_init(ObjectClass *oc, const void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
@@ -2763,6 +2768,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
+    cc->get_arch_id = arm_cpu_get_arch_id;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


