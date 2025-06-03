Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745CFC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPV-00088v-6c; Tue, 03 Jun 2025 07:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPK-0007xF-OL
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:15 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPH-0002Aj-9M
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:14 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso845095566b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948529; x=1749553329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08HuXk3jkIVLfkToiAYT1EQvKRHMi0bIkqfvgQp9dJ8=;
 b=OuuHSUieAI+1UZLrI6rJPpcp5e60lrMGMlAbBzZgJuMjNEENP/gRBiaWRSrXv+Y70t
 XZ4pUKnXr/Y2Gg3cogY+uaKEyFQVKFTIYY6JaUZFBOHj7XHamqqqDT8s4JBlWgnuclg5
 YUrMEffieZHOashrIrW6d5yvL3xMukFRN9Nn7nEvgprFcaT9t0o3quc3aPi2xFLfhqjO
 qIpMYzNihB5TQDLvgQWbUShWzLuA604iryXHOSNMETe5PQndy3l/BnfijqmaUlpVAkZL
 olnXkY+YamXs9aGShGPpJUNOyas5bEBWxxgduorBXbKQf01jd/MFNK9Cnl5gMim3EXCQ
 I4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948529; x=1749553329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08HuXk3jkIVLfkToiAYT1EQvKRHMi0bIkqfvgQp9dJ8=;
 b=wb/rRNkjv7kWsqTRBDuZFzT1YEIxAKi9XCHydGQUx3JTHjtadzbmGBrD6qk9h1m6Hb
 2uegMnBBr0vGlf7OT1x/4xaD1YLlSPvN1IYwHpYRqW7vWH6M+4Qp7aslzK/8SAOKHC97
 un6umpdMmqGeGITLlu5lRxPp+D43MHczCXy1q3rzBYGL2KUdv44yIxxIveis40XKoTjC
 3+VLqU8b3g33b0fEJd3Z7FoqaCLFhOrqjJZBrm9pXOV5mdbzJYTcLVoFYonwDDt0KS5L
 eWbme33rJb9We6Y9Rd4m82chOdPvJvcOh806cPXhqRSWMYcxghHKTna7ts3frJzqnLxR
 ydaQ==
X-Gm-Message-State: AOJu0YwTZu1y0O33chAOaZ5UX655BnPon7IFNfKrCiESDBc2/uPgjJEr
 AtU9Zk/hVxiIIer3aw6RU9JRhApN4OA+0BCpMkeqkQxK77keTuxZz6yPA3w8lFbAUtk=
X-Gm-Gg: ASbGncvP5LGUcRI/Qqanpo80NcXtLLVhLjOTuplvZ0TnNPF6AqU8pq830eBeh66cAYV
 85xq207qt3xP3L3I9sn6CTQiihXxLycnPgdnljAuh7Sr1YDpO7ayv2maZc/bN6mMRypNrmXwDLB
 kq4BRgtHx6048bkB5WnOtZ3NgCoVm0/v4/KoO/beUC29XQkaGDQbS+dRhAExv/2ahIzax94Mn3d
 atUJqwv6kTzf4/+xtrkdWgVA0HdPIgtfyKccfc+ywVfTXxEYU4JZXe8uycuOvWgAY66ctFWxMtL
 /gVxOTNBL95PiC5sVAoNEmilJiSCbDCmyyli7TKN4daU2EM2T9A4
X-Google-Smtp-Source: AGHT+IFuUQ9Z5gwnAK0Ic0DyqmN6WDKF4zjEaOYv2OLPtOdGJOfZimWxycDuS9jYATKQUPiHamexWw==
X-Received: by 2002:a17:907:9488:b0:ad8:99e7:171 with SMTP id
 a640c23a62f3a-adb493e28f3mr1175212366b.21.1748948529161; 
 Tue, 03 Jun 2025 04:02:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fec86sm933025666b.7.2025.06.03.04.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59A5B5F9D2;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 05/17] contrib/plugins: add a scaling factor to the ips arg
Date: Tue,  3 Jun 2025 12:01:52 +0100
Message-ID: <20250603110204.838117-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
2.47.2


