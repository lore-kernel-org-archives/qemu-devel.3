Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C683E83071
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSE-0007We-Ud; Tue, 03 Feb 2026 05:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRy-00076U-Fq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRr-000288-Kd
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113749; x=1770718549; i=lukasstraub2@web.de;
 bh=uuMv53cnY/NF58kfbB7HunUnASLW39jEamv0bqglux4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YiobyogA1g5B5fSdqyRk9ezwP4QQZoPKvPYaScPHozQEz2WFgdJZTK558lyZTf8o
 S8QDKjlWwyD6PppDNh6JHUyN8D+tgJluJFk7blqxH3OyQFfkHOGX3EEgTvUuES0I7
 L6K8us1TV3hlZ3BFNBeBgDRm+SzAjFINo4Zam1hEOE6S/OxNJTRIgLEZu6qMEBrli
 gEwJqQmVtEgyGsclNm65NN9pb309KQgKRWHfXlo4a9hKfWeNhFuP9er0VDynrQT+h
 6s6E6x0z+9Y82wTWjHmWZaTOSB8GFmiRbsdwnF4946pSrt0f+hI7IwdyFzmtFUrbx
 F5EYDGTbb9nGTXJLjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YJ1-1vtYAW0tgH-00FPx1; Tue, 03
 Feb 2026 11:15:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:13 +0100
Subject: [PATCH v5 07/16] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-7-57508b7389f6@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=NdyvakndV3dkeHSFzAflHfbOGlcPwAgindSd07Zzuv4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrPxFqQpFo60Uum067/hM3E1CvNoFRnT9kHn
 k/KEsipfX+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WOKYEACwJka2AqR885CGD0duJ2ptb9D/7c+3ljQnxYtTuH4s6xCGLZUO+sfpwClgM4HHqlB6xfv
 stMbeU19h+paSFB3ELOi07IJ8eFLJHHOWtAEg27mPbc3sRh59LK+AbnJlYKCObGWAkDw1VwSkdx
 N0WSKciLm4O58qjxe8mFRAY387NC9Dt9+zAblBL/UbfTGmrdSb51e05aA6r1cjrsL7S3P5V1jmL
 lE5R3lokl9UaCn/O3Kj2RqHyHNso6d7NalGBiY8OhRtiMQKoP9vfnBq8FiDLE6CIpVf6/0fPAZ9
 K/xmvP+sZZKYC+is73Zfqvn+x12r72xXQ5R08kxaqX70BmQ5V9DeLJyy/FhNTC+WPsYFjDd7pcW
 w1XqNDKXi0r7RULpojRoidHGmwkjv0jWKewP7WXzt+43GOSEDkKsefEDFmQeWG0qvrLuUfNH4lp
 hU15HQZybLIZXn6oYgT8wAxvoy0Z0ju+3pVpCv9+fIASx0QRpl8JUIhUTVXxpiL+9YX55/3sKeX
 d3wadW+TntwderewcbJpyyChC22ApBMgG8bABRDv/+r4KmW5hf7FWVUuEm/OUAVJEranuGSonVk
 9klowz0J2zH8TbKLUPAyBG2c+F/5mB3lD0nwdEpf2jPTV/MEWXKTRUj5bKwtFd8teHT41paXrFJ
 rkXc3VIoOUsSuqg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:S8aXqzEzz0loVsXB4DwqtHhXw6leNbRL4URKHveU93Zoh9TBdks
 U+P0teCYbdrJRa26fvcSJINISl6HG6UmwUGfGolM2F38+eJ8PxPvPt03B1osE6gTuWXMmDb
 x6SODfUF7x1XQRfKXZzvE2B1DXtBZZyfr1AOSdNI/YpsTtEAyAsPjAHsdGsfv+rXLVMyBUU
 4x2h+Rf3EgfF9sl2qBguQ==
UI-OutboundReport: notjunk:1;M01:P0:KF7o729modw=;0wqk2h831MigMO2LGJ6HAxSlsIb
 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
 D8DD6iGuB4fMd6wrj2osEab8MloT2J7gNRWF5L
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5


