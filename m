Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA34AC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYd-0004T7-HZ; Sat, 08 Jun 2024 04:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYT-0003dv-Ok
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYS-0000LI-3e
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pQ5Er/NEdCVoAtuU67mW13Q59cMmGe2/F/7mqRXaRo=;
 b=S172ECvQi6p8netse9ypS/oMG27kDbQPbrUdNdxMU8ygZDyCAVRr3GJ0Ym9MOKavwMTGYQ
 EsBX48ukdVHaoGsvbLN3NQRx2thD3HOkph0pAPI+bfPUSTJHXnwKByUvEgQX0CHRSgJsGW
 mFZvT6Es4Ggbwaf9WqVNZ5gCwirH6pI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-wf7FL_ZkN2irI2zx4_p_Zw-1; Sat, 08 Jun 2024 04:35:57 -0400
X-MC-Unique: wf7FL_ZkN2irI2zx4_p_Zw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c70b484c5so78497a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835755; x=1718440555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pQ5Er/NEdCVoAtuU67mW13Q59cMmGe2/F/7mqRXaRo=;
 b=Ix8451EeQkz/Xe5GbVv7NDJ+mQbEZQU9CAqHkujLdTr+mL/C9xYdS5MARB2klsCUJS
 4GzlkB5e6wLgK7o3WmHFLlzDlVzIVSNdB5mrxnRfdudM4kHIWxwARPrnwhEZCLMA02vn
 6XgbWwX3unD4WD4cpZTM4zkJIbKXemJatzyLLLZ65I607n2elgNJ1FIWast3iiN+P2rT
 PkHxk6HYf2296CMoDISa8YjZXDmMdfI974OREpJIW2P1CCQC+gouFY2EfPUtU3TEroqi
 MVJEWxEsMBNEPkKA5QK1AWcZGMsyQIUIcS1xWP0gVkKuJxJVKANkyrlhUxnukYCZI+jK
 buPg==
X-Gm-Message-State: AOJu0YwLWcknZvtr36efVD4CYkB1dKtGOufINsJyvOG492dF4N9VIhSc
 9GHQhGsnIQnrVA1uIvtwRo1tGD3kOkTjNpWdwaVTc5Rs4AJR3T9gpJFHT2DkY9HN5NzEXR+7VYB
 FOm7WF3zkhabHlX3nrt3XtI0lUHRXFCFeNLhQ7Y0ExnsSamfs9IaXlKunanw2ska2OyCbDfoBWe
 xi4imAzaAwMpnA/wN22HGv7ktXrIjpzGdDUsvB
X-Received: by 2002:a50:9f25:0:b0:57a:6ed5:b327 with SMTP id
 4fb4d7f45d1cf-57c508e1f3dmr3112986a12.12.1717835754964; 
 Sat, 08 Jun 2024 01:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhxrJpMz4UWUDt1yNq0Po5homi6nU35ddzjCl9/U7XRjPDOxNT2e+KLPzXVRWAkY9Bx9y0Gg==
X-Received: by 2002:a50:9f25:0:b0:57a:6ed5:b327 with SMTP id
 4fb4d7f45d1cf-57c508e1f3dmr3112974a12.12.1717835754597; 
 Sat, 08 Jun 2024 01:35:54 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0cc355sm4015571a12.33.2024.06.08.01.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>, William Roche <william.roche@oracle.com>
Subject: [PULL 38/42] i386: Fix MCE support for AMD hosts
Date: Sat,  8 Jun 2024 10:34:11 +0200
Message-ID: <20240608083415.2769160-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Allen <john.allen@amd.com>

For the most part, AMD hosts can use the same MCE injection code as Intel, but
there are instances where the qemu implementation is Intel specific. First, MCE
delivery works differently on AMD and does not support broadcast. Second,
kvm_mce_inject generates MCEs that include a number of Intel specific status
bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.

Reported-by: William Roche <william.roche@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
Message-ID: <20240603193622.47156-2-john.allen@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  2 ++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 39 +++++++++++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 29d799adfd6..e6d5d1b483c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -377,6 +377,8 @@ typedef enum X86Seg {
 #define MCI_STATUS_PCC   (1ULL<<57)  /* processor context corrupt */
 #define MCI_STATUS_S     (1ULL<<56)  /* Signaled machine check */
 #define MCI_STATUS_AR    (1ULL<<55)  /* Action required */
+#define MCI_STATUS_DEFERRED    (1ULL<<44)  /* Deferred error */
+#define MCI_STATUS_POISON      (1ULL<<43)  /* Poisoned data consumed */
 
 /* MISC register defines */
 #define MCM_ADDR_SEGOFF  0      /* segment offset */
diff --git a/target/i386/helper.c b/target/i386/helper.c
index f9d1381f90b..01a268a30bb 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -91,6 +91,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     int family = 0;
     int model = 0;
 
+    if (IS_AMD_CPU(env)) {
+        return 0;
+    }
+
     cpu_x86_version(env, &family, &model);
     if ((family == 6 && model >= 14) || family > 6) {
         return 1;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b5635209812..55a9e8a70cf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -638,17 +638,40 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
-    uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
-                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
-    uint64_t mcg_status = MCG_STATUS_MCIP;
+    uint64_t status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_MISCV |
+                      MCI_STATUS_ADDRV;
+    uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
     int flags = 0;
 
-    if (code == BUS_MCEERR_AR) {
-        status |= MCI_STATUS_AR | 0x134;
-        mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
+    if (!IS_AMD_CPU(env)) {
+        status |= MCI_STATUS_S | MCI_STATUS_UC;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_AR | 0x134;
+            mcg_status |= MCG_STATUS_EIPV;
+        } else {
+            status |= 0xc0;
+        }
     } else {
-        status |= 0xc0;
-        mcg_status |= MCG_STATUS_RIPV;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_UC | MCI_STATUS_POISON;
+            mcg_status |= MCG_STATUS_EIPV;
+        } else {
+            /* Setting the POISON bit for deferred errors indicates to the
+             * guest kernel that the address provided by the MCE is valid
+             * and usable which will ensure that the guest kernel will send
+             * a SIGBUS_AO signal to the guest process. This allows for
+             * more desirable behavior in the case that the guest process
+             * with poisoned memory has set the MCE_KILL_EARLY prctl flag
+             * which indicates that the process would prefer to handle or
+             * shutdown due to the poisoned memory condition before the
+             * memory has been accessed.
+             *
+             * While the POISON bit would not be set in a deferred error
+             * sent from hardware, the bit is not meaningful for deferred
+             * errors and can be reused in this scenario.
+             */
+            status |= MCI_STATUS_DEFERRED | MCI_STATUS_POISON;
+        }
     }
 
     flags = cpu_x86_support_mca_broadcast(env) ? MCE_INJECT_BROADCAST : 0;
-- 
2.45.1


