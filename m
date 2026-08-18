Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA167C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNbY-000523-21; Tue, 18 Aug 2026 13:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lipovyjakub@tillia.cz>)
 id 1wwMvW-00043i-Ic; Tue, 18 Aug 2026 12:44:38 -0400
Received: from m1-out-mua-3.websupport.sk ([45.13.137.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lipovyjakub@tillia.cz>)
 id 1wwMvU-0006zB-QW; Tue, 18 Aug 2026 12:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillia.cz; s=mail;
 t=1787071474; bh=6RFZys3HrvAaThgRRsfI5XljUc8KOQv8gu7cbeOhN3s=;
 h=From:To:Cc:Subject:Date:From;
 b=ck3FZVkZx5JCGOhaWQaqfElgUazbjHFcSMP1BpGkaGKGEHb1HoF9jStvzlPCdIG3U
 Npl0ffG5nixjin3a9gBRuhDAcrlMy3OPP8OnDv4OALiby2l7JcozR37kcUB8nasjde
 6u703diD0DYoiqUlyIGq42AVDGOKM3XGfdbNdpx863AwzCncudVIEIouWMa9OfXEt7
 tQNTuNYNZS5MSAMObbhP0YZc9b5rlzJh32I4fQGPsGVKchP6ZUqDGYdVwsD2jTMqmI
 BVrm1T2xZEUu6QeEwgQqo9brj/wpA3mM6olFML4uCX6T7Cm0oM5XmtVUTnlZBBjv/3
 47yH/5ifOgJ+w==
Received: from m1-u9-ing.websupport.sk (unknown [10.30.9.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by m1-out-mua-3.websupport.sk (Postfix) with ESMTPS id 4hPbC61zv5z1Xtb;
 Tue, 18 Aug 2026 18:44:34 +0200 (CEST)
X-Authenticated-Sender: lipovyjakub@tillia.cz
Authentication-Results: m1-u9-ing.websupport.sk;
 auth=pass smtp.auth=lipovyjakub@tillia.cz smtp.mailfrom=lipovyjakub@tillia.cz
Received: from 0.netbird.cloud (unknown [84.242.101.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: lipovyjakub@tillia.cz)
 by m1-u9-ing.websupport.sk (Postfix) with ESMTPSA id 4hPbC53tnqz2gl2;
 Tue, 18 Aug 2026 18:44:33 +0200 (CEST)
From: =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
Date: Tue, 18 Aug 2026 18:39:58 +0200
Message-ID: <20260818164414.245189-1-lipovyjakub@tillia.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Out-Spamd-Result: default: False [0.90 / 1000.00]; MID_CONTAINS_FROM(1.00)[];
 MIME_GOOD(-0.10)[text/plain]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[];
 ASN(0.00)[asn:16019, ipnet:84.242.96.0/19, country:CZ];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 HAS_X_AS(0.00)[]; SUBJECT_HAS_EXCLAIM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]
X-Out-Rspamd-Queue-Id: 4hPbC53tnqz2gl2
X-Out-Rspamd-Server: m1-rspamd-out-6
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 2166
X-purgate-ID: 155908::1787071474-BAB9B1FA-70ED95A9/0/0
Received-SPF: none client-ip=45.13.137.12; envelope-from=lipovyjakub@tillia.cz;
 helo=m1-out-mua-3.websupport.sk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:28:02 -0400
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

In 64-bit mode, loading a null selector into SS raises #GP(0) if CPL = 3,
or if CPL < 3 and CPL != RPL.  helper_load_seg() only implemented the
first case: the null-selector path never examined the selector's RPL, so
a null selector with non-zero RPL (such as 0x0003) loaded successfully at
CPL < 3.

This was caught by test_sreg() in kvm-unit-tests x86/emulator64.c, which
additionally fails its subsequent non-null check because the wrongly
succeeded load leaves 3 in SS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4204
Cc: qemu-stable@nongnu.org
Signed-off-by: Jakub Lipový <lipovyjakub@tillia.cz>
---
All three SS related checks in x86/emulator64.c's test_sreg() now pass
under TCG.

I have not added an in-tree test case to verify this, as this case
requires CPL manipulations that tests/tcg doesn't seem to be able to
easily do. The behavior is covered by test_sreg() in kvm-unit-tests.
Happy to add one if preferred.

 target/i386/tcg/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index d5c174b7fd..36e3ae3b55 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1411,11 +1411,12 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
 
     selector &= 0xffff;
     cpl = env->hflags & HF_CPL_MASK;
+    rpl = selector & 3;
     if ((selector & 0xfffc) == 0) {
         /* null selector case */
         if (seg_reg == R_SS
 #ifdef TARGET_X86_64
-            && (!(env->hflags & HF_CS64_MASK) || cpl == 3)
+            && (!(env->hflags & HF_CS64_MASK) || cpl == 3 || cpl != rpl)
 #endif
             ) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
@@ -1439,7 +1440,6 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
         if (!(e2 & DESC_S_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
         }
-        rpl = selector & 3;
         dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         if (seg_reg == R_SS) {
             /* must be writable segment */
-- 
2.55.0


