Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A5CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMtI-0000eH-7Q; Wed, 07 Oct 2026 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEHNa-0003dJ-0f
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEHNT-0000UZ-Nt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791339961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sK5GD5O9fskSwF3ozz8UE5sf0fR4JZta0W2sHM0IuM=;
 b=XJovKhHvyZN0avrCPMpeX/6JWsZC/EBDcBD/M+fWz5BQF2uUzL1pyJ0riWlEuOkvZXiw+Y
 Ba3u4VNsySIozQZ8YKtJM0kUXQnVEmGdfyiPVp/DuatCz2LQoFEb0GUguBKL6JSs0quS39
 FKTJv3Y4RVaN4rrh2gKf+Wn0ZFrwTAg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-wRdsIhSYMFGxBFPpuTyQYg-1; Tue, 6 Oct 2026 18:21:00 +0000
X-MC-Unique: wRdsIhSYMFGxBFPpuTyQYg-1
X-Mimecast-MFC-AGG-ID: wRdsIhSYMFGxBFPpuTyQYg_1791310860
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338c59f90dso53618431cf.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310860; x=1791915660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1sK5GD5O9fskSwF3ozz8UE5sf0fR4JZta0W2sHM0IuM=;
 b=FV1uYk1R4W92KIFu8Su1bUS0U1jfvTl0LN6BgpDbUc+E3JnbNKFgFO/CezQNQjQfCh
 3besqnJUjclrY5DWAFn2U+xtb3MbS60LnykQRjI9nZODKsSYfg2sHPJDzSHF+x8l/syk
 T0oezZzt60D5M3acHFw6BNPCM8H0X/oc32N33hjGV3fpN7jT/JiApjRdnuUlc8JkA0Xv
 1J269k+Mh71L+S7XXI/MsY1uzWBPuEc7bJEE+c3mDq6nA6tnvKoHMe0SGF/NE0dYjP6Y
 tH5RzXan0OeArTmlhI/afbkhD7xZVat2MWK6vKF51drXDMD40IBziElqtC+fKlPLSATc
 P6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310860; x=1791915660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1sK5GD5O9fskSwF3ozz8UE5sf0fR4JZta0W2sHM0IuM=;
 b=o9v28w6YH3WRiL6qs8KQYN4Nis1h7edTE/jxA51jxyzG+KI+/IemRaNxr24ElNUslO
 tV1bUO9U+2LcNfqiL+1Vw0cPJlSSwmkMORFhwSPZk5vJbrzPbOYGnloj4DMnMLcCY75x
 /in5pnduHJ0cux0dXU/Nr3HT+R8N2U8zpDQeE/bny8qrJuBdzYQ3RUKRzH6Xpgf0WgWV
 hQdz9AeAM7xUrAdBw2OBm6yZo9MU//KSgsChgQwdwaGJItUE/MxOvdAuMVuoYa95O+T6
 0dZGCXuTPrRFynsc6MOdnKe6Rn3Ej4ntebEqRCCCdZge1Ipl+RVAndy0S/ORwzzMbav8
 Ebgg==
X-Gm-Message-State: AFuF++ktO93UsS6oCsFaIW/sop4U2/4zmhUoB6up1XE+0JcQUO1Egse1
 TTMLvUfp6nc+TJTaQ2LrSsFBW7x8bYPDHPWeHWtRMvX6BxlNV8hbKaOtGfokpi2+1K4lFx5f/a0
 DKFQBALEvn6aTtfYfo2Wbff+c/FyIiL6fLYyPP5FwpRNGziwoL+P+fxD4IkWLK32O+v7jMugCK0
 uRqpTdmeQuazBinqvcUGbSGYPTbszZACiDsr4jDQ==
