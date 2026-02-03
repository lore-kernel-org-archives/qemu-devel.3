Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54692E7FDD6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExQ-0008FI-Dq; Tue, 03 Feb 2026 06:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx2-0007vA-QN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:12 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx0-000593-74
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:12 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6580dbdb41eso8374768a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119527; x=1770724327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmAQhMQ8vyDaeIAxAhsnVaQsmiKDf2EhtEVKbz4JjHE=;
 b=TFDR7sju0zE0PuoNSu/uMyxJYYMJidotjG7VTJ3GT8Cx992GS1H9UjyF5C5gtyaXHZ
 VzF6aaakBZU0Gh2x0MC+GvhOm0t/SQofefNILNYwdYwQ3DxnnlS0rnQh8Z5zOdjsyQWs
 Wrs/O0AIcIX3IJ5riw/+yl6u7TQAzEUY0aXqVQatSgapoWqDy59NvESTFDhm8vP0+ORZ
 2WKJXI1LfjM+llPywJgqxkbpt3oGWvGOVRniye/uqC9KD/bo8C2c0QVE5ihPgQEATppA
 LaDG91a6A9lmZcu9NgdXCjq0/N/nIydqnTVpezNW2lGue4QW+NccvhRC6+qklb7vPZlH
 mU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119527; x=1770724327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gmAQhMQ8vyDaeIAxAhsnVaQsmiKDf2EhtEVKbz4JjHE=;
 b=rokyZEYo6OJMgkXKIlMARvCHYxlW/YkmEJUiT2wIlLVc1WfvOOxrjTTW+XRmHUcl8c
 gmwNIEFB38dhIkJO580nYvtGldS8NlYOsE4x1NgClbP42IgBVrTxwtVotCWvfY4wfCJl
 djUrg7HUUpdcs9ZuwiIubpjtZRjchYYLiTqvYpLCSwOuVXdMoDpfDj3DUf31FgGLwqjJ
 s5Uw5WV6O2IFaCcZuyDJRtYxuGL2J9VsjdOWWwo/AIAJNERGhhBMUegY9lCfk8bK0iuf
 mq7eWtYZ2X4uAjOleyexI0tVQZsfmVl/CRUNyQ9IsYEfHqrUXMHM5x0a4O9AMRMntBCD
 HIWQ==
X-Gm-Message-State: AOJu0YzfiW4pDiVFUi1h2NM3xxxNsjAZgo797GACtYBTF55s15vWhKE2
 V8lKA0ZNTItMFgPMDHZoxAnl8GLyCxPJPGEV+5SaF3cXTtL81e8HlnB/+06MoqjWLqo=
X-Gm-Gg: AZuq6aLYCe2w61olFSx4DJcagXf4DIveJ/h/pRxgMEP6u0GehjuoS6eVvyRUvYrriSs
 zmvuJwZibck8yTRqMWoBOknSOGhK5jdOH1VDzh/5A/6rChn6AbujoUZOwrz6KLRIviLwjUVxQB7
 5qERj+j9ppqkYMmwQbiZDULy9f6ERHneOxG/r1e5Ta/a9tBzrHzkgCpXvpj2Qvq/K5OrH2C0RWG
 0+EkZAQz6jnk/qzJ4CuYpKpnWOBvUg+ZWB7oAEdnj3FGZqFk0bP7upH+JjHJbD2zggs2krHgyh/
 bgXyEWpv0S8CTXEeOxbP0XpeMSvlNFBhIZV9A2wxcxB0aLok8YqOcTZ2rMlvyackE9lWT23IVm7
 YscbK/xLSP2Jsaf78Ig8wVdnl3kjjWJZDmzdIbMe8ezZnRIf9NdS7BdIvODAun0jXd2b+YUC027
 xCM7GSVbx8px+U9h5ee7c6Kg==
X-Received: by 2002:a05:6402:538c:b0:659:389c:a0fc with SMTP id
 4fb4d7f45d1cf-659389ca359mr909932a12.27.1770119527298; 
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658b4256949sm9087243a12.6.2026.02.03.03.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51E4A5FAED;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 03/11] gdbstub: remove the need for goto cleanup
Date: Tue,  3 Feb 2026 11:51:53 +0000
Message-ID: <20260203115201.2387721-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

We already set a default error reply which we can only overwrite if we
successfully follow the chain of checks. Initialise the variables as
NULL and use that to gate the construction of the filled out
stop/reply packet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1f8cd118924..d4db7ba30cc 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1413,36 +1413,32 @@ static void handle_v_cont(GArray *params, void *user_ctx)
 
 static void handle_v_attach(GArray *params, void *user_ctx)
 {
-    GDBProcess *process;
-    CPUState *cpu;
+    GDBProcess *process = NULL;
+    CPUState *cpu = NULL;
 
+    /* Default error reply */
     g_string_assign(gdbserver_state.str_buf, "E22");
-    if (!params->len) {
-        goto cleanup;
-    }
-
-    process = gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul);
-    if (!process) {
-        goto cleanup;
+    if (params->len) {
+        process = gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul);
     }
 
-    cpu = gdb_get_first_cpu_in_process(process);
-    if (!cpu) {
-        goto cleanup;
+    if (process) {
+        cpu = gdb_get_first_cpu_in_process(process);
     }
 
-    process->attached = true;
-    gdbserver_state.g_cpu = cpu;
-    gdbserver_state.c_cpu = cpu;
+    if (cpu) {
+        process->attached = true;
+        gdbserver_state.g_cpu = cpu;
+        gdbserver_state.c_cpu = cpu;
 
     if (gdbserver_state.allow_stop_reply) {
         g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
         gdb_append_thread_id(cpu, gdbserver_state.str_buf);
         g_string_append_c(gdbserver_state.str_buf, ';');
         gdbserver_state.allow_stop_reply = false;
-cleanup:
-        gdb_put_strbuf();
     }
+
+    gdb_put_strbuf();
 }
 
 static void handle_v_kill(GArray *params, void *user_ctx)
-- 
2.47.3


