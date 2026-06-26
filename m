Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FFDCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3RK-0001M9-BF; Fri, 26 Jun 2026 06:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3R9-0001LO-HT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3R7-00028s-Jk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnKvASURvZWU24SqTGG/iiMBQh4O8gIlXQs5/0TWch0=;
 b=IOZ8M/PgVpikomiYmaDqYzrnqTOtklcfC03JMn3vb7gLnlLN3sTnSEVyyZP3Q7aqZ4XwIc
 snsztmCuoHv+iUqhyaGQTC8TY540Zdbs+a58XrYwFlD0uklPOvDS6C6ARz0SJf0j+N9B8T
 85Kc9ruaaZRmYtGLmkhMORLwVnN+TGI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-5EcbY8rGOK-7-ls355U0xA-1; Fri, 26 Jun 2026 06:05:13 -0400
X-MC-Unique: 5EcbY8rGOK-7-ls355U0xA-1
X-Mimecast-MFC-AGG-ID: 5EcbY8rGOK-7-ls355U0xA_1782468312
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bd797e447cso746627e0c.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782468312; x=1783073112; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XnKvASURvZWU24SqTGG/iiMBQh4O8gIlXQs5/0TWch0=;
 b=bazYaztZZqna/XVjCmdewCsF6CJoEhru7tyI2uYdx27XtQPlPAqb0tW1Ku/Qvb7bDr
 5f+dyjtbQgdyaLjgp0lqpGnzsTS7ypB8DvmvpGCaEitkoYO5ezps9Lb95MByDS2lHSCD
 WrS4BmkQVUANObmpLsVCOnB867RxrJinnYa1zU6uIk6JcBm6LDlRubWK7u/+Gxy0ZEmi
 xEJ63zA3Y7T5RzS21s8CQ4Hm592nUQ1tqxledIZ1KSFt2F6MUcJU7DNm32Prb985yJOG
 AkBQTJUxiAqE/bhr4F3YSsPfs9Eh2TABCXTD8dQvF54iy084bLWPyaoxrBknMRT6KIM0
 6PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782468312; x=1783073112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XnKvASURvZWU24SqTGG/iiMBQh4O8gIlXQs5/0TWch0=;
 b=jZrkGVz5xUEyFJit95A5AaJPVEDnGutaoOBwXSNOcjcaLj/7zU0RzwU3q4twik0dj1
 24oHuLSQmnleOEhcJ55rVsXSAkE3AUeky1zGzET7vPZSQZOF+V+DTHTiaelvY3j0HPgo
 9ZAvfamoAyskV9Bkh0B1TycbYsS7P87Yjb951Z9dG+jE9vSAnwKSX6g22ReqjiRaZlGJ
 n3awwmpaGE/1FMHvDwJBpAsKpdO+VneulgfZrVyPJqOO1O5Or3OYBzGU7OYEgDrb5KIm
 v+G0Cxk2oClhCVc6/C9a/FeBlkj8pq4cdHUvfwUQrkX8p7sVLdiUFDXIvzdu1phtFDcE
 7Aiw==
X-Gm-Message-State: AOJu0Yw6vaGPuCC1OAAOX34AGy6jLgsa5jL/a0UHhTcZU2vRxF1xVnQT
 wvgAHkR5Xr8hTUhN/YG06PL5ivqky6bjXb1zSNUR5pNQbNNFvjsmdaHbZeJF2t6yM0+w9pD0JWp
 lDjSaq9ozypAsbFYxa1WDqXDhtFSZkufBaGMlPbLark0VdAWlzGRcdgxS
X-Gm-Gg: AfdE7cn/meK5JzlTNH81+JGaQNt9LmP2sEzujG8gwt+eZHZ8RHifnTM9+bv1NY3dYHn
 rrqrNHondrEWP5MGr2nvDqC9DuYEXsdDZxRwGwZ1E5DrauhqyGXptSJU3QRIgPVIBZHWN9uNz1R
 tgX5XiUY89uT7IGAUSlYFyHXDfdP3osDuMpTrqRyJ7/bUjgAnfIXd3RCSzH1yzkwP9EW5tKhcS4
 9ukb0Yyu7B6hIuJJUJXHcg/BdxBD0H9PT3+6z7n6KDRQ+oQncgkMpz8RZnsto9YojsS0Xl0f5wK
 PJH2vibrwbAwTH5tregHuz9aP0D78UALuXFqPWAXTVM8QAFCCDetcJBv5oAQQSdZ5yT100PzPM2
 Sfgp06HQb5Tltpkg42KacOWSAumeOBZrwntJq58ho5zgfsKMqpONw5SE8Ytpyj8OlYYQ5ejYJu1
 KBncHi
X-Received: by 2002:a05:6102:2c0e:b0:727:48aa:f604 with SMTP id
 ada2fe7eead31-73436e001a2mr3251512137.28.1782468312399; 
 Fri, 26 Jun 2026 03:05:12 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0e:b0:727:48aa:f604 with SMTP id
 ada2fe7eead31-73436e001a2mr3251462137.28.1782468311946; 
 Fri, 26 Jun 2026 03:05:11 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd390e76sm1122716485a.3.2026.06.26.03.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:05:10 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 26 Jun 2026 12:04:03 +0200
Subject: [PATCH v6 3/3] igvm: add device tree parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-microvm_device_tree-v6-3-9cd13cf057e2@redhat.com>
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

Coconut SVSM, with the upcoming device tree support [1], will use
the IGVM device tree parameter to discover virtio-mmio and ISA serial
devices instead of relying on the fw_cfg interface, which is
QEMU-specific.

The device tree is packed before copying into the IGVM parameter area
to reduce its size, since IGVM files can define tighter memory
constraints for parameter areas. Packing is done in the generic IGVM
backend rather than in per-architecture device tree setup code, so
that each architecture does not need to handle it individually.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c      | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 backends/meson.build |  2 +-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index a5a2a4eccc..80e87fe602 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,10 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#ifdef CONFIG_FDT
+#include <libfdt.h>
+#endif
+
 #ifndef IGVM_VHT_OPTIONAL_BIT
 #define IGVM_VHT_OPTIONAL_BIT (1U << 31)
 #endif
@@ -121,6 +125,10 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+#ifdef CONFIG_FDT
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp);
+#endif
 
 struct QIGVMHandler {
     IgvmVariableHeaderType type;
@@ -151,6 +159,10 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+#ifdef CONFIG_FDT
+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_device_tree },
+#endif
 };
 
 static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
@@ -786,6 +798,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+#ifdef CONFIG_FDT
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    g_autofree void *fdt_packed = NULL;
+    QIgvmParameterData *param_entry;
+    uint32_t fdt_size;
+
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
+    if (param_entry == NULL) {
+        return -1;
+    }
+
+    if (ctx->machine_state->fdt == NULL) {
+        error_setg(errp, "IGVM: device tree not available");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
+    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
+
+    if (fdt_pack(fdt_packed)) {
+        error_setg(errp, "IGVM: failed to pack device tree");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(fdt_packed);
+    if (fdt_size > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: device tree size exceeds parameter area"
+                   " defined in IGVM file");
+        return -1;
+    }
+
+    memcpy(param_entry->data, fdt_packed, fdt_size);
+
+    return 0;
+}
+#endif
+
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data, Error **errp)
 {
diff --git a/backends/meson.build b/backends/meson.build
index aabfaea5fd..8792c58c36 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -35,7 +35,7 @@ endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 
-system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c')])
+system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c'), fdt])
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
 

-- 
2.54.0


