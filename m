Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B207C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWB-0007lw-CP; Sat, 22 Jun 2024 08:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW6-0007k4-Lp
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW4-0000JB-2A
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35f2c9e23d3so2442389f8f.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058006; x=1719662806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eWHSPGQ4OpgUOQnB0NTDT0+Cwh6MYZ+vbNYocaAOsiE=;
 b=zGA/CoOkJLs6A3+/Ziuajk72PZbmKI4HXTpAhQBqIas2U1ROZeMjoBhpGM98bdZ4eB
 92aiGZSRVt2pJrXMwXH217QjsLLa/Za/8DXQNPTVuGTHHCBqK40Ox+IlpE2c6n6Z/huW
 EhMltvx9xHXVX3OzMg/M3E/5pp9qs21CHqNVstGxMRCOTmqmb3CrXAETvtc2tN77g/1X
 l1xsDHOMSOcaP1X+2EK2fdtxY8DSI4T8YxJdqvmmyQAkfX4bis2QgwhgxAD/Z0CTLWix
 cmxR8K8nv0Sz/NH5xvqqwxdayKF+23O6Ku6bp2NhL11KGSJ3vC3gDnHz3wc5kWIm1vqc
 aaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058006; x=1719662806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWHSPGQ4OpgUOQnB0NTDT0+Cwh6MYZ+vbNYocaAOsiE=;
 b=cclfhpwb6nfbiP2GWjgbIM1v15mv71JpR2Q2RlrmI8uXwURjELuP37SD6eY18zOAwl
 M3Ugxro0JC3ltG50TCxHdRsHErCrJP0sTcHxhPPRT3cd7ryl9w+VzaT3Mzz3ARAGpyFw
 uZmPXl7mQ5AzwE+Q+P3VSZAeq1uXngvQz1qFeXGXFcsilDLWPjCJtn4B/XZM4jBudgI1
 skRxa1VhIn1AB6STwirXEx96Kjo1BPH20jaHFgJ29Xdbt0ezic9IQUdpg/cyr+k6D+i/
 Ln47MpeFd789X6r+27MqH8frfcZx6O5hKbk8zUnTxYJSdlYCRUxL5JmLme2Q/ef0khsF
 JtRQ==
X-Gm-Message-State: AOJu0YxbSH7+QFPBHE7Gmh+fYdcT03DOxKVoR8JjoXFDJs/id/rH7+dx
 /YyzD4ENLbcx4iGf/9vKUP3tAsKdQ+7KMKSIT/930WHwivsUid2b2tzH2KHqOEq96n9eztt/lcE
 JKog=
X-Google-Smtp-Source: AGHT+IHJ1cJtSx0r6XZSn7BemioWS7NiSOd58bUwtRO0y6LGequNK6i1cTHzeXf0euLWeGdoR9uvaA==
X-Received: by 2002:a05:6000:1a8c:b0:360:728d:8439 with SMTP id
 ffacd0b85a97d-366e36491b7mr1214622f8f.2.1719058005778; 
 Sat, 22 Jun 2024 05:06:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] hw/net/can/xlnx-versal-canfd: Fix sorting of the tx queue
Date: Sat, 22 Jun 2024 13:06:26 +0100
Message-Id: <20240622120643.3797539-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Shiva sagar Myana <Shivasagar.Myana@amd.com>

Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue to
become wrongly sorted when executing g_slist_sort. Fix this by always
returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
Also, if two message IDs are the same, sort them by using their index and
transmit the message at the lowest index first.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240603051732.3334571-1-Shivasagar.Myana@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 47a14cfe633..5f083c21e93 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1312,7 +1312,10 @@ static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
     tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
     tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
 
-    return tx_reg_1->can_id - tx_reg_2->can_id;
+    if (tx_reg_1->can_id == tx_reg_2->can_id) {
+        return (tx_reg_1->reg_num < tx_reg_2->reg_num) ? -1 : 1;
+    }
+    return (tx_reg_1->can_id < tx_reg_2->can_id) ? -1 : 1;
 }
 
 static void free_list(GSList *list)
-- 
2.34.1


