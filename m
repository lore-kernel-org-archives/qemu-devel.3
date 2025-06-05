Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABACC5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQj-0006zv-Lt; Thu, 05 Jun 2025 12:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0006yi-4e
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:00 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQe-0007vx-Si
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:59 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-606b6dbe316so2085756a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140815; x=1749745615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RYsWu2FLtSlw32TxI54Iy1CVKbOUEX/+7bcau3xMfg=;
 b=dyDN1xUEOlHmgMMBi/PLhp5QJeEl/GIO1LWdKWzwVHTzVGvqbEiQkKpZxWvwE8uHQO
 vEcZvQeB/DtX5ZMW/T4L1vm+70NIDNIC4tT8CqiH+nkQyzj4P8h4AxlWo3gXKWyXtGhD
 gpq/Le0GX6avOCc+G/DO/JHbRI4VPB1wUitMCdPkYhy1Zst1C2qg5z6C5kc0mLxSJwKX
 2xH//DdV0QVsog16ZD7w/OkNtnUpD6SOvTl/FTdVt7Z7NtpaG00JK6Gi6bljGMWr9ik9
 Cq7sZ1bRJcMxvHn3AsjiwMIYZWuAwQk0Y6cjzsBEN1URAuTDPEgaI1s8Yx8ry4jODzEE
 K/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140815; x=1749745615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RYsWu2FLtSlw32TxI54Iy1CVKbOUEX/+7bcau3xMfg=;
 b=TPYaBYUGnT7tmN1I2Ao1quV27AggIWvRKUWMYFeV5TaW5eu+VFbzspXKLGmjLbgoXe
 8U7Twc7cU5X2xaHyWt2l45kxhhV/WFS94dsz/qjXkS0KVmrjpaXo1gV/lHL4VHHk8ugq
 pjqQdY0/lxfQV8cgj5VO43z1ldBdw9FOOX1s6GF22/ywGydNVCUwQK1SzGDDVw5o6Wmz
 vh8oa+xTUDmus7l5NnjO5lcMYcliCcXM+Z69yCIXMONiBIm/Ma67YvjFg51maG1yXRuA
 H5lZ6SlC+/TCPgAAgP0Mnq7kMUx/cmufaqn7h4DPWNgutAvKoQk6UvwfsVnZmLBfUpZ1
 0i5w==
X-Gm-Message-State: AOJu0YyuvYKL20B3+kndQIcfDkTIGhCazouF8ax2DkU8io//BdzDUVGS
 3A1mkKDRIggCzaHEgYZpO27bk7W9P+FspeFjGA4LZeyM90ls07oVE1vf9SNstI4Ym3Q=
X-Gm-Gg: ASbGncvZ4HhY89zNdDQdVqc0bA/Z+4jDThMPiimlnMNUowZjpt8tqmjxDWc8MB55PvB
 SM3bGX1Eyiomc7ek52yIb9VZW8YNZjOx+Rn/DWvXtMV8CmKDEedOcyr/HbGbCYrosZ464EVH2Wi
 j3HztxGtuEvnl1Wxtb6DbJVR7QXgT3uyDr58furMC79oHK9ID6RM3gZXG6MSizPIsGJyUsz47Vx
 Rlc3o10ZRkS54qCK06lp80K5hXRgdy9jpjK3pOBb5xrZGTle4+Omio3ioq1q6QH7zB8BXkIp6ud
 14e6NEbUljcqRvHYSQmOn1i4xIUlCNUjOhSMpMQRiOi9aEDbg2NzPwG/lT6Y48k=
X-Google-Smtp-Source: AGHT+IGC3B+SOmvVVPpqVVcY50fnTcoYtX2GMnSnRj0NQbrpcEqap+p9fYu0VRpDB3+UV4h/2ETBjg==
X-Received: by 2002:a17:906:7311:b0:ad8:a9fc:8146 with SMTP id
 a640c23a62f3a-addf8f5a697mr705689266b.44.1749140815089; 
 Thu, 05 Jun 2025 09:26:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e8780besm1293932266b.94.2025.06.05.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF3E75F7F7;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 05/17] contrib/plugins: add a scaling factor to the ips arg
Date: Thu,  5 Jun 2025 17:26:38 +0100
Message-ID: <20250605162651.2614401-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's easy to get lost in zeros while setting the numbers of
instructions per second. Add a scaling suffix to make things simpler.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-6-alex.bennee@linaro.org>

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index e5297dbb01..d067971135 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -129,6 +129,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
     qemu_plugin_scoreboard_free(vcpus);
 }
 
+typedef struct {
+    const char *suffix;
+    unsigned long multipler;
+} ScaleEntry;
+
+/* a bit like units.h but not binary */
+static const ScaleEntry scales[] = {
+    { "k", 1000 },
+    { "m", 1000 * 1000 },
+    { "g", 1000 * 1000 * 1000 },
+};
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
@@ -137,12 +149,32 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "ips") == 0) {
-            max_insn_per_second = g_ascii_strtoull(tokens[1], NULL, 10);
+            char *endptr = NULL;
+            max_insn_per_second = g_ascii_strtoull(tokens[1], &endptr, 10);
             if (!max_insn_per_second && errno) {
                 fprintf(stderr, "%s: couldn't parse %s (%s)\n",
                         __func__, tokens[1], g_strerror(errno));
                 return -1;
             }
+
+            if (endptr && *endptr != 0) {
+                g_autofree gchar *lower = g_utf8_strdown(endptr, -1);
+                unsigned long scale = 0;
+
+                for (int j = 0; j < G_N_ELEMENTS(scales); j++) {
+                    if (g_strcmp0(lower, scales[j].suffix) == 0) {
+                        scale = scales[j].multipler;
+                        break;
+                    }
+                }
+
+                if (scale) {
+                    max_insn_per_second *= scale;
+                } else {
+                    fprintf(stderr, "bad suffix: %s\n", endptr);
+                    return -1;
+                }
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.2


