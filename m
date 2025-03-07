Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DF8C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMR-0006Az-Tt; Fri, 07 Mar 2025 17:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMP-00066z-08
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:05 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMN-0003Nk-4n
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bbd711eedso18413215e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387201; x=1741992001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koJwEkpLST/7gWyCJsL/yXVo3vaaAtJxi2Nw9A7NzsE=;
 b=DDKsMw29k+bny3kzKqubFlxd+ZrH++YyXmd84Q7l3+ctBdMx/yrmX+s+sQE1BVxmpU
 OkbkXXFx/9B7ln1JVPbAS+qKxLGOG8pYzP1b5Cmc2lQTAVnQUEQQ/eMYdGWzWGmE2P2K
 A4xz+rxxm9+CatJdDnBgFuFgju0TET4drTmc3qIq0I+TAIbGRVp7rH/ZxBC5fB08EcPW
 w7EVfpEweUJwRlDPpePb48HF6pqbmlIlxgRjybNow4bLBGZ8P9BRIx98GkBOhoBanjLI
 qXAUcHeCtX0DCuCWzrFA20bkdJA8pTthVR5Ju0W0SNUaazXtcD3RyksAk3wN/n7rCGK+
 M5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387201; x=1741992001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koJwEkpLST/7gWyCJsL/yXVo3vaaAtJxi2Nw9A7NzsE=;
 b=AqKY6p9iHkRLyXAJmYP9KDs+fZGY8/kI/NmHzdt2zLOOq/4w/32M3VWi1rxLTljri4
 4JkkmqIj1EB03akC18Nwzpp6QF60H/Qnjc0JgG6NmIErABCX1RoDIFr6mYPPLcGoVGS8
 qDJITs7TuUNNFBxZRWDHLJrSWsd6+wXA48Fha8Iuo/ZGsEePmQ55fK54z6w4GLVfotAY
 myFaMeKIhCChbkSUFIZvHVcSnoOk7WCnufMehxjbrnwZgdJNM+i3clNYKTVgOAlbzEgf
 MQJLC/LcOcndpPwlBtcR4u12Ia7zQhK625tFAR4t2lkKorbVX3Cosxbc8mJKa4mqZ2BD
 dhJw==
X-Gm-Message-State: AOJu0YxFTJAUTrSR3XP2juI4s5f1ATBYMoYOJEEUiZX0hlyxOomHX6Xi
 BXRagI8Vc4/COr6xPbXyPR5crnLCoeB2Qfer7/TILMNqkAvQv1rGJQ/T9/0L5j4ekYbgrDuMnzP
 O8JY=
X-Gm-Gg: ASbGncvcovMCpNcXmG8pCfdE+Pkh5ubNJvM6xl1cjHJfE07p/o0xwfz8pfaf5ppS8Mq
 6s1zlfzWmWWlX3pJFS+kKtLMF49mtIqhRg57h1+xQDPYaHlgbOL5LkZdsOvWsFo2k3z+HGKqqxG
 41HzzOCxFaISVJpMbDpLXzkiKVs/0q9kspvz9SUoqgfs0N/U9jsmN/13XmsB1Xb/rDzO74HZnGk
 kv5gXHOePxovweL+tv7bcTT6YGzzNraW7CR0rGuigpWzdxqmnqkL8DhS/1bLq2zCK23SQ0ZlPNO
 u3RNoPZCe3LcYwK6OvJ/qhj501MmoOa6jX/KrftgcoJSAlm3EiXOYbLUicd2l0IZCA6k62C/N25
 pIIIxinYu+2ybbbxz+Es=
X-Google-Smtp-Source: AGHT+IHTfQQ3o6s2tPclL8m5IPfAHPblUiprGcBMAb09s4SRWQab9eVED6oixw2cK26H3Rfih78zuA==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43c549dcc0amr41814965e9.0.1741387200874; 
 Fri, 07 Mar 2025 14:40:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da473sm64096865e9.18.2025.03.07.14.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:40:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] hw/acpi: Introduce acpi_builtin() helper
Date: Fri,  7 Mar 2025 23:39:44 +0100
Message-ID: <20250307223949.54040-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
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

acpi_builtin() can be used to check at runtime whether
the ACPI subsystem is built in a qemu-system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 include/hw/acpi/acpi.h | 3 +++
 hw/acpi/acpi-stub.c    | 5 +++++
 hw/acpi/core.c         | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index e0e51e85b41..d1a4fa2af84 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -150,6 +150,9 @@ struct ACPIREGS {
     Notifier wakeup;
 };
 
+/* Return whether ACPI subsystem is built in */
+bool acpi_builtin(void);
+
 /* PM_TMR */
 void acpi_pm_tmr_update(ACPIREGS *ar, bool enable);
 void acpi_pm_tmr_calc_overflow_time(ACPIREGS *ar);
diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
index e268ce9b1a9..790bf509e5d 100644
--- a/hw/acpi/acpi-stub.c
+++ b/hw/acpi/acpi-stub.c
@@ -25,3 +25,8 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     g_assert_not_reached();
 }
+
+bool acpi_builtin(void)
+{
+    return false;
+}
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 870391ed7c8..58f8964e130 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -78,6 +78,11 @@ static void acpi_register_config(void)
 
 opts_init(acpi_register_config);
 
+bool acpi_builtin(void)
+{
+    return true;
+}
+
 static int acpi_checksum(const uint8_t *data, int len)
 {
     int sum, i;
-- 
2.47.1


