Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82068E8307D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSD-0007UM-OW; Tue, 03 Feb 2026 05:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS1-0007Cm-Dp
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRu-00029l-5F
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113750; x=1770718550; i=lukasstraub2@web.de;
 bh=bHKDgq6h+b/M7EhW61MaX0Cm/kdRU0pIx1l0id9k6Us=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=d2Q5hUyApbiqH9w44lLdL5OSINHMgXksMF0aVa86Z2wjzDdMV5K4Rph4F7wMcxmK
 m5Vbai/Np1jCSEjYWvnif6TSXnobcjJTYI+g7LKkFkHdO2TIw0uFmaQqWtArGK5nj
 RfmWtelCX2PM1tHl4371RthcvnmVZi97PLWx9Os2z+qc0zezrZXAk3hZAR1W947Xz
 2CifcVSz7Quu72O4h5TgNVBw2nrEiUZN1v0feVDEdvoWbrFf65gho8JuirPGl7HCK
 THrx49ZFDmYU1b8d27WS/qGQtGmxhdJzM3nKfcLkfc6kvXVeCWcevm8AeubK30ZfR
 9B3YAD8e6KII9lsgmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMEW-1vJwtk1JLy-00oUS8; Tue, 03
 Feb 2026 11:15:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:16 +0100
Subject: [PATCH v5 10/16] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-10-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=F9IEy+4YXw0ic4hdA5SnWxv36ftHLR6BjkCOtPAGjYo=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQWj8+ufCeheqFCQH3VbQFgN55wJLfCzVFF
 +2UWP4eV/OJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WCt5D/9+2u8B2PUzBItFP5yGH1nZ5HnmxCBDRUyWi0xSskME2eZ19gPuXn/7KklPFxr5MB4erLD
 C+d5SBsoyCYEcFx9ghR/O4yZydcATjbR3qMTDliixtaeU1OKtG4ZGtWd8+/U3dUZK6UkZUd4+gH
 7oqkxu4bSRUswNBVuZhrjC/LJk6qOxv19srN8Jf2UzSmiovINKmOGMXAvnvL5VaClnxHNCkPGI/
 aVOfJJIN/JfH3G0OJHRYwqZ36PDP6PKTDvmyLPk4ZBK1grflQl41ar2vQEFyvXQFex3/QTUUB6t
 jqv41eIqF8ZQz85F2A529bC+eA47M0KpW29KEkSPVcLekaVkJe2qs5H1fRErhEj6mButqNJWEXP
 HGKOrfbcsbTrKtd52UJxkH+5gdwbsd3tSO+CkuUu1ZkRWll56mwhD9uaey4zFocDQnN8MTeSM+R
 9exscmANGPPLX72wxzRewVzxk69hlr/Vm3eR3uzEK2ADryleldCKfLYgipGhhhZQ52EaVexDSm9
 dGsB+scethVRLzwiRozy1AHTfsfP5ja2C55PBNfEhfanEOUCiPWG6QbdqyfJVV0eoUtJEQoCM+V
 s+mPL+tkDmWGAshF4nzjszGca97sxESY5CL4fqJP4CFuSU/5AyeZFQ0nK1vZkIarNdxv1TnrZ49
 WkDH62OYiNqk3bQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:IYaa/LF1142Gv3NBbRGl+11CvHXARIup4qu4Ay/+ig102xjpJDl
 0yd1F/IT+QxmASetrGp6maR22pjYqOas8JqDCePz5xr5oCc8udDb5Y3hZGsh81WxleCDRi/
 eGoIcPKvNWTKWk1M2K5YLNhsxJy7Xtm5N3aqQzFGPWiWdkNM0W8nkl2juulzbuTGBhxi9a5
 YDcZvOXeU1ayo/qWSGv+g==
UI-OutboundReport: notjunk:1;M01:P0:nGZeBb1o1qk=;CXVBtDPe9YGxcMtnUYOiMnV7oYx
 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
 F0567AkI=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 8dfd39b035c48590fcebeb20459f01fb37fb67d1..d3534d1a32ad82f02101ac092e=
bf818a0caee6f2 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -947,7 +947,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index 5515be1bf305b40ba0b590136df18a53451872c5..9e3f73f27766196ea8673bf9a5=
8c97d5b8b1672f 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


