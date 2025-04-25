Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57302C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3Y-0002qE-LG; Fri, 25 Apr 2025 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2t-0001dP-E4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2r-0004D2-K2
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39efc1365e4so1201389f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595171; x=1746199971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LxRNMlVfoq/xLHs+1YnVYUs29an33zqnfwHUeMoXn4=;
 b=pFH9c2Fw1dekRwF25pDju0ABzqSupGzHVVlF/IzgijMQiD+4Crv7EBV/enVME8S4tn
 XRNL/4e3jVdutZg6hcxseATEAIB9MepVFWYnbOByvMYPifqoXKocWAFWv7xCPcZb8mxK
 g/XqbDC2hdTomjZOK0qeFcX3ve00e9JL6FMitW/TXc0pZUFlZB2vlzcsk/Z9luiVFjky
 558+E2urqDxpqOT9SQwBp3tTczDG0QEBN1FH4UKIf56B+MwOgFY7MPZzQklaUHR98yZd
 KhDyFy9gGqu0l89oxfzNTEHny3Kvb2f/odc1coi90esElY/O5q/Zcu2QdnJo2NzfyqPs
 ofqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595171; x=1746199971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LxRNMlVfoq/xLHs+1YnVYUs29an33zqnfwHUeMoXn4=;
 b=nFelEJZAlTt4aemasn46IaXSSbXBnWxC+gHUm4PusZdTAJoL+OKIO+oI4BZAI1+j11
 FDHl6kVBtO7x3MMFGYDGYrZGfOnM4uqC5u/oa+YhxgHKRgZCItMztAEYltdeeIhaxLV3
 MvSfIQIMvNUBIvP5dmQftrCS7mnQULEclpGUYuQwQmxfeuv5YDf5ZjzdoJI24aOR/uAR
 Q0BeGTCtR3+UGug4f2sZRNG7YRgWiqt79wvCyZ+m71OstF8YxtDvW7O+mfLxEofb5aTb
 HSVFj1plDM4GdDN63hjw6QAmzfPuD66jvLU9udIwCLgYqV2EjynUG+dJ1OUMXepfjCXY
 lajg==
X-Gm-Message-State: AOJu0Yx4U78Qc4QOujG0rBx+k7f9t7G4+/zjvX3BTD1xpHkcpwH+wL5m
 RTpJmoAujh/cXQUFMVoW6doF33PTnw04kWTUxfxJx9RmO5d9OT0YUiAhVoH3ElMztsvEao/IQ/k
 0
X-Gm-Gg: ASbGncuvjz6lv56081YmY814pe0AnhSLi4Gcx0vVTD1WUKRLqk5u5Vx3IS5YrVQvBlO
 vsUkb8toJ8NYkgc8v2dDoNwCosydZv9g2GlySALPXjCPwnIxo9qvy7DoSHKqNFo8IYqVeCgoZMG
 4zCAAoKGCPr5598qfpzRwLsW+9BGHCIVDBFQub3FKPGPhRZyq5UYOOAOMxHmR8fgQr3r0iIjBe4
 AvVN22ZcVXpx6iELDnvQggcGGj8btX7HAJLIzDLp/8TdpvOrOAUJf+2W3K5+30t93gTmVoYUXb6
 9QuWkK7jWcCKh3gKge5wungjXLQ0amAuRCtRZlbRa6H3/cJph44wmhBlXpOKL4aE8nQiSAjA7ht
 mBp/kmHu0wS8xTKAolLoFDSmv9w==
X-Google-Smtp-Source: AGHT+IH3O/+X0r+KoZgu2SHZgErRj2XLtWbjNCNFjeWB/oebMu7qmxcLe7kASZGDTq194d91lBXlhA==
X-Received: by 2002:a5d:64ee:0:b0:3a0:6b91:fefc with SMTP id
 ffacd0b85a97d-3a074f7e3dbmr2172971f8f.50.1745595171160; 
 Fri, 25 Apr 2025 08:32:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e00e3sm61672295e9.34.2025.04.25.08.32.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 50/58] qapi: Rename TargetInfo structure as QemuTargetInfo
Date: Fri, 25 Apr 2025 17:28:34 +0200
Message-ID: <20250425152843.69638-51-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The QAPI-generated 'TargetInfo' structure name is only used
in a single file. We want to heavily use another structure
similarly named. Rename the QAPI one, since structure names
are not part of the public API.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20250422145502.70770-2-philmd@linaro.org>
---
 qapi/machine.json          | 10 +++++-----
 hw/core/machine-qmp-cmds.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a9ff8076317..c8feb9fe17b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -275,15 +275,15 @@
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
 
 ##
-# @TargetInfo:
+# @QemuTargetInfo:
 #
-# Information describing the QEMU target.
+# Information on the target configuration built into the QEMU binary.
 #
 # @arch: the target architecture
 #
 # Since: 1.2
 ##
-{ 'struct': 'TargetInfo',
+{ 'struct': 'QemuTargetInfo',
   'data': { 'arch': 'SysEmuTarget' } }
 
 ##
@@ -291,11 +291,11 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: TargetInfo
+# Returns: QemuTargetInfo
 #
 # Since: 1.2
 ##
-{ 'command': 'query-target', 'returns': 'TargetInfo' }
+{ 'command': 'query-target', 'returns': 'QemuTargetInfo' }
 
 ##
 # @UuidInfo:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9447e345b3c..a5e635152dc 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -134,9 +134,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
     return params;
 }
 
-TargetInfo *qmp_query_target(Error **errp)
+QemuTargetInfo *qmp_query_target(Error **errp)
 {
-    TargetInfo *info = g_malloc0(sizeof(*info));
+    QemuTargetInfo *info = g_malloc0(sizeof(*info));
 
     info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
                                  &error_abort);
-- 
2.47.1


