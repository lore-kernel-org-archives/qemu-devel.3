Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7CBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1w-000431-Qb; Fri, 17 Jan 2025 13:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1v-00040g-3E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1r-0007rH-AM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21636268e43so58625235ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138310; x=1737743110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQva3q+MWFJ9pcoUzbmbXwAhlkVRuQCmcAHZ1Ju2AJA=;
 b=VKajTxHq+V/nOaQCoqV5AoNRcDdpTdAeCpKyLtsWHHuPERMRpRsDslhqr3YCjE9w++
 2LUJC5rTc0Q0TpnwZqKkhjIRlC1gX/XIjGz0boMUcnAyCJlYH4L20gGJwmlPA+44bkhP
 oZ3WVPaqJ9826PdC4b7+S/9mZMzxUTNjqZ6NAXwQYxARIS7lpJmeGE02ptsjkLydBkRn
 /RSbUPrL7QcouuG0f63qps/0qgxZG26qqTi4rppaCNfa5uAlviWjLTnaDCM/NHyIe/1A
 UWx+MOJDfOLutSOjy9adJTe+Kg/6OK1d/tjgs2JLZZF+LjrMtmXF9L6MHdRxJ9X0/EPN
 v8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138310; x=1737743110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQva3q+MWFJ9pcoUzbmbXwAhlkVRuQCmcAHZ1Ju2AJA=;
 b=OrcktC06wjKJgVAF+uZf3UhlyAZwZ/cxn0Th+3JGxpu5ARw0mc/zBI/8PoEGlQwndH
 v6iNZ+ElWT8OAa7Yw8798Ye8THImud1+5gnR5H/aw3vywmSHHKOCKTl64lP1ibwwdCXN
 zR1hK5yQadDtOLa4ST/kpY/df/pjVAJdIlvxpXG6vyBI14LjnMiyVvLY7li43Y45yJf7
 s2P/J91DLRuxad6sW3wc698Hfnrv3u+oaDuREFfkB+P8tbLU1GREAaVrAkG5Z2L2Fp5s
 Vjf5f7SaLmHh8WSQW2Q70HJzi6qx2AphQfUO5fCxk0+efR4/JJz0Ygnc9W5YPMpatQ+0
 zWZQ==
X-Gm-Message-State: AOJu0Yy1+Mx6t1rQ7/t7fG4IIuDi7bu6Owbo16EsomDpkSn5clC327By
 7kjz+PWd7Dfyezg7RYmYxz8bN0zdxTZAeof1jKQ1Q+ZCwJ3pb0K8F1dRgDZtD7UdGxneu9t9HiJ
 y
X-Gm-Gg: ASbGncuF3zeh0XTRDgEj4GFSSaZSY37yjvVbn9d4rr2dFTJH9fFeHd3r5vrH95KijKV
 7p46Z6xwxpL5sxa4IF+HJqIsxe+wn9Tw4Hq9pWjisa9MH/voMopYEyqeNhdwAf1RWyDH7dtZoRz
 jc6gahAGEs/xbC+Ds++bpb9DIpswoxts7a3CODM56htyC2UT8sSNrSoOiGCH9Ak1WcDQbJ5hZvd
 eR9ZqoSk80lC/pe40Hln4kPjPzc2Bz44UbLYmoeW6ApeTWfPNU9wV+h9AyaxOdSVsIFWm6Nh2P3
 E1yBxx9wiJUHQHY=
X-Google-Smtp-Source: AGHT+IE0ec2R8QTr3Zxmci7Hmw3ShAreTkYm9zsRplsc9QivcY8jf5DmRh5bKFSSorJT3ZSh20xn9w==
X-Received: by 2002:a17:902:f7ce:b0:215:773a:c168 with SMTP id
 d9443c01a7336-21c352de425mr55852865ad.1.1737138309885; 
 Fri, 17 Jan 2025 10:25:09 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/68] tcg/tci: Move TCI specific opcodes to
 tcg-target-opc.h.inc
Date: Fri, 17 Jan 2025 10:24:05 -0800
Message-ID: <20250117182456.2077110-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Now that tcg-target-opc.h.inc is unconditional,
we can move these out of the generic header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        | 6 ------
 tcg/tci/tcg-target-opc.h.inc | 5 ++++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 93622f3f6b..14aff6e7f9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -303,12 +303,6 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
-#ifdef TCG_TARGET_INTERPRETER
-/* These opcodes are only for use between the tci generator and interpreter. */
-DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-#endif
-
 #undef DATA64_ARGS
 #undef IMPL
 #undef IMPL64
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 84e777bfe5..ecc8c4e55e 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -1 +1,4 @@
-/* No target specific opcodes. */
+/* SPDX-License-Identifier: MIT */
+/* These opcodes for use between the tci generator and interpreter. */
+DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-- 
2.43.0


