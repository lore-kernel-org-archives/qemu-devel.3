Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A338CFCA17A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfo8-000439-Vx; Mon, 09 Mar 2026 14:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo7-00040M-H6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo5-0007rA-VG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r9g5CqWf0hmFdhCjo01T6zVno1OvrQP8qBF9MdcaDw=;
 b=NjnUAwCilAc7TiQQC5zSq+Hx1Bc1P6pTAIRhlB1jtgmAQb7thIHAsa0g+gsklVGPaEO6cV
 sMBE25HjXVrXm2siHvxA0gGHhf8/ghhklZBaGzr5UfgFwcoqA36BbA8x9naQfkin6E9gfa
 OftluuhA8pq3MYrOSFofGYJ+W5zcUkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-WvWtpYY5MpmqD0mla67jdw-1; Mon, 09 Mar 2026 14:58:19 -0400
X-MC-Unique: WvWtpYY5MpmqD0mla67jdw-1
X-Mimecast-MFC-AGG-ID: WvWtpYY5MpmqD0mla67jdw_1773082699
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c12269f3so4161967f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082698; x=1773687498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1r9g5CqWf0hmFdhCjo01T6zVno1OvrQP8qBF9MdcaDw=;
 b=UhSEd9fsI/Ac7TXVenZ+6aritHaL8nIpyCHoqANM+grXDZ/f4NPcE8fAe+NcFvymP9
 gw2G1a2v1H5yvUZMNTfaoxmUaL9MLUDnEP77BdGQRnq2BOW2yLVSo+N91eTsh650jXu6
 pt/CujVE2zl9TKkGxI12MhUJi9cUocbN9eQ1u9tboZJbCJXNBgi0uL1PAHtJnKbM0bB6
 pXF3xjLRXQ/+14gIOcMRa32NFkOxnBsOFGtKQFzJjsoTz6rIAYWO7v39QlkQ0W/rWD1/
 +pgiVEOnsZ1ThJIByAWR4VIjZo/Mt658FNE4lv5rEAxneJaHGCvqLy2qNu/hvqY/RBJk
 dUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082698; x=1773687498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1r9g5CqWf0hmFdhCjo01T6zVno1OvrQP8qBF9MdcaDw=;
 b=mPAW7KQB+gOezQwqz6Tkf/a00WDkAWBJTESIgI2UlUvdhSi0cmcrKzFkoZ/mDIyGUa
 AEKbZycJT9T2/kUg86wtYWnvgnGSQuhM9n1vqvJsNUZjPjcTQLL0umyYL55AB9EtLnuF
 CJy5LWyZjy2yUOCTmeUtY40m2YbeAlavF5WS3lxbR0ZSbxTvigD2YFhVRkwyawlE99de
 XlJu+6JL6HJXVE/wbhyXd/YPZgp7eUdk8auFQQf7Sv4l/IxBFF50tSKIbeO06LdFGxfV
 p1AYP7HlYz18t4CZzSgw8hLXaCh0oTk4rhqeYR47CsC5jtKgKBeaRjiUmPkZPmQ+o1oe
 YWbg==
X-Gm-Message-State: AOJu0YypNg3b36igdqpGFgL/3eyf4+Reoy/OWMhYrqSrtAXfTbA1EDK4
 ImCTcD8KovH1un0zvoimDd81FQcBhcwDSSgdafPF545rH6EIg8c85ujgLOM6zYAtpxsGO4/UMkC
 WedOSZhyIKSZqm179fYbHday1eOasCRR9ndh9vzhO0RTLyndpoIcQyfVKH6utc0XXoHwRh3xuaz
 N4qj2aXbSYKG6p3MfKLmNxRvDB9ftD+ETlfULQkHRG
X-Gm-Gg: ATEYQzwV7bKEuAxUfCYeB2NZ4vRMzpVSOInfokqOds9fK1Je1bKipliH3BgLJJgVy5o
 RuU6xRYXcilMFBxBl/JHuJ5EfszV9Ri6zsG35xUAU2mM/vyGC+9SpSyf8EQv9hMVpHE1FWGVANg
 i8GHGrLYc3hOxzxIT/vS+WOAk+rVEyzR7L21R5yIauxl/pMXyB3N9BVFDUNd17eWF09zVY03AJG
 sKETyxbCzSr4IvUw4LiyzWrPZNtcSaH5WvF+hGcB3ujwOCZHjw3Hapbdc71zl35aTKY/9rPGYdu
 Yo90/AD5BaNbXV66o5uafiaUPKPslo37Ba08DoiGXbGMe5MX5E3VH6UvUqOOCefQWC9RZH7BzEG
 R0UOBpww3/r2HT95ZO840V8uvrziobEhR7XujWS69L3vVqvdtTY7ZmgKEyKb1WUZkEzGeqoPRb/
 4FOnLOysUVrpz3fIssSUNuOHj9cd8=
X-Received: by 2002:a05:6000:26d1:b0:439:b486:ba6b with SMTP id
 ffacd0b85a97d-439da89401fmr21864478f8f.39.1773082697882; 
 Mon, 09 Mar 2026 11:58:17 -0700 (PDT)
X-Received: by 2002:a05:6000:26d1:b0:439:b486:ba6b with SMTP id
 ffacd0b85a97d-439da89401fmr21864407f8f.39.1773082697294; 
 Mon, 09 Mar 2026 11:58:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm27632784f8f.35.2026.03.09.11.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 10/10] whpx: i386: remove SIPI trapping
Date: Mon,  9 Mar 2026 19:57:52 +0100
Message-ID: <20260309185752.76865-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
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


