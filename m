Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03343D2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCm-0005JF-Ui; Tue, 27 Jan 2026 13:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBo-0003Dr-7b
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBm-0000nv-B1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DzRQVM+Yn5+P9vBYO5JpvhQMbQW7zOc6oNfGNETZrg=;
 b=WlhnwRmYLpUX5NZwCCCDKqy4NlLRv89sFG2kImZ6C9mxiq2mUCAALPKW2WPfQRGL7iO2X3
 E7dpw6p1Chmy17r3zY80IDSt4cw8IzCTG59r5DtXkPgy5kbu63fmiOHsoPx7OMt0hPvWcd
 GEQ3Bh/q34raARXGZ4oqMfa1NINXQ0E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-SllwvqYNO_eKKRmxziQzYg-1; Tue, 27 Jan 2026 13:53:18 -0500
X-MC-Unique: SllwvqYNO_eKKRmxziQzYg-1
X-Mimecast-MFC-AGG-ID: SllwvqYNO_eKKRmxziQzYg_1769539997
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-894971e3b60so160435506d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539997; x=1770144797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DzRQVM+Yn5+P9vBYO5JpvhQMbQW7zOc6oNfGNETZrg=;
 b=RYi1J1J3GK83NmwwQ4AIo/r3UGjF3fcBBFmMt1JaceGfr/49Oi/HaDcgi7naY8Y+rK
 c6LbKW5HIBS232BexLg5R9jSCMe9BSUe+lmQ7rpuzfvOAxmLbefCxOrA3JxHRWKPiIvd
 sm7/jX6RYWnlkSwY24dj+1/vwa18YY3v63kVS46+jfG/WtrR5gYq2tFtRd26E2NAvkjg
 WC2VQOKrwu4G5+YGJRV/mC/EHtXXoO/okdLJmOP+56W36jVV8f5zCBPr4o1Cpj7XNeK/
 t8/ApTsuJCcKE63mVF0zLhCLqk0lRAqLtsUFJSdHulWnh4WDL4QWAV7c0aT3nBqFWudf
 PKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539997; x=1770144797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2DzRQVM+Yn5+P9vBYO5JpvhQMbQW7zOc6oNfGNETZrg=;
 b=l+uwk5Lgz3XlITQyYhc/Nu5GMRYZ6nVCgqiVBW1w9ZYE8920PnQN63R3FavA7Kn/JV
 m/AIHtbAnvKW79JtaQRsQAReAWVHmOMtFKUvf2WUiBXOvZvUKgftWauqHI4UJQBVDiNt
 VA3GNg61h082qqhT1l3zN6/sNYqxtENjHjnzCaVk1gv5ot5sU4NJEZd5dhX6fII1HwNR
 soO8g5EqCagWpw+mlEqOvldcIPVwv3FifgcOoeQ0n/Q9DJ6ntkZCWbq+5keZJTY1SCKe
 /hwrZdTXP851QjCgTRjhmswXTxv80E+ICThwLCz3CwZMdTXOhlLETig1v/MuPSUYTIqY
 8XBQ==
X-Gm-Message-State: AOJu0Yzma0dmM4E9/WBQvc0JpCQaEaRUARSTUhhLeEeKmJw77nu0Wydi
 dDA/3LgQNo15Y+2SVfRkfOfZOhCXzIqCg7hqF1SwXN3iLCAYCmSYBfBUNkcPqwkRbC5sejS6ccM
 MEV4VtMtML4KEW7xK4cRBd0wT9B5LMGqFVz/B437aQd9tchqspwvhvwzQK4EizNT4TqqWFjJnS6
 hPwy4yLvcaK89GdQsZ+Q5v2ydgJDf5Y0WUrc85bQ==
X-Gm-Gg: AZuq6aItmEt2pzoCJ/yESLR3Ee9S/yItzUf4d66BIzl2p6eVXcAXXqeAbO9/agzV03u
 0hgAfVgGH7AJTV96ZD/HGQmW01yRcG7Woy4nXXdU9tiGGBTKXsiOwzltrWX8ceJwF7GLGFS6VRd
 4Uy6BxoCHPt0fngwd2DWGzsojI31CakOBf4epmNu31tw7Rs8a6igkGfN1s8+WMqtMB3A3FznxyL
 u/mKuX0PKNfl/v9Mmtwc0plukusB9u1tQ1v1jvsWV7C5U2voYojPqoj37IKt2Z4a6LB3X6b0D0T
 WKjZPwgLg5YZRzpiPBSRjaDCtN4o3jNQ/tksn2kzRDtnxb4i7am8uAN6sLBUujocgwuaySo49No
 4
X-Received: by 2002:ad4:5de9:0:b0:888:4938:49e6 with SMTP id
 6a1803df08f44-894cc9910c3mr38227676d6.70.1769539997064; 
 Tue, 27 Jan 2026 10:53:17 -0800 (PST)
X-Received: by 2002:ad4:5de9:0:b0:888:4938:49e6 with SMTP id
 6a1803df08f44-894cc9910c3mr38227326d6.70.1769539996566; 
 Tue, 27 Jan 2026 10:53:16 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 18/24] migration: Cleanup error propagates in
 qemu_savevm_state_setup()
Date: Tue, 27 Jan 2026 13:52:48 -0500
Message-ID: <20260127185254.3954634-19-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We did two unnecessary error propagations in qemu_savevm_state_setup(), on
either propagate it to MigrationState*, or set qemufile with error.

Error propagation is not needed because:

  - Two live migration callers ([bg_]migration_thread) will propagate error
    if this function returned with an error.

  - Save snapshot (qemu_savevm_state) doesn't need to persist error; it got
    returned directly from save_snapshot().

QEMUFile set error is not needed because the callers always check for
errors explicitly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 830d8e5988..0683a103c8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1385,8 +1385,6 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
-                migrate_error_propagate(ms, error_copy(*errp));
-                qemu_file_set_error(f, ret);
                 break;
             }
             continue;
@@ -1405,7 +1403,6 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         ret = se->ops->save_setup(f, se->opaque, errp);
         save_section_footer(f, se);
         if (ret < 0) {
-            qemu_file_set_error(f, ret);
             break;
         }
     }
-- 
2.50.1


