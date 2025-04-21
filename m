Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE73C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 12:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6q5f-00039B-0T; Mon, 21 Apr 2025 08:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6q5c-00038U-OB
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:17:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6q5X-0002Rg-HW
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:17:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224191d92e4so38461075ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745237846; x=1745842646;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/YVUaaMZcYpUwgp4L2sj9L/HdRlwNQgzQpJhbBW61/0=;
 b=K9gWwsHozsvO+WWvILKLyUcPgqCwhaFZL9cFUNTU7dDCA9UT+AYleVrSx+NqUqcOrb
 cUdeZCF7AJBxYrWkhbTxCVJGAf6DKoepPg4Yg6oIFYvy6sZemJTNM9TAqXTIr8RCWIhx
 xpqte/b64wEGr0HpEGXkkGz7ASlimUBK8JjMmTRl9MDZBOMS9ExCghpK3Onq1OROBeIW
 vMa+jH5IEt4+vQh8+0R4H/aixr6U3DcuKsZnMqKp7Fx2+EuDDkLq8CZjBCUNDaNsRQ9z
 LAbJ/5muJQHTg6nD9cphcoZ8vTOGd/LvD8NpV+ibZAIJoxZCFob4leKcdMHxrXdtCQjV
 zUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745237846; x=1745842646;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/YVUaaMZcYpUwgp4L2sj9L/HdRlwNQgzQpJhbBW61/0=;
 b=cl/KLCZOHXMwNrvwAQFHyQt263nyFlL2Pu7QH0r9VC0tdXapm7KnY3w3jMXfl8JDWl
 pQyHUVTuPhQ/F1tvRsTyfhjfxQZNFt/Ew+FarZaoPrmfEPDPEq2YUHs8tWqgnWUSmDGC
 Rq0pXIBuWLtpwwJZ+HDzenEXID8b1H/uhIKugjnC/4nDCHnhztrNoUcnQKTq5JeU2puG
 Z+7uxv00PhuITZwGO1ibDhePiX7WAXgfC30ADeAkImjDwk9H+OdQVY+1hUHGD8P4GgWS
 VoOAbzQx0ko988iBnhcM2we6/BVh10Z2KkWDaB9W3y5SqgH1PRfuJyPYq9WVetBfuAV+
 wQ/g==
X-Gm-Message-State: AOJu0Yw44DNZEJXyWE3bVjdhh23F/MqZq5PIk8GMrkkuPeUl/OLOgxj2
 TxQqwOwbdfKBBB6MHVkN++0Smbgg6mLpfAxZI4dgLreuQ1814tzpZBsDwUE/J/I=
X-Gm-Gg: ASbGncsv18NS1FD5WulAdhPSauKhBy6daXiEHV6wpml2uUOEZuzON7GjD/a+yvc6lsS
 AxdWKwIvFmtRuP0GFH5nKzOABBkpKG2glQo7BvdOZRYXYxvGaXC7Hllb5u5b1uQ0SggpUmNeEch
 6v3FHs/0S4Ord6fO7XXICR8vEVhzv815eFSXk6mxu+l/kfg3dkYvuVgF7Umwz6CLMhinCkvjSeu
 VvIQudcbl+M9PfcUjUPKrP8zo+xhK3inCKm+IRSBqR7fiC2MdfaFXtXpSB8vJTMfpGr+cwZXWPY
 jvkU+nE9qrKFc++ml+FR8WkU32hwcEMuJUy73FUqunuImNg=
X-Google-Smtp-Source: AGHT+IG0Rk8C4aaq0dBfjaOinBppWAq3z0ODf3Ya6C6kuFjOHeO9BhR5qkduRScJTxCeck/oQGHeUQ==
X-Received: by 2002:a17:903:234e:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-22c53620bb5mr155761415ad.50.1745237845778; 
 Mon, 21 Apr 2025 05:17:25 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22c50ed297csm63974915ad.196.2025.04.21.05.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 05:17:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/2] virtio: Call set_features during reset
Date: Mon, 21 Apr 2025 21:17:19 +0900
Message-Id: <20250421-reset-v2-0-e4c1ead88ea1@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE83BmgC/y3Myw6DIBCF4Vcxsy7NDIq9rPoejQsD0zqLQgOGa
 AzvXmpc/icn3waJo3CCe7NB5CxJgq+hTw3YafRvVuJqg0ZtsMNeRU48K8PO6O7K3FqC+v1Gfsm
 yO8+h9iRpDnHd2Uz/9RAIDyGTInUxZB1i37U383Dj6mU52/CBoZTyA23EUBubAAAA
X-Change-ID: 20250406-reset-5ed5248ee3c1
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

virtio-net expects set_features() will be called when the feature set
used by the guest changes to update the number of virtqueues but it is
not called during reset, which will clear all features, leaving the
queues added for VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS. Not only these
extra queues are visible to the guest, they will cause segmentation
fault during migration.

Call set_features() during reset to remove those queues for virtio-net
as we call set_status(). It will also prevent similar bugs for
virtio-net and other devices in the future.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Buglink: https://issues.redhat.com/browse/RHEL-73842

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Described possible consequences without this fix.
- Extracted the change to move virtio_reset() into another patch.
- Link to v1: https://lore.kernel.org/qemu-devel/20250410-reset-v1-1-751cd0064395@daynix.com

---
Akihiko Odaki (2):
      virtio: Call set_features during reset
      virtio: Move virtio_reset()

 hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)
---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250406-reset-5ed5248ee3c1

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


