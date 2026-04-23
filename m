Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36031F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKk-00010z-EP; Thu, 23 Apr 2026 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJb-0000Xe-AG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJZ-0005K1-JF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiXQsll1JQj9gR6NKDgvKQISqWBpMBuRG51hECRcEGM=;
 b=LmeeZGWibVsHRimT3BdNWHoURht+aBeuwVAyx6LbHrqF1sI5hCVoCjQO0Rx9GLQhn8PgkX
 wZ0ZLsvG5ABPIHwCsYfriwlAuMpAPRna1TeLumD8omln+thFKTWCv9QyCcMBZ48WH1nbKo
 xhKAUXcqDgZjWVh9KFbzsfkwoVi29rY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-RgiusbgTPOSWAH4DdUzCJg-1; Thu, 23 Apr 2026 06:29:43 -0400
X-MC-Unique: RgiusbgTPOSWAH4DdUzCJg-1
X-Mimecast-MFC-AGG-ID: RgiusbgTPOSWAH4DdUzCJg_1776940182
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48906aa28cbso37291905e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940181; x=1777544981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiXQsll1JQj9gR6NKDgvKQISqWBpMBuRG51hECRcEGM=;
 b=bG/QHtNnIr3t9onhqnnd5qWb7b4hB2qHSCGC/Gxa4jv7f2UJt0seN4leNo1zBIrRIP
 zFnQKMBwg1BriUy8J8fkcdVQy4XMRpsC7vkWgV5dygv+v9zSSiLyNTJeVBYfZUarOGG3
 wy+CQ/Q/dMtx5ZjQUgcszX2wdH/RhLnzmGH/3n6hICJAO6DY9C/liUbMYawZD/H34bSd
 tu+GIoBagJcY/HuB5tnC3T2xu54cYVmPsspqkBGXzhOE3RVIhNw+NbQ2HVZuJQ90N9mz
 +aJfrhn5VwzGPicuW1/9Hk3IcixMiaSyma4MO9185B0cXBuh6Fc19387xP0igqYNidza
 0afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940181; x=1777544981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OiXQsll1JQj9gR6NKDgvKQISqWBpMBuRG51hECRcEGM=;
 b=cTuZ4Xi6kasxX/VDC6nrr8alTsyUvg1UQESMO7y9J3y1wjZg5gMH0jDm0xyomx3huy
 3SK8AR9G9e6sQuvBGDPOPGzbFTsIVerlekQreRl+NkhwQdCsVba0xeSNJjXOveHw+PDw
 vTOa5ZZ4vzdGQm1drW5edpFelDeSQNjygbzi8k4cBBbxINbsdsmD7slheqxt/cFJ7MiT
 IO6wQNeVKO6KGUA4BmyQaPYY3opLysMU9VhubW8HIo9z0d/Z2ErlNVMmGg9VFvNyM/T6
 lMQTS0DZr8s51RpV7Ka7/1xmCHlYpDA63/O0aBMguyUSBPojJ0gwspFO06yEMDXJXrxP
 ACbg==
X-Gm-Message-State: AOJu0Yyc168RpuDhopphdgkntI7Oqm+qg+qNG/V9cUs956FJTgfDXv95
 LkcvKRcW+A1ZhPhXhtAIJzV73nuSEmkOMZS0nXXKPDeifBgcKRK/7SpT0j934xGalue2n4obsBv
 QNoNDBwUFiGKexh3mrUOpyFN5mwNMo6hov8xh73hVuSEcXu3Rm6vO4NJjKUoBQUgRCP5XSOTud6
 An6vJwceML0Ki/Xt61aXesA3yuObTLLBRmFeZguzA9
X-Gm-Gg: AeBDietUsdD+x485CcSdWBdJOwxHmIRAHtDqxcaUMxXk+F9hXkFqorupsEYUoVN+Zwr
 UJLqep3BV+w4/BC9zg7wDAk46+GKkuSx7bYpSKKWL27ZB+KgYv/ghbedrRH3UTIBxFHOV0IUymf
 t0eWRlkFe/kaMM9pC1YrJ1OxN9+imjVG0tpWga9qYl4YSeUpBA9k5gNQmYyRFQFkuptf46Ck+Xt
 lY7LdRHwTvDQIBF53k0j0LnHpyt5+sHzf/3GurPlSRF+uu5rutYyt8dcBinqUUk9ydNi4QW5yOW
 gLzm2B/jkwc+CG/uavONHEXjaMiocFJCYZqDhdUM7WMSZZAG+WinxIcRGDNv85g1RIOBEBwkeAk
 u6DB76FnEr/wB/OsWHWl3CJ0RQ5U3mYI/SILN+ZzK9Y8bMQQ5V2k41p3mf0Yw5m8e19Zhpdy3ok
 a9fa22fTPDtZhhGrMKVk4xckPS2X5zXb2Yxu4=
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr348261785e9.2.1776940181368; 
 Thu, 23 Apr 2026 03:29:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr348261265e9.2.1776940180815; 
 Thu, 23 Apr 2026 03:29:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm535266635e9.10.2026.04.23.03.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/25] io: Use glib2 instead of strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:04 +0200
Message-ID: <20260423102922.443639-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here
 (2) we want the comparison data in HTTP header and it should be a plain
     ASCII one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-5-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 io/channel-websock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 9902b014f79..85b22a8822a 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -457,7 +457,7 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
     connectionv = g_strsplit(connection, ",", 0);
     for (i = 0; connectionv != NULL && connectionv[i] != NULL; i++) {
         g_strstrip(connectionv[i]);
-        if (strcasecmp(connectionv[i],
+        if (g_ascii_strcasecmp(connectionv[i],
                        QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) == 0) {
             upgraded = true;
         }
@@ -468,7 +468,7 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         goto bad_request;
     }
 
-    if (strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) != 0) {
+    if (g_ascii_strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) != 0) {
         error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
         goto bad_request;
     }
-- 
2.53.0


