Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A56D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9py-0000nm-Mb; Mon, 01 Dec 2025 14:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pv-0000n0-Q7
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pu-0005I9-Cy
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhlRpcavjCvGF29D/uw6s5hCLFCnLOe1fbEz6fTyAew=;
 b=goWIx8GeMI9cuAiNx7OQi2Vd79iK7D8v0rXWo/yIJF4eVAoUZ8Hpcja3WKBdmlRS/cPo/Y
 0VOdgDfTsrVGMvo3BZ56N2kqpjb5xxEKEejFJZWsFtxxPmg4KXkZZelezWXVjZuytLY127
 pG73925Wx/FZ7wTAjQXrLLxdPPofiyk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-nR9j8snTN5u4ae-ChpB14w-1; Mon, 01 Dec 2025 14:45:24 -0500
X-MC-Unique: nR9j8snTN5u4ae-ChpB14w-1
X-Mimecast-MFC-AGG-ID: nR9j8snTN5u4ae-ChpB14w_1764618324
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ed6e701d26so84669911cf.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618323; x=1765223123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhlRpcavjCvGF29D/uw6s5hCLFCnLOe1fbEz6fTyAew=;
 b=PeQFjkSsfhrAumE8BzRmuMFDTXQXSc8dG4z821SDsIDgjJW1hzHX92jECkSKB6PzAs
 DKeIQkRpZUbsQicHAxeO1+ft7YNySx/PX7xVLGS2dcbyy9XEhHJH2XEVaxli8OcRGopP
 i80PiSdOqLdB5Q8799bCQfs9f4/2ctOmnZosqjoGReFT8hd6hitOs7LlSVQOO3P+uzD3
 j/D5Xr6tBP3MDSfVLbRIF4k8umjNODB2cj3XGYGPBclRZarllx706huSdl/i7IH3gDPY
 8qxfgypyc4Pi2I3c96yY4DsxOfSj1Ba1cSE0LLMgxwqJlVpMNHmUkm2ESK4Iel99PfIB
 lzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618323; x=1765223123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fhlRpcavjCvGF29D/uw6s5hCLFCnLOe1fbEz6fTyAew=;
 b=XNMBox4tivgsaSlbCtSH3b2kHVe6YvbriuTVKxXvgPK6j/Br/tfxWhOogdM1o+iJG3
 wDyiX9yYaE5+Xg0f8cJhUURFYzzYW2M92Z+J9S3XfOzrNy8r2xjHHq1WgEFR05Ka4KkS
 oEAxQjMI4dP82xbNVlLSjwTdrBWDMMuayH+OHPbol91csz+eNDLWuuQpy6pCTse/j5+O
 77NGTKJ8xakSryejyC8TrTuNkeRvFCf177hanTAgpB3/9UJUZ3QbFqxUSSEHEvfrs68c
 hun3XntCQpVKCF6YLhT5xbgdXJwBwxOePYiDejRGvsq4v5RpdaTD4TXWM+390BYY4zim
 pSrA==
X-Gm-Message-State: AOJu0Yw7H3N8Cv1wr5TJnJjRuV5b9+FkarClSb93Ohc6jyYr+x/ZIosp
 kIfGQW7V2DEuFcsHPQLE5n680Q+My2pHjEMCmuJ0WZ5lx1EQNvykFtVCfSWzX7fUBkOB7JP/RE0
 TARmKeRvTBFUH8DeOCCC3MCEf4+X3h7DmG7mUj6HyJNeoCQSp3TEUEbIjpaxMRInitqLEypbW0c
 eYSGz86TPLq8xaih+dAatMyO3P/03ikOHB/klumA==
X-Gm-Gg: ASbGncvRkMyuuqyca+tEBWV4Ajbj0V7oIXWNXNt/zfgjjiOZ3R5y5H3dZGTiEJSQIUC
 Jv95NZ8D8eUi/92+dtneSMqu6fYiYt/HYpSov54qJhPCWQgkL1UEcDJQwUHx0f+nMd2ofmDVFoA
 OuObhLDDAgnMHFNmwhKnIakl+DBfyrYF2X6gortYkVEzDziM3e7vyOguHe/QjF251ic9IDtWL68
 GSTeJTXEjweot0HlQ1xQx6F8TxbUL3VrK8o+iqXBWkHXiXyBMNSdmDRw1g7iFNUnwMtfzu4tqfm
 zePFzNkn3y3bEPuWG2U+xzXRNC25efahqsvboZYaBo7oBygo1BgwNEi+mZFutbtH2OjtuY/QZps
 B
X-Received: by 2002:a05:622a:144c:b0:4ed:b012:9716 with SMTP id
 d75a77b69052e-4ee5895b9c4mr508296191cf.80.1764618323144; 
 Mon, 01 Dec 2025 11:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOIrg9RsmQ/oAhu1v2Yo+uLIG7J9YKzMFgd9GJn44S+bTaXDG+xtCBRgIjHju42aWIItJOSA==
X-Received: by 2002:a05:622a:144c:b0:4ed:b012:9716 with SMTP id
 d75a77b69052e-4ee5895b9c4mr508294981cf.80.1764618322299; 
 Mon, 01 Dec 2025 11:45:22 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH for-11.0 v2 6/7] migration: Make
 multifd_recv_terminate_threads() own the error
Date: Mon,  1 Dec 2025 14:45:09 -0500
Message-ID: <20251201194510.1121221-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 651ea3d14b..52e4d25857 100644
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


