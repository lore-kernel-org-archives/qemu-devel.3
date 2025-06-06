Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3DCC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaCG-0005AK-GK; Fri, 06 Jun 2025 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCC-00055C-8A
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCA-0003Pf-Ls
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so12673355e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228329; x=1749833129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEZ1hQ5Ve/n40v+7Xdzb9ewpikW8Poa4vyefkyKHER0=;
 b=vT2oaioRsFG1IBc2zoOjg1xHYbQ5+q9dKHkysw/FEp2C6za58VTtIL+vezMZlDBkl6
 L9rIkNcBB8ZpIUcAsZ1uirZpwfwnwy6RJs80jS22DBKVGJyhMoQF8IxXLf2jt7VFcjpP
 za/I8yPz/rnY/6HrnkUmHmdlNfLtp0BkdVajmfYier5LwytWGrJLSLaBRExRimyISFxh
 /R2KpSW5/j0tFQw/MprnnH8dPsYSEF4h3bQ/ud2sGeeqz+SIQtk8PXW5c1NSFW1wa9Q7
 gOVOWjtjbEdPh/GjJ35/SP36iuZMemurHhh7wCKwMFr/LjQr2SdWzPk3QYYndbW2aOQ4
 InqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228329; x=1749833129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEZ1hQ5Ve/n40v+7Xdzb9ewpikW8Poa4vyefkyKHER0=;
 b=vwQbOimsve0KqcuDZ2ZEiq09prXmY5zBf4vvsaganCb0hsXHo2nOZKbmnlxAwB/2qH
 CYAgpCKP21fgZZiUSnTjb1bcGKb+QT8zRxGQjaZ/aJWZ2w3pfUZr2Hq6S+WMSme8MbSQ
 Gy+S6JY/PKAkrc5l4NxsITrectoX3/I+R366BqHLOmiGRxEHKvO7DRePeyIwhMlBLZWq
 iNCZAV7CuHgRZweK3TBDNCTj2bsr3AQAxrrNjQiuEaf4ld/N1w4hypO4NQ89LO18xWs8
 d32fIy8hWP1SKxNI9z8q3mg9xc3kAzPkQgyq9AOfhB7+ix1jpgnuMry+mL/Z+2Lr22XZ
 qJfw==
X-Gm-Message-State: AOJu0YyyxoWaM3XEFf7VCaj6wn5TuHKlfH4TK7c0A9cIQcs/BFYN1UW1
 VoG065IW/ykOq9oERW96qlwEXbOpmpFlhww852qng5CgIUIGYyRkljGVEhWh3QHGiAgOT82x5Ca
 x6WSUVh+u/g==
X-Gm-Gg: ASbGncvgN9dTV7nKK2gIg2AR9Qdb1KXj+8dmpelDXt8CNUfLCmmDPGq727OSecftzDH
 5+HvUQhL5MGuhGTJ1OzFZOc89ermFO0lY1/mIyfvKrVqAjDfTqfXvrDJPXSU6LLuks0sQCWKFsV
 M7fVo6aQSlsfOICw74nPnNbyl24qLBQU0Fr0dgUgo3eiCG4Y+4uUzW4vh7cZzHrjif6Urk03Qww
 RYFlhtH/fZk5z8eLsfHva1SViYpbXv7hmvTTDZl7fW0uiy8yUKbvWCvzp5O2+xEmeweaErYhHK2
 bbCKQ7Dx0uHiW0y3jYLSz+ScVzKGV3IOyXOjuPeYJAavRIbULCBazgHcxOMlV8lcWIj+Nl7h6Mp
 pESQ4h0B0oEWr6ypxnK1gURSjpt2dp2pbiKmLBQ==
X-Google-Smtp-Source: AGHT+IFICxov0pvMKxGo28Kaw+rf+i8HFY+WVoVL2vnBfNYO9OTf4i+cavlMQW0m9L0SUT+jBjjPvw==
X-Received: by 2002:a05:600c:8b48:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-452013141b3mr50523815e9.0.1749228328771; 
 Fri, 06 Jun 2025 09:45:28 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229df09sm2376630f8f.6.2025.06.06.09.45.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 09/19] accel: Factor accel_cpu_realize() out
Date: Fri,  6 Jun 2025 18:44:08 +0200
Message-ID: <20250606164418.98655-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Factor accel_cpu_realize() out of accel_cpu_common_realize()
for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-internal.h |  2 ++
 include/qemu/accel.h   |  2 ++
 accel/accel-common.c   | 15 ++++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf7..b541377c349 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -14,4 +14,6 @@
 
 void accel_init_ops_interfaces(AccelClass *ac);
 
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
+
 #endif /* ACCEL_SYSTEM_H */
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index c660c5f4b11..3c9aaf9523c 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -91,6 +91,8 @@ void accel_setup_post(MachineState *ms);
  */
 void accel_cpu_instance_init(CPUState *cpu);
 
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
+
 /**
  * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 4894b98d64a..4f3b42e7112 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -88,10 +88,14 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
 {
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    AccelClass *acc;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    acc = ACCEL_GET_CLASS(accel);
 
     /* target specific realization */
     if (cpu->cc->accel_cpu
@@ -108,6 +112,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    return accel_cpu_realize(NULL, cpu, errp);
+}
+
 void accel_cpu_common_unrealize(CPUState *cpu)
 {
     AccelState *accel = current_accel();
-- 
2.49.0


