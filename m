Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1210CE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaU-0004dR-Gj; Sun, 15 Dec 2024 04:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaR-0004cC-PM
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaP-0006zF-8g
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Idh6F+CCHPC1QXuT+CtjsxuMJk4UDaP68th/7PYeY34=;
 b=ao+cfuo1liSmCN8aYlV6FYO5LKLSq46H8VIo+mTUph4ObbRfccLQvK7pwVxS0US8iBwA61
 mpNwCuCLhcdgORokEWgwP625xPWU7Hun35J2PjZH5Q0GKZ+Oi8gbsN3nSb6p6WoycpJKJm
 5cGrqndiz+kfIApBtOHeBxSIFx6VBOk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-X-mO8gnnMf-3Rv43afx5lw-1; Sun, 15 Dec 2024 04:06:47 -0500
X-MC-Unique: X-mO8gnnMf-3Rv43afx5lw-1
X-Mimecast-MFC-AGG-ID: X-mO8gnnMf-3Rv43afx5lw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso345515e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253605; x=1734858405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Idh6F+CCHPC1QXuT+CtjsxuMJk4UDaP68th/7PYeY34=;
 b=hTZ66idSwkKB/End6951pvJY7L3H25Nxm1I/XLshGn5+i0lUxjySKDTiLJ8TJ6+tmo
 NYgUBXXFhFP+FJJKLpxbda/dTCOa4b6ZP2ilM+50rs8PQWR2CpqimNbC2h8BtEDrl2JG
 eca3GnVQ4wTx/I2sZpDTp1ny/Gdh9jmf5456QXV+aiG34071l8zLiqoZ7fV+V/XpsEkW
 nJT/Rwj/yuR3OJ5nZOk9q2c2TLP5JDeQv25+YAgCRErCnV3Pq4L+jh38GUk3mysPDLji
 /I3le17FdbuHeqj9DW7OxHsVt4UfTjsgkwTDhmxT2lkQb3C2wMcaktDgs13edvhNMt3w
 JLeg==
X-Gm-Message-State: AOJu0YzN78CWcFRgn33KmOTjdlTI3pSdhXJx5/QJJaCGm/JRSpHDb84L
 gUA/DjnpPEHh19izgA43P4hQsdbxJA1CDdgqN2H1KMibUo3nlpLkKgDK5hSiG4BpiLT+tAc621c
 xSatGWpervCL0dRh6a9efNbyIIVAFgRQnhgjKFzeROdkTxIpUNKQZaQ3W5KgJAKERBHOOICHAuY
 M1Ht5F1bC4r41oFIAsPrrHWejh1/xcXDsmw29t
X-Gm-Gg: ASbGncs2/kDEB4s9kEi7SYEbrkKeIHthGEhy2vdgD9emnUdXAP2QsrKcKE0sOskIwSU
 bGUzIwHw+mrw/2BD5mRrsEGRbUEokBf+2cHapCQ7A/3u8MVTm6iWwQJ+DTa6VoCpc+irZR4UTmz
 be4PXnHDTK4mIkHbW98+Vv7797VrS4ardLg4Mtu2dU5UiK/IIm+sBHgHBx2mCF6fVYvs35Iu++i
 5zwYfxLQ2/z75B//1V8G08F8t6KaJ8plrIyB4n/nbBz1o3A1zXOt+oBEFA=
X-Received: by 2002:a05:600c:384a:b0:434:a239:d2fe with SMTP id
 5b1f17b1804b1-4362aaa89e0mr62916755e9.28.1734253604921; 
 Sun, 15 Dec 2024 01:06:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGysfcTt60NSxVu+C2YzakB8y+tIeDM8pyUczW8CaTsHFWSR1u70gKVQoOhcglW463CCq2Xjw==
X-Received: by 2002:a05:600c:384a:b0:434:a239:d2fe with SMTP id
 5b1f17b1804b1-4362aaa89e0mr62916555e9.28.1734253604506; 
 Sun, 15 Dec 2024 01:06:44 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e322328sm119831855e9.0.2024.12.15.01.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 10/13] target/i386: optimize CX handling in repeated string
 operations
Date: Sun, 15 Dec 2024 10:06:09 +0100
Message-ID: <20241215090613.89588-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In a repeated string operation, CX/ECX will be decremented until it
is 0 but never underflow.  Use this observation to avoid a deposit or
zero-extend operation if the address size of the operation is smaller
than MO_TL.

As in the previous patch, the patch is structured to include some
preparatory work for subsequent changes.  In particular, introducing
cx_next prepares for when ECX will be decremented *before* calling
fn(s, ot), and therefore cannot yet be written back to cpu_regs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8ef938372d5..2ea8a418612 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1337,6 +1337,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
 {
     TCGLabel *done = gen_new_label();
     target_ulong cx_mask = MAKE_64BIT_MASK(0, 8 << s->aflag);
+    TCGv cx_next = tcg_temp_new();
     bool had_rf = s->flags & HF_RF_MASK;
 
     /*
@@ -1362,7 +1363,19 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ECX], cx_mask, done);
 
     fn(s, ot);
-    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+
+    tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);
+
+    /*
+     * Write back cx_next to CX/ECX/RCX.  There can be no carry, so zero
+     * extend if needed but do not do expensive deposit operations.
+     */
+#ifdef TARGET_X86_64
+    if (s->aflag == MO_32) {
+        tcg_gen_ext32u_tl(cx_next, cx_next);
+    }
+#endif
+    tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
     gen_update_cc_op(s);
 
     /* Leave if REP condition fails.  */
-- 
2.47.1


