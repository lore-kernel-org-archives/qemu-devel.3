Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDB7CD8C83
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkM-0006Tz-44; Fri, 05 Jun 2026 11:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjZ-0005WO-UA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjW-00066w-HS
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/Cc75KG/mGn6kld4q1FR9pIIprF3eBJYHOfuAmQ4M8=;
 b=Pethh6rk/7vXpqVhtcTSaiqOmMNe3MQtmjN9JnC5PNMefv1qDozYIR+1QUBoG+nVh//CeG
 5WF2kRNCn3baJ8M5KB82DrnsEaQvqzVcIj7vS78YRwVelq6gFXstHUhLIfdojA3yHgEh3k
 ObYMCwbQkDRDIJRQx762yzbf5pPKRX4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-cuYx3mTaM-y3oIxVctntBg-1; Fri,
 05 Jun 2026 11:45:16 -0400
X-MC-Unique: cuYx3mTaM-y3oIxVctntBg-1
X-Mimecast-MFC-AGG-ID: cuYx3mTaM-y3oIxVctntBg_1780674315
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7698119560B0
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E85D1955BC4; Fri,  5 Jun 2026 15:45:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:29 +0400
Subject: [GIT PULL 09/23] backends/cryptodev-lkcf: skip cleanup when not
 initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-9-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZoIQTw/8fvWMrcbUlgAsETKAbnpCOyqqMPiJiRQOO6Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7V6tt4x9DsVqd4cs4U4gA8swuo90MGocs/0
 oKI6nHofL+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5SH4D/9xOFAIzVcWnlTCtksjuBI4jGn8iakNkrzHS9RTe7OfaVOCNcZeFlvObrY7VhL/S8vFRFv
 CKB0VEEvwDHqqEY/w+LYGD4Q5NBgDfaNsYuIAqmRdvgrVI37rB6Uac+kjRi+I4DRtgeo8LdH1NR
 BK4R38IPNnh44WPM5PauWnD3/uFjPyDRmBVv4FiKozMSqQnrs2W1WgalVmKujqaOjTcwkyVlo/p
 P0KTLfa8yzut93sme4EDGra8aSBo82vDwH9MqDNyU4Bnyf+5Gmihb4ZDHzPnmTCV+kqzvlxMGLL
 c3nQcqzn4x/QRoXxlF90ZRRPjuvXxZqLRAo3he8hZaj06Dc29K8MQXhIiA4m+ImUFUynUSccegB
 +CDf1p9kZMuO/hWIR6iN6yxA54E4pM4x0LtTlON6CIevhFHAjWX+eIH0l3/VNnNOnTIRmGe0swp
 +nhiwNSez9KZetfVWRJOjEcI/4oGJ8//FnHTPkK1bPMgL6YlxUVLoAVGdIIMKYH6ApCT0rbwenf
 N02uSbqp/FHk9P6LWc9DS2W3YU23pfmLjYJwoSVCdyFjgGwjFfvbd8YM4vYfc5FU8FuvKXcsRqt
 3m62Lak1JstYXyvPVt9ejNY1tBZb17aJiy0Jqhnqm/L+Op0kW8+/5Mix5QsLdCLdxY/EbrktJnm
 EoJo0+tlslN2V7g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

cryptodev_lkcf_cleanup() locks a mutex that is only initialized
during the init vfunc (called at realize time). When the backend
is destroyed without ever being realized, the mutex is uninitialized
and the lock aborts.

Return early from cleanup when the backend was never started.

Note: it looks like cryptodev init/cleanup callbacks should rather be
regular complete/finalize overrides (calling the parent method).

Fixes: 39fff6f3e8b3 ("cryptodev: Add a lkcf-backend for cryptodev")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/cryptodev-lkcf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 40c7bd3c5a0..3fe29d3104c 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -255,6 +255,10 @@ static void cryptodev_lkcf_cleanup(CryptoDevBackend *backend, Error **errp)
     CryptoDevBackendClient *cc;
     CryptoDevLKCFTask *task, *next;
 
+    if (!cryptodev_backend_is_ready(backend)) {
+        return;
+    }
+
     qemu_mutex_lock(&lkcf->mutex);
     lkcf->running = false;
     qemu_mutex_unlock(&lkcf->mutex);

-- 
2.54.0


