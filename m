Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BEDC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoAV-0006mp-4n; Wed, 04 Jun 2025 09:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAS-0006lw-7j
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAQ-0004iE-O6
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vicT1n12Q3bt43l0BKSXkJu6cLKKIkPFHwd4M2fi9jo=;
 b=BhAKF4v6DuVQiGd9XPG5kxafKd+r0nd66DBwuy23xntv4ENPTdWdNBj9xgB7kcYbAXodlZ
 TlRxokwgwa0JY4ql72eUJONJK2tElDOgmBtD6BAoGfhjQKNT7O4tHHXSNnm8lHpkDWZ1gS
 ianvCgJ3Npob1i1pR5FInQ1nYJYfPIk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-hM2bYuJoMUypaDvMbwXDFQ-1; Wed, 04 Jun 2025 09:28:28 -0400
X-MC-Unique: hM2bYuJoMUypaDvMbwXDFQ-1
X-Mimecast-MFC-AGG-ID: hM2bYuJoMUypaDvMbwXDFQ_1749043707
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so2513028f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043707; x=1749648507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vicT1n12Q3bt43l0BKSXkJu6cLKKIkPFHwd4M2fi9jo=;
 b=WYPAigDMdsqLHvy5L5Q8PFxQ4STwMjkQlipsFkqdya++bT/qJqkE32y2a23HPjuLKi
 ygywrUQnDdhQ0vPmlMsjL8bx0+b2CZxKTSXCUA6O6uDmGUGiBVrfqx88dDesmaU/EtZU
 1F/MWZzUxuWvmsmuJgdJ96VeuS4Zn/ITC1BGAOVUhr0ryiXNNFMwAfm5wMKTksEBtfVX
 Jyf2SuVUi4YtFiOOunxsjUUnK4GxZmhQK2gYRCngUGLGMViYeOmK+nUUNHtXQvxgDs4D
 henPR5azAAa/61QR5lIO2mcywB7j8lXg9q4PS9w9xgS/MjaftReFD/pA4WbE+/125kYe
 vkGQ==
X-Gm-Message-State: AOJu0YwxeZfmn7VmcOuKPFxTjCerJ++bYHNfgRmvBsZ1j5CCQlZT7UxT
 WpGoyYj6J0yJSnXo1e57IJ0lCBwD2TEAPr21nO/9D+cXN6GAdKao+aWW2MRSQ8T5inWs3WbfyJQ
 f3bjePHL6yaNbpGymWJhUq5J0fWnsA6MLbmChs9hWgal5XsSPwtoqObJ1
X-Gm-Gg: ASbGncuzZ44fwLEPy23B8ftZE9T1HcSRGknLg2aLeGZ0wCnpZFQBoZ2HfiDr7f0fwPQ
 tGS8hkQbowv3DxIBMtBetipQWZ7ixmEDq9jkonJvoh0oazy8cyAr6yZfPwWqwL+APGKx1y3IfmQ
 v/r8Ji8qm3uJcBREdjjaQHQVTQycsYJOJ34jAFZfVZ9moz22LCPJxvZzD6M8+9HKi1xzpYGQQUE
 yCbyyyccYJFxinNlVLeRFNp2toZIo8ZoutFbuIdcEO7oZhozloZfjEaaoPU0NFj7IEuRgufpq0E
 6jKnZgL7w/AMhgDzrarqe6qD8SthJp5GZAmYlzr+wsLq+kf/IqjTb8c/f5VkjsbKFQF+sA==
X-Received: by 2002:a05:6000:25ca:b0:3a5:1c71:432a with SMTP id
 ffacd0b85a97d-3a51d91c1f0mr2306095f8f.14.1749043707375; 
 Wed, 04 Jun 2025 06:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF0xxaJmacjXrte3GpDxJUUoTGlf0c5vm2WZie1r/tIy3jbFegc5ygm/LUgMoK+/ifitoM0g==
X-Received: by 2002:a05:6000:25ca:b0:3a5:1c71:432a with SMTP id
 ffacd0b85a97d-3a51d91c1f0mr2306066f8f.14.1749043706983; 
 Wed, 04 Jun 2025 06:28:26 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc1adesm207268165e9.33.2025.06.04.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:25 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 02/21] fuse: Ensure init clean-up even with error_fatal
Date: Wed,  4 Jun 2025 15:27:54 +0200
Message-ID: <20250604132813.359438-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


