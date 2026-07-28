Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4CEC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooz4-0004gK-Rw; Tue, 28 Jul 2026 17:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooya-0004UC-IJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyX-0003iR-Nr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTM/N9lbOP8xRMWNN1H0iMPnAMdF9INBG5H3f+egzqw=;
 b=RLJuUdrmEEdprB4swlZs4u6v2x0b5tP/ex/7oinDT36tdMMZY8Qj0EPw6q+S662XOycL/F
 KHKR2/0FbOJuZtY6WtNzMftUJh+E5biMOcVnmPB8bUvhNnCnewqLBh0fgTlqiChKkJkVzF
 RnGWOEcKVniWzzU+45X50QesAgc+rDE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-Dxo8-o_sMDysM_TWjPMEMA-1; Tue, 28 Jul 2026 17:04:31 -0400
X-MC-Unique: Dxo8-o_sMDysM_TWjPMEMA-1
X-Mimecast-MFC-AGG-ID: Dxo8-o_sMDysM_TWjPMEMA_1785272671
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b571432fso36455285a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272671; x=1785877471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QTM/N9lbOP8xRMWNN1H0iMPnAMdF9INBG5H3f+egzqw=;
 b=mnFRSni87qgCHNGU/LZG9ZHd2qKNwgv3viYdnwvAGr+lbtuZv+oWdWQmWoKd2Niy/M
 xJmoZsxk72Zu8LUSRyDPqsP2ju8/13T6IpPMjm4FLezLiE40E7TUWDu/y1hadAlAVMql
 FYMkCN77hqj37Gr2LGG3Mj7HvBPlBXAgINPRHc5Ug1dCoFt7LC/nY/ufE1i7Hq8iw+8n
 WoAxLbnac2Fr73PxCyA8WWFoAxHjQo/fACU+te+/jHi/FUdw2nLIxOKPcyzKq29lhqjX
 LrAW1FuQMT2tOUHBPGFVz7JbxUAJIx93ZvgENYnJTMr69Ok+7Z0o9Z4FB6mAIk+XVYjo
 8+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272671; x=1785877471;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QTM/N9lbOP8xRMWNN1H0iMPnAMdF9INBG5H3f+egzqw=;
 b=eGW/GTMhrNYnKMDZkCtJWDFmisbNXjdtdcKAGxdg0FnaE++zLscX05muZZlLe38Lcu
 N+MGX4YM49s+dgKLFwqiwqwczlKGpdyKBfsZ184JQw7S1NIQvav0WFo02+3H2rP36pbW
 A23ysVwGFuLjbN+wUPHa4KtmsX6aiem0ddp2+58x9tnDOn9L6E63j0J7zfwVgq8Gqj+/
 bJf057vsylUjdqXR9jOawgJnhq3HYHDVOoJpghzhozBM42y/hTju37ixDhSlTg6aSunM
 qk5bxazF0ylw+H7k8tJa8ZMW2SF6s23ymozf60cNkOJdhUV5nb5zTRxpr0md9MPqurYt
 3BGw==
X-Gm-Message-State: AOJu0Yz9KKqG+L4w8x0AcjbC9VQhzhGKdQJMHkow7moWRhW83j9pZFhe
 Y2Uk0mPWLHAW/D8toE7osGlb2OotPSj2OrLNyENMC3EulBLZPWmfb4Dh2NPMznB/foAm0S1Y+LM
 wxCwBbhUGaurxE9A/EnF36VzGw3l4+f4iIkpTvTHK8BR/0+eD68nPvFYvSvpBW5zyRyani5qFF0
 jOVY0MkHLVvgCYNMCJhwXNy/xTNrMg3Yam51j9Ag==
X-Gm-Gg: AR+sD13v1JZiMenvWF/Xj/YSnlVjjYELJZx3hEapaYkBzsCgLdTzO50d82kxPdM4pMK
 5osyD7eyl6dK8HzfmF+H24Zd5kAtRDGb0DtiXyoNIzoZmjU/gecR3tZ/u1WTSXEpZ/BwI3vlZ3Z
 /JJ8MLCOX1eS+ToC/CLtcg7ZlDUN6mkOIOs0TeO0Soya26qme5Nj4bk/cuZOvp/Rp6H52BuZRIl
 +E2CXu8CCPpsfsbNekwF1GOfpS0A/n80QmcTzx3NXWeJgZRdRcH3M6Q1jyH33OCgUKkZSlt/FtC
 2tvNrC/1PsftBHzsdBKZ/lPwor8VkjRrpHWw6y3RYWHqPlrWvFT4XgoXDdHuoo7n2D++cxaYAbe
 zVqbl70LCCqTFUvatBxB/fqu6uzUwVifm8Ihc7UhrpmSL02YUevT5qegw
X-Received: by 2002:a05:620a:2683:b0:92e:c0ac:aeb6 with SMTP id
 af79cd13be357-9330270951emr375409785a.40.1785272671006; 
 Tue, 28 Jul 2026 14:04:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2683:b0:92e:c0ac:aeb6 with SMTP id
 af79cd13be357-9330270951emr375405685a.40.1785272670440; 
 Tue, 28 Jul 2026 14:04:30 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3227707sm21277985a.6.2026.07.28.14.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:04:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Date: Tue, 28 Jul 2026 17:04:16 -0400
Message-ID: <20260728210417.1925078-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728210417.1925078-1-peterx@redhat.com>
References: <20260728210417.1925078-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In an unlikely case, when a migration stream is attached to the destination
QEMU and only send <4 bytes to the channel as magic, it's possible that
migration_channel_read_peek() may spin forever.

Fix it by adding a manual sleep for partial read.

Since the path isn't attached to a coroutine, it means when partial read
happens, there's yet not much we can do but hang the main thread, it will
happen even for len==0 case.  It means monitors can hang due to this,
either partial read or no data arrived (but connection established).

Leave this for later, the hope is this is extremely rare in production.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
Reported-by: Feifan Qian <bea1e@proton.me>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926..f446561b59 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
 
         if (len == buflen) {
             break;
+        } else if (len == 0) {
+            qio_channel_wait_cond(ioc, G_IO_IN);
+        } else {
+            /*
+             * When partially ready, we can't use qio_channel_wait_cond()
+             * because it will return immediately.  Apply a manual wait.
+             */
+            assert(!qemu_in_coroutine());
+            g_usleep(1000);
         }
-
-        qio_channel_wait_cond(ioc, G_IO_IN);
     }
 
     return 0;
-- 
2.54.0


