Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACAFEB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWc-00013u-J7; Tue, 10 Feb 2026 11:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWS-0000hw-Dq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:32 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWQ-0006xj-Lr
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740603; x=1771345403; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EPLwTehrelpiPf6IXrMYwJmwYy0EEKVA2aCPBnb9Ru8vkH9xxmMHoq9Ip72Ui5AP
 PuumpljEStP2KaXRJ1ZQKtn7e6KV8FG36vC579YmB5AgsGRD4bXMNR6tBZXu7oXQw
 nTsa4M3Q7hZ4RJcGn8D6c+fQIJhgXgfdaTvHrzI/nOEGrnoayfyAYru1nOB97KYtt
 By7hlCfM1sDPS2/dWFVw0Nth/WgIxUW0UcpTmfdip6edc4iG0dmtdu8zouEOI54QT
 DQD06EdJElfXUjv6JdLG8h8psXmN/8ax/6dLMfG+aoaaSBo3rEQ509ks8N7Mwg+WH
 dlGHzX6zqs1/lZL88w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1vfDXw31vr-013yQi; Tue, 10
 Feb 2026 17:23:23 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:05 +0100
Subject: [PATCH v8 07/17] multifd: Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-7-7f9e5f7d082b@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3Sh/lwPvrWrorWUOso6xcnQ72ofazvdurA
 djD9CzE5haJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WHRGD/9CXMi8q78EeXn7OMn8ATLTKD60u1JmEMbMgjGySi3gRphmdnYavboCd8+80ZBZUZtOjtL
 D8EDIYwzkNQDtCfd+69Jw3F2mIXGDHaqpHIsTH9TSrDR64KAOWHpehL068pWw1fzTMJDYieW581
 TimFapjw3ApDjuzB+2tWpbAApQ2qU8d5kDr37XQV0S8NiK3DqnHuQY6fVRPSeUfYiLDnWu0rWSb
 3+94GgP1kUmjLLsjOvXFVDv2qHGq/0ylzdMpZ7msFxDNMc5EUbssPBI4XLvTYhcKZCcJli/YMZW
 byZxJ6pRh6WBGBmgFOF4+Pd0rCoUtmqlQGTwp9fojRn6+4IOA80uPMEAyI8qY0CqnjkJdRsjceE
 XDgpI/HhvI/o1jWKwaEE1o9+eAlYuSxDtgX94f/rEYapu/Kkm8+q0+T7lTFUMXgPiS4n4mB2ALW
 Vcg0QcSYIcPfRTQ8RVa3g2isTdvFukOyvEjhSpBCf9wmey3aUyohUKdsjk2zfPjANrG6kKpuVOG
 CjXPmayRn7l3z3eMlbAGb/BTGfniRee7nutmM6qs+y0BbqKrhv4lIpMptrTMUXf+nFFCtY3r1Ky
 azge4fPkkW3bu0ZoZqjqrLYnkTDM8+2XXpwoS/DUUfH3gFJJL3Izx2IAGBMLPUTq6Lt5Y+33t6K
 1As9+28/K1tO7zA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:nf0vIrILwvaHV2V9NoTkB3q3KTIh4gKF/6SUJkGab6SKP+zO4Tj
 Sk1UEdqGuJicbapUgzEdFIxWiTBSSf1idV+dMYnQtRi+Vduryovv14krs4FPtmCj58eH60s
 f23BQLhBC+yFjji8VGZ0DrqNakuSynw/kuYO5qbAeIi1OIoAWfTo58v2ymsuElNgs5LsXkE
 YpWwU3RspnvOz7aCx+pDA==
UI-OutboundReport: notjunk:1;M01:P0:O7c1YQvJKKc=;Hw92uIiZXKZcGmfY+r4eLxAJLtF
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


