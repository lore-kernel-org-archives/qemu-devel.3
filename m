Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EEBCCF2DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn3y-00086r-6r; Mon, 19 Jan 2026 06:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3w-00085B-Vp
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3v-0006dg-Hs
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:48 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so2284611f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820685; x=1769425485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fVwrVnP/PWITMvtJ7WHDio1LGq6lJqRNDjS4fFYTXc=;
 b=Vv+nj2FsYSCas08POv68c5ImuNSNsV1WGu/1i9f6X/c/Wv8pcGgMyX5Ahu/B5gmF2r
 0UEIYZ3pZiQWGpiOZvAS3EmA2gtRqXk3Rsufaj76B9Glx5e2d7dhMb6z2didCKDavn64
 WxhJ071Idqm+x5fMWUrKQjekqWMIiiBNsmza3a3ftfHtzfh7bvtMNFyN0guOi4+7w10O
 QqwHsAiRM0ThfegHc4mBc5Qcm+hjmnNX3taAWr3Xv2hc8/5ZobMqY9hW/BxOF57K4bsM
 83zv2oqU5VN1sJ7BePNXlcgREXVyBehY9Qi+Fbe7hau67wmKzECuAGETcO/vFWVU/M30
 S4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820685; x=1769425485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8fVwrVnP/PWITMvtJ7WHDio1LGq6lJqRNDjS4fFYTXc=;
 b=JIOxG+i0K9wVpJ4tVgzlrLcqNbnbgjr2mgln0KLIVmt/+4zllTW1fmaDTDvBl17oV3
 1udlTNxsQ5YOwptdyYnd3xVzxS103KrRdVGjlftSZnwxUiCMJ+fUkr2JE0jBfSKBnnu+
 GRJZCwRjN7l7Yi40nFsuLaxUL9GkibrIxstB8xeVPLxnm+P8p6yUVZddKmXVTNCFJgDF
 reYlHvY2tM2AZzxOt9GOyY1HzLgYLinPnYc1XNrvmOzYpCtC8sFkBT0xaUw3nMJ8BgjA
 Z2dMs09z+MTWl/hj15C0zYsg8LqHhbkJGe5HAICXMmzaF4QpQ6HEcEdxTn8ku/rvFdPe
 pnjQ==
X-Gm-Message-State: AOJu0YwXiT9jgpzw5Ydfl3DGMGPF+yzF/1m9XNDTWh+OcfDfXj0UO6u1
 z+HQSWYe/r7nfXptZ2I6vOt+PCI7HZyj17U35KJRRQyxzsD5AEMzHQVAyESKvi55LH3qKTc9Dmm
 ufAv56ek=
X-Gm-Gg: AZuq6aJPuc5Hc4uK9dNWhBDYEPKK1FqGDvn7KUrlwdA3LdmDoyi/omTckWlgt9Cl1bZ
 iVmxE3YvwnTNF3GvGirVA+cyqNk/WkC12XE9Mc34fmswjDnpFthtS3a+bgl9gNBzWAAvxUWUHl1
 c4xlfhRDvc5pz+4iSe1H3iFLJANnIikfpZGhgqMcEFWnlhQABHmISP2AQeKf6lQs2q5bvVV3uM/
 W6ELJ8/NUKwa8cbZEII344+0AP3pfiIqETK2ApsYSYjVee//EX6Zl6QsaC4ClyJd1FOC6/6S1qH
 vjS052HXo8DwHFztiVP9t4Q/jkq7XngydznBLZTQT6abfU9HGv6jsw3xm93Y5fiHkziW4PB01jL
 kfmWvlbVgrNdP3RKwok3Sx6W8wbCLUcMaDVTLPVMhPzvXtSidVfvufvite3WbbSZVDkIXRygBli
 q9GaTnWPIVpDJLrj+Vjw2h37KTn/BosZcua/5H5d0F+cxep4llIOu04T8Cc6cX
X-Received: by 2002:adf:f983:0:b0:435:6c8d:d017 with SMTP id
 ffacd0b85a97d-4356c8dd0d7mr11585446f8f.32.1768820685525; 
 Mon, 19 Jan 2026 03:04:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf42sm22578583f8f.20.2026.01.19.03.04.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 6/8] monitor: Truncate target register using ldn_he_p() API
Date: Mon, 19 Jan 2026 12:03:56 +0100
Message-ID: <20260119110358.66821-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rather than truncating with a target_long cast, use the
unaligned load/store API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 3 ---
 monitor/hmp-target.c         | 8 +++++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 97d99f1c747..c56f8df505c 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,12 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
 struct MonitorDef {
     const char *name;
     int offset;
     uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
     int type;
 };
-#endif
 
 #define MD_TULONG 0
 #define MD_U32    1
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 5738b47bb03..257605a1c96 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -65,6 +66,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
  */
 int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 {
+    const unsigned length = target_long_bits() / 8;
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
     uint64_t tmp = 0;
@@ -83,11 +85,11 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
                 void *ptr = (uint8_t *)env + md->offset;
 
                 switch(md->type) {
-                case MD_U32:
+                case MD_I32:
                     *pval = *(uint32_t *)ptr;
                     break;
                 case MD_TULONG:
-                    *pval = *(target_ulong *)ptr;
+                    *pval = ldn_he_p(ptr, length);
                     break;
                 default:
                     *pval = 0;
@@ -100,7 +102,7 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_ulong)tmp;
+        *pval = ldn_he_p(&tmp, length);
     }
 
     return ret;
-- 
2.52.0


