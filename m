Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532DCC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjR-00010u-HP; Wed, 19 Aug 2026 23:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjQ-0000zZ-7p
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:20 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjO-000432-Qh
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:19 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cbedf6a6fe8so1138953a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197577; x=1787802377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uqnXWGuDLvEfhlq4w5r6kD4ZoGnJTkkdca1i+GCVCbs=;
 b=N+HBZkDCc/IIypWljbciy2syz01oRFG48AOa9tofRVZ/2WTaOlawgFjhhgkzBXVJeS
 htKzZ3sY7T3euUxJGuYTboyWLDmbYmY57yUnFvvM54yWdnMHmC8adIb22uU1fTzVWwfO
 Wb6locE36Yn1H6pXGP1CYQg7G8tVpATu4ouecunhII2mAUt2cqJgh7gFPDWfoNYPFO4D
 SVARalsIGGz+CkHo61mqSGOWQhg/ys40vXgU5pEmk9H013ch26grLZ22O6/VpclOZRFI
 mEpXqWCRbG9WgDd0Yzia74f9oaO3aJtFDyBBilBc04DutrmU8mXRZTHdNrABuK69tJ/T
 HYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197577; x=1787802377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uqnXWGuDLvEfhlq4w5r6kD4ZoGnJTkkdca1i+GCVCbs=;
 b=oDaMddzwwyDp3lTk/QPZjktL4ouLeG7NJSfOzz7Gn0pHHAMcZ9ixX2AXHAADzjzQ2+
 zWQdXs2vwBRmS8AE70aNWmcfV2FmMvydPMYbpMfq5B2xzPvp9QRjDDDeaxL3hZhucoUH
 vGZhCCMWLngSAO5QuHQiOX2uQ+XzbKzoC6LcUTEMPRrh/lq9EvYPuNEdNBSWWwe949pd
 iMjpyovc7YOHnVT7PQu+rPQgPHDQHxX3/1lq+VRnss8Pd9NPLMATjJbRZSwc4s3izNBf
 dhW3FgCioW6NqcryTJKz4BsGem2rGHuUAhhRHRlahkhcNMO1Tklp4EA1+z1hnqg8Lq7+
 +q8Q==
X-Gm-Message-State: AOJu0YzbCiBbUARltNO8KnOGcylsQYGOu93Hmw3TfclpWZrcF1zMAAnR
 KgLihgXegGQzz1f3T/HfDQig4PtdDdgEVQpAAtQKsPg/EUetfhZCqUcuJ5fLCg==
X-Gm-Gg: AR+sD12U+p4PCt2KuZ+WBJYZF40hnlEKzf4B5XAPxXeepiZLRsuuklZad8xmnKZK/IZ
 3EMUyJYuPatI1XgoG0ke/l4d7p7HSocaZ2QYluDHBBGC9Izyw+vu4w6TuLy1sHl/lJ5PrdtnrEC
 9aPIhdm47Jl+sJ3L6NcaApXt4Hsa52MR8UHHrJKF40utoaO2OFCw95NYo9GqfD+lSeBq/P+U+o3
 HnJuU6D8b8ElJeTAbeCz+uNFIaLCdrmNukkNmkrqgM354g/6Y9Mjzu70LkajlF3Ct3BUMVdhAHz
 zIsZET1DoTlSaf5gWETKnHZVA5E6Gt3IBp1mt7XlMJNJakYlj7V9ZIKFa4gdr2XUFW8258bb/Tu
 85uWbIzmH88o43aEkqK/Dr+tThDzoHB69VgcHkLt0rBJhJQYFNHcbMSSe+k9QqFm/3Tq650UckD
 8ps7FgYMY3B4ftySH6KajHT4/6awT8/1nFf8iBzY9iNb/FlF/Db7z4u3wuOvMIy8C4W1AmTfyX9
 QLjBnJJkfb7OD0A
X-Received: by 2002:a05:6a20:3ca5:b0:3bf:6222:2e7e with SMTP id
 adf61e73a8af0-3cd014a9a32mr18446831637.4.1787197577358; 
 Wed, 19 Aug 2026 20:46:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/93] disas/riscv: Use signed type for vector immediates
Date: Thu, 20 Aug 2026 13:43:28 +1000
Message-ID: <20260820034430.1186695-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

operand_vimm() sign-extends the 5-bit vector immediate field in bits
19:15, but returns uint32_t. This sends negative immediates through an
unsigned type before they are assigned to rv_decode.imm.

Return int32_t to match the signed value extracted by the helper.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-3-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index fdf75a12ef..967739bdbb 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4487,7 +4487,7 @@ static uint32_t operand_cimmq(rv_inst inst)
         ((inst << 57) >> 62) << 6;
 }
 
-static uint32_t operand_vimm(rv_inst inst)
+static int32_t operand_vimm(rv_inst inst)
 {
     return (int64_t)(inst << 44) >> 59;
 }
-- 
2.54.0


