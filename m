Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D662C531DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebtx-0007wV-KO; Thu, 15 Aug 2024 10:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebts-0007an-49
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:56:29 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebto-00014T-53
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:56:27 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so890888a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733780; x=1724338580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vFtKZMCqZ//aDW9JM8+1eoo4MiLhC2zYG7YF5q15rM=;
 b=phvu/T9SnomwTs47tYDaem6MvlkKJ6Z6ukZ1X/bHeA4aYLlUESLJ+ne9kUlJPQ+L0G
 v2K37YQkgP+jg7AZAe85LcXNIrj6bhDkSMz4cSxnIDvN7TsYjk3Xse15d7fB/u/jhdKO
 wyHzsBFimU9qbaTeQX5SgYnw1Qu/nOp7mjxLEMQcplTi3uisV5ymS736VYdHkmXXZcwc
 I6+bokGiCie8MOnLudxiOANjTCPrc+ZoZZBfV3zZVC24CpytDNQWrasTtkayluHaJHKQ
 6vRgabSZcx0UXhSAuZC8+QI177bIcKPIKkBvifwv/5QPXFF1RRtx41EuZ4x2ks/ZMPN/
 XTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733780; x=1724338580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vFtKZMCqZ//aDW9JM8+1eoo4MiLhC2zYG7YF5q15rM=;
 b=S77UbVFtNUwimFxHVk0PVZ3oBPaf0Kkh6PCWjZ9p9qDGxmLQDq3HaeW62hk9BDGE2C
 XlTy/Hv7wj8ykUUN7i671a6xt7tp1R6wDLoNbn6OW/W4U29ic9FfpOnk4UWm2CznTb5K
 EHLjAFft6YjuPqb0CpVE1XmYY5uX/hffwPJUu6ql1+iTGI94GR3Tyu0SE6cZgU0R7Thf
 MtRlGcHATGlbsUBZoqHLUEyN5Xce/Qrg+AwaKvdQc21/1Cix82dcRxC7oIcD3wIV4vDQ
 K52YTrCK4mtfo5g/f77/SuYLOl90JlfxdJHEpfHhVgBfwkL/63eyImUCewUqQHn5Zh/T
 h/Wg==
X-Gm-Message-State: AOJu0YzjQBxjGcdQ/GiO1RgAuWpBZxhgOggDE06ZYWZ7oBm24NJVaN8B
 ao9RbNcns2t1N6Wd8V3xhL3/ZFvXdr1oSkk3fp97T/RGfEgL06AYaLiSySKaE5c=
X-Google-Smtp-Source: AGHT+IEdvW69uizgr/OssDuGL/mJIkDRhSrDYVv1+9FYzxBVxzhHUX/DxDpoxUfI1O9/a9EugGCu1g==
X-Received: by 2002:a17:907:7f13:b0:a72:5967:b34 with SMTP id
 a640c23a62f3a-a837cce9ab7mr292721766b.22.1723733779664; 
 Thu, 15 Aug 2024 07:56:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6975sm112618766b.41.2024.08.15.07.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:56:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 503B860263;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 17/21] virtio-net: Use virtual time for RSC timers
Date: Thu, 15 Aug 2024 15:49:07 +0100
Message-Id: <20240815144911.1931487-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Receive coalescing is visible to the target machine, so its timers
should use virtual time like other timers in virtio-net, to be
compatible with record-replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-10-npiggin@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-18-alex.bennee@linaro.org>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 10ebaae5e2..ed33a32877 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2124,7 +2124,7 @@ static void virtio_net_rsc_purge(void *opq)
     chain->stat.timer++;
     if (!QTAILQ_EMPTY(&chain->buffers)) {
         timer_mod(chain->drain_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
     }
 }
 
@@ -2360,7 +2360,7 @@ static size_t virtio_net_rsc_do_coalesce(VirtioNetRscChain *chain,
         chain->stat.empty_cache++;
         virtio_net_rsc_cache_buf(chain, nc, buf, size);
         timer_mod(chain->drain_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
         return size;
     }
 
@@ -2598,7 +2598,7 @@ static VirtioNetRscChain *virtio_net_rsc_lookup_chain(VirtIONet *n,
         chain->max_payload = VIRTIO_NET_MAX_IP6_PAYLOAD;
         chain->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
     }
-    chain->drain_timer = timer_new_ns(QEMU_CLOCK_HOST,
+    chain->drain_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                       virtio_net_rsc_purge, chain);
     memset(&chain->stat, 0, sizeof(chain->stat));
 
-- 
2.39.2


