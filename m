Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05194CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAJ-0003cJ-Gd; Wed, 07 Oct 2026 04:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEINT-0003Sd-W4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIND-00078J-RP
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791343803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqpRJxQS+iNTJ0+npVm/fkKuNV78OA2rpfF1fhhaJNk=;
 b=a/gT/uuaM1NacdagrMwMkjijQEf9pRCNKOgwlxyUsx7oKhKGHDgbdl3wE0KojEnwtgaeCf
 dX7r0m6urPd6sgmBDkAVtYbvX8OGO5xpct0qe3JeSiTUYDwzUpc6d7hhp7r4dRIbyg7Klo
 K/z793thXDQHk6A/jrWWZ0dq87El0JQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Z_LSY-NMPv2-Unow2onxNA-1; Tue, 06 Oct 2026 14:20:52 -0400
X-MC-Unique: Z_LSY-NMPv2-Unow2onxNA-1
X-Mimecast-MFC-AGG-ID: Z_LSY-NMPv2-Unow2onxNA_1791310852
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-534f3fe0236so57007651cf.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310852; x=1791915652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cqpRJxQS+iNTJ0+npVm/fkKuNV78OA2rpfF1fhhaJNk=;
 b=bmTnbXAeYJWjO6ZYnzz46H4n6akpr4PiONQm8cH9yPXKIwRAvcdMiM1KVXjof4Cg/v
 ZzqziFGHwLsEkDhyXYzXkaUIl7NBxt98aO5hkCrFwkjgo5W7vqOoYne/v+hC/u9jFWtM
 SLSG0J3KLMFBnRMlRjG5ven0NDnnDRKirYwzb89se98jhquHnkUZFiVonE6AD2sJCWrx
 gp0XQTfoYgsASlAnsO6ljUc5orX4qR3Wuwq5q5HLbG8tgYB4ey3AVkOnlZUi9a4NJCmB
 ArtcwxNSWVM8VKMHaPGXkeMC6bJJPxXMRct4DQauef78rGkhK8VMeC/C+GUL1D1NH9tY
 tKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310852; x=1791915652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cqpRJxQS+iNTJ0+npVm/fkKuNV78OA2rpfF1fhhaJNk=;
 b=fc7ugjfoEwy/gNLeAtgC7y4e3Do03fQQBljOHHx4zuwUvRzMf/I+konlmWqBXgqVut
 qP/kYhiCdLbm1CoGug9YA8wciVmsn4wZZliI/hfRJxRUBOYHg66TxCcCHIYKnsqQWggv
 OyTIIJJ/rUJwp6kafFsRiTW4o/jrkhkJCCZ7jZ+4+e5a+6Fs11+em861bRrVep9qJpkI
 Uwsk5/lk643I9sb/SeNU32NxEZjvYn47ov0mV6C3EWkTHAJABNSzvvBFsgDgp+ZrKgPe
 +fkk9OmzaxfOxPSBLWW310Y/xSfHYmbaKz3No4qdc/1aB7/k/EnS9nahOjQy+3M/aR7L
 q/SQ==
X-Gm-Message-State: AFuF++ly2QYbRwLLdizZmvk57pRtdz3gpkZDjf3dRzG9gVs+QBmb8ahZ
 aDAxDaheUSSLa8fgi2gwdTNal/fUZksUtOkW8jTjFiXtTKTrp03emq6CMsj1e8lVsD9ZoeFAH8/
 Bl0cZmM9AHLUr/LRIjdBzWXCpUqFCRUU6mXNnk9ooBOmkJ4vPuVzrKEKw6srLfapdX+/lvXCOmb
 P7pRA5FGR9Tfs3PE8iYzs3dOkSTvw+JCakxKmhlA==
X-Gm-Gg: AYBFou2sUCXCVenIMD+fqwQHAcJGM18/VUjtetfiioAUGSueNLPnU1cskTBb9neE1k5
 j4Od5lcYNJcAY5hzsDbxk5fWQzKITk0WYcx0q4Y78OwnBEDfus1Q0dCc7LNd7zZbzksy2bv5nFM
 weJoEJVCxHR8A4f6JLIlPtGfZniM7liIm18C2xpaAnobnFkZertw22zZ4t+VFnCJueA4nHGiPKm
 9ip6W5x8CR/OG3HckW/2vNArzju/0pzFLP5VNdm12Y8+cLqXXK+1t8k9p4jyGauB1nS7nqDWt0X
 MU4mB7P4bWKueBwzHn2JbHbZXH7LDbACfcZwP7kG4B27VJADvnlzjicX77GWzBIpkvAhXEI=
X-Received: by 2002:ac8:5f10:0:b0:533:8cc0:2e17 with SMTP id
 d75a77b69052e-53566d94c2emr35082831cf.50.1791310851556; 
 Tue, 06 Oct 2026 11:20:51 -0700 (PDT)
X-Received: by 2002:ac8:5f10:0:b0:533:8cc0:2e17 with SMTP id
 d75a77b69052e-53566d94c2emr35082071cf.50.1791310850728; 
 Tue, 06 Oct 2026 11:20:50 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53571f162e7sm1995671cf.1.2026.10.06.11.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 2/7] migration: Add two more trace points for incoming
 channel mgmt
Date: Tue,  6 Oct 2026 14:20:41 -0400
Message-ID: <20261006182046.3767283-3-peterx@redhat.com>
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

We have trace points for both multifd channel and preempt channel when a
new channel is established on the destination, but no main channel.  We can
normally deduce this by analyzing the socket channel tracepoints, but add
one for debugging purpose so in a trace log we can see when all channels
are established.

Add one more for start / resume of incoming migration too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 3 +++
 migration/trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index fab7949fe1..3ffc0c2c6a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -852,6 +852,7 @@ bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
         assert(!mis->from_src_file);
         mis->from_src_file = f;
         qemu_file_set_blocking(f, false, &error_abort);
+        trace_migration_main_channel_received();
         break;
 
     case CH_MULTIFD:
@@ -918,6 +919,8 @@ static bool postcopy_try_recover(void)
 
 void migration_start_incoming(void)
 {
+    trace_migration_start_incoming();
+
     if (postcopy_try_recover()) {
         return;
     }
diff --git a/migration/trace-events b/migration/trace-events
index db911fe6f2..68bcf12dc7 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -200,6 +200,8 @@ postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
 migration_call_notifiers(int type) "type=%d"
 migration_request_switchover_ack_legacy(const char *requester, unsigned int switchover_ack_pending_num_legacy) "Requester %s, switchover_ack_pending_num_legacy %u"
+migration_main_channel_received(void) ""
+migration_start_incoming(void) ""
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.55.0


