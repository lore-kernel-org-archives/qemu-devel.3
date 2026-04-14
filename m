Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AFFF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRhp-0007yX-8v; Mon, 13 Apr 2026 20:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRho-0007si-DW
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhn-0003Qf-0d
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso41171555e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126757; x=1776731557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VyMpbZZBycD9uof5+Mpu9kfOlAUg4ZoswdMUmEvtEU=;
 b=fF1Qx1SOtv+N82yZCJqHFDysCP7ZWqobntnoGtUEV0HfT2c+y19cZ3S/oplMI8MRnj
 AzqQPN2HTaxh+/kwoB8uj2f91W2DBHqie1WJ/fmcnUmDMX1cxcslaScTQPW8ifuLc/Xw
 1Uqd5vW3JjsFZ1v/AeA8MIyicK4LecWv3s7VwZTlwj1K8IvxrTvwotlk3PUJEIYDHvMT
 pyV4OIvY6stwMsqShQ9L+Dd4DyfVi3S1yCMjK2nzyjLR9V/w7XjQGYekyhuDSmBAqTmq
 uDCClodvBtFp3esNL/rktotN670z4Atj5fCoCm/D5Qnjl236oTlOGuGSglh6WVnbYEbH
 y9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126757; x=1776731557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VyMpbZZBycD9uof5+Mpu9kfOlAUg4ZoswdMUmEvtEU=;
 b=cYh1+CrDhq/Axtf3RqvotpmjgxqDNeiuaLI+hHyv5ax5Yk14yAkSYZVVCLLzMZYkrL
 racsa0N2MckVtN5NfMCWVY8od+2LsqxEiqpPj+klaDuQ7hiFPMGTAYoxBtgRG2BnJSj/
 nHft3wf6SucEzLqupi5TTlcK0LNDbiGITAGLrJrZis3wWuQhbPZwrxkelEJ3PnnUdd+f
 i0u4TYMM8yHPzVhKAMc9Vr0TckrsNwj673xwe4Dp+jHNZ26cfUI3MZbhZOi+ji/FxjT7
 mF2DgwUquN6MkCOAG87AJKzToLX98PyW43hxUoAvGJ+sFKgY0umkMwpt/8ul4ObAJJd9
 0RIQ==
X-Gm-Message-State: AOJu0Ywmxi8Xsfcp9LQLVhreOID6nnr/v5BrfDKElSh12+734ja3oMm/
 lk/K55qYL3x/tb1ZFtKXszeIJK02Jh7f0YcUGsA37RV9rH0BeujDwrk8jYzS1iiIgnXCKbwKvga
 Im4Fn8Uk=
X-Gm-Gg: AeBDieudrHfZ2e/2VvAigk3bZwIItJLWUYrsrkXy3mrDqzpOuUSXWux6DIO75aLNeZj
 LWYASd1aXgDkWxU/tTTW1upcxPinGIdpkYksMTVmzTSihHuAfW0GrH5qAScok04MK2cKNudBixB
 Yg5whSpdirrp/w9Ajb0rrj9UZDZ2TpjLqkMJJmwjmCThZFfOybrD9ZWvrZciNJS9Z66gjZz+p8+
 wCs+TwP2dhPZmf8hGLJ5i8i2mQ5u6LMD4B7xzbXjN2ikzoLtu5s9gR1D7a9Hp8/DxnjkHv7ABZq
 uzDq1Arod4H45XPcaT6YUFPA+rJ2QbA1DW1WDIV9rXRcQzUWRgwsl0ua7MdcUN/s+o5/0/+Nkmk
 EMlte0JYXt6c8SsA85ncsSStCgWVIsX5z7srZelz+AzeX4KsK62KfqRkXi1Gr3lrenr9C3uYlre
 7vS6Bmc8wRBc8JMWytGEIi+JcOWJ/HkUBk6xPbZwisjBsi+tDmaCzjdgnoIjW1nlFUUIvkmNph
X-Received: by 2002:a05:600c:a416:b0:485:41c4:e2e4 with SMTP id
 5b1f17b1804b1-488d6860571mr145539645e9.23.1776126757174; 
 Mon, 13 Apr 2026 17:32:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1513csm6532565e9.2.2026.04.13.17.32.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 21/27] monitor: Forward-declare the MonitorDef type
Date: Tue, 14 Apr 2026 02:29:53 +0200
Message-ID: <20260414003001.97571-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Rather than having core header forced to include "monitor/hmp.h"
to get the MonitorDef type declaration, forward-declare it in
"qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/hmp.h   | 6 +++---
 include/qemu/typedefs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 8abe3168924..22784bd4c79 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,11 +24,11 @@
         g_assert_not_reached(); \
     }
 
-typedef struct MonitorDef {
+struct MonitorDef {
     const char *name;
     int offset;
-    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-} MonitorDef;
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
+};
 
 const MonitorDef *target_monitor_defs(void);
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acea..07f2ae7c9f1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,6 +72,7 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
+typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
-- 
2.53.0


