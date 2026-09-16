Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F5FC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pgL-0001pE-Af; Wed, 16 Sep 2026 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pg4-0001lj-QS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pg0-0003uT-Nd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKPv13O8XSl6nTzsPGb25cDdpbOt3uJwnax9Wc1iZE4=;
 b=Ig+m3OHynEoOWCvBMs7QtbblC36zUFQcfH3z/oxcN1vnhre5yQ4nKlHF1kt6dWIvQePBzw
 50tQAfnjjMlYDnIwvsYVo4O9y2OuHroICJvZP8KJP50jdiJ3Ggiskz1djEfg649URSUlMx
 nguS0a18FrAzyKCELyX5+ml0UKUHfZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-d-BBRyosNYquz42fLcPhwQ-1; Wed, 16 Sep 2026 09:27:50 -0400
X-MC-Unique: d-BBRyosNYquz42fLcPhwQ-1
X-Mimecast-MFC-AGG-ID: d-BBRyosNYquz42fLcPhwQ_1789565269
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso50710685e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565269; x=1790170069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dKPv13O8XSl6nTzsPGb25cDdpbOt3uJwnax9Wc1iZE4=;
 b=Fw4DVIoBETjd+7rEfM5NOR8paLF1CH1bFQNwIG1O1topZYiMS0JtlE1uKUI81Nzick
 Gl+BGOpoe2odc3gHlfGGLlD5tyT5oRfRyS5rVLo6Udv2MmwgXnDyaQlJPqskL35lDbE7
 v/kYipgobBfBX7sRBdsZOuGcHXhoO/CG1+XsopOMJvHulekJYYVF0A/+oE/OkyjaXqx8
 ZrqMeiyZbfIZJnfqrXoDh/jwJFkgv1DKQOu+pwbNiJgDS2bFJiSZsBBxh0TPM6Tnz+yr
 8ewZWEohDVJhAto00V4TYiS8XiDPHivcnvm6Aq4M1QGgXaXK5/ZVf5T0tkGA5e2FSZXv
 4e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565269; x=1790170069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dKPv13O8XSl6nTzsPGb25cDdpbOt3uJwnax9Wc1iZE4=;
 b=lE+4b5b09/cx34q7enR1Bv86v5ueVUScz92o+R2rVd7eZTuXWtjEkSMZnQpnNsEb0i
 4r6nV07ZNophKY62juEhPOeOttyDjUX17VZisIP86NX84LhxPW0JVfjc7rDTf3GqsUg0
 wrdedVjq19Ulvcq4mru66uXEd67wg/jN0rvCncqkclBtJu4CwlLKn8/SHl6h0TGXPepS
 EnMIPLe9h057jHCmFu5TvD78EiYgIyOLKUiL8rUtZgIGWx0+gVVJ1JEXzkXPy7cGpQKX
 eJboB1Ipmr2NbOobnFvyaLI2n+/MGvD7PxXCEsv8Muv+KniQxq8S8xILB63VttaXK8z4
 xpnQ==
X-Gm-Message-State: AFuF++nQooY2jAZk37wmdsdK0K8hDnWezrzeJZy4v3SvBlFZG3jJlDh+
 deZTRNY3zt0fJYQ1cVyLiHWJtdhSGoquBpfGPttX6FAU9EZDBOJ8rQyXHa2K+S38sRj4Msy19vp
 9zQpe8TFsZgw0oicYlrlkl1cHeZMsLTrwg0gw9AFxBntOCKXfG6hE0E9Oxw/QAbwKw2GIP4rAMz
 RxuYeZr0bQmrYZ4nPBuxnVeA5R6Fgp/9GBLXRzd/bi
X-Gm-Gg: AYBFou07NYms9ijFaGIWoMamr/Us8yF2OYfrBoUQDFJiYD4ilLiNktl/pWNAGrqif9z
 Q9UQ3Ico02nDatJ+3u+6hCoUbKzGJeojj+XAsDmXlYEgte0a9o1C5wq/F45Wpc788S6x8Qes9C9
 li/qaECXSEz+ixbNKk6I1AklD/r55boJlrw+oYjlPg2Y4jtvL+ofP70gmPQIHsbFbwK9VOaVvqv
 YXc+6HTrB5QVzToVDb+gQbG4JofHgtwcilVtxqQnwqzmOUt/PnwdnaV21C81O+8PLOgdMaNwIrh
 E5RCT1DJ52fTUC1XrkXro8jY7Rltq1jv5JxfQNugdzYApBDiZsJRxnEnzsT7pbHJqSYoeqcVIj7
 bK82nAGp331vBSVkSSPDIDlNImQgpK9DFeQtQWuHCdij91PQMfR7Ef55kxnxPjzODeSvzRUHrS7
 HA+ihx
X-Received: by 2002:a05:600c:190e:b0:49c:f4ff:e872 with SMTP id
 5b1f17b1804b1-49eb7314d54mr29833885e9.5.1789565269027; 
 Wed, 16 Sep 2026 06:27:49 -0700 (PDT)
X-Received: by 2002:a05:600c:190e:b0:49c:f4ff:e872 with SMTP id
 5b1f17b1804b1-49eb7314d54mr29833455e9.5.1789565268592; 
 Wed, 16 Sep 2026 06:27:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d903f6sm76103765e9.4.2026.09.16.06.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:27:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
	qemu-block@nongnu.org
Subject: [PATCH 2/2] nbd: call reconnect_delay_timer_del with requests_lock
 taken
Date: Wed, 16 Sep 2026 15:27:40 +0200
Message-ID: <20260916132740.872244-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132740.872244-1-pbonzini@redhat.com>
References: <20260916132740.872244-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This ensures that s->reconnect_delay_timer is written under the lock.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 85842e7cdfb..82af55ec4e4 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -207,6 +207,7 @@ static void coroutine_fn nbd_channel_error(BDRVNBDState *s, int ret)
     nbd_channel_error_locked(s, ret);
 }
 
+/* Called with s->requests_lock held.  */
 static void reconnect_delay_timer_del(BDRVNBDState *s)
 {
     if (s->reconnect_delay_timer) {
@@ -219,8 +220,8 @@ static void reconnect_delay_timer_cb(void *opaque)
 {
     BDRVNBDState *s = opaque;
 
-    reconnect_delay_timer_del(s);
     WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
+        reconnect_delay_timer_del(s);
         if (s->state != NBD_CLIENT_CONNECTING_WAIT) {
             return;
         }
@@ -2134,9 +2135,9 @@ static void nbd_cancel_in_flight(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
+    qemu_mutex_lock(&s->requests_lock);
     reconnect_delay_timer_del(s);
 
-    qemu_mutex_lock(&s->requests_lock);
     if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
         s->state = NBD_CLIENT_CONNECTING_NOWAIT;
     }
-- 
2.55.0


