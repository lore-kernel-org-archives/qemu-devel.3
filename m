Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB6BFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsL-0001ze-PM; Mon, 27 Apr 2026 15:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRri-0001I4-NC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrf-0007oh-N2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+eC6NQYMsyddRo7PFwbRV3xFGGbIUsTRsbhZr7HhNM=;
 b=hiu9rLcBro0M6Kj2SI7r2F2q90MAX0s1YUxJoSkWbXIhcVAW/HpKG6TYLRpaw/QehdbFMp
 YbaFVlOBOULNbZiiLCfBVtq5FNcmXrt0C0mVcgszQDRy1W2jrw3SnPOlcUQtrkFj+MMEXD
 STAhI8nH/3ZPe+MF37/Mzq/5IyvV3Mg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-EytumEKpOAGGqVZzecd0Gw-1; Mon,
 27 Apr 2026 15:43:27 -0400
X-MC-Unique: EytumEKpOAGGqVZzecd0Gw-1
X-Mimecast-MFC-AGG-ID: EytumEKpOAGGqVZzecd0Gw_1777319005
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBB021800282; Mon, 27 Apr 2026 19:43:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B313300757C; Mon, 27 Apr 2026 19:43:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:09 +0400
Subject: [PATCH 10/41] backends/cryptodev-lkcf: skip cleanup when not
 initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-10-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HrppNKbbNxohb7YDYQ92lXKgUl9QPVoSeBjpfd/wmpc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUVsUu48ebgWl2IieQbcdJdJN9Z8NKmaH2I
 dUqTTBFDc2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5YvAD/9AYxD8efG/BQzajgGHPRt51FSZdQNbMk818g8Aivr1flz3uaINzf91x8JZrX7+9of5otf
 zjKs/PJzbFkm5jqGfS0DkhsI5KE2uXYNKsBzJH6TofR8JixB9d8hT75VO07hdBe4PIDaYRDTKNL
 hYyWZPn3tbVqY73fRP+pdT2rJQC/Y6Ph+JTX+M/x6DBKD6sHZrJ6FELop79KCv2BTilLfLCW6Dl
 xB2c2l/EyUqizeaffMds1doj57Qkxp+dyFV8WnCvIyTpz/IiZKRluR+0NqCH/ahqKRsQtHv4WNO
 NcaZH+s3EKFtyP54JQ11H8n5nWdc/utu6vwRDW6lIGYUQTpIKKQcmB07auUEsScUb/UJg3ZeGhx
 xnnnL0of9S5vmr2UxwaSkUDfqxmQUeAVa7XE8qoQRi8J4tk4d4bHx3EQpZcYzrg67F3E4nn+McL
 1Q6kYWA0+L7b82/q8SjwVAHKf+nDucm3fzWNv6QwOxSBxAXsH0rzuBQKkXY7ZIE49QXmDuNsjA0
 7h+JfZ0YRZ185+tZhFgNP+G0ouA5xO97AFf29ahGgUlpIzLUJw4K6fz4r69eTy8u1wJ9rladnwB
 ouJET7bjYe+yxho5jbIg5bb6D6VKgGcau/cI+rYr0J+fQCuJKtpkqIaXFsfGifZ0k/zPeG8Sg5s
 tUpne4rlXYfFy3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 40c7bd3c5a0..74db03fe96b 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -255,6 +255,10 @@ static void cryptodev_lkcf_cleanup(CryptoDevBackend *backend, Error **errp)
     CryptoDevBackendClient *cc;
     CryptoDevLKCFTask *task, *next;
 
+    if (!lkcf->running) {
+        return;
+    }
+
     qemu_mutex_lock(&lkcf->mutex);
     lkcf->running = false;
     qemu_mutex_unlock(&lkcf->mutex);

-- 
2.53.0


