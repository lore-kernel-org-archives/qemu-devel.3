Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E3FC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuK-0003fR-LH; Mon, 12 Jan 2026 08:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHto-0002zt-Nk
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtn-0003l5-A9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APFw32lDHGb6vJ+fHAcwZMep7Yabt12YehNL48qlxeE=;
 b=chvy+x43U+fISDM/pQS0kH07dwd4Ik+bupte/yyQHVdhNs76vCP+FIGA0oxQhiH71ZmRDP
 dKyLRZTbm2tnE3DlwWK6OUVvU3oGAf4Vo2rcbgua04gpXRkMBK9nHhMF9ioDispo9Hb2RV
 0Nbt2JT/yGvPze3/q9poZL4uKM9rKN8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-2dyuJqSbNeKKfix8242qeA-1; Mon, 12 Jan 2026 08:23:57 -0500
X-MC-Unique: 2dyuJqSbNeKKfix8242qeA-1
X-Mimecast-MFC-AGG-ID: 2dyuJqSbNeKKfix8242qeA_1768224236
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-81f404f4165so1139377b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224236; x=1768829036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APFw32lDHGb6vJ+fHAcwZMep7Yabt12YehNL48qlxeE=;
 b=rUPyzJWxAHxviaCBY7VemyDpv1FYogvVQUAwWRQdRQpTMZgeuBEt9LtAS1A9g/kccR
 I1lrt/PpYL5fcDcZ7aO/Waz6QuPCAt52bEgHSk6iBWjpKb4EWJcI8jW2IdnVsESRDD4a
 twVnFO4LEphW8KbQ0jjAliLhiNlo9MRmzrs1DNdf1sIpZDeBtr4A/nOHntx0WhCrR1uD
 E+LYn1bK+gp1a7HBAN1z1CDR6eAvAesKMtyZXMqoqwBfMZc46R1VCN0mjqVebX1tH4c+
 FwizijJ3wvclYd1HPa6Nkc2LRhB/i0tLWwESGROap/b3R0RpjN39aNYjc0cG+2NZ16Ib
 luIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224236; x=1768829036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APFw32lDHGb6vJ+fHAcwZMep7Yabt12YehNL48qlxeE=;
 b=herZUKsx0LiGexaWoDCjPsZTx2B++GXnYGgJSMGyuE9QjhHh+fJeTnvVvSs//CSe8n
 l86X0Wv4iEI2K/z2sDnNeYzasDo94IYoUlhWnyVFVeI+lrA8c6olZd+8ZMHz1zgheuTt
 SQegiGt5sc72wvkJUVoRgBdCISQVC/BwS+V2DRCAYeYad4rMPJD2DcxT7IaIFky6Ku3u
 6iQkaw6EYFDvMDlgkFGa2iWSr/FugNm+6vpFVpOULDZM5TuvtQW05zjbn6Uoj/DrFT2t
 tU7Q7OpfijhrCtupf9/QYDwtmmnVoC99QBmtHF9xDAVlVFOAqKeQKxbzYoe8yVsGxcJ7
 fqwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHR5DzyfmxMWVHIbPm9DyBvlC9tU/GeUDWjpg5j6C5lKmIUrsbvzGAh9bJA8SXDvdMeQJ4dYBe1rZZ@nongnu.org
X-Gm-Message-State: AOJu0Yxya0r7xc76lbK2zCEieT38j0mZffxnsFRXUbCJFUl22BlVNvyG
 FmL5mgsvBk7STrq0j+aT6ko4FjS2BAKNGktWCUGJN29p9Px4kh4TDnoc4gWqhRTV7XQTXx3mByp
 idMXfOYdBpIr7xE8oHGlKrLge8C+0Zf6Lyw+t/CrgwJ/rftcfHPXKcoYt
X-Gm-Gg: AY/fxX5LDK6afaFtc8Ny0H8xIs6s1UHfu1imsYIx+5UkBd3AJF9ADKlHok29CNjMH62
 NQCqTT4Qwo3Q00BH2kd0Xwx/vRZzVkf5yQhJq7TcAkZEDWogSaJw+93MJt9ftrYZhQ3EtAwIcb9
 HeKcFluknliooLljXuA8emE6I1j7XI8mHCe2E41XE3ionlFx6dz6/fgizYpwbD1Gl7sDDYQb77S
 FfLQMRCPtAl7XxSHygEQZj0Nxk3cI/5mCJKrS2VwNysKBC5HlIkOaVr3WPTvF9m5peVrWK2xDs9
 A1AGoKuNKNaDuEz3sXAF/tvFfiTI1pvYt+3IsriZFeiqTZGW5StHnkyabEs6Sp+4BQbJh2dBlY2
 VWWMY4a+1SLza345QIYc9YTqBaZ4aDYoU6AY6Kwz8x0Y=
X-Received: by 2002:a05:6a20:7d86:b0:334:9b5d:3876 with SMTP id
 adf61e73a8af0-3898f8f5751mr15608236637.4.1768224235803; 
 Mon, 12 Jan 2026 05:23:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdnnEq/+4QREmK7Kwrw2WpnnCo0brli7EYMdGC71kOXLi8N0UspIFsrwXTnchK1WCgIs9ahA==
X-Received: by 2002:a05:6a20:7d86:b0:334:9b5d:3876 with SMTP id
 adf61e73a8af0-3898f8f5751mr15608223637.4.1768224235424; 
 Mon, 12 Jan 2026 05:23:55 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 11/32] kvm/i386: reload firmware for confidential guest
 reset
Date: Mon, 12 Jan 2026 18:52:24 +0530
Message-ID: <20260112132259.76855-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 4fedc621b8..46c4f9487b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -51,6 +51,8 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
+#include "qemu/datadir.h"
+#include "hw/core/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/kvm/xen_evtchn.h"
 #include "hw/i386/pc.h"
@@ -3267,6 +3269,22 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
 
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
@@ -3285,6 +3303,16 @@ int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
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


