Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1CCFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3F-0008OB-U7; Mon, 27 Apr 2026 04:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3C-00087g-0T
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3A-0002jQ-6U
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ad135063so90591685e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277439; x=1777882239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CX4HMtCLtaKxWP+CnhHEeurJGMT23nAqgS5xqErMf6U=;
 b=kuNWx5cmwiMbTjs01Aw1rnjiR9pST/+QTRKfG09bJg4k/WdpVVs2fO7ysHitrWQ+CZ
 dOZZkCTA6pP8t0E5+ILpuc2H3VuV7ByNcdKPELmYbBD6fCWLp9/1shswT5qv55xBSfxd
 Eng3yIO5PzX8TzXX4tsbVXKiOL8qK7qbspoPWW6dc/fI/WPq+yEeTcp6ifvEwEXLujp5
 NaV3y2/3fdryafGgIByJUaAWLAyU7PDNbiX8RY02bOMB3wEJ0SrbDwfwe7omNCeON6ID
 v3NQSZk6LfAue5ilus3utqVmFJkjfGCZotZ6+oG/pF6Ai7a86SPJyDZm29lwwrjIFEZd
 xz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277439; x=1777882239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CX4HMtCLtaKxWP+CnhHEeurJGMT23nAqgS5xqErMf6U=;
 b=HUMuO9/XxEFFi5VuACX1de8qTL8RdNDD4gTEEsoys0ZBOmr8YqHGxRuP9jS5wLxaT5
 G4NauphGGs3oDBk77NjY4zwNrC8tMaY/8pjMUfZpmFsh/ZJRqmQiUWZHHppvNmGSf/do
 KSBOWLD+Sa9+IXDToFAdiVPkdMFeC+BgqNnWrxU75qPoITtSvezThBhrUXjI0mPuBevq
 v6m+cCZCTFf+Pi0gSX3UoAVVDJpjJ0M8fdXgjlbBCnbl02X+o28eDOWGDYy1NTjXOpu4
 EFNxpWcVQYdKq33OSeSUGUsS4H3aNn/Q6isSS0nsfoJBNtNnr/l8l3gj4t9007ZRasfY
 SOAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0UGHOzrn8fB2PxYG0chQ6UnRnzgqfPBEmedMGvSp46H1NGqbTv89aKzpXUS4Ui4sJK1ch8QVVWU8x@nongnu.org
X-Gm-Message-State: AOJu0YzbBGshRg1vzoN5L7CHNu72cH9BjJaH4/H+bHo2w0NEQruEFdut
 f2WSywF3/kNQ8TiYiGz80g42aPEGF8M6eQM6Xr+FfuF8C4ztIBDyksEQoYKQSyQOUqGdk1GRubB
 ha8CgtfI=
X-Gm-Gg: AeBDieveWLDv1u8pv48AiAemh2+qqpBZyf21G+wzdzXSku7T2j9gH7pWF8wo1ggZwDn
 BpLf/8h0Y2jTW1//LUt1R77s+1r9KcDq0PzEUowaq7mMG7fNlPgYIs6oOGpLCP0vUpKgUOjowPZ
 9w5eqJvZelNKQD0GtW3m8nUuJbp3NAtTLDpiHT30mKAqrJvzvtCh79tbmOOxKPAByOJMPU5SFvr
 MrYcw4DFM5sNLSfqeUWUeUZHV2WoH0RwcchEoX5LF1VASsQPu/V8EbwiQTVVbxrn0guEFMIcvpx
 hoXJBFlw/isI3g0MR6yVS82vuTxlbaN6THBHCn6/oAvH5W3H32oxLsdJOrGM0uNtfbONKGHYKD2
 FTJR5ERcrZVity8YaKIkXnYeFpuWQGgd2A+XWyLKyRGHL6PIWsRND66PuDYLRkwOlnZOOoI6JoF
 KT1MaUvRSwZ77UmXm31cGpKEAuRNF3NazP9+BSUr4lsgAKCXzZqVaMXMd1fIM6artRIpkEwUl38
 i0anB1hcxZ7y+R1lMxGhg==
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488fb793c6bmr605724035e9.28.1777277438510; 
 Mon, 27 Apr 2026 01:10:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1cfbf2sm813858135e9.15.2026.04.27.01.10.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 26/32] cpus: Introduce SysemuCPUOps::monitor_defs hook
Date: Mon, 27 Apr 2026 10:07:32 +0200
Message-ID: <20260427080738.77138-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Allow targets to register their legacy target_monitor_defs()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++++
 monitor/hmp.c                    | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 5b831393cf4..94e36ecdd18 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -93,6 +93,12 @@ typedef struct SysemuCPUOps {
      */
     int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
 
+    /**
+     * @monitor_defs: Array of MonitorDef entries. This field is legacy,
+     *                use @gdb_core_xml_file to dump registers instead.
+     */
+    const MonitorDef *monitor_defs;
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index d7b2f731def..70e5e5c2367 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1608,11 +1608,15 @@ void monitor_register_hmp_info_hrt(const char *name,
  */
 static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
-    const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
+    const MonitorDef *md;
     void *ptr;
 
-    if (cs == NULL || md == NULL) {
+    if (cs == NULL) {
+        return -1;
+    }
+    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    if (md == NULL) {
         return -1;
     }
 
-- 
2.53.0


