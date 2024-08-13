Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0FFC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy9y-000813-0q; Tue, 13 Aug 2024 16:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy9t-0007rF-UC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:30:21 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy9o-0007hF-05
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:30:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so6927491a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723581009; x=1724185809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8VJVqwOU+3OnI+KhTAsjide89+CrsOHDPq/j9RwzJ8=;
 b=B4jddG6PtgQVd/JlRN2Dn7Dy97dgxuHR32ymDUrNpiOAgog27C186v7MMS76wpdNdi
 iiCPa3akNprKBIVs8XySt0Ryri3mM5yeyjVQtOf2BVruPjg+Qf11B4X5itzVKcyowMJv
 gc7LaEQLYiEhdWDF6B+58KMZduusE/HPHnG5/sz3mkFTAGr4uCBPDeHxg3RyDlwuOMNy
 jZxXLQdccXhIH8asVKww6TPJFSZZ8LgneHPW+kCIWRBJEQOQyn3RVrmtUiMEtw/vDiVF
 lHcZ3F9WMTh8+H9/l5f0xI26DL0fDQ6vahjMWd+tGNec0svFqDe5CuIJV2B9E4P1kvny
 m2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723581009; x=1724185809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8VJVqwOU+3OnI+KhTAsjide89+CrsOHDPq/j9RwzJ8=;
 b=BsY2qr9wXCU6rdfqG3ugKUv0yFp4xIBmRIxAMkn1FbHUfQhMI7n1hLRpQGfkdEYXQ0
 WO4Gk5G3h81sv6U8TDfynO+3slC0nhMDvegVmtf6nJ3C21NqhiyuHhEFw82BRwdHEH6Q
 bnhRwlYjS3UPKEtKxp8VB/aeWKWMA06RvBB8EWeZlrMzth+O4ooyK0t3vx4FvTekSmPL
 ci+odM5WH4cITTU/WxtjdLXjGATMljhk1/tt+Qggc2BHyaqxINvLCYCmWm9ZJVE0Cpm0
 FzfSDitmDY+dMIimfGR6rvv0jo439QOBXSl4fehS5BidD0OvUta4YmeWZDFast6mYySs
 jg+A==
X-Gm-Message-State: AOJu0YwRTfzQzBWTZxwHVIVaeZOL4VpjaqqMEnEqDtQ6H6AXfKUUBCan
 oF6IngySi8/kswyFpPDCcRMQ5e3CdZZej397n8LSAoHCBn8MfH8mw/WCyd/+yu4=
X-Google-Smtp-Source: AGHT+IEbrpg+FXr45vd3vgmckaaVoEmq3bFsXX8AczPKD5IDIqNa2uewY1v70Y3ToIBVCfXRhW6gow==
X-Received: by 2002:a17:907:f704:b0:a72:80b8:ba64 with SMTP id
 a640c23a62f3a-a8366d552ccmr40115966b.25.1723581009064; 
 Tue, 13 Aug 2024 13:30:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f48ed5sm96719366b.29.2024.08.13.13.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:30:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D7465F8BB;
 Tue, 13 Aug 2024 21:23:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 17/21] virtio-net: Use virtual time for RSC timers
Date: Tue, 13 Aug 2024 21:23:25 +0100
Message-Id: <20240813202329.1237572-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2


