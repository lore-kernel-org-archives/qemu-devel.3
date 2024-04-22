Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5D0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuUF-0000Bx-Kf; Mon, 22 Apr 2024 10:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1ryuUD-0000BU-EO
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:17:37 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1ryuUB-0006kp-8C
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:17:37 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a55b78510bbso110409166b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713795453; x=1714400253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LrDoXa9KP1kc/NGluVGm9K6DF251cRYqD0XD8n1DWXM=;
 b=jCe7LXfLm/KpN36/xSa7Gh8i3JyP3hdVwymdz01p7xaFbzPaZN8VKy3GxDLjuJL3Yu
 5t4ajU3rsbtok9d5aXjc/VC5T7CJxQV9o0gzS8JeQ4AGAincqiX4SgxuiZ+DUXNg1db+
 cPbeX68T7StECp/t1dqwT5GgFxfOD98emia/1e/XpVtXvu9/tblkssZgu9KIcGXnPSPJ
 86o8sihjClrc1IdfqiVw19gNl4lypmzjBrepRmBez6TfizkEIVCUA/BlniEKE0+W8e9R
 Zz7gHsRBbx+WYQH7SW4rsfxYTAuVwtEs7g7sp4iMzj/qA6u6XFFY0dmdNADy+HH7wHgK
 /U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713795453; x=1714400253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LrDoXa9KP1kc/NGluVGm9K6DF251cRYqD0XD8n1DWXM=;
 b=NEysjlmrIbxHHSoBLwqWIVZYn/oIPv1uImmWm5OI3fX7AGzid5+hRlldE04lPm5oop
 qFPUKlVdwAgi4pCJC6mAhDuL6f30cXYyVH7Gv0yOXjFPzxONhCmoGVVg4jivL08XBuv3
 e2pnjixKUMto2lnTPBF1QYIgUfF0AU8gs8N3PGHUmCtn6LJnajIW8b4KS75M/dEis7FX
 jNuHJqnZmp7RolHBWLIm/G43JqNO45YHn9W3e7/vMhJc6RYgQrAjCDoXs5ZQ2bla/eY0
 l5GmU5SeXSghBtBbydUrOZq6REbbuuCpUZiewoOPV4WU/I77BJuhjKW3qhZVahuhxUZ6
 LnzA==
X-Gm-Message-State: AOJu0YxLMGw2sOoW6f+ZkXMW+u8MH0Fu2bzzTKYGKj/s+WotvivTdTxJ
 D3V0Gp70SLizoLCNC9n37nlea5YNTwptRZAXkzQrONNZOEbH3D8PtAofuo4FWok=
X-Google-Smtp-Source: AGHT+IGY9rGb3molNvzsXaasBcFOvcBXHE3hE/c06DqOLNJD6oprmd/ygpsgm3vQkI8WGN9smuV0ng==
X-Received: by 2002:a17:907:86a5:b0:a55:ac7d:af14 with SMTP id
 qa37-20020a17090786a500b00a55ac7daf14mr3661196ejc.40.1713795453068; 
 Mon, 22 Apr 2024 07:17:33 -0700 (PDT)
Received: from localhost.localdomain (91.141.46.84.wireless.dyn.drei.com.
 [91.141.46.84]) by smtp.gmail.com with ESMTPSA id
 c19-20020a170906155300b00a526a99ccecsm5758740ejd.42.2024.04.22.07.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 07:17:32 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	yuri.benditovich@daynix.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] ebpf: Added traces back. Changed source set for eBPF
 to 'system'.
Date: Mon, 22 Apr 2024 16:51:16 +0300
Message-ID: <20240422135116.53247-1-andrew@daynix.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::62a;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

There was an issue with Qemu build with "--disable-system".
The traces could be generated and the build fails.
The traces were 'cut out' for previous patches, and overall,
the 'system' source set should be used like in pre-'eBPF blob' patches.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss.c  | 7 +++++++
 ebpf/meson.build | 2 +-
 ebpf/trace.h     | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 ebpf/trace.h

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index d102f3dd092..87f0714910e 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -25,6 +25,8 @@
 #include "ebpf/rss.bpf.skeleton.h"
 #include "ebpf/ebpf.h"
 
+#include "trace.h"
+
 void ebpf_rss_init(struct EBPFRSSContext *ctx)
 {
     if (ctx != NULL) {
@@ -55,18 +57,21 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_configuration, 0);
     if (ctx->mmap_configuration == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
         return false;
     }
     ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_toeplitz_key, 0);
     if (ctx->mmap_toeplitz_key == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
         goto toeplitz_fail;
     }
     ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_indirections_table, 0);
     if (ctx->mmap_indirections_table == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
         goto indirection_fail;
     }
 
@@ -108,12 +113,14 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
+        trace_ebpf_error("eBPF RSS", "can not open eBPF RSS object");
         goto error;
     }
 
     bpf_program__set_type(rss_bpf_ctx->progs.tun_rss_steering_prog, BPF_PROG_TYPE_SOCKET_FILTER);
 
     if (rss_bpf__load(rss_bpf_ctx)) {
+        trace_ebpf_error("eBPF RSS", "can not load RSS program");
         goto error;
     }
 
diff --git a/ebpf/meson.build b/ebpf/meson.build
index c5bf9295a20..bff6156f518 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+system_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
diff --git a/ebpf/trace.h b/ebpf/trace.h
new file mode 100644
index 00000000000..abefc46ab10
--- /dev/null
+++ b/ebpf/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-ebpf.h"
-- 
2.44.0


