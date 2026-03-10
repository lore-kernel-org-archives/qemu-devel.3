Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC85EB107E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 21:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w04cT-0002MW-V5; Tue, 10 Mar 2026 17:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w04cS-0002MF-6k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w04cN-0006J7-8B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773178072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uyTDzpLR+Gdd9SMiQy2COefWh/cQWvnMk/HB1hTEIOU=;
 b=N4i4md9XL66leIBdg7nHLpgmm7xHpJZk57dvNGcC9+pihzxgCWyl737K81x9yQEfgoQG6U
 5Xb54gDVl6QkvtJwR7pye5MVQAFKe+pIlwgAytrj/lyNAwJBvQmC7lY4HtZsQ3lxJn2B26
 0GEcts7kJWL0fzz5yp4w3HaLGA+SMgY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-Uxyzo4R9NgiCBFMHhMf9QQ-1; Tue,
 10 Mar 2026 17:27:49 -0400
X-MC-Unique: Uxyzo4R9NgiCBFMHhMf9QQ-1
X-Mimecast-MFC-AGG-ID: Uxyzo4R9NgiCBFMHhMf9QQ_1773178068
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 944C7195608F; Tue, 10 Mar 2026 21:27:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF29C1800361; Tue, 10 Mar 2026 21:27:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] virtio-gpu: fix overflow check when allocating 2d
 image
Date: Wed, 11 Mar 2026 01:26:52 +0400
Message-Id: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ND3eSyVN3ENItEs+TEpDRjQyMloMqCotS0zAqwKdGxtbUAynzvAlU
 AAAA=
X-Change-ID: 20260311-cve-af8a6cabf312
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Zero Day Initiative <zdi-disclosures@trendmicro.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mBc1Qr8LpF0QeGx1uyunREV6PkyjRSpeIZRi8PAAQGI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpsIzNmt6osK+gC0keJARdQ8KJ4DKIgPoSu0s8B
 Zu+zzyakSeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabCMzQAKCRDa6OEJdZac
 5b4ZEACUV4NTHoWXvYhm7pQILCQDgZre47PUFbFalUvXSl5gRaGmKs7yoWV+zibfaxLmurFAqYc
 mmAhVt2JVy/66qq11vLZ46sxUJu8VQuULK4gKQcmeuhlofcpr00+oPqR4zE3Cxs3vOb5F9wUxpI
 byjGWJW43MfDYJU3Y068mK8EdykuEdohF2WK+budcdXBsekpOTqPhqk8Y+yCCpjoIkZDkpCsRIe
 9EzrFDRQ9h53NSXTnot1YSQN/0OZWE+298AKKdMfWXT65ONJgmVHr/EZ+M0XAWUORowZOvTGpoI
 +ohZEoucTuGK38aPF1hF4qbJXdH/QaMK0S8YH8eeNJGyhZEwybgu8Jr7LL54joH1lS2DXL41Q/H
 XKajlccIK30S16KSrNlyZNL1+wpDr4ieCNUWABxXPZI+GKpRnuHpx2IQpehwi0NhFQfMiJ0CvGt
 XoZHX50sfXY8W/wAPluiitpxEe7j+axuAH+DhldfHF0YuQr4oe8jkJvDyEcwWd0Qu7g4hriABmd
 uSzRPYJCfktxEpiB1KFn706/h8C6OR9BVzYHBmIutRI6uYVY2FaiPDdDya1m6zcVCiff2ajDXY7
 5RE0G1Qrgx7CxcGHb6WL8KLDHa/zmYCIzSpAFDudi7YWi5kMoo1YR4axYDsHX2z4MPvDdN/+KoG
 wVEry/jK5T38gOQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The calc_image_hostmem() comment says pixman_image_create_bits() checks for
overflow. However, this relied on the facts that "bits" was NULL and it
performed it when it was introduced. Since commit 9462ff4695aa, the "bits"
argument can be provided and the check is no longer applied. This can lead to
OOB access.

Thanks Trend Micro's Zero Day Initiative for identifying the vulnerability.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (2):
      virtio-gpu: fix overflow check when allocating 2d image
      virtio-gpu: use computed rowstride instead of deriving it from hostmem

 hw/display/virtio-gpu.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)
---
base-commit: ae56950eac7b61b1abf42003329ee0f3ce111711
change-id: 20260311-cve-af8a6cabf312

Best regards,
-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


