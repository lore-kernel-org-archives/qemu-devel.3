Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE63D66BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyxL-00005v-K4; Wed, 17 Dec 2025 16:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxD-0008SO-Mu
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyx9-0004XX-Pn
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:02 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a09757004cso56578615ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 13:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766006458; x=1766611258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ux7V/vcnfKVnQVQzXuR5cKKTLtK6T4UuaelCSQB/P7E=;
 b=y7P6vWPnVzWfbUGpCQ+t1+sGUs9IaQc1N4pqi8vzZ045KSca5snK6SJXKecnH7kzEx
 RMUHA3AG/OvCKP2uLcf3LpryOEOrnlwS3TB8zl1DDF1fE4+DNjo1+L5e4ZIy9bHiamQ9
 v9YYRYtftQDpiPt/6zBdqoYk3zOqu5mNgGMyX4Z04TRtLHJBfDNzDstNb+3pO9fEJq5a
 KP5NCyoKSCDCn2hvhhXUP2ENOsAHZb6x+7wgmVWbpmtjjjzUtV8e5YakzglApDARQnyI
 JcDB95rQg4s1xQj0OJhsS0BAnYELSxMcFGVwZsklsf7HsR3htnSvSFiN+V59cuSSrwU3
 HtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766006458; x=1766611258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ux7V/vcnfKVnQVQzXuR5cKKTLtK6T4UuaelCSQB/P7E=;
 b=A8UMx2OXG1ty0vqe3Ct4hclX7LbBt8vGaub4ah5lVRi6JlwNeED8QHMH5aDtCY+MQQ
 HGU40ecyBqkMAiyiAOOQqywVZHtSohEBjak/OT6gIlONODoaTCdAtBruNxJ5fKdIJRpF
 GuWzzIJi+h/mIyRKK9uZIZ0L46FU6besgqeNLl+XfalW9ahAOKoMhZzympYS2UOU/XMg
 mDgX1HB8Clg6F0AX8BQwE/9Uy+sIHqiWeVjuKDsYEBuT6mtSYzeboqDPQuBLIzL8EApZ
 ib+6V7HjGslqdLJ/+tuYXiSYeqKRI3+IlKXA15PN/rdSeESCw6mn4zveQa4Qthmb9RAK
 kqOA==
X-Gm-Message-State: AOJu0Ywdhmy1PxYtfrKkX3k4uyqUnzFz9WCH4jr8hXEHbLb3VbVKylor
 MsJ5ULf+G0XmydeEMT0qxPNeusbQc7ltVnhiWw40EBR2gg4M3AE1vZ88p/Jk4lock7atoGbUvkW
 YUKm3
X-Gm-Gg: AY/fxX6HY75/VsRMs2cmlw6D3aPgZ0VSwkkg8UN3lnV4aHt4c81t+P/x98ovZMuwJH5
 NZzzm97Kv1Oj6XOlcWXPmZH4Fb9b12zqTksywl+TdeAajiI+PeUoWBTzelLvGQvu1wsZ7Ask07G
 ZxF07cV7TYF3/VCYVr2I0ugxYRRntvWfAx1RtxLpnZTDXIBdYB6qCp6MrRCIaNxKdKImKxL5wJk
 +0KPkf2gXAEqtdmHq8HV9YNy7vh/eJLm+4JDJMxejDMeitnblJchjoVBhlyOjHcA1Gw/PGnexx/
 mipViaM7XfpVdThy5a6bzYL3Ij2XWWmUJQWRrYu/bq42JOSH6paWruguobco5UFWDLb+rUldWfo
 oFHkqTRFsJSvvqVdlnln2xJEPkXVy1uQfUwn+L/XKbwh4DvfSVyIy5bU/CjiVUej/xwfM5TdxX2
 5K+ZxQgANkuwWJfkg=
X-Google-Smtp-Source: AGHT+IGsmzPhSKcPO8lH02VXvl/xP3usSOzkhMUBWaZRt8bf0RPs57isX9k0jJ8e+xsm9J2ufQt40Q==
X-Received: by 2002:a05:7022:3b8c:b0:119:e56c:18a7 with SMTP id
 a92af1059eb24-11f34bc656emr12330014c88.15.1766006458073; 
 Wed, 17 Dec 2025 13:20:58 -0800 (PST)
Received: from gromero0.. ([191.8.216.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061ef3383sm1852476c88.0.2025.12.17.13.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 13:20:57 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 1/6] target/arm: Initialize AS 0 first
Date: Wed, 17 Dec 2025 18:20:13 -0300
Message-Id: <20251217212018.93320-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217212018.93320-1-gustavo.romero@linaro.org>
References: <20251217212018.93320-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
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

Move the initialization of AS of index 0 (ARMASIdx_NS) so it happens
before the initialization of the other address spaces. This is purely a
code organization change with no effect on behavior.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc..1640b20b4d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2158,6 +2158,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cs->num_ases = 1 + has_secure;
     }
 
+    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
+
     if (has_secure) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
@@ -2175,8 +2177,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
-
     /* No core_count specified, default to smp_cpus. */
     if (cpu->core_count == -1) {
         cpu->core_count = smp_cpus;
-- 
2.34.1


