Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB0F3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q9i-0005q5-P0; Tue, 17 Mar 2026 04:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8w-0005eL-0v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8t-0002gY-O4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1TdznvfNo/kLR4VJ2BTsWYY5GiN7ppg+wGeY50m1ko=;
 b=cVLorUcZS2WwSNsbDrZRqZyPLgsG1bNnKAIOPr1G/dzRPweCVnzTEkBB5NR0jAIglMJb3k
 NI8l/O9uK7CVEBjuvHFz9hG0hmDEd+UfwxsxqARFM9uRtD6v+w7wWt+0nsr5Nv0vnAs0Ys
 Hn5WAibPJbyl9Tnt2KTOSZEKjQxT0PI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-cJlvGoeFOt698YnLvwtXHQ-1; Tue,
 17 Mar 2026 04:51:05 -0400
X-MC-Unique: cJlvGoeFOt698YnLvwtXHQ-1
X-Mimecast-MFC-AGG-ID: cJlvGoeFOt698YnLvwtXHQ_1773737465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 117D319560A1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07D2C1800107
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:18 +0400
Subject: [PATCH 04/60] ui/vnc: clarify intent using buffer_empty() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-4-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=j4U6dEjJpDeqnxOtsFHIu/TPbBPNsN4KR/RfvB51MEM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXaxQauwEZJjMtxnCzxzZPR9z7YAD2W+s5j7
 odo7ABm9IuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5VW5EACVRtgWpW8GkB2VnJp+ZtVPH0ZeWooSs7X6yJv8TtlZ8JjvQH2A7NPR6Gp1uSqC6eDeqXI
 NEveb1JycOkkss09nhwq5OfigSua7Y++0xFn12oJ5NLnVhO4B3Gc6yL9y/4T7WyqrFisPqc5DCv
 ooUTDDq257n7AuC/0E8kjpPJOUS1tDDDunsV+QQeVeXUfEkfPUCFIhQbQKu5rPh2W1Li3bftwhD
 9fGjBRA4+MwMZ5i7Nw1v/+6nKwWfIsiR45BVSqOOzzRIHLZVfp64Zzwq5btha8FbC1PzrcZON7L
 oEGaM2LOU2I7TGveNs1DEYUkr3hqhaz6V8b1YFipnJXSaTa10mDRyyKwya0PbRisL5HF0v4+RdR
 2zxP2tRcWIyQUXS1OZwS2SHxSpHlDmL25lgKJYzTJzNyydSdNchwnSY9rLHFLTdya8dHVIBiSzf
 wM9Ox0NtG2phJAjcJ3kV7Hmqpci9VT1KNnG0UDlp8CQGMIO0gG+AXpllw6NN7/A93j8oViOVqYi
 XLsAJuoxXmxLMRwp9n4vZk9et9OyN9vRJuRpPrDskcYtx/4J7yg1RrTv2xfNX0TOzjGBpfNgMcI
 3FOvex7YVUPXxl8ACnPGPnFiKH50PRGu4DtwRaEgfttI7qAyfCMrf9IF/FbIVnKb9UBIpdEVmmz
 5ksuZgr6tSNyCcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 2 +-
 ui/vnc.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index a6ab733faa1..4dd7ccad969 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -160,7 +160,7 @@ void vnc_jobs_consume_buffer(VncState *vs)
     bool flush;
 
     vnc_lock_output(vs);
-    if (vs->jobs_buffer.offset) {
+    if (!buffer_empty(&vs->jobs_buffer)) {
         if (vs->ioc != NULL && buffer_empty(&vs->output)) {
             g_clear_handle_id(&vs->ioc_tag, g_source_remove);
             if (vs->disconnecting == FALSE) {
diff --git a/ui/vnc.c b/ui/vnc.c
index ccc73bd7aa4..4aa446a48d7 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1718,7 +1718,7 @@ void vnc_write_u8(VncState *vs, uint8_t value)
 void vnc_flush(VncState *vs)
 {
     vnc_lock_output(vs);
-    if (vs->ioc != NULL && vs->output.offset) {
+    if (vs->ioc != NULL && !buffer_empty(&vs->output)) {
         vnc_client_write_locked(vs);
     }
     if (vs->disconnecting) {

-- 
2.53.0


