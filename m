Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0CCF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHNp-0002GR-8D; Fri, 10 Apr 2026 15:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNm-0002Fq-QN
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNk-0000Nf-A0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=582Mq7JHgKD89nFbt457ZffKJ0pztKW4k1JqMJhynNw=;
 b=iQWewPhaxqv7b/fxx/wuitKhMbXJEmSFHeyk3rd81UNlKdAFgh9h8bQWu2kwaiDbgNylZp
 t9ZECk7dCcouLuARRs9UiLijFrW2DssdDIYQWKVcprQMySn+RpiMtb3c6BZw7rp/ARuc1Q
 xmX/wnEVsNCzJb8x/yMWmJk0368vOYE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-u6iGaDMcO7uhPJyMHa9K7w-1; Fri,
 10 Apr 2026 15:19:06 -0400
X-MC-Unique: u6iGaDMcO7uhPJyMHa9K7w-1
X-Mimecast-MFC-AGG-ID: u6iGaDMcO7uhPJyMHa9K7w_1775848745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98A5918002C0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 555CE3000C1F; Fri, 10 Apr 2026 19:19:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:24 +0400
Subject: [PATCH v2 02/67] ui/vnc: clarify intent using buffer_empty() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-2-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Oaz4HwykOBOf9JYgkJzVi5dqUDlvyrzedLzIIlA+YUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0TMZDQJ9nSmNocpX15cdsYo4DX93RlAFrK+
 4RLcdCWLO6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5YbqEAC6ky+Rv0lNUojnxjQiDx6KbczbsZjpOvvo4kNs2jZM40OKsEaqQlR4IgQ6BPKo6+UhTTU
 lTtd54nyIWymFmBcSl0ohuJ2rV8yT1Vbo/MAEi0PDwrdK/UcCWEJBRhhvFz8fs0K4Np04jpcNSG
 inr46cQIx1SeKa1XtLK623eZXRTEaAXhvAEivPyAAq+wbbgub/xPK84sLnxcbayAL8oet4gf3Ex
 +cm1JbV516v4+hYr4n811hvvvqs0hTpq9ikq64eAtLHDIk+nr8dncAplO3GCFk6qrPYeTyX4jSk
 mWqMajRaOyvBtGRokdu7lSFl1r/GEfCPaJi1AQDm2bSxZYk/NQJqaepDuDHiG5sPblW+wQkgx62
 evArJ31zEThCplTBHwQqV33Gz4vg7VdyC4Jg/TYpdfv442yKHp3RKYLydok2XOLfxVexqJQlrun
 WyIdvx/elwyPa2DK5ENy8Ul8SMZcGkLwNuRyUJUhYGtg22v+achcWDCXpSWXt4DliEH62XCwpXc
 BFpWs0vWQI2t85Da1MlyPpafjf5Is46vwaMOvbfwKhY9nH3TlC3FfM06HSiM9tjVQHCyd540oBi
 HVPXeNMEmVXgQvjkqMMPEoHqf9fmlxTREbAxeT04/6XNGUipvCaWpButo7P7VFMel1X5xgw2kj/
 pZHMw3kXrI4Sa+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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


