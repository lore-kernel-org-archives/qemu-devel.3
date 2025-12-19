Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CACE66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfqS-0000Zg-V7; Fri, 19 Dec 2025 14:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqR-0000Yc-1X
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqP-0006nB-4S
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so23305005e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171332; x=1766776132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncJUNebs7ZM73hrk151b27J1wkIMha9Y6kzNKacJdwU=;
 b=q/94JHsRJ+GkMfyohYwwRRoVvhO7IwzheWujSHlnn6C7IVRmWHYjzCRLg4i9kW1O1u
 S/6m5EOMiWz7Acqhc1tXE3qtwDece5RLIOaqdrpCniEY6m2ogHmTUKxsHgUkUsrpE6ZA
 thaZVxRUNimUBCa6bbHzxUFWNGwhe5qzbswrtXF3FsH/YXg6fdN8k7uec2JFkQ7A+wYu
 zIr4UrEVdNzyVthK0nIrei+ItIMUDVqbARcbecS9kk/ATacZKw3FBJwlmut7bEEi0poa
 AoYjBeFhiqJ594lICwhce0TNXGxz5LAsgFSAFpru7NcwQ9e1C3RY3/uxuUtOefuKV89r
 NyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171332; x=1766776132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ncJUNebs7ZM73hrk151b27J1wkIMha9Y6kzNKacJdwU=;
 b=fvkrgARbDEFqdcUBmXsBa0OCd5JxFTB+Js+FBZStiunVhwX3dhVuvgiaq254n6wArx
 zDd+OsMRCWKIQLN1T1pEvCCwYEJ2q5EAYgDhhANhlgE7p8c2zHuQ7XDFtraTcSSA6iI0
 OA0ehRaKS8CqC8z69sK+O6+4lMgL76dYZsJYue77ZSty+EGn4sUFc8TRISwfa2gu2xSh
 v75Og1teOY9YaiTC+nw3rDWMWgtCs2vK3qlC75Cyd+i06D/UMRthqL6rWnxLVScNsVcj
 HU2Npat27VMh+5erBBMYB+H2EQrEqjp4ipmffH6FwYc0wOk0362tuPxGVqd7bzfMqaTM
 lEKg==
X-Gm-Message-State: AOJu0YylUQfSaHLkfpRQKa75cJopikPnG1jrJnebDFvUCCPcRcwN0sXW
 TZCrOLx8uB4XQjXal5JUgdNVTpYXwAP4rj7Xdzjayzc6h0u5dnH+L+OoqBDxRir308E=
X-Gm-Gg: AY/fxX6apNyVxOPMKsbdt9eRupH3p1JJZDGxZmxLL9aYClvuzb2G9CP6jIFspbBdrk8
 iTlYjFfzgugqErAH8DrPwCzA1jmnjj5pIRnL0Nqw6krbCIZdtlMENSWUv7/AG7csKF5gLuArTWk
 LgKoabU7yirHY8vgf5HRE5NASqkzvf/NRfzYI7Lqt4+O6fmbTb6euPCrtDYyymKyuqRBYl4cl/Z
 uYUL6zW0DWlP+rsFYa3ta0zAmi6UdW22siezZvjt4yMvp0BYv+/zN3PV//pH7wzxA8p5T7KKb29
 yHqPL2LY3wiuJnA8aQ6gIHVLjsBrNtYzdlA4rnCH8mi+r1b9FBIdsiz6RgWrgZrdXZGFo7XwyuE
 lPeIVtnOhTusoysDuBaDRhGRIpggKfPsGTQwbmarQeXLxPPTzCEvXaM9yW25IgrD8kYk5Nx/gCM
 wnIMTWRZbALk4=
X-Google-Smtp-Source: AGHT+IEDTpOPtHHV4qDExkgs8HlMd1I1k+4FnT1Ic9yNZd92whd1zb5UBPyt+JRb0F5YDM9/M10TLw==
X-Received: by 2002:a05:600c:4709:b0:477:9aeb:6a8f with SMTP id
 5b1f17b1804b1-47d220b7f4dmr2062125e9.9.1766171331612; 
 Fri, 19 Dec 2025 11:08:51 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm6615321f8f.32.2025.12.19.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA01C5F87A;
 Fri, 19 Dec 2025 19:08:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [RFC PATCH 01/12] contrib/plugins/hotblocks: Correctly free sorted
 counts list
Date: Fri, 19 Dec 2025 19:08:38 +0000
Message-ID: <20251219190849.238323-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Alex Bradbury <asb@igalia.com>

g_list_free should be passed the head of the list.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <0529ab0212aae1e4a5ff3c287045acc0731e5d01.1764716538.git.asb@igalia.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 contrib/plugins/hotblocks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 98404b68852..d3dd23ed9fa 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -73,15 +73,16 @@ static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("collected ");
-    GList *counts, *it;
+    GList *counts, *sorted_counts, *it;
     int i;
 
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
-    it = g_list_sort_with_data(counts, cmp_exec_count, NULL);
+    sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
-    if (it) {
+    if (sorted_counts) {
+        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
@@ -94,7 +95,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                     qemu_plugin_scoreboard_u64(rec->exec_count)));
         }
 
-        g_list_free(it);
+        g_list_free(sorted_counts);
     }
 
     qemu_plugin_outs(report->str);
-- 
2.47.3


