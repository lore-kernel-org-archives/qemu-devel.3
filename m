Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D3E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7S-0007Aw-Ok; Wed, 18 Feb 2026 16:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7F-00077f-DS
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:50 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-0007MF-9G
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450181; x=1772054981; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=S/e4yvyYWdFshAuB5VDtkx8rfhMQ+ijUG4Mcvhf9p9wM1SiOvDTojPN+q0O8W6z9
 mmdYi6AYU/zvV+NsL+Pa4MpQ9howB5oHek1ncZQ6q/IgpFNjUu950VsCS2gtNNVAl
 C9OviuuwrlJN5WhCHDIVuk3eKznanIfmvIoNTLkutSCxjwNA7VuTUQuoqQJov98xf
 lgN/bF3qSGgj2qcJxYdpEVsu7f48UEGZHkug83MV/10TWWHi/tCpoGoKFeeSob2dJ
 ZMBPLUUbAiyN6n5/QenKvzYp4kPYmdmdbKBvC7D+drEy2S7negHGJlHtYTzNttB6t
 YwynoU7VXAz2BgJcKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1vhAtc07en-014YCM; Wed, 18
 Feb 2026 22:29:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:32 +0100
Subject: [PATCH v9 12/19] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-12-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=5X2xJUQOZtX1vrH3iSE65Qld5dEQ8f6o9Mt01ciNeAY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89FnnLieXx+JgU+6GFeOCc/ryEUJm9XHkFf
 3KpPPktAseJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WPMkEACvKlBXzDu7onM/kz7bokZyK0+LsO6tEKHAEOUGxi1ju/ZauQsl6jXvx/6JYJ+Sf8pTr+l
 S67EGEk5f8gr60oJk/cqesU3cK6k1ohWBKOuou0u/5PUHFUGdp0ACU07VL2XZHZqZTWQCPkPH71
 LznlrbVnQTo92sGvR72AqpLDkroVY+FLCwVcbibbx5QbXFUXdOs5Sgzul1u0r+LDEAM0jg/0jTL
 KH1by/Q1sE4Nj1IeuNmvZHUsxobIncsRGXi5Fm5+GcT2xQeslnH3nq/WzUjXt2A34HjkD6qWB1Q
 Ym3oPkPYpkSa1aRqcP8RfAoaQVuokCUZUAuQQK3AVozkhot59+KB8Gp8kyLMl206/5Wb8P+KysW
 ptrT8hQqG/WwNBmOw3G0EmBGgq03n9t4z9yZeRjccpQKUDUh6nx4IwNmElbsNDu1jyvz8y+1xF1
 WIMqrjPdYA+arSqK/cbTiFg78YIqSc3TvAc7jrE3lDK//zfC3y8jw9STYn/30wQ+tubX/GRec4M
 ZlqhSryFG6QQPkaDdE9Ta7itQbi7Ns5Vv/VxhqReWX2jPNsTRCmXfpWz4340jifGYSGexhzj+EL
 uNFSN8awUXMkyC5K+Av+kyCFiIfSgbagjElH2xtB7K5wKac+exUvg+dnI11Er77Y42yd5n753Z3
 Y1bOlnRfVUZb23Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:au+99EQonQLBKUDFTpS5UqG6yvruO2YFUoi967J+EZcbd9f46KP
 GT7d4HMm1ge16nj86ROrlL3SVnZANWCqDl8DuwyiX8zcPiibPMvsD7Z2qgOCHkpiohP4vkO
 SsZog0M4ahR5dO5G9puLeCYB+A0lCGoLhMiYd0rPY60gdERcfzA4FYt9BnH8ex8ZZQiDQzV
 O1TVA1nYCEOU8ztQBM6Wg==
UI-OutboundReport: notjunk:1;M01:P0:mAYf2D9jfZc=;UQmDe3XcIQXTGIz6eMv8gIUeOq6
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We only receive ram into the colo cache here and don't touch anything
else, so the BQL is not needed here.

Move cpu_synchronize_all_states() downwards, before we apply the received
checkpoint. It turns out that qemu_system_reset() already calls it
for us.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 3297aa593cd9f87bf1013598464cc581a9d23531..ce02c71d8857d470be434bdf3a=
9cacad3baab0d5 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,11 +686,7 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
         return;
     }
=20
-    bql_lock();
-    cpu_synchronize_all_states();
     ret =3D qemu_loadvm_state_main(mis->from_src_file, mis, errp);
-    bql_unlock();
-
     if (ret < 0) {
         return;
     }
@@ -733,6 +729,8 @@ static void colo_incoming_process_checkpoint(Migration=
IncomingState *mis,
      * With colo we load device vmstate during each checkpoint, on top of
      * a vm that was already running. Some devices expect a reset before
      * loading vmstate on such a previously running vm.
+     *
+     * NOTE: qemu_system_reset() calls cpu_synchronize_all_states() for u=
s
      */
     qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();

=2D-=20
2.39.5


