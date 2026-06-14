Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979E0CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDV-0000UX-2V; Sun, 14 Jun 2026 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDS-0000NY-EO
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDQ-0002l8-SS
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1a87ev5WzUSmrHocVk9epH7IkkDeogv22x3ZdbZKZs=;
 b=CmqXBUJxBeq4KyCS2et55W1DazKvWfs5okk/E2XxcFaZ4bsTg+R3YT+mPTLlAD0HFHeBdJ
 rbiyYXibZGuG6fwQZuBb0j1+zxsd7AXXX8KHKr/dRHAxoSPfbv3ugGdx0u6SQQCUagnkSZ
 t8ZbX+UXjjLgXiVcR151NMbtO4Uj12A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-f0xkusDgOdSIfx2u64BV4w-1; Sun, 14 Jun 2026 15:09:51 -0400
X-MC-Unique: f0xkusDgOdSIfx2u64BV4w-1
X-Mimecast-MFC-AGG-ID: f0xkusDgOdSIfx2u64BV4w_1781464190
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so22034205e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464190; x=1782068990; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K1a87ev5WzUSmrHocVk9epH7IkkDeogv22x3ZdbZKZs=;
 b=hQTpPxqQjyHazRPbSnThP+3ZiBvJcX+NVVo8s90H8DC+gNdXsDFtfajC/er9zhzhuX
 mvQGokaoqsfnk82ws2cmm+uQBgnmib34wCxStAjq5vIbxu2S1xvWJLxFhAYRUPcGCHnw
 xcFJ5eCNv+MSq0ddfyEKqNX4eJ8tylRNi2R/F5Yu0IE1lLsLoxzgpW9SFohV5vweM2cr
 3JcmU4FKof6Xe6WOGelnWANFg0IiFCXKNbNSLHklntgf0ICGGhdetbf6MLMuzDUOMbhT
 w/DzJ7jlbqToxQ79vGU+5Sa/aGc1DypKUe4NxdpegwbA7NenM/DF66G0h3p3XsFPH1aU
 /ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464190; x=1782068990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1a87ev5WzUSmrHocVk9epH7IkkDeogv22x3ZdbZKZs=;
 b=CJWEzfTf+c+GRmmpJjitospmdnXPKpE5n+MIpV6VjWok6KkTJB+zeRciuCUagZk8df
 R9p1NqV+G6GP01RltLgm9a8kYdp8fyTIjcMvfoga21iypHvMUH9CSZT7zKE17p3gvxhQ
 v04WjwObzH6irq/YWyobwX/yzGro/6OeAblj2LXSZ0X3W5dz68tuinpNKW7KZzAp4EiA
 SnpDwhwncachTC9fbMQdGHGDXBDYqj0jysRFuksQkXz6xwDtqzEUgn1CS/ToXDW2XPvM
 sABxpfRoRxb3YG1dIzt6w4XblP2V+mrMqLhPgNOb6d0iCz2Y0MFcNj5Z8AYqDAuIrpu8
 dFVQ==
X-Gm-Message-State: AOJu0Yyzy7drqdgWjn+YPqDCX03VV/InjMI0hpOniv1U3z25iR9unxd1
 dB2Wumau1TeggfSnCgoRMuZ6RA7mI/052iGqsnSvCebfD4ntMtM8rqfXBCTUhGjNJ/QWfK9NC8f
 ULkQt6CW866FK8BI1rMQdfuKJd5vY+0ichjqyabHMYFHs1NPKJwVwyX6MXzUjJsdk0DrL30f2TR
 TmxKrLtgXDGM7HFCY7BwUbs+f25B2ISKe8dA==
X-Gm-Gg: Acq92OGbccluoJ5vy8/dwmq+fWHNB+bG9Dsq3NQj5Q9ufGebUUA8xoBQhxsqEuGABLj
 6oz86esyM04vySSCH7GRHpp13wXNX2lF5kCEausMwjybVicnkpUnVGaf8EVs/ymnykqB4TQ4ERV
 qKkam94yAv53J4oIW6TatdrMe/CgU29kp1S4JecedsNjH4rP7h204QGoo6vOUBPwz+sJPOk0EdU
 gdO1/QHTMBYEapU5bIrz0bHYCc7PGfDOEPhpycJF7jTKsED1si35UvuYeLJzxTFHJ0qo2yIBkUa
 YUnL/1A/iEKaN+pxXGu+zo1mi+k0HIFLllusXRGVcEYeC0KzoLRq53gF2bUr8R2dO6tk5tMOQWP
 kSOax1s+ASYAGSM0OYVcqJ9WOY5snMnIXEyRn+quYXSo=
X-Received: by 2002:a05:600c:8b44:b0:490:b65f:8b1 with SMTP id
 5b1f17b1804b1-490ec4992b5mr139293685e9.5.1781464189721; 
 Sun, 14 Jun 2026 12:09:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b44:b0:490:b65f:8b1 with SMTP id
 5b1f17b1804b1-490ec4992b5mr139293245e9.5.1781464189192; 
 Sun, 14 Jun 2026 12:09:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d2449sm168855225e9.14.2026.06.14.12.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:48 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 098/106] vhost-user.rst: fix typo
Message-ID: <480be4f43b208e585e68c300dcab924adf6765f4.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Raphael Norwitz <rnorwitz@nvidia.com>
Message-Id: <20260330095226.158386-2-dtalexundeer@yandex-team.ru>
---
 docs/interop/vhost-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c0ae4cba98..c83ae2accb 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1329,7 +1329,7 @@ Front-end message types
   How to suspend an in-flight request depends on the implementation of the back-end
   but it typically can be done by aborting or cancelling the underlying I/O
   request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
-  protocol feature must only be neogotiated if
+  protocol feature must only be negotiated if
   ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
 
 ``VHOST_USER_SET_VRING_KICK``
-- 
MST


