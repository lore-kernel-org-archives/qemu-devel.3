Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E204FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1x-0001Wb-55; Mon, 27 Apr 2026 04:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1h-0001J1-SU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1e-0001qL-L8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso5952818f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277344; x=1777882144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vj1VCyGpmEVZZgVNhKzGcdjLaf+nPbuu+8SZqhBUOlE=;
 b=egeU0eVQCadUmdEanMQFm3vXfE2gdLqQ6np2ddcTYBt2S89TGn5Myj8dkDXCfftWbv
 ZhwKmGsKCu1KMwciqZXXES8VZzk4X/N/O50f872Xil/wDabn/WI/he+vuMzgFzBpEU7C
 gRy89XfjUPsMIISWbKmiUhSkLTBU63h1o2qQgM65MIFgYECSiihjMnSCY3ysZgveFqXO
 /QTkcPzeSYb2MR4L6MyExMsRqF+bQI5IYJYh9mG9E8PZVkptGp4mqJHul4B3bFYt/hYP
 bihsJsAp85THWlBOsoZ6aWZlO3vEuP8PZa+8UNc5fFwMNq2bzM7wPHymhgsB1++OouOI
 Qb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277344; x=1777882144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vj1VCyGpmEVZZgVNhKzGcdjLaf+nPbuu+8SZqhBUOlE=;
 b=baVHUOqebuSJrBVCjA2K443qGRvFVxpfPWkzJRcVAR1JCmHkn230Tm0FdgD4JxMPq4
 fIlLwcw39SV7Pwmac7m5USjcBQnRj9H/mrqtH40cyiS4HvQSAq+ZE05Xo7I0nCXgRKYE
 oPXDS399GrORBCmF7qS26TdMKgl/fhikpFdSM4eCX2dUlYkkroWNArffup0R9SRNCp/W
 jXQzSbwVYd50wcAMdmqLy73CTKZXe8EVtQIFjrLS+OlM1dbd79ej/JDmAd3muoeXkvvj
 Z2gnDQa8oGPfybZghny+394bVGnOLDp4OiyHzxDVdcC4jAnTd/t7eRfreJMzQd4XTffR
 Ze9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KOgfurPILpMSj2SEALR7pex/ZCBP9fgEpySzfYuHcKMzANvl6vwJC8ZBo0jOjxZbLx3Ou/Xzr2IvT@nongnu.org
X-Gm-Message-State: AOJu0YzsAGPeOwigtCx8TPU9gLSUyDpdPK5H8zFK0sm/Q1QEojIH/XFt
 61v9tYgNl4UjXfjnao+VxOY6R6R0iAMHQsFnTqVFe69ZEouljoJgflsT8XrZ5CKfGwW38FFX72c
 5nMzQQpg=
X-Gm-Gg: AeBDievVyF5PnQfR+ytyBEPT+7oSzKR1CeQSQ2RsUEb3K+aO22GG27vFDv2ZRtGV3yB
 7BX5j2LQslOf66ALdzM3Blq4nZLwPqOOi3jNHjj0W6aQOoLp2ziflI3ovHSG886gLtWi2+hhRH8
 ICcyxiyWy19p5KaHXdUHBzLZ4pIYciWcIhfRttQntw1NU+BN5i5LnoHrmrlFXAypUD6ILvWVyhw
 YlpbmnpbwRGBiGPTcmN38vSWlI9eoz3bEc5R1exU+/fIxfKqw7YZV4FD7URiYWLh5YxJzmpGrUz
 BDZ6yn8764N/+EhiRJGi6Str5OwDCbUCUvSJDvJ6ryxEbWbAzcgMAlWlg2G6PCkpyxiATaMsPeM
 eX9w4gXSFHNLkDv3TW0fL0Ky6swKE8TPALgOymhmbzgGXPpBRI0V0rfFJUSc274o2coxTBcaUMg
 c76Dt2dNp+/f5suAdP24PPR7Qo5cvD+Mhuso6aHkLQ7YtJcHT6WxLZcQ4fJKMWl1UShJXTZ0o85
 n1w/XYy5+I=
X-Received: by 2002:a05:6000:184d:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-43fe3dd958amr64858841f8f.21.1777277343559; 
 Mon, 27 Apr 2026 01:09:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc09b1sm79693042f8f.9.2026.04.27.01.09.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 12/32] hw/s390x: Reduce 'monitor/monitor.h' inclusions
Date: Mon, 27 Apr 2026 10:07:18 +0200
Message-ID: <20260427080738.77138-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
index 9c2330205fc..d694bfdf768 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -173,4 +173,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
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


