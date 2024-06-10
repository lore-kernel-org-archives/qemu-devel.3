Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D329C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjId-0005Mo-Nb; Mon, 10 Jun 2024 13:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIb-0005M9-U8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:17 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIZ-0001bB-RJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:17 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52c4b92c09bso270760e87.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718042354; x=1718647154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyIsM5i4zPBNdNF1s0PfQtdMv+Jq8dQQMzodQt/XrZA=;
 b=rQzgkOQIvhnNWVLlX2LhmmFsUokDfnjBmC0+ZZZI0AKFA/QfVZv+Z0APJI4EtwkSt0
 jhcFi4cehtTCz0EuiDbQSdN3726MFKmJMy5Yyk2tqEvkjZBnVXYNPJ/BryYn0JeNrlhd
 FFRN/wC8WoxaOKhzTsSPF+aecMW0dzIQrlMDJnfZu9spn5YoV8Cm7dlf4Musb4daPTmD
 h8GvO5QwDbf399LpEAQDTDVTHRL5d6qXiF4o5lci2EW1idhwXpePO2a5Hu4r0o0X55Kr
 8ZSeJY0qsAMiQdEPhqbLh09QHdMT5uEbZc74vHAeeKcIk+lGaGOkV0fnzODgk1EVmr0s
 uDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718042354; x=1718647154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyIsM5i4zPBNdNF1s0PfQtdMv+Jq8dQQMzodQt/XrZA=;
 b=dgTFC0JAWbwheeRAvIrZuNlAA8mo++pQeE2ccbdA5O3YQYMbyRDrWwNTZAcbDrN/tD
 ZQ8h5/I/yQLDtcMeQY/gSj6s3oGG86rVjFFfdAsTcoMHb81bsI5boSVlg2DhJ1qZ0viu
 vAGd7onVrvnA5aXSlpCWWqs7AucovwWrCtP5YV1nbW/obdrdnLhPOFHBA0ts4aMFN7au
 vss7njGmHD8F2JnoEQHlyylXAsbzGQR+RQD8agdFlTAaWx6y0GO15kzh4L6kY7EPV4Vu
 dv7M+uedm16EMfew6k6wEC1NjOB+AQZ6EgHs4IcaWWLCkFJlLLPZM6NxevrZDVyOAosJ
 jaiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpXrnHMGBDoTkjRLVLNOdVGQ14TR4IFiz9Zdxa+gbMSUmttdv08Pr49IzXYrUqPrjYiGzJD9sz9Si1rVPksb2mgfRYKIw=
X-Gm-Message-State: AOJu0YyCK1EEA0U0SSFvenvrGKB2VTiHjv8URmbzs7vmEUrBT0353Vf4
 8NIX0O4lLSUx/cRVgTvdTkAU1amMihQ4t3wrdAlImVtcj/1t+OnueB3BYktQ+x4=
X-Google-Smtp-Source: AGHT+IE/dnRCmyenDy+frFLywNY+imaKEZh9Ff64wBtFkwJv/x3PrsyLwzPdfcTOAkwSjIxWCGA2kA==
X-Received: by 2002:ac2:5e62:0:b0:52c:7f8d:4888 with SMTP id
 2adb3069b0e04-52c7f8d490cmr4836851e87.24.1718042353801; 
 Mon, 10 Jun 2024 10:59:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421e6f0861bsm36413705e9.4.2024.06.10.10.59.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 10:59:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 3/3] hw/s390x: Introduce x-query-s390x-cmma QMP command
Date: Mon, 10 Jun 2024 19:58:52 +0200
Message-ID: <20240610175852.21215-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610175852.21215-1-philmd@linaro.org>
References: <20240610175852.21215-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a counterpart to the HMP "info cmma" command. It is being
added with an "x-" prefix because this QMP command is intended as an
adhoc debugging tool and will thus not be modelled in QAPI as fully
structured data, nor will it have long term guaranteed stability.
The existing HMP command is rewritten to call the QMP command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json        | 20 ++++++++++++++++++++
 hw/s390x/s390-stattrib.c | 28 ++++++++++++++++++----------
 hmp-commands-info.hx     |  2 +-
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 6da72f2585..a56b7572b1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1905,3 +1905,23 @@
   'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @x-query-s390x-cmma:
+#
+# Query information on s390x CMMA storage attributes
+#
+# @json-args: HMP arguments encoded as JSON string.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: s390x CMMA storage attributes information
+#
+# Since: 9.1
+##
+{ 'command': 'x-query-s390x-cmma',
+  'data': { 'json-args': 'str'},
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ]}
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 9b4b8d8d0c..8c2372bd71 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -19,6 +19,9 @@
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/type-helpers.h"
 #include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 #include "cpu.h"
@@ -73,10 +76,12 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_info_cmma(Monitor *mon, const QDict *qdict)
+HumanReadableText *qmp_x_query_s390x_cmma(const char *json_args, Error **errp)
 {
+    g_autoptr(GString) buf = g_string_new("");
     S390StAttribState *sas = s390_get_stattrib_device();
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    QDict *qdict = qobject_to(QDict, qobject_from_json(json_args, &error_abort));
     uint64_t addr = qdict_get_int(qdict, "addr");
     uint64_t buflen = qdict_get_try_int(qdict, "count", 8);
     uint8_t *vals;
@@ -84,30 +89,33 @@ void hmp_info_cmma(Monitor *mon, const QDict *qdict)
 
     vals = g_try_malloc(buflen);
     if (!vals) {
-        monitor_printf(mon, "Error: %s\n", strerror(errno));
-        return;
+        error_setg(errp, "Failed to allocate memory");
+        return NULL;
     }
 
     len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
     if (len < 0) {
-        monitor_printf(mon, "Error: %s", strerror(-len));
+        error_setg_errno(errp, -len, "Could not get attributes");
         goto out;
     }
 
-    monitor_printf(mon, "  CMMA attributes, "
-                   "pages %" PRIu64 "+%d (0x%" PRIx64 "):\n",
-                   addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
+    g_string_append_printf(buf, "  CMMA attributes, "
+                           "pages %" PRIu64 "+%d (0x%" PRIx64 "):\n",
+                           addr / TARGET_PAGE_SIZE, len,
+                           addr & ~TARGET_PAGE_MASK);
     for (cx = 0; cx < len; cx++) {
         if (cx % 8 == 7) {
-            monitor_printf(mon, "%02x\n", vals[cx]);
+            g_string_append_printf(buf, "%02x\n", vals[cx]);
         } else {
-            monitor_printf(mon, "%02x", vals[cx]);
+            g_string_append_printf(buf, "%02x", vals[cx]);
         }
     }
-    monitor_printf(mon, "\n");
+    g_string_append_c(buf, '\n');
 
 out:
+    qobject_unref(qdict);
     g_free(vals);
+    return human_readable_text_from_str(buf);
 }
 
 /* Migration support: */
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cfd4ad5651..0a944e43ce 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -720,7 +720,7 @@ ERST
         .args_type  = "addr:l,count:l?",
         .params     = "address [count]",
         .help       = "Display the values of the CMMA storage attributes for a range of pages",
-        .cmd        = hmp_info_cmma,
+        .cmd_info_hrt = qmp_x_query_s390x_cmma,
     },
 #endif
 
-- 
2.41.0


