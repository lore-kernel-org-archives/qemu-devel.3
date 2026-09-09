Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B774AC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Kf9-0001ds-AH; Wed, 09 Sep 2026 11:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kf6-0001dM-RA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kf5-0002q6-6H
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJuKc0KFvrTFhfQ+lxhxg/G1C7+1PZGpgPJG8KcUgqU=;
 b=frHNi6/Peq9HvEYCD/F1hCPKuSiExNReonmCvRubEHFURYx5+EFi8pIXmnGm4cLY7exCBq
 EWwQ6f4IKLheujt5U5pKcbnPv3W9OeAC/RHDz0XE+Ro3SW0WoKv4ahnbEi70IyIAKc3CFo
 Pu99/EolWeu5gEpnl4m1x+uvrOUJklY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-wNFoCsldNzCXJQlYk3C5Yg-1; Wed, 09 Sep 2026 11:56:31 -0400
X-MC-Unique: wNFoCsldNzCXJQlYk3C5Yg-1
X-Mimecast-MFC-AGG-ID: wNFoCsldNzCXJQlYk3C5Yg_1788969391
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so80125145e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969391; x=1789574191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJuKc0KFvrTFhfQ+lxhxg/G1C7+1PZGpgPJG8KcUgqU=;
 b=ILpIoKIB9BUp6WyvBbo4B6RliNYYAtrPMgc53Z5dQ4mjo7UuY4lEdfLM24EJv3S8Sa
 w7t0EFHK5tIIfK32ENEnGvatVV8STIKP2ubn+Qq6Z1L9IHcqYovOI4RmS3IYrcSnVsKS
 o/JPTrulwUm4hG0hIGQcMiDtlvEpFvXgU8bKaPzUhx+rECb0i9qZh5kj0GQa7No/5zJW
 M7FBVmlL+mr4a//V0nSHdFr45TGDbw7d/TXSqH07v6MXxnxg2mHg7RvDOef+hGikc6ea
 y1MXnsr+w46qp4j7ytep+3t6qmW7dMObYOzO7q/jDU8fZjeVOQMjwkjClT0fhUL/3rhy
 TyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969391; x=1789574191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJuKc0KFvrTFhfQ+lxhxg/G1C7+1PZGpgPJG8KcUgqU=;
 b=Dgvt8MTwCXhdBJeSDd7JmbtfY9RH1tTL314k0qDZq2TMc24pkNpiMTlZK2F7lyEu7G
 kfebQQiYB29M3Xp5u2a1Hs19TS1YNoCzZjLxF7m+2CTlsGU+ZEwvfEpH+hWMYnBtJ2e6
 6Y1B0rNGDMCgXzGhT5+t2PYi2nMOL79trI+7jyIVkNNZXqCzOteLjxEJOsyfr825Fp3Q
 L6tVymEMNC5aji00emAyyQakr4WQQDOf1DpvONctRLQfeh7hj+jDeSgvdekbnqpGtMBu
 pd65dgc+P5t+l+Yc3bZTarnnQRYwYobqTFgBF1ILaE32NjizSSEPrLsdsaJOCkK7XERv
 tQOw==
X-Gm-Message-State: AFuF++lc7pcTtywFb38sYXAFSdOhr8d2a2IyxWkErkYA2cpsQLy6eeqd
 l0A8MnA9o0EbslFLTThHIuGVueHAGr4GQ7y6+V54E999+Mn1Hs0ccjTVWeH9vo/mEZski7F9igX
 ZXiJVUg7YknKUc1O714Vb4GD3EbVV6SEodBipXogwgU1PhBY4CCk3lHVd/O7L2qxQC26sPB1a0v
 md/kKeEM/WeJ+h5VAuZa1oDIxm4vs+g1iNQwLCDrhz
X-Gm-Gg: AYBFou2DuZRewT4l92cVvwXkoxOUsMU4wVBwGv8anEj8qlk6Q07NAM1qepWcgbB1jE2
 l9XW4oLlx9dKuin5NZBasB0UiabMZuZW+WW6YEmyvjONHexljv+RLvSoZO2JWvtAY/9FJHc9mrx
 x9RuZd0zvvpjzqCJq1ge0kQJv337Iqty+5TJMVvtdSiM5GRSsbqwGEKlv4f4OCMT+UD7Lo9s8eM
 YKDzmAiiYmjscO7GCk6NQ1srN9Y0oPoxlPHGTmTz350R4HdVqimmtG7GPVFNcx/bHn72ih7jsUA
 0J3FHZLAOu3LQqdEatXEs3w6ent5tqZCOtECTx85ssbcDh8wSHuC43jmsQEfO3y7ollR86eqcOj
 XRzBRCFcn6beORh3qJLnHCY+Oz668OHWsV8tpzAJoEgcZCrSSfUCDYNTI7JErpaXde9qaZLRWL0
 3j9RB1
X-Received: by 2002:a05:600c:6091:b0:49c:eb17:cf3b with SMTP id
 5b1f17b1804b1-49cf8252497mr329458115e9.8.1788969390801; 
 Wed, 09 Sep 2026 08:56:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6091:b0:49c:eb17:cf3b with SMTP id
 5b1f17b1804b1-49cf8252497mr329457835e9.8.1788969390417; 
 Wed, 09 Sep 2026 08:56:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm229875e9.6.2026.09.09.08.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>
Subject: [PULL 01/12] target/i386: Fix FXCH to unconditionally clear C1
Date: Wed,  9 Sep 2026 17:56:13 +0200
Message-ID: <20260909155624.1082893-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
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

From: Simon Scherer <scherer.simon89@gmail.com>

Per the SDM, FXCH unconditionally clears the FPU status word's C1
flag. QEMU's helper_fxchg_ST0_STN swaps ST(0) and ST(i) but never
touches fpus, so C1 is left untouched from whatever prior instruction
set it.

This patch clears C1 after the exchange matching the SDM.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4399
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260902085424.148650-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa1..32af8b79f4f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -519,6 +519,9 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
     tmp = ST(st_index);
     ST(st_index) = ST0;
     ST0 = tmp;
+
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
 }
 
 /* FPU operations */
-- 
2.55.0


