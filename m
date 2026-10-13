Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFDDCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcWr-0004J6-NB; Tue, 13 Oct 2026 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcV8-0002jX-By
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcV6-0004n2-8i
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSwp4c7MVreijaBLexFo7gu4N6THLCU6KVBx7OJHxlk=;
 b=EXy5pbDFyB7MEw4ntnhOUME/ERN/Y19l5uflNNJ4CIxcaq4DFYcgIIqokW7PbveFmuNxYy
 9IPvj4XjuoccHjs1Pzp7fjldU7sCQHYvgFTRjyWOZEqb4e83uHW5NuBV3lEaOX7yoOlNgd
 cbwQ+RAFCz8aEqbsat5x68XIDVSFftE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-sdzglKrOMEaQE04dVflEjA-1; Tue,
 13 Oct 2026 13:25:01 +0000
X-MC-Unique: sdzglKrOMEaQE04dVflEjA-1
X-Mimecast-MFC-AGG-ID: sdzglKrOMEaQE04dVflEjA_1791897900
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CCA91945CB2; Tue, 13 Oct 2026 13:25:00 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BABE330000E6; Tue, 13 Oct 2026 13:24:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:24 +0400
Subject: [GIT PULL 27/40] audio/pwaudio: bail out on underrun in qpw_write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-27-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aRZt8MYvqellOMfxTuNaA+mvv+Noe2ZpLsXb2BICzxQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDD5WQ5DJfW//ma7Xjf4KBfr0fOgVrOmbQvB
 3pcZkA9vk+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5TnUEACsZA6+tHWXi+QW2+MfaulLmC3g+XXvnNPyqyXxAdBDXknwxO/4BFg3hkKnj4Tg4yBMvUK
 EpKu26wqqHXl9EIsZp70ECnQZsGnpdG26wSqh/YlA/1NIEWu23UeXZoG7YCEgiJFo6cLKWBMQ1T
 eC2rlum69QdYSfPOVDS4gQfAQlV6ZI7DZS6Q+Q/oCDharLEiwOtBeUNR5fGXONEa4Jj12CXZk3z
 dFoFySNprfOt/Z0j0xmF87w3tgLO+P0SDkRbsght1XgmCMDaFBlMo3zh9lMYWSAwiQZFS1McHcp
 l67QnZ28Nb/xiU8KQAjFQ4Pb6DZRwdcqaqXe7uEql792pPlX9Uyjr2Vku8KSOUd+iluAYPR5CP2
 SkRKZPDAy4pxXQUtWpSZcMhe3L1xeUk13ktH7ihJjqG7Q3+d278qyIx0P9cS+2KnjRxFBhKyIlw
 AuMmOIHdj40frXmw+8ql0uRVAkPRoPgZmXzHMcIv3G8rKpUu54dYeDLvgH71bZ40okWPwpZP/Fj
 Y5l6QknCOZ70MPUhhGA89nFI8javMCcBsoexm0+95Q36T9OUT+Y5ttOB/wgFHgbbC49xaGrNx3m
 G1PHeVh+RYGzmNs4NPyTSedZA8tUIFzSQGthv9LwdTfc0lRS8DQB5QCScfDAGRyjsq0yULKG/Bn
 fYv+jXcb7GsyVpg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

When filled is negative (underrun), qpw_write() logs an error but
falls through to spa_ringbuffer_write_data(). Bail out instead.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-10-ccbef537cbeb@redhat.com>
---
 audio/pwaudio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 8b3faae8a907..18b371dc4f93 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -326,6 +326,8 @@ qpw_write(HWVoiceOut *hw, void *data, size_t len)
 
     if (filled < 0) {
         error_report("%p: underrun write:%u filled:%d", pw, index, filled);
+        len = 0;
+        goto done_unlock;
     } else {
         if ((uint32_t) filled + len > RINGBUFFER_SIZE) {
             error_report("%p: overrun write:%u filled:%d + size:%zu > max:%u",

-- 
2.56.0.116.g6de20f6092dc


