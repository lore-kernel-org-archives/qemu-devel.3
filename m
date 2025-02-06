Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871C7C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3YP-0000Zk-F3; Thu, 06 Feb 2025 10:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YM-0000Yq-5Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YK-00015t-4k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso7082895e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854746; x=1739459546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHepygSTQPvUisviVKnRnZ056x3g9J+9ojwVkl7r+jE=;
 b=w39CDkRrNfp3UBBvB43S4xJ/J2OShWEnci5cs9MrpYyD482ikugbqxAKI2Sss/5nhk
 uNfhsYcaBsWcasxnsslb/e0jGFd1QTj+YvMcj7xtMDNzXV6cAtj2PfycJ+SfA0sW+i9m
 Wbs7BOHop5N4MnC1sij6FZO9d67ofluGVQwGISAMvnZb1DVa4DuyyWLLMWSEnhmy88Dt
 mzQFqCTGZ8isZvW2YutiSOUcTM6OX7Uy/yKKf3OMZMjq8I1JLm7keVrb4qlwkUioLn55
 xYCwZwc3Re4Lk/LSO48tKpagnMgmEVrGjgtWCQtZF8YGEIR2ZHrvYLEuth7x7/bW5byh
 LNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854746; x=1739459546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHepygSTQPvUisviVKnRnZ056x3g9J+9ojwVkl7r+jE=;
 b=fHTnFjWMaS3C7igVhsSdPUhbDVTqllOais911fBWG8ruaG6wCs8pV5fL9iR1G5fO8t
 G4JbiSh6/kU9zwQc6YuYk8pzd1syMaxhBhdMxDhg9mxE3FQ9a6n9ljm+NTJl6WnXZTCS
 /8Twk9ofsnspMA4eQ+rhp6eiARqpWarqv8Q6ceU+DgD+fTbX7/WGHGscpS007v7+4R6C
 wx+oQg4jPil30+52NKDKtWTKr3CV3chhRlAWUbBMpr4N7gEA7X2U3kVAfwlQGRv3cPZ5
 HaWeeMCHMTteBOG2yXyHWEZufCynspzU3DszsuW3HwPr8RX1tQYFzvyhcLtn2x7w7ZfJ
 TQyw==
X-Gm-Message-State: AOJu0YwfoUmHgQXu5KcugCRUdCHHQBfUXEV/4aSl/t9YmfbG40nwcsVe
 kVDTCvCqGvmodazm1XzCwRKbfmd0n3bpAaYe2qj1Jwem/d/E1ysFgDcJADtyfkd+Kd5n+V9J0os
 L
X-Gm-Gg: ASbGncu2xKqPdmsJmSES+M4Qo5o7e005M4fCgx7p9+do4zi7px0WNmMRZrjMnSPhIZ8
 6K3BXVMJiJHl4PWepo4iiGhfj3fopi1nU5jXtCZ6ElSW9//CcN6YI46S5DMfeW/ieXfXkwYn1MQ
 R75UgZXOTrfsioyj8GJB/a5JObQI8qfqxa+kkUgFdQuO+krK5AVQtNlHww9klcEy1o2Q/QfEPJ/
 8Uci9yM76Va8Vazi1qUMtL/QcUzZmqcrb3QRgE30qjKonMgT5hqNHCmW/5MXQyQDEzoD64OehJZ
 p0dmULdB+thZOHNlkuD9WA==
X-Google-Smtp-Source: AGHT+IGltjcEiJzKtyFhBuzcTM9FTBBsT6c8Iz681X4mia7nbFbis3sqG3SrhKUkUhfdM69JN0flYg==
X-Received: by 2002:a05:600c:46d0:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4390d57762amr65606665e9.31.1738854746320; 
 Thu, 06 Feb 2025 07:12:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm23591535e9.0.2025.02.06.07.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:12:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH 6/6] hw/core/machine.c: Make -machine dumpdtb=file.dtb with no
 DTB an error
