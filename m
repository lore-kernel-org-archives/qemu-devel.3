Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8097DC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONC-00012L-4P; Tue, 01 Sep 2026 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONA-00011q-BF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:56 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON8-0007BS-9H
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:55 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso6253703a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268673; x=1788873473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HgyviTIOYw8VAyLJ2LdZVp/ABus10EL8EvtUFSkealY=;
 b=BKcsFJtFUrfJHL4YG0WnHofZwwiK86gj23adhx2vMZrNzlKZsT73tyVyIkFw+5Ex9j
 STm/faXdim2y3EXGilXlMoMHVM6Fj0gv0bIF2YsAsJRPpO0xhky7DPLbRtNh4uMf7W4j
 2mjwgXg5eaRn3GDqNebX6NN9UPGTdoSd99tdPIK2/rWD+hLkUBbzmdwXL6KZq0shPayY
 CgJF2cLjGIwtl1jkmqTyNNp1s285LFpEOM6k7ijY5Id3Z6XGQDN8M7jb6EvpoADzN7Pw
 H3BifKRoYNmEq39srWatiweI2IRD/uTtPsWKR5TjPk0Vw3ZA1iXPKJ/gpdfu3kJ3UCfO
 mkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268673; x=1788873473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HgyviTIOYw8VAyLJ2LdZVp/ABus10EL8EvtUFSkealY=;
 b=mnwxNzoSt/01DxL47VPv0N5uHfsg19YB+eT8LYfohHMZknGF/EdS9HLRlIFd0YNI6+
 SFslXCZEvkI29Jo8hknOiHySaxKkTgIKCnBgcuz1bK3COwJogk7zJb1O02BRzAb1REqu
 kIwJRQsyxH6w13lJavFV/fUvHRoYtJwN39SCLVCcLcws0PxoNbNPl+dlLrBsy9FAVvUN
 eZhTrrHUyX8CqdahQ5PyiG05v3nrtPdd2AV/6wVZ88wLGXe9PhmakL6c19cSlY/KfiGR
 pOSRsSbguIb1Z6yk3qdnpk1PfZuZ5ElcysbgqWiZMsjn4DkSV+PqWnMIH3wBf+LZWims
 V91g==
X-Gm-Message-State: AFuF++lm8e1jZN0rV11v8ZqU2lW7VX9LL4jEIgYRlPYj8kKAf2A2cqCY
 1ZyxVMdM5xGixouguIHl01KXDBvwJ7r7Do4HwPgLHYIpXfYsXcTq03AUByDL7f0ntMU9nDbCMkX
 SRss7/5M=
X-Gm-Gg: AYBFou17dLU6t1jAKVr3gH22fPOXc3WxLAFycWNEFoBczJTFk4+WKGNAVjtopDzk+dL
 QDcrkq9bBfKES7Gj08RC/oxG/m+5DtmX3W637kUJXWtT9iNTu2rZLzMvo8mIT4lFWRo32yErjpp
 MfanAplVxChccIiKdkblwuoaaUIGyp8XpJY0NO9TvsbbkaStWkPFGNtq5+fpFpFxErOPrj6eFgy
 m8+/h+yF/Opq4mrhIwXvEAGVkS0v12x4Hff/tp55gpsAk+sm7u+5ilwvCPoWEXxdqZcXqfiQ/2P
 3wyas3VIJFD7FIah+hKi5JcmMOL2CJocbgMsnIrATNxxsw1fquAKGsgfv+0/+4oK+b6CzcKJevw
 sjXtBtDDIJspguk1k66+CfKPZmSnPyW5etp3fRMw9PCGwotPlEcsZEAfcTA7JizHd/rorCnZWWk
 4p4HabAcUwB5snSAja4ZrgJZeWa/TknM4makAKe7rnesSP6zv7loawapkMLQ4r4pX35teRFfQhj
 hg55hdZVwwZ7rgscWGNKCao1InkhJDKYW7NSlhbVokRJX05qPomYKVZQ90gqJQTvbArcg==
X-Received: by 2002:a17:906:c113:b0:c25:cb7a:12d6 with SMTP id
 a640c23a62f3a-c25cb7a1365mr10450966b.14.1788268672673; 
 Tue, 01 Sep 2026 06:17:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/58] hw/misc/iotkit-secctl.c: use GNU C case ranges
