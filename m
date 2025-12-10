Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99B2D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4E-0004o8-FX; Wed, 10 Dec 2025 08:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK46-0004mp-17
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK43-0002zf-OF
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByNPD+9j8EtkYKgJbFGTPkBTs1AUYDB++Ljp5NI1P9g=;
 b=IGQ/JouqRuOr5FdKTukkr5xufKjcl42ok1T/2HXLOsmj9jzQSWGndGCR1Ps0RVmlj7jm6C
 1+fWNs1HEGxmBL4JewC8M5rb4VXf96JX88cDlz1JEJ97ZsAIM07QjUVzpVvZLy6cpsuGbN
 OMvrP0D/4zKyCWNmb87c8r9AANE94gc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-KQhFq4ECPmWH5iiVc6l-RA-1; Wed, 10 Dec 2025 08:17:05 -0500
X-MC-Unique: KQhFq4ECPmWH5iiVc6l-RA-1
X-Mimecast-MFC-AGG-ID: KQhFq4ECPmWH5iiVc6l-RA_1765372624
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42e2e5ef669so5233650f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372624; x=1765977424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ByNPD+9j8EtkYKgJbFGTPkBTs1AUYDB++Ljp5NI1P9g=;
 b=bxT/gFDlYRVihcI6yhXfTvJJtX1IBSf4TP4+PeMqN5Q5Ox/tVnPdRMTBObHSVO0Yt9
 8KPRwXiCibcG84PgSA4bhVZ/+3MOVMNfB6ZZnxgP3fdLib8M53dVqe2meaDZwkdBC+0g
 Sb4/PpmI9hisjMo+n8foUISvTKGVnGXkHpliTFM6SkoBoTemUw2H16U69aze/SlM1Owi
 77Y3bRbS/kOLn1jlQowk/uCMu4sGMueS4Fuspg832AGFR6ALQeHbjqccIUICuSW3kImi
 zurg/dxa3P29u2bINpR8lVbW30F7tPxKdh6Lp2+GSfhN1ahHq+twrilJ2lvwnlciVCh8
 /Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372624; x=1765977424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ByNPD+9j8EtkYKgJbFGTPkBTs1AUYDB++Ljp5NI1P9g=;
 b=V2axlfQO5pC7mInDg5CLLY8P7fkmzV39B6QbYoKS8Z9i/hs987Bm5dowmve9gXIGMj
 23DbecQ189i9XOJTFKf+0+WvZz1lOnUUaZ14/TQmEXmHNa1BQwBKITepwHDEaxONElzP
 urc73zt0gcO2vvCnSIL/gmfbWHUt4H97Vf+7EzSSjZ4VqQQJ9YP03ujDl5ob6RdO87pf
 /slFfyUqIJbp9V976tt7O0fJ+Vq9yEJLOrZ7JwLuLufrz7p73mCiYZNPsRe6F6leDceA
 WsnvIAOrjBlH7kzIYfvYc2QKSKCQjjZqEMGne8AyCgo3Uzc0qOfRLLpvA48vqwdcjGPH
 RL+w==
X-Gm-Message-State: AOJu0YxoXFKa7OfacAJYRPhI5UJtnHn40+OzVLjfBCgxIyn1bo6dauP+
 SXcqRyyRqmeyIpUXd1pzMOwOXO4zsUJBTu1iySkkvV5uH8+GRSX+GbWHcPhPWWtKXjWxVqYSL4b
 n5ndS6jTPYXRJfznItsAVDw0CSVvnd8ErQQZQ6BxsfD0L5pRNTwT+QjHy8FsBd2dP919ilytOXk
 DmYLcL8RhYbSbv+3KLuuCHtdop4sIsESchgRCYBJFg
X-Gm-Gg: AY/fxX4hf9CWVpncdY69xzejUtPAp1rQFmxJb+kaY/CJN6Vu5Cc8/8XzRkDmjOTZNgI
 vOfQcKgeTKKjbEWAunIfHlSE9sfFQMBMlqgsR0euUJoUac+LWGZhPbbenpmCo3d+qCxDJSHq2LS
 MsBJtX5GE5Aqq0DWcV/CR4stuH4qPbwNYVSd/vusxrXJZ1YafrLklManoVPqhci8XxWcAFMNpLJ
 0Nev6ijROIDtPNyIIFu0WZqIQ2SMgLID1qIuYLxN7adPho6gweWNG6IW0Rm1luhacYQ87ni/6Ba
 qESlOHuoVoXxb+yJ2WPIDaBN9ccG0XnaTwvye3iP/2yPa3Ejm/vC1xG+optlV2v7zyi/ydPO8PH
 m/9e4Rb2L5jA5wiWE/lpyYfctRJAIwRsj0P0pS8jr4W5rDOQSl2MGK1+AY3y+JRwgVdXVNlFsXD
 hZzYyH1/13KfvwWz8=
X-Received: by 2002:a05:6000:2dca:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-42fa39d4044mr2615606f8f.14.1765372623973; 
 Wed, 10 Dec 2025 05:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqkq4qRnapYcG4KqtU1jTToBQBEI21E5d/KPNZz6F6Lt3jTN7THSbi779k3ayfq1RsZdTF9Q==
X-Received: by 2002:a05:6000:2dca:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-42fa39d4044mr2615577f8f.14.1765372623496; 
 Wed, 10 Dec 2025 05:17:03 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm40271879f8f.28.2025.12.10.05.17.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/18] target/i386/tcg: mark more instructions that are
 invalid in 64-bit mode
Date: Wed, 10 Dec 2025 14:16:39 +0100
Message-ID: <20251210131653.852163-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c9b4d5ffa32..213dbb9637c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1698,9 +1698,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xD1] = X86_OP_GROUP1(group2, E,v),
     [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
     [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
-    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b),
-    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b),
-    [0xD6] = X86_OP_ENTRYw(SALC, 0,b),
+    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
+    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
+    [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
     [0xD7] = X86_OP_ENTRY1(XLAT, 0,b, zextT0), /* AL read/written */
 
     [0xE0] = X86_OP_ENTRYr(LOOPNE, J,b), /* implicit: CX with aflag size */
@@ -1834,7 +1834,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xCB] = X86_OP_ENTRY0(RETF),
     [0xCC] = X86_OP_ENTRY0(INT3),
     [0xCD] = X86_OP_ENTRYr(INT, I,b,  chk(vm86_iopl)),
-    [0xCE] = X86_OP_ENTRY0(INTO),
+    [0xCE] = X86_OP_ENTRY0(INTO, chk(i64)),
     [0xCF] = X86_OP_ENTRY0(IRET,      chk(vm86_iopl) svm(IRET)),
 
     /*
-- 
2.52.0


