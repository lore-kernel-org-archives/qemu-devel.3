Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCDFC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqIF-0004xS-1w; Tue, 25 Aug 2026 08:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqID-0004tR-KG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqIB-0000lN-Vw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyxeCggo7uPr+hvGJI/JQMliRIq8OGfljSD0+Pgo2TY=;
 b=IL74Y3qeQsvreVWda8rXMF5qbPY0UGxcRc2yGbbBjEhjFO3HSq8Eb9fAwLwHEfYuPxslQx
 YZkpXR7TeY2k1PVjvdhnXdAfyWgIhMv5PItvpZrkbDzWUCkTrBVhIOPSQ5mUFeldmH2IX+
 mwnY2tzRbl7kGea7j2VGOzcc1jiBBBY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-2OI7uaKKMd-XajFwS8xq6Q-1; Tue, 25 Aug 2026 08:30:13 -0400
X-MC-Unique: 2OI7uaKKMd-XajFwS8xq6Q-1
X-Mimecast-MFC-AGG-ID: 2OI7uaKKMd-XajFwS8xq6Q_1787661012
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15e555a164so76604666b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787661012; x=1788265812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DyxeCggo7uPr+hvGJI/JQMliRIq8OGfljSD0+Pgo2TY=;
 b=ONX3w9OP+YWxGtMCDs0HpLDpyjUeDkywZ3bdMX1+k11nTdwwaJEhCgnKIpjH3FOvyZ
 5GznizxgyUwHFQ9i4WppkeKl+DvlGNu1c95F+MclSEj6+NvkCIrWJUIF6wJPAVRibYCY
 DeyqpKdh35uxVfFpQLBWtShmbRUV41rFWjJMwhM0/jz5k2S8pR1wh9gAsV+w6ZtoTS8h
 T+Uznhk2qwDeVXdCMNIBcLvIjMMEqza2RUpzLqQrTDMaSD9vN8Wa6TlUHzOGgMGEL8e7
 utZtRTHtPJ5eqQ4czzrjE8DuWRh9Akr3cu1rQGTNv5Dpyt7QG2Dawy3wTS5AwdcocZYL
 FVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661012; x=1788265812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DyxeCggo7uPr+hvGJI/JQMliRIq8OGfljSD0+Pgo2TY=;
 b=GsrMuABkRRRMx2CsvyHJMSLwapbCT+3J1qdzcajj4C/LURW7bmI7tQpLgci8rTLIx9
 vqx/nvxTIDHrSYOxPeId4GcrVfodFn0G6LFAZk2HW2/OixkgqiwUdy42Am2IlGzHchLk
 PLr1U9SEvPuNy9Cu7w1LmlYklVFQZ1rcCw9bdvXqEDk94j0K89q7Vey+X3mx5UoJDuPy
 N4upDwnInHMBKRZktqVWMWZ5denRBCwRDvH8yTbcOdbYWzIpzg9Cjpes/I2kFySuksT6
 k+zSoz7sDJ3xWEXnaOLhkOxaCmR8Jf8MV+8sXDd4szkL+TG1XYvPcf61DSGu2EwJuadC
 tkEQ==
X-Gm-Message-State: AFuF++nLfEFb5GLsxKwV0fNZcMInJm9DgXQbazBnfCRT3NTe44WK6c00
 Bsr+A7WZ5H+0VfK9ORC+qjGow1RGvvqkM1+yz8aorCfH+c62j5lg47/zxC9E4qGL/62DCs+3Opf
 uq1ZhKrLEHBSKpf8LY3nTaMDVDOuv05ekxvObm2Jact4boCnNYCj2iO8pSvEVWM4Nnl457DgvDP
 4GSIS7THOdtHfsOQZi48vyJLsogbO3MQGbieE6s3sQ
X-Gm-Gg: AR+sD13do7YKyKQLDo3Xxd1pOEf+XkGb0rl6zPzpa5NoEs6sND3PagETCSyWuqcXAEt
 1fhi3rbTmajMipLMxQQEHHwCWkR0JrK2DJF+UaWTLNqD8UA4PgMxE2aHV5I880DvTECab7mIOlN
 sbHycV4hQIdbdoSxctrjlQc+dQoqrxvZ+Ht4sLAbqV6e5M965qbCgkrNjbNi1P702VPT30Ff4Fl
 DEF+IQcC59Ot9IT8+o9SakAqNhBsOSKF994zNRBUBPCY45wFvDDZ/SLiZRG6d+I9+vbhXeucfSi
 bDY2J9CdXkL5L2I9u4pmxI9A2HeVtdGFOwaiNtD0Ip2na5pGhV63QatlPfzkyviBbRlsSnDCZwg
 wqZd1+CyGwlL7D8V1H7LyC45V6OYoBxCMA6yD/JR13h+S5HaAlz16bP1+FPlPtm+0wS0aPK8g8D
 ioaw==
