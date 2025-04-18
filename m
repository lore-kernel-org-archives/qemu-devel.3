Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FC0C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pWj-00027T-5j; Fri, 18 Apr 2025 13:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWg-00027A-8U
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWe-0008Im-LY
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso1378903f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997355; x=1745602155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4P5dfO/LmRaJEoCTtsJ2zP+gLd7pvy+OHCsvweT6c6w=;
 b=LbH+waPpyosFykn9TEYqn9JDKB36OQ9uPIEIEv8Z3oT3volXCB0vyz4lXihYphHNH5
 Q+Kb2zwz9BxPBoIbKauy2jhA/QczHfBexUKPrL9G8uzeVRlhW+huYnsIO1K4p/fK/vwS
 6eZ5sRy3efaIwhiG/mZWQOVWZlaZYHVy7+AjvNTGsIX1h6M9hR/AH93euK6tI4MT969c
 W3P3Wqm1jGbMtwrVi+ADGKXKeKT4kfcaqS4jaKHMSVNGaxt0FTfM27PnXxe375A4oNdF
 dqSDnLV50qC5AgbpMczZJm8GL47wp5r7UHyLydmhWucUC4XmX0YgnIzqoGHt5XY8bPEI
 xQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997355; x=1745602155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4P5dfO/LmRaJEoCTtsJ2zP+gLd7pvy+OHCsvweT6c6w=;
 b=KihsfCmZ5MJqC9lNBmbSXhljyIWuY64IaBpE/8iKT+Ippi7sv7nhT0L1qZIBpTCg4W
 dXUjXZpR+4EMUhOumoDzjk6sjYtNtwxeeOr4ZkNtANYjEOtJ/Aiub0sn0MSZhzSkxQRg
 P1+CJ8pRrQi7zDoLnxXr/NNP7H8Rtys/z7PLDsldOGMab2JK90MQfyZxCQq6FewPDTF7
 WsTik2UxWuves9t4Gpd4Oi9SisrLKF9wMglqz9bApVVeu1gf8kJgr7+F1m2qHXBztNsP
 j2ke9CogQwq/3V//4a7aXCMTMNqXcVzhkD1KE5qzBsC49HKNDLa0ZeIuTuE7/G/DEmst
 agSQ==
X-Gm-Message-State: AOJu0Ywoe7IUYRs7aFvfQC9RvLezuXZMQYViqLKfw7B7Uqy7qHoRGhhN
 do01HgZM4pja1TjPTVOzx2utsUFEIi/IFsu7UiIfI7Qyg30lJqdbqeWY3ZOgO9LTZz9BlogWhii
 F
X-Gm-Gg: ASbGncvehEuMiVEhHvGgGbqrEQ/SKHdwOm7wutD0HAs3lAAzp5I+FGT6MRSeAIl5hrj
 LmIB6aIcGVgvEH5a2X0G0CHMHsoyZnSbsgxjCFFUg+MTC/ITi7DX1cvuQCRxYVMYd5+zMt/VEn1
 XWCQJtl7dLQDQx9SstAcNuWAlxfgPlnUKQ8nqSGSGP1uN3K1PLoWmF3Vu/vmluVZnkq98QAOxCR
 a84wGkNxzxSpVO/O9iHI9R1gFdhX5VVutdoUV5cY6GXlJ06em7fN9GFPXet/1e+G4jcRz5xfz50
 JZ2PpH0+SHQZRzXu/8ZDE5iQq/e/4YrSbxqSeUeyc2otq7jF/qizzWv2Msxz78iLHEdLLPuJCQa
 nv/Pr/fxPevLiSxY=
X-Google-Smtp-Source: AGHT+IGbJNwXKbLWzxNYdqsT2ae0bxE0+bdBqmyzwFvtFXQXhOAV8oish7RsjEhWr4ubFFE2nA74EQ==
X-Received: by 2002:a05:6000:18a8:b0:39c:2678:302b with SMTP id
 ffacd0b85a97d-39efbad7f5fmr2604788f8f.45.1744997354867; 
 Fri, 18 Apr 2025 10:29:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4206fasm3280221f8f.2.2025.04.18.10.29.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
Date: Fri, 18 Apr 2025 19:28:55 +0200
Message-ID: <20250418172908.25147-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
---
 qapi/machine.json          | 12 ++++++------
 hw/core/machine-qmp-cmds.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..3246212f048 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -275,15 +275,15 @@
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
 
 ##
-# @TargetInfo:
+# @BinaryTargetInfo:
 #
-# Information describing the QEMU target.
+# Information describing the QEMU binary target.
 #
-# @arch: the target architecture
+# @arch: the binary target architecture
 #
 # Since: 1.2
 ##
-{ 'struct': 'TargetInfo',
+{ 'struct': 'BinaryTargetInfo',
   'data': { 'arch': 'SysEmuTarget' } }
 
 ##
@@ -291,11 +291,11 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: TargetInfo
+# Returns: BinaryTargetInfo
 #
 # Since: 1.2
 ##
-{ 'command': 'query-target', 'returns': 'TargetInfo' }
+{ 'command': 'query-target', 'returns': 'BinaryTargetInfo' }
 
 ##
 # @UuidInfo:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..408994b67d7 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
     return params;
 }
 
-TargetInfo *qmp_query_target(Error **errp)
+BinaryTargetInfo *qmp_query_target(Error **errp)
 {
-    TargetInfo *info = g_malloc0(sizeof(*info));
+    BinaryTargetInfo *info = g_malloc0(sizeof(*info));
 
     info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
                                  &error_abort);
-- 
2.47.1


