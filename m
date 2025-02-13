Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC841C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 09:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiVjB-0001Dd-Ew; Thu, 13 Feb 2025 04:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tiVix-00017y-Kq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 04:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tiVis-0002uY-5u
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 04:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739439688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dhNM2XS2aMoLSfuWj7PxKqJ+8mLVG9Kal2ka5HJ22aY=;
 b=FxXN59sFbnw8euh7FFn1bbGuYx7TpP3IUGW/759GQjtKHWhnudgCjft9nPI646w44EG71H
 jt84pm/UA9BJK6h1ZZi0SBLYjto88k80oucHcjSOOXbl6qff7Q2U303bKj4ah8Pmp99iON
 YTFn8ItoQA3UbrPxPMv6PJcNCUH9bVQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-cwv_Q1MOPhmWMxC0XQMUvQ-1; Thu, 13 Feb 2025 04:41:26 -0500
X-MC-Unique: cwv_Q1MOPhmWMxC0XQMUvQ-1
X-Mimecast-MFC-AGG-ID: cwv_Q1MOPhmWMxC0XQMUvQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fa166cf656so1623379a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 01:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739439685; x=1740044485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dhNM2XS2aMoLSfuWj7PxKqJ+8mLVG9Kal2ka5HJ22aY=;
 b=RMXooKLhp37s7EzlWTOt6/JanASrl+UoavC8x8AM5GOSu3x9tLi+qVMq5Tpfibe4je
 oGON8jnj1QE9Qwla/fV9EOPxg5WeUXd2/JRIjvjsNG9THuCnl08Pxx05FiL+Z7UTm9Ef
 p5wmUZB/kudrfYS9yNOX1jDn6Km/0cN/wPF0Y+wDu2XrlWd44uzUSbJSUbvaccRgqHiG
 s/GMptvUDCIi6JHSfzSxsK7fYXPxRxjknCu3rivHbvOn/bT5xGwLJFd8EYmmQ718y+Dk
 n9Hd/NmwBjwONfn17Q395VZvDgqB8YSEj4FzXToXBkhfzSWbimxGmoJxfjNjNpeNg6pq
 KVNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW98diyT+x7ygu65jD7T6YbYMwh6NlW28/rdDvAmgmkLF2OWAupCKt3bwD4g2ijpIsB/20stw4rk8nN@nongnu.org
X-Gm-Message-State: AOJu0YyjzaUcNpsyX0P5s+X2f3OlyzZbvNQ9tK4ck0shmkh2SpPOxC9L
 rrzcixJBsgSgaF6PlKBSg+Ht5TgnxRn1pvvm7Q/DQ2s4FVzWSmsPqs9d5IzE7tn9RoQ4stKCIC3
 nzOssbVOXZ0td7CBpS7UaLSRHuFwyprWnSip+caWebTcWDcifKWm2
X-Gm-Gg: ASbGncu30yKWBFAAsgjYcVFBm4a822kuElVfCbhdcvzoybViGBrB8Rku4h6UVd3virC
 tuVrceCs0zMRK1dBnAp9TGqHKNWN8ro34p9kxVSXK171XCvbxKOAqa7IHqUkxHascvUL7kgXjD6
 lonj4cTeAAVo1uEWTlAtCOMc0MDatpPL1t1RiCqS+y3W+aC8dE/YxGe1SjxcrwU6GGE/Tdl2UgX
 5gD1nwGklBYR0OGyeiXfYwXhjNbU95SWe+yQflIwpUjLShvIYKCARCjBAtgv/nJU6ZeFMDcZlnC
 4GsT+UZ72U7BIJszco3w2cyyfK9+
X-Received: by 2002:a17:90b:3a89:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2fc0e98dd17mr3553901a91.20.1739439685164; 
 Thu, 13 Feb 2025 01:41:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+NzP2XAk1pJAMNmfBevYWFmx7nvWvOMHQvQBeDfQYrS2LJR1w31cD7PARTcNFSmMzZ3R2kQ==
X-Received: by 2002:a17:90b:3a89:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2fc0e98dd17mr3553877a91.20.1739439684792; 
 Thu, 13 Feb 2025 01:41:24 -0800 (PST)
Received: from localhost.localdomain ([116.72.129.244])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab0233sm2912289a91.44.2025.02.13.01.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 01:41:24 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] microvm: do not use the lastest cpu version
Date: Thu, 13 Feb 2025 15:11:00 +0530
Message-ID: <20250213094100.129358-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

Microvm machines are not versioned and therefore there is no requirement to use
the latest cpu model by default. Let microvms use the non-versioned cpu model.
Those users who need spefific cpu versions can use explicit commandline to
select the cpu version desired.

CC: imammedo@redhat.com
CC: zhao1.liu@intel.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/microvm.c |  2 +-
 target/i386/cpu.c | 15 ---------------
 target/i386/cpu.h |  4 ----
 3 files changed, 1 insertion(+), 20 deletions(-)

Pipeline passes:
https://gitlab.com/anisinha/qemu/-/pipelines/1669159835
See also Igor's comment on
https://patchwork.ozlabs.org/project/qemu-devel/patch/20250128035526.3750043-1-anisinha@redhat.com/

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe..b8be1542ff 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -458,7 +458,7 @@ static void microvm_machine_state_init(MachineState *machine)
 
     microvm_memory_init(mms);
 
-    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    x86_cpus_init(x86ms, 1);
 
     microvm_devices_init(mms);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5dd60d281..6d251c0025 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5513,18 +5513,6 @@ void x86_cpu_set_default_version(X86CPUVersion version)
     default_cpu_version = version;
 }
 
-static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
-{
-    int v = 0;
-    const X86CPUVersionDefinition *vdef =
-        x86_cpu_def_get_versions(model->cpudef);
-    while (vdef->version) {
-        v = vdef->version;
-        vdef++;
-    }
-    return v;
-}
-
 /* Return the actual version being used for a specific CPU model */
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 {
@@ -5532,9 +5520,6 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     if (v == CPU_VERSION_AUTO) {
         v = default_cpu_version;
     }
-    if (v == CPU_VERSION_LATEST) {
-        return x86_cpu_model_last_version(model);
-    }
     return v;
 }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..71f150a05f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2701,10 +2701,6 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
 /* Special values for X86CPUVersion: */
-
-/* Resolve to latest CPU version */
-#define CPU_VERSION_LATEST -1
-
 /*
  * Resolve to version defined by current machine type.
  * See x86_cpu_set_default_version()
-- 
2.45.2


