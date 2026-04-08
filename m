Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD21610F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsN-0007Ul-PW; Wed, 08 Apr 2026 14:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAXsG-0006NN-8h
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCW-00029o-VR
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOg6aB8+NOKrpHZmrJdjsj4iQJGYpx+Cn+FtttlNL1I=;
 b=aRbHaTK87O62HdD8jlN79/+OZRund2tQpW1qPTfGz+coq5jrccvlIf4irNsAOROOswZQVm
 iVrkpbVcQYlMxIdlmXB4FQ/z3/ItvXSAqYS9kXltcird0WlXxCPUNtVcdVU3F1YFrtojzY
 W/q96d1xKZ4bVGvy14Kr2oHNdtTrnoY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-m6ebftIJOPGXzPBz1k9L2w-1; Wed, 08 Apr 2026 12:56:24 -0400
X-MC-Unique: m6ebftIJOPGXzPBz1k9L2w-1
X-Mimecast-MFC-AGG-ID: m6ebftIJOPGXzPBz1k9L2w_1775667383
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso60841cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667383; x=1776272183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOg6aB8+NOKrpHZmrJdjsj4iQJGYpx+Cn+FtttlNL1I=;
 b=n9x/CSxAgGVrUxBaFx9J1jIu882Qnq/O46KKBjeG5+Lv9/ztwaajCjku4G20YQLHuY
 xQOQ+QIL5bBlo4luGnZUV3zE3meliFsp3+3XD13rilCDBAo2FlVEEdlOH20B9cypPbuO
 uTUuW+z+hnZPsbIcO3xCng5ssUM3QQ1JOIP7YooM9DDOIJ+yqnBokPzKQZ56AFYXBbAw
 v+L0szfK+1JgNoDMMBLuInnCWJ5m9H+PXl+V2okpxQoG6tZ/ZVKLZNm1cv+VR8oXGe5/
 FgQWHr1Sao0k+ZCyOdKb1yMzKmMUS0N3Tk5UzLQOyU/D5OrJhfnM0sMSZ2FVGhA2803Z
 qLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667383; x=1776272183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aOg6aB8+NOKrpHZmrJdjsj4iQJGYpx+Cn+FtttlNL1I=;
 b=hkj4hgUweMnVBs3ABzSL3VX0na5rs04kX5um70Ri1AuvbWQcPBWGT5v1aPda3t4xuN
 wRVlAgIpmoBGbRyPMrxc/Cg+SYffkYn3OyIOyHcUWrGL6dGjXWEJ/n2OZKEe57lCFfOc
 MkzCuPMrfWqYPL7qtpHxjOz4eSPa5ctxFx/vVpvpRePHC9P3lVFumsFR95+Nt9EMiie2
 hmBZE7DXflYXk/s3jaE+rIXO2LGGBALhLld3V+W4YeSUcRvw+ZQMHQ7LLGtxFAB1q/V5
 7KM4/IWY5M3/kr67teB6sfRdL5B0jTQArX+hrtO4pwuOL1OTbp8PRAtc2HbK5Ly34vAr
 fAjw==
X-Gm-Message-State: AOJu0YzfmuTdX7Ik/Cp3hD6Ta2PrV8oe6TQCkI/SiD9YE7lFcTQuSMH7
 VByZyVYEpKNlfzbxju0bUqrFjnjXx59RyOWK711mHY4ugiB9CZlC9L+fC+E1XrO7BzTLjx03AC3
 zl9/7C7pvQwyhzNXwRCr+nuSY5i5YU4Rxnzo1D4wsuxRX493CGpMpIjX8JOuHYkEMHBph7yVT18
 xroGFs8HvivLExlk0N1VilnuTbBqduAJ0MoV9Iig==
X-Gm-Gg: AeBDievByWr6q7Em9ROupOoma4ADNcMNh3uxBqLvWa2qQ794kBDg3bLIHarTivnJKmW
 8gTwFJKAg6vL742vAETIjOcvCavVEVDKxbcxjc2K9yqcqG4mTdcdpuVLWN6tCu34yThXcVloxEv
 tD0Y05zGnVPcPabNqVDOTKPmJSlqtY+uQ2D/4cT6IEeU7IVlnm2Z7fxvPt6FebjtjPW5zn8R8GI
 ndBYVHBoHFAol+mxXNM+13NsUh3X4ppSBE2bjheiMCPJ1vBL+wmJjEqeKYtiZRL98yGnc7srDMq
 VtqF8Ydf6W9rDg8NwGTMDU/0HILfVUZv1ZvjgSUq2OHN2a9pBJrsZce0VEFVaBV1CLbYMDCkpkF
 hBTaxiPh3n0dvFOvpdM7idsxqtDDU2dPLEYkRNr4D4t1S
X-Received: by 2002:a05:622a:250b:b0:50d:7d8a:5d45 with SMTP id
 d75a77b69052e-50dc2218241mr1272841cf.36.1775667382945; 
 Wed, 08 Apr 2026 09:56:22 -0700 (PDT)
X-Received: by 2002:a05:622a:250b:b0:50d:7d8a:5d45 with SMTP id
 d75a77b69052e-50dc2218241mr1272401cf.36.1775667382336; 
 Wed, 08 Apr 2026 09:56:22 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 14/14] migration/qapi: Update unit for
 avail-switchover-bandwidth
Date: Wed,  8 Apr 2026 12:55:58 -0400
Message-ID: <20260408165559.157108-15-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


