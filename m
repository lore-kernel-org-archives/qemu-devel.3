Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75EBCD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbU-0000BQ-N9; Mon, 04 May 2026 07:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrb9-00082u-K4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrb8-0000vc-3U
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Feyzoi72st3BK6uw08MumeJ0heMFM0ajonX0WOp0f0U=;
 b=K7tYd2Z4HGQPIIE1xRGRFRDCgGgU/2aEFLLhRDWysWlybHoNJZVEyX4jpeT1inK8LAhG6x
 7TrNfoC88RqBcqHarbKa3x99PlrA/9DGP0Z44fxVBMviV9XSiMiWV8lsj/sLUQZZyiT8zt
 pXUpY5zbt3CQQYHg0e3Qg23gw68Z+CI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-Pwc5-e1MNqSPd-zVpa3VCg-1; Mon,
 04 May 2026 07:36:23 -0400
X-MC-Unique: Pwc5-e1MNqSPd-zVpa3VCg-1
X-Mimecast-MFC-AGG-ID: Pwc5-e1MNqSPd-zVpa3VCg_1777894583
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF4E180034C
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9AE81800347; Mon,  4 May 2026 11:36:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:00 +0400
Subject: [PATCH v2 12/46] backends/cryptodev-lkcf: skip cleanup when not
 initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-12-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XKESI/0DSqdUBTRFIDl2KEKlv25ZaJ+0o7RYfGRaK9M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsFkq5gFoGkhdtbX0XtTDFatKfr3ENADZrN
 KHIfiztfiCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5S6vD/0Qn/ePgQg1XfJ43ptN3E0NTKDPf8P2rc3lhhVr6HatnbxRMZyv3cckuT55Z5ls7sKtJSg
 AowLOFQHMGAr0NhjTmtH9x4TO0GdLxiH8PBdXFN9fKvEJvmmF9ajzOpcmuojb6/qs6Z9yuO9iV3
 SxOua5lZyXpQoMbWKZZsW+ooB+TzRqgk7D8WHFcYXbMVnPP/pcOraYRFBIcPQECoMYx6gffMeKF
 Xa7f8q6SuIOLH9U9/kATD+TAsaL9eIqr1UEiGM1Nkd8qDbBDHhmsmpyzXVO+hePrbhBJilhwdCh
 OFhWFz4zA9zRKwbCZMYWFRMaKi+/bPGUgvE5Uvlx3YtnmzuqCqhtVKSaM/RTl0I9HyqYSTNhCE9
 maQDKMkPQ0JkjEzrqc8hfQQKqJvRVi0OPN6VMSVVwZM9WYzdVlaXJdlGC7UF7+7tNr63QVQlAF3
 zn3bMPK0OYXv7qRiOovnfUchN8Y9M1b1h2zUuFXFTCsEDBZecBJnLZdGgHTOj4WvlJGrUdU1hqz
 3duQ9I5nUm2AiQBq0oMy/NwntzQxnoRADqdBX0lM1yRdTxDqYTvsoq3v91qFJL36z7Khl+l1xLv
 Lu3z1KRTfDX+fIAFG9xoFKEp8xsiQMEooK/ZDJoRxqT8b70Ded8qf6drMh2rXAmmahN8gDKiGET
 bgUFotrBHM1hj0g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

cryptodev_lkcf_cleanup() locks a mutex that is only initialized
during the init vfunc (called at realize time). When the backend
is destroyed without ever being realized, the mutex is uninitialized
and the lock aborts.

Return early from cleanup when the backend was never started.

Note: it looks like cryptodev init/cleanup callbacks should rather be
regular complete/finalize overrides (calling the parent method).

Fixes: 39fff6f3e8b3 ("cryptodev: Add a lkcf-backend for cryptodev")
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


