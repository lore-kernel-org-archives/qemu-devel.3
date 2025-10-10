Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47CDCCD187
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76TH-0001sq-Is; Fri, 10 Oct 2025 02:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76TE-0001ot-RT
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:19:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76T7-0001Hi-3c
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:19:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso1152664f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077146; x=1760681946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAwykyiOhWvraQUfGAzRC/31Dk7bosyxV0Cl5cE42l8=;
 b=Kks0ZQG0FnQ3YDuuDtTw0smA/O38yLwLsOsimoOKNqyLde//VPMuvyYfdoW1rR5aWT
 rlumwnMzLdbDp4sCET+4SUZ2EmKMT6bvZeewK8egZ/msbbyCCEHe5m4+n1jc11a7PTxQ
 zy50BQJIjoV0BL5cmBShZPIeomxm9P9SBkoBbtkdzV2jb4YJVjMQsUu6ofFor86F86+d
 +gzmWxmjGKBZIDEm1h7xYMRaBMgwoHEpQjoqWKFijt0LHiegwR7Hdq2tjq+u32eCN1wK
 Z3epDH44Y7zahJ7sOTwYmwIBzUBUgRx6KsGw/sURPCHRrtoIakxxnFH3Yw+JekSb3LEg
 zxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077146; x=1760681946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAwykyiOhWvraQUfGAzRC/31Dk7bosyxV0Cl5cE42l8=;
 b=Z1jYw3AZjVy+nrpEkRvP+N2lHg1BkiX1O0z917rr/9AEi2oS9VI5H/h/6V5XjTAhXP
 m9iCzNV1LB6rTJlSuDzXh/nSysjM9QVJ8EclC/bOGcj0luDdEd4GUSaOttRlPaa1U/j4
 8OO3LWcJb7zLW587P7TN/IQGWF2dQJuZZeVdivTiuT6zGQH4VAIn6LsD92cjq63gF/o4
 daYgX5ixSE8nQW5CSA5fltkhi2Oti31Tqnn4dDwEcoTx6twaUR4YTtr6irvIf/7tS1U7
 Ew6nGugVXsDU53c5mg8KHvgL7GKEa5PKiVyQs1oHDBnGFMz/A7Yg8WdhG6P6moLzYXHA
 /laA==
X-Gm-Message-State: AOJu0Yz3U2DJMphXlvw72dJ3iBPkG3x+IAbMgFTfq4zfhbCmxILr871U
 8Scp+PpQcF0SQoSxm3MgLymDv2QKGN2yMvK/+qP1tnOgp/hI4XhOQDtVbHRM43kC186GqTNTPtJ
 KPtbMU531pqv+
X-Gm-Gg: ASbGncugUso0tcanVNaEdJ5pNnGf+QfXJwEN4gyRhmSaaPhPzcSOmmBvvwZQX3HyAsk
 DsGRHGKFG4QBWXko0uKAkZAq+1lnwJNcvaNzyZr8UsZThGsCzbpli6GxXIb055EqdTt9kBj0/G6
 GpNme7tcWV9sMSVomhrEey/N9NcXPOyevHKWy9gWeA3axAp1Nk+v+was2MDrb/go4XlxXkXfoNr
 ZgcBUxyoI16WJ85pydV8uocwXWaGDF74JL13yN2zixY+wcCi/ug5k48HIuqnJwlypVifhYOF/bj
 nhMoqy2fAHnfLpCcGgzRNzQSlfDR9YOl6ijo7V+vHOAdjVsMpPqZGbOJQrNk0cWWOvrjFjV2bX3
 471xWlV3k750mentgfh4Gs4Cnp+tTaIR+fV+b0Bi+m2r4/bWlpw/XZsVFhRP5dpCJKNQCamCuEJ
 rYxfYFCvgMSnn/TvM2ogbPsR1y
X-Google-Smtp-Source: AGHT+IEaw23SIuDD/mzjx6TQeY5zR86M5FBQRYkThiq/qbgV/Kw0MK7QSN5wnJdmOxtYtaDb6jyqJw==
X-Received: by 2002:a05:6000:2f83:b0:3e4:f194:2886 with SMTP id
 ffacd0b85a97d-426670835d8mr5901053f8f.19.1760077146460; 
 Thu, 09 Oct 2025 23:19:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0061sm2467769f8f.30.2025.10.09.23.19.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:19:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/6] hw/hppa: Move CPU::initrd_base/end ->
 Machine::boot_info.gr22/23
Date: Fri, 10 Oct 2025 08:18:36 +0200
Message-ID: <20251010061836.45739-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010061836.45739-1-philmd@linaro.org>
References: <20251010061836.45739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These variables don't belong to CPUHPPAState, they depend on how
the machine is started, and only apply to the first CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  2 --
 hw/hppa/machine.c | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6c9bcbd9078..49d0243f677 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -271,8 +271,6 @@ typedef struct CPUArchState {
     struct {} end_reset_fields;
 
     bool is_pa20;
-
-    target_ulong initrd_base, initrd_end;
 } CPUHPPAState;
 
 /**
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b6f15bc61a3..61e83daaadb 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -43,6 +43,8 @@ struct HppaMachineState {
     MachineState parent_obj;
 
     struct {
+        uint64_t gr22;
+        uint64_t gr23;
         uint64_t gr24;
         uint64_t gr25;
     } boot_info;
@@ -524,8 +526,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             }
 
             load_image_targphys(initrd_filename, initrd_base, initrd_size);
-            cpu[0]->env.initrd_base = initrd_base;
-            cpu[0]->env.initrd_end  = initrd_base + initrd_size;
+            hms->boot_info.gr23 = initrd_base;
+            hms->boot_info.gr22 = initrd_base + initrd_size;
         }
     } else {
         /* When booting via firmware, tell firmware if we want interactive
@@ -677,15 +679,13 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.gr[26] = ms->ram_size;
     cpu[0]->env.gr[25] = hms->boot_info.gr25;
     cpu[0]->env.gr[24] = hms->boot_info.gr24;
-    cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
-    cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
+    cpu[0]->env.gr[23] = hms->boot_info.gr23;
+    cpu[0]->env.gr[22] = hms->boot_info.gr22;
     cpu[0]->env.gr[21] = smp_cpus;
     cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
 
     /* reset static fields to avoid starting Linux kernel & initrd on reboot */
     memset(&hms->boot_info, 0, sizeof(hms->boot_info));
-    cpu[0]->env.initrd_base = 0;
-    cpu[0]->env.initrd_end = 0;
 }
 
 static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.51.0


