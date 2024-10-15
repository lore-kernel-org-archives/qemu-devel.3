Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC780D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNw-00009t-5Z; Tue, 15 Oct 2024 10:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNn-000838-BU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNl-0003P2-II
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtLc0lpCek67EOsSAqPMkd8exLr9Xv05gXgeBpMusKM=;
 b=gvBQfyHrE19Io1zpYTfjz3xYLkSLbYancoOmonaWZ09G9SKhshBEA+DyNEn76cYuHeKV/g
 3VPXSIZn6GdUQ+SaslspaZcuLfqLSKe7ps3NlPHyHNn/q2SqQlTACTRvHBlNUKIL7PoOmF
 fBdw6ILHs3UVFgYeQARqYpGtqO53MLM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-iC5cgFSyO4qxx4lcWMuhvg-1; Tue, 15 Oct 2024 10:18:38 -0400
X-MC-Unique: iC5cgFSyO4qxx4lcWMuhvg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so1419894f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001917; x=1729606717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtLc0lpCek67EOsSAqPMkd8exLr9Xv05gXgeBpMusKM=;
 b=RMMFEV0Q3qOvxJxJGaYYfl83hQmpxx0lIfO684ZgntMIwULVVyLYJWB6dnQgT8hk/S
 hTHeJLEKMnZDirMBSTc8GWCZw8vDKBAvKdwbHJ2Kk2Msdra7c1OYNFrK4TDD039hWf1C
 1vQo4zyDSe0zgHE5Wo7s3PCgEvl6UUIgCQSOkpG8VYlkPlSTAeUoYSJAJ2AUsm6uJd3m
 MVmxHRGOxtQeJpg9mEAV9W3UX9/4zwEJmvTBZaAp95TNZT5JGwMoQvRSZayQ6TX/F7m5
 EGz1vU6qoVHLuyorWo2vmiI+kOQXv9ayrfG3vpvygoTwswaKmnav/Ux68c5SDAr3cKwR
 8knQ==
X-Gm-Message-State: AOJu0Yz65OYZAJrgNhHJAnKLqcJFzTZ8arjfL9uDqRJHOIR6Nh1FZZMq
 n2So0lnGbBsfu96Z1TtFaiHOG5b9o/jON3kX5nJQz9HELnwI2N/hhXkXGo8QI+GQZ58u+N+DDbH
 TmNQnytoTyK9cPGdxCmd6nwomg0Tx/t5Pn8cuLH7Hx5eJIvF8IOFpEPedWON8W+8QB/o+lqWRdz
 PcLPBdRzjGy4c1Bo0VJhuDZ6e0GHltw6JmHw16ODQ=
X-Received: by 2002:a05:6000:50f:b0:37d:43ad:14eb with SMTP id
 ffacd0b85a97d-37d86bb9d5cmr324987f8f.14.1729001917142; 
 Tue, 15 Oct 2024 07:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqjd7jK3FEnN5XOqDf/MH0Wu9l+2PseHaXybhc3uTtDnGpNSvJW+fbJoaN9dBoD4Z/ntYrKw==
X-Received: by 2002:a05:6000:50f:b0:37d:43ad:14eb with SMTP id
 ffacd0b85a97d-37d86bb9d5cmr324972f8f.14.1729001916740; 
 Tue, 15 Oct 2024 07:18:36 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87c44sm1683541f8f.33.2024.10.15.07.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 25/25] target/i386: Use only 16 and 32-bit operands for IN/OUT
Date: Tue, 15 Oct 2024 16:17:11 +0200
Message-ID: <20241015141711.528342-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The REX.W prefix is ignored for these instructions.
Mirror the solution already used for INS/OUTS: X86_SIZE_z.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2581
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org
Link: https://lore.kernel.org/r/20241015004144.2111817-1-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 487c376032f..1f193716468 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1706,9 +1706,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xE2] = X86_OP_ENTRYr(LOOP,   J,b), /* implicit: CX with aflag size */
     [0xE3] = X86_OP_ENTRYr(JCXZ,   J,b), /* implicit: CX with aflag size */
     [0xE4] = X86_OP_ENTRYwr(IN,    0,b, I_unsigned,b), /* AL */
-    [0xE5] = X86_OP_ENTRYwr(IN,    0,v, I_unsigned,b), /* AX/EAX */
+    [0xE5] = X86_OP_ENTRYwr(IN,    0,z, I_unsigned,b), /* AX/EAX */
     [0xE6] = X86_OP_ENTRYrr(OUT,   0,b, I_unsigned,b), /* AL */
-    [0xE7] = X86_OP_ENTRYrr(OUT,   0,v, I_unsigned,b), /* AX/EAX */
+    [0xE7] = X86_OP_ENTRYrr(OUT,   0,z, I_unsigned,b), /* AX/EAX */
 
     [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
     [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0) svm(HLT)),
@@ -1853,9 +1853,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xEA] = X86_OP_ENTRYrr(JMPF,  I_unsigned,p, I_unsigned,w, chk(i64)),
     [0xEB] = X86_OP_ENTRYr(JMP,    J,b),
     [0xEC] = X86_OP_ENTRYwr(IN,    0,b, 2,w), /* AL, DX */
-    [0xED] = X86_OP_ENTRYwr(IN,    0,v, 2,w), /* AX/EAX, DX */
+    [0xED] = X86_OP_ENTRYwr(IN,    0,z, 2,w), /* AX/EAX, DX */
     [0xEE] = X86_OP_ENTRYrr(OUT,   0,b, 2,w), /* DX, AL */
-    [0xEF] = X86_OP_ENTRYrr(OUT,   0,v, 2,w), /* DX, AX/EAX */
+    [0xEF] = X86_OP_ENTRYrr(OUT,   0,z, 2,w), /* DX, AX/EAX */
 
     [0xF8] = X86_OP_ENTRY0(CLC),
     [0xF9] = X86_OP_ENTRY0(STC),
-- 
2.46.2


