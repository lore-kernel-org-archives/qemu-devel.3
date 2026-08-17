Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7ABC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3t3-0003rt-4a; Mon, 17 Aug 2026 16:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t1-0003rR-Bf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t0-0002nX-12
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=108l7THhgpe6cHYXpok4mx1AU2dSOtOrPe6nKfAK15I=;
 b=HPMVWrpOFwzk6D24mkqU3ii8RIyJIjN+gBAE471eNbjKe2Ni6fXdinpw4H4jAT4ElyunNz
 LMskR64kl/qFl9y321eXl2gBuHFVYsOIxbBsfx9VH4qzPS1nZyuy01SDKZC8hA+7ndMd19
 RaRCVB2V+IwU6gMW7ixh3tmtS/jYef8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-xlzZqcOGNA-5VrGx9zbUkA-1; Mon, 17 Aug 2026 16:24:38 -0400
X-MC-Unique: xlzZqcOGNA-5VrGx9zbUkA-1
X-Mimecast-MFC-AGG-ID: xlzZqcOGNA-5VrGx9zbUkA_1786998278
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so71166981cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998278; x=1787603078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=108l7THhgpe6cHYXpok4mx1AU2dSOtOrPe6nKfAK15I=;
 b=GOrC5zewqrLT+vyuPMCH5HwE1WyK6jNmF3LS85femZCHLd0zxjilV8l7cQ3yA89j9Z
 OWg85BXwDlMlkCnBGC1rxzTUipRd0YXMby/pcHy9+bd03XMfVGVXomlcuB8EnwXTZO5D
 YC0kstz4QWgr+Kf5HoQufzJlZyg2c8WQjLz9yy4PF+Cf6jYH/Vpx2/kdAAKZ25LyHFPO
 TpZX9oieVyGXVr7LDiG7KMHTPy9Vj5vzm6LLtF8eQSTOa/3q2OG2+claeAqns0bbMksy
 WZZyF8EuDWg7nvYX0vUseTNlrHSrHokNlQYhVgKxiZdK5pUsR9ceuMDYUH5JKUesT7X7
 6ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998278; x=1787603078;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=108l7THhgpe6cHYXpok4mx1AU2dSOtOrPe6nKfAK15I=;
 b=pE30ddG8kNImHSczX8SNHouPv7V1FqOITp+cU3NLpsbGRtTvZyFe79wjnRbUxWjxKy
 isq0J4A++pIwas9DMuqBqOaH7gLXAuivd/QGinLBwwPGZq+xkh0LtW8ztAvpMsUcdwV2
 CGT0cRZHvQMmLAaZkxSoR81PzbsGxyHTX78fBy8tcgWs8zZJiD4CvCXP5dFvdcGKJMGZ
 9nWcYYXgffDYt9LAMrD50SVxqKz+Tq+/zi/zh8qWketWAUXXQgu3bnYAJYlPJLu2X300
 Kr314kIaNTNdXqT3RNjl1MVnTV9zIjIiLVVRKDNsTaqZFKGBY1UZQKA/eXWlyQDWj+ry
 blzA==
X-Gm-Message-State: AOJu0Yw86pcMTvTc4V7ax/R3QFdLRhpHU4jZCXupSxtEZ/8wWaNLH8GH
 tnowoYsydBHBx7jKptCQl8UoqNRvuTIRC+aQPynlSr3laA9+CQzEh97aKakWsoenK88OjvCHN/5
 mk4jh8oCTod23xAmnY+Bx1Rzqu3ZwR6/rOwnhKyOm7afXUttqd6wEgz3ss1SghzZBv6s3Usmec6
 QmtFvteedadkqCbColhtG0QP1r6phWlYoAKi7WXA==
X-Gm-Gg: AR+sD13+hzUGArAMuWK/Vc2N3Nv/9CddGfAaxvVLp2qt/DPdcUhYI6Akgqx6sNXy7Zf
 PNIgLBY1xXVDAqR81HsvuiG6k5GXn5aa+o5k5VxSsrjLuSoRp+Ev/dNkGBLdSMD8ltDR+ILHH5H
 xG5W+7ysmUFIbg4wsBD50LntzCiwBinJI7PUN7LN88TcV8I5H7Xg0xPu3Jot3G03olcjsJ9ahQ/
 oAQ54LtlvkldDC0wwi2tS375SMeSKHOe4AEi1Eg6lZ+x2LXh3BtaC9L9GAUuTNTBOEvrJIjhOoQ
 Q6LanfVK8gcv4LReD7xKeXnNYpI6WIUNaapssh5tSJbZc5uPe7KokJyX5vsGgyH93Q==
X-Received: by 2002:a05:622a:e0db:20b0:52d:9c42:f326 with SMTP id
 d75a77b69052e-52d9c42f545mr111901451cf.42.1786998278205; 
 Mon, 17 Aug 2026 13:24:38 -0700 (PDT)
X-Received: by 2002:a05:622a:e0db:20b0:52d:9c42:f326 with SMTP id
 d75a77b69052e-52d9c42f545mr111901081cf.42.1786998277603; 
 Mon, 17 Aug 2026 13:24:37 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 00/10] migration/rdma: Fixes or drops
Date: Mon, 17 Aug 2026 16:24:14 -0400
Message-ID: <20260817202424.2901438-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This series includes some RDMA changes, either to drop some dead code, or
to harden some checks for the incoming data stream, or both.

Please have a look, this should close all RDMA recent AI reports (none of
them are real security issues), thanks.

Peter Xu (10):
  migration/rdma: Introduce RDMA_CONTROL_NUM
  migration/rdma: Remove unregister code
  migration/rdma: Stick with rdma_ prefix for all tracepoints
  migration/rdma: Drop RDMALocalBlock.is_ram_block
  migration/rdma: Drop RDMALocalBlock.unregister_bitmap
  migration/rdma: Drop RDMARegister.key.chunk
  migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST on buflen
  migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST chunks
  migration/rdma: Sanity check upper bound of register MR address
  migration/rdma: Sanity check compress request ranges

 migration/rdma.c       | 344 +++++++++++++----------------------------
 migration/trace-events |  83 +++++-----
 2 files changed, 144 insertions(+), 283 deletions(-)

-- 
2.54.0


