Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF58C79FBD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfB-0001eO-Ev; Wed, 09 Sep 2026 11:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfA-0001e9-F5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kf8-0002qU-Jn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud/RrzlbqKmU3yuBZt8NK/ipDXjA8gSEIDTtqvRRSOc=;
 b=Qt7QO7ja58cJqI+Vgr5GIkHoBA3AuCpPk2oAuMQAtrjElWpyOx8PaGhxe4/4Dtb5eSbV5y
 WadLOiOHC9D8N093RuPOwRkjIDN1fZQTbffi2J9TxO0XwgFLqeOrp5CRGvLctRpCxxPBe4
 pbPD7NlknCKb+5Mragi1eL1TlGMjyx8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-kcoNWy43NUiFp2BlGsq6cw-1; Wed, 09 Sep 2026 11:56:36 -0400
X-MC-Unique: kcoNWy43NUiFp2BlGsq6cw-1
X-Mimecast-MFC-AGG-ID: kcoNWy43NUiFp2BlGsq6cw_1788969395
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49ccf17d3b0so43873975e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969395; x=1789574195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ud/RrzlbqKmU3yuBZt8NK/ipDXjA8gSEIDTtqvRRSOc=;
 b=fArOOqX3ljdR5pjFYIJbABKJCpTF5RJ7pOxyNqiYjXsFDj/TJiHwm/Q/8bnlYxjeFi
 RSJb4pBTpTEp5+pTk8Yv6I/SDhaOeeFCA0bzyh5GD/wncX/bMtv+2ENAx7kmwm92HjB3
 QjVE+3TXJXvy7n6WysyLCkAgRehnZoAl2Ux/z+cXdlbSNbl8Ejo92xoWjk9uMFpzME60
 oMHW1K3HHbxrXZxZDHDUoIaeLx2Q5zcv+3AHoBHhnN5HBMTO2JshOvFWRBk8dsR9M0cT
 bAjFBQ1I6Zzk7MD580wgN62kvbaF2+C7zbgg6TlZ56hV+JUU+tv0UOjQZcnUapMqeMcg
 dpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969395; x=1789574195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ud/RrzlbqKmU3yuBZt8NK/ipDXjA8gSEIDTtqvRRSOc=;
 b=DJ5/rJLHvvbXmYSt+rthc5gMJYcoWbMWTz1NL1QlRA1y8GAfn8tjh1MX3qEewWCUBX
 rHtQkhWzgAg5SDUAGaQm6tmFgOTbBBvKGtcOAI9jed53knam2vFB/bKl7GEe1giR2IRe
 NCHtRBGrgy1TsxAO77doNbtmAgNLkVQUZUMiTQPKbrLxHV5Yv63sTQ6XZ70DERWLZDAz
 BBnkdQlQSi8YHDrmLDWbmRvlVyaA9YSNZeJ4su6p/plQfrjJFLXSlAdeJVmcKdobDAhC
 mX/FnPw758KC9wnZyFoHDSyCFfcZRj72RPvMNMEXCyzPgvBaQli5gZGYZI21AmjkzNNk
 AvTg==
X-Gm-Message-State: AFuF++ly7QJdQVdh6aQ8Pqbd7Aj17mGWN3wYPtOq8qNfxOK7mRzCXd+0
 vC2yy5m/dn5sOisuEdokA3lnKNpadBlOOUtgKkpsHYTVxO6tFQJG7D93Ud/fIRjKlr2FMxh924b
 oZ6uyIit8Ye3RgQyoPCU6+vi8ilUV4K40eZOHnM+XTiyxxGYgnjIQkw+2AXQTSUftOwe9QO7IRZ
 XR2D1HgdA+08mhNp4f042i1Zhyo4Ue4s3nPNSBOHfU
X-Gm-Gg: AYBFou2y3J/71ylbauISKJO15LHJ30/dkpEiid7oxqaTv279f9ph8wjatYNHVSFrygl
 HrPOox8ueV7J7aDXpgNUtcPyorx82na2nxz2/rOTAeeQ8UKeNA6wP33JuDxmwtUN7PXxlNafde1
 P4lhsbXsWD8qr8FNtY2GNjU66iwkq+KgYy1kcluVn+oseLvPN474y+AnkBj/qF9TtUwDbPA5OoD
 i3yuI9+jtaefldCGpvP7uefRiUDqIfmq1LfIMqwM0gSqmFyBkGg7sh8fkSfspFf+huV9uZXLXRi
 vsMGjWSoLECXpHjoprsuwOziXjg+ENkKsTSVxAitB5rt+eDLaXKAWcstAHp+hI1Ur8Vew0is72S
 PYeLoef/cnA8V6s1ozG5b0yB/sXg2GVLpxqja15LQD+Z70M85DvaCa0ivhCeRFmrbng==
X-Received: by 2002:a05:600c:c491:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49d1f368530mr96562335e9.13.1788969394857; 
 Wed, 09 Sep 2026 08:56:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c491:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49d1f368530mr96561665e9.13.1788969394342; 
 Wed, 09 Sep 2026 08:56:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e60bsm61700025e9.0.2026.09.09.08.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>
Subject: [PULL 02/12] target/i386: clear C1 for all x87 compare instructions
Date: Wed,  9 Sep 2026 17:56:14 +0200
Message-ID: <20260909155624.1082893-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The SDM specifies that FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP/
FCOMI/FCOMIP/FUCOMI/FUCOMIP unconditionally clear C1 in the FPU status word,
regardless of the comparison result.

helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 only cleared C3, C2, C0 (mask
0x4500) before OR-ing in the comparison result, leaving C1 (bit 9) at
whatever value it already had. FICOM/FICOMP dispatch through the same
helpers after converting their integer operand, so they inherited the
same bug.

helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0 never touched the FPU status
word at all, so C1 was left untouched by those too.

This patch clears C1 explicitly in all four helpers, adding the clear
into the existing fpus mask for fcom/fucom since fcom_ccval never sets
bit 9. For fcomi/fucomi add a new separate clear.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4378
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260828082235.128360-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 32af8b79f4f..56fb94c957b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -534,7 +534,8 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -544,7 +545,8 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -559,6 +561,8 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -571,6 +575,8 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.55.0


