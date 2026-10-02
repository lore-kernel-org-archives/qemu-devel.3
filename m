Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F68CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZMw-0002Bh-TF; Fri, 02 Oct 2026 05:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMX-00029Q-05
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMU-0005NO-Vv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZzt01cQhTLHkCcugG6UcD8OeCoErq/eIerFTFSiw/M=;
 b=A4h55h8tyKl5XG+xUn+BfrQpvLzVwnglrwMif+4SHzF7SQFyuHeaKXdJpkiDv+mKxRL9Yx
 QitpM17xAlR+Hzb1dGWz/OrSXvy6cAaNoCW+Ho16bAG6j7WexJ1Jc+Fqc+tKLn+isIA4eO
 HNfW3HtdiHSpxhfFkDWYwP9o4DhhjZE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-DZBj74tFPSmbICAuDLAXiA-1; Fri, 02 Oct 2026 05:15:24 -0400
X-MC-Unique: DZBj74tFPSmbICAuDLAXiA-1
X-Mimecast-MFC-AGG-ID: DZBj74tFPSmbICAuDLAXiA_1790932524
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1624abeacso1859695e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790932523; x=1791537323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gZzt01cQhTLHkCcugG6UcD8OeCoErq/eIerFTFSiw/M=;
 b=CKDrq1nYxoE1fddtPs+nx1MPzWStH3KYbC6L6B2L/m2D2zaNT+3p8DwQgBOE1Cvm94
 x7TJhMTYToaEgdazAPdJ4JItpetF1m4nAa1L99VKcWnwGeATXYuaHBy2HrcXwUTXsFfH
 1aziZWqdlhc17b5ImBc3v5NISjoDKZA5js3nhgmQd8V+G+w7dNt7j8QMs6NCmqC4CD7k
 T6N/yCwzjlytSFyqwpH2xJcTFdnbDqzc83Xnr34iwwIzqJfhZNelBV30ot/ba/zxs8ty
 4u2itFneso/hlg/UDoLPKQZD9DB8fskHNVTU/QPM2duRQ0xBoaklh1RQb02Sk/4qfXQG
 CRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932523; x=1791537323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gZzt01cQhTLHkCcugG6UcD8OeCoErq/eIerFTFSiw/M=;
 b=BImCuY45cG/OZBGeHpFzwF9SurYP1oiPG0t8yfNdnrFvIBxepaDhBwuWD0YgRyTFmK
 StIevxIBsw9wEDwOgNQiq3iSrPnNGY5a+GJsxq+bqBoD/nInLWfVK16Q7fvyapr8n0sM
 MzDb6PaO6w6pWSZmPRFLIq8WQ5LPP3/FCgMw+AMK1caUbu7HaH2EPTifrfTv7I73kqUT
 O2aYQ0pKx1nRHWDE2wMfpZWSSosvxsc40Mych45G8LefWq5CYWqN5glyleJ3Fsztzd6k
 jpoapZDX9ocR01/lQCnVP4HBf8DZE4iAzKvSW1IVxjt2HzHi4o1VDMnx8p79phORY93a
 DJvA==
X-Gm-Message-State: AFuF++lsMxw8LsY1aO6lRRsiJ8p6p0KQzVwGeEJEN38506IJYpw7MtOo
 MXIzWdc8mwJUT+Rr9z6WzSedp3Lo3bGg6CZbqsdTF94oBZIZzJLbChhNQSG6cWmy1Bmhh/a7siH
 rLhrrNYFVpjYBS2hktj8/Ma6gv1HtsE0xsGQUOA6I036csTaN6CksC+crLKuJe2Frp0ZT4CfJlJ
 rYddJHlzG9WkY7PKv3vjgePDInza/KqSKcLfXEt2I8
X-Gm-Gg: AYBFou1NEdA+RZ59cWw3FmDWaBXJVLx1JWiHyFOzq087BqVhSCH63eTteXLEO6aiocS
 SdGkmveg8llN078+WUaRbAdJ/acZLno0b51uJBKpiP7tJAB29K4nGt8aIfoYDVVmdiqCH4u2rpU
 UiNx+YrUWtDTEUPyefJcEpugnfAcnAFDCOUQx25c76nl/HME7QbuvqMpS/roSX+JS/Su90oIPwX
 60/VwI3hdvN0I3fKcL+RGbfnWbghtUrW7gJGaVdSN9vwkFcFl45H6hnZNCdcHKRGQ9up7Mu3Ewe
 LQfXg2xkV3RJAk1hk/FN556y+bk7EbbPRB8uoeSEdKKto9um1gOoNF383RnF/dEKRsqWBhvM3iE
 jH6/1qJF+/Az1qRMlVym55IAf5/h0KG7fCNpsqWmQI7FBe2fOXIUHWSJWFxUYwmBIkCf9oBBcV2
 ns0Xfs
X-Received: by 2002:a7b:cd11:0:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a027565217mr22761265e9.22.1790932523605; 
 Fri, 02 Oct 2026 02:15:23 -0700 (PDT)
X-Received: by 2002:a7b:cd11:0:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a027565217mr22760745e9.22.1790932523058; 
 Fri, 02 Oct 2026 02:15:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0304407d2sm39570865e9.0.2026.10.02.02.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:15:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/32] target/i386/tcg: extract validate_cr0_exceptions()
Date: Fri,  2 Oct 2026 11:15:16 +0200
Message-ID: <20261002091518.1139575-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002091518.1139575-1-pbonzini@redhat.com>
References: <20261002091518.1139575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

The checks on CR0.TS and CR0.EM must be done after all #UD checks,
so extract them to their own functions.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 39 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 459452b04e3..996e12d03d2 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2742,23 +2742,39 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
         goto illegal;
     }
-
-    if (s->flags & HF_TS_MASK) {
-        goto nm_exception;
-    }
-    if (s->flags & HF_EM_MASK) {
-        goto illegal;
-    }
     return true;
 
-nm_exception:
-    gen_NM_exception(s);
-    return false;
 illegal:
     gen_illegal_opcode(s);
     return false;
 }
 
+/* Called after decode_ops, so that #UD for invalid encodings has priority over #NM.  */
+static bool validate_cr0_exceptions(DisasContext *s, X86DecodedInsn *decode)
+{
+    switch (decode->e.vex_class) {
+    case 0:
+    case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        return true;
+    default:
+        break;
+    }
+
+    if (s->flags & HF_TS_MASK) {
+        gen_NM_exception(s);
+        return false;
+    }
+    if (s->flags & HF_EM_MASK) {
+        gen_illegal_opcode(s);
+        return false;
+    }
+    return true;
+}
+
 static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
 {
     if (qemu_loglevel_mask(LOG_UNIMP)) {
@@ -3037,6 +3053,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     if (!decode_ops(s, env, decode_func, &decode)) {
         goto illegal_op;
     }
+    if (!validate_cr0_exceptions(s, &decode)) {
+        return;
+    }
 
     switch (decode.e.special) {
     case X86_SPECIAL_None:
-- 
2.55.0


