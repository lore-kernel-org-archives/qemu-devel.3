Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D56FD0062
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHm-00015z-Il; Sun, 01 Mar 2026 14:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHl-000150-Di
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:01 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHi-0003Vv-Mv
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392612; x=1772997412; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fRZZe9YiQsaLv5XUotOulQINJuWTltW5ljC/YMwv2gA97TlG9riIrSTapWj32RFL
 8famzt7AJa8unjaGQTnwqDTcgejMuI7/bQUUChKeL+Wf2fH6cgKknBC0di8HifTta
 L6ym5Q8Rz0ClvktV0KVp3Kh6HKRDWaQuIh7OiZnpcJl1mYFJiAp08ePaO+Uno9Jy6
 O7SjJdGeWL3kZsmzKc61VwpkyAFOs9xWdZ4JkosF2zOxvOYghR6DWxwluWSwInFSs
 kEorgKu105G16Sxvw4ndWO/9CCbwpPs6hQAcXkbTdV6gZ6vixph4gGvoMopRvkczV
 Y31niZIN6C5tTFOn1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFhg-1vSNPy1q3G-00a36W; Sun, 01
 Mar 2026 20:16:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:36 +0100
Subject: [PATCH v11 11/21] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-11-a9701e795d7a@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdMndLV2vKVwcEDGeWgvPKRDkv1aLiy7Xml
 ACLrZSoBJKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WD30EACqD3XhPYa9EK7Zlwqfu2UCgbYuFBMbnEGMl1j88PUfrsP8B74Vm6Pi6I9c+XPgh5AjhpJ
 s1JLJDN112Xj8C3JlIj7xscjvCX+3+k5ogowYha97T+DqhM+U1iEFh5l5xnptsFkQbEDinfyfRx
 RDBiHIAZZ8+BggjNKMkjaCPQMgQQT7h+NpBMdm377iASCqTO07dTNv7nFrT9OURw/JGVI9qBO3R
 b8Cv3XYRAU6NbVkwPg3LdSQeaebg86+9SYgCdRHJ6rpBrLlXiwUPAeq1p2STkhHP9pumNfEkOjq
 u/JiBjiH2sezorELnEkCIFeecx2pSbi7n+mtOBQHuHL0l3X/3nY5vtgksIOxaCkK+4Y0zgJMx28
 lAodV3XxoOHtRhAtRj/zjSZxwXnsFWhRS7sKYoahztvl8qao8oNSYqinAgQwM6l085gHQrueJ5G
 oS7FKvmL7afjwHKZLaHekKda9f6dVtWJEv9C0G1YZjVA3XPJMg3kKraaCi6hG92jjLSsggdtEEu
 Vxt7MjFSgIH9QwwZMy0LNmNXwRdRCgEsJG8WlWzrriM/Rs586EZpmD+5KXF4x2GemCyQtdHm72F
 8zGurIBwzZpmqh1IoQYwKptvplFenz5y2LaPsX1i2QoMgrmFkvAfU796fWSTCJ2X94H+EeXmluB
 SS5RJEddyQqiwfw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:AnTODGTimrYR/Q1YpzwWodUZ1ESifFhiwk/7M2feDE5L9DVdr/c
 gqtc/98Ffbkj8g4tO9p6S7yV2g5Tx93kEXsB/FybVgI3IvbpiyasJlzmGuGSc3xbHsCFlz8
 6wzrkvE/CX4zBL0pupVCgdXGjpKYYIcZyHUOvioqrq0DRuHixdkoiKoFfgQPzYgbxyJru9O
 sq7RaPgMk+yB46sXGwUnQ==
UI-OutboundReport: notjunk:1;M01:P0:+6Js95Nt8iA=;fTKURxGxUxaoUj/+LMdWubSpUSN
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

qemu_savevm_state_complete_precopy() requires that BQL is held.

This fixes a crash when running with TCG accel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index dc7cfa81ef7db78e3ee372642de48567c5bc06eb..3297aa593cd9f87bf101359846=
4cc581a9d23531 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -455,9 +455,8 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
=20
     /* Note: device state is saved into buffer */
     ret =3D qemu_save_device_state(fb, &local_err);
-
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
=20
@@ -471,6 +470,7 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
      */
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_savevm_state_end(s->to_dst_file);
+    bql_unlock();
=20
     /*
      * We need the size of the VMstate data in Secondary side,

=2D-=20
2.39.5


