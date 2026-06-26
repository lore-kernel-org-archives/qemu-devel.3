Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9B9CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3R9-0001L0-9v; Fri, 26 Jun 2026 06:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3R6-0001KY-Ti
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3Qs-0001x8-He
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2+gt3kOaDWnp3CfzIOR5olodVGZ2w4YtxgxJ3MeOrM=;
 b=Q9anrMfOVyTXLGKVPibnP1m4vER4M+d+rk3ABDjplNDbEGwU7unBOFx9kI0DQtZDfuMFsY
 eHTeBnRmVPzOFVObkPEDzuN99+f18UG0KW2cqgiBzUlpR5hrGhtLXSsd+iiVqotBOADhnL
 E7OONy8+coRKVDcsRHOPCTYfHc0nTOw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-aQHGH912MUatwRmn76pVrg-1; Fri, 26 Jun 2026 06:05:08 -0400
X-MC-Unique: aQHGH912MUatwRmn76pVrg-1
X-Mimecast-MFC-AGG-ID: aQHGH912MUatwRmn76pVrg_1782468308
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9254309dfd4so161404785a.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782468308; x=1783073108; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m2+gt3kOaDWnp3CfzIOR5olodVGZ2w4YtxgxJ3MeOrM=;
 b=Apgq99dxh3H3njD/ZR9UaruL/NoXU+CPbKDrPFx6T8sDo5nkswsh09tpn8Ny68eikc
 Gnwmn/RrSRmv707D6YBmBwM8Ss02dWxyQroPnyg7tG66sEXYfkXrCgBy5+jLJlN6Iw5V
 ZJ/lrFYylRBzEI7QDQUB/SxYgQJewszTPa2Gi3q2YkaB7hnU0hzS6F26zb7GtFbjSQ52
 LZ90Cvar2JMSNC422qwgDU+yQ6RB5KILzje++esrF9MhjsQOcRH9tOc24fRBs+7Qpr12
 15Wpk02bTR/YUdiOMcuj/C9QQirWIAfTeKGKN3xrf/u+HkQea3L749l/aSKWcND7FLML
 a4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782468308; x=1783073108;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m2+gt3kOaDWnp3CfzIOR5olodVGZ2w4YtxgxJ3MeOrM=;
 b=YX1bhbopqB5lqfxmyqdOe9c/XZip/cWQSXUYv3f10DXEMVdvImpSDmRHNb1K5cvgS/
 HEMic8ceWJQe/kek4Qq0z1XKrB9PwzH7YG8Xu8TzlweFkXvvo0rDipmqPqjONY6GdUS+
 IAwf+CqZE59nwmYCBV6wzkZPNG8rN2bVmvWnJFsLoBrG+pjyIpVWYIGToZGQ2Vf02KB1
 6+Le0rGZzujqrfPjo6lLOxabmqn0jddupsFSlg11VMdGk7srHVEtqqGi6ybLPH7YYciW
 cNqmcLl5s5xEIJJFwSKd264v3U6zaaJtg28iKP8+Ii+mlIRoMbQSbziduYyYNG2P2FPz
 yNNg==
X-Gm-Message-State: AOJu0Yyr4iL1vEQCpueHmvSOeehfzxDCxrwzQ7c3R+6cYo5+iCyBuLfy
 dPobpAdZ3KSvmt7/whOi9xhycCKbY8s9ccwLQJi73HSVVr5LQhBLqS1CHY7ICchRzVopcPp+xsc
 XVUrhH9WKri32ScmC8MSP/760zD32wb4UEqeNDtSDY7hrZRLAuf1Wzi8EnozE/Abm
X-Gm-Gg: AfdE7clf+Z5LvPUfzjQ7v3R/7mAbvka3880Irny74M2hVwXCmH8DobuZi7U0XJXzjB4
 CvGtZXFcb1qAelIFLmxzSHMYpqASSs9r4s2aX0jBsgRHHdhR73j370uuerV7lS/UXwv1oovoocB
 m3wqFHriU5OuXb9zXSrHmf+ppkmFFf9XPF25/tpTCz66oROW26HBECNaye0sMTwCADiti1IQ+wT
 EMiPEiiZR3Ve5PM8Q6j+Tu7iXCpMOhrq1kSEkJRpVLxwAHFFqYKZHG3HlS3X+k5KmlLBCvSM9o+
 ga5SYayHh0eHkKB1Ybv8Q1YoPpthk/0fyKhid+RP3x4q3yG8PTYoiBj3iw0zGk4upKKJjVuAqNr
 8v80+Yxp/vBHSP7cmaLDnOBA9z8/r7VpLlPNAol33iTq5PQsPYMih7sj3oD2P3hG8tNRqGgvocb
 AJecmt
X-Received: by 2002:a05:620a:2727:b0:915:c615:388 with SMTP id
 af79cd13be357-9293d5b583bmr878359285a.55.1782468307970; 
 Fri, 26 Jun 2026 03:05:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2727:b0:915:c615:388 with SMTP id
 af79cd13be357-9293d5b583bmr878353885a.55.1782468307466; 
 Fri, 26 Jun 2026 03:05:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd390e76sm1122716485a.3.2026.06.26.03.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:05:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 26 Jun 2026 12:04:01 +0200
Subject: [PATCH v6 1/3] igvm: Report error on missing parameter area in
 directive handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-microvm_device_tree-v6-1-9cd13cf057e2@redhat.com>
References: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
In-Reply-To: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Parameter areas are how an IGVM file tells QEMU to allocate buffers
for runtime information the guest needs — VP count, memory map,
MADT and so on. Usage directives reference a parameter area by index
to tell QEMU where to write each piece of data. If the index doesn't
match any declared parameter area, the data has nowhere to go and
should be treated as an error.

The directive handlers that look up a parameter area all return 0
(success) when `qigvm_find_param_entry()` can't find it. Therefore,
the load succeeds but the guest never gets the expected parameters.

Note that the IGVM library already validates parameter area indices
when the file is loaded, so this path should only be reachable with
a malformed file that bypassed library validation. This is defensive
programming against that case.

Report the error with error_setg() and return -1 instead.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c                | 26 ++++++++++++++++----------
 include/system/igvm-internal.h |  3 ++-
 target/i386/igvm.c             |  5 +++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3f4b97a5d4..a5a2a4eccc 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -81,7 +81,8 @@ struct QEMU_PACKED sev_id_authentication {
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp)
 {
     QIgvmParameterData *param_entry;
     QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
@@ -90,7 +91,8 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
             return param_entry;
         }
     }
-    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
+    error_setg(errp, "IGVM: parameter area index %u not found",
+                   parameter_area_index);
     return NULL;
 }
 
@@ -528,9 +530,10 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
         return 0;
     }
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
@@ -601,9 +604,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
@@ -660,9 +664,10 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
@@ -683,9 +688,10 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
     QIgvmParameterData *param_entry;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     environmental_state =
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 7f131c4d03..7eb3792ed8 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -72,6 +72,7 @@ struct QIgvm {
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp);
 
 #endif
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index f41b498b89..ad9bf87761 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -191,9 +191,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);

-- 
2.54.0


