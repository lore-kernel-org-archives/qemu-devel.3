Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6810DC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkzr-00035N-7s; Fri, 02 Aug 2024 01:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkzo-00034o-Mx
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:38:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkzm-0003gn-Ld
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:38:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc6a017abdso52784435ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722577109; x=1723181909;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eGaTYy3U1N6gj26D8cJ144df6qPTUusOZaXUi98TAYc=;
 b=h8tEM6NWojcFj0H1+MOtCzmlSVA7PGuO0YAJ2KRhb1ctpnwtGEZcLPsnd0NLQv0yFB
 hjJX24xgAM4PKEvL+GwzoRXP9WkSqSW1AwTF+9bidpKr2nr3ClxK6wUiO90PmR4VB3xS
 guRq09NJhitY/eJ8dwjRYEmLhxrBSrP1Oj2TBmD4MhuxXvmgbHndwF7ozr34U55PATvN
 oZjZa8MrrtxSuDTkAKhVeltVIhJfRsztoQ4qe04qnIkS5HKwctBWis/CCOHYvmq+iW4y
 IpCvp+TlGWAib5cqc2MYIhkP5CAI6U+q3qlpQL5th5vaFJatCdB1a2ku7d/lm63pmrJS
 1PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722577109; x=1723181909;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eGaTYy3U1N6gj26D8cJ144df6qPTUusOZaXUi98TAYc=;
 b=MEbwk0o+UqUHJdZpTSx8yRJYO553bLglVzgsHfKFE4TaJixj9h0rIS9eEmC+sL6cZY
 tS+qQP6Wk8vGzOIqAfM4IkZ0I4Ts2NFnHoBJs/93ElswjE3WKSvsFLhZK3KU2oSSoYL5
 iHs86zn4x7Z4xiZuAuFeU9j9iD/7abnnLNGUKwtJ31UnoR4ni0fe6a4KzveVInW5vFzw
 CE3wyIQfFDV2rA+iT9sTFHWah+50VQUzJzXtZJdc85uNifFJisIJU9T56qU5nGGPT8O9
 t3EBpOgYx/FukuHeN7+5ZyhvhRtrM14dGPIJ8SSJxrpcsF/Iyb2Niv2ZCE78t+gdanQd
 09jg==
X-Gm-Message-State: AOJu0YwROeUJ3FdugrLUxv9+GWHLcZyo+ql7aYEDXsg/bexUv7NIg6u5
 x3RZ0nzc0MMnm6C6Nh5Dp95xAQxLDI6twVVe5cPYxsjOcnwvLm5dRz/EcPKeUAk=
X-Google-Smtp-Source: AGHT+IFDOsyyz6BkWTABeJbiANg1s3wnYDMd3J2PGo5tIcpCkIxbXygTH2dzH4fiUA6OtBNpXtM6UQ==
X-Received: by 2002:a17:902:e741:b0:1fa:925b:5b77 with SMTP id
 d9443c01a7336-1ff574e2846mr30983025ad.64.1722577108902; 
 Thu, 01 Aug 2024 22:38:28 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f53832sm8387965ad.73.2024.08.01.22.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:38:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:38:19 +0900
Subject: [PATCH] vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
X-B4-Tracking: v=1; b=H4sIAMpwrGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMj3aLiZN1US4O0JBNTo6QU8zQloMqCotS0zAqwKdGxtbUA3lLU4VU
 AAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, sriram.yagnaraman@ericsson.com, sw@weilnetz.de, 
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

VIRTIO_NET_F_RSC_EXT is implemented in the rx data path, which vhost
implements, so vhost needs to support the feature if it is ever to be
enabled with vhost. The feature must be disabled otherwise.

Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/vhost_net.c | 2 ++
 net/vhost-vdpa.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a788e6937e03..dedf9ad7c242 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -50,6 +50,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_F_IN_ORDER,
     VIRTIO_F_NOTIFICATION_DATA,
+    VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
     VHOST_INVALID_FEATURE_BIT
 };
@@ -81,6 +82,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_F_IN_ORDER,
     VIRTIO_NET_F_RSS,
+    VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_GUEST_USO4,
     VIRTIO_NET_F_GUEST_USO6,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 03457ead663a..46b02c50be8c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -88,6 +88,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
+    VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_STATUS,
     VIRTIO_RING_F_EVENT_IDX,

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240802-rsc-e90fb452bd7f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


