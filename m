Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF5FC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDG-0004Dk-Dx; Mon, 18 Mar 2024 11:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDD-0003uy-A1
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFD8-0007v5-1G
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so2993825b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776856; x=1711381656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhbUaEW+2x4ajdSm7F1FWUPuBN/KHA6Xi8kM/8vXMJ0=;
 b=U5jzI1Ox0JCI00vOS7yfpJzg57QPNNEZqI/nHhOq51SgcGug4Z2A1cE+iBZ7lThUfd
 3TsHIDnTLjkRHQIIih1m9jGh3ct6p5e1qTSuXUODivTqoz1THv7/rmGmkOZlQ/dVkawJ
 xymNyXNbNa48LsSPwFtXEsF/BOajz/W7b/ZfovWC0VVbqV1xJFoNa+wMRqY30MZRpkDo
 JIKnwwCLNZ3reJUrqTRVAI+pVlwTcHssTVI9OHopXH3ZoWfeCZcmU/EKj5Mz2Mcdg02x
 D2m4UYuJPZFWl0oQRTZ1TPQ/HfaVOQey8Us3WcXvPXiE2JKMoIRMCtmMw1NEHeGILPCG
 CJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776856; x=1711381656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhbUaEW+2x4ajdSm7F1FWUPuBN/KHA6Xi8kM/8vXMJ0=;
 b=AFA2YdO5EMFyqShM/MB4q02pDPvJTgTCU/cZAjxy/0V4qh4ChfyUWDZO0dmLtbLh/j
 vIGioyWe55fXYhpiBdIqrt8elGbhMKApeP6yhUiC/nySe32fsOiC4j3t+5IND9vq5cdX
 YRAteWH7fSJex7sOe6qcmn+scuLrPz0/lrP0GVwgQiqp9Mq51Rj+6InSecVZNthqnNPi
 gJNKRyAsv1KMaDRAIxDYWv7RqJNPY8nfIarZg4xXd7se11F2/Bo+Tmsby9I7VuTUtsju
 fF+QZzsm1C99n7jDjyocuDKcis0ie2zo9THa2GOemuc6qB+g1unKD3qImmmJv+bE1Z79
 SENQ==
X-Gm-Message-State: AOJu0Yw17IHSrgtYsxLTKWrJSZLWAq0yOAv1j8ylHc+LtTgJPrtcO+L6
 PWvYTM0b0LEzcvGlzhVQiedCPVewczlk5IZiPSHEwlhxZazG4plTValz9jU/GaI=
X-Google-Smtp-Source: AGHT+IGHcljV3Nj8rWLf1bqsA9WylQbg5aH0ShA1ONiyqUkMxIGubGk/T9sjveQA9bM7KT9gH4HxrQ==
X-Received: by 2002:a05:6a21:920f:b0:1a3:4a1d:1092 with SMTP id
 tl15-20020a056a21920f00b001a34a1d1092mr11893355pzb.35.1710776856307; 
 Mon, 18 Mar 2024 08:47:36 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 11/24] virtio-net: Use virtual time for RSC timers
Date: Tue, 19 Mar 2024 01:46:08 +1000
Message-ID: <20240318154621.2361161-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Receive coalescing is visible to the target machine, so its timers
should use virtual time like other timers in virtio-net, to be
compatible with record-replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/virtio-net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6ac737f2cf..894df25222 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2176,7 +2176,7 @@ static void virtio_net_rsc_purge(void *opq)
     chain->stat.timer++;
     if (!QTAILQ_EMPTY(&chain->buffers)) {
         timer_mod(chain->drain_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
     }
 }
 
@@ -2412,7 +2412,7 @@ static size_t virtio_net_rsc_do_coalesce(VirtioNetRscChain *chain,
         chain->stat.empty_cache++;
         virtio_net_rsc_cache_buf(chain, nc, buf, size);
         timer_mod(chain->drain_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
         return size;
     }
 
@@ -2650,7 +2650,7 @@ static VirtioNetRscChain *virtio_net_rsc_lookup_chain(VirtIONet *n,
         chain->max_payload = VIRTIO_NET_MAX_IP6_PAYLOAD;
         chain->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
     }
-    chain->drain_timer = timer_new_ns(QEMU_CLOCK_HOST,
+    chain->drain_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                       virtio_net_rsc_purge, chain);
     memset(&chain->stat, 0, sizeof(chain->stat));
 
-- 
2.42.0


