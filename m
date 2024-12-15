Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F76E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMka3-0004SG-J8; Sun, 15 Dec 2024 04:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka1-0004Rk-Dc
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkZy-0006wR-Pl
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dGFERRWFUpZlIsQTMSnLpRN54/m8liDcvkRPsprq7k=;
 b=hZTJ396JI+t1G1Z0w0UWPV+kXyXGl2QgIvhU/5AOkOuVsCS05OFeLFnl6xrrkdefFDns9G
 o6HI620Z5vt+hj+liuXxwKePpO5WCr8b/OKcNsvFaraMI4ROYuD9lgegshO4WBBcFa6w5C
 8JPx8CN7BAu8wZ3R21qzmSFbI1A4ELg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Ht9I7XYAOqKQNCZ1s1RtGQ-1; Sun, 15 Dec 2024 04:06:20 -0500
X-MC-Unique: Ht9I7XYAOqKQNCZ1s1RtGQ-1
X-Mimecast-MFC-AGG-ID: Ht9I7XYAOqKQNCZ1s1RtGQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so6339175e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253578; x=1734858378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dGFERRWFUpZlIsQTMSnLpRN54/m8liDcvkRPsprq7k=;
 b=DFvpHXpKfkE6tMmgmmPpWQavGLlyuHwWAlMIzIjPhMFNQ4z2wcPaTd8Nj7IiuJUms5
 QqyHQosRoec8AVdm038M+BkAFZXfIP+xIDv7dIr/78ax2K/JeC6Vh25AM1Fon0cv6Ku0
 omMk+xGU83NFeJdWWpl1bPr1GFjq7TaaB2RP/JLy7ciA8124u/GREdPJhTdWc0BlYKFY
 0WeHO3p3W4vu7T8eSPwe+8ZSvlf60QppSEyFwkp2WGTU1Eym4iiB1Ts9sP9nEnNGEn4Z
 pYYIk6ZXpwfQuWhHUpjtWCIegLH52eKD3Ugs4RSvXTzp5RW/fZ9LZSmsoQ5lWaHk/MVo
 tNgA==
X-Gm-Message-State: AOJu0YyT+Y08G4uDHnqguLL2kbUUxBPESrMO44f7Bom/vgBpCSo5I7h0
 fTsRfIZ5xFDV9xTP7hKf/n8dcyUBCN+zav5+PQ3Xx8FwWUbSEMO7K2fhJJbcVNtvPI1ydrM8szO
 IGXwGQK6p+ZqZAPbcagG77Xv4mOK+sWCfz8Kt/1i/vXJuGI0Oxt3EiTaZvBwLJqhHHC7wnSn1Kc
 9QRqDgVHThwNLKwu+atl3omAn7TlJJyj0ewNN0
X-Gm-Gg: ASbGnctqzqgcsS4azQfZsWGPC728O/p4aXSAERrVvW6AU6ldA9aQ1NWx8by2cJ4mZPu
 Q+FLcLhFR+NmRZtSUa2Gius0lzV/SDzZAhZRnDWe3214xr0M4Eg9bkdTx7uME7munB7j8h4qBFA
 Rp6BFjncYGEAfQEOXW8hpd+W/YwknxTIKCpgVha0V25SUKIoTt1Xi0Vd5mz3fDLWinS7dXNMKHM
 c0WwSuTrAYedjTeC2X3xCTgBGDYAODTvIKv+9XULlf5qEUVsudTmBShFgg=
X-Received: by 2002:a05:600c:b95:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-4362aa3acf9mr81406155e9.13.1734253578461; 
 Sun, 15 Dec 2024 01:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpOtXrJ8muv+pnGwrgPQCn6Yb59VbQ2DNB6/Qc9t+r2Lb44jBmGDyLo9nCZqDjud7SytvMfw==
X-Received: by 2002:a05:600c:b95:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-4362aa3acf9mr81405835e9.13.1734253578104; 
 Sun, 15 Dec 2024 01:06:18 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706c82sm103757765e9.35.2024.12.15.01.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 01/13] target/i386: inline gen_jcc into sole caller
Date: Sun, 15 Dec 2024 10:06:00 +0100
Message-ID: <20241215090613.89588-2-pbonzini@redhat.com>
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

The code of gen_Jcc is very similar to gen_LOOP* and gen_JCXZ, but this
is hidden by gen_jcc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 --------
 target/i386/tcg/emit.c.inc  | 6 +++++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d729e68c98..298842d46b6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1846,14 +1846,6 @@ static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_jcc(DisasContext *s, int b, int diff)
-{
-    TCGLabel *l1 = gen_new_label();
-
-    gen_jcc1(s, b, l1);
-    gen_conditional_jump_labels(s, diff, NULL, l1);
-}
-
 static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 785ff63f2ac..8d18407facf 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2276,8 +2276,12 @@ static void gen_IRET(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_Jcc(DisasContext *s, X86DecodedInsn *decode)
 {
+    TCGLabel *taken = gen_new_label();
+
     gen_bnd_jmp(s);
-    gen_jcc(s, decode->b & 0xf, decode->immediate);
+    gen_jcc1(s, decode->b & 0xf, taken);
+    gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
+
 }
 
 static void gen_JCXZ(DisasContext *s, X86DecodedInsn *decode)
-- 
2.47.1


