Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D0EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3X-0004KX-J3; Fri, 06 Feb 2026 15:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FS-O0
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008P8-L8
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408207; x=1771013007; i=lukasstraub2@web.de;
 bh=vlIFQDH4hCi74B8eo0oca2/cu6s2QSYy3ts0uxIfZuM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eRi4MYTXVXHHygbmdj6PvGhnDpV5Syk7Lu9IedB7RVWtZ85/Xt7sKQvQ4hcUkelh
 V90iipgOgaJvJZTe0tYoJDnu170N4mnXEeIqvOCWWoudx1rG08bKdoFogIkLf+xiR
 nYAG2Qrq3C5UsiHSfRzu3Lz1xRCd0FmGGIJ6pksSxbZWGslNZh9e35P70pS+ZuC40
 0HVzJaMcl3x1LeGppUENqgnNXL9i9RflJj7msiIX7a+2XjbEW1FnAfE4ZfaqYeJ9f
 H3E03cELnibGx7+/nLNLNeXPpybyOnB4m/pQ2iYdB0U+qz9vYOiLG7osj7Pga8FJV
 qB3rAHv4q1s9h3u3ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1w9Ir43f3E-00OJxm; Fri, 06
 Feb 2026 21:03:26 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:10 +0100
Subject: [PATCH v6 12/18] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-12-27779dda139d@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=ixoigdBoDBgHN6cI/nsjdQCumjwqEm7jaZXbi2aCFHo=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGR9Mll56kVHd/1N/ZxOgFfeJzcA5enis3K
 yjBqcUiCzKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WA5rD/9MD+DOjHUU5G1XdphAw6YdE30econe5qWd71QOCmnM3N6Cg0ppzGzaCQT7IKdu2a7WTgP
 8I04ufLfXsa7paxfpHPEga6vhS42PpjpCGf3rMHYJT3BXaC9HwQ3l9fEPkHsF734ZfrRjKjIDHO
 zfN3EquHGdkibvgYl+lF5BDcbhEPtm5Rbeul/IunE9RErRIjAJ6HzK30vdcrIyn6PCGG+sQSe8Y
 iRxAEUL03Bka16oBMutL8F9wR9cSRw+hxFtGhoqgMe27PZOEMtwXirxriR/8oqoEoPf7ajTMHvs
 +sVlzzfqq4qiD5d7LTvbDIOyYoOI2qZm8VmPTI7pxVBabSHOTWiINBm1CaxTsSy2+MTvwGYEivq
 HMN4Egntdqm6vyim5oZDuC0BfT63GU1CtyYaiNPaUpZSnAfPkmj/W0Qn01HmxanaWdZYYq5oxO0
 b4KGuI5PQJA4VRHPXxAleSe11LZNClB9xqGcVpXveofq4QJ2hPK4LKB5Y2nj9lRNJcAbGxAzfmL
 Inq3FyK7dQ7KXmaWDBX8W28Wdx7nqkZv1ad9xn8bl3VgbP2yCGd/8Qy5w0GEiBWDb01CR7DAarv
 r8s4Yxh/fcAN7UUPv6UPUJohVwfyTqtgwHF7YENeKf5EEpojOt1o+6WgEb6jNsJE0IM42RXTSwp
 h71IwZZVuKNsgWg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:vPDhZVbHyWPifrLF7tSIxtaCltFDeDQuvfqLEylAKzy5mKbvwGp
 uPv2Jq24dANRhmbf7eYvEsQ4upS6aS1OjOXbIiYwSFwSU4RhgvVFgRYl9WJxVxx4IassQoi
 Mvs/To+5XtKkf8pPrFdHmqGqHYyt6s6EViwYoOj7y4KIRu2c8yhX6Bz21qUIUcFgA/6qQTB
 Z3egzk1z50hIPyk3fihKw==
UI-OutboundReport: notjunk:1;M01:P0:C9usHADVrBc=;o6G5wh9NGNi6UA3JISGcUQub0fF
 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
 /4TfHVS9FkxzjAtvhxdCwugDy00IV
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

qemu_savevm_state_complete_precopy() requires that BQL is held.

This fixes a crash when running with TCG accel.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index afab8eeb14d09c1db9b235121c5845b11a80deba..74338a59b563846f4562161942=
001889dd6191bc 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -457,9 +457,8 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
=20
     /* Note: device state is saved into buffer */
     ret =3D qemu_save_device_state(fb);
-
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
=20
@@ -472,6 +471,7 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
      * to be blocked here.
      */
     qemu_savevm_live_state(s->to_dst_file);
+    bql_unlock();
=20
     qemu_fflush(fb);
=20

=2D-=20
2.39.5