Date: Thu,  6 Feb 2025 15:12:14 +0000
Message-Id: <20250206151214.2947842-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206151214.2947842-1-peter.maydell@linaro.org>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently if the user requests via -machine dumpdtb=file.dtb that we
dump the DTB, but the machine doesn't have a DTB, we silently ignore
the option.  This is confusing to users, and is a legacy of the old
board-specific implementation of the option, where if the execution
codepath didn't go via a call to qemu_fdt_dumpdtb() we would never
handle the option.

Now we handle the option in one place in machine.c, we can provide
the user with a useful message if they asked us to dump a DTB when
none exists.  qmp_dumpdtb() already produces this error; remove the
logic in handle_machine_dumpdtb() that was there specifically to
avoid hitting it.

While we're here, beef up the error message a bit with a hint, and
make it consistent about "an FDT" rather than "a FDT".  (In the
qmp_dumpdtb() case this needs an ERRP_GUARD to make
error_append_hint() work when the caller passes error_fatal.)

Note that the three places where we might report "doesn't have an
FDT" are hit in different situations:

(1) in handle_machine_dumpdtb(), if CONFIG_FDT is not set: this is
because the QEMU binary was built without libfdt at all. The
build system will not let you build with a machine type that
needs an FDT but no libfdt, so here we know both that the machine
doesn't use FDT and that QEMU doesn't have the support:

(2) in the device_tree-stub.c qmp_dumpdtb(): this is used when
we had libfdt at build time but the target architecture didn't
enable any machines which did "select DEVICE_TREE", so here we
know that the machine doesn't use FDT.

(3) in qmp_dumpdtb(), if current_machine->fdt is NULL all we know
is that this machine never set it. That might be because it doesn't
use FDT, or it might be because the user didn't pass an FDT
on the command line and the machine doesn't autogenerate an FDT.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2733
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/machine.c         | 6 ++----
 system/device_tree-stub.c | 5 ++++-
 system/device_tree.c      | 7 ++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b740071ac7..f0e45fbad9d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1701,15 +1701,13 @@ static void handle_machine_dumpdtb(MachineState *ms)
     if (!ms->dumpdtb) {
         return;
     }
-    if (!ms->fdt) {
-        /* Silently ignore dumpdtb option if there is nothing to dump */
-        return;
-    }
 #ifdef CONFIG_FDT
     qmp_dumpdtb(ms->dumpdtb, &error_fatal);
     exit(0);
 #else
     error_report("This machine doesn't have an FDT");
+    error_printf("(this machine type definitely doesn't use FDT, and "
+                 "this QEMU doesn't have FDT support compiled in)\n");
     exit(1);
 #endif
 }
diff --git a/system/device_tree-stub.c b/system/device_tree-stub.c
index bddda6fa37a..428330b0fec 100644
--- a/system/device_tree-stub.c
+++ b/system/device_tree-stub.c
@@ -5,6 +5,9 @@
 #ifdef CONFIG_FDT
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
-    error_setg(errp, "This machine doesn't have a FDT");
+    ERRP_GUARD();
+
+    error_setg(errp, "This machine doesn't have an FDT");
+    error_append_hint(errp, "(this machine type definitely doesn't use FDT)\n");
 }
 #endif
diff --git a/system/device_tree.c b/system/device_tree.c
index 56d4ac5650a..0d554240f93 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -635,11 +635,16 @@ out:
 
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
+
     g_autoptr(GError) err = NULL;
     uint32_t size;
 
     if (!current_machine->fdt) {
-        error_setg(errp, "This machine doesn't have a FDT");
+        error_setg(errp, "This machine doesn't have an FDT");
+        error_append_hint(errp,
+                          "(Perhaps it doesn't support FDT at all, or perhaps "
+                          "you need to provide an FDT with the -fdt option?)\n");
         return;
     }
 
-- 
2.34.1


