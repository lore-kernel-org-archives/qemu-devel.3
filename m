Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCA7C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zrv-0001IA-5P; Tue, 15 Sep 2026 16:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrt-0001Hi-Ok
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:05 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrs-0005aS-2d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:05 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso2206835e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504503; x=1790109303; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tSwf+aSZl4o9EHWe1PTU6IuxaLQsk5COu15yj71WkRM=;
 b=R6t7HLfT8GVWP4y3KqY47IIoLK211Nf59fuq5H/GJO2mSaIwyRfUZ5FwyxCRtR2hCO
 9aOMwD4KbsarkoOO4Ceqeazh+aI0MM3+8rbyFhsMFptJvNaxIvum8qyB2Gtwjyi7G68P
 71vtHYuKybK0UlYK7fPfIHqi4PauHh9JjuloXeSllLH5alzCj16pP/PZf+4z2KEZsLxz
 lownTPhwOjihep+cWZkM7yVvkItznStT36YUaHyVbVmQGcC/bOtc+dc3R3n9xsP3qso3
 kpT1eTnCGN/xjBA7KcMuDOFH0LCglv5Lzb1jrJSjGF/EiH08My1oSTvW0zuEJTXf+/pt
 rWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504503; x=1790109303;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tSwf+aSZl4o9EHWe1PTU6IuxaLQsk5COu15yj71WkRM=;
 b=CjcFGk8Zyedm7sUPLPLuaGZPQPyPzLDtFyZCMgfDrhpO0tIpXNzQ/9zOqaqGhKz950
 AUe6Pl6IjVe/sBmvdN5xZPsS2SLL/kRibPDpoS5QGiIA2CP1NhH5h29QvXormQ3Rd5Z7
 WQa3B4ZxR+X/YaDiQAV23h5uWcNpsipQC2HpSaPpmYNbSq0CSLkQVkJyX9GO27WHAQn6
 gy0CrOHXDJlCLLbJ4KYS7OZsTwQQrZUpLtKhLw5WxyECoXUqXphoWD9iAIiLS+HsXvQ8
 jeeK8EqEhqGy/XYxcNxb6J3QRWKCYWpXm+EYFmPGK825/chcduPMYR31xr5s1Wo5Sstu
 KN8w==
X-Gm-Message-State: AFuF++kgtQBfFnl8KCZR/eD5gmXQBgGoGdchGKSo2j0X/j6KU3ta14pv
 azCGfQrvPgug1NLdOAD3l32HIpzP7PIQPwzE/SvCQvaWTE1HmUq4hBdsQGxbmF7Sc9VPhNXFJEA
 1MaU0
X-Gm-Gg: AYBFou0cvIXZqNNfZTyPBSX+4eYEpVf7jhDER4HLQR8+0gGQSemzRrMV8e8bFos2SDy
 rkaziOwsqZVb/ziZTnQ3+ZDqxPholYMpBorpuBoCLhx6iE36g7OSFdKNSoF0Ak86yWJa2//BNwR
 +YtUSoHGCLFmZ7kEu573rcO9k6f9yaynPJwu0T/REnejvZfOhvLpxwpJxAVz7Y0ym2jR7uARHLb
 nubTW6q5auAGBY8TX8S4mlpQRZISa5ZTpTZHrm60on1o4eD3F2GLmxMEqu5xFdDbVZ0RFoNibfx
 yMeRMdpZyP7MBiv7CDbqSWlb/L9tG2pLm6BoIFukem3TKuPbMLozbRADlkMIcnvRamBUwsl8kq1
 i+SnCY8aQHX0pz/XtDeMqHYP5GGxwtzcYQfxRc7uljG5OF91QgVlPqfZhAVV9TYyxiO+O15FlN9
 2xTafPyK1hCM4bUGdSq+hRp6Zt8b24LxlVc6sx5BdMzMMJt+6mxipG26YR0pF/a9KVskXbJsrnN
 SD7pB8=
X-Received: by 2002:a05:600c:4f43:b0:49e:6c27:d093 with SMTP id
 5b1f17b1804b1-49e7a6704d3mr117180085e9.15.1789504502723; 
 Tue, 15 Sep 2026 13:35:02 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:02 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH 02/10] oslib: add qemu_debugger_attached()
Date: Tue, 15 Sep 2026 22:34:46 +0200
Message-ID: <20260915203455.580999-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

Code that watches for a hang has to tell a hang apart from a debugger
stop, because under a debugger every thread stops and whatever liveness
signal the watcher samples stops changing with them.

Linux reports the tracer in /proc/self/status and Windows has
IsDebuggerPresent(). Answer false elsewhere, which leaves the caller
behaving as it did before the check.

Match the Linux field at the start of a line. The Name: line holds
fifteen characters of comm, enough to spell the field name and appear
ahead of the real one.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/qemu/osdep.h |  9 +++++++++
 util/oslib-posix.c   | 22 ++++++++++++++++++++++
 util/oslib-win32.c   |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230..96afe09632 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -658,6 +658,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
 int qemu_get_thread_id(void);
 
+/**
+ * qemu_debugger_attached:
+ *
+ * Returns true if a debugger is currently tracing this process. Meant for
+ * code that would otherwise mistake a debugger stop for a hang, and false
+ * on hosts where this cannot be determined.
+ */
+bool qemu_debugger_attached(void);
+
 /**
  * qemu_kill_thread:
  * @tid: thread id.
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index dc001da66d..4eb6a40628 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -112,6 +112,28 @@ int qemu_get_thread_id(void)
 #endif
 }
 
+bool qemu_debugger_attached(void)
+{
+#ifdef CONFIG_LINUX
+    static const char key[] = "TracerPid:";
+    g_autofree char *status = NULL;
+    const char *p = NULL;
+
+    if (!g_file_get_contents("/proc/self/status", &status, NULL, NULL)) {
+        return false;
+    }
+    while ((p = strstr(p ? p : status, key))) {
+        if (p == status || p[-1] == '\n') {
+            return atoi(p + sizeof(key) - 1) > 0;
+        }
+        p += sizeof(key) - 1;
+    }
+    return false;
+#else
+    return false;
+#endif
+}
+
 int qemu_kill_thread(int tid, int sig)
 {
 #if defined(__linux__)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 5f3e8f4d98..6663d83151 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -228,6 +228,11 @@ int qemu_get_thread_id(void)
     return GetCurrentThreadId();
 }
 
+bool qemu_debugger_attached(void)
+{
+    return IsDebuggerPresent();
+}
+
 char *
 qemu_get_local_state_dir(void)
 {
-- 
2.53.0


