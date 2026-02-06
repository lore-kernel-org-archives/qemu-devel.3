Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187A4EE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3c-0004Nq-C0; Fri, 06 Feb 2026 15:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FM-LV
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:44 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008OW-LC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408207; x=1771013007; i=lukasstraub2@web.de;
 bh=vSJQuYUZ4CP7GTvGG0IjnktlqbBJYwrNxJUnI30MbGE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DnXfsbpWg/adZYU6b9M62RjhMWjEQa2Jyt+j4EFdiVO11hQnSsz7vQan3PfEAoVE
 D5k9Hva1o9dpuLSo/MO1DmOIBvDx7+hDocYDH1S7Aa3Uv3Vc29nrm4S8tiYzi6cVE
 MMlNw19GvtryD32O5z5KSDIyUf7BOKMDPSV2wXLaocoiF/FKHKlVletkDBYLXM9Am
 8U+2dYB6CPFK1rUavUNa/MCzfSDL0rlAUfNcQW0q5uWF4q9Kl/Wpfw1rQbckqCO2t
 8vCUiFBww7hYTnMwkbLnC2J/Adi2W4gFqeor5sfg9+Har+24alx+loEVOe2wh+qFt
 KGKsissBn6TrPFrC0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Pda-1vp00f0gco-000aqq; Fri, 06
 Feb 2026 21:03:27 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:11 +0100
Subject: [PATCH v6 13/18] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-13-27779dda139d@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=8ihZLb+acd0F+AVt41Mu0anZidBMt2QTu9acWlOFPFQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGxoJc9R3Q4fM5n3XSldsJpY7CsaG+VSEI/
 uzB/jHo+2OJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WDuTEACHoxqT7vEckjE8geMwO38DhdcTKZrBeALeAEMzR43zTiQ5qOsppNFYvbQbVD0jEhgBB7B
 Im1XzPWk+M373l2c9KT+vbPw+JR1zoz+bnytZ0Rd/oNf+Syn4q/kMJiEWUDJHwh190nVfd/I0YV
 AFgKWUsFluLDutW3xQXWrcWeofOpEPr0dTsSOPpmktlD7dB+tLb0W7aYt2YDowqg/TwVp7NvIIZ
 XhdOmKclvvekhmc4d0uurpjfj0IPF3le93049Zo2R7Vb+T5TZ1PkPeHS1S/roccOEgZj2LyNQCn
 5WERrdGw05LTubLd5Hoq6526du2z97dCtPMcdL2GJ37gR0z/Or3jXl7puL5mbUr+Ne+8XtFaoKJ
 3bOkHj6w8It+1r/UiNb0axqceUH7f2kFQScSRKmKGu5MyQbWPoCuqcFfxicDw6U6yDgxtdPz3bP
 0gjfA3JglKdeLdADp8BV5Z5jX9t7W/k5XVTbtTI15S1OvE0CdaEApQFTzwHCw1hr76EiHEYwJ9s
 PZD1mnFTlbIO3tQCR24LgZuK2bkmijnhGsKO/KQvpRTjHT/F5GJh04vdntJJ5dJsMoF7BmYpjEM
 Wd5ei7/BEgG+Y6Z7W5wpH0rd13vKpJHv2+zOb08tK1pFepEPq/8JDsrSMckhMuJ4Jr46FBdTMbU
 kLoFUfU7AAbdBIg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:BfcrLnmU/UFIzw4fiip16TTB5e7BmSgWv38lY7GA3jTmyEr1hbC
 phGSSCfN+X0g3cQM+VoJ4fggw18UEQiApgNU3lwccbf2rAu542T0EdHczPbYXo8NvbdOToC
 A1zV8dsagOPQgjisckLbYjoiYG2pB8rc50bZmdfNcs/+Lcb3qF2P1PC7MxgngSH4XeEmWCj
 9fGKFUqrUR8u5Q1jIyVuQ==
UI-OutboundReport: notjunk:1;M01:P0:S603cYod9AM=;vRVT6HgYyF4dRdq3n1akKKCvB2l
 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
 jo3iMQq8=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

We only receive ram into the colo cache here and don't touch anything
else, so the BQL is not needed here.

Move cpu_synchronize_all_states() downwards, before we apply the received
checkpoint. It turns out that qemu_system_reset() already calls it
for us.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 74338a59b563846f4562161942001889dd6191bc..cd1a2b94f497fcb25609bbe117=
feaa8eed1d7f50 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -684,11 +684,7 @@ static void colo_incoming_process_checkpoint(Migratio=
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
@@ -731,6 +727,8 @@ static void colo_incoming_process_checkpoint(Migration=
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


