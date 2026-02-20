Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1920EC5AE5D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXn-0000Vw-27; Fri, 20 Feb 2026 14:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXf-0000Tv-C5
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:59 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXc-0001RU-N0
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617110; x=1772221910; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CYiGX8S1bNF8XXCeaa0eXivMg9ciSsfYZQMrSIDGImn+aXAwUn0un/I4caZvtmfK
 MUGaZ8Ob7Dj7HOE8h2CMuSGNT64xWxZmDWxdM5JKMfrGFbFmUItu9bQsR6JIRvcFr
 8w/cJaSEcmObCPpuMGrs7RiR8AZUM+/Uzy8kdLCXfy8dPovMEudWZZy8pKkKqkG76
 6lGZ52YGrxHyYTiLLIy7jCmHoegEN7frAqbQuGDux025PiGJHb2RTmq5aK8lpiZvy
 dGYueU6Ki9Ju0v4vmEYMbLLtSrvA286SHVDcie7iAYaBhsdy1ZI424d3AO2x2DUQE
 GEoDv0SJtau0FeIZFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Ez3-1vsh3o3qkn-000oaL; Fri, 20
 Feb 2026 20:51:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:32 +0100
Subject: [PATCH v10 10/19] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-10-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Jo9ygbD9kqkeUyQ0JD+anPkAvVD/vEUQ7S+iY6iqDJE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOrxYrpckB7x8y1IAQNiwrrwGC/TvQyjCVF
 MOc5CTL0e+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WD+ZD/9vX2YQmcVIujiEfyFW38525/1rHyhsc6uXcHEPTx6e9hMn1RswWG6cDAtVZ7b6s6m5fwp
 f5r5evs+SwmWkwG5DhlRzT6MehfNDwEpABCTz8eb5TxiEt4GHdXVWTdMHHKwObdb65zk1AFQe/+
 GbZEuIdZEUGE9iJShU92jmHStWZTPwmypJKwvsZwz6H+TbyCAL6JUL+FOGqu5LHsWvDR5FCYWca
 EP1UFp4ie3RcN4R/0fDENla8P3pHDuk2hhJKfYKAKxc+rlbq+UDixuqOWsOdkCrzweFqtZhOLmZ
 nGAfdOmXK/YLzB/Qe9KmoY9zu1jwz3BB8dOrgV4hPp9EDVEvL0YgHb/prdtTzaI6b6Yh4uvQBfC
 10kDlQaBapLm87WP+/xCOjqigs6TZ1pkw8+RmOcOhmEe9tazXnfQmWWab6R1uEISabigKm6d3Lf
 oxreckQFLj4Fwd/HLLj+deXrgUh0bsbOOH0GQUXlTQkgGqW9WejhoElpz7BSyZIX20PLBrHdO5g
 kiDbnzHWRmb1k4Jr7m6Q6zKHjt99fDdsaYQw3IWaWK69yxJq4ost/WcWuHCZy9vzA/xN+hpua8X
 qo5atKzoHwW1oQgK2xcZpgavbIXVR42SPp4Sf7OWoi4hQaxjwVnSjvROZd8YQ+jsVx+aPSnNT2k
 9lnH8wAoDdGOWBA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:SvdynoCY1AxFa37ldoBCvJ5/Qg3xa5LNcRhyaVO8wht3skCo6kV
 xzLM2AlbHlozilWs2yxGKWTaSQeZJoa1GcQdprNLh3SEBpG86cTbehipwq14tSR7reAgQK+
 qyzJGhXhYlElh6hbIEDmVctaDChqN31qDwzmbiEpf+VS0GhonjInVfz0kE3Lfpt3x4iKdvX
 oxBQW8wmRm6v7HjNswWPA==
UI-OutboundReport: notjunk:1;M01:P0:UGm0rGKE3xA=;XpP5s+jjZWpmcRUJ3ye74o3dbRY
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With colo we load device vmstate during each checkpoint, on top of
a vm that was already running. Some devices expect a reset before
loading vmstate on such a previously running vm.

This fixes a crash when using COLO with Q35 machine.

The reset adds 10-20ms overhead to the checkpointing proces in my
testing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 96102c9d0fb3b60e063c81ce07b730011bc4919f..dc7cfa81ef7db78e3ee372642d=
e48567c5bc06eb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,6 +729,12 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
=20
     bql_lock();
     vmstate_loading =3D true;
+    /*
+     * With colo we load device vmstate during each checkpoint, on top of
+     * a vm that was already running. Some devices expect a reset before
+     * loading vmstate on such a previously running vm.
+     */
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb, errp);
     if (ret < 0) {

=2D-=20
2.39.5


