Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EE5E95A95
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 14:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaaMS-00047R-02; Tue, 30 Dec 2025 09:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMQ-00046n-G6
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:06 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMO-0000f7-6x
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1767103558; x=1767708358; i=lukasstraub2@web.de;
 bh=IJdhhwrpjxpzQDkHFTGPLxwjC0Qy2O4wkTBkP1PiIOg=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ulyXDT3dZYkNPXMm7FFbYyCDA/T2ldaz2xYfuY8QCIz9LIkuO3me/LMUPcK7l1Yw
 W7VUMRHxfrkTb3p2fjTXBh4MCNWnwXWWrWSMF1Iade/8AAWv9aYTwTE1SbbQcqEQZ
 EvsueUR32HeJDDD3fyI6RtMhb4f7NuWiZOd66lydHvMbmlN+Rx5jCg6PNpqrowYFR
 +Qg0nT0Xjp4G2eG6lZAiT1Ga1qjShi9AHC4jss8qT2hOPQo8Ontuw3tjKwGj4bdJF
 9gAnzqcIimUJGSy2xJXv3ALPFfLsdQQzJVKIy1n27cV9Xn7+g+uu8A22x5nsdtg5k
 Z9f5Dp3Sb26AZz2yvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.110.28]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vop-1vw7b23Vtx-00x6p0; Tue, 30
 Dec 2025 15:05:57 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 30 Dec 2025 15:05:45 +0100
Subject: [PATCH 2/3] migration-test: Add -snapshot option for COLO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251230-colo_unit_test_multifd-v1-2-f9734bc74c71@web.de>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
In-Reply-To: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=DZjtVO4KSpIlSVNY0AVQ++ao1ntVj0lQQjATFcqIaYE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpU9xDB01VAOpZKifg8UucaYdRU8UeMGd4rfV2d
 i8Nbl28ArKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaVPcQwAKCRA1qwsonF2y
 WI/4EAC5d/lRBQ7ZXitvNNs+t03xXhuxwlQqpjp6McEYCOt9VNePfi7KWWo5HuftZcsnip+Vigv
 j5WPyfa8Pn/NKn/2CJhzARqBs4FCmHs4Q1xn4KatBDccchTtSOSn0IRu3GiUXLCpxZn9gMX43zZ
 zlqBRZbEM8Hy8G4R/y6TakN9F436E4Yu+lckPrnpTCfD1oeUe+OSAoiGxBmhvINNOHezEKiS4MA
 u0V4Gmzj93oe5JEGGDAn+L/sxcUjZPPAMKCqt4WL3J14FFXS6jY8cJukGKV963AJDCYnyjf1IGX
 89Evyc4SJOtOr+S/u05epk8d8JthWULlklT9NqslsMLdTpZJ1GdgqNiLktt2EDoGHxlJ8FwLHeQ
 wSJ88pRLa+zqLRdptxmX2sgH/TxKyySX1x/FJsH1YhaJPc3exspsFl0kUgFAspqyuW0KTTkUNgK
 ZgLyFPm1+QCjT/EzrzFNmvSRvCPbCwhFr2GR6wIXvkv4ihc44YERouRbUBtcHwGgnqtiUEHWRwp
 EpQ9e4jhSl1/xu+IRoH8Fri6hwMqJd4JGv46w34u+P/a4EKK0dyK883mCoOorgWV3ZiMYOm03HX
 SJWSOCDA6VBhhYnihpMjGLb12OvalbAZaIAVVwgbEiluVJPZS8YLPMuLY+HDp+JVjFBJxuZOy/C
 +/jH7crohiEwUfw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:+23O/FIOtKxmwGAHswrs+ymBG72QMFDqQ1duvcOU0iVZycjlFD+
 OExAw1Tfdlsjmr+pkRWIM+PqM6lBBvxdTTPL2YchWoVl+k2Tamq1mFpIxaMVQdsNoCq5x1e
 t1230+r26UHhvFg40vxF4njVovR/C3iR7C/wQzvQgFXuTDfxv7tH3C6VwfY1W+MGwtEDCng
 O0gFfAg4khSTTNQVP3fww==
UI-OutboundReport: notjunk:1;M01:P0:JpZlnrlAnGA=;8SuW5mmPyHp/wSFS6sHr2C4IOyi
 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
 Lf5crus4=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For the COLO test, both VMs will run in parallel. Thus both VMs want to op=
en
the image read/write at the same time. Using read-only=3Don is not possibl=
e here,
because ide-hd does not support read-only backing image. And the image
won't boot with ide-cd.

As a workaround, use the '-snapshot' option where qemu will internally cre=
ate
a writable snapshut while leaving the real image read-only.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 tests/qtest/migration/framework.c | 4 +++-
 tests/qtest/migration/framework.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fra=
mework.c
index e35839c95f51d851a3fed8e8457ed2d7e927f59b..8c1fc6e009f16dc05a47e91716=
7f62e0250ca992 100644
=2D-- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -322,7 +322,9 @@ int migrate_args(char **from, char **to, const char *u=
ri, MigrateStart *args)
         }
         arch_opts =3D g_strdup_printf(
             "-drive if=3Dnone,id=3Dd0,file=3D%s,format=3Draw "
-            "-device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1", boot=
path);
+            "-device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1 %s",
+            bootpath,
+            args->is_colo ? "-snapshot" : "");
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/fra=
mework.h
index ed85ed502dd01aa809892b68d3934b5107bd3442..2ea13e7758697550b5531737e6=
6d6d939dd800d1 100644
=2D-- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -134,6 +134,7 @@ typedef struct {
     bool suspend_me;
     /* enable OOB QMP capability */
     bool oob;
+    bool is_colo;
=20
     /* Do not connect to target monitor and qtest sockets in qtest_init *=
/
     bool defer_target_connect;

=2D-=20
2.39.5


