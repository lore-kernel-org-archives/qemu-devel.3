Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D22C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrV-0003T0-JO; Tue, 06 May 2025 08:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrR-0003Ox-Tg
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrN-0003q7-NF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso10851604a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536240; x=1747141040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZ7ZcEntGPm6gGVefEyriA5YLtZ/h9pxvxLBafrRxrE=;
 b=DHz9IenC26s6aHkYTsX6PNWZf4BQ/qprEX1qf1vK7G2qRgRPrys8hSbUWy9Lu8sFFv
 26Vsrc8AD3slWLgKNE3OLIQgB5azHIvxCQs5r4WtrkscdrQ1EWE/5jRfzjUEwgPWzpqK
 iS6ZyoyyH442YkSEpSzIyLC6RUXoQFEBPtoYyEM1dZ8VSLidf2fM43Tkfy3iNNDGGtpR
 1mWtB3k49Z0ShFf63jH9D8Iks1dJSfkuodEa5CHRSPRHuHdBk02PIEPqdwlPglDob3eq
 Ll+37URJg8HidcgjosTTHQqS5fISMq7DoxbOum59M/vZewtTGE9pH0bCTExF3UujMtOX
 r2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536240; x=1747141040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZ7ZcEntGPm6gGVefEyriA5YLtZ/h9pxvxLBafrRxrE=;
 b=e8MSJTMogXvRMvKkoa7/8OjR2AhgdUKaAufWv9zBn9e1XOPB7Gsvgov6sxH7GsQKAH
 dXF2PQ0G7PGSPnfvQYAr7/b9wbl2joRVoPPJG2LyFdj/G3tFX03rWxvIriD8oVg23w/g
 gs6H6w9p1AH0sCwb0Qsyak2tUhSOviNghAJB6QcKv9tG1PKrD2ZiLSZ39HlqGLmc9nIr
 jRXzelYLq79LJqbnildYNXK+eKFHtfe3Q9P2Xnr/4NdgR0xlTin23ypWszAOvbTpWbHh
 D9h6lqRvnEyr3+KFosyoFi/jEJocJo7CJEzHvPgPEpfiafGrmApclAcVyr1cInBYUXpc
 RyKQ==
X-Gm-Message-State: AOJu0YxGmInBT9RdxARSmikN4oGvyKEv2U8SVcSIKtyDRRAclDg+FHof
 /+fAhtySY6zh4YfAEJi86xO4CBRGq7Ep0kV40K8LWceSG01Rcns2SWPwKocFZ58=
X-Gm-Gg: ASbGncscBixwxKy7YazaV/bNkfZKmFflkvE9fTk5MWGWtlcDysJLMOjjxKlsM4ajtqm
 OIy6oLJm4gTRVy+yYZSFitNurRCk1GTZYwBsCESsz36AMiUCXC016nvuGMEvqmsIHojJZGvIqY3
 sUN5fV/kmGTIS4+xgMQaRp0gMgqaJ6fGieOYLz6AdLZJhw/u42JhBxYBax8SmkcfIf4T6WOKEp7
 b7rcgNs2OZIA2l4Bg9idqk63K5ghaG/dNl/QpABKlM1A+0KaA4iRdC8uvHeB1E0uSSJcNs8Wjz/
 coXsdwmNrZ3Gw9bQZZt95i6/cr09HdHgoW3SNIFJkuw=
X-Google-Smtp-Source: AGHT+IESU9jkf+t+9IiUqWzqA2hstZHNJAvXar9Wuh0EFY6uhdG9PoGKI/IJ+aL6aFi/XLfIpPihjA==
X-Received: by 2002:a17:907:7f8b:b0:ad1:8d47:f5a1 with SMTP id
 a640c23a62f3a-ad1d327b0c8mr332156966b.0.1746536240089; 
 Tue, 06 May 2025 05:57:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18e2d7a88sm642870066b.36.2025.05.06.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B8AB5FAAE;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 05/14] contrib/plugins: add a scaling factor to the ips arg
Date: Tue,  6 May 2025 13:57:06 +0100
Message-Id: <20250506125715.232872-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
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
---
 contrib/plugins/ips.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index e5297dbb01..9b166a7d6c 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -20,6 +20,8 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 /* how many times do we update time per sec */
 #define NUM_TIME_UPDATE_PER_SEC 10
 #define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
@@ -129,6 +131,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
     qemu_plugin_scoreboard_free(vcpus);
 }
 
+typedef struct {
+    const char *suffix;
+    unsigned long multipler;
+} scale_entry;
+
+/* a bit like units.h but not binary */
+static scale_entry scales[] = {
+    { "khz", 1000 },
+    { "mhz", 1000 * 1000 },
+    { "ghz", 1000 * 1000 * 1000 },
+};
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
@@ -137,12 +151,32 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
+                for (int j = 0; j < ARRAY_SIZE(scales); j++) {
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


