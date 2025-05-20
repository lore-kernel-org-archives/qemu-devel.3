Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C01C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnW-0007f4-H0; Tue, 20 May 2025 07:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnG-0007N3-3K
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnE-00032k-DC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZeJSoI1oYQ0zCCATRLISYxzasklWXEzQTXEkeQ9H7tU=;
 b=RnxBT2evD36x3D96/L50pMti34g5uqpBpWIi0idHuS2mde+TAH+1TfQb2izgjzXWkhEb5Z
 ooiDf5eSv9+9Y6xt97BpG348t4gl+qOrVg0veT0wq9II0lgOcgWirV+nemFN7/XSxNZYJC
 uz48TL+4PloWnocwxPWTCkecybdOQrs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-LKKSitI9Mt-52av6N0i1uw-1; Tue, 20 May 2025 07:05:54 -0400
X-MC-Unique: LKKSitI9Mt-52av6N0i1uw-1
X-Mimecast-MFC-AGG-ID: LKKSitI9Mt-52av6N0i1uw_1747739153
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad53f8a49fdso293534766b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739152; x=1748343952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeJSoI1oYQ0zCCATRLISYxzasklWXEzQTXEkeQ9H7tU=;
 b=sJ/r1HoUq0zav3qXVb3Ar0zG5myTWKPrjnbmgO1luOfSjnLII2zwPk7mMHLoTrDTWa
 TMyG8n7PB3Kumj2U2LQJJLhDqmegFruBf70x+13bDtRPRKcp1/kG3xE/bD7wAQkWj7Ze
 j1aUcv9vG/LJpaioVoeRSzcJ1oEq0VnlUjLHspoNZ4CrOzfTDlVISsllwqV6lm6Q606U
 JdYU0RDK7oS5sNjpW8MIsSAbilNo5zKSpdCu50Vjl5scq7KDiJs1NRJUgTjP2S4NXUUV
 /bGg0vYKdBDE8Eb2WnwO1K3lI5UZmw/+kAJmNR+gyyqFfOUrNo4HyREt801SwkZ/kFM/
 0nqA==
X-Gm-Message-State: AOJu0Yx9CxqNHhOWHpitmUzPZRLThkr+ePYxjZlQ9LsER6xskw3U58uR
 MCJzUwFKYhfihHIFy7kJrHRaaeUyRGop9xin0H+XGVq90nJOT0yWNwseLjGNJHar2X4PAxAz3D4
 ZKqeltd6iNpnE+P7VM7/rJk0FpOqvH7a/iV2mBf26dtc+DtBIm60BFngdj9qS8B2gX0UgDq3K4D
 dXkhTsY7onksqr6adJ4/6Z1G99XIiMMCEmUK5iWIXZ
X-Gm-Gg: ASbGncvQ4ffxYbnY10fuVr6MDELf7hKI7xipn3a1vhZVkcEBmO3TnUdDz+0Lafg7hln
 nHJSi1u6TpZCKA/BQHmhq8CiMSRN1fchD76lNVx+uZMQbAzMi+ODXkM/TsfaoRHzKde7Zneq3H/
 LtglQ4MRWt76f5hExWtAf02zA7UqzDjd/AY4AHdSLGrMdhxk1OIJCt8j55IOf2SoKzGh19naY1F
 IkVsbqXFSLjlGc6mMZCIKJUbl/h19DT9QiZ0CnMLhDO4t6r22EYEDvGedMNAMk7tK49HrqRFlk5
 TgElybE+7nkRfQ==
X-Received: by 2002:a17:907:6d01:b0:ad5:58f7:6c8 with SMTP id
 a640c23a62f3a-ad558f74558mr991251366b.49.1747739152231; 
 Tue, 20 May 2025 04:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHFMGoj63uHLU9GiJXRJv38O44XZcAMiQ36jpFYVwZ/Mc1bZiFJ3suEOz95lMbhmUIvq5YA==
X-Received: by 2002:a17:907:6d01:b0:ad5:58f7:6c8 with SMTP id
 a640c23a62f3a-ad558f74558mr991248466b.49.1747739151767; 
 Tue, 20 May 2025 04:05:51 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06c20bsm711351566b.44.2025.05.20.04.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/35] hw/riscv: acpi: only create RHCT MMU entry for supported
 types
Date: Tue, 20 May 2025 13:05:04 +0200
Message-ID: <20250520110530.366202-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not create the RHCT MMU type entry for RV32 CPUs, since it
only has definitions for SV39/SV48/SV57.  Likewise, check that
satp_mode_max_from_map() will actually return a valid value, skipping
the MMU type entry if all MMU types were disabled on the command line.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1eef2fb4eb3..e693d529e15 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -288,6 +288,7 @@ static void build_rhct(GArray *table_data,
     RISCVCPU *cpu = &s->soc[0].harts[0];
     uint32_t mmu_offset = 0;
     uint8_t satp_mode_max;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
     g_autofree char *isa = NULL;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
@@ -307,7 +308,8 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
-    if (cpu->cfg.satp_mode.supported != 0) {
+    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
+        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
         num_rhct_nodes++;
     }
 
@@ -367,7 +369,8 @@ static void build_rhct(GArray *table_data,
     }
 
     /* MMU node structure */
-    if (cpu->cfg.satp_mode.supported != 0) {
+    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
+        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
         satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
         mmu_offset = table_data->len - table.table_offset;
         build_append_int_noprefix(table_data, 2, 2);    /* Type */
@@ -382,7 +385,7 @@ static void build_rhct(GArray *table_data,
         } else if (satp_mode_max == VM_1_10_SV39) {
             build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
         } else {
-            assert(1);
+            g_assert_not_reached();
         }
     }
 
-- 
2.49.0


