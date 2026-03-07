Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FB8FCB638
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnf-0003Uq-RH; Sat, 07 Mar 2026 10:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytne-0003P1-R2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnd-0002cI-68
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:42 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so118064265e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898159; x=1773502959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Og9IPGiSN9L03BPKj7huycvO2v5oSung0TvI7JHvuuE=;
 b=bhGkD+/l8MY1ke9sVRgN/44dFFDVB2N4ti0k3jw6/VmiRR1CANy+Z8Hi7t6dilP3eu
 xy34aVROaoR5m1NYPfbwn+rZOm3+JfQP/OjJWF5+BMwiMEFTHkovhnkhXEgrTtCRTD64
 Bwu4G3zkKgeZYIxlds45q0tqawAwZUGhQXOg4P8mmK1XvDgG2Dabj/7DAwBdKhHnZp3+
 EI2Lmjzp32bOPAmigo/Qbs2P/kXjUN1p5x9zWbtmmEsAzK009WG8Qkgx9I61iwvNd7IT
 fFgVbSNUkVho1th4fIF2fJ4Q6Rg93p30VxijaXaQPVWpNuMVYkQE0Ve4ZhRvVdbiNDdS
 1mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898159; x=1773502959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Og9IPGiSN9L03BPKj7huycvO2v5oSung0TvI7JHvuuE=;
 b=d8WbXuKvTP5zWCzIdaFHpzvNatPBCu1uPCZSo2OdPq/FidrkviiGa5qQRnT6MdwE16
 sfb91HxdIrL0xjIJzzLy4Ap8SttKplyBeB4win7MI5AUZUmoBG7/FrTRcmgA3Miy5YBE
 XQObPXLCwDX0B2wD+dXCpPnq0X8UdoJ0svLluZZ+3+Nig+eqdxXjIwIjKwQG6HtKkSnb
 dqmwmIkD9/MJawzM/guZKdBCvvgRls9989JCQEDSGta3uWxbS/mY/jejFZSSAuwMn9z/
 FdMj0UGcEthourqb7IPl+aawferDtAIfbW/Fg61wg93pzdApiIIeZD2830N4n2B9pg8Y
 a56A==
X-Gm-Message-State: AOJu0Yzu9wZelpOH736vyDQ8qrrDIITI/c6fzuHVOUyMdiez2KTKPCPH
 /IJj6CX512N6wlTU+zbqEHnuK0+FpvAkq/NyjziL3dxhx1ou0QD4UkuOGZv580R4AA11CKqvBm+
 pAv03NZY=
X-Gm-Gg: ATEYQzx3B3x6UKropZGq4ke/XkIpVepGrv4qn806P06Lq+fZ27y2zkEl0Rnq8Q55K6O
 GCUne2mMzHz4QXH/GSAEfwrfnUjYPpRcQQeEYsQWxp7nzTxs3F5vXeSmog48RNXBnjhdF3qQxPJ
 mzi9jy7ELj6HSQD4SSRyyEJ7pRh6QgUgfCjt9ELLTxinAWqQi4tExWAgip37JwjO2qGWlQEPNn2
 fR1k+lFvctt+eNehb2+1om0wevGzQ40dpLltlhE59JhzPIzvry3THj7e95MWKHg/k9/gWjdyAEW
 eQ58eLE91D63L9jls89vtZj4jud1I6kmLub4KCqVWvCSQ8mA5BnlchVs/NTyh3emPlnPByIGYRD
 dWJQgvaywYeIhpjrVgGOWHiq25kLLjmDUtlT+i58buDjrzQj67l2ezZo95sVbyoZOVKHqgyd/lb
 FY3uXdG1ItIg9tY7xUwxU2Bg3v1ooezeGiPySvibW1zPMg/pm/BGm+h/nnKIDNWlfYWVr922Mz
X-Received: by 2002:a05:600c:a013:b0:485:17a7:b9cc with SMTP id
 5b1f17b1804b1-48526958835mr93584975e9.18.1772898159210; 
 Sat, 07 Mar 2026 07:42:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb85b8sm12050264f8f.17.2026.03.07.07.42.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH 5/6] hw/virtio: Remove VirtIOBalloon::qemu_4_0_config_size
 field
Date: Sat,  7 Mar 2026 16:42:01 +0100
Message-ID: <20260307154202.86309-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
References: <20260307154202.86309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The VirtIOBalloon::qemu_4_0_config_size boolean was only set in
the hw_compat_4_0[] array, via the 'qemu-4-0-config-size=true'
property.  We removed all machines using that array, lets remove
that property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-balloon.h | 1 -
 hw/virtio/virtio-balloon.c         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 79ac194ccec..abbf3397188 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,7 +70,6 @@ struct VirtIOBalloon {
     int64_t stats_poll_interval;
     uint32_t host_features;
 
-    bool qemu_4_0_config_size;
     uint32_t poison_val;
 
     /* State of the resettable container */
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 38bf1e84a1d..4c5f486ba23 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -708,9 +708,6 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
 {
     uint64_t features = s->host_features;
 
-    if (s->qemu_4_0_config_size) {
-        return sizeof(struct virtio_balloon_config);
-    }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
         return sizeof(struct virtio_balloon_config);
     }
@@ -1054,8 +1051,6 @@ static const Property virtio_balloon_properties[] = {
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
      */
-    DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
-                     qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
 };
-- 
2.52.0


