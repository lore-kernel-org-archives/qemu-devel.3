Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4409D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hY-00020f-RC; Fri, 12 Dec 2025 10:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hX-0001z1-RD
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hW-0005iL-CQ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33QlZAhGXHGFDxYNTuc7M9dXD1Jmdy+6/iC4UFNG7jM=;
 b=bKZxlpdgx8l5wPsvs+apukiKLHIn1JUttOlZgVovWBzoueU32E4qsv6Ik46ORruWY6Pm/X
 BqHuB5jhBnwhm906JbAMySKhJeudGgIacl3Byyb6Pw0GmUE0UEVwC2tul9BTDo3WTJ+O0q
 NX+76rwbxhwnUdQRhQiS19NG4szG07s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Q6_suZTtMLitH1vPAtlwcQ-1; Fri, 12 Dec 2025 10:04:56 -0500
X-MC-Unique: Q6_suZTtMLitH1vPAtlwcQ-1
X-Mimecast-MFC-AGG-ID: Q6_suZTtMLitH1vPAtlwcQ_1765551895
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29be4d2ef78so24282975ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551895; x=1766156695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33QlZAhGXHGFDxYNTuc7M9dXD1Jmdy+6/iC4UFNG7jM=;
 b=S1uWxX83NwpMz4YOWJU9opc7t3JrH02VXRfd4cC7dc46tjyW/xxBpeyntDW35qqML1
 NBY6X+Tt4vWk5uEA/dtFfUj8mkf2eN/kxXgDc8L/kBVoRKK37DyYKesvR5PKw5o6SsPv
 lN58VrU4WGnWJyZMUUJqVLX9yprlTVHKozVtU/swtLCUhfMG/aF+/+2aIbxJrSfNYy+m
 XR/pSebZWPVeVPmXRiw652I/6/dQ7qS9aRH8swLROsOYYJjlX9ALamkZGqr0Ee3dBCHp
 KXHLNKoDOZg9MjBhink5CwpsWnFPBsUloblsEYYnVTOCGbm0tViB7Mz7sDNBm7JgwHNx
 7uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551895; x=1766156695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33QlZAhGXHGFDxYNTuc7M9dXD1Jmdy+6/iC4UFNG7jM=;
 b=Ri9MGwXZqIlCyCNZ/nB9lm1dYY37cleMkLVIKo3W2qAYGHr2BkYB9e4TaCnd8RDXtj
 G73mStDElRnqhXCOPShkvLw8G6kG0VcOm8pS5f4wY8V/VFVa3WVmg9KKwmSpMBWmlBVy
 JNUKUWoG1qRnBKP8le/rajHpDbt7kTN9TzWnShkq3af59243U30bfcl3RbHK7yjAUxkr
 6vzz1pM6NnF9H92+SJ8vs8vFs6+RdR2za/gqK//Ds6srndJ24mcKZhA+lEnGeQIGwkoW
 pjr9AcGPDCt8XkzCdkMdnqhM4DvoqEWowTQayNAPW8Xvt37F0paEvHla3NkrO/crKZ59
 LbUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIk1o7NTDiABQ4YTEKvqRDNvTSQR6c28+zBYb02tSoL8SQndUrxFzg91D+Sjajg38d6+pZHbL0tG5W@nongnu.org
X-Gm-Message-State: AOJu0Yzx45gPJNN/EJ7wYEQUMJcy8EIZdusEhLrfk9nA0gc5L7ECbBHr
 VLBimvYsD9dgJg3+5go4eqxrxIoz2AJrTrgp7iiQFH7vT4Bo7pCxHBHniYYOE82DLQrry0JfvEJ
 STanZDff78xgrBdD9cjaKZmwrDa4wgI5NWipu2jTWGtD/QvmDXoVlqRyD
X-Gm-Gg: AY/fxX44x1kscX1Vjv/Co5BbN7WS46HCaZvHaNwDkPOvIb7zwi+ib3uIb/mZm0b47B/
 LpWU1FszNBvYMFwYNOGAEgeHQa9NQ2KiT17ylYYc2uZkKXPhtUQyiRaE51eqGzoc+5Hjmqm6Gmn
 HBe1acc0II5Fhm2W57YBAQQYviZ6FyiUOUDAohpHB+8AeiABSXC3FJe/l6bbu5Tg5xkBqg4eh5n
 p0tWUWOK+dEOpahofO2wAVhXJtc6ExCk8s6GT6zr56bgt6oaHj4usDyg1LUaktcZf49RFC/8D0O
 MgFy2fxPKJrdrNePrIGW1CtPQciAH2IKlYYDwasxoBi/krZVK0oiU8/fsUDPzSmcV+6LcbT4m0T
 QFcWXjEChUjlvV3tSAuiJL2V0tRQ9LWrR1sXoBDzTVuY=
X-Received: by 2002:a17:903:1aa8:b0:29e:9387:f2b7 with SMTP id
 d9443c01a7336-29f23de5f93mr22685875ad.11.1765551895150; 
 Fri, 12 Dec 2025 07:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmliy17NoT9CiscMYxPRgRHMqJ1Rk/M5PpK27wtcCKth2RCOVldpTXTYQq/2I2N1+rv1xg1g==
X-Received: by 2002:a17:903:1aa8:b0:29e:9387:f2b7 with SMTP id
 d9443c01a7336-29f23de5f93mr22685435ad.11.1765551894711; 
 Fri, 12 Dec 2025 07:04:54 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:54 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 09/28] kvm/i386: reload firmware for confidential guest
 reset
Date: Fri, 12 Dec 2025 20:33:37 +0530
Message-ID: <20251212150359.548787-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When IGVM is not being used by the confidential guest, the guest firmware has
to be reloaded explictly again into memory. This is because, the memory into
which the firmware was loaded before reset was encrypted and is thus lost
upon reset. When IGVM is used, it is expected that the IGVM will contain the
guest firmware and the execution of the IGVM directives will set up the guest
firmware memory.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e971f5f8c4..199a224dbf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -50,6 +50,8 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
+#include "qemu/datadir.h"
+#include "hw/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/kvm/xen_evtchn.h"
 #include "hw/i386/pc.h"
@@ -3254,6 +3256,22 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
 
 static int xen_init_wrapper(MachineState *ms, KVMState *s);
 
+static void reload_bios_rom(X86MachineState *x86ms)
+{
+    int bios_size;
+    const char *bios_name;
+    char *filename;
+
+    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+
+    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+    load_image_size(filename, ptr, bios_size);
+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+}
+
 int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
 {
     Error *local_err = NULL;
@@ -3272,6 +3290,16 @@ int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
             error_report_err(local_err);
             return ret;
         }
+        if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+            X86MachineState *x86ms = X86_MACHINE(ms);
+            /*
+             * If an IGVM file is specified then the firmware must be provided
+             * in the IGVM file.
+             */
+            if (!x86ms->igvm) {
+                reload_bios_rom(x86ms);
+            }
+        }
     }
 
     ret = kvm_vm_enable_exception_payload(s);
-- 
2.42.0


