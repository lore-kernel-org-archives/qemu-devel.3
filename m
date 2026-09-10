Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB41FC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lnh-00027q-CI; Thu, 10 Sep 2026 16:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lGn-0001AO-J9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lGD-00083R-0N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dS2LV10xW58XQBK2n8n0ndzTRRlQmRu7LpDRVGCeMs=;
 b=fkab8dWxcPtVNYrj3imFOAK4+G9EjXMmhbEESN9itc4WqduSZeSEwu124IpBI/QqciAYcr
 5zzR8GK/GlWjriYmpKw7pXaUGA1dK77CKNVbpoL4mC7lh1WAeTiGB4Qr1gF7id165PKs0t
 /ZnsyIjNoYY5iCUVVuAVZujv0AicrWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-nkx2V4-COWqwJlkDkDkk7g-1; Thu, 10 Sep 2026 16:13:43 -0400
X-MC-Unique: nkx2V4-COWqwJlkDkDkk7g-1
X-Mimecast-MFC-AGG-ID: nkx2V4-COWqwJlkDkDkk7g_1789071222
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4858f06e142so98480f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071222; x=1789676022; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6dS2LV10xW58XQBK2n8n0ndzTRRlQmRu7LpDRVGCeMs=;
 b=mq+Bs6HuLgMB/Te2e4F/rfxF6oZ1x2UIwPXAT6jiXX3iPnFJsWA8odAVRCuLVdnHXa
 Rue6XFb23FoZqGfF5C3C/wYkaO5pqGYCdJ7L4NBfQPho5XxJdW/ZQYUQ4AbbiFpJcOBt
 psjqWNKclW040hnUo37v0pil4fpy7ik1G3jdhgA2jTr9jsQKL59qJH5n82AFq0T5inbr
 fo9sWWdz7wzyQebvItCFuzvIqZdHRn5k9V1H5hjCmKDYf5WrOjyD6kybDnvNIS9KysxW
 g0fx1gIasWL9L0l3BCJkExOX0Wm7mWZewv6hngxxc2LFclne89a21+urLX4QOGM6U0nf
 P/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071222; x=1789676022;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6dS2LV10xW58XQBK2n8n0ndzTRRlQmRu7LpDRVGCeMs=;
 b=pgdHpa3AnigRuF/Vp6nAoyk/576v3o3xTpUOKGpRJqoHdVhZyegjE2k23uAsn1ZffS
 n14IC+hccRINtrHS/f3jvNT1AfC2gzrNbFpYh55RLKM2rh8D+e2u0kTMGBIgLnd8yeo9
 mmLdNacYmo2UUziDPzqueVxtDvSMkiGZ6RH8n7jNwyh1X+bXnCuMTALhc43YcBDYXqnz
 C1K2j7JJe06qCnrB0qbO2PV8CivulaFdVGoq07L2xsR9mb5/l+0CWIlBGbJ8II0SM3vJ
 vpaEMim822iTmDMtFUapGkJpGLpLCnW5kMBy0mYv1SQaT54IAttoYtUk8R3kB64mPs3M
 AOEg==
X-Gm-Message-State: AFuF++nhiBnShH8ADnibz8gBds8mTgz+kh7sqQavjhSJd3DVxmbaE/oR
 FS5cVyDYvRGGxFW2m8Chv/LgVS7ZUedidpDlugCYpJ2oCTsZhaum5PZ8Xv4T4APczNlWG3H8NxF
 c91JaVO221Ymv47GRIkmeJFfZF4f+mB3fIejg75N2FKAjO6uLN79vL7JxUk0OgN5iOj5bmvJZnq
 UoVGgRvjhbf68CBaS3gN7b3SG1ByUfXPk+Wg==
X-Gm-Gg: AYBFou2XJkY3Zpb0n1SeeHXi1GF3bEmKNrJjXwfsX7OrJrr7y89cav/fhxIzUbsoLfq
 fgoV4uB3+ROZMfWckuMYe0JJkHyl/rYqy1VYiYfh9cchfujdt63bwiIMa7UGs6t4H83pSLHrtC/
 A76qH5kU/6q8bHuk0wKbdgIa0JLCHx9Vk8TgXbREnfjTsipIA+FfGvjIyXk/NXfijzFsgeveG+z
 HHRcwbz1tTKUODMjn4cVgY0peIhcWAcFsFwRBcuCQ+g4jd+qEGzMrwnI5Rj0JeVWxAvJS+Nyb2f
 mZgQtAQmwEtaDL+0LZETZxjH56FdxboOJ7dZAObLFQH2ETy938RwZjCavXTN4XGwsnjW1Eluaz0
 iZ5In00onPMy+H303sZfJCKE=
X-Received: by 2002:adf:f792:0:b0:484:3310:f39b with SMTP id
 ffacd0b85a97d-486eb31e1a3mr559325f8f.28.1789071222098; 
 Thu, 10 Sep 2026 13:13:42 -0700 (PDT)
X-Received: by 2002:adf:f792:0:b0:484:3310:f39b with SMTP id
 ffacd0b85a97d-486eb31e1a3mr559291f8f.28.1789071221596; 
 Thu, 10 Sep 2026 13:13:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35f3d9sm679751f8f.35.2026.09.10.13.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:40 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 53/90] virtio-crypto: clean up every data queue
Message-ID: <d67d6972c4d34d9b5f07be32afed1b1e4d770b0c.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

realize() creates max_queues data queues and one BH for each of them.
unrealize() decides how many to tear down from multiqueue, but nothing ever
sets that field, so it only deletes the first queue and BH.

It does not matter how many queues the guest used here.  unrealize() must
undo all the allocations made by realize(), so loop over max_queues.

Fixes: 20cb2ffd5ff3 ("virtio-crypto: using bh to handle dataq's requests")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260728111217.573046-1-zhaoguohan@kylinos.cn>
---
 hw/virtio/virtio-crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 79e2acb56c..85c7279aae 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1114,10 +1114,9 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
     VirtIOCryptoQueue *q;
-    int i, max_queues;
+    int i;
 
-    max_queues = vcrypto->multiqueue ? vcrypto->max_queues : 1;
-    for (i = 0; i < max_queues; i++) {
+    for (i = 0; i < vcrypto->max_queues; i++) {
         virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
         qemu_bh_delete(q->dataq_bh);
-- 
MST


