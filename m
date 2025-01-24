Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8E8C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFd-0006od-O7; Fri, 24 Jan 2025 04:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFV-0006ev-5G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFT-0003ru-Ih
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1rO3vXe0bS4eUZYDa0eLCYPsVdQibP8a4QBB0eAkTo=;
 b=b1pukGYe0CvGQCtIU+NcqJLS1ytzqOKb6jZB82J6VC4RZ/tt3WiiuMW8dybd4mQcdNlFel
 KVlxCfA4CO8TUiSE0V5S6Yx+dzILbG3gQEZ/3NqXkWgNtq2CWDyli8Vb55pB40mai0v+Se
 QRr+8gW/9ZqSa9yJs4JUoiKEK+HQ/Ug=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-8xXTxqu4OzmazvydXQCovg-1; Fri, 24 Jan 2025 04:45:08 -0500
X-MC-Unique: 8xXTxqu4OzmazvydXQCovg-1
X-Mimecast-MFC-AGG-ID: 8xXTxqu4OzmazvydXQCovg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bf4913659so1541120f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711906; x=1738316706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1rO3vXe0bS4eUZYDa0eLCYPsVdQibP8a4QBB0eAkTo=;
 b=LTI6+qnpUhgoyu5+ySC2gege4YSzEEkoxRE2Tnk3lLfWBErT2di0WEOCxIERwIwVmh
 79RjrbkslllXBejF611ycaGVCoPs5hjKbnyKvEZnZ1qOJMs+QS4hhm2f5Dqy+BbboGvw
 u0yDMcnpmpI9sP0Zir1wuzlcFaVsK4nf/5cHtmhtdM4SDb2AfHAXdGpFOVtK2P1mwI8D
 6ri/GBCyQN5YpiBw7evRp+ptlRQkHIyIktlx/N3bg57ScHDyAFdE3J5X3hHmnjz1fJV4
 OPmqCHm6ggAQ7KAVJpWw52IYnjURq7TUU87WpjRlLSqVDxwYW9KzmJF8Td36cm729Wc0
 2Viw==
X-Gm-Message-State: AOJu0YzXAfxzGG/AmvnXh9RNfj+ZxCK44wdXkNOI9UGuD3Jo3qzvk5Bp
 WBjUtQ2X4TjXWKNXc705Z5cPso0ARmMS5VE8U/3GM6vZT+rFonZckpoUeXbSsZ5r2MklMtZaiAP
 l/Td5KwIgnL/+fFHDn/9tkHbu7SLDPEM0BT/+dZNYq8bPJib5gMqcZQ+di4+bMVfzlcD9vPuELw
 j85G/LQkurpZJWa6qD5GMWkY4G/QJKZCDvXOx83zY=
X-Gm-Gg: ASbGncsKnEj/I8LORHXvTFWuJD1DAAELXGx+PDwcOrA5UgncB6fBHnnXQT+LlMBrinG
 FYxoVLplWFJo3QyNZUWBpA+NOIwVigRfknuEpIliwqTe4YB5AJPEEMAyRnhHRMnafpUt6jtBHYr
 LJwFQmKezp+43K/QHWAgpqbTbLx9OpbmJjaMiEEykZHh3yxWBlcft84gYc5D9GjFcgwrNvHtDvL
 1llOJLLLeJsumaZ1kxB2RiO7uPaOlLeSPMr180RIKR87Mc6UaYgXaszaRN0gQB7VaL2WsnLVg==
X-Received: by 2002:a5d:47c8:0:b0:385:df43:2179 with SMTP id
 ffacd0b85a97d-38bf577ffc2mr25581510f8f.17.1737711906663; 
 Fri, 24 Jan 2025 01:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7a0Y9G3P4eXsb36h8Ct45GRthZwPYKYYHDoR768aACOAVxqfjHKBj7XqFeULXWD6rQ0KLqw==
X-Received: by 2002:a5d:47c8:0:b0:385:df43:2179 with SMTP id
 ffacd0b85a97d-38bf577ffc2mr25581476f8f.17.1737711906215; 
 Fri, 24 Jan 2025 01:45:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d74esm2218569f8f.37.2025.01.24.01.45.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/48] target/i386: optimize CX handling in repeated string
 operations
Date: Fri, 24 Jan 2025 10:44:05 +0100
Message-ID: <20250124094442.13207-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-11-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7a3caf8b996..0a8f3c89514 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1339,6 +1339,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
 {
     TCGLabel *done = gen_new_label();
     target_ulong cx_mask = MAKE_64BIT_MASK(0, 8 << s->aflag);
+    TCGv cx_next = tcg_temp_new();
     bool had_rf = s->flags & HF_RF_MASK;
 
     /*
@@ -1364,7 +1365,19 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
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
2.48.1


