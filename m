Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE99C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raff3-0001Bc-UR; Thu, 15 Feb 2024 12:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeV-000867-3s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-00040m-Ul
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412078e983aso9074425e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018551; x=1708623351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ItDus477ViEF7ViBoqLevZzlW3W1nD36iFfdLJ7rWjg=;
 b=x8fctdMTPSoWlhaUpzBXp7jcDfhBSeenfHB3WYOSK08+CPQqYv2AeX1Lb5bzYDZy3g
 Q0o6RgcVxS0ftNbhjhze/mTMceKPhIaiXbb0ZeAvIOhhtAwIxD/UZMK5QrVtxJcvsjAI
 6THXZfM8xfu/OyeIL9qFu259M7dU0xdu9mStkrA+v4Pb6+KwBiTSX0JOvSVsCUH81lc9
 6ym/JVKSy0NnE+a8KeSKV/qGFN5cUpaAgo1thUuwNa7WH2KIagZWCOreIVKd+8pjLwGW
 k41qppyov34sHxm1fv+WSJEL2qAUYZHvgFUei0o4OIbU6dH0tShSfXs8NFPzSki+YhoD
 deBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018551; x=1708623351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItDus477ViEF7ViBoqLevZzlW3W1nD36iFfdLJ7rWjg=;
 b=LPgDMUr79W7hmCzGNCd2LSzmnjOIHtQCnSqwZaBCgqZ6xSd6ZGeTy88obXBKVKOH0y
 PlgJ6dnpRMy22W9oVoe7xg6hD5YWQsakXt5DK3ypMXYpdqmqWlByfWdITIaO5vjRh/vh
 SCaOQuwIVF/G354Ob8Cd13BMxP9/nR3hprhV8o+AdwWeTDIosToPDYEA2xKn8tjgXJcF
 b1y65S1axki0nxOcQvELz3rYrHkuTY+q+tB0eexs/SIi8WKJ+6ZcBV0rLfiwu3xSUlft
 bUo6s0XVtiENI7U9eDEaHPURRVj1jUd3MoO7ummV1wDc9QM2Q4IL4IREnguUiQ1rwBIn
 SgZQ==
X-Gm-Message-State: AOJu0Yz77RL/Se5g72dvX1vA/Xe54gKuqRvUY6Kzs5T2cEM2WcsUPLsn
 oJfaK3kvQjVPtofE0DeFcfZ7dt6gKo6w8gQMEVRRwjQ9NbdJA/IlmuD6cwuLgvKcwxyzKLnhPy7
 P
X-Google-Smtp-Source: AGHT+IEHQF8Muc161aQlYURq3ajT3X3OvAbZZr6LcF/16wP3XS4uxz5MpJDWT8QFrH3l1HtfguIn3w==
X-Received: by 2002:a5d:5011:0:b0:33d:d35:374d with SMTP id
 e17-20020a5d5011000000b0033d0d35374dmr1399416wrt.62.1708018551354; 
 Thu, 15 Feb 2024 09:35:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/35] hw/misc/mps2-scc: Fix condition for CFG3 register
Date: Thu, 15 Feb 2024 17:35:30 +0000
Message-Id: <20240215173538.2430599-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

We currently guard the CFG3 register read with
 (scc_partno(s) == 0x524 && scc_partno(s) == 0x547)
which is clearly wrong as it is never true.

This register is present on all board types except AN524
and AN527; correct the condition.

Fixes: 6ac80818941829c0 ("hw/misc/mps2-scc: Implement changes for AN547")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240206132931.38376-6-peter.maydell@linaro.org
---
 hw/misc/mps2-scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6cfb5ff1086..6c1b1cd3795 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -118,7 +118,7 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         r = s->cfg2;
         break;
     case A_CFG3:
-        if (scc_partno(s) == 0x524 && scc_partno(s) == 0x547) {
+        if (scc_partno(s) == 0x524 || scc_partno(s) == 0x547) {
             /* CFG3 reserved on AN524 */
             goto bad_offset;
         }
-- 
2.34.1


