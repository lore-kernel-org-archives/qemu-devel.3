Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B691C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBs-0004P2-3e; Tue, 28 May 2024 06:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBX-0004H9-AO
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBU-0008BJ-Jr
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1hrZjd8C+P/TJKcTay5AIq/j09eUcHNdpUi41ujwU8=;
 b=VpiOmzn7PhWOF3iF5mPgldH7kHpq8GALL702bjVHCZ+vSlkn56ZPPrxOZZv+fSBgQMf1xd
 EeZ0rLxyzOqVl+6Ceygz+TFpvlJkboPEd4bI0ABJxNEVK6LJjVmc0j68oBD1vSxos+eWk3
 CCYUMvRwlre8UivmztktI+k/morl9Ww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-n5CxWwGsP3eYeUOPAXW9gQ-1; Tue, 28 May 2024 06:35:58 -0400
X-MC-Unique: n5CxWwGsP3eYeUOPAXW9gQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-354de3c747bso433647f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892556; x=1717497356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1hrZjd8C+P/TJKcTay5AIq/j09eUcHNdpUi41ujwU8=;
 b=bEyGHuSpKptnla9VdaUFa9As2RO10pzoDFeltMdb168JVLBC/Bmyklg7Dq7PAGmhXP
 HRtvkynHP2BrnnsPMVPNmVC1wRxiFfKt0IwNoteMfx1vRYUvjbD+Ckp1UWxxD06Q0qB6
 Y19UikIrP6sI8VlqcigUCBrNPjyAD9Y6QrVSlR/diyC5JzXnTkgO9DDxV5BplBGIRGyg
 Zij4r8xbnLWDzwuMjiKiQLxYgvo5N8E9oLvxKAJhfT/pSytTxJezus/nfgLFbJGAGzHP
 GRkrfVZo1v1oFhGTNUwSVVn15XeBReCS761xNskeWhs3VJfS7wrrcwKrWtP+C7IGBaWA
 Y2Pg==
X-Gm-Message-State: AOJu0Yw8rtaN/r/lnvqVEo/5t8ESnebIxOvQYYCaaeWmlcXe2RUeeMBe
 43z3ean2i+W+Re5ePk1SBablnafnx+AFmkxEBn6W0RyCjWcROlUx05VgmAGT4fm2BmlwQm5wKlU
 SLRBR/sBony0t5k0H8EosJ5ZEVDBLEjDzP3BYEZiH8LukI6a3B+cyb55XR0oJxamzIZ4PEaO37A
 UP3U7falW9gddGtk9WjeURyvLZhn55quou+V03
X-Received: by 2002:a5d:6846:0:b0:354:cf3b:5791 with SMTP id
 ffacd0b85a97d-3552fe0211cmr9126222f8f.70.1716892556389; 
 Tue, 28 May 2024 03:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoFM14g7vg/DaHhzW3IUmtDA0rAdyjmuaGRucVyIZrFB7HdNjC1uXP/Zkw3JMBff5GHhxh6g==
X-Received: by 2002:a5d:6846:0:b0:354:cf3b:5791 with SMTP id
 ffacd0b85a97d-3552fe0211cmr9126176f8f.70.1716892555892; 
 Tue, 28 May 2024 03:35:55 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c93a5sm11364472f8f.70.2024.05.28.03.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:35:55 -0700 (PDT)
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
Subject: [PATCH v6 02/12] libvhost-user: fail vu_message_write() if sendmsg()
 is failing
Date: Tue, 28 May 2024 12:35:33 +0200
Message-ID: <20240528103543.145412-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In vu_message_write() we use sendmsg() to send the message header,
then a write() to send the payload.

If sendmsg() fails we should avoid sending the payload, since we
were unable to send the header.

Discovered before fixing the issue with the previous patch, where
sendmsg() failed on macOS due to wrong parameters, but the frontend
still sent the payload which the backend incorrectly interpreted
as a wrong header.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 22bea0c775..a11afd1960 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -639,6 +639,11 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         rc = sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
+    if (rc <= 0) {
+        vu_panic(dev, "Error while writing: %s", strerror(errno));
+        return false;
+    }
+
     if (vmsg->size) {
         do {
             if (vmsg->data) {
-- 
2.45.1


