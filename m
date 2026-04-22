Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D88F9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV1U-00046E-4b; Wed, 22 Apr 2026 06:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1P-00044S-MU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1O-0002Fp-47
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTd2Ekr+XluWk1nJp1NBPmtWaX9aqM8Fly/x7d8Kr6Q=;
 b=ewwZ/Rb29JOaeDw+exOZjcpEfI5GuLGNovUrk8K6L1CK0si8KmyLN5hXbUFhoEGbIj9V+T
 TLMUIXk1gfNDm4k18DONNAD/KCqR9wl5JXQSZ/1qS+OyAv/eH3lCxMwEPyLKiZnHCFytLW
 i8P0YuJIE7x/zMEJLQKW3XbrizXMnbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-x5kwd2v5NCCNVXI1kmkKiQ-1; Wed,
 22 Apr 2026 06:41:26 -0400
X-MC-Unique: x5kwd2v5NCCNVXI1kmkKiQ-1
X-Mimecast-MFC-AGG-ID: x5kwd2v5NCCNVXI1kmkKiQ_1776854485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A3CC19560B2; Wed, 22 Apr 2026 10:41:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9D083000C21; Wed, 22 Apr 2026 10:41:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/40] ui/vnc: clarify intent using buffer_empty() function
Date: Wed, 22 Apr 2026 14:40:07 +0400
Message-ID: <20260422104042.3936506-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


