Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC097E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfn-0006l5-L9; Thu, 02 Jan 2025 13:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeS-0007FR-0k
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:33 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeQ-0006Cd-3p
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so183469255ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841429; x=1736446229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=34PDZEbnRMWgOGhG5jWyE54EWIxgW8QYKTB2trFJYyA=;
 b=WjEsfEIBI1FTRqqFALTYtfhMhMZ0qhRbHeAFtCWsrTXLEjRK3M5Z3VUOnNiaY9uJj5
 sb4gr732OQpT6YSM0RcLpIK6a0d+i4mU4t16yYj6T/hR+Usrul1tAiodeRdjpzJa8jQ2
 h+qICbKQnehNPT8PNCA66/MjnCKPhaOhLX3DIEK/nSDsS2ZOuM386C3lvtTriTCMDE9H
 ucIDryTuiz8Ygd4dtGsYQIfT9tMBYZGMa2vsekrZ2SjnKkGvujoKNxfROCVAJMuX5rNh
 ykPBJUKabB4SDAyhYWgvIMu5vZ0OFCCDsTCtXHmbFOuDSiKzE/+YhTUvAF/wRXb5JERS
 8wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841429; x=1736446229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34PDZEbnRMWgOGhG5jWyE54EWIxgW8QYKTB2trFJYyA=;
 b=fEGPSEkyD8quddgmgqoAHE9QV0k9795quA0JzKBU3XdVr6m+xh9Tix7cSa6FKKWHIn
 PwaBORF9M1DcbpiNSajuwqxUNP4zhTHZyJHTfCmFoHBub1ZdSIzQjTckrgCrFWJfpVz7
 BZDbtTG3/asw3xpmHWlJAa1aNim+77WDWPJo5y/Lu9lU/JgKpJ+eksMceujcovEn31Ug
 TQzcAjdvGq3SjplkwShA8YpEQY1Ml9SiomdkhIhiIvNKOsiOm9ICz95II9y3Xkp0mDeC
 YwzmpK7VzlnTTEQK4D4jsNTfwS48E3IFIM1r/BwESRu7KORGGSBpzIDTWg9P2uybzwwp
 i8YA==
X-Gm-Message-State: AOJu0Yzn7BgCSmT1xuQVeTqY21rsBWdNhXDrCFoQmxezeQvne8rpdlr5
 gkMaCrJoUnNvjBHfT8v2JyOoCW8ReuR7TIXacB1+L8sdHb/SBLjkb3mNk5xaeUadDby15CzB7yk
 R
X-Gm-Gg: ASbGncvPwuN+4ZHOlnz9L2QSHB62CZwT4XvRo5PnkkCHTLV7R6F2LT3LFFnJibuaqQr
 GtuO9EX2Fi1i6pK9UI2mlDudSg40smkcz9Eie3EiV/zkulbc4rhPptJaQEoLzSzC2sXIeJPTv6S
 LbQFdBe+hUffYuoAf2VU1uLDfDTPLRnIzXqzx3ip36ZCZ6RXayAYX+kOBeuq4+HrVj3un0TWNlj
 +SJHPGmtj59ftN/n95sKDVOxk+uK2lsdxE0jBAfLBLxHrxkdlJHAHm9Cnz0aA==
X-Google-Smtp-Source: AGHT+IHN5bBrlyc4sauB2vhpJOCGooZLbyVdCjwC1O5oY4Qie0iLD20MLdqsYcAHsicYqWPavloEyQ==
X-Received: by 2002:a05:6a00:8d8d:b0:726:8366:40ca with SMTP id
 d2e1a72fcca58-72abdd3c228mr51292742b3a.1.1735841428867; 
 Thu, 02 Jan 2025 10:10:28 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/73] tcg/tci: Remove assertions for deposit and extract
Date: Thu,  2 Jan 2025 10:06:23 -0800
Message-ID: <20250102180654.1420056-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

We already have these assertions during opcode creation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.c.inc | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index b7c58671f0..dbffbeff5f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -774,28 +774,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     CASE_32_64(deposit)  /* Optional (TCG_TARGET_HAS_deposit_*). */
-        {
-            TCGArg pos = args[3], len = args[4];
-            TCGArg max = opc == INDEX_op_deposit_i32 ? 32 : 64;
-
-            tcg_debug_assert(pos < max);
-            tcg_debug_assert(pos + len <= max);
-
-            tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], pos, len);
-        }
+        tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
     CASE_32_64(extract)  /* Optional (TCG_TARGET_HAS_extract_*). */
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
-        {
-            TCGArg pos = args[2], len = args[3];
-            TCGArg max = tcg_op_defs[opc].flags & TCG_OPF_64BIT ? 64 : 32;
-
-            tcg_debug_assert(pos < max);
-            tcg_debug_assert(pos + len <= max);
-
-            tcg_out_op_rrbb(s, opc, args[0], args[1], pos, len);
-        }
+        tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
     CASE_32_64(brcond)
-- 
2.43.0


