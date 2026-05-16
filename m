Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8406CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wd-0005TZ-Tm; Sat, 16 May 2026 04:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wb-0005Nr-7c
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wZ-0007TP-H2
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Feyzoi72st3BK6uw08MumeJ0heMFM0ajonX0WOp0f0U=;
 b=ZVbD47+Ng+q1k8SKktsGbIawKZ2AByC8XcVgAeENINVX4KBdYkpSxPgDwLF4LVyOIvgtO7
 9QCiQhPOjg0UdVStUJcJdKS7wd6wBT6+wEo3WuBisfi1CItwiDgFEAPsUwqnAC5vlRVKnn
 E0Ts8PzBnNhUCAt59Yw1/iFLEMJeDG8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-34Qqa2qrM564gibyahUvxw-1; Sat,
 16 May 2026 04:00:16 -0400
X-MC-Unique: 34Qqa2qrM564gibyahUvxw-1
X-Mimecast-MFC-AGG-ID: 34Qqa2qrM564gibyahUvxw_1778918416
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1E1F1956046
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AA2518001D2; Sat, 16 May 2026 08:00:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:09 +0400
Subject: [PATCH v3 10/24] backends/cryptodev-lkcf: skip cleanup when not
 initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-10-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XKESI/0DSqdUBTRFIDl2KEKlv25ZaJ+0o7RYfGRaK9M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPXjoFYqe82ja7TeolINHMRI0XBYapOmkZ2
 3rAWE/bXcOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5SGsEACDYr0SxoYLF/VScqblNrVaiqwORbiOd2bZ8ddMRNXQ0ZBbs5hoz+8JM7pNfhzHy1xcCMa
 wFJOeInRjjLr7smSIQgAWCKTrCXuZl5ErBRRhyeWbPm3QTSEfZ6sIX1ponFad6I3j06bDJUXZRH
 K1cn/dIIT7RfAOkLcT7kjtZp5igqVuHWZx7rIEvvyurFxmNi/67kBeNTRccENlFPGo032yv1Jt1
 VeAGJPUqiEsoJGUjQJ9UhRbTLT67mI7qDo8Hbli/iSPQPc6FPpV9hRSEqBcjIcF4xmN1S/dyv20
 /B9EDcLkVAi4PjjeoVqeJYixABQF6h68H6uLcd0E1owPIrJI1eKa7+661CE76I+T7MLiMxxIyCp
 +/BwdLc895q+Sg9+vcxJbebBbiKQdY02ZkHNvtop5O9AKSKmkDRrocywoPLjBFOnsXeUydLS76c
 Nzqq9H2kruOU08iBNNHOvEQcVIIFtatHn5wg08V+cSBDtF8uncVganMNfAYZZ1XOMXLXuHy/UzB
 4sxJbAePtUJmmAdUQPoAW02oRzGDsv7UwmDqEG8xeG74bNVWxC7zfIg6nV47oBAI/jFdvXm+mrv
 pP7lnyU422d2k2cay2rMDikRQlPADZzDaIpu0W+vVbGU8jsZ346HlrAr1KUwQxdP5Up/y6xgQ8y
 HTillYk9Wvdy20A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


