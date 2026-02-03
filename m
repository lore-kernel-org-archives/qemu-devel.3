Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F421E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExK-00087E-FA; Tue, 03 Feb 2026 06:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx2-0007vJ-S3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:12 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEwx-00058P-8t
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:10 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8837152db5so879614966b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119526; x=1770724326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCQXfrGRlea+C74aku67SoZ+IPzjFLau/OaSoC6An2g=;
 b=che9Zroo3SiLueyQI4zQbzCAsCi+dZ41lHy7CMXElp+vKwjE2lvHyIwMnSB6+IhNvO
 erdXsg0iT/zUj5hD2Rt7NNAIY971ABKrRp1E/NzCzymuqCAWMfTW0vQkX5/Djcbx6BpF
 a8dZ0d+bTVZA9np0eAYpFb3QSMhdGyq+w8lN/ViqVhAm5025I4+YAm5C8rXT4VBVh84f
 V+qhfuqksju2aJTElJbDNt2sWolHzBBXKEJesFwwTQRwYsR1j5sh9xXNag+HoL5WlKFQ
 4W9AcOjwcfnSJxRQ9czoE10nFDbHW4jNBs593axQrNTa6tH64x2ciwOKEy+UcSkp1HN3
 UuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119526; x=1770724326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lCQXfrGRlea+C74aku67SoZ+IPzjFLau/OaSoC6An2g=;
 b=l4Wqd5m5s3z0geCBH1r4epqmt86/oi4IEXlnpl8GfdWqkIQSaBjk6FPFiY5ENIHvT4
 cxeNvOBqkkBS8lSTkPf2AZ4UoyOyJM3wA0QbVBPfREikXCH9B/tdGJ79+0kzxEI99r/b
 aHu/BGyJ8wAPLT7KsGSLi8rvHGSmV1iynnDkLBNH29SXkptS7Y6Z0shDJYjA0/ZAoPJX
 jWA9IcRg+uvImiYvXiaHiXrt5Le0IsYvO/AEsmnnV+/QUlcjWgSBA/W84/GD+gLCM8Kh
 Qyxnio4xsR5W/xb3RuNMKIXA4w+vhdEL8B3QgMn2VV72gMJvrLJN1dBi7j39MXyOB7xv
 rJNA==
X-Gm-Message-State: AOJu0YzhcI96kYIrip4b7yV7Ka2T04SLUuHIxh3TPNHJ9LiJkB4pDEY/
 ZN81MbLsPfDOtYePHyE8KfsiSqN2K0GtWW5PXBfnvf6RnulMj6d+HCDbC1fivJgA1D4=
X-Gm-Gg: AZuq6aK5KV6gaLQDBvqlZ4iHnDkekYkBhF8m47P24sTAIXcdcPke8f+OuHlljCq2+vY
 z5liNPSp9sy7BZSTl3qe7UVU6Lyv1zSrSkqzWN6lEaTy293ju1SOjl6U3yP2rYUXQr2tBQbWGAU
 arnZ5kVq+ueU8cuzw4ppACTLUZvZ8HWVEVMe25MnHF/NGOzulcIkDacgzZsMraMdxtU1JEgEhC+
 cAQc5ozwHyTlxqjWDSRE03bcQXCJt0uL/ZHhkshRxjqp/yTgXebykPeHTazLIgXLGNNusBDAJY2
 HH30NdzyEPzYykpK7Z31lWvgKrSAj97dpkOLvui6NJ+YNLV1lpVR4n87R/nyoZVYlPap5Y3OjFk
 nA21hNYkQxJ2MKX9Mf+yBY0P3Ig1nWYOCHW+1vb49hWTW3wbsxEdIVZGy8QTV59CObk2SiFBX62
 LYSJkAlTsAqz8=
