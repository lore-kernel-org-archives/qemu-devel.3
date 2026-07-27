Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B344C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtL-0000kK-E4; Mon, 27 Jul 2026 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtJ-0000dE-R9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtI-0003xV-EN
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZKEHVo3ZzLDv/RGBdvdxXc3UPVSehiDLCN0yHal6ik=;
 b=a3mcDB9N5vZ0Gj+qnOGA8X60IPIEkGjb9ErRre63ZX+LhVOtejoFJ5lE1GfmSktGZR9jsI
 SuxbU81OMWppQ3oxWf6a5fYNzHMaUuCnRT1aT/JJ0dxxvv12PsoW7EuKItIG3KngFFWYOL
 TNTndhAC4OtAkTR0639rER/ffWzw6Ac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-9sHPpEkpOoaPVe6e-DGecw-1; Mon,
 27 Jul 2026 07:53:02 -0400
X-MC-Unique: 9sHPpEkpOoaPVe6e-DGecw-1
X-Mimecast-MFC-AGG-ID: 9sHPpEkpOoaPVe6e-DGecw_1785153181
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80EAD180066E; Mon, 27 Jul 2026 11:53:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B29F18001DD; Mon, 27 Jul 2026 11:52:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:25 +0400
Subject: [GIT PULL 16/23] block/blkio: fix compiler false-positive warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-16-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b4aunSxFIZR8zEd4fYoUZnkOi/BDIcfBKX/rl+ZoFfM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/OWtUmyokGiKzZh3nhZF19sqM3xCGP1/XM
 b9UCgEP0cKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5c75D/9KHPaNrPNn05oeCu1enlACjxvLlCZ9oNDO9fbQkPlTn9iW3Np/eOh6YVcZOjYwgyEusdc
 yoY9pypx1d37F8ckTrs+mxLGLu+qD4du5h45mSZ6gv+PJbwSuZA+/ttkXRF4DQMVtvPSWimVimC
 vzaJzZZC0H1kfJcyfo4Yow4Cz6xPd3rbVzcWLfaACtGFhJ4iHh3NLJh9gzdU7IiFwCXdPvMLn/L
 OD7NHKpDurSyasDLnxahaAUW0Dx8h+cD3fJOS22Curm+ZD98LswEqt4cwEaY0wsIvmR2c5kU88w
 mCbkyMp1aP0ATOFGWz/bBXp4raEsKcz3RT3PgMXFOO7Eh05yU/D+/YspGKBg28RALRvs+a0kQYD
 wxIJWTW5hDgy1n0VSiDfsgJQff3OjrKoPKxkbDgx9i6cuSmGNgbu0KwrHslamTPccuxLr6kon5J
 8EcgfDkde4g6E/xuCaFYUxMKceC02Pd5PEHI4qMqwMfxd7Ib8u694+3w2rp4pYp94jLa85K29af
 KFQ7fsfWsf7+k2t1QMG23r6p/UsRdUljDKvEoc4h/ncnq8RKu1xJ8Kcq7USuRTdirPztSKeMY5w
 4zYqyfg89ViKh5H1J7AB4ncqxuLONIHtieZbNfLh3NZGBpYmMdpziFfnLFe0lokvcLqNw6m6vzP
 aS6pjLp/E0nBabQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Under some optimization, gcc produces a false-positive:
    ../block/blkio.c: In function ‘blkio_co_getlength’:
    ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
      943 |     if (ret < 0) {
          |        ^

Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index fb8bec27d71a..008320bf2061 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -937,9 +937,8 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
     uint64_t capacity;
     int ret;
 
-    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
-        ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
-    }
+    QEMU_LOCK_GUARD(&s->blkio_lock);
+    ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     if (ret < 0) {
         return -ret;
     }

-- 
2.55.0


