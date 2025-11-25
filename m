Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2014D0EE1C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxB-0007kn-W4; Tue, 25 Nov 2025 15:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwG-0007CK-5c
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwC-00030v-3Y
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c8c5v+0jpdumCrxkT9SiY0lxovBK7mZ5TDU5iM91ks=;
 b=AGDG2KKXsht0SOybB796WzA5BQ2x+ZTQl1KMiTIuX3hHriknfoeIzPV1sz0BJfiWZiESrt
 AAapvTmb0Pn/BkIH41ks+JfcYq1m7CZK7wAgQ5XkSGeOuH0U9U3oDBpgJ165oa6ZxZd0gW
 0qH88oLtsf4ClliucJwbrjyz5Jo2rvI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-m1HVZE80NlOCy10CG_VCiA-1; Tue, 25 Nov 2025 15:46:58 -0500
X-MC-Unique: m1HVZE80NlOCy10CG_VCiA-1
X-Mimecast-MFC-AGG-ID: m1HVZE80NlOCy10CG_VCiA_1764103617
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b29b4864b7so484945985a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103617; x=1764708417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8c8c5v+0jpdumCrxkT9SiY0lxovBK7mZ5TDU5iM91ks=;
 b=Azr7bNJ8tH63awXc18cNLI4owswkV2ULxj9XMZ3+uIjY6+ZT1AxLSha3IMMCsRi8eV
 nZ4adMYfhGeJyNCugJXx3VSx8ObMCRtiAPZMT3OAJ68BB97KU09HAK21b6SCpzBYi2X8
 xUUQGIdo+aVLlAat0aD4kobDTL5hs61XBRdok/Arvg4UZtm5kmzSTYYdQkxhadIO0ica
 eta+DDMoTOr5Bxvtgec+dseTwLI6m2im46+sLlUqgGW6KiQP/zpJJqppGRqYY1elRcyE
 3y+vYNMAy8d26UF8/e7+/3mgUyf6zVysTmFYeglG794ENK7YtSRR0TAQsFxfw10ZeYXV
 MlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103617; x=1764708417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8c8c5v+0jpdumCrxkT9SiY0lxovBK7mZ5TDU5iM91ks=;
 b=fQGv1jCh/4skD7fqIWaVdLRiV/iZbazuQIxgVtJNRsToWhtjhdhD3HuhQ7kLTx5N7t
 hs3qTq1Dg1fG5zwTNPzZpYlSGrGAjaNkPMHYZFXhhGnj8bN8mYj6FebbJTB7gVlpTsO0
 /GilpOx3SGG0EL0v6B6egAPwahD6lDRPGfs5Pf5h8Y8yYsWdX3YfKD0SZDHFhDUKYRjt
 WWvJmE1XbtRkkw6rALZUNA2lBzgcn11sMDDCZ7L/7Skw1bOFAaYa17WnbYXCsWo+pa9M
 bp2OFOzDTIZ86H7ImNp7QkO8olLw5n0Dv/0bGNUjq+2BYFiN8fsSXGNG1MGuLB2OtwDp
 Ai7A==
X-Gm-Message-State: AOJu0Yw1GzJ0APv1WkmUmp1kZGjbJ84crRACvi8II7JAlF5o1Cdtbp8H
 KOJwIxfDXjk6Pq2SqHqt9Lpjp/ODj60d0GiNTOZBO4xBkMsPfadgYkC9tF1c73ZDbISzoapsuAY
 NRd4fSNK1Ns/yiIk55UzQ0Tbw4PvQr6Ybucd/lbdZXyKQnPX0HApF8qr9zcED9yL3AVZGVDTTTZ
 xL0xAAMkiseHVLayiVisRsRknbmD0t6NaltpH+1A==
X-Gm-Gg: ASbGnctksAeaRCvAT61yi0JAdHrS6Q92/wWLtbOSO1s53MEDXQ8hY6tH5bVtFKpF7YE
 EYlTnlXyzP4k+7jk4XgRyqYFssRgYngZ3zNYmKYQJNbZ5trUGos5tz6fu7a9xeKAT3+Hg3RGXpD
 dCwecKV9Xz16RVJg0hRwKi+NCJUSSyA6WsaTaTwT0FI+swT+B9VcO9aip20pMhOcddL/2MeTcQN
 QA1aj73ydctopz7RMCUbDYCqk1Sm7PSn4K5zFYJCStUBN8MMR+eZwqav1To8f939gexW3ZGq6JW
 NRq5qx4klWmERJ7WWh7iR5FdRrkLFuQO6pqOw1S6vOiPmtm7FVuKm5wgOBZ/ITRyG3tbqhkJZOM
 8dKs=
X-Received: by 2002:a05:620a:29cb:b0:8b0:f2bd:4762 with SMTP id
 af79cd13be357-8b4ebdbf290mr597345485a.75.1764103617114; 
 Tue, 25 Nov 2025 12:46:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6TG8CyW5GaUwqdDncArC+Gg+TF3VVw6OhfLayABdV8f08WB1s8vriY7ua2g/r+mqWtI+KPA==
X-Received: by 2002:a05:620a:29cb:b0:8b0:f2bd:4762 with SMTP id
 af79cd13be357-8b4ebdbf290mr597341185a.75.1764103616614; 
 Tue, 25 Nov 2025 12:46:56 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:56 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH for-11.0 5/6] migration: Make multifd_recv_terminate_threads()
 own the error
Date: Tue, 25 Nov 2025 15:46:47 -0500
Message-ID: <20251125204648.857018-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125204648.857018-1-peterx@redhat.com>
References: <20251125204648.857018-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make multifd_recv_terminate_threads() take ownership of the error always.
Paving way for making migrate_set_error() to take ownership.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 930eee9949..c861b4b557 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1068,6 +1068,7 @@ static void multifd_recv_terminate_threads(Error *err)
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
+        error_free(err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
@@ -1434,7 +1435,6 @@ static void *multifd_recv_thread(void *opaque)
 
     if (local_err) {
         multifd_recv_terminate_threads(local_err);
-        error_free(local_err);
     }
 
     rcu_unregister_thread();
@@ -1535,7 +1535,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     if (use_packets) {
         id = multifd_recv_initial_packet(ioc, &local_err);
         if (id < 0) {
-            multifd_recv_terminate_threads(local_err);
+            multifd_recv_terminate_threads(error_copy(local_err));
             error_propagate_prepend(errp, local_err,
                                     "failed to receive packet"
                                     " via multifd channel %d: ",
@@ -1551,7 +1551,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     if (p->c != NULL) {
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
-        multifd_recv_terminate_threads(local_err);
+        multifd_recv_terminate_threads(error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
-- 
2.50.1


