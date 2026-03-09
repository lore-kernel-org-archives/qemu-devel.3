Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F967FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzef3-0003Lc-Eh; Mon, 09 Mar 2026 13:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzeeN-0002mH-Dy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzeeF-00027c-Bw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r9g5CqWf0hmFdhCjo01T6zVno1OvrQP8qBF9MdcaDw=;
 b=YUGvmbjgt/jOSZuX1vsW6fwfcsh4kLPltfypPsr48FRBVTgDIGTgJAMGNJOFhMxnbNIfcu
 Do5TD39qacnX8jutBo2Gl7xYqDqKMjkt+R3Th0PJfw2QMKR22ctjdTY2HahJxFnjLm0iER
 O+PrHGJdHybpkI/yq63dpW9VZpNlQKc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-_bjd4DsyO0KYFHwmwyDHxQ-1; Mon, 09 Mar 2026 13:44:05 -0400
X-MC-Unique: _bjd4DsyO0KYFHwmwyDHxQ-1
X-Mimecast-MFC-AGG-ID: _bjd4DsyO0KYFHwmwyDHxQ_1773078244
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c4bde453so4317699f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078243; x=1773683043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1r9g5CqWf0hmFdhCjo01T6zVno1OvrQP8qBF9MdcaDw=;
 b=RuRWnE8Gkb6hUaHHY80aLu4+DUX79Kjiaieq/xkVI48efAsStFPdsXELAwuQsbXXr2
 qYAHg+6McI3HGU8YYKyPvl5XVpZ/PapSLUNCVZC4dirzFzWsfj4rAUb2RsKrT1hSJc5R
 UyouD6ngPw+rQ4mpNTDPalGmyyk5i7Tzy18/3RR+72HurcOAvA57qkrSQ8Cs2sGgln5I
 pycoz2pgWfI+4r4E2lbbNcBtJ9ARHp9N6hcgQw6Z+Q+2jNWHl7hQTweBhpnfyE0b6ijs
 rpEs4iKPXptEl0AeZz2JBhI8GadIZ6cdEnOvGoMfYctT2tTJ5zh3SMZ3K8lvvmImF3Gh
 KzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078243; x=1773683043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1r9g5CqWf0hmFdhCjo01T6zVno1OvrQP8qBF9MdcaDw=;
 b=Ev2Y7s3bdhutvkIRq5rA5LmhTkNSHQlqbDG30UEPFKZAw30Ow4iby24qkF+lW4H61k
 2vjCXwow2s7sVpex9pq41rKMhNLfytIaYoxval5bKmWepK+w55KDzIHEedEcKroF0a+1
 BCzey7BQ56STF47w7zUaUOZifskc8wCUk3BZaUJGccnb099vZwgs62+Hi0p15a2E1klZ
 W2PXdLXTd3tMkghza5uAic4Qwo6yjF3ndIjqybaRiAvhoK8hU68xz7CKQ7ZM+AmC+0F9
 D7lLOK9AwugXxZ/mRzWC91X1fdh/zzVcLnaCXfbYfmXFGuo9yp4R3UwugR346OyT6Rsw
 MlzA==
X-Gm-Message-State: AOJu0Yx9YZaO3+JugLcj6FdKOQtMDNwwquJAyfxEmWkqIHYSIPYvaNFJ
 z2vdTAVTQxEsVDWbnIBYrf9q0VxuprXv0cbDu2I4O7U+OD+EhFgQ+O5Y+TVroQGcq2kZt4WtbEV
 aUTWOZn0QtJ6r7BjUOkSYQ5fpJvyv8ZRNxgL/feLeyBK06hcLYGamTtbjBGyu8G/MP8cNFgzKFQ
 JTECJNAje9nlSi0KMnlJb+UO0dYX/05tdQwBs2rLQo
X-Gm-Gg: ATEYQzzHDltjdGLQSgIEesumHrF92Lrn2o1dyTKw7mX3tAjBnK/ghtyx3fbv+idPD8D
 PUDVQfjDjrlrp/w+rfsSyaE74HFWDqYhONcTyLPLZ0iNi/v9IrzVEYbHjsa2D6FRQEewgp9Y5Rc
 j97YPDGR6Bfpy2nI5BuqFUhAn1aHXmAQNgyoq3Rk+2PMLZvR/9IrQZP6CYLQ1QkGHL1BrJhN45N
 Gyij4Pw7tcn3Eggpefz7l9MTCqnMYJyGAwAesx9dVTo/IF8ND3UfNQKvVFAMkGBnac4maPDyZOE
 z+Ab86U2BFdPEU0GnAMImH2mIRGL2r6OF/qWQy9NZew7RILXqSDwAGWjvFUOuCHorVbhhPLBwdc
 tf8/7I5gglwD2mKpD4RqlkPAHUdWfAC9SQXIW1MclOJPolSc0qNJFlE7QDVhs5rkri89LDODlYx
 M6ou0amAl1GXnip/DnkKMNp6zrS8A=
