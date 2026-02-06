Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C7BEE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3W-0004Je-Bp; Fri, 06 Feb 2026 15:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0004F6-Ua
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:39 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS37-0008Nr-8E
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408205; x=1771013005; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WmQdhjaHdVnOEMXw1sZPy3ZeIoXiZb+MGL3aews7eovoIHEDTa38YGdVH7Ci26Bs
 Oxp4Ts0JMgFvPgcbw3mbmpvhJjzOkN/1ZvG3cn6dOqZa7UwyA6adCCJLYRnCsb7Ql
 5b+8f7f+q/15aKdmq2gmOQ215VOzEfkF7nw0B/GfJPX54cLytxci6rnkRmxfQoIBX
 Q+ZfYBiweO2UhyC5AEc+dbWX7JzG76PjBjznSe+H6X0NxYh0vdVPlGDORBXNVX6bE
 7p1/iaAvafhajWScs+6CQQTHqe38XJUv215/MfuNi5f0Oe2a7ZPK/gfCc//5vq9MS
 UCFEWTM50Y4OVCng/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1wDiht2qqC-00SfYs; Fri, 06
 Feb 2026 21:03:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:06 +0100
Subject: [PATCH v6 08/18] Move ram state receive into multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-8-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFelqOB6rX4EoicFFwYMzixMIHMJjxEbnoo
 YrrwZbiMbOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WEYMD/4pIEHu4BmnJlwyQaNtpEGbxXcIRcHv2QlIzsGteODdUuA8ROZKO1gExYL8rVjGv/eGTvy
 0va1Lp0WNbMeHgE8E8g3JOTs9iRa2NIjwfhad2ts9/veXfgZUS/ck4OwuZFqJwIBKu03uAR7U3i
 +zeKShpB31vqdimNU+SqvESalGIkq9mt5qmeCaIA2XphWSek6W9I4BKVjEBI7DtFtxkoDr7AayJ
 7eyaSB1/Apg0G8QS6c1DlDq/XBtX6xTfarqCl/7nW6R13wGyV2+a6Zg5BhUSbsa+nBK1IP1WwPI
 yRlM6cCkOZpG+GnC36QnZhLQTOxZFdQRzeGZhtdnYEBFuW1T2YxovwTpVda59xb/HB3ID+lhYrr
 mqRsgWO5PdJZCBmnWY1Ti1pShFMNd24uhwv3nIPHb4bc+U5JdgvQWPm+FwXxQMw+gDlxTK6Q2CK
 CnjNeaRMyBxVUBe1yg+JaP/IbpsZIZZDO0YYMoLcZ1SDOyQcvK1XmVheCaUw/fS3vwAKznRB/Zq
 7H1Q6GbMQ+w2RqZtLhPGHBL0lZ5I07+UHlSQd63LidTYyZmdZRdHKWiljKjq3haxWkdrNonvDAN
 HiFdIl5W85NeycLYxK/82Y2FyALEZyfB/3wto8+xLT34BkjzGwQ5IjE/HmCrpTMvA2bhTfLnoBU
 E32peF3Bgte9l+g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Wul0GjzBlD4n5CEM1aTTxHp1T0PJRW2jzpjB5EQDNk8ZCvlkBAr
 U5zMg+fqmj7qoZ6q1VMLXu3JYJZ8XFbVgd+yX+kTqKX5+97DY5Br/jPEITCgapJWvSzHBjF
 BYjwMV0OHEoMTS4K59ub3/Z0t0C7i8ol2MLR40jipq7U3ukFA1OHqCyiqNjHTHogzkY0LGV
 EO4eBG0ynCf7uu9Yfl/XQ==
UI-OutboundReport: notjunk:1;M01:P0:ua5xjWnwJBw=;pkrAXSkzwxaN6gVhWvlrbN4KtCT
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


