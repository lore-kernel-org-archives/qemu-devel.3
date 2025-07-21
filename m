Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADEFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtGK-0007pM-2x; Mon, 21 Jul 2025 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1udtF5-0005xu-KA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1udtF1-0000eZ-Eu
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SvOFlCZsGOepa3TDlS91hN3f1Vv0H5iFYz4c6XJmP5I=;
 b=CdlQ6HlfA6qehDCGxt8Dyr4Q+IdXTQwmguTdmRkWp2440EGN4WSETramQDEis28dt2FvuQ
 I54EBqoVzHA3OcVb0X8dA/ngc/m/cRp4KheOI4ZH4lS/PMk0gvWgajLY7Qsltet/xoO0tm
 sl7vY8GC2vgncAIhjRrPxLlc6n3a5ow=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-QX-10pagNbO5Mww3nAJPUw-1; Mon,
 21 Jul 2025 12:19:45 -0400
X-MC-Unique: QX-10pagNbO5Mww3nAJPUw-1
X-Mimecast-MFC-AGG-ID: QX-10pagNbO5Mww3nAJPUw_1753114785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953E11800291; Mon, 21 Jul 2025 16:19:44 +0000 (UTC)
Received: from gondolin.str.redhat.com (pixel-6a.str.redhat.com
 [10.33.192.205])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 933DC30001A4; Mon, 21 Jul 2025 16:19:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH RFC] arm/kvm: report registers we failed to set
Date: Mon, 21 Jul 2025 18:19:32 +0200
Message-ID: <20250721161932.548668-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If we fail migration because of a mismatch of some registers between
source and destination, the error message is not very informative:

qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
qemu-system-aarch64: Failed to put registers after init: Invalid argument

At least try to give the user a hint which registers had a problem,
even if they cannot really do anything about it right now.

Sample output:

Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)

We could be even more helpful once we support writable ID registers,
at which point the user might actually be able to configure something
that is migratable.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Notes:
- This currently prints the list of failing registers for every call to
  write_list_to_kvmstate(), in particular for every cpu -- we might want
  to reduce that.
- If the macros aren't too ugly (or we manage to improve them), there
  might be other places where they could be useful.

---
 target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 667234485547..ac6502e0c78f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -900,6 +900,24 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
     return ok;
 }
 
+/* pretty-print a KVM register */
+#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
+    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
+               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
+
+#define PRI_CP_REG_ARM64_SYSREG(_reg)                    \
+    ({                                                   \
+        char _out[32];                                   \
+        snprintf(_out, sizeof(_out),                     \
+                 "op0:%d op1:%d crn:%d crm:%d op2:%d",   \
+                 CP_REG_ARM64_SYSREG_OP(_reg, OP0),      \
+                 CP_REG_ARM64_SYSREG_OP(_reg, OP1),      \
+                 CP_REG_ARM64_SYSREG_OP(_reg, CRN),      \
+                 CP_REG_ARM64_SYSREG_OP(_reg, CRM),      \
+                 CP_REG_ARM64_SYSREG_OP(_reg, OP2));     \
+        _out;                                            \
+    })
+
 bool write_list_to_kvmstate(ARMCPU *cpu, int level)
 {
     CPUState *cs = CPU(cpu);
@@ -932,6 +950,41 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
              * a different value from what it actually contains".
              */
             ok = false;
+            switch (ret) {
+            case -ENOENT:
+                error_report("Could not set register %s: unknown to KVM",
+                             PRI_CP_REG_ARM64_SYSREG(regidx));
+                break;
+            case -EINVAL:
+                if ((regidx & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
+                    if (!kvm_get_one_reg(cs, regidx, &v32)) {
+                        error_report("Could not set register %s to %x (is %x)",
+                                     PRI_CP_REG_ARM64_SYSREG(regidx),
+                                     (uint32_t)cpu->cpreg_values[i], v32);
+                    } else {
+                        error_report("Could not set register %s to %x",
+                                     PRI_CP_REG_ARM64_SYSREG(regidx),
+                                     (uint32_t)cpu->cpreg_values[i]);
+                    }
+                } else /* U64 */ {
+                    uint64_t v64;
+
+                    if (!kvm_get_one_reg(cs, regidx, &v64)) {
+                        error_report("Could not set register %s to %lx (is %lx)",
+                                     PRI_CP_REG_ARM64_SYSREG(regidx),
+                                     cpu->cpreg_values[i], v64);
+                    } else {
+                        error_report("Could not set register %s to %lx",
+                                     PRI_CP_REG_ARM64_SYSREG(regidx),
+                                     cpu->cpreg_values[i]);
+                    }
+                }
+                break;
+            default:
+                error_report("Could not set register %s: %s",
+                             PRI_CP_REG_ARM64_SYSREG(regidx),
+                             strerror(-ret));
+            }
         }
     }
     return ok;
-- 
2.50.0


