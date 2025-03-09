Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D8DC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKp1-00059C-BI; Sun, 09 Mar 2025 13:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKoz-00058l-O7
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKoy-0004ni-7q
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so29843715e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542734; x=1742147534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M4O7vzSf9Kqz7dSwzKnWekJP1fOmdxWNIgHecTPSDb8=;
 b=TmqscUnW2XiPmBXpZXE+ic1WAq9AnVt/cSlC0fp1WOdYCAZuH175o2xbwJR48FlgEi
 GjSIlpsaSniq5R5cDw3BLfRmtiMtLIHUytoLotuXkPT0z0OGSC8Jwb/WNJAtuTPCCfSI
 gIt0s0x3dTfLg9fhwQOujd6ju7qms9Dk4NytNufJBZ2ALM1nzO4DNlZJZWuGv0BF2nbQ
 b90p04Ga9QYIEwvQcnLnJ7m9PQf+tcfeIOKLidb7czax0kKTiq7p61RDDbpnhgc9Ypkf
 OQ9gYzg8KVRFxqsP5LSLnqoNuqMgPS+w/E1o+5hWCMTy+QHJllg5pslv+f7pbGdfR8oJ
 MkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542734; x=1742147534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4O7vzSf9Kqz7dSwzKnWekJP1fOmdxWNIgHecTPSDb8=;
 b=TGrl6pLfbLqKc8YfzVBQFiNqmYSroME1RI2mf9fwe7GIp3dzqZ4vKs8q/GgadFa8S4
 09QRo0EWVWfihrDDvw3qGa39IGrTgI94yqtBZ4SOyCkJAGv4Nw5R5ps2VQV1mEFrxS2C
 wgUvn+Gz+tU9JZwAZM4Ermpnrb/+Xp0gENdGsMJ7BHCsTzNBtfq1Er91l87uL6oXbr0g
 bf/DAdgR/3Q5vqHWxEY9FK9K/GXtsyhzBoFSFI7FfM8HBndyO4ENvjz5SbQTsczG8/z6
 Fsm6O5kloz8NoL6ChHemkhhuT/fMD3TyAwZPoxed5uotbXvp/sATWFT6kZJ7tUCJMgeo
 TPFw==
X-Gm-Message-State: AOJu0Ywv/gmMgS+BZ6onf9kE7P2JlADBiUX/PUDwzGxPunkEY26PVIR3
 46R0zH8vbwLSFtVL+Ffg0c5XTeK2FvT5JJO5eL2FlEoRO0I7Iy6l1GiUy0bH1tEc1FKCopyHjze
 rhDc=
X-Gm-Gg: ASbGncup1I15Bozfk7QpGHc1m9OPrikQqLGhC0E2f7Ihfkv8EQDtfDRxteiIUQC5jkq
 knk3+Vw1MLUtmFfPR59PQBWqQMjPBHD0Kb+6STve2x/hhA/e6feolypP28gRnFTAH5uTe7wq9bc
 p8wst5sh5nxvHptx+FVxfQwu6UOLsd0IPBHSrvCeutmkhCI7EUOGSg5I1jbBCrVr4CMG5nEbJTS
 Z9hdnOOGxBVT15hcQtKRGL2iR/xEaV2GRcypa44NFTPWbPeskzUSeKb7XzUHqIpupaoWBSLdvC0
 WXVWNDfW8qH4BoD4n7ORN2ijhTPdIgYeuXliREdQRocUkmiZ8ZPB/mYh7E+EIyR4NyUQP3j52or
 ohSC2rU1PmftjBccBwmc=
X-Google-Smtp-Source: AGHT+IFTlCdl+LWaEswVfeZ3CDBAxjhaVLpaV/I3z41fiJQBbcwKpLGfvC0fcX3KjAtZUw5+W3xGdw==
X-Received: by 2002:a05:6000:1862:b0:390:fe4b:70b9 with SMTP id
 ffacd0b85a97d-39132d6c5demr8880879f8f.21.1741542734240; 
 Sun, 09 Mar 2025 10:52:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9b6sm120766395e9.29.2025.03.09.10.52.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/38] linux-user: Only include 'exec/tb-flush.h' header when
 necessary
Date: Sun,  9 Mar 2025 18:51:30 +0100
Message-ID: <20250309175207.43828-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
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

Very few source files require to access "exec/tb-flush.h"
declarations, and except a pair, they all include it
explicitly. No need to overload the generic "user-internals.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250102182521.65428-2-philmd@linaro.org>
---
 linux-user/user-internals.h | 1 -
 linux-user/mmap.c           | 1 +
 linux-user/syscall.c        | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index b9b05c1d11f..4aa253b5663 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -20,7 +20,6 @@
 
 #include "user/thunk.h"
 #include "exec/exec-all.h"
-#include "exec/tb-flush.h"
 #include "qemu/log.h"
 
 extern char *exec_path;
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6828b17a63f..d1f36e6f16b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
+#include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "qemu.h"
 #include "user/page-protection.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 02ea4221c96..b32de763f7e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -26,6 +26,7 @@
 #include "tcg/startup.h"
 #include "target_mman.h"
 #include "exec/page-protection.h"
+#include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include <elf.h>
 #include <endian.h>
-- 
2.47.1


