Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D39CD13D2
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6WB-0002JJ-R3; Sun, 09 Nov 2025 09:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6WA-0002Iv-FS
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W9-0001pm-1r
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91i3UOyc3eezBkr70nZBeo508ef7mwoghfHMmpZOf8Q=;
 b=K22F+vu/OzNm+u6G6B8UQnwFaow627TYeIgFiLSPVI5fwhs74R3/luDiZWlujN5wPfTu8K
 v8hqYFlidl+ctz9flWIgdy84a4K4y958EEzSNmG/7Y5LfzcdNGhA47Fb/59PLg/F6glON/
 KWST9H70iO94aS345u3UeW7jt6adJ+A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-LwZLiGvqMGS61XFzcNncGQ-1; Sun, 09 Nov 2025 09:35:43 -0500
X-MC-Unique: LwZLiGvqMGS61XFzcNncGQ-1
X-Mimecast-MFC-AGG-ID: LwZLiGvqMGS61XFzcNncGQ_1762698942
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c521cf2aso1515623f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698942; x=1763303742; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=91i3UOyc3eezBkr70nZBeo508ef7mwoghfHMmpZOf8Q=;
 b=CKamfHSHW8XHgQiscc6H+rNSMsWLwAZoH5igMCmbvxdUPfbdYDVQ+nT+csVNVDTvTi
 uJgNsBHt8qYJQhJQmBWfk0+GNlMk3YNOlO/Z1hx/et3wSbOg9sqoxvf4Vb390GXCE0AV
 OVfbGWpQDDe5OcFOafweiPmBzSVyQo5eMi+tT6iaZAwMpexZ7hyV/jtgv/JGiJgsnu94
 VsOqA6oBLLmGlXDrOtr69+sIE5hHN0XjOcUmWmFLm3BVR5eELJilNgKj1f/7nn+vz7dG
 +wPnHFi3R+v1CxCJFQTtW8Dydp4nMdtqhNSpXmdB60q0fi/Y3b9uWbHSvfhpAU9Ol/9+
 Aj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698942; x=1763303742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91i3UOyc3eezBkr70nZBeo508ef7mwoghfHMmpZOf8Q=;
 b=jh5kzzVjvzHt+QtB3K90WvdMWg1ZjwSqFVh172/lpUkDu1PLtS2gbX3C/uBi05WV3c
 gkHMn1fZQfcSMQTLNDQ5g11l7A1WkLpkpgY/+aIFdvrgPEbDZJTiMJOwLXVS3ogcSElm
 Id9mXgHuJmM86+Ik4SAp68U1CJVmVXVqd0hS0OwUhZC122n0QhHuPGE9UrVVONDx+czQ
 W6Od41XLr9/XRvstOtatAHQiCz3CW9bAbm/jZHSNuhMP4FFnYfrlrv+gMV6YFFlirnUZ
 hd+hFwGkqbVqstBavcX1iFk5bdXOEiK/d68lbHKAP3U3U4ejHQVU5WU6EilfoATBI2EB
 H/TQ==
X-Gm-Message-State: AOJu0YzOFh7xSYL17JJ3h4vomlOszj9hZt5YMRj3BUegf+S0sl2P01cO
 iAwQuwWjUyBGuHj91QvZwvmQINWP/SrlwhZutm6PA/Ucmpd0r7pQ34+iizs2wryeAN9WIsFgp2W
 JNqTz64i3LNAzMUR4PYuRh3GEFV/wCIQeHRW+IIUrF6kGe6z3+4iOjatgnZLBSHT5bgsVtpDUYb
 fxHHQSasVt73CqAvf9/heuHumm6bkmgSDXTw==
X-Gm-Gg: ASbGnctrbFg1axhpC+DHtGuS8QUuhO9eRqZlCUR28lofVvQ27iivbhS3Z6Pe67SH5Xj
 luXB4ZwquJpXVPGG/lu+kMoXwsofs6ISPysVVe7XR3PW1fxoOknivoE4KN2cRH9v90ylDV6MR2c
 F3G+/QnVWWaywaA55gJ5ctfJtSwInWAhxJbyg36pCjwRSahtmmh2BvzQK6yhFcdCwZHfCB/Cw88
 tmzoEWybqN2lPmtxqXim1Q3fTFsXGmHAsaCYs5msMnQqF7FsbyYQsdOHRTthtcu0ZyCbSkQo+s1
 5KtTL+1A+ZBCow1zchY6k+A9hsx57JG1mBgA7Sd0/RidixkvevPfWkhZ6t/3SsEkXeE=
X-Received: by 2002:a05:6000:3108:b0:429:c4bb:fbc7 with SMTP id
 ffacd0b85a97d-42b2dc1e2f9mr3968901f8f.16.1762698941659; 
 Sun, 09 Nov 2025 06:35:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEoqDzmGV6WXGm+1tuYHmCXemRc+5x+atrWLC4vOdFzBABDC0YzorwiF+LSsBUyvIK0r+18w==
X-Received: by 2002:a05:6000:3108:b0:429:c4bb:fbc7 with SMTP id
 ffacd0b85a97d-42b2dc1e2f9mr3968879f8f.16.1762698941070; 
 Sun, 09 Nov 2025 06:35:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2f7a0512sm9051996f8f.18.2025.11.09.06.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:40 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alyssa Ross <hi@alyssa.is>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 14/14] vhost-user.rst: clarify when FDs can be sent
Message-ID: <97f24a0496be9e0a7216fea1fa0d54c1db9066e2.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alyssa Ross <hi@alyssa.is>

Previously the spec did not say where in a message the FDs should be
sent.  As I understand it, FDs transferred in ancillary data will
always be received along with the first byte of the data they were
sent with, so we should define which byte that is.  Going by both
libvhost-user in QEMU and the rust-vmm crate, that byte is the first
byte of the message header.  This is important to specify because it
would make back-end implementation significantly more complicated if
receiving file descriptors in the middle of a message had to be
handled.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251106192105.3456755-1-hi@alyssa.is>
---
 docs/interop/vhost-user.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 2e50f2ddfa..93a9c8df2b 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -411,6 +411,13 @@ in the ancillary data:
 * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
 * ``VHOST_USER_SET_DEVICE_STATE_FD``
 
+When sending file descriptors in ancilliary data, *front-end* should
+associate the ancilliary data with a ``sendmsg`` operation (or
+equivalent) that sends bytes starting with the first byte of the
+message header.  *back-end* can therefore expect that file descriptors
+will only be received in the first ``recvmsg`` operation for a message
+header.
+
 If *front-end* is unable to send the full message or receives a wrong
 reply it will close the connection. An optional reconnection mechanism
 can be implemented.
-- 
MST


