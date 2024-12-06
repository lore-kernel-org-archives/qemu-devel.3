Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6453DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7R-0004NC-0O; Fri, 06 Dec 2024 17:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7P-0004Mk-4L
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7N-0002QP-O4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KaWXvIbyGkvjWCcWSsdzmNjfpjFNGapBznL6Ic3T0Zo=;
 b=bcVwtOXuMcMl/2Nd4oQowzgrmMxmcZPsIziopECrqmtBEDOLsL8TU1fzeTLb2t361Hcooi
 XF9GgPv3R9VV2EbhTLmjXahTczn+rud29ytCYxIToQNYFSWD39XQQoGyxiBuKGnYXKIRMk
 3yhnL9Kl0PdglLlSWMwV8z5FeHlnB1w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-nD_BDoCeN7aONcDf7mvkkQ-1; Fri, 06 Dec 2024 17:48:12 -0500
X-MC-Unique: nD_BDoCeN7aONcDf7mvkkQ-1
X-Mimecast-MFC-AGG-ID: nD_BDoCeN7aONcDf7mvkkQ
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8418612c3b5so232160739f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525291; x=1734130091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaWXvIbyGkvjWCcWSsdzmNjfpjFNGapBznL6Ic3T0Zo=;
 b=XcvBp+vDpocvJSfu8bhroclDiwX3fD0OaJu7TXHv9AapgnineW4qwBLCoUjGEHoE6g
 /0hhiLTVJBhwJTYbuu+OwYOnPbW7gq1jNdXOKPy/368k6eYJB7yC59ef7SqjjipfYUdw
 55K+aZyHytuOrHAUKvx7mfYPlpjhTGswVW6bGqkKpW30FO4eFIcvDiP+RVj5NbrvRThN
 e97HFsENeAtjYt1xTQRz8YjTCFonS0fq6jLi3XdrBPvJ+YLe6hsP0rWSy4shYiRvlGc5
 cpIfgdgfMfCyoLFhYm6O7x0nevovKZKKdpREw8BUjAOyPZFQ/zjfEboRt5jeCR5gQfDE
 buCA==
X-Gm-Message-State: AOJu0YyKLWpLI8lM+fdiqoQlCzqMuqLoU4Y4QG4/dSKd66L8FkRUkRHD
 aYC0mNlN6sJjGqScDU5EhM7VpVAv313aVf7L+/AIFIsDxJasygd2hkmIj6LcuAhDgbrj2/rmaf1
 1WxdtB/T0LnXmB8VRxAaRSb0V9eFDDHmas4mtX8bBZM/2m6uka7Gs4dNOojZ7386AFu0Y7G8Oor
 FkFZfWuAmp6u0wlI3HK3EJdmIgiD6C/fhhfQ==
X-Gm-Gg: ASbGncvavI6omANecod1F0K4OjOGNQscXDhvs+Us/fvC3JgReYGqLWgM/9T2qPQIXeR
 LwRLZrhHGRJU+bWa9VRDQdFytlOVLBnjrtgNgN12wigoTh0yJoP7tUCBL7NvjeTHwY/VrFujl6f
 4Zl+oWyLJqs4jtpqFkvKS4h4TDbqOo/Jgxt833RWov8w8WtYk4VsSDi1KejQ+NhoNr6Lcvr6J15
 hlBPkC3PofEuo0kI3Mq5t33BDfc3GezLKbMGPKycUGgJP9mrCXOScdMlA4CbBCTPkjtZwf3Zhrf
 x5vusLaXCsxnlTQpSEQbMcpupA==
X-Received: by 2002:a05:6602:1610:b0:843:e89d:b62b with SMTP id
 ca18e2360f4ac-8447e32bdf7mr478795339f.11.1733525290890; 
 Fri, 06 Dec 2024 14:48:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELHrJW4urV9sPJvpj5tARdb9tBTOqrUrQ7szZmZuw1fhu+VECo1p00l9St/ZQKmg2OQikCvA==
X-Received: by 2002:a05:6602:1610:b0:843:e89d:b62b with SMTP id
 ca18e2360f4ac-8447e32bdf7mr478793139f.11.1733525290514; 
 Fri, 06 Dec 2024 14:48:10 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:48:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 5/7] migration/multifd: Remove sync processing on postcopy
Date: Fri,  6 Dec 2024 17:47:53 -0500
Message-ID: <20241206224755.1108686-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Multifd never worked with postcopy, at least yet so far.

Remove the sync processing there, because it's confusing, and they should
never appear.  Now if RAM_SAVE_FLAG_MULTIFD_FLUSH is observed, we fail hard
instead of trying to invoke multifd code.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 90811aabd4..154ff5abd4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3772,15 +3772,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
                                          TARGET_PAGE_SIZE);
             }
             break;
-        case RAM_SAVE_FLAG_MULTIFD_FLUSH:
-            multifd_recv_sync_main();
-            break;
         case RAM_SAVE_FLAG_EOS:
-            /* normal exit */
-            if (migrate_multifd() &&
-                migrate_multifd_flush_after_each_section()) {
-                multifd_recv_sync_main();
-            }
             break;
         default:
             error_report("Unknown combination of migration flags: 0x%x"
-- 
2.47.0


