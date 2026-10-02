Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA80CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb3Q-0001XY-G2; Fri, 02 Oct 2026 07:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3O-0001WD-Lz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:50 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3M-0008VT-RP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:50 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso24683405e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790939027; x=1791543827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9tN+AxFYSB1fAa8V08Lpm1ZM27JAKqWIOqROhNIAGb8=;
 b=hMSDut8FjMGKUJAPtqLdAB6DFT5wrVnPgOfi+rCb65Sc5iIS+52Fw3dadfh3beL9Sy
 b4CcIajodwsKqH4V6TvqCoP8eK2npm1cUQhHSLA9HtGD9TGii9hTmJuXDJC/LQoMjyfr
 Iq3BoUSrKwYa95L8KrwTX89usUxE8VElxaRPVftg6KPG2hh5E3BJRL+fncdqTHwbI/vE
 dWPV05/s8QjUxG2y6zeDLBO90DxBRjDd5w3c4kGjf9EoluX8s+UPlr4koarOXE8hE9Vp
 5pwerpXm/IYBQ003rRdE3AQ62L30CNDKMVIyrm7gADRjwIYJhxSEdXMZ4Zm+KEELyikZ
 2vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939027; x=1791543827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9tN+AxFYSB1fAa8V08Lpm1ZM27JAKqWIOqROhNIAGb8=;
 b=ysSPyNHRLwHn5smu5rQZ2DCgcyq/YkWbz1ouXpO9NZNAuNZYKpppVJQEo17cdAndAB
 hyOxDv8xU+bjCiJpDB3vo1sa4IIW84LWw5wy7WDnY5uQG04tqmDAQ6VKZv1yli2q/uVj
 s34Lv0Auc464xyAffUlTq35nKyOnCsvhhlXt482TFc1FUW4ylz64Ovn+8TqFXB1bVCE3
 ot1v7dPf7Aem9y6UOtN02cSOby1XRb43PYdrmOpPs9QknomLSQlc3/f9Xx1uaHRIz08+
 Xszw9vfXYMHNnPl4bkZhEOgY0Q3PDfUERfKASg01CQcw0GSB0fvKhJpUKFyD+LsrCp1n
 e8AA==
X-Gm-Message-State: AFuF++n6Sh+DKHBNNtzfbbVyA3+deNKdoCx+7yWanNud86zKWmEICRUk
 lcqNV033U4RqY7vkkNGlXTldtpiiPeaPpQiWE8JTc8j+/rjxkjf2GmY9rVTV1QspNvqstNRdj/f
 Q7Bp5
X-Gm-Gg: AYBFou36KNPSuUZPUeyZz3HR7smVl5Vl6JCtd9cWERnrfs9o2xP62Zs91MOc2L57IJO
 X7qJF4AQjCIemhldJtIGcY3sIjPSVoKlGDi1ag8HrHWeHF7FQbTvyFUBTc7pPNbLaMdQQMtWr2E
 PKcG5rlfT81HoLrPRYZmsahjVek6tCAlU2KZonUOc28tTVrrn8AlHlS29HgjHgvNOy7aXkArcZ2
 rr+D14y9BG0bTE4EbEOUTISHX8Fobe7o4ve90iez3TFzoxqcIqbiTzBNbCEkvCeR6RhVaq+0Pzo
 c35SHpVTpWIJ6r1RM1AU0LswIrrTdxTPnfAmPOIGa2mlxhj1n/r4UH1imfdpgil2e8mCcRq7m0R
 LXYnuKxwu0UBWdcbO8WPfstUE0iwPQnfHrhvYD3GU1FkaXExS+ka1GcelmXNQR3AhOicuv6kmiN
 cfc+WyTe8WrbxykN/711cjtRFoDsgEDPxBqZPXY0SfyN3sR+xlSefJ87IemwC5U0VwOvw=
X-Received: by 2002:a05:600c:1d09:b0:4a0:37d:9e21 with SMTP id
 5b1f17b1804b1-4a0276ed19amr41398095e9.29.1790939027268; 
 Fri, 02 Oct 2026 04:03:47 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9f21:a362:21c8:d9a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm24533785e9.2.2026.10.02.04.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:03:46 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 4/4] migration/postcopy: answer the package-loaded ping from
 the run BH
Date: Fri,  2 Oct 2026 13:02:58 +0200
Message-ID: <20261002110258.1835979-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002110258.1835979-1-den@openvz.org>
References: <20261002110258.1835979-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") keeps
the source in POSTCOPY_DEVICE until the destination answers the
QEMU_VM_PING_PACKAGED_LOADED ping packaged right before
CMD_POSTCOPY_RUN. The destination answers it from the generic
MIG_CMD_PING handler as soon as it reads it, so the source's
postcopy-active means the device state is loaded, not that the
destination has left RUN_STATE_INMIGRATE. Management acting on the
destination once the source reports postcopy-active can still race
with loadvm_postcopy_handle_run_bh().

Record the ping in the MIG_CMD_PING handler instead of answering it,
and send the pong at the end of the run BH, after the run state change.

The wire format is unchanged: the pong only arrives later, and an
older destination keeps answering at once, so mixed versions
interoperate. The cost is that the source stays in POSTCOPY_DEVICE for
the duration of the run BH, including block layer activation when the
destination autostarts.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c | 1 +
 migration/migration.h | 2 ++
 migration/savevm.c    | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8944acf3cd..f93f99f30e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -495,6 +495,7 @@ void migration_incoming_state_destroy(void)
     migration_incoming_transport_cleanup(mis);
     qemu_event_reset(&mis->main_thread_load_event);
     qemu_event_reset(&mis->postcopy_run_event);
+    mis->postcopy_package_loaded_ping = false;
 
     if (mis->page_requested) {
         g_tree_destroy(mis->page_requested);
diff --git a/migration/migration.h b/migration/migration.h
index c65212ff63..80401391f8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -110,6 +110,8 @@ struct MigrationIncomingState {
     QemuEvent main_thread_load_event;
     /* Set once the postcopy run BH has changed the run state */
     QemuEvent postcopy_run_event;
+    /* QEMU_VM_PING_PACKAGED_LOADED received, answered by the run BH */
+    bool postcopy_package_loaded_ping;
 
     /* For network announces */
     AnnounceTimer  announce_timer;
diff --git a/migration/savevm.c b/migration/savevm.c
index bc1bc98a0e..e20471892f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2267,6 +2267,10 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     /* Already POSTCOPY_ACTIVE without a return path or in fast snapshot load */
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    if (mis->postcopy_package_loaded_ping) {
+        mis->postcopy_package_loaded_ping = false;
+        migrate_send_rp_pong(mis, QEMU_VM_PING_PACKAGED_LOADED);
+    }
     qemu_event_set(&mis->postcopy_run_event);
 }
 
@@ -2618,6 +2622,10 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
                        tmp32);
             return -1;
         }
+        if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
+            mis->postcopy_package_loaded_ping = true;
+            return 0;
+        }
         migrate_send_rp_pong(mis, tmp32);
         return 0;
 
-- 
2.53.0


