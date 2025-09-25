Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFD8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ZyS-0004Fi-Ny; Wed, 24 Sep 2025 20:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZyQ-0004FJ-Mc
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:36:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZyO-0007jH-8p
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:36:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e1e318f58so2802465e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758760590; x=1759365390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DM4BbjrB777ABTlKIhObcTIwoLevNW0Kv+c6Y7OPRjs=;
 b=ybn2OLuMKV0jMITWuZebcxPwXD18ePak38OssWoO4aDstNwAqJN5EGI0cBBUTYrgDF
 bsHdsbvZ+RvfwlNMgeQYtxT0CC+s8IjE0LuROkvujT5LGFXa7kxMjKFFPe4QQ8sMnGJi
 NiTdwyBa/7orC8UajEtvQau6sf6h0EFgrimyYHWjIrtepmKFBIfGL24PLzTE5dRSiyUk
 CIBOoEiQGRoYMo80gj/J8JsQL528ehqgsLKxFE8wLFsQQmfX9P+jyL/h/LQTPXnC40cu
 mlahGCgIKC9q3MVNot4wMz3u7ZIDtaV2yXyGVJfQ68Z3Tt4U6Td0gCXoI0/J1vbpM/zs
 DccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758760590; x=1759365390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DM4BbjrB777ABTlKIhObcTIwoLevNW0Kv+c6Y7OPRjs=;
 b=BydrUi5N6VJamSjae8oU6ZMobwnwfX4W/oyOIu1YwQqcohFRhFIpQmpCINwURDcNLU
 EsgZJp69rCZxgjnjbEtknNFqqm49OQJy4+6zIfTsPD0hKQa+6xuc3nbhl+xOgwZ+LB1j
 aaEaFJvhGrwk0wNtko9WbZYG+CTeL4zMQ89iMDmMtcD0KyS27mtIyeVqHJ/GQYUbp5cP
 1QiW4fFQOSBDhl4aClaHmrl3NV8ABpwAZJ7ak/tj9dX+Z3jezUpm5qzkCBBWi19c6YxY
 6cZTHoudsii8k+uLKEy6DL1fc1ASMGTO9hBOUMLVE844QZA2uYR306SBsw6oR6lxiB5M
 NrPQ==
X-Gm-Message-State: AOJu0YxIl68RajVEd7wFFu5Ngmq+2qEG0mIK1N4BOUtgrdopqzmbvc27
 5HxJU37l1FzEUOVJqGKqu+blaTW7ig8EDhi/koC7JR18o/UHuCQY+0L+2S+B81P6PVIc26VB5qQ
 gLCbhf65bNA==
X-Gm-Gg: ASbGncsO1tYDySvt02NftKNc8RPpPLKXe2AkUZkY4pSM5pUk90FYkV2K6Sq0gBQ3sSC
 NPE3QXiXJuzdpB/9fRxgFANY7hUiUdmHFmn/DwLyQTAXKsTDxXF4EtdRVzQqhF9HWDMpjaD5TzE
 Rn10TfJiRaH34w6PYp8PZ7UEapZeCNCOulfA77ZvhMjwUgmYc5y+5MjU/isnYKefHrf6YXsHn/l
 A3ji6mpPbK+xw24DQf0sn2g4QZyaiCl3gutQ7CGTj93hNgoOsDm5bVGRYFI+5T/t6IzMl5LFUuz
 SotJwYdK7/89DanZ1Z/fQLkWxmUhX6lw8UfNfk6FU6q+94hzLqIZPq3y8Hz7bjQb28HrTwUzZcs
 diTgLob//Qli/buTFfU8TNeezlgSArgWpMFbqyzw4xZk3nKWpdoWq8ReNB8XU1kVVT0oXTcG5
X-Google-Smtp-Source: AGHT+IGHSsBqE52U6ABlnQiKNyyNjTJM3uj1n6w/kbkILyouLaO/LR8G8VAG6MLIIPG50cLscA5sJw==
X-Received: by 2002:a05:600c:3b91:b0:46d:2edc:5adb with SMTP id
 5b1f17b1804b1-46e329aed3dmr19892235e9.8.1758760590485; 
 Wed, 24 Sep 2025 17:36:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a7c8531sm52639545e9.0.2025.09.24.17.36.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 17:36:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/alpha: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
Date: Thu, 25 Sep 2025 02:36:28 +0200
Message-ID: <20250925003628.58392-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

All these CPUAlphaState fields are of uint64_t type (except
the @fir[] array which uses float64, expanded to the same
type definition). Use the appropriate VMSTATE_UINT64() macro.

There is no functional change (the migration stream is not
modified), because the Alpha target is only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/alpha*
  configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
  configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/machine.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 5f302b166da..6828b123ca1 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -25,8 +25,8 @@ static const VMStateInfo vmstate_fpcr = {
 };
 
 static const VMStateField vmstate_env_fields[] = {
-    VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
-    VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
+    VMSTATE_UINT64_ARRAY(ir, CPUAlphaState, 31),
+    VMSTATE_UINT64_ARRAY(fir, CPUAlphaState, 31),
     /* Save the architecture value of the fpcr, not the internally
        expanded version.  Since this architecture value does not
        exist in memory to be stored, this requires a but of hoop
@@ -41,27 +41,27 @@ static const VMStateField vmstate_env_fields[] = {
         .flags = VMS_SINGLE,
         .offset = 0
     },
-    VMSTATE_UINTTL(pc, CPUAlphaState),
-    VMSTATE_UINTTL(unique, CPUAlphaState),
-    VMSTATE_UINTTL(lock_addr, CPUAlphaState),
-    VMSTATE_UINTTL(lock_value, CPUAlphaState),
+    VMSTATE_UINT64(pc, CPUAlphaState),
+    VMSTATE_UINT64(unique, CPUAlphaState),
+    VMSTATE_UINT64(lock_addr, CPUAlphaState),
+    VMSTATE_UINT64(lock_value, CPUAlphaState),
 
     VMSTATE_UINT32(flags, CPUAlphaState),
     VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
 
-    VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
-    VMSTATE_UINTTL(trap_arg1, CPUAlphaState),
-    VMSTATE_UINTTL(trap_arg2, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg0, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg1, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg2, CPUAlphaState),
 
-    VMSTATE_UINTTL(exc_addr, CPUAlphaState),
-    VMSTATE_UINTTL(palbr, CPUAlphaState),
-    VMSTATE_UINTTL(ptbr, CPUAlphaState),
-    VMSTATE_UINTTL(vptptr, CPUAlphaState),
-    VMSTATE_UINTTL(sysval, CPUAlphaState),
-    VMSTATE_UINTTL(usp, CPUAlphaState),
+    VMSTATE_UINT64(exc_addr, CPUAlphaState),
+    VMSTATE_UINT64(palbr, CPUAlphaState),
+    VMSTATE_UINT64(ptbr, CPUAlphaState),
+    VMSTATE_UINT64(vptptr, CPUAlphaState),
+    VMSTATE_UINT64(sysval, CPUAlphaState),
+    VMSTATE_UINT64(usp, CPUAlphaState),
 
-    VMSTATE_UINTTL_ARRAY(shadow, CPUAlphaState, 8),
-    VMSTATE_UINTTL_ARRAY(scratch, CPUAlphaState, 24),
+    VMSTATE_UINT64_ARRAY(shadow, CPUAlphaState, 8),
+    VMSTATE_UINT64_ARRAY(scratch, CPUAlphaState, 24),
 
     VMSTATE_END_OF_LIST()
 };
-- 
2.51.0


