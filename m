Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B00CC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPecE-0002ki-Cb; Fri, 05 Jul 2024 04:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebR-000119-3j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:37 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebC-0004Ci-MK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:36 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58b5f7bf3edso880801a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169241; x=1720774041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvGmIc/IqaQmuLkCI/kfZ02beHV2np9KXDzigOomwVY=;
 b=in7Lqla4JNXzW8kXfO3Nux1UqsyAxl7Cf5LomM3LrtAPEZmx8Bdc4q2jVrTSa+teXc
 ZqY0hw45ZPKHkiBC5XUhIYtqo1b3ar3Ooh1hG/IMBRgw80zaLmkSn3HzAHiugrpdsA0e
 cwiRTq0AnvIfb/Te99du73U3Ak222kQ6Q8F6xz7fGPFjRH2rRYla2o8YSlqBpxOjKUxD
 k9pdbHsW0GG2iBNvCabLLd9Ee7gKsnI74YXw0uP3Pc/ro12ciSqS6ARudLNDmuQ/rpB6
 WMyWnZa8AK3HLVuxtrR5VPkgFYPVOxsHkDEn17dsJmrpcN1nxD7/FrFQtkFZQp1dOBB6
 2CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169241; x=1720774041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvGmIc/IqaQmuLkCI/kfZ02beHV2np9KXDzigOomwVY=;
 b=TiJN6bdhIMfLz/F0XBtC6VADO6rGtDX+kWmhMkj8qP43y0ctyUiipLMBU/Bfh9iAxR
 yKzxosTGMnTSK7MsyM8Fp1oyR1dc1/+imxpvxgH8RD7+H1qAEd/IF/yBbZM659UbllBc
 wSfxrhHEsl8EnFUemgYvvSoLVtZOmNBIkW6o+sJlhA7mAVeLCJj9dtaknS1Y6W6c5AW8
 pLuK+K6n9HFX7G+A6e5IJZCkpiXZ81H+cRGNgQw9nRwkNaathkSWnc8R+BYztLrOiVfz
 eqi0H53ihwaAuTwHLuJ9EbKiaeA2a27Jtyj7L6UeDyOynarVhexYxYEcoJO3LHm907cm
 VCNQ==
X-Gm-Message-State: AOJu0Yz+rHfXMaczTMItcgqki6CDgbeWgWHJ+ifWDKdQtuSgpag4pmvr
 OPVKiuFFSfD/vyWM0kxecXJP4l0RHUrp8WCV3hLvJWBOnjuaaWUyzaJh4Cx1mQk=
X-Google-Smtp-Source: AGHT+IG7Y4c+2QbK60kabKShm7UnkToLD8lzkjlq/GeUVtXONwWYLR2/QV++lN1AaHduQj02lMoGJg==
X-Received: by 2002:a05:6402:4312:b0:58f:44fa:a2b9 with SMTP id
 4fb4d7f45d1cf-58f44faa6c8mr1665943a12.16.1720169240516; 
 Fri, 05 Jul 2024 01:47:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5902c5f74f6sm121979a12.88.2024.07.05.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9CF86213B;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 21/40] test/plugin: make insn plugin less noisy by default
Date: Fri,  5 Jul 2024 09:40:28 +0100
Message-Id: <20240705084047.857176-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

While the match functionality is useful lets make the verbosity
optional while we are actually running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/insn.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 5e0aa03223..524f9ddde8 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -20,6 +20,7 @@ static qemu_plugin_u64 insn_count;
 
 static bool do_inline;
 static bool do_size;
+static bool do_trace;
 static GArray *sizes;
 
 typedef struct {
@@ -73,30 +74,30 @@ static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
     MatchCount *match = qemu_plugin_scoreboard_find(insn_match->counts,
                                                     cpu_index);
 
-    g_autoptr(GString) ts = g_string_new("");
-
     insn->hits++;
-    g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
-                           insn->vaddr, insn->disas, insn->hits);
 
     uint64_t icount = qemu_plugin_u64_get(insn_count, cpu_index);
     uint64_t delta = icount - match->last_hit;
 
     match->hits++;
     match->total_delta += delta;
-
-    g_string_append_printf(ts,
-                           " , cpu %u,"
-                           " %"PRId64" match hits,"
-                           " Δ+%"PRId64 " since last match,"
-                           " %"PRId64 " avg insns/match\n",
-                           cpu_index,
-                           match->hits, delta,
-                           match->total_delta / match->hits);
-
     match->last_hit = icount;
 
-    qemu_plugin_outs(ts->str);
+    if (do_trace) {
+        g_autoptr(GString) ts = g_string_new("");
+        g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
+                               insn->vaddr, insn->disas, insn->hits);
+        g_string_append_printf(ts,
+                               " , cpu %u,"
+                               " %"PRId64" match hits,"
+                               " Δ+%"PRId64 " since last match,"
+                               " %"PRId64 " avg insns/match\n",
+                               cpu_index,
+                               match->hits, delta,
+                               match->total_delta / match->hits);
+
+        qemu_plugin_outs(ts->str);
+    }
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -216,6 +217,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             }
         } else if (g_strcmp0(tokens[0], "match") == 0) {
             parse_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "trace") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.39.2


