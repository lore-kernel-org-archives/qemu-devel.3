Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C4CC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyf5-0006UD-57; Tue, 11 Jun 2024 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyf3-0006Ty-Ir
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:29 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyf1-0000ZH-U8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:29 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52c4b92c09bso1097371e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718101406; x=1718706206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tgZq3sbZcXD41HkUXjwl9sONKRxoM6G0WQFFkBzjWc=;
 b=UB/y2fsDJLtvXgHEAn5o+BUgRDr+osL/vPLHM/G1RIW2fPnMP+Wm6hhbuDzCb8dypr
 eBYSesrCHXmSccVkU+Q0BTwucTiczJOFN+IhoAv9Jtzq6BUpzGjEtfrwEcC4b6G27JZJ
 lQs+GaF/QiazCdNXPHYDq+zB+iioCaPZYHUql5Gp6kzEjoMQHjc1OA+mLNmLQlG4izrr
 xOVwN2h84N0g+/qmdA6ZFk5LkC85B4YPLnU08SR/cMDCb8V4VBljJLHz0ZAC2/SzeTp1
 cWMkmFbBwZNiBDnilaNfJi69pmdaMFwpnnBvu4MG7SENaGPLJJB8YlBqv6y6+x6cwVYb
 9+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718101406; x=1718706206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tgZq3sbZcXD41HkUXjwl9sONKRxoM6G0WQFFkBzjWc=;
 b=KspxlSPDr+2jrOxeDzSo3mOK0Of2rYJSyUAlsrzAXwgKbo+1RHn35jewl4zZ2iiDPA
 bliCBuC1caPHqgg+ZeE5KWn+kEvUnVwYYz0MsTlIOPLpArg/7+md8btkheGrt1G1n5ML
 WzoWBiFMhDkK1cmRJzLShy/TqekKjPOcjH7IpSoyQV5AtXtqP3MSkYzOH/Z54ey1VIcC
 uBA7WpfCaPb4dqVeGpOpVV3eH8hSqxn/I3pLn4EfQmF0ZGsm4np4fntdU0sTWRa4eO8u
 kIi/YpmS2NnsffWeGkws4WsiRn20MZ6DEHe3a2v4V6BA3Mak2fzGArGmuNvSzloQeyyX
 KcFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrtr4ILEG3LgXi3vNkRmsRl9Wm4cUpN7U8+zJy8CpHOF4OwXRdgm33UYEFB84b/k4YR2HTudlKJppN2b8uMjU0nfSJI/k=
X-Gm-Message-State: AOJu0YwIj10LH6pgpTzZHx6OQ3ZkcRbgMY8XNlG74k5YFnwFs5WfryRo
 P297IKwArQzccfctffyvK0WbQ2b9NtZJCmIzdaYyVTPpPs08vrZoEJD5rNMaEdc=
X-Google-Smtp-Source: AGHT+IFwjf90XM61plDbKFs5fle018sLqXgz9qnD/qUjLy0qk9F7/lMjfQ0S+gM2h1ScBVOSOyJGKw==
X-Received: by 2002:ac2:551b:0:b0:52c:9725:b334 with SMTP id
 2adb3069b0e04-52c9725b492mr465698e87.54.1718101405948; 
 Tue, 11 Jun 2024 03:23:25 -0700 (PDT)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0b876d80sm10294643f8f.109.2024.06.11.03.23.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jun 2024 03:23:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] monitor: Remove monitor_register_hmp()
Date: Tue, 11 Jun 2024 12:23:05 +0200
Message-ID: <20240611102305.60735-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611102305.60735-1-philmd@linaro.org>
References: <20240611102305.60735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Previous commit removed the last use of monitor_register_hmp(),
remove it so new commands are implemented using
monitor_register_hmp_info_hrt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/monitor.h |  2 --
 monitor/hmp-target.c      | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 965f5d5450..2199a74913 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -55,8 +55,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int64_t monitor_fdset_dup_fd_find(int dup_fd);
 
-void monitor_register_hmp(const char *name, bool info,
-                          void (*cmd)(Monitor *mon, const QDict *qdict));
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 1eb72ac1bf..86f48c613b 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -145,22 +145,6 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
           compare_mon_cmd);
 }
 
-void monitor_register_hmp(const char *name, bool info,
-                          void (*cmd)(Monitor *mon, const QDict *qdict))
-{
-    HMPCommand *table = info ? hmp_info_cmds : hmp_cmds;
-
-    while (table->name != NULL) {
-        if (strcmp(table->name, name) == 0) {
-            g_assert(table->cmd == NULL && table->cmd_info_hrt == NULL);
-            table->cmd = cmd;
-            return;
-        }
-        table++;
-    }
-    g_assert_not_reached();
-}
-
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp))
 {
-- 
2.41.0


