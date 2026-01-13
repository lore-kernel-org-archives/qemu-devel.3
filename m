Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CE1D0C854
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLP-00034g-SH; Tue, 13 Jan 2026 06:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLI-00031g-4Z
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLG-0008Pe-Jw
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWfkiUEs3L3eRoPpvKnE7WI6HuZbSNuFySWoG+pF2vQ=;
 b=AZ0CSl54v2TyfSfVRPJnzaPrBQeIn98uXW93ZnxepI9pzjc472Ee8UFgD3lOj8tg/4ZtrL
 vAJGpsFJSTmjvAmvFc5g/+4pN3bTeqoLRtuMTkTqXq+EkcaoMGTbkrtr15Zy+kihEIgGIV
 awisN71Tvcj0OM8gBRyzp6EkHu7YXQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-G6j2cbXKPPuIrhMloB2kBg-1; Tue, 13 Jan 2026 06:13:40 -0500
X-MC-Unique: G6j2cbXKPPuIrhMloB2kBg-1
X-Mimecast-MFC-AGG-ID: G6j2cbXKPPuIrhMloB2kBg_1768302819
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so74284495e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302817; x=1768907617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWfkiUEs3L3eRoPpvKnE7WI6HuZbSNuFySWoG+pF2vQ=;
 b=Z3njKmGBV4/MWm1Q0ybkhca640X5e1k2YrTCNmkdzW7cxOPlQ95AoVS2MskDzYyFC2
 jv5A2c61PmNrA4l7rd/CloRtrU/RwyuS+PMhZc/YaCTwUKBKWFHTf3h8XM9lWMACfyi8
 LzoqMrOtku1IwxXrBCDt/zI6D5MGbHdGnclmvo/0INr1waX8Vwn0r4jcE1MT1Bi4a1Lw
 MKov/DoL2F8zg0mnaH6WZg+/OSs5SDuwOLVDYztStgDNZ+ZoY9W25Lr0csrkmVuvjkP3
 Pw5rGOE8EyLEb2o3siWe8qZ3c9tf0k+r/PiKa4X8Dyc2cIuYrIhMTPNij7ScCrk2L6F/
 1jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302817; x=1768907617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWfkiUEs3L3eRoPpvKnE7WI6HuZbSNuFySWoG+pF2vQ=;
 b=O+aph7en54uOyhpTpp94wFmDRKxCSGoNuSd+uGtQofFSKr9GCeOZrzc1vB5zrmV1DN
 BEHk7Mq+Xe0Gd4g498YtMQQSynZkgFW3Hd8X2st/RN6EoAiYDve+UyyJnpHAPm6gVIMa
 XUGLPObAYSL6gXcW3CvdlN3HxUrAtVLnHmD2V/QeQVONhpZmkTXBvAZEoMCh4QimkTLU
 iFBxLaV6/Tct8j8+6pgc5Rhmx1ZFrwgzFngKid/NXahUr1HJx1n5hr0W+/rMscrqennE
 UsPOYG3LYSc6zIbhZiFsYXlE02xx+4nk4i1w/wlKRAL1Sel74iDAUmHJOVvR/C9OPPHZ
 Ja2g==
X-Gm-Message-State: AOJu0Yw3IA8lEdBA/Gh6iMRehThRjY8hZaesWqOgTOtLm7EivJYTg7m1
 eYLKcBXBGaEs3SgO4GrTWc6XAKn2eczgM/8ukDHAR2XQe/1RdcNn7hPFha/+cd/KrXe0uV+gh8k
 7xnge++aj+Sy4/ZYyk+Qdkfnhz5T56Lw7viKQHYIui+1hSzQ7xrcIpnF6lAO9IcdnXs7FvVNp55
 S3h3O0RhCm3+nBX7fSnr/zmC0dUjO5vyIIDKc1pbbw
X-Gm-Gg: AY/fxX699viOQAD5/Hvr8FrOuW+5Ijz1aB4JYjqUzXBbx+bQDGee/tanSoMc0wFcM03
 gJLjdcebVu3TvvsL6SXDiLDoj5mC06P3YWT01crIbV5ad8AmP7BbpH/Nq7P2a+u7ypxyNXkCis1
 EsyaCnQnJB4YIzRC8i/q4mIzHewD95pmtfStOMaAosu3/1Xc5P6IorD3k3/ix9A+rkJMebHfSdM
 9vZ3hc2uFOzHrKHcq+vdt7v6eu5TBQUe8vOwSM2ou2CezG7qo8nDQN0NQhGPkPNTK7q9bV5lzuJ
 gwFvvsjaBglbDFKEiEzT8BS15AYLBJh1set9Fkjn4j8WyxrFBw+2aywHx5KH1dmNv2iS6KbHmwn
 wungQaA8GV56FJu0Z0F1rDHkuvKUNh2PUmfpWHdApR+7r5QxCnoM4CSQt/EsmRb6PDB8qwwihyY
 sfXFu/yWiPpTLFyQ==
X-Received: by 2002:a05:600c:4709:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d84b41b2dmr239582135e9.26.1768302817260; 
 Tue, 13 Jan 2026 03:13:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUMjJGSzu6dH3RfX76RI7SrZkwz7AfoomAvaX5nUo5a9MlTT1hS9J6k7xFWoIwpNtR9tIKhw==
X-Received: by 2002:a05:600c:4709:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d84b41b2dmr239581825e9.26.1768302816820; 
 Tue, 13 Jan 2026 03:13:36 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ed9eb6fbesm12480785e9.4.2026.01.13.03.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 1/7] target/i386/tcg: do not leave non-arithmetic flags in
 CC_SRC after PUSHF
Date: Tue, 13 Jan 2026 12:13:27 +0100
Message-ID: <20260113111333.1138160-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The value that is pushed by PUSHF is the full EFLAGS, while CC_OP_EFLAGS
only wants arithmetic flags in CC_SRC.  To avoid this, follow what other
helpers do and set CC_SRC/CC_OP directly in helper_read_eflags.  This
is basically free and fixes an issue booting Windows 3.11.

Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: e661e2d7a37 ("target/i386/tcg: update cc_op after PUSHF", 2025-12-27)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper.c | 4 +++-
 target/i386/tcg/emit.c.inc  | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 91e492196af..6ddd64fcb07 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -414,7 +414,9 @@ target_ulong helper_read_eflags(CPUX86State *env)
 {
     uint32_t eflags;
 
-    eflags = cpu_cc_compute_all(env);
+    CC_SRC = eflags = cpu_cc_compute_all(env);
+    CC_OP = CC_OP_EFLAGS;
+
     eflags |= (env->df & DF_MASK);
     eflags |= env->eflags & ~(VM_MASK | RF_MASK);
     return eflags;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fde3d669d9..e55b65176fc 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3253,8 +3253,7 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_helper_read_eflags(s->T0, tcg_env);
     gen_push_v(s, s->T0);
-    decode->cc_src = s->T0;
-    decode->cc_op = CC_OP_EFLAGS;
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-- 
2.52.0


