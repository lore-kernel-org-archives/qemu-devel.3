Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC7FD0062
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHg-00012l-IR; Sun, 01 Mar 2026 14:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHe-00012F-Jd
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:54 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHc-0003UU-Ko
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392610; x=1772997410; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eiR1RVOqjtVDw9Ln19M4riiR75v68RKr5Oh8iMtYk/2bEMlfhs0Yt16bi2P+aMKQ
 C3yK8Q8XRhtWVlsjdhJSiRlQYXIYd7rCJX9T8C7l+1A3K5Dw8GlkTKvY3eOZnRi4e
 X2QePgplNyVCg6Ic+00buWN9wuB+bK1thmv1nw/0rLgR7GBa9rKJKFLv7e0vW1YdJ
 xd7OVG7nWfZupkazYoU3yszIjOKi3w/Jc7XuGQJdKAkUeSDFnSzj0pu4sjemos//4
 7+TL+7cAWmr733/hGYFD4BODOeuvTsM8v4i+c72uPhik+5WdL55be8sxQXZ7M1sQK
 dlQmJ5C9BXRbhKfVEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1vbYUz2usF-010H6P; Sun, 01
 Mar 2026 20:16:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:31 +0100
Subject: [PATCH v11 06/21] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-6-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCc76Lh4qsC3/28fvaXs5SS/GISZ6yMTa5+R
 ptij/DvBAmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnAAKCRA1qwsonF2y
 WKUFD/sEwQkgZDLmfBix/K1HizACZ4TkZq8jANPsffD5CZO7sZ9XcfkUItERZssiOqZ19UTxi7c
 Myry1ujMk/fDTA0er0GbsQL0Ja3TADnYZjXTDA+xn1546TF9uhDzCSyw6mDOxRilWXMMnhc2IIo
 rxjUpAczfU28NJQGJCvrRoJi1GkOlnl/Zx8QMpki7RWKYThsO5thWkrpMDWYnWh9HJEXj+vk4t6
 FpkemABnaD2SfJjWAM94Q8n5WydNthkKM6zqFjI/9OgcoCKLB77OJPKsdkWd8cikJv7fBwryR5D
 vx+P/5RnaewjZJN9ibzVJ1CP53RI+SUI1K/k4l0yOz6UHkRtk89Fd4nUzG5D9b6VZ5UatP1dkVI
 4KLwAq75IPYTCyMbch5bC3Lh74JfIEHjzuvDBs6mQvCk9fvadIh41UQyVaS6RxVWc/UQ3nSb85p
 nS2uFwYNJL4PSAoxVPekos63iyEjurJ/D2kE66Eq+eAMCOvvdXMY7kqMK7mzm92WnDFo6UsX3hb
 zxuriAvqo2xkQSx+3pul8IFsATR2h1p956L/zjgRC1EF4VgHkiYDMCJ2bZXkFP/Om/y0kGOgi+n
 5Bq0oOjUZrLKsv1avTuN05xfzVJpvVGZU0PMqhnZKNLn2BRnzmA3IbUyRmBB8/BdHg87wiJLXXa
 Fm4I9IYNC1KkkeA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:q3PpcPZsKHkSbDcindcx1l4QbwObiYi7X/Flly4l+hZZxUp4aCv
 8ZvT/4PGJuYn67FPPPfpPpTxRIp0J+in0NEWuTxDbu5q/F+zH2LUhSsAYl/9FkFtiBtkS+2
 jwMqdIYE5E7GwNmaPCAirrD+eQO3LxNKf6x8au7lBoiBwQMjnSj/Lo2Ys6MDuEiblfFVXqK
 4F5rdySk4NALYKWCd+WKw==
UI-OutboundReport: notjunk:1;M01:P0:/TXrCs5zSiY=;45d8dOR63QEc+K/R7zioMDVVRoE
 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
 aO14TP5Bkwz415EJy3QBtyuHh9LYbjMAtKFJi9
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