X-Received: by 2002:a05:600c:3593:b0:485:3c7f:527e with SMTP id
 5b1f17b1804b1-4853c7f53cemr54268495e9.15.1773078243538; 
 Mon, 09 Mar 2026 10:44:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3593:b0:485:3c7f:527e with SMTP id
 5b1f17b1804b1-4853c7f53cemr54267895e9.15.1773078242998; 
 Mon, 09 Mar 2026 10:44:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dd017sm95189205e9.2.2026.03.09.10.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:44:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 10/10] whpx: i386: remove SIPI trapping
Date: Mon,  9 Mar 2026 18:43:40 +0100
Message-ID: <20260309174340.52174-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

The implementation in Hyper-V works fine and the code
currently present doesn't handle x2APIC correctly anyway, so
remove it and use the implementation in Hyper-V.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-10-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 97 -------------------------------------
 1 file changed, 97 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b095c96962d..4d5d3dbd243 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1692,100 +1692,6 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = whpx_handle_halt(cpu);
             break;
 
-        case WHvRunVpExitReasonX64ApicInitSipiTrap: {
-            WHV_INTERRUPT_CONTROL ipi = {0};
-            uint64_t icr = vcpu->exit_ctx.ApicInitSipi.ApicIcr;
-            uint32_t delivery_mode =
-                (icr & APIC_ICR_DELIV_MOD) >> APIC_ICR_DELIV_MOD_SHIFT;
-            int dest_shorthand =
-                (icr & APIC_ICR_DEST_SHORT) >> APIC_ICR_DEST_SHORT_SHIFT;
-            bool broadcast = false;
-            bool include_self = false;
-            uint32_t i;
-
-            /* We only registered for INIT and SIPI exits. */
-            if ((delivery_mode != APIC_DM_INIT) &&
-                (delivery_mode != APIC_DM_SIPI)) {
-                error_report(
-                    "WHPX: Unexpected APIC exit that is not a INIT or SIPI");
-                break;
-            }
-
-            if (delivery_mode == APIC_DM_INIT) {
-                ipi.Type = WHvX64InterruptTypeInit;
-            } else {
-                ipi.Type = WHvX64InterruptTypeSipi;
-            }
-
-            ipi.DestinationMode =
-                ((icr & APIC_ICR_DEST_MOD) >> APIC_ICR_DEST_MOD_SHIFT) ?
-                    WHvX64InterruptDestinationModeLogical :
-                    WHvX64InterruptDestinationModePhysical;
-
-            ipi.TriggerMode =
-                ((icr & APIC_ICR_TRIGGER_MOD) >> APIC_ICR_TRIGGER_MOD_SHIFT) ?
-                    WHvX64InterruptTriggerModeLevel :
-                    WHvX64InterruptTriggerModeEdge;
-
-            ipi.Vector = icr & APIC_VECTOR_MASK;
-            switch (dest_shorthand) {
-            /* no shorthand. Bits 56-63 contain the destination. */
-            case 0:
-                ipi.Destination = (icr >> 56) & APIC_VECTOR_MASK;
-                hr = whp_dispatch.WHvRequestInterrupt(whpx->partition,
-                        &ipi, sizeof(ipi));
-                if (FAILED(hr)) {
-                    error_report("WHPX: Failed to request interrupt  hr=%08lx",
-                        hr);
-                }
-
-                break;
-
-            /* self */
-            case 1:
-                include_self = true;
-                break;
-
-            /* broadcast, including self */
-            case 2:
-                broadcast = true;
-                include_self = true;
-                break;
-
-            /* broadcast, excluding self */
-            case 3:
-                broadcast = true;
-                break;
-            }
-
-            if (!broadcast && !include_self) {
-                break;
-            }
-
-            for (i = 0; i <= max_vcpu_index; i++) {
-                if (i == cpu->cpu_index && !include_self) {
-                    continue;
-                }
-
-                /*
-                 * Assuming that APIC Ids are identity mapped since
-                 * WHvX64RegisterApicId & WHvX64RegisterInitialApicId registers
-                 * are not handled yet and the hypervisor doesn't allow the
-                 * guest to modify the APIC ID.
-                 */
-                ipi.Destination = i;
-                hr = whp_dispatch.WHvRequestInterrupt(whpx->partition,
-                        &ipi, sizeof(ipi));
-                if (FAILED(hr)) {
-                    error_report(
-                        "WHPX: Failed to request SIPI for %d,  hr=%08lx",
-                        i, hr);
-                }
-            }
-
-            break;
-        }
-
         case WHvRunVpExitReasonCanceled:
             if (exclusive_step_mode != WHPX_STEP_NONE) {
                 /*
@@ -2249,9 +2155,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
-    if (whpx_irqchip_in_kernel()) {
-        prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
-    }
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
-- 
2.53.0


