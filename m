Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5619FE6F09F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 16:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY5O7-0004Gv-4y; Tue, 23 Dec 2025 11:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vY5O5-0004G7-RP
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vY5O4-0001W7-9D
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766507847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c2ocaCI/da1r6BOrJmdNaVSl00ID2evj45IIA8Xhpvs=;
 b=Hz5scgajVDiDJl2X+w4bV7RhxXPMBGaRF4vvKMHuwqF8Io2cP0WOfH8dndRGtWzcRjiFwj
 qRt52zMSt6jIpyFbrfg/0jniB/co0m9Cw4DoLZQpe76682L4CCR6yuQ8n8lv8qUumPnAn9
 VW2bSZ5NAaaxy+B5eY/yt/H5Z3Lk/XY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Z6GSF6VVPimPHx1wnBvmqw-1; Tue, 23 Dec 2025 11:37:25 -0500
X-MC-Unique: Z6GSF6VVPimPHx1wnBvmqw-1
X-Mimecast-MFC-AGG-ID: Z6GSF6VVPimPHx1wnBvmqw_1766507844
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7ce2f26824so494778066b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766507843; x=1767112643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c2ocaCI/da1r6BOrJmdNaVSl00ID2evj45IIA8Xhpvs=;
 b=eOgwE32DID+FT7s0szyXagd19uCVcotGxTEfzY/S4fo8rsQrroG9uO/iaxQHLVGUQ2
 NmQWQYEsvRJ1DSIrC4UjExyFKEW6VtlE80BSo5rGLUubEWn2dUXUMxqUVeA/lWO3osqt
 diJP4u4WBG/Dh1EsAYqW0jqaRkOl4VXbryromn61a6QF6nznX2gBu8eFShin7xX87s09
 YdffnS7lh2JmY+UPPmIZmigMa3Kng7OGxuK/X9uwJNuOkJqNIsYkTRIV/cz1GYCJYpup
 BSzz+Q5HgSCI0yz5r6yO5VtwK1ktAumCVErUMqvHwunyEA17/S7tcaMDMxIqUQYyQRO+
 4Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766507843; x=1767112643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2ocaCI/da1r6BOrJmdNaVSl00ID2evj45IIA8Xhpvs=;
 b=Kj4wW5Jk+B/Pa/w0xFWk3zM8FyTMb/wsXo7y+fGg0XemDfRfazupmZpRkJS8NKIlwc
 GUwzzsIHNgFeT+yqpeZzgfQghL0/qtfijmnDuB1Z3skNn7lQSH9xeiSaKZxeGeCfQ2Qk
 JUhyiYa1QOCh37QV3IRagugZh06ntUa9PQC3oFuqJdpMVsGDjqqPhEQXL/uqFWKuMARF
 /sy04psFIl58VeD+BlzAiWfsJGkxcdRfiiB9m6BgAJvM/tWv7b8p7G2eT4KFCrQPNVEL
 AgmA4LPUNKJfM4BrJfpqnE57KnR47cV4+Jk3Y1d12LEAJWXzK/xz+9CMtbOy3z7IAgUc
 HaPw==
X-Gm-Message-State: AOJu0YwGqkjQzazy7RmX6xy4mISDnB4AwA+mUmQMGizl3yy8b8NN+foz
 wsaURd0/aa+OCeHMz/4422i9j6fQkyrDuNxFPl4TP2lzbP2ANASNOSEL1QOnVJGvCiH8gh06sU6
 BWMxSQGHVhkKK4Ofo+5apr1kuM3ORieqtFZHvLg0L6b41JUJQQsp0a1q5U+6XefJHusAOYnmLI7
 9Q7bWQDNenops5/T6r6MkoesmgQrwxrzALcCNBNDZn
X-Gm-Gg: AY/fxX7hCqI0s+2SvLjiLE8CCOKpjH4OjzAntBOY2y6sP4Ka/7oXl2VZI9A80xBWvnC
 ENN9UZ4xDGkKwdRlkO5wf5RcfDiDBA069wmXM3h6tXBDusx1kb139ZA5fd1MJUQZGo0kP+oqPBw
 1hOZB26pc2SmLI/CH3qLxiEzQsnpvDn6cpFr2Ymwi+Ib0McJExq+NFHApYY0n3lfGuSrQRJV4Gq
 vebaDZzqXxrhwhPkzzsiMJg0+cdYhHRzbzBlobGmmkxDCXBXqdLhzA1GL3l3l6fGJ2dqkc6xweJ
 A8mEjbH3G8EwWjFWn8GWr6F8PQQccNr3stiqwhmy5jm22ZkdI2i0Y9loh+2voE4xV+BGHGNNa3M
 ooJrHawCT/37omiHaYLsEmAcD49iL3bDfrVOoX/N8EDyqW1sSpHvh49e9aGpqvIyV9f1dtZnAT6
 7Q3YGwn4pFpQJA7yE=
X-Received: by 2002:a17:907:c0f:b0:b79:fca2:ac0f with SMTP id
 a640c23a62f3a-b80371da6cbmr1426191666b.38.1766507843584; 
 Tue, 23 Dec 2025 08:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGliMThg+MTDQu+lINVGPR3Qgsmf59oRg9b3SCb1JvwFvphoaGAM7Oof/GFpLRk6CXscBowaw==
X-Received: by 2002:a17:907:c0f:b0:b79:fca2:ac0f with SMTP id
 a640c23a62f3a-b80371da6cbmr1426189366b.38.1766507843032; 
 Tue, 23 Dec 2025 08:37:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b9105a9d8sm13981898a12.11.2025.12.23.08.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 08:37:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH for-11.0] tcg/optimize: do use affected bits
Date: Tue, 23 Dec 2025 17:37:20 +0100
Message-ID: <20251223163720.985578-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit 932522a9ddc ("tcg/optimize: Fold and to extract during optimize",
2025-06-30) inadvertently disabled affected bits optimizations on
operations that use fold_masks_zosa.  These happen relatively often
in x86 code for extract/sextract; for example given the following:

   mov %esi, %ebp
   xor $0x1, %ebp

the optimizer is able to simplify the "extract_i64 rbp,tmp0,$0x0,$0x20"
produced by the second instruction to a move.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f69702b26e8..c546e8910ba 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1102,7 +1102,7 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
 static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
                             uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
 {
-    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, -1);
+    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask);
     return true;
 }
 
-- 
2.52.0


