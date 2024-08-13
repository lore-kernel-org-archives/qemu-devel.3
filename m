Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4BFC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjl4-0002QM-EE; Tue, 13 Aug 2024 01:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjl1-000207-G0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:43 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjky-0007rQ-PG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:42 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5b22f97b7so4015147eaf.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525657; x=1724130457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwoV2EHPqP1ARxWy8IKqb1XishFRmCZirlXne70HlYw=;
 b=AGVSYa4mxeHpT29xdKlEzZRdZwfq4Z0oC4YTvXfd9VucEt35G9qd8w3j+sfxAlzojE
 dbHK7QRKOny2N6jmBw0w1O/tCnxGyUHrIz8HKCUO6EGZthtQ4YzqlFiV684U5kbQXeUi
 EhQBBsXaH5MySRhQPflCmSvoJhcK8l2UFBDTupMBKkuZF10IoXbb0oI3j9/mBT0vQta/
 a9Qo1Rhj88PJca/UVVSqUngxBR6f2d/4gnnXPkCvFXStJ30ewUl9vy0FaCsexGhbT+R2
 bylTC+K1O3lx9T33tqeo6dU+NpBc4oVJKEhuhPZtg8zPDZqCU2u3HwGSESBVOVq0oZXj
 tAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525657; x=1724130457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwoV2EHPqP1ARxWy8IKqb1XishFRmCZirlXne70HlYw=;
 b=wYFmf1pjAk+pEhGCUm5dKhGe7jUI7lKO27erkN84PABUubtu6/eJs2sqABUruGpaP8
 XyaQRFcmXJu4pGLS3JSdryvJR7cUkb67mhSaTGaV/bnk3lenr1kZqFa9juOc7YhrppAT
 iioeMw4u5MSBCsZF+3N/A1rHu5iXy+nhF/av9exDOMw1eqDWGl8mGqYsdAgsPlSJ4MMe
 jGa8+oADoCQkNEd3DaqkY71ZdDplENPR9ileol+7l6W+Hg/nLajQbxOxuuuQOlAygvKV
 hyNXEQ7d2MuePJnH1jKG9I6m1o1KTnOOj6YWMgzZbFAelp36h+vJj8cViq9hARvbK3RL
 6bNg==
X-Gm-Message-State: AOJu0YwUyskbTuxzufiToiaL/p0Vk96cRIy34pukE5ilo/C8tiqDcJv+
 HJJPf2r4GbLyNR+fg/TjZWgIec7bUgEyKdxV49Ki1GTBazjnYlArHLBEraX2
X-Google-Smtp-Source: AGHT+IFRYjE/Qmk6NjNXhNO9c+/7JjhPXsOfGuld5xsywMtTmKYZEDjPIkA8b3FmjDG/a+dryiyWwg==
X-Received: by 2002:a05:6358:60cb:b0:1a6:b034:b381 with SMTP id
 e5c5f4694b2df-1b19d2ba055mr332002355d.3.1723525657504; 
 Mon, 12 Aug 2024 22:07:37 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:07:37 -0700 (PDT)
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
Subject: [PATCH v6 09/10] virtio-net: Use virtual time for RSC timers
Date: Tue, 13 Aug 2024 15:06:36 +1000
Message-ID: <20240813050638.446172-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc32.google.com
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
2.45.2


