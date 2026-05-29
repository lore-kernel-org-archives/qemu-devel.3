Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E22CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIr-0006Lq-P1; Fri, 29 May 2026 00:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIp-0006Ik-Ls
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIn-0008F4-Hf
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7RFZipe/z2ZS40s0zyaVC+5GC6QzmqglvkKCyJm4m0=;
 b=RaIVG5SfoSHWzVMztuQAOfL4/UenXH+jUlevKm3hb11NWRv4t08/eVeHLr09G82q5KINa8
 Bxtzl5qQ8XtbFR/EfHAVaZ2T7+QBABNkWslIEz7wePE4TT/B6LaB1cLQgntFLvzNf5+T19
 QXAwgX4APf1yHeY8IMmjIMCIeXPy7FU=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-BQ89JhDZOe-Fk6_z3SONtA-1; Fri, 29 May 2026 00:58:31 -0400
X-MC-Unique: BQ89JhDZOe-Fk6_z3SONtA-1
X-Mimecast-MFC-AGG-ID: BQ89JhDZOe-Fk6_z3SONtA_1780030710
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d8613efbso1751167eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030710; x=1780635510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7RFZipe/z2ZS40s0zyaVC+5GC6QzmqglvkKCyJm4m0=;
 b=CXZ32NSG68n5a68LhH7Q0qmexh+gAetpN0gRhOv6VEf68D2j9pqncYY7XP79j9A7IV
 s+DFUOdVMpdsXZTdInPcHN0cmix73oGqcCt9amGWggHq4swmhLZmbKwfxlSScx6kWEpG
 4pU3XyOeNGsoiRU0n5RNasnLX3+4nNg5egLc7W9KF8KjOLiKFDs/FgVYvJnR4QMirOT4
 oc87tuQD2kV/DOQe6BTeH+3mZg6FOXE5k88SCtzyh1fcJAfexm9nJRSn972+wGBQALNJ
 YdUnTs5aj3gZ+ef18X8qKn41tkIM2lCZX2qnAu5iz1AvohTqZFvTh34PNJ2FJalf/CxI
 qDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030710; x=1780635510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7RFZipe/z2ZS40s0zyaVC+5GC6QzmqglvkKCyJm4m0=;
 b=VdBxWHiAJfIgHvyyEsmeC/tJC2mbhvkwl/qFoIDbmGzWJmnOrpFR9jGqDJ8C/lGHGG
 WPn8YQQy9R2PkIgg1OwzJOl9cPaoEaqJixPDHY2wX5GLuOGnps+YnaI/uDV9wwvAqGFF
 3QdUC5rGIw2l028rjnaaKsm4s8glQz7hY8qNv6AKsulTYKffcUG1C09R0ctxHJ0lBHZq
 lNqyZ8YtgdPaxf+dXtvNG9boHEd97RaN36mogffhalXbWMORJrvM2vPs+IAh8iusds+U
 AnV/GxX4yCvdX1hEbZXITWDzfiwefKw/7I8cp3PZE9JeOyM2nRuGx9g+ch4iRrYIWnis
 9xsg==
X-Gm-Message-State: AOJu0YyXlnuRIQUXbXHnpUxnP5dgTAJAE2tuX4AlEm7GGQHkDnwKIlEd
 ogirLvYvJ4KZm8c0qKqO0+pXuLp7SXbZhMz/f7FHZHxTUjU/X5XLF4eWKJQMckEcy4INisVt4qE
 q/EjmSxfigwjDwqKcmCLHikJuEQOAERA3zPa8W6yn1kcVNzoOlZjgYnOIq7vL1Sk7T9dxFmbesU
 0TG7A0yHrP0i3QRbBBEEVS0DChC20z0TneBETDWKbku7A=
X-Gm-Gg: Acq92OHArMf2P4svLnqy0WSFDuhKxsuz+xqQEMDbmT1uFtOCsgt0LQUI3657yQ8uEzA
 OOG3N9DFP75pxHdCcuoXfg6amCnjOPp9mLqHJuiM8StXUIPH24sD+fWT+Utw9vzRXN68r1O5q9R
 xcPBv07KOi8YCMgqn9vGHVXCiyO88n/biiujpqCGwfTGmn0iqLE9ce4OVrSrTD88/YQg05qTO2d
 XvxZEfCq8onbPQLg0uXdsBd41D9D2A/vsQk7yarFR4gRDhnbI90lnyG23ISS67wweGnIiK3ntes
 dZGWfyyAIuQgnUmlVt4unnTZ9mzMoinuUQB0AEpeHqrYn9oUNhKz0UvISp/e55og+bt5iE0QTkB
 jUIXZ5mSvJkS7TY6p6HeBFAt/3E/ewVCsyVJdv8Ip2tpfqNEvqoR+qZ7lEsUN6yT0OUAkuH4h
X-Received: by 2002:a05:7300:a584:b0:304:de94:1c2c with SMTP id
 5a478bee46e88-304eb2875bbmr695958eec.34.1780030709756; 
 Thu, 28 May 2026 21:58:29 -0700 (PDT)
X-Received: by 2002:a05:7300:a584:b0:304:de94:1c2c with SMTP id
 5a478bee46e88-304eb2875bbmr695946eec.34.1780030709131; 
 Thu, 28 May 2026 21:58:29 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:28 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 13/15] net/tap: check that user tries to define zero queues
Date: Fri, 29 May 2026 12:57:28 +0800
Message-ID: <20260529045730.90322-14-jasowang@redhat.com>
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

Add check for queues parameter to be non-zero, and for fd/fds
parameters to be non-empty.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c  | 4 ++++
 net/util.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index e464f62b47..57ffb09885 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -807,6 +807,10 @@ static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
             error_setg(errp, "queues exceeds maximum %d", INT_MAX);
             return -1;
         }
+        if (tap->queues == 0) {
+            error_setg(errp, "queues must be greater than zero");
+            return -1;
+        }
         queues = tap->queues;
         *fds = NULL;
     } else if (tap->fd || tap->fds) {
diff --git a/net/util.c b/net/util.c
index 1998a6554e..8265f15548 100644
--- a/net/util.c
+++ b/net/util.c
@@ -94,6 +94,11 @@ int net_parse_fds(const char *fds_param, int **fds, int expected_nfds,
         return -1;
     }
 
+    if (nfds == 0) {
+        error_setg(errp, "no fds passed");
+        return -1;
+    }
+
     *fds = g_new(int, nfds);
 
     for (i = 0; i < nfds; i++) {
-- 
2.54.0


