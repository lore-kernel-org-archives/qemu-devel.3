Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1947E66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfrN-0001br-9F; Fri, 19 Dec 2025 14:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqX-0000ci-N6
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqU-0006pR-Ck
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477770019e4so18527585e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171337; x=1766776137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1Ho9A/XPHpaG24XQJMf5tV6Yy1l2byzrQqypIVDpzA=;
 b=G+FnhMtzS3RMtfv/TdimH1hYI4sg4UbXLJxoG60Yi7MUk07gXQKu665zMKi9PNFvlf
 i/VZzOsdz0T3kGa44FD8PTreMz4QCtmljC8nvjpTJWZpmpb6y/hQ70I9+yWtGMtmLheK
 Pwtsp3lXF4msGxl2GIgTW3qK3a2e/4BLEm5Xznw9BuZ7KD5+bQJradqm+Qd21gHLCJ61
 juj2R9nArj91yb0nk9h39cGaDMWHepSrJl+eXpx5oI9/8GncUe648mBlkUkaGAERIIEs
 c6RaIHjSLqlxGrZPo6DMxtZD4XWXNUMa5SM0NCnYAKGEZqk5/8F0MQhTDRsLTvVpgG05
 42pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171337; x=1766776137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z1Ho9A/XPHpaG24XQJMf5tV6Yy1l2byzrQqypIVDpzA=;
 b=QH00x8UDbwDstEyHtJuSc7e0jAXIezfzv0akJ9jWczalxD2rgTH35T0RlEHRFEQz4P
 OsYAg4A2fboevHprPrczbBaQZM2LAoUAfa48OwGYSeEGXCUct8qa11H6tEVSvZTSDHjX
 LtV+BYhKbkKOJ6LO+49XI6U/LXnd9aS51psVIkMRlO2Jz2P2LkY6FMQmBQTSZSSujIIq
 WFUWj8Y44m2Clmmd9zhx6JjrjkIaKDbmMEmlKdWAn0z16a+s968vSa+KVM9/tWE6gNBr
 644aacV6SCiqXOWX7yeT5r/TgnrRMYdG7/H23EAQ/aaezBirMROPX7q9VYtecng0i8cg
 rq9w==
X-Gm-Message-State: AOJu0YxQjNNFnPw0hYKIagQI8pppb2K5SWDZq/EM8s6nWLIp2ameUm4V
 rNJrjhbyQftZs7KjbkVuTmTUmxEr/YcKnyrXtVDRS8ZnAUlPwViWc7gvesLlJSy8SAg=
X-Gm-Gg: AY/fxX7q6wEet3CitMT1ohy8s6Rr9pptJNcHfPaiN/VoWYaiULtapthWQdakc80ZSoF
 Wj5wDOE1G63tXDNQS8wuVVESzDuCargf4p8zBXCxrwglDsEPBH/oCOCiI4VCNtvfyf/NGaRflrc
 tgbBiPzhnEEgaOY8w7k1dzHFNfsEn/zWL4H1++XKnpKgHCsuWxYFX6CKF4Jb57zLsopbG2b7P72
 wt7u5ar3cUCLGkuGJBJJ2yknnBAP1nZnGMkuCpL/YwOuM7XbH35mmOQMhVp3relPq+jfJWpuBNE
 xrX/eFEpilHpxzBUXvmgWesKeQ9+20mexBhzxyITsSfOiYJoyNMgz69vqb8f678pbVI/m2UTn1O
 nmlIKdSkNvseh4nAkyVcM1ByEmU1qXTeUfz7utCXUulLEsnt+mCBQ4zHH4GcU4WoKn+PMrSbh9c
 EuUYByg0V62zs=
X-Google-Smtp-Source: AGHT+IEiRuseyh0saS2WdyWQSI+3lEZVjidRsb7ooPV+14p4ymxQyBFa4fsZZF3Ealju2FknUZz8Fw==
X-Received: by 2002:a05:600c:1d1d:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d1953b8acmr38452675e9.8.1766171335660; 
 Fri, 19 Dec 2025 11:08:55 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723d19sm123428605e9.2.2025.12.19.11.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 518AD5FE99;
 Fri, 19 Dec 2025 19:08:50 +0000 (GMT)
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
 Alex Bradbury <asb@igalia.com>
Subject: [RFC PATCH 05/12] contrib/plugins/hotblocks: Allow limit to be set as
 a command line argument
Date: Fri, 19 Dec 2025 19:08:42 +0000
Message-ID: <20251219190849.238323-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Also add documentation for this argument. This allows the default of 20
to be overridden, and is helpful for using the hotblocks plugin for
analysis scripts that require collecting data on a larger number of
blocks (e.g. setting limit=0 to dump information on all blocks).

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <bf04947f9a694a4d3adf5f0775dbb8d5013fd8c9.1764716538.git.asb@igalia.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/emulation.rst    |  2 ++
 contrib/plugins/hotblocks.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 543efc4d7dc..e8793b0f9ce 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -473,6 +473,8 @@ Behaviour can be tweaked with the following arguments:
     - Description
   * - inline=true|false
     - Use faster inline addition of a single counter.
+  * - limit=N
+    - The number of blocks to be printed. (Default: N = 20, use 0 for no limit).
 
 Hot Pages
 .........
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 40d8dae1cd3..8ecf0339974 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -84,7 +84,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (sorted_counts) {
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; (limit == 0 || i < limit) && it;
+             i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
@@ -170,6 +171,13 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "limit") == 0) {
+            char *endptr = NULL;
+            limit = g_ascii_strtoull(tokens[1], &endptr, 10);
+            if (endptr == tokens[1] || *endptr != '\0') {
+                fprintf(stderr, "unsigned integer parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.3


