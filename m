Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E296CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIK-0006ea-Po; Wed, 17 Jun 2026 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIE-0006cx-Vh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIC-0007e1-K0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/m8px2SzlRS8AyDVnogUZnSnnrVsntNilzOMSCr4pY=;
 b=BDUdpeMymyGbvCbacLZL+00pMZd2/7P57gU1rmPTYB7eE9IKSzQv7vwuHmo2NOytx5XXRC
 vSbRngQgeiEtwy8zNYG8Vs3xMDriEbDbDrZqPuzAZVsaoF8fhBvUA12v/5nSyRy0C+im0b
 MZMvqxhhVB1KP1YJriUgajxmUeQBESc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-H5o8e02WO-uPXkIb85vQag-1; Wed, 17 Jun 2026 10:30:58 -0400
X-MC-Unique: H5o8e02WO-uPXkIb85vQag-1
X-Mimecast-MFC-AGG-ID: H5o8e02WO-uPXkIb85vQag_1781706657
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so56227665e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706657; x=1782311457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3/m8px2SzlRS8AyDVnogUZnSnnrVsntNilzOMSCr4pY=;
 b=K6NxZPh1m75pjtiIBABUCAiK0elSUwhhJ/HroHTnaE0iYt4Ai0kGyLdCs766aKdq28
 imV+XV06ZgjH0kmYnTf2V86c6KR/BqeXXUiXz+i6vM4smYXBphNJ4gUPWNkou3ReLLmr
 MyCuAfqJ4SNqBkLxQYmBKKRxMPd3eou9XyaCQHw39eEYh/ICyqJQ5Kgl6d9wlHXjVsm3
 7sl4g1+Y/WSXL7G72iMcJcdkr2/h8FgA69KpMMjgOgl/x29uV+lPq2hPpBbKF1+j6EvS
 Qsbn0WmF5yXYoOXFr40pTgwmPeLGcljc+cqOwUNGZcbL5N7hBTApi9IdXZf3Hz5fES0M
 8/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706657; x=1782311457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3/m8px2SzlRS8AyDVnogUZnSnnrVsntNilzOMSCr4pY=;
 b=XSHH5tSgu9lqyrGd/KEs6+xc8heKbp1ojiD9evtSprYYks02Ks/ZuLKuDDAS04PyN6
 jnxLQ6c08+2u5TZ0T+h3SHTf4IzmokTe178MMlbXvM10zd9yqvNMHID0sUe2PsH5K4v2
 7WpFAtkIY00yxw3raWYW3ppMzjvM+g6UUmegu0D/Dd+NJ+4bWZ38rkwVUpgwCQel9pAe
 R8u8AF28i+Cf67E09OkQDe0fYP6XvKka8pyfSw/6/8btgHhqB36WazUm4NZr1wphQLvz
 +lat8T/NbTmgaSML8Ri5yhK6EG0/QPxtEmuOdkKD2QHAPXm1YsXOS51s5KP2RyFeCW/D
 x2Cg==
X-Gm-Message-State: AOJu0YxgxyfubJRwuOV7EdsvVzO8lBSSe5SLAk/PfVSckjdVgoIkz+nu
 r2mhLprCgbciEIxHZpTikpDm/Bx589FzC5gwxo/nVxQbIu+5NqnahsnRF2a3XbGTRKjAeWjY23l
 0hpw4jgjk1HwKawfzhlK1jeUQs3+R3gZyoo9zo9wkRRA1JM6+WbmfWlGXLehc4yyBahX6mutRa2
 wlmn6THHvSiUfZZ4nVuP/nAiVjcQQARjZ1wSZYUk3T
X-Gm-Gg: Acq92OHpnntQ7OluC4lFbgy+QyUc81oKrCh5di6M6yg1MO227vhLB/A1b+N4+f5yJ7p
 TRcWejLVcIu50yqH+cauBuZ8fUQAKrnl5GF0hAMsX5d3bL07DAWfRYJeLqOEN1Gdxu2VYXh3EFF
 85ceM2j5SgnUuYBoA+rWQ2hrd6mtgcgExrJVNAFBmN527rOoZ80obZFhuPG4rY/iZw/5l3Sxjfi
 gRgCT5cc84uw8TQwbxkg/TWRLw7jnTN7icFUxyf6Yx+5kRaZoXi66XSzrp6YN5WPJmsH00DeTSL
 Og+zAn9dpn6SKs+p2wkLj++kESjxJtRiYC4H4LDQAS4D9wBmmktum+QoETZa55GIOnwpmaKQtm2
 XveyVZGOA+ATGDWiszIIsbeAW2A07vWllddcI/ztu53adG5pPNA0qXXX/L3InxYLwVDSygSyYYn
 Yf3l0CqhS7HbeCcVKT
X-Received: by 2002:a05:600c:34d2:b0:492:34f5:94cb with SMTP id
 5b1f17b1804b1-49234f5956bmr39373865e9.26.1781706656999; 
 Wed, 17 Jun 2026 07:30:56 -0700 (PDT)
X-Received: by 2002:a05:600c:34d2:b0:492:34f5:94cb with SMTP id
 5b1f17b1804b1-49234f5956bmr39372825e9.26.1781706656318; 
 Wed, 17 Jun 2026 07:30:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923756ff5csm7663045e9.0.2026.06.17.07.30.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:30:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] target/i386: add more easy cases to gen_eflags_adcox
Date: Wed, 17 Jun 2026 16:30:33 +0200
Message-ID: <20260617143046.445322-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

prepare_update_cf() sometimes results in CC_OP_ADCX, so this
improves a bit the handling of BT+RCL and the like.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 8eca66b6967..83c889cc3b2 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3332,17 +3332,21 @@ static bool gen_eflags_adcox(DisasContext *s, X86DecodedInsn *decode, bool want_
      * to be followed by rotations within the same basic block.
      */
     switch (s->cc_op) {
+    case CC_OP_ADCX:
+    case CC_OP_ADOX:
     case CC_OP_ADCOX:
         /* No need to compute the full EFLAGS, CF/OF are already isolated.  */
-        tcg_gen_mov_tl(decode->cc_src, cpu_cc_src);
-        if (need_flags) {
+        if (s->cc_op != CC_OP_ADCX && need_flags) {
             tcg_gen_mov_tl(decode->cc_src2, cpu_cc_src2);
             got_of = true;
         }
-        if (want_carry || need_flags) {
+        if (s->cc_op != CC_OP_ADOX && (want_carry || need_flags)) {
             tcg_gen_mov_tl(decode->cc_dst, cpu_cc_dst);
             got_cf = true;
         }
+        /* fallthrough */
+    case CC_OP_EFLAGS:
+        tcg_gen_mov_tl(decode->cc_src, cpu_cc_src);
         break;
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
-- 
2.54.0