Date: Tue,  1 Sep 2026 14:16:52 +0100
Message-ID: <20260901131732.2263947-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Replace case fall throughs with case ranges when register addresses
are continous.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-7-simonxhy0404@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/iotkit-secctl.c | 112 ++++++----------------------------------
 1 file changed, 16 insertions(+), 96 deletions(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 9f6fb81088d..2d06d6f80f5 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -187,36 +187,24 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_BRGINTEN:
         r = s->brginten;
         break;
-    case A_AHBNSPPCEXP0:
-    case A_AHBNSPPCEXP1:
-    case A_AHBNSPPCEXP2:
-    case A_AHBNSPPCEXP3:
+    case A_AHBNSPPCEXP0 ... A_AHBNSPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].ns;
         break;
     case A_APBNSPPC0:
     case A_APBNSPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].ns;
         break;
-    case A_APBNSPPCEXP0:
-    case A_APBNSPPCEXP1:
-    case A_APBNSPPCEXP2:
-    case A_APBNSPPCEXP3:
+    case A_APBNSPPCEXP0 ... A_APBNSPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].ns;
         break;
-    case A_AHBSPPPCEXP0:
-    case A_AHBSPPPCEXP1:
-    case A_AHBSPPPCEXP2:
-    case A_AHBSPPPCEXP3:
+    case A_AHBSPPPCEXP0 ... A_AHBSPPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].sp;
         break;
-    case A_APBSPPPCEXP0:
-    case A_APBSPPPCEXP1:
-    case A_APBSPPPCEXP2:
-    case A_APBSPPPCEXP3:
+    case A_APBSPPPCEXP0 ... A_APBSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_SECMSCINTSTAT:
@@ -228,18 +216,7 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_NSMSCEXP:
         r = s->nsmscexp;
         break;
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
             r = iotkit_secctl_s_sse300_idregs[(offset - A_PID4) / 4];
@@ -389,10 +366,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTEN:
         s->brginten = value & 0xffff0000;
         break;
-    case A_AHBNSPPCEXP0:
-    case A_AHBNSPPCEXP1:
-    case A_AHBNSPPCEXP2:
-    case A_AHBNSPPCEXP3:
+    case A_AHBNSPPCEXP0 ... A_AHBNSPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
@@ -401,17 +375,11 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
-    case A_APBNSPPCEXP0:
-    case A_APBNSPPCEXP1:
-    case A_APBNSPPCEXP2:
-    case A_APBNSPPCEXP3:
+    case A_APBNSPPCEXP0 ... A_APBNSPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
-    case A_AHBSPPPCEXP0:
-    case A_AHBSPPPCEXP1:
-    case A_AHBSPPPCEXP2:
-    case A_AHBSPPPCEXP3:
+    case A_AHBSPPPCEXP0 ... A_AHBSPPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
@@ -420,10 +388,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
-    case A_APBSPPPCEXP0:
-    case A_APBSPPPCEXP1:
-    case A_APBSPPPCEXP2:
-    case A_APBSPPPCEXP3:
+    case A_APBSPPPCEXP0 ... A_APBSPPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
@@ -444,18 +409,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTSTAT:
     case A_AHBNSPPC0:
     case A_AHBSPPPC0:
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SecCtl S block write: "
                       "read-only offset 0x%x\n", offset);
@@ -482,34 +436,17 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
     case A_AHBNSPPPC0:
         r = 0;
         break;
-    case A_AHBNSPPPCEXP0:
-    case A_AHBNSPPPCEXP1:
-    case A_AHBNSPPPCEXP2:
-    case A_AHBNSPPPCEXP3:
+    case A_AHBNSPPPCEXP0 ... A_AHBNSPPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].nsp;
         break;
     case A_APBNSPPPC0:
     case A_APBNSPPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].nsp;
         break;
-    case A_APBNSPPPCEXP0:
-    case A_APBNSPPPCEXP1:
-    case A_APBNSPPPCEXP2:
-    case A_APBNSPPPCEXP3:
+    case A_APBNSPPPCEXP0 ... A_APBNSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].nsp;
         break;
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
             r = iotkit_secctl_ns_sse300_idregs[(offset - A_PID4) / 4];
@@ -560,10 +497,7 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case A_AHBNSPPPCEXP0:
-    case A_AHBNSPPPCEXP1:
-    case A_AHBNSPPPCEXP2:
-    case A_AHBNSPPPCEXP3:
+    case A_AHBNSPPPCEXP0 ... A_AHBNSPPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
@@ -572,26 +506,12 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
-    case A_APBNSPPPCEXP0:
-    case A_APBNSPPPCEXP1:
-    case A_APBNSPPPCEXP2:
-    case A_APBNSPPPCEXP3:
+    case A_APBNSPPPCEXP0 ... A_APBNSPPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
     case A_AHBNSPPPC0:
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SecCtl NS block write: "
                       "read-only offset 0x%x\n", offset);
-- 
2.43.0