X-Received: by 2002:a17:907:a0cf:b0:c1c:49d9:4c34 with SMTP id
 a640c23a62f3a-c24e2db3d7bmr770483766b.11.1787661012387; 
 Tue, 25 Aug 2026 05:30:12 -0700 (PDT)
X-Received: by 2002:a17:907:a0cf:b0:c1c:49d9:4c34 with SMTP id
 a640c23a62f3a-c24e2db3d7bmr770474266b.11.1787661011628; 
 Tue, 25 Aug 2026 05:30:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685ab63sm1704746366b.50.2026.08.25.05.30.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:30:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/20] target/i386/tcg: optimize CCMP
Date: Tue, 25 Aug 2026 14:29:21 +0200
Message-ID: <20260825122921.431739-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

If possible, modify conditionally the input arguments to generate the
flags requested by dfv; this way CCMP can use CC_OP_SUB* instead of having
to compute the carry-out vector by hand.  This happens relatively often
for dfv=0, and also for dfv=sf for code produced by clang.

Of the combinations that cannot be optimized, both GCC and clang generate
dfv=zf.  GCC also generates OS and OSZ.

Do not bother doing this for CTEST; the savings are modest because it
does not need complex code to compute the carry-out vector (CC_SRC
is always 0).  In addition, trivially replacing the arguments to the AND
would only support dfv=0 (produced by -2 & 2) or dfv=S (produced by -2 &
-2), because TEST cannot produce any value where CF or OF are not zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 56 ++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 1144953abb1..7641b2fc104 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1749,6 +1749,53 @@ static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, u
                        decode->cc_dst, tcg_constant_tl(dst));
 }
 
+static bool gen_ccmp_movcond(DisasContext *s, int cond, uint32_t dfv, MemOp ot)
+{
+    target_ulong op0, op1, max_int;
+    if (cond == CCMP_T) {
+        return true;
+    }
+
+    /*
+     * For some values of dfv, it's possible to overwrite operands
+     * instead of using CC_OP_CCMP.  The weird "16"s are to set AF==0.
+     */
+    max_int = MAKE_64BIT_MASK(0, (8 << ot) - 1);
+    switch(dfv) {
+    case 0:
+        op0 = 1, op1 = 0;
+        break;
+    case CC_P|CC_C:
+        op0 = 1, op1 = -16;
+        break;
+    case CC_S:
+        op0 = -3, op1 = 0;
+        break;
+    case CC_S|CC_P|CC_C:
+        op0 = 0, op1 = 16;
+        break;
+    case CC_O:
+        /*
+         * While for >8-bit results -max_int has 1 in the lower byte, for 8-bit
+         * results -max_int is 0x81, so it flips the parity flag.  Compensate
+         * in op1.
+         */
+        op0 = -max_int, op1 = 16 + (ot == MO_8);
+        break;
+    case CC_O|CC_S|CC_P|CC_C:
+        /* Same here. */
+        op0 = max_int, op1 = -1 - (ot == MO_8);
+        break;
+    default:
+        return false;
+    }
+
+    CCPrepare cc = gen_prepare_cc(s, cond, NULL);
+    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2, s->T0, tcg_constant_tl(op0));
+    tcg_gen_movcond_tl(cc.cond, s->T1, cc.reg, cc.reg2, s->T1, tcg_constant_tl(op1));
+    return true;
+}
+
 static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -1757,16 +1804,15 @@ static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[1].ot;
     TCGv cout;
 
-    switch (cond) {
-    case CCMP_T:
+    if (gen_ccmp_movcond(s, cond, dfv, ot)) {
+        /* Including CCMP_T, aka "normal" CMP.  */
         gen_SUB(s, decode);
         return;
-    case CCMP_F:
+    }
+    if (cond == CCMP_F) {
         decode->cc_op = CC_OP_EFLAGS;
         decode->cc_src = tcg_constant_tl(dfv);
         return;
-    default:
-        break;
     }
 
     decode->cc_op = CC_OP_CCMPB + ot;
-- 
2.55.0


