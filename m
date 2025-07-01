Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ED6C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQI-0005Dv-Cl; Tue, 01 Jul 2025 07:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ9-0005AY-7p
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZPy-0003F7-Q3
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vicT1n12Q3bt43l0BKSXkJu6cLKKIkPFHwd4M2fi9jo=;
 b=R9qCZ0APZihsCo14WpIxZ7GApYV1EdjOlTDWmQBUroZ9pehQV0W+pynxhVzWL5vIqegqHl
 4BhX/lsb9MCjHmWg5+cvVM/jxDfsUw86sllb7zpdkIyJG76nU2suI+EQpb1qHD/Lmdo5Es
 bVNLgBUkl1YLdDZ31KAhPoVRsneijsM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-3AUkznmzNfKKaEhcs2JBDQ-1; Tue, 01 Jul 2025 07:44:51 -0400
X-MC-Unique: 3AUkznmzNfKKaEhcs2JBDQ-1
X-Mimecast-MFC-AGG-ID: 3AUkznmzNfKKaEhcs2JBDQ_1751370291
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45311704d22so22759865e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370290; x=1751975090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vicT1n12Q3bt43l0BKSXkJu6cLKKIkPFHwd4M2fi9jo=;
 b=SIQtCcbGWobvPXxXtSbP/RKP6Y6Ub+RIi3fj1kvRyuc3LzC7ygkIpxMtVV+NIjEaTc
 3IrP9p8Yo4dmmaMtJBxji47iGIoTXbvNbOrd4XEXls0l7lvHwL/GtseYkOrzP80v6F0d
 Lz6CrbnGGmnACp5PlUnCTKaQPysHDP9eF6hvnsGvLclX1/dVsZwNqckbwr7XJG9y5i61
 XuqAuKDz3WlglVaxfEGgsdd6ag+tfiXlEOCfVz/X17tUbcdjnJdVZyzEyhDHBUdKOQFd
 wBh2tBr6Cyb2FWlEm5O5HIf+u3v2vUL4+/H/lv3pSh2ffU2KQC/WN+KcY3+pdV2UY3HX
 SKjw==
X-Gm-Message-State: AOJu0YxvLxQn/Vp4PKxAG2BZyyo0lxe7pgtVpTIiqeqs8B8Rf9v+4mBM
 OEX39aNSSWQGm2YBZQGyVDJ2VRH45LKvsDiuzHqs2PhcE6I75VBj0fqIIVYPfMhu4yYkZ8008kI
 c+HTqjxeIpOXW1lO+8bM88fRaInUli3pAbonwdVc8uOmMyMwgPCvoQfYV
X-Gm-Gg: ASbGncsvjCzK0O1M13l/NErCCNAoY+3uwqScee5kkkKRZk2zRrzpURGLm5mobeo7TZJ
 uEdRyHaZcmmv/jjqQfLd0FdNge8QpEAqaxfpwnCgPAFzcY2GNWAMs/3IahmHCiXOiA6shXPFHLv
 LTd6Yaw6Jv3iRyAiA6oJBeJkDeYXFhQIxIhtoWlidrQg7FzQkVmjEyN4snLcU4/8KqOKnswsnf3
 AJlfmemrrJdlJqZPo4I7G/o12iq9QE1FE4Z+XjFfM2aWy3NL9a6rCAB5VKMjqhRmM/zaFjBE1f9
 qvckzsrnb7rqlYXdj1yjYb4AV8CVWwnQRNhqxsoYRl/bjmtOdDYWzx/Z7HLaBcEFoFgbjaGwGdb
 WQ3Un
X-Received: by 2002:a05:600c:138d:b0:442:f482:c429 with SMTP id
 5b1f17b1804b1-453a84069b7mr26196255e9.8.1751370290492; 
 Tue, 01 Jul 2025 04:44:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/KSSaExI7tSriJSKh3CJ+W2i4cwOnH2U7DfkF2usMOGbDo55o7tUhWNC/XHbKk+nII1a6UA==
X-Received: by 2002:a05:600c:138d:b0:442:f482:c429 with SMTP id
 5b1f17b1804b1-453a84069b7mr26195905e9.8.1751370289969; 
 Tue, 01 Jul 2025 04:44:49 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c49fsm192090365e9.7.2025.07.01.04.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:44:48 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 02/21] fuse: Ensure init clean-up even with error_fatal
Date: Tue,  1 Jul 2025 13:44:18 +0200
Message-ID: <20250701114437.207419-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When exports are created on the command line (with the storage daemon),
errp is going to point to error_fatal.  Without ERRP_GUARD, we would
exit immediately when *errp is set, i.e. skip the clean-up code under
the `fail` label.  Use ERRP_GUARD so we always run that code.

As far as I know, this has no actual impact right now[1], but it is
still better to make this right.

[1] Not cleaning up the mount point is the only thing I can imagine
    would be problematic, but that is the last thing we attempt, so if
    it fails, it will clean itself up.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index b967e88d2b..b224ce591d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -119,6 +119,7 @@ static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               Error **errp)
 {
+    ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
     int ret;
-- 
2.49.0


