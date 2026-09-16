Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C9C982D0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJM-0000mP-Fj; Wed, 16 Sep 2026 17:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIq-0000j4-Je
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIo-0007bS-Ua
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6LO977wvI2xcfln2SzfX18ONYi8bEpf5XH34bvwTKM=;
 b=ChNW4YPVVtZveytNtNC8e0YxLEPHzK06Gg2YaDUellwt96fXko/yPxfgnUCr02T9Tf1/+N
 FPmv7MSlXJXdJSx7qhVbOg4YhvyWNbIqj7i7oST4894hYhxOi5QZi70oC0pnNTLD1vnSHN
 Rup3RFw68sYYkARWKQoYkRvftV9jX6Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-4B2ZYE7sNtKLedbVLMTklg-1; Wed, 16 Sep 2026 17:36:15 -0400
X-MC-Unique: 4B2ZYE7sNtKLedbVLMTklg-1
X-Mimecast-MFC-AGG-ID: 4B2ZYE7sNtKLedbVLMTklg_1789594575
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a3f673221so41238685a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594575; x=1790199375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G6LO977wvI2xcfln2SzfX18ONYi8bEpf5XH34bvwTKM=;
 b=agMT8ABNYPDAqOz0eJW6FXhIBzoGWGsS3n2d97CxAQbk1Pky8LpTenANPVMF+4cUKY
 waNDcyzcV+rnDKx41UyN3wQt9iMtW20ay/MX+eGyeVNIyExe8fJsldIASwvVzeXllVyz
 Y8V2uguIlkCAw2umgrkcOzrhts2HNB2jGn/rU9zCj7aTbYkh8zAqdFANa5TTqAH9eR3s
 ja764szS3zhtzpTQe/DG2SGH862Bpy2nZdZlRL8HFZwkxj9MCEiV6Kl/QuQURUJAm8Hd
 R+Ty18u/7ECKO6QIOmW9Qsl4+f2frSl+1rfmjLpoqGjCbWnrqI5YK1WPhF+VojBgpszF
 GTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594575; x=1790199375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G6LO977wvI2xcfln2SzfX18ONYi8bEpf5XH34bvwTKM=;
 b=FTx96WDgxj1AVX36DWAruu17YtknXvuujWj+snYea0A5Dq2Vq7FpcJVSJhCV3Rj/R2
 EBCm78J5dd6AiCwVnHKeyd0pkYQT8xC4aK2Hh+Y5aopoEn1mFZoHvRh2VpavRL6K8Evq
 O0Zg9RpU+9R3sALEN1zEec5gMvFs5VsWCa/loJQLWIPhbwkLa55r/uO6hwVYBBzKQBm7
 etURzNedNhkrC+s4sQkSmaWL9Uqip0BM7hhzegfA+CxXO9YMgntFaE/cialxu24QMRln
 ADBSsBKvYTDxIze91ksXeCdpcxBjb2P03ZzL7iCE5sIdw8DdYzwjBSkWik7SBC1fWCEm
 INPg==
X-Gm-Message-State: AFuF++mvm4p88f+gKpy/BqLvGKU9gyydH/fxjh83DlAKW6lNZ5pXdJlt
 5jFM3XAeo8k7iaalLGiHq8zI7yJ4ZczZH3VV8hZpHxN2ItkE3PlNOsUKqIXHXhS26lnzqHOhzQN
 fkgfkUFUxIQcx872WQ5FKJbqOLzQmi5LQ/L9qWdNkeTEdeLArTwv+r2qTEFIRUnjl5sQKkBoRUc
 KOzJdJ6tatoEpcTAiCa/qL8i+w2KiEBxcrSA4IwFNC
X-Gm-Gg: AYBFou3g/i6iSPNYbuuw37/9jOGoQ2VQ0g6d2YfYNlJDgmReImH2zNE6E5Ck3p+cMs2
 qKGYlqe3HtjE86nZxzkPnUAlQm8iNpXDsJoncM+C0p6lJlT5EajjYO6B15xx3vUmr6MuFUXB1ic
 joaxFMqXce+Xdo14jv4NU1w0FjwwNtd2Aifsktj10cwjOn6G6XctIYK2BWm07017WSpO9Q/fy3C
 07wrsF4oAmUYo3uQVi+vE0zZwScKsC4Hr8swqDLEeGTpPoltiZsGb7jLtBrnn172VUzPNJb/XiX
 TnD3/gu1XEBu1+Eo2sA4aplHoaJYyxHbONS+ldp+MGpGS7pC44UA6r3y/VNPdr64+jKp
X-Received: by 2002:a05:620a:43a1:b0:939:a834:98f2 with SMTP id
 af79cd13be357-93bb770c70amr697956785a.15.1789594574657; 
 Wed, 16 Sep 2026 14:36:14 -0700 (PDT)
X-Received: by 2002:a05:620a:43a1:b0:939:a834:98f2 with SMTP id
 af79cd13be357-93bb770c70amr697947685a.15.1789594573955; 
 Wed, 16 Sep 2026 14:36:13 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b7821d231sm313373085a.21.2026.09.16.14.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:36:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 2/7] migration: Add two more trace points for incoming channel
 mgmt
Date: Wed, 16 Sep 2026 17:35:53 -0400
Message-ID: <20260916213558.587304-3-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213558.587304-1-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index d14beb5d22..cfadcc79c2 100644
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
index e87d4abd91..e755872496 100644
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


