Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9AECD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrI-0000yc-TK; Wed, 06 May 2026 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoN-0006G4-ON
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoL-0000lH-QZ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48374014a77so76932775e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076071; x=1778680871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tiYO+phtoKsyzGu/jE8yoJf/zh/ppWFtTlS0H3YUZnQ=;
 b=WFVxhlj3qcPAFe47c+CRG4Exe53p2mUBnKR5YsYB2HC1ov9EYJjENJOuOO8WRbfwdy
 MjvoLyt9iR/N1ciA+/F1m8Zv5sC0EoXI2KXZa63heN21ElQTUD8FSm8PqGecjpF1AWBS
 4g2dfoHswHVYBpw0D8SyHfRwMqMpBdwWa5lEwdGFB2v9k7QyYp4Q+bOTVWnh3ZLK1Wew
 EAxMuz8ZJduTgHJ+5EF2K7KETrBtU/DEvwWnBA10gvYESRRey/WO9da0AHrPqO1syANC
 7vuzGZ3KoBDXK1tQiA1iM8Vev4F82F6qQyWIXg21VYE8hrj9T44FSJ0tbdPpb0m7p9qM
 3dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076071; x=1778680871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tiYO+phtoKsyzGu/jE8yoJf/zh/ppWFtTlS0H3YUZnQ=;
 b=gMXIdFjXivdUMxy/7+JcYUUx3uplfra4bIfNxI1he9j+g+plO5IfFyLXU+AzpIYOAT
 O3cJvU9ywhsNYER4n0sYZwlIxm/y6t1Eoe3FTWzibCGpoWZDmeaq2O2Sk/DLht9N5FKM
 WU1wUnGvLHkvJD6J4VbdXZUGSIz9LEot30JFOo5uo43WFXK+2puoeNcC7q5RMo2uz5Bi
 GnkiYWgHzkXjC64sh/DLPoT2XNxMjT3vWlagrAvdXTMqsojmV2pw1r3SyE4rmf6n/Ayy
 Zvz6xZQRnEw0NFqMnfDbHNrImdwGKD1aqVt6m6op242Mgfbr+MVIW2c8cgcE/ZHlnE/e
 skrA==
X-Gm-Message-State: AOJu0YwPhLhyyPedLtroR5qOoffSwVb5/KXloSkJWgfO+1uVvkuFnKOx
 n8osKCxY3q4PA8USQK2G4xTc3onlbIEHukXeqqD/1pD2hnU3qiMnRLDFfKAIWU4STC3uVYXYw9P
 DRfRUIEI=
X-Gm-Gg: AeBDiesAbMgFij9cx0z7UsvKQ7chEHmaVaNUcJ/S7/GBD8LGDpnYaKTe0q5xeI1gvCw
 5lkgql1howEG1UAnucMDmdsPsQd1kAricQ0osoztmGtgemK75sql8XKcXAZa4NFtNNb33cHYRCl
 QOa/iJaxxyloG1w8dhyjKxCrZjHcxIfttFMbYHVelJzUJlboSNVeo1H6loB/vdEXVb80aKDZBz8
 czwGQaT3T7n6GwX6kqhqmis4n5eQ3TBknGec7EFQDKcsWn1bgtEuP0CuP8jHXdJifJWiU8xprL4
 g52k8kFFhcH5h8KqWPiILP7J93mHE9gF82HAzvAgHuRxFugz64o3xCeYjEHcLZtC+VWsfebX822
 Pxa0Tng6W5ziqNFVEPugmow9hm3lDLYNPPgD02/Yihe51Khv7JjbCTYOXJG9WuXzxnZh+nIXgNf
 FJMSvPBizrrg2OgUVwe5n+W5ZssP/IH9xeMD3YrWa+bcvd9SYXKrX6JGyVG0OC/z7swnwMmjjqO
 1YWzDDA5dQ+Ar8RfPWP7g==
X-Received: by 2002:a05:600c:1d18:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48e51f45c84mr62938635e9.27.1778076070890; 
 Wed, 06 May 2026 07:01:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530d8691sm41423315e9.2.2026.05.06.07.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 045/110] monitor: Make Xen emulation commands generic ones
Date: Wed,  6 May 2026 15:54:17 +0200
Message-ID: <20260506135524.20617-46-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

In order to build hmp-commands.hx once we need to stop using
device target-specific check. Use the generic pattern to make
the command available on all targets, providing a stub with
kind error message when the feature is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-10-philmd@linaro.org>
---
 hw/i386/kvm/xen-stubs.c | 12 ++++++++++++
 hmp-commands.hx         |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index ce73119ee7a..bf6ac28bef4 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 #include "xen_evtchn.h"
 #include "xen_primary_console.h"
@@ -37,3 +39,13 @@ void xen_primary_console_create(void)
 void xen_primary_console_set_be_port(uint16_t port)
 {
 }
+
+void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
+
+void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index b806ec5635c..dd6243bf2da 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1843,7 +1843,6 @@ SRST
 ERST
 #endif
 
-#if defined(CONFIG_XEN_EMU)
     {
         .name       = "xen-event-inject",
         .args_type  = "port:i",
@@ -1870,7 +1869,6 @@ SRST
 ``xen-event-list``
   List event channels in the guest
 ERST
-#endif
 
 HXCOMM *** MUST BE LAST ENTRY **
     {
-- 
2.53.0


