Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E970F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbN-00015k-TK; Tue, 21 Apr 2026 16:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbK-00011X-Lq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbJ-0008Th-41
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hINx3Pl7mMgpNmHdkNkzZeehT6CitLSjSALu0u8E0o=;
 b=YQ/gljPaOVKyh4ZTwkDhWm+Zo+uv0fTpp4WAUBey6QybkUX6LQAiG14a725dRcB4PMNDxR
 RD2brSD7lYzT2gbNpcEmYLK8Bk4dWXNHo4cLwc2bRW2LIVtw8Vfaa7pwrurjNaJS1U/AgR
 sd0hLbR6L48B2T+Et88+ySyu3/XIXXY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-eGE0dn9OM_KWDoy7HoIH5A-1; Tue, 21 Apr 2026 16:21:39 -0400
X-MC-Unique: eGE0dn9OM_KWDoy7HoIH5A-1
X-Mimecast-MFC-AGG-ID: eGE0dn9OM_KWDoy7HoIH5A_1776802898
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a5f6110c1cso116742626d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802898; x=1777407698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hINx3Pl7mMgpNmHdkNkzZeehT6CitLSjSALu0u8E0o=;
 b=oeH/eo+AOSrF61qPlJ166uWV6huSsNw5pdYkNetwhJdK+IY54hjwoMEGro9nI0BZKo
 My2n03XsvqiSFua7HcTxw1k02DkxPtEGJJMJ7RomJwPYau32Bv3PGNsikTksSXHyzbY/
 9VjGBEmocD3g/Nn9V+uqj4KsaE2daH/TWaHCQqQ+4qH5vgkc6xdirp0z4zEneNidJzbQ
 Ix7cXgkqQq4+mzZlP6bMroMLZBb//Hg+QejI6RXrbEqkLpKNe67r3iD/ZcGwaRtY1Kjj
 COFVagJzgoq3O+aa9NywkHhzN2h3dh1eW6BK7jBfSLqUT37jWC7tqztpeU2BwDfqSRcI
 2OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802898; x=1777407698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hINx3Pl7mMgpNmHdkNkzZeehT6CitLSjSALu0u8E0o=;
 b=ftVO28XHYOWfHqS9EksW5XUedYzqcaTCVf+1k25TCeZ6i/Q1ovRZChhahT7tofIdW9
 JdCAYZHnd/K0jM0aH5Pj6RxFt3J8kJcpSke/RTJjbeo4nLeLaiTHTNkjnPZlDw6zivCf
 AhoqV+QjLu4RAmtYvmKOItX1+3zfd5p9LnfSG1F9TnRdItnI/1ORyCeuJsLAI6c6p26x
 7f48HPIy5aIBOx9B8YsY5Q0gKnct//1VwA2zIqhJKqmRqG+wA7ytPeSsx1YO15rLbuVV
 D0HXH2P/3kpINSUFOFOk8RcDZwuNjzqJJzJY6iWmLepaMsK1zGnmHisGQsuOO4YiO94y
 z9Fg==
X-Gm-Message-State: AOJu0YyDRLsD4yxgY5IDpgD2Bhv6VAWPU5uX76+2Z0FLjCyVN9b2htNQ
 vw5QV9W7C0mGVYOl5xqznbuK9Tw/Ihn60cYURA5sk8viKqMDHMaJ1Vy5o1cru1561QGOHedYvvW
 G8VcqrzoDE+jaPc/6MA/PlgY6PcSpTbOxUonzPEfEM6po0d1VkjkEA5x238II5uAbIjNRIK8k22
 PNLfm5yDUETnNdd1BikqWasqRoQN+oSW8zhVmJuA==
X-Gm-Gg: AeBDieuyDpQWXydlWXJvXnXo/9/VzjIGt6ve6/KB/OxSx48+C666kTxLjXtDhVGsvw/
 KWYlgJs1d+C1y1xAbmRAL1bBcjyL8xaPzdVUAwsfW77RETgXad18jQwMJobmSwm9vaZcIlvLCSp
 CJitrIzy3dO9CeazAXSTkpE0fy2a7D746CPgiIxkqnj9Tp4QRTuwjN2UU4jcEoiY/BTGIvQXQbm
 5m6RJx5wa6/64jux5/24w7MzuqfTpeOUNKL0lvk5ua9WjeuDZreIYKmWXW3Eh70LWWhRSh8W9yt
 dASsrGbza4691ljLD3VWo8+82gl8ce/HTuNATKO/HUk8PJMlNh/AxtdlZQjw5kw8KXjFvo/X2Ei
 cywsqarvUdyQBqxBjgx7F/KUTtG92ir7KI9ssul73UGq9V4op3Oi7sd6/Yg==
X-Received: by 2002:a05:6214:4588:b0:8ac:a154:e156 with SMTP id
 6a1803df08f44-8b0280cc08cmr327337456d6.29.1776802898141; 
 Tue, 21 Apr 2026 13:21:38 -0700 (PDT)
X-Received: by 2002:a05:6214:4588:b0:8ac:a154:e156 with SMTP id
 6a1803df08f44-8b0280cc08cmr327336806d6.29.1776802897575; 
 Tue, 21 Apr 2026 13:21:37 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 15/16] migration/qapi: Update unit for
 avail-switchover-bandwidth
Date: Tue, 21 Apr 2026 16:21:09 -0400
Message-ID: <20260421202110.306051-16-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add ", in bytes per second".  Unfortunately indentations need to be updated
completely, but no change on the rest.

Cc: Markus Armbruster <armbru@redhat.com>
Suggested-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index a6e24b5685..b7518b29c6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -921,15 +921,15 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  **Note:** this does
-#     not limit the bandwidth during switchover, but only for
-#     calculations when making decisions to switchover.  By default,
-#     this value is zero, which means QEMU will estimate the bandwidth
-#     automatically.  This can be set when the estimated value is not
-#     accurate, while the user is able to guarantee such bandwidth is
-#     available when switching over.  When specified correctly, this
-#     can make the switchover decision much more accurate.
-#     (Since 8.2)
+#     migration can use during switchover phase, in bytes per
+#     second.  **Note:** this does not limit the bandwidth during
+#     switchover, but only for calculations when making decisions to
+#     switchover.  By default, this value is zero, which means QEMU
+#     will estimate the bandwidth automatically.  This can be set
+#     when the estimated value is not accurate, while the user is
+#     able to guarantee such bandwidth is available when switching
+#     over.  When specified correctly, this can make the switchover
+#     decision much more accurate.  (Since 8.2)
 #
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
-- 
2.53.0