X-Received: by 2002:a17:907:1c1e:b0:b83:b7c5:de2c with SMTP id
 a640c23a62f3a-b8dff514b5cmr970984866b.10.1770119525723; 
 Tue, 03 Feb 2026 03:52:05 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e142a57c8sm618914466b.37.2026.02.03.03.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C35D60001;
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
Subject: [PATCH 04/11] gdbstub: extract stop reply message construction
Date: Tue,  3 Feb 2026 11:51:54 +0000
Message-ID: <20260203115201.2387721-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

The stop reply message we send can include a lot of extra information
and a bunch is mode dependant. Extract the construction into a helper
and add specialised versions for system and user mode.

The correct response for system mode should be of the form:

  T05core:N;

Where N is the core ID.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h |  7 +++++++
 gdbstub/gdbstub.c   | 15 ++++++---------
 gdbstub/system.c    | 11 +++++++++++
 gdbstub/user.c      | 12 ++++++++++++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 92466b28c18..3134a6e8eb2 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -237,4 +237,11 @@ void gdb_breakpoint_remove_all(CPUState *cs);
 int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
                                uint8_t *buf, int len, bool is_write);
 
+/**
+ * gdb_build_stop_packet() - craft the stop packet
+ * @cs: CPUState
+ */
+
+void gdb_build_stop_packet(CPUState *cs);
+
 #endif /* GDBSTUB_INTERNALS_H */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index d4db7ba30cc..c82fb5ad324 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1431,11 +1431,10 @@ static void handle_v_attach(GArray *params, void *user_ctx)
         gdbserver_state.g_cpu = cpu;
         gdbserver_state.c_cpu = cpu;
 
-    if (gdbserver_state.allow_stop_reply) {
-        g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
-        gdb_append_thread_id(cpu, gdbserver_state.str_buf);
-        g_string_append_c(gdbserver_state.str_buf, ';');
-        gdbserver_state.allow_stop_reply = false;
+        if (gdbserver_state.allow_stop_reply) {
+            gdb_build_stop_packet(cpu);
+            gdbserver_state.allow_stop_reply = false;
+        }
     }
 
     gdb_put_strbuf();
@@ -2037,11 +2036,9 @@ static void handle_gen_set(GArray *params, void *user_ctx)
 static void handle_target_halt(GArray *params, void *user_ctx)
 {
     if (gdbserver_state.allow_stop_reply) {
-        g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
-        gdb_append_thread_id(gdbserver_state.c_cpu, gdbserver_state.str_buf);
-        g_string_append_c(gdbserver_state.str_buf, ';');
-        gdb_put_strbuf();
+        gdb_build_stop_packet(gdbserver_state.c_cpu);
         gdbserver_state.allow_stop_reply = false;
+        gdb_put_strbuf();
     }
     /*
      * Remove all the breakpoints when this query is issued,
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 79f80256e3a..6963c930b01 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -662,3 +662,14 @@ void gdb_breakpoint_remove_all(CPUState *cs)
         ops->remove_all_breakpoints(cs);
     }
 }
+
+/*
+ * The minimal system-mode stop reply packet is:
+ *   T05core:{id};
+ */
+
+void gdb_build_stop_packet(CPUState *cs)
+{
+    g_string_printf(gdbserver_state.str_buf,
+                    "T%02xcore:%02x;", GDB_SIGNAL_TRAP, gdb_get_cpu_index(cs));
+}
diff --git a/gdbstub/user.c b/gdbstub/user.c
index a2327c61352..cc71cda3e33 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -974,3 +974,15 @@ void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
     gdb_put_packet_binary(gdbserver_state.str_buf->str,
                           gdbserver_state.str_buf->len, true);
 }
+
+/*
+ * The minimal user-mode stop reply packet is:
+ *   T05thread:{id};
+ */
+
+void gdb_build_stop_packet(CPUState *cs)
+{
+    g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(cs, gdbserver_state.str_buf);
+    g_string_append_c(gdbserver_state.str_buf, ';');
+}
-- 
2.47.3