X-Gm-Gg: AYBFou1PYFZJ1z2I0W0BBXuJGo4En1CUXMdsbsb6TMY5cbkBl38DnbnD7oOMhk8x796
 0TmlA7HUPRzC+iXPDQxC8k7Qkq7IKFxLuE7/Tp5pLFTYzY9ebPzVWIZygM/0oXY3kk8TuSp3wDL
 4EUiZwcsGWRIu+OwnCrh75t5/TRdSgA6PSMIbfXtJ5pw196ivZ5lWT6mW1/mti24dH6HGFsf9bb
 mFNLGiQ2I6Lay5+s8FCeT1ukwlbL0p+rwK6NNAXJJg7j/BbKuhL0/gBylVwm8Op4fxTiThoPBwb
 NGqbF4LbAtLA06eGJEwpyh6JziFunTfebgxLdYE4w7Mmh6x1sqBR/HPROn9qCVtuQtXzj14=
X-Received: by 2002:ac8:7e93:0:b0:533:37ff:92c1 with SMTP id
 d75a77b69052e-535668c9ad1mr37281701cf.8.1791310859821; 
 Tue, 06 Oct 2026 11:20:59 -0700 (PDT)
X-Received: by 2002:ac8:7e93:0:b0:533:37ff:92c1 with SMTP id
 d75a77b69052e-535668c9ad1mr37280951cf.8.1791310859059; 
 Tue, 06 Oct 2026 11:20:59 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5357211719csm1704951cf.16.2026.10.06.11.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 7/7] migration: Postpone the outgoing preempt channel for
 preempt_pre_7_2
Date: Tue,  6 Oct 2026 14:20:46 -0400
Message-ID: <20261006182046.3767283-8-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006182046.3767283-1-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the corresponding outgoing fix for the same problem mentioned in
the previous patch.

The idea is simple: either migration to an old QEMU or when TLS is enabled,
we rely on correct ordering of channels to make it work: first main, then
multifd, finally preempt.

This patch re-orders multifd and postcopy preempt channel on outgoing side,
but only for the old machine types where preempt_pre_7_2 set, to make it
follow the right orders to create the channels.

Keep the resume path alone because the resume path never involve multifd
channels, even if multifd is enabled.  For that, fun fact: when multifd is
enabled with postcopy preempt, network interruption will break all multifd
channels, but they're never re-connected, until they got recycled at the
end of postcopy migration.  OTOH, multifd_recv_all_channels_created()
reports true even after postcopy network down, as multifd_recv_state->count
is never decremented.

NOTE: this will move the preempt channel connection no matter multifd is
enabled or not.  It should fix multifd's case, but should have zero impact
on when multifd is not enabled.

Fixes: e27418861288 ("migration: enable multifd and postcopy together")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b140fb6950..53cb6d3821 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3729,6 +3729,21 @@ static void *migration_thread(void *opaque)
         goto out;
     }
 
+    /*
+     * Only for old 7.1/7.2 machine types (preempt mode supported since
+     * 7.1).  Connect the preempt channel only after multifd channels,
+     * because some QEMU versions (v10.1 to v11.1) will assume the order of
+     * channels to be: (1) main, then (2) multifd channels, then (3)
+     * preempt channel.  IOW, (3) must be after (2).
+     *
+     * multifd_send_setup() makes sure all multifd channels be connected
+     * first, then initiate preempt channel here guarantees the ordering to
+     * those QEMU binaries.
+     */
+    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+        postcopy_preempt_setup(s);
+    }
+
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
     bql_unlock();
@@ -4009,16 +4024,16 @@ void migration_start_outgoing(MigrationState *s)
         open_return_path_on_source(s);
     }
 
-    /*
-     * This needs to be done before resuming a postcopy.  Note: for newer
-     * QEMUs we will delay the channel creation until postcopy_start(), to
-     * avoid disorder of channel creations.
-     */
-    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
-        postcopy_preempt_setup(s);
-    }
-
     if (resume) {
+        /*
+         * This needs to be done before resuming a postcopy.  Note: for newer
+         * QEMUs we will delay the channel creation until postcopy_start(), to
+         * avoid disorder of channel creations.
+         */
+        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+            postcopy_preempt_setup(s);
+        }
+
         /* Wakeup the main migration thread to do the recovery */
         migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
                           MIGRATION_STATUS_POSTCOPY_RECOVER);
-- 
2.55.0


