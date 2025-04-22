Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2B4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F1n-0006mU-4m; Tue, 22 Apr 2025 10:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1l-0006m9-2Y
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1i-0005Ai-QX
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so3658559f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333708; x=1745938508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TR9SdSktHd3Yw0bHZBVqSYFLRBMlP1K6kgxMEqmEDdk=;
 b=ko5/5y2a1mgimQ2NdH3QZ4tyGeMUaPSI4TXqkgJHb8NTxmTWuG07w0A1Q2xUqbAh5/
 NRy0nLOAI4uAuH6vDDmkh+06eRsZhXo0jlidWSfSRh2Nf/UOXvyMV89/LOmNsdA0CEcM
 hRYGboSUSTZgvaoVvuVcgVOV1DnDBiT91EVU4lfMFbb6E5mZOOWt7cp1gJU1H7G0tdVT
 7Gvp7lJGXThI5T4Rrv5m8RzvJlYKwffJ0Sj6rjsKTPagH09jlfT7SEupekgha1FXfA38
 kiXR5AeQ88bFRvcIp2m6zKBu+yDuDJ+15q4YOYWnkHI+T1U6+/lnPT6/Yfx1MFQS43UV
 TTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333708; x=1745938508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TR9SdSktHd3Yw0bHZBVqSYFLRBMlP1K6kgxMEqmEDdk=;
 b=AiIoSEe8E1Bf/7JCty2JyFqSOuL8fYjntcYb4WtrAeLmIxYUcs3R82SkzdfRzpg7+H
 CGk/tqvvS67QqU7UJ2bfQjHZ+PKb8mqNX8Bgq+6W2GKUcg8pArh4iIhKeuJYykgesgQ/
 zJE7EObn2AVaoVvFRenc4a1j2aSUSfE6CshV7m3MRhjJ4yb1pUpmLW6Dy16k7803LbHZ
 0QcWsDjBuT93hkvV93+ypUaJRn52Gx2iztIeFfH0F5Km7Hpj+ZdFG/KRcQS4rUkr73Og
 uMb7/7BrY//JhaLE5ceIa1HrqIcuJCwjaJHTJzzCS3RC8Mjfc1navQ/MnajHJXf8V3hF
 h34w==
X-Gm-Message-State: AOJu0YwQrcfXChGFYT8egptNalYjBstNDqu8y+Cq+nFauRWVd5dAcvMK
 CoTPa99H6zb2qd+GbxtkJZv0J7BlqQYEoo4H7QiMnXsdAK/PCHGuv16918roQND7vVzvYbWZlZJ
 G
X-Gm-Gg: ASbGncuC6J0UOj25bZv/Uu+G41nJRmnskykH/FQkeG14qXhVWHA8yKHz+s7NKDiuGp/
 9BinTMNsPgwnImni6ZRRimroS8QEzs243ioNbzx40UrAmgD0JOqY4HCMwrSsRvwb2aci6BCgUts
 8eCSgKorat5MLLqCmc94lZ+13cRaXeITPGB02omwHAqGVdDuv3frdDfK2HKSHc+hbINU0z1xUsb
 eqxLFw0WBl+nLyEh9dDumfQGXcd1lFjODx+Le6pIGdG2Q/1FxJ4CWXwa4kxl7AE+84tK6iaOIJA
 atuAYCStOkTQ5pHUUVhkOgLtR2ioxkXs6gmbKT30SPP0TlTHli+kgTYR7PlfIVasZCvJlibxBhv
 RfmlCXSkknoQvuC9h/UaMkvGpng==
X-Google-Smtp-Source: AGHT+IG7USlGEf/5IBKzqHglLQ/7YMeW8Uh8AGdmnnO86bz3f4cjPvJqBcBbDoHm4SY7FILadcK36Q==
X-Received: by 2002:adf:f94a:0:b0:39f:6e9:8701 with SMTP id
 ffacd0b85a97d-39f06e9871dmr6473119f8f.7.1745333708257; 
 Tue, 22 Apr 2025 07:55:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931c3sm15429955f8f.77.2025.04.22.07.55.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 01/19] qapi: Rename TargetInfo structure as
 QemuTargetInfo
Date: Tue, 22 Apr 2025 16:54:43 +0200
Message-ID: <20250422145502.70770-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/machine.json          | 10 +++++-----
 hw/core/machine-qmp-cmds.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..6889cba2c75 100644
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
index 3130c5cd456..0e9ca1b90e2 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
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


