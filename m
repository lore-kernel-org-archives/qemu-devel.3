Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285BED1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUG3-0003jV-Qy; Mon, 26 Jan 2026 16:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG1-0003id-Sn
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG0-0003Lh-Dy
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769463383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rL0AQZMo/YY0quRtMt3oVsuGltDVpd+3XkWVPidUEU=;
 b=LUtfCWtAXh6reztDGfXy92RnMY1w4ooHx0jSo2jOEQEmTzVE0ksEJRQIX8qEUn8wvsnCka
 L6LjPvDbdrBlwl+fFuS9NaoGoCo3n4iTzs2LeqEicoNWZCNOSc/gdUt7SJ0RADKcVR+MIu
 Amrhclt4VrSXwfHU8pRumCz/TLnrE9I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-xnaecXWgP8WovYzFhhvhJg-1; Mon, 26 Jan 2026 16:36:20 -0500
X-MC-Unique: xnaecXWgP8WovYzFhhvhJg-1
X-Mimecast-MFC-AGG-ID: xnaecXWgP8WovYzFhhvhJg_1769463380
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5014d8b3ae0so131373951cf.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769463380; x=1770068180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rL0AQZMo/YY0quRtMt3oVsuGltDVpd+3XkWVPidUEU=;
 b=ebBhY4IaVt67dpsckxvYd2ZsocfQ1DtOt4xkvjxVMxrhMLQpnJvckgzCKves47vbyO
 v/QBX3jeM0M3Zb+HqzFURoal3UiYEVMHMLE1XPp6FvcE5joLlpDIWuAZl4jqkn9gV+9r
 lw0m6Ne87a+KNjTG+uNpwsdwZOZ5t6HC8wKIn0oT9GLGx85B2n2U2LAuxtlfnB7xi576
 kQGXO4JCle6MNUh+6yBeTdV6xluArnWMbhH6lfrFEl3Z2eAYOfyfYfVMqop19ZgqG4R9
 hvA75GQjhNEGxAI8Bspa8ea7FunsHmr1pEZCLoiTYyVX+BkeF7T4up/j7qqIsPhEo5sE
 iflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769463380; x=1770068180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8rL0AQZMo/YY0quRtMt3oVsuGltDVpd+3XkWVPidUEU=;
 b=oHjBJgc6zLih+OnTFDwZbO4niN+ILuEDkojgK8MF/ygotF6C0PclXDHkSc9JszmAkr
 r1dTS5Hyx1GYuOtIUy/4xuckqva4IXu97XvFeLkLeYbUA/H0J8ILOjECI+imfx5fQO2T
 hU3i+UqNO0tGXNVZGA5zkyD03vJH82bzYDJfRS5Uim7Qa4VrdT9zngdYvmR19+oNnJLA
 Ct/I+0a27vd4mBpt3UuSnn1xeWg9MjlU3NBGhfAVPdeQicQTzRI3CycNKSUHKn8IMs4Z
 WsimApYqS/hKXwwT+E9nHxbRdjoDQ10uksKtTKrjYrs5zo+f2IqOKsIFMFWuP6xB14os
 IWwg==
X-Gm-Message-State: AOJu0YwChj4N1eYMaS3bpgIYvUV4EUcjR5q/ev7k5OjvQqwuLXvyCRJP
 /rBfc93ZuQ4iHjjKSbFSGtvNgUZPed03SXZkUxtqQWFq8T2PnAK8g1hCVyYsyo5Xkme0pssT9+h
 c6VF559YDkmaDrkPgHbDoYOl4Ik2QFtyki6obp4YzFjR8wUJ1LlCoi7z8vVvkY1QAQDb9BtHvka
 zqr7/ZScabRaz1m+OhGrl7U/hVKjI617w0On5SWQ==
X-Gm-Gg: AZuq6aIB+3R66mRODnANBtndg+Jva5Von2RsVI+KFM5NGOoAe7ycuwpLr7bV1q3iTP2
 faArQeAsCXi9UJ3YjPb1FfJzopqWm+GjGZEp3j9KU23h9jXJkODAisZ8jF5TgLOB+5BxwEf3V0M
 KDsPWJHe77NfWu19jYwP5MsEGpq6cOFEwrEX9M1EdkNWLewd3GblAS8VXWWcOXhTHTAxUtPvA87
 MowXZ3EKMBWOZ7oDiUs/Azgm2xBFRXLqYHI4oDUXo2nCt80tKY0A6gXChnGDRXrn6noHJek2z7o
 cn+8Amk1vOhUS+79+AOVKjA1cku1Z90tE2hzkhjvyPAJmYSSqQd/gJoXFWVomXeBvwAyp8RDX+s
 0
X-Received: by 2002:a05:622a:110b:b0:4ff:c295:3c3e with SMTP id
 d75a77b69052e-50314c22e67mr68533731cf.10.1769463379878; 
 Mon, 26 Jan 2026 13:36:19 -0800 (PST)
X-Received: by 2002:a05:622a:110b:b0:4ff:c295:3c3e with SMTP id
 d75a77b69052e-50314c22e67mr68533341cf.10.1769463379382; 
 Mon, 26 Jan 2026 13:36:19 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f9cd9esm89769281cf.33.2026.01.26.13.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:36:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 1/5] migration: Add a tracepoint for invoking migration
 notifiers
Date: Mon, 26 Jan 2026 16:36:10 -0500
Message-ID: <20260126213614.3815900-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260126213614.3815900-1-peterx@redhat.com>
References: <20260126213614.3815900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 2 ++
 migration/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0..341b9be80e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1528,6 +1528,8 @@ int migration_call_notifiers(MigrationEventType type, Error **errp)
     GSList *elem, *next;
     int ret;
 
+    trace_migration_call_notifiers(type);
+
     e.type = type;
 
     for (elem = migration_state_notifiers[mode]; elem; elem = next) {
diff --git a/migration/trace-events b/migration/trace-events
index 91d7506634..90629f828f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,7 @@ process_incoming_migration_co_end(int ret) "ret=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
+migration_call_notifiers(int type) "type=%d"
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.50.1


