Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A6CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIE-0005gA-Ag; Fri, 29 May 2026 00:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpID-0005g2-6F
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIB-000869-Mr
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mulJDhFXAKpDPbSq+OgUy/fpJcNoIOEb6I4PhYcrchc=;
 b=Nf4xPdn5uYHsP/LAzJ3tmUWjNwdaX8GpXxk7aim5HRCpMpAGHHjF2Lkk9J0OkJbN9F8DsP
 HN5SekaJ7Oh1ZK2B6H6MA1X9fNCQC4wy2/qRFdxUrUvoSMv5sryjfSz9RWj9nDp/XEpspN
 T+cf8kHomPfcKuHPawadVyNtNl9xrGs=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176--yyB7lP9MPyOrcAqw0UJiw-1; Fri, 29 May 2026 00:57:53 -0400
X-MC-Unique: -yyB7lP9MPyOrcAqw0UJiw-1
X-Mimecast-MFC-AGG-ID: -yyB7lP9MPyOrcAqw0UJiw_1780030672
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304efad654dso300189eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030672; x=1780635472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mulJDhFXAKpDPbSq+OgUy/fpJcNoIOEb6I4PhYcrchc=;
 b=Ypl44cnZIXra3nZdIWoJFnzC1Q4rscptbf9KFEHJ2G4ZzDJt91VPKMZ68vUCcW3bSU
 JM7pK+tBsVQ9hlGtE8ZnYniFfpeiodN/lwd3Lh/fo0R4/LEPXSuRJ/yZsUJr7uHSouPo
 OLCQcbk1x65CxTvCJJRu6SwATfKmQUqkrn/EZv0dEWGRIGf99wQywpsND1OkeUviQzoM
 hE1UM3nPLUmAoJif2U+/Wqd6HYDbDhzUcOaRTuH/kQ3jWC9lZKKyjj2iJg+HSLTTR4Gd
 QxVKlNMyqGCNTVb+r91gZS/SK9P4j0Qq6kQkFXDXg0O9jquEZCq3JLC0EWY6wZ3m4Bwg
 vHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030672; x=1780635472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mulJDhFXAKpDPbSq+OgUy/fpJcNoIOEb6I4PhYcrchc=;
 b=kaM9yw7FUIrEb2sylVODDTZkPOFTylyPw70l4z2WsLXkWR4yWJCpvBDyATcj7qWy+H
 HHgF7eDNzQTn9VYgHVk1tu4MEV1l9k4UTKWN3XpnaCucGS3ZgZUljWOIRI80mOqva77n
 a+LHnFjJlG4roC7aNd1Gx1TiPAHBmLCCAhpM8lejJMGtxnM2FecJ+8YniqFmm4itxDYa
 iiox7L8mzAnD5O0+JGvbvwnUjZ1RGKKXIdcewOkBM3lfSPpapm6FBsQepgb2ZZFohiL8
 z4b0nRrY0vIrR0uy64iB9LetTw4JIXY7RyzTxkBau2EHraA7OxXpjOznrPn4HqS7BeZf
 bhOg==
X-Gm-Message-State: AOJu0YwzfVi8tlBZ3cDOgtq/v8472TuG2B/kLupUG3GHpJIZFqVBP7Fy
 ZBaLITZDtgj/bN8otzocNZCqn0gc4VtFMibGRGBparNZpPR/2BA9bloTvJvApcFQyE+mRUk2V5N
 xwWWzOIwceUEncWHT7eGY+aKuJ+GMJ7JZMyaldZaCEkKPeffMN0zgOboJwUd9JsAR70XNnEftPQ
 UNZ+2jennp3lS6Xk73XNe/nCvLPsBjdY/OdkySfrsJuR0=
X-Gm-Gg: Acq92OEZgTMGnuaZrE84mAqK43+QvrzmE1Hn/Tu30WFSt8h4fk3HSVyCMaF3UYKfL9a
 RC5+/1KXVVNZnwri2ldJ92PeeY6s5JaAvIMABO4HRBGnTkh2sf3P8E3tcuvLJUA+jAlY9Tw2eHB
 KUwfURJw1ddzU1K1rUZhb0kVYUCZNTgP3fCqtVgvvRD6W5pZ4TcfAu44yWeyAu+yMmdVe6GAgkl
 pgZJH+P5/0GhsU2D7k51F0F+tNBoQ0X2prbTp+4vWfVbSGoD6bzoDtdvBO3ATseQKxRBVWfUIAt
 9QCxo3fAyfWiwO0MUaUwA6yaW94GPWBPwr4e4GBzcGA8Riv2C8T6bsash3wDu/R5Lg5cX7xMmir
 vL2lQRZBZVaX3TmHvkCXJq3LL+lb1qQmBdjNmaqpkrJXfoovq/YIt72p/I1C1LbCGR5ZeZ3B0
X-Received: by 2002:a05:7300:2d06:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-304eb116620mr651307eec.23.1780030671787; 
 Thu, 28 May 2026 21:57:51 -0700 (PDT)
X-Received: by 2002:a05:7300:2d06:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-304eb116620mr651296eec.23.1780030671095; 
 Thu, 28 May 2026 21:57:51 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:57:50 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/15] net/tap: net_init_tap(): drop extra vhostfdname variable
Date: Fri, 29 May 2026 12:57:18 +0800
Message-ID: <20260529045730.90322-4-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index a389aec218..55b8b33ea8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -822,14 +822,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    const char *vhostfdname;
     char ifname[128];
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
-    vhostfdname = tap->vhostfd;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -871,7 +869,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
                               NULL, NULL,
-                              vhostfdname, vnet_hdr, fd, errp)) {
+                              tap->vhostfd, vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -972,7 +970,7 @@ free_fail:
         }
 
         if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
-                              NULL, NULL, vhostfdname,
+                              NULL, NULL, tap->vhostfd,
                               vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
@@ -1012,7 +1010,7 @@ free_fail:
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
-                                  vhostfdname, vnet_hdr, fd, errp)) {
+                                  tap->vhostfd, vnet_hdr, fd, errp)) {
                 close(fd);
                 return -1;
             }
-- 
2.54.0


