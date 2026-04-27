Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A78FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLRQ-0003qa-8x; Mon, 27 Apr 2026 08:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO7-0008D6-P2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0005lJ-Ie
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891f625344so91592505e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294109; x=1777898909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9y4m/iMelPf9i9IEtiQcavxusS+opbaUucMeNQfMLfc=;
 b=lcBl/+E5bwzllot1A90vs2jfupCTb+wkChs7vmB/OEvZN0T5MPCbVNNwqMDwECUNO+
 nSM5rHgS0S95f5fiGGjb3WeOgJL9Y7wzI920UUfsVoVgiiuQpXrGyLJ1yhCt9bq/1N09
 b3VIn1K/QItH1wjuc/DS7RbJIdvTHIbenA4Fdaz5YLr/Yqkmp29+7OQIyiuy60zldhuX
 +H9mAoUldqFCpsqu6n1B2eyKFeW01B9MxlvPs35FhTTlc63Ia0GBk2KmOr2+gXBBXjs8
 gHtSSQ46iRQV3S9O9RT4/vqB8AotBCClG+H0LXH5zLbo51vSy5wWXPJlQkfc+R8e7acd
 UrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294109; x=1777898909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9y4m/iMelPf9i9IEtiQcavxusS+opbaUucMeNQfMLfc=;
 b=r+ytWjwE+6eqkZoIMILVoTty07GqnWq/pUd72PNMHcRBLSqlq8VenJoP2T4dwzV1sk
 JfuMP7Mk7j+kuqQxwhRs6AuXBZYrCzOQ14jQcNWEU4xuyZX/Dn7fqQMK/a1eHcL7dx2N
 reCMOGg7UmCnUhPrcLapbaaW8h6kbWRApJ/lrUNBAvXmUDae41XYJQXSfo2PgUYut2+5
 Xk/xm7GetgJ7DYoIWiEBl/bbX/0QpAKTEMJ0ukRcf8EhPrR7rpA6NsSny37ZaWaZ8WDN
 oj6lggUrOUwR3FZVdd3UkMn8MZKCdwaRwlRqFDONQkbKx+7ZLC3qUUyzshMLkiAvcqEu
 qiUA==
X-Gm-Message-State: AOJu0YwudxXco7xVeRr5GQKBqtMFXrGSTI6axELPhmFy5Saaa3rDzUxo
 6sxYHMHxC3KXjBbAdXcUzfYZfTjRsiKNhhBDeGuReMNPbZzbYIUOsrQzPO3ADvZDnvxBD3zMmyA
 +QAGW
X-Gm-Gg: AeBDiet22CUv+dv4F1DHB2pRIn/dK6vigZ6ww9cscxj7grtZ1xuny766vCcVw0op/bW
 CyiHJTokaml4WPRbKbU5GXSnDIaNZqM3BcFx/gTlWiPXnhSlrnWScatX9o68Xqy2GY0x10hb8IO
 H/Yk/9ELrbgC/AUnMXbnA9PU1fQ7hTrGIzI+REfaklFaRRjdarMiZx6ki/FgXqRdAnIAWb8x7dK
 SU1k/a89mXhFLJkYcy8CCe1vVmMFTPShygf9I/xDzUi1oSssu4XBpzB5Ecam+I1xNdTIlUQdjz/
 7OXjBSh+Uz69FE7Uetp6Nmva6CPVDwUYraH4awMA2A82YseUpqbcHcnGJJISqP0qzKmEr1/hhoi
 ID42QbVY/Gnjbbkylhv0r+rf3mOe3Z9BIlO3U65QgFY9XnmRLs+cJg3m9nQjpaqrhe0nijJC/uU
 Lr9kOwkGhXaCLjtoW6Hwd4iFpErfR6LMd9cD8rp9Kuj1j6Jyf1cgvTd8o442DsCAbCXNthZYCtD
 jg17EAa0pVRe1TDs3Tf4iRLhhUXt5EsjBLb5da9gA==
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr456828485e9.3.1777294108776; 
 Mon, 27 Apr 2026 05:48:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/63] target/arm: migrate memory op syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:28 +0100
Message-ID: <20260427124738.966578-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-15-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 7ff8c30e2b..841fd3292b 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -742,14 +742,39 @@ static inline uint32_t syn_serror(uint32_t extra)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from the Memory Copy and Memory Set
+ * instructions.
+ */
+FIELD(MOP_ISS, SIZEREG, 0, 5)
+FIELD(MOP_ISS, SRCREG, 5, 5)
+FIELD(MOP_ISS, DESTREG, 10, 5)
+FIELD(MOP_ISS, FORMATOPT, 16, 2)
+FIELD(MOP_ISS, OPT_A, 16, 1)
+FIELD(MOP_ISS, WRONG_OPT, 17, 1)
+FIELD(MOP_ISS, EPILOGUE, 18, 1)
+FIELD(MOP_ISS, OPTIONS, 19, 4)
+FIELD(MOP_ISS, IS_SETG, 23, 1)
+FIELD(MOP_ISS, MEMINST, 24, 1)
+
 static inline uint32_t syn_mop(bool is_set, bool is_setg, int options,
                                bool epilogue, bool wrong_option, bool option_a,
                                int destreg, int srcreg, int sizereg)
 {
-    return (EC_MOP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (is_set << 24) | (is_setg << 23) | (options << 19) |
-        (epilogue << 18) | (wrong_option << 17) | (option_a << 16) |
-        (destreg << 10) | (srcreg << 5) | sizereg;
+    uint32_t res = syn_set_ec(0, EC_MOP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, MOP_ISS, MEMINST, is_set);
+    res = FIELD_DP32(res, MOP_ISS, IS_SETG, is_setg);
+    res = FIELD_DP32(res, MOP_ISS, OPTIONS, options);
+    res = FIELD_DP32(res, MOP_ISS, EPILOGUE, epilogue);
+    res = FIELD_DP32(res, MOP_ISS, WRONG_OPT, wrong_option);
+    res = FIELD_DP32(res, MOP_ISS, OPT_A, option_a);
+    res = FIELD_DP32(res, MOP_ISS, DESTREG, destreg);
+    res = FIELD_DP32(res, MOP_ISS, SRCREG, srcreg);
+    res = FIELD_DP32(res, MOP_ISS, SIZEREG, sizereg);
+
+    return res;
 }
 
 
-- 
2.43.0


