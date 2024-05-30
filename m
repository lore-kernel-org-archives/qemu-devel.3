Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEC2C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaUP-0002pl-3s; Thu, 30 May 2024 03:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaUD-0002fg-Id
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaUA-0003N4-Tp
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35dc0472b7eso563984f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717055165; x=1717659965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86k7CF14SSg/CYqN2D7txu231XQemu6J+/zlA2s2d3g=;
 b=CU2im0Wcsh9VrTyD++I9rVZB8REdLHEM8elVT7j69sQPwzNCD+nPOnGtrMyiMdMI+C
 MKSq9XO0johVQX6dalrRatiubpkIfDg7iegH0f932Nt62fuxkoITWVsf7MkPJgwMzJYz
 TbVLN7eaQsCi/2puAWGCag6i0tNVrRfjl55V0DxYGh+PV7vy/ORvistOloSc+bmmc4pe
 dgrfBhu4WBLM0d+F/UrZS7rhO7P5Oe9QnDV6AbjTF1kw/GwKaScqEITooxS6/WBVOwiN
 y8GYP3T4JUKVM3dtiCw/J8LwPSkvxvP0G5w3D/CJYfTWMz3F6Sq+wKAzWhb9NdNJdWvU
 KIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055165; x=1717659965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86k7CF14SSg/CYqN2D7txu231XQemu6J+/zlA2s2d3g=;
 b=gcavmcXN1i4bNvrAx5/td1oVyCxr6DEdpYsL4aL4vyP2l5AvZ44oExzAqnQo0BDEmc
 kvnasgmhrGuf1fpQadcKYTv05eG6GrWO5pJMt3vwVueVSq6O0QBVaLfwwPeH08+U0LDx
 7IBWi73+l5OpzaySO8nhkpGcUxIWzkN+dst3JFWhXiIrRUVbbSvHypArtFIs5Lba/o8A
 FhJJIxGMYy+mtw17lV5kmjsfcza9xkpl3Sr8CCnh8fBmwXavUMQKYndAfssDKK603Rug
 qby0gBsNEmQQIdJuK/RUr6/tFhYWAL2arSZJ83kFSv9aJtQxbZ2U8DfoG9Qc5Octp4Rn
 Ozsg==
X-Gm-Message-State: AOJu0Yy6KItWC2WYGsQ2VBWuUFnaOUG5x/4Z4+Y3t1LSbJsX/Syh1W/H
 Sy252Ai6WQNvU7RbqQg1XbU2kKwb7NckHxpcPBeVNdTXQTBIRVfkD88igjOUkRmzkhrAPiX1NP/
 X
X-Google-Smtp-Source: AGHT+IEmftNfdDbMA6FOoRjkK3+k/JGk/r04ilH9+Bc+75KFFpoW4tMh6RvD4GeQN9KHkRD6in5jqw==
X-Received: by 2002:adf:ec04:0:b0:354:cf3b:5791 with SMTP id
 ffacd0b85a97d-35dc02bcfd4mr846234f8f.70.1717055164804; 
 Thu, 30 May 2024 00:46:04 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c960esm16668562f8f.80.2024.05.30.00.46.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:46:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/s390x: Introduce the 'dump_s390_skeys' HMP command
Date: Thu, 30 May 2024 09:45:42 +0200
Message-ID: <20240530074544.25444-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530074544.25444-1-philmd@linaro.org>
References: <20240530074544.25444-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

'dump_skeys' is specific to the qemu-system-s390x binary.
In order to provide it in an unified single binary, add
a equivalent new command named 'dump_s390_skeys', which
works identically on s390x and reports an error on other
targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h      |  1 +
 hw/s390x/s390-skeys-stub.c |  8 ++++++++
 hw/s390x/s390-skeys.c      |  9 ++++++++-
 hmp-commands.hx            | 13 +++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 954f3c83ad..647a1e4a3f 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -181,5 +181,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
 void hmp_info_mtree(Monitor *mon, const QDict *qdict);
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
 void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
+void hmp_dump_s390_skeys(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/s390x/s390-skeys-stub.c b/hw/s390x/s390-skeys-stub.c
index 50b5f83437..94b491425b 100644
--- a/hw/s390x/s390-skeys-stub.c
+++ b/hw/s390x/s390-skeys-stub.c
@@ -8,6 +8,14 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
+
+void hmp_dump_s390_skeys(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "This guest is not using s390 storage keys - "
+                     "nothing to dump\n");
+}
 
 void qmp_dump_s390_skeys(const char *filename, Error **errp)
 {
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index f9bb08eb92..e7dab52a6e 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -24,6 +24,8 @@
 #include "sysemu/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
 #define S390_SKEYS_SAVE_FLAG_EOS 0x01
@@ -105,7 +107,7 @@ void hmp_info_skeys(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  key: 0x%X\n", key);
 }
 
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
+void hmp_dump_s390_skeys(Monitor *mon, const QDict *qdict)
 {
     const char *filename = qdict_get_str(qdict, "filename");
     Error *err = NULL;
@@ -116,6 +118,11 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
     }
 }
 
+void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
+{
+    hmp_dump_s390_skeys(mon, qdict);
+}
+
 void qmp_dump_s390_skeys(const char *filename, Error **errp)
 {
     S390SKeysState *ss = s390_get_skeys_device();
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc..c12e2c2bd9 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1120,6 +1120,19 @@ SRST
 
 ERST
 
+    {
+        .name       = "dump-s390-skeys",
+        .args_type  = "filename:F",
+        .params     = "",
+        .help       = "Save guest storage keys into file 'filename'.",
+        .cmd        = hmp_dump_s390_skeys,
+    },
+
+SRST
+``dump-s390-skeys`` *filename*
+  Save guest storage keys to a file.
+ERST
+
 #if defined(TARGET_S390X)
     {
         .name       = "dump-skeys",
-- 
2.41.0


