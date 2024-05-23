Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CDDC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9rd-0002Hq-7s; Thu, 23 May 2024 10:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rB-00025V-KQ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rA-0003wl-6O
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xyelDCWIlCX+PAbwFYWN2GP5CDp4IfKR8S4cYw8b0U=;
 b=O0bOI/VfYu2d6Q6CQAAXuONMA1q/srKcrR8VK307QRcOiFU+S14BLFv4EQCQ9slsYq186g
 aHwHDuTIcanakR/qr8ptaQ1iSUiAHedvKGWKTp7/MFT9yEw6wJxysC42YjisJvQfpcFneA
 +6sNGwAgMwc2mRzLwTI6WNe3stc4/Nk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-wfWtd-OsO46aucllNvrvzA-1; Thu, 23 May 2024 10:55:46 -0400
X-MC-Unique: wfWtd-OsO46aucllNvrvzA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab8e7f5f8dso3968516d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476145; x=1717080945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xyelDCWIlCX+PAbwFYWN2GP5CDp4IfKR8S4cYw8b0U=;
 b=waMJv+dUInW7ggBBRNPf98sU3Rm+AulKTzFtfu/NR+H0DfAN36CFKWohVQ0uX4Ix/K
 agjPzUN2Q/Pb2CYVfvZCePQilA4luHpn1zcVgAt9IjhRulhhFNJJnxW3s0FLNlRU3MyA
 sT2IWMkxj6DNWYsnoJzPkwp9qgC+wmc3tmSUdDi6LZ8CYBhQSPVkpIak+5jpfPFaqWQ9
 YlhQkVBzCYexndgnAJGvrISKz2Lf/z7FSJfdXanC6QswA4G5mEb0fUeG08jBZ89R/Ety
 JVo+HqrRf4yZ3Az2OzfJabjBgrPSYckgeNNI9n+jsiSDjtSV6PX8IrlzlpKLpQWRnP+1
 BZJw==
X-Gm-Message-State: AOJu0Yxgvx8zsXnFxUftJ3kuTuiFVgkFywnXwDF7Qhmm+YyOOU4q9edM
 tkVgOKc7TdcMbDhvl61B5ew4bNYzVUVIJyNMj/letZ4C2Zwr3ygEoC2REkWP7km4X69THzpGSHA
 27OQbw1Iyn53BX/t2by9eJnZvLAThcmyHnbWIx5Rs8VJDklKGrdIA3ileOghfzMxhdjP2hS8X/X
 KOJ8jwjb31uIz+3/YFLTlzmFmc3pHQtEhl/+TB
X-Received: by 2002:ad4:4487:0:b0:6aa:206f:c2e with SMTP id
 6a1803df08f44-6ab8f5bce70mr36215116d6.15.1716476145616; 
 Thu, 23 May 2024 07:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPLyumh+jE/AutlVpcVipemoO5BlwX8gs6pHLiiSy/sDzeH/XtwPUAVKoaIpJXaHb3J49sgw==
X-Received: by 2002:ad4:4487:0:b0:6aa:206f:c2e with SMTP id
 6a1803df08f44-6ab8f5bce70mr36214506d6.15.1716476145081; 
 Thu, 23 May 2024 07:55:45 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab93c15e1esm5250716d6.4.2024.05.23.07.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:55:44 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 02/13] libvhost-user: fail vu_message_write() if sendmsg()
 is failing
Date: Thu, 23 May 2024 16:55:11 +0200
Message-ID: <20240523145522.313012-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


