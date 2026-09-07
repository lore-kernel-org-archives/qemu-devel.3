Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A684C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzf-0006AP-7T; Mon, 07 Sep 2026 09:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yza-00068Q-Bq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzY-00050W-Nd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so27746325e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786150; x=1789390950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V5GTzXoa5Bc18T0mL4aBCRmcSOeg2+fjb2ceHf6mrW4=;
 b=MYQpNvJ9Zr5LJR8o1Emc5RcmL9Qi60jb9iZqHHSSiOS1o4m2Rz4bGJyF+hhkkssj5y
 r97zFSJ6vkuJDKm66Z59O7fyb/v3fns/I1hTGbbqdu19/GG4KSpL0OZGBkGu9ZgehOuc
 mJbUTh7DoSuz9PhS4mlR6rxfoPZAiBsCpSRwbQMgAgNWkFLVNGEEBDTC/HqqlP954iJL
 /34jFXZG6+Fy2zDrNhm3UHgTmczag13DdyxeRcg4L0FpsSA+1VqEjVcIlEvZga8l/YXk
 1iQHvuueIvgdZsbjxRxKXmkcf3eq2V3TCWZQcbVMK0Ln8H1uaoMXCSfTonV7KAGKlHxm
 Jzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786150; x=1789390950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V5GTzXoa5Bc18T0mL4aBCRmcSOeg2+fjb2ceHf6mrW4=;
 b=YJ5IjRRZbrvoJAVcfOgoQNRQaJRUmQe0HiDRs2hPGROKm/htnPFCvx7ypw7AjGq/D8
 3SJejXRl6rP2m83GxNYLQBuz/y0AKtv5pRqqlfRuwX5hHS2nP7jG0EuxlAQbXt1xH/rv
 WXLzewx440NkiDnkDrZfEro1JE+IQR644Oz/hMGoTonXCFkC2dwTCuKwf3SGfyM1jCe+
 u/phRex1S0KULlUWTdVdy1M/Q01NEzzgJQuWgqKjvbMs5eJ14TLZXzuOzj0EG07fxHvg
 1VAoZ5Jq5p+3kHTaywh8BhzvcKjRkIAqOdY2cbzghhGikfqg5SfX4AzzzIIVUF2sULGo
 DVrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsDFep7lOCxyiopTxg7bM+UQOFxVreYgC33LKmdN1co84qB60bPjFwYBMXkxHXNQwa5Hqhu5W4CQC5@nongnu.org
X-Gm-Message-State: AFuF++kSoRPa8nuRmXgNfRHHW/D38XpPVuKWEvnszT0NkSbJqrjnhKwd
 Sh3SaYIWgc/VUdp/P6qFStcuDtVWhWAyyhq72mWaoMnzTIO0G9u/5bypHe0p+DIZ290=
X-Gm-Gg: AYBFou0D6tWJbHu4GRm7x3cHL8sKu2ti0F3bsOBa5laOHN89adyZtqXpdx8jIyIDObi
 xE9sXrjQlghV5G2HFwthpCIQWos0N5YbBsWzPh4mjthblDpMm7u3+vF9RImsUjKQtj06eMtcyei
 bd0dQYaRzONz8vli/0FvGzV05IWuDi+mkxy9oa9n/CGsmrzAXEcxit2y5Ti5syofoKPnehiRPuc
 2pslSTyozQFvSHhkdFji8rXV82pEBjKVQcIgdT6lpY2yu8woveiwom1isrwLglWWI8sxS372b/H
 MhMpcMy9vBTyVSiBx1BRvGIeLVyKZKA5bDErcKrOmCVzvKThZj+FW1hGFyjajE3y24D9x4y5TZQ
 Z7mPShuBjLZ9xwacybXrHOQ6F/IvDDxrPVDwsDeSM5Sv2bTaOJT+opsKObvocNwWcryWsAD1vz3
 3ZYj9T9GmUAqxnu8C59aNeFpz47cA3fsmgDzAG5CgQCzYLmu7uuSRCG2gf5CsasJyzeK/ZyRNGm
 VDIqLSME7CL+tSncyZL52SQj6jJlcFJZubVu90N113u2mi3X98lvQGxveVJNIFhxhzN+Q==
X-Received: by 2002:a05:600c:6088:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49cfc6cc100mr200288545e9.27.1788786150108; 
 Mon, 07 Sep 2026 06:02:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 4/8] target/arm: Don't use arm_cp_reset_ignore when
 fieldoffset is 0
Date: Mon,  7 Sep 2026 14:02:19 +0100
Message-ID: <20260907130223.3148989-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In cp_reg_reset(), we treat an ARMCPRegInfo::fieldoffset value of 0
as "reset is handled elsewhere".  So we don't need to explicitly set
ri->resetfn to arm_cp_reset_ignore() when we haven't defined a
fieldoffset in the cpreg struct.

Remove the setting of resetfn to arm_cp_reset_ignore in the handful
of places where we were doing this unnecessarily.  These are all
timer registers, and doing this brings them in to line with the other
timer registers (e.g.  CNTPCT_EL0 has no resetfn, and now CNTPCT
doesn't either).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f8185b201be..9d8f09f13b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2209,7 +2209,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTPCT", .cp = 15, .crm = 14, .opc1 = 0,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_pct_access,
-      .readfn = gt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_cnt_read,
     },
     { .name = "CNTPCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 1,
@@ -2219,7 +2219,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTVCT", .cp = 15, .crm = 14, .opc1 = 1,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_vct_access,
-      .readfn = gt_virt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_virt_cnt_read,
     },
     { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
@@ -2310,7 +2310,7 @@ static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
     { .name = "CNTVCTSS", .cp = 15, .crm = 14, .opc1 = 9,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_vct_access,
-      .readfn = gt_virt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_virt_cnt_read,
     },
     { .name = "CNTVCTSS_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 6,
@@ -2320,7 +2320,7 @@ static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
     { .name = "CNTPCTSS", .cp = 15, .crm = 14, .opc1 = 8,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_pct_access,
-      .readfn = gt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_cnt_read,
     },
     { .name = "CNTPCTSS_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 5,
-- 
2.43.0


