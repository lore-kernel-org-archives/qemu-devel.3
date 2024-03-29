Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81305CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 11:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqAR8-0007Jt-UO; Fri, 29 Mar 2024 07:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rqAR2-0007Jj-SZ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 07:30:13 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rqAQz-0002RR-G2
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 07:30:11 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5157af37806so2148456e87.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711711807; x=1712316607;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j6DDkwpvom+BBv/17n5oZbHgS22S3mUaYfYDrMWoWMc=;
 b=It50Fy+cNczGK304551jq6FL0J74YR8TdIr+BsZiO/0hVyFClsQnBNxat7Ol8Ix/G+
 3k/MZoAYwTW5PBaRzbY0YlWyyvsph5fqCLLJSOrywchwlSinh0ZV7xdmSvG7mV19EZXJ
 UCJ8oIJwJtSXI+s3lmTU0YNMoFtxLcNi/9xQUtdhKaqVCoj85pFv4pYPUmaRSt01jDxt
 hgF4hQ7uVwtJkZeREOjRGiUn1v4wGtzjEaqyOR7EamSfP8+E/L/zk6QERkdZHHaQqz8b
 LdPrzswUcpOr2npsP1Wpa1kOPU63dXZGhPq6JQTCggHR+nvCdXtQKc6fjKzMqx02z4A6
 Shfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711711807; x=1712316607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6DDkwpvom+BBv/17n5oZbHgS22S3mUaYfYDrMWoWMc=;
 b=K+UhanmMWMcpOsZSe/cWfVnr3MvL+RpPOgcWhs7a2jrVuneZqwukbevq5sb2CglRdF
 PbK9MiyBWUWaRRiFSfTfGuplGJ650W/o+9Cn5xyDm6pgfdxwKoUPbKUb3Ad3+zpC/Z7h
 sDF61xPYnO5D0kGmeMscJM2Hxwg8tyKOXHk3HNXZ68fQ1PPFjHgKTIJOoLhg0cv603O8
 DSZzxi7nPWpDI73VjUVo8ZvIsMs0SBU78iYyoL3qq190+S+zJlOEfVsVfJ0MOB1VY/qA
 7YAG40Xvd6GV0OMdXhjLk2IAfcCegRGT99onvDlWOEjbQt3ifXGAGN0kCq7xmUrlwSme
 PHIg==
X-Gm-Message-State: AOJu0YyZ/HlY+qb1UamKcADngSFwN4W6OSqxXTps0J8/OZs2EvFL0nsh
 9YJd9Fq5BRjEBpOOqSi4c6KJrNTQUpm3c+u1/1lx1ii633iXAE4ImSuVR/mMNkH75kh38znpDP7
 h
X-Google-Smtp-Source: AGHT+IHeIHMEA/iHL9fRGCGlW+rYfLpN4lZTm9d66p2gY93IN1WI8LI6EU399Y7InYYIFxL0xOxk6w==
X-Received: by 2002:a05:6512:11d2:b0:515:8c3e:5665 with SMTP id
 h18-20020a05651211d200b005158c3e5665mr1343017lfr.27.1711711807021; 
 Fri, 29 Mar 2024 04:30:07 -0700 (PDT)
Received: from localhost.localdomain (178.115.74.196.wireless.dyn.drei.com.
 [178.115.74.196]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b0041488e78fc8sm8341892wmn.36.2024.03.29.04.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 04:30:06 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	yuri.benditovich@daynix.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/1] ebpf: Added traces back. Changed source set for eBPF to
 'system'.
Date: Fri, 29 Mar 2024 13:04:20 +0200
Message-ID: <20240329110420.1865664-1-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x131.google.com
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
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 2e506f97435..c8a68da2c56 100644
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
-- 
2.43.0


