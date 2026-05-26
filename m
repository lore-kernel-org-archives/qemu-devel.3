Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C207ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRvmz-0007Gp-T1; Tue, 26 May 2026 13:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRvmy-0007GY-Sq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:42:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRvmx-0004AU-6I
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:42:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so36098765e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779817317; x=1780422117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0mssOI/2jraHsHBlbkv+u0I5kV8JcukvHeex68v/cTo=;
 b=wMP+5KSyYhVUOUUb10nfkfF+zWYVWfFPG2Ve5fS6n6NNZmCg5e0FAjaaBSZP/TYk3L
 8OG5rjs0FkdT1m3i5CH10NqNkn8hrePMh5f7Knh3ax743xQuOlY41lTvacwuwLcRlIFU
 Qx32p4Kz/HmvvTpKenrAx4K9uzxOGucFutdtx1HLtkKdp9kxr3ULYAjA8MLNpI4f0kn+
 Pq8+BhCE++D8rMuw1rvSZhHsy+x/zLS7qUP1MWBsc/zVfT//NsbOSIX3r4SdELmomT1F
 kyxdK1WDH87qwtbWolZ3TNk0ZAwIAUg/lL/IawApedHNbMMO50+a49frj0jjx9qteGPE
 kBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779817317; x=1780422117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0mssOI/2jraHsHBlbkv+u0I5kV8JcukvHeex68v/cTo=;
 b=PwlScal6kZSwSTQCYRFNWesAdpWSOWf93h4ov9L1Sg1OE9El/xMAZwZNz9OH6tW19x
 jDcCTvAqQmitJhrFmzKCvuNpa0JLrOdl741G7WtSSby+B2Q+uhzcCRj0U5a3x6gjvfCV
 CESZHv0duVP6hDcAJiKG/hCsbAG4mwog35nYLvRKLCFXCRYrIGh8HcoYGJtnbkMAhL7u
 F8mYQxtiijGbM9E8VCe1WJhGr3xvXXY/yfYOmVWCczEbH85f0cKgEav+jlcF9uI0pJoM
 JUmy/QB3m6qYrlw2Dm0Z6y6z+2oMc3ro52Sa9SWtD4amuJ2jFFdFIpBOLp005UNsNge9
 S7bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ978yQl666YpB9f77fcOfDFVRg46IHU8yOJ0PxOk/wYjTBHhoA31LH6gT5OpdHkH+MNNY2tc47XDZ0V@nongnu.org
X-Gm-Message-State: AOJu0YwB/jzQHuxM4c2iVjSHIEiDN4eUrAiGlcdDe6hl8aPW63YoxbtT
 i40wYZzRZfwmWI9jwJaCe+wWgQ0D6O38SumfYBlscQJ0vxiSYPWGQjtdhY6ftCpuRNs=
X-Gm-Gg: Acq92OGEh7NN5j3r4+x0hjC0LKgHffYQW6n+bkxffogHjrFfNEdxeC94QLLQ+BxLhRF
 sH4LbFBwfADxSz4Tid5eGC9OkFqCa5gD8g+Wcal+ibsUiE5ZYk4yBVSGxm4UkxzSffzoSjXJuAe
 UyCkdehVVAAq+v8kLXCUv3GCOeWhORJw6jWehmLU9EzkeEl7wvOhnDyap36nhYsaTZYh+FI0v9w
 en3Gh23zrfsi03Xjou1JesUIJKzR3ABN801/eGMMcG2Mn+E40cm1TuR6K2IdQCFq0pv4qUNowwM
 bMKHW4p0flg2s2c3/o0hFAgx134MwyoMw84nDDElC6IloOh8pf4F8g9eiz0qWEPFGiQF3R7q7zk
 wOMQzCRFkAUnRh9av7wkrZ3GyDFFM1iW8Jil9Yy/p676yCQU8ddk6RWU4wQKzg+1bVrTx4w7rIM
 G/NAPmDJqSKmGHqa4lFAXrBqvEB+/kzq8PN2PpfWAUESHm5iCoZ4ezruaIQuEUyLwPPo7o0Xmx+
 iI+jIXHbD63vy6CWnW9Wpt1crMu4OUVv3vGKWnYyQ==
X-Received: by 2002:a05:600c:4ecc:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-490428db91cmr296943015e9.26.1779817317323; 
 Tue, 26 May 2026 10:41:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c600esm335920215e9.3.2026.05.26.10.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:41:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain
 fault
Date: Tue, 26 May 2026 18:41:55 +0100
Message-ID: <20260526174155.2491217-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The Domain fault type can only happen for 32-bit short-format
descriptors.  This means that it almost never needs to be encoded in
a long-format fault status code.  However, there is one corner case
where we do need to report it as a long-format FSC: if a 64-bit EL2
does an AT insn on an AArch32 EL1&0 translation regime that is using
short-descriptors and that translation operation hits a Domain fault,
then this is reported in the PAR_EL1 in long-format.

The PAR_EL1 register description defines that this should be reported
as 0b111101 for a level 1 Domain fault or 0b111110 for a level 2
Domain fault.

The Arm ARM pseudocode special cases this in the function
AArch64_PARFaultStatus() (because no other "fault to LFSC" code path
can be a Domain fault).  For QEMU, implement it in arm_fi_to_lfsc().

Cc: qemu-stable@nongnu.org
Fixes: 1fa498fe0de97 ("target/arm: Provide fault type enum and FSR conversion functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3512
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 00830b1724..bb15b149f9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -880,6 +880,16 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
         assert(fi->level >= 0 && fi->level <= 3);
         fsc = 0b001100 | fi->level;
         break;
+    case ARMFault_Domain:
+        /*
+         * This can only happen when doing an AT insn at EL2 for an AArch32
+         * stage 1 EL1&0 translation regime using short-descriptors, and
+         * the translation hits a Domain fault. This needs to be reported in
+         * in the long-format PAR. Compare pseudocode AArch64_PARFault_Status().
+         */
+        assert(fi->level == 1 || fi->level == 2);
+        fsc = 0b111100 | fi->level;
+        break;
     case ARMFault_Translation:
         assert(fi->level >= -1 && fi->level <= 3);
         if (fi->level < 0) {
-- 
2.43.0


