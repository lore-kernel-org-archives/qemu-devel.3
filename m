Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0310C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBa-0004H4-Jf; Tue, 28 May 2024 06:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBR-0004G5-Dp
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBO-0008AN-UI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UtH0D4I15f6AmqPGZ/mKuxu8KcITJcJzO63ZIJCMrs=;
 b=M6IUFiSxUs6k+M0DPac/gE1T4R+iGn5r1rI6LE/QoIvcpg9mx7whN4T1gWrauAefWvaG1e
 /3bHyjcn4bMRWDO5pJqIHCEtWB2V1OFAzCP3MI7u9pZSjpiT2Fr+ZGEinf/zRDEFXS6Pz+
 fT0/42TJnBJbRTjU17psBt9ijeF9v4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-EgYDU-qnMauWdSwHeLPDfw-1; Tue, 28 May 2024 06:35:53 -0400
X-MC-Unique: EgYDU-qnMauWdSwHeLPDfw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3580f213373so518412f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892551; x=1717497351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UtH0D4I15f6AmqPGZ/mKuxu8KcITJcJzO63ZIJCMrs=;
 b=CmtvuelmUE59KE8PuKPj6Jquj+qSBRRlcoBkxj4A/kkqzfxf+lhVMlFTModkca4S07
 a4fOBLOQdjTL71Wjh3n6oBBk0FamyrxgHA5szSZLmz73Xp+P98qRSkBaYjsCiYWGlzXk
 21Fbj7J8Gxl1sXa5slxaO+Ckac3sewBeth3GGpCQc2YJXzU1lCbMbjdqim63N/t6AuZR
 9j5e+C/Y/dQEES0sE1vYszmTcDZYnKFvGU0MbhyyiahEJzXerd32CmMJp/QQQ6S541Kg
 4Axef/FEZPNVzmPcyaTCPwl2WP1Z5HqNm/lWpEG/5EUyoQXfWk/0T5GgmTml22GzPeaN
 3mVw==
X-Gm-Message-State: AOJu0Yxm4r2JJd/Wicq+HbpnCFwmN7agyqIz2wUQBJi/CU4qGCRwlqSa
 tNugy+d9whVEafeEcSFoi6iCl1Qfz6idz/Fabkq7zmVA9dNdE+qFy8EHvzm9xfZj3hTrFydFhCs
 CwVQO8aeoHzsHMER9H54qwRJIU2NMbD/VXu0g/XjrJrlULSz4fEH+VPqweAq8hNbP7TLnlWDjo0
 wG0i+p2O9Ch+brY2AVHyHwVuEOeeGcN1ny6xlY
X-Received: by 2002:a5d:4385:0:b0:357:5051:2a58 with SMTP id
 ffacd0b85a97d-35750512b9fmr6204890f8f.16.1716892551404; 
 Tue, 28 May 2024 03:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWuQ2BGJUk3myyZuI10BwMyCNuCR38/3F2ZlIx6PoUKn8VGkBeGUglZZ5r0fNeXYH/kE3XLA==
X-Received: by 2002:a5d:4385:0:b0:357:5051:2a58 with SMTP id
 ffacd0b85a97d-35750512b9fmr6204854f8f.16.1716892551077; 
 Tue, 28 May 2024 03:35:51 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564b762ca8sm10588060f8f.112.2024.05.28.03.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:35:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Brad Smith <brad@comstyle.com>,
 gmaglione@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 01/12] libvhost-user: set msg.msg_control to NULL when it
 is empty
Date: Tue, 28 May 2024 12:35:32 +0200
Message-ID: <20240528103543.145412-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a879149fef..22bea0c775 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -632,6 +632,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
     } else {
         msg.msg_controllen = 0;
+        msg.msg_control = NULL;
     }
 
     do {
-- 
2.45.1


