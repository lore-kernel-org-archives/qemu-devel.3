Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA12EF0705
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWS-0000hs-IM; Tue, 10 Feb 2026 11:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWQ-0000gW-Tu
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:30 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWO-0006wl-QB
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740603; x=1771345403; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BjDJ5Z+UCLreJLsUcQkTuq7Xslz7BIJWevG6ONPT4qxDEH+r6HXcIsNZfk5oNLnm
 ja3ReEwWOlnqnCUKsH/wb4nTjLn57uowFGN+tJlozC9rYhp3WcJHdkGSqvuy2ge9e
 e8/7Dh6uXMm21YVaNW2a3w8MFq133nlJ5uG++caGFo8TMGYQ+j+YdA2U1K8VOxvgy
 tB1Kwf36WGg/8d8zAD724Epq40rovgixaPxGDh9/A1Ql/vTejLejYzIinNwWuUld+
 1RLzQ7Xng2MVAjg7hAsKmUlhRJQ4Y0w/bC4GFLUQ7GOMeaxnLfbM3WXCJYbHjZHb3
 IKpMUykPrGzbyJS4ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1vZf6m21Bz-00yS7I; Tue, 10
 Feb 2026 17:23:23 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:04 +0100
Subject: [PATCH v8 06/17] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-6-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3BiDi+NRtgYxyWWvnTxY0GxAP/z2tiZWWc
 uHLOSMVhA2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WCCgEACFRe5CJoqrsJPC7qPjT4YWkZJQ2GTo+TBilEI2OtzxkJ9aSCeh2sSPV78LMGDbL4Ok7ki
 6oN/tZqcHcJeix8bQLpoRCzylpeoxkvAGkDeNpHTyxkZqi+UKHsBii/8HeCLudRIfYRn0XrilXD
 k73OHSZiz1JkLzcLb/rr8ABXGjCj3lKgpcTpFVyLqpJp8SDhnnjoin+jm+vbNRI+cD4+9ik1cV5
 ZxK80ZL2Rrt+8am95b12JK6QJvZ1MkFIKROK9wzwg7vUJj9dJ32Y1KVyOrIc2TuCIC4f/cG3Af7
 LfPBXg0bjp0PcUU7vFwAvFZatJmNojejWEusPur6jU1IhTJOKITyW0B9MEgY0Lf8UYdEI+rapWf
 Uf3/W2dlHZTb6qHGKmSfyACBpw+8X7kdu4kuUDm6d8S9jpnew+iMV564le+FQSuyWiIKkf1OMEY
 zHIPWtJ4vIdE/5E4SiMEVKrWjfMLCBlhmEt24sFQ8z2SP2qu1BdTrmaseyhFZ6Y8y3TGbB8JQNn
 L+yulymJmCanHbWGdimtBOM7TVK/nDk0rEK5QkgCpAv7sbxTo8S9Syga71pNE0TKX5cQW5wYhvp
 6syF2F8/Ppqb67S9QnTagg567+nIcRlGN24nBMEYk9TAQRY4eD75vTACQ8K2W2g093JHO4RiXi4
 ceLaDpH38fecFBg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:SBr0nSx14pxsIr/FMZ9dvV0Q7PZMhD9uf6GyjYVfayOLFeL7FCN
 1iEa/WnaMvTYs26AOr6ZY+GcA/TisC75U2zgkYuUxgF5fMtXJ322mct7SDSg29rxzbHbIaO
 n1ZFJV9NL5yKWn8vLgPF7d/gVeUfFt9RsJ4jpHbk10zUqx3MxhIVx63S82+SBUoO9fcA5LN
 w4e2HpdxCuUDJDwFjhpOg==
UI-OutboundReport: notjunk:1;M01:P0:nJXZ2RiYSsw=;thWb8+6SIEJ5b52mgEbATsKCYTI
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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


