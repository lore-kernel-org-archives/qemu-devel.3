Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42770FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcp2-0006jx-IA; Wed, 06 May 2026 10:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcom-0006Zg-Tg
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcol-0000on-AH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891f625344so10810725e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076097; x=1778680897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cUjSLdSoIrDBQplroB02h7z26WmhahkmttyxJ4BZ4Qw=;
 b=DlhHE48H8fosb68RSn4io2pvYNux0JbY0fi4RUt3GM9j01sZLb4D7mAyrn9G6ezpm7
 rumIcQP4An970gnFVC9A8Pq5JbC021A5OujpNfG8FRAlCCfKiq9aFprletATMPOi42e+
 DBs0SHZXKuNRXkdqJUwmPALahA5BS+68yC8n850UmwVMS08CYv9o+nNu2eoer3Biy2iu
 PVFZkgNbLHyBxkq+3LC1p7M2OIqrzGvQh9eWbrDMpldplSQqKpzucYkcYbUcSUCpdDws
 PI/gQZjzhDc2hlOYLAMGvJxGifzuyC9DdKMeu4LGG+HbueZ2O5d20BmSgOPZw+N54BHi
 p4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076097; x=1778680897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cUjSLdSoIrDBQplroB02h7z26WmhahkmttyxJ4BZ4Qw=;
 b=kK8zV0Y/xBpqE+miQcDJSiTPOeGTXza4MaWFNigGdl16Am1ut4QxtOK2QslX87FbKt
 zXCTd4xRbad7l67UG2ClB3v7453x+7gJv53/1do5yeFIE2ju6eGrEOI0GJZkpLYEQZ01
 h7GdWZlpbzYZqRy5XoQTgR0laQsmy3UESMm0S+dWAD4V6JT7utXW1MDxu4Nu5Nk9wjqL
 X3W/DwsjwkUpZvCfYMkWcXEuFDTMNWeMDjrREVdjaS1FztiH6ErXuTTjJI7/acGoUwpy
 /lfuCD9aIOe6WOhsD0K32AHiVaAGTeiLGhgGAdp6wk2bX8eYSI0vZWx+2fozr0+IKwTQ
 0UwQ==
X-Gm-Message-State: AOJu0YyDHuSOjVCxJE2dPOaAj5JRUstkPdb1FiNeGcrTLpR/Vl2LiylW
 jM+uNJPKy+SKDVacl64g5G9NgHYhD8hFvF/zI2lrWlYaKHrbFb5z+9nDBDvZ19167SPjbw/kcmI
 ZnbrPdbk=
X-Gm-Gg: AeBDietUpOo1/CM6uay1evCr+q7Sij901YYg7AbMU9fDWn7qjxS/6RCGID1iYrmgzNf
 1zgyE136LyzkvCTl9f/kbAMWEiWLQq0kzPcGf/654tfCegiQR7SbvcEXflbSlS+bKcBOkmXHgEo
 4mW5vIegwf3cNqG0vutMnA5XvpMRPK+zn19XFC80vDuQwZohpgziNKyQSDhXNJAuv4L7jqlf95Z
 2hVXGJd66gHGVTj5pr3I9YgwQzO4f3GszVUm+Ur9Efi5wipEP730YH1VORiTneXaVmNKzSHW2s+
 G483gDwoQbqtruyDHMdx0HQJB2Vp1HIJFJJjdUcaQ6q846RKQpXA/mv+P8ir3F1K5hhl2zXCC3b
 zysEBSpJLJFcYzit7izYGVcfyf6aUQmWzkTVwvJ5Wgc3Eq3COPj3onDQICndEUccnEf3FQcFgBK
 ppNpeT9XlTnyF0ExahSxtpYJeHoJNB43lGwz7Fm/nVsinUex2kBt27KRebfqdO5J6VU0T9ZB7We
 wIFYQL+wZ0=
X-Received: by 2002:a05:600c:821a:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48e52286b5dmr49524805e9.7.1778076096465; 
 Wed, 06 May 2026 07:01:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53142ce6sm17602855e9.28.2026.05.06.07.01.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 048/110] hw/s390x: Reduce 'monitor/monitor.h' inclusions
Date: Wed,  6 May 2026 15:54:20 +0200
Message-ID: <20260506135524.20617-49-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

We want to make the HMP commands available for all targets,
move the declarations to "monitor/hmp.h" where all other
are, and only include the monitor headers in the source files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260427080738.77138-13-philmd@linaro.org>
---
 include/hw/s390x/storage-attributes.h | 4 ----
 include/hw/s390x/storage-keys.h       | 3 ---
 include/monitor/hmp.h                 | 5 +++++
 hw/s390x/s390-skeys.c                 | 2 ++
 hw/s390x/s390-stattrib.c              | 2 ++
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 66716a97c05..0305873b019 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_ATTRIBUTES_H
 
 #include "hw/core/qdev.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
@@ -72,7 +71,4 @@ static inline Object *kvm_s390_stattrib_create(void)
 }
 #endif
 
-void hmp_info_cmma(Monitor *mon, const QDict *qdict);
-void hmp_migrationmode(Monitor *mon, const QDict *qdict);
-
 #endif /* S390_STORAGE_ATTRIBUTES_H */
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 2d02936c31c..666c05e2996 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_KEYS_H
 
 #include "hw/core/qdev.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_SKEYS "s390-skeys"
@@ -123,8 +122,6 @@ int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
 S390SKeysState *s390_get_skeys_device(void);
 
 void s390_qmp_dump_skeys(const char *filename, Error **errp);
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
-void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
 #define TYPE_DUMP_SKEYS_INTERFACE "dump-skeys-interface"
 
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 27ce1c303f4..3ba17008255 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -174,4 +174,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
 
+void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_cmma(Monitor *mon, const QDict *qdict);
+void hmp_migrationmode(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d974d97b5e7..7dca67d6618 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -24,6 +24,8 @@
 #include "system/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
 #include "trace.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 2e83aa211cd..74b23b0a995 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -15,6 +15,8 @@
 #include "system/ram_addr.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-- 
2.53.0


