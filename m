Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30010C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXE-0000Z5-Bj; Wed, 21 May 2025 12:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX8-0000Vj-IC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:11 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX0-0006Ad-MY
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:10 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-601ed5e97e9so6523314a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845780; x=1748450580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk8FpSTvxiM/NAT/RHs0cdgY5o8m/myin/sCjff0MlQ=;
 b=ai4Z0MBNkOIQqVT6FHvgQGC2NVvmlBMDuQsfUe4PWehb6CUWBnRIbZ6S+YUC8aV9Jj
 h2Q0Pez48xv4fFZypspXmSNvZQK7izoBHNMMiOj+l2kNHa3e9VHT8D6/WtLBwecaQ+iw
 iniedxKYXO/1bWVj1t9G9pIBnSS4VAXro10uhX0BssNpkvU7nMg3+uwYfPOULnz23vUY
 t5X7M0c6i1L/PWOrXIGQmvhQq0DBWi0s1y18KvGapsNwV6/jr6bRgUr9n6HHQJ+QwxdR
 wziMHjXrqNZ///C2V+Y/ezVEultboy2+W/FoC4PPq6s/hnuu/21RT6TNAzMXH7VneBPQ
 BVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845780; x=1748450580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bk8FpSTvxiM/NAT/RHs0cdgY5o8m/myin/sCjff0MlQ=;
 b=jX6GpA71VcmyddYOUk4gQvLq9cuegbYnuV8tAHZl8CkJ9xmNyZ3nxSKeCztIEM1Eag
 OP8q0jfMSAllAmxLy2YUGU97VLkG/038v2RdG3bzdwf16PyiLly1S3UR8lhcRrDs3eA9
 G6K6K5sJIHST1ALbTIy1vbYod4UzgkeZlzT8XCldP1g3X1gRFNknrMVC4nwcga4rF1kd
 JSxQ3ItTGMp2FOa/iyj52bjFpn0Qwc0w7bvoolpiexDcwS6lk2kQFwk8/2TAxm//4W7z
 BOycB3jnd9BcS4npMiBYk86vI9mM0mGedoyhIdKigPwUT5ejv5GxjjiW7BmiYxh0SwWt
 Zlag==
X-Gm-Message-State: AOJu0YwR2Qu5ucwk/kmfhSedQdoe7XT2us4TErDmfCZDFq1Fv8oGnpDs
 dcVjMRyLG3WKmV3FKTVqSQfQ/k2ssHkY1Qh1VGcmgQJcFSVHFRmNpuwDCDyiYYVUPXk=
X-Gm-Gg: ASbGncvaA0vRB+A1QDeBiFs++ge/2GgEqDjjeEYkonBLsiyPLHKVLRyL2sKEi1BTb5M
 VEzoYnoAvS6YAquKs3eYJvYYXYjEWB0NdWBRsFqSCDnYZ4LibTN9yR09F0dbwc8qoEM2PgnLEZT
 ijSatisGUBdWPc5Nk5104D9+ceJlgByD1Bg+9LqIiNiEENjHTDjCHHhccbIPAcGRm+Iza4pxzkX
 +NElp79cvx09oDvybsqcXbQv/6T3t6kWcU2g+wylvehWdAzLO+z5VEz4d/YacyLT+IpsSmh5/VM
 TX69MLdMC8hHggzSQ6Y9LcgHIRycptsE9fRQ0KIhaS8lpL7E83lT
X-Google-Smtp-Source: AGHT+IH9NN0WLJSVJmueJBQ2QgSM0o2wAFE4QqB5up/xqwzVXs6hiazGIO04dYNoK2VuFDqnMkyNmw==
X-Received: by 2002:a17:907:2d1f:b0:ad2:23b6:149c with SMTP id
 a640c23a62f3a-ad536dcd710mr1664944866b.43.1747845779769; 
 Wed, 21 May 2025 09:42:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d490910sm929266466b.135.2025.05.21.09.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB1FA5F9FA;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 07/20] contrib/plugins: add a scaling factor to the ips arg
Date: Wed, 21 May 2025 17:42:37 +0100
Message-Id: <20250521164250.135776-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

---
v2
  - normalise the suffix before a full strcmp0
  - check endptr actually set
  - fix checkpatch
  - scale_entry -> ScaleEntry
  - drop hz from suffix
---
 contrib/plugins/ips.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index e5297dbb01..eb4418c25b 100644
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
+static ScaleEntry scales[] = {
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
2.39.5


