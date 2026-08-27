Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F86C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarx-0002pT-5N; Thu, 27 Aug 2026 10:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzaro-0002iZ-Tx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarh-0005p3-U1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdZXj6xCMaHtXb1ZbAVNibFohz8lgPE2CXZ1gsgSqik=;
 b=gYd8ZwIPsjhvGUuOGQRhBeWazX/PHw/+MEhI5wXemuawiwTG6oQ5yocRvTlbifXhS45u90
 K99+a2mAHylh7+NbVVfMe7GBkI1qesrsbjdj+QhMEoP55EEDTu7VFSLtInHvjNMAGXhJm5
 ygj5EqqdnwjMKBU1CKTvNApmfC+DucQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-vLSmi_CTMTib4rYGwUlWMw-1; Thu, 27 Aug 2026 10:13:59 -0400
X-MC-Unique: vLSmi_CTMTib4rYGwUlWMw-1
X-Mimecast-MFC-AGG-ID: vLSmi_CTMTib4rYGwUlWMw_1787840038
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so7502485e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840038; x=1788444838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdZXj6xCMaHtXb1ZbAVNibFohz8lgPE2CXZ1gsgSqik=;
 b=PpZJbEK5Jzvz0cibprO4DMVR8f/vBnHL+2rECpUR0M6J+0dnUvklpQI2zhEhXzvsyj
 Afit7R7Kj5uZJYfJxN/FqwIjl6cPCEFdIsUg1b6INtsxR5rko7YCHorJWvkfrcqVfBE3
 m+dTogMahdSZTzBLjzGI6hYAnXnBehQ0tVuWYP8mknyyDnMIr47TxdWfZXN/z7dwUV4o
 Uby1CMJt7j+IZKMDrL+PoB5LRjcIINpvWmB4+pPNfTOv41EdynrLpBMAHi7wmoN6OEak
 HJ1+O8Np6+gdVluOs8vAcUZIcbXwitJo3bRwUGwv9e5tdJdN8QGNvGDK/sH6sKgpKJgm
 FW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840038; x=1788444838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tdZXj6xCMaHtXb1ZbAVNibFohz8lgPE2CXZ1gsgSqik=;
 b=EQzUw6NciVsm1UQAmA80U+qXnjmjeHRauAtbcO6HXAD/SIoOGunNea42ztzLrPbX4f
 ztBBSPwEF7BU7p8JOtfe0iKFl+bi7OdDU93R5ATjDdDIH1cJDfYsV56BYYDUV/4+kpNw
 a+2sV956/F9ZMKzsqHc4kJ0CsSYQc8lGPFTwlqLTIJp4DzC5igiNSpWzROrVoYM/axA2
 E36lvbiSgy1nmCC89Sk4L6mmPAduxT52yjUl7QD2wYUoALp7j4jfqzscpdGLbWHWQhDV
 o4aFyuoS846YTZTTZv+XAOW6FgThf6uTtC3bxlPAeuH+ryZaF3wtOii038eoekbD1OY1
 vi8Q==
X-Gm-Message-State: AFuF++k0y0t0hDYhuJ88/1iR+3x4dPNQpjAbHJptUUuNtWTpP6ugfiOP
 LL5c4p40qUiJQH3qJFixt/1E+AzSSAZemIvmNi/WZl3MldlI3JWAeSa4zuaMDbslbBK4AHL7HxT
 mD8kDxfQNXvcqj4tUjjyLZe1Zm338GLsdPzbCE9A6ZJ3NkUKYVEVGI6j14nsatBxHjkEVKF9/2r
 SxWPQnbvmognK99gNGnEpEcQUe1vuSTpEmFkHkbHnC
X-Gm-Gg: AR+sD10jhTomW2r5xxNLWLBN8zc4e1XPKV8PKb07hjFQrGAR2oTtPoNGBfnecNRpHQL
 ta8vlPmQQKkqHe/rGrA+bujg4JOapDe6y2MYZHOCCzKgKS3WVjuInvWRUK122xegUYQeRz4T+EF
 wDJLZ+PrK/Ga+pJ2gzBJqu237mQZlwOqcafIy7yxilg+KPdG7bFHJQgPE3UzhHMFhnxpkGUU7b1
 1rCk76InqeSNEp5aiDV2pW384TpsNDQVNvYutVKaffsMNE2NGFo9nVN3F9RlBI9aXKpT4cyHQvR
 E38bNJixc2o7+ql3L4tXKIUg/32iMcpCaX70t20StYw5NhTN3ia+FvwZMc9zvAxR7wg5ymCJ6Ul
 xOgg0BV+AHj8tap9Kqq3WP4HM2XRiVdSrGMBZp5SSSUJ4e8W3tpaKp62pMkJuVQELOjI+e7wGtn
 60DVs=
X-Received: by 2002:a05:600c:8518:b0:499:dc34:bdc with SMTP id
 5b1f17b1804b1-499dc6f553emr191665775e9.1.1787840038256; 
 Thu, 27 Aug 2026 07:13:58 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:499:dc34:bdc with SMTP id
 5b1f17b1804b1-499dc6f553emr191664695e9.1.1787840037739; 
 Thu, 27 Aug 2026 07:13:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc61cfsm57839615e9.6.2026.08.27.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/23] target/i386/tcg: inline gen_ext_tl
Date: Thu, 27 Aug 2026 16:13:02 +0200
Message-ID: <20260827141314.1099352-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It has been mostly replaced by tcg_gen_ext_tl(), other than for a single
appearance in gen_op_j_ecx().  No need to have a separate function.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 ++++++++--------------
 target/i386/tcg/emit.c.inc  |  4 ----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d1791550772..70f9bb42209 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -640,23 +640,17 @@ static inline void gen_string_movl_A0_EDI(DisasContext *s)
     gen_lea_v_seg(s, cpu_regs[R_EDI], R_ES, -1);
 }
 
-static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
-{
-    if (size == MO_TL) {
-        return src;
-    }
-    if (!dst) {
-        dst = tcg_temp_new();
-    }
-    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
-    return dst;
-}
-
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
-    TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
+    TCGv cmpval;
+    if (s->aflag == MO_TL) {
+        cmpval = cpu_regs[R_ECX];
+    } else {
+        cmpval = tcg_temp_new();
+        tcg_gen_ext_tl(cmpval, cpu_regs[R_ECX], s->aflag);
+    }
 
-    tcg_gen_brcondi_tl(cond, tmp, 0, label1);
+    tcg_gen_brcondi_tl(cond, cmpval, 0, label1);
 }
 
 static inline void gen_op_jz_ecx(DisasContext *s, TCGLabel *label1)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 968abd47a73..c83ab809408 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1686,10 +1686,6 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
         ot_full |= MO_SIGN;
     }
 
-    /*
-     * cmpv will be moved to cc_src *after* cpu_regs[] is written back, so use
-     * tcg_gen_ext_tl instead of gen_ext_tl.
-     */
     tcg_gen_ext_tl(cmpv, cpu_regs[decode->op[1].n], ot_full);
 
     /*
-- 
2.55.0


