Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C525BEB26E5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWd-00014N-In; Tue, 10 Feb 2026 11:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWT-0000in-9K
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:34 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWR-0006y6-KX
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740604; x=1771345404; i=lukasstraub2@web.de;
 bh=vDwo5voZ5MxEwVTCWV2ZsNB7oCoNMDxztsKzH90Jjok=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eHAiYX4YOTsLTf92OKnLQPiikcEPdKKpkAoVnMug9PBtsQyknaFh+pDfLozkrL2A
 DiFQvhQWkcjo/YZQybKlrqdTRGM7L7+G4o/1oRr11/zE0LV0XBCeoRq/0aralYIXF
 a87Wrp4MOsWzSgKoNxfxCkct3DStxQyN35FyaNTTeda6K/6e9F3HzHNApttXwaWnt
 rDuG84iQxrZMUtizLlLpSRDQ6iALTPW1VPF1IiPYsQ/uHtGDjYAabvcOJdZYkYTpe
 MNtNn9xn21K6LeiEVacu3+aJG9wNobQgRxnMIDkG5yBjfXHDk2zUhcsbQvf/Wu8qW
 8vkZ9cOuhB6qRmw1OQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1vmMPp20Gb-015dOc; Tue, 10
 Feb 2026 17:23:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:09 +0100
Subject: [PATCH v8 11/17] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-11-7f9e5f7d082b@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=qckNqe049aOGUPLcO7lqIGw+0pvXh7cNkXCCgK3qxO4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t354snWpTaNESUlC2G7Bpnv4KFpyCMWBGCN
 Z8EZjkwi+uJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WJExD/9IXTmmPRtMEX0qNtXrf4T2rtbInJcTLfyL6HIHhaZLwP51bzWaf/LLVVnrA2cbPR6HnR7
 fnZqTeZcp9EbspsVyT0fzEvvVXuU1kJcy7wf7qDb4YPCSrxR9/UOkaiyvs+IB0GqgHha5U+Q/J8
 +LbDYKzilkdnX9cG+FmwMmk+afFRg4kjy2aEpZl0wJbXCe+0PTUKVldTrUIiyjgxapKyvfj7gYt
 TWbK5ualZFQ2U/7/zwcwkAmSnpPpZWkNe/xY19YD+qw74PRz4Rl65xK8j/0lvz3E+TQs5ikT6l9
 NOJgiBqyUva94NhThhT88QAja3TItB+QZiAwosKU/NEC2HusdD38FkAgNfBnzrkmzrHB6sAPcN/
 dK8qMRg58GeWO3h5WOiYE+KvoqyAm5BddQD5OZFLlvSfZBYKilp1IIpDutlIoOVlCbWQ5XRvifs
 0nd2dkbfVjMLjqKTuNapRK8Gn50ceQxXSJKumhftdHlDcCs9yi6VBGErmcfvJJEarTghzjIamsc
 pAlfljqCY5+cKF6b7b9O3WkAXHTUMqc9HeRx+pkWqU41ChKnLO2ukagCZ11YDI5bdfL8fykBIBk
 9mYZFILjl0KtYzS2knGHY2TIrXNAwY6rovJlor+wzPwTO0Wx6Fh9UVtNNibV4TZX38J53yoEnPL
 vGX7OnuEH01UVRA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:BHKGGeT5WEzqTdgFbOo5HacKP1PxMh5Cw6r6S7ilnD6fvTLVxbA
 ZjeWzA2RPfQDzhZK4Od6IWoBR8dMjvJuqUS4H1i8KjYiIHx0hxLhbyT+c1lgKsBJbjJc/QN
 9EysFajgNS9+CAjqrzbhtP0sJGAycTWQJFj5S8a+lOe0agbARd+3x3w7IjR47w1eOM+X5dh
 I4/wQPcyZNkp/3wJZk1eA==
UI-OutboundReport: notjunk:1;M01:P0:vsqpnc8gkD4=;Cgivt2DSb6PSz0nPEzVr2koEBmM
 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
 QJQCR77+esj+4Z+UtK83UOxqDahw7
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

Reviewed-by: Peter Xu <peterx@redhat.com>
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


