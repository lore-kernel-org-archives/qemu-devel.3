Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1EBE6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOh-0003NR-Dj; Fri, 30 Jan 2026 07:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOe-0002qE-Kd
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:44 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOc-0001sA-VG
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775276; x=1770380076; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZDsyz/ZS+1E47rP2cLeKVRTU/LzPmfy4h4Oyo+GqQoacMytJR76mctx9PaEd9boi
 KxvZC9QcNVEvaxE6GMGRGb/5N/Vd28Rt2aW3dYxlckXw8q4jKuj4xFv340MoTdDCM
 8f2ao6gcvBHrTqSQilKvW6cBUWixISmRnP9kqN0DAmzVw+4NjWlzLFzGXwiXNhh+t
 H11gQRhIuu0FPnV9PUSE+Ep2HaZHI65yv32Rj0v8h5q34tnAtAWwB78KuKOCpFDcG
 Uo3EfD3+dlWpOiViEFbJKj53+7PcsC/MGi3QO/m5BYN9XweiXutD5iPm2oj997bw2
 RZCQFSBJ4Ru7s+sR8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1wF6rw492R-00pJCN; Fri, 30
 Jan 2026 13:14:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:16 +0100
Subject: [PATCH v4 08/16] Move ram state receive into multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-8-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClKnUa/IWZCDWaPyzxNn0pad3enstcW4kAa
 KQWlmxyNQuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WHjSEACVM54yNfojawJ+Hbf99WhbFzAZOJDbLTLWbZb9Q4BJdMgI+70yRaU7jgQgkeCEgwMI6Fn
 1Hbkcb47L2JTQPsCVcgpIsbcbqJAvwh+IGcMGJXa/38ajigk0fpXPgCkjR6WzLoN0/XOdrmAffa
 GsCz6GIi9LPiedDWXwubueqwJRJe56/a1iPP6R/g10J64wfmxUdQstTLuqQ4Cjsn+f9Cis7EM19
 tp4ZkZYkDOGEKH5EJCDtbQDki4Dn2vbEfpL9LO9nPeh/rs1MftItHp9npCNrCdfRG77GW22m7Ip
 SWUQuc68kbVUUVToPeVram3QOkGr/qf8xejCaLz7lLoNAd79+4Ku4kFfPX41JPezWh3+yEC9+mD
 1ObyaGM5OQ90pTaJDEGFsKm7KkDBuRrX17IbTkwskUId/yDLULRoOSulZNhBoYVlrdmcA0n2Fk9
 Kk6r5dEMiE0XLq6f7UEytE7867lkey+d6Q3/Pm2DyHISskkoGbNCWMctLSYzooFcRkUaQLY6YNq
 WD6xEncSF8vbsIg1IAWBq+pYkoj+WUF+w+k0Cq5kyXepTUtfez1njTyeBg6uhryclnDDHP0j38s
 RsrqSg6yAz8mLCFgSKaeMmkJ7iG+9wm9/amwpU0l1MgUBPdKNemlkIr4Oo5u4Lvzv+GsW63Slk0
 vCalM89VWTx7ICA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Uj4gxF/gFEDk9MU6Jz0yEcnFVDjxfK81yIZbbdxw03Z+2vUTQWt
 6JuIUfmSGdh9pImFVJHrspJDcr+BlWNhlAxTyqDUxS+w3iyfDe+365tEkhxe140fssJ5SGi
 stmFEczThxBuvxaJcgsGCNqt6u57LJZW/4fnqgVsigcDg+ukXaZ92ePqNzAKjVNSnN4yDh3
 7j25v456e19M0d95fl77A==
UI-OutboundReport: notjunk:1;M01:P0:YfC1uBYTv8M=;46/eO35p3GvjuKag/3yQV/ifL3E
 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
 oMb0jks8=
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

This is in preparation for the next patch.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688fdf98a5c7f4ee9fb80ba2901201a33e..332e6fc58053462419f3171f6c=
320ac37648ef7b 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1253,6 +1253,15 @@ static int multifd_device_state_recv(MultiFDRecvPar=
ams *p, Error **errp)
     return ret;
 }
=20
+static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    int ret;
+
+    ret =3D multifd_recv_state->ops->recv(p, errp);
+
+    return ret;
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MigrationState *s =3D migrate_get_current();
@@ -1387,7 +1396,7 @@ static void *multifd_recv_thread(void *opaque)
                 assert(use_packets);
                 ret =3D multifd_device_state_recv(p, &local_err);
             } else {
-                ret =3D multifd_recv_state->ops->recv(p, &local_err);
+                ret =3D multifd_ram_state_recv(p, &local_err);
             }
             if (ret !=3D 0) {
                 break;

=2D-=20
2.39.5


