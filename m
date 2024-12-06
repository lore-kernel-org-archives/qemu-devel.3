Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABEE77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgI-0003bF-Cd; Thu, 05 Dec 2024 19:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgH-0003b5-JQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgG-0005lm-8l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/u1/cF9PD85EfXyRSPB3h8kEgVgxDKJ3kxfHiutEnP8=;
 b=MdlNGzvjZJ7HbHE6DJihTVBDLyMqWp86iyeHxTt4u6rrAiY/iXtDjkzI8TFNU7R5B+5/uX
 vkFdb7z9q3gRxGuJXwC3w73ax1+m959i3bGV91C90RK4mpcWJsq1UM+yh2RrX5/LRKMEf0
 83CcB2QgiJlM0L6sKZjchH1I+TZn540=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-XaftsRzGMCqkM14pD0zE5g-1; Thu, 05 Dec 2024 19:58:49 -0500
X-MC-Unique: XaftsRzGMCqkM14pD0zE5g-1
X-Mimecast-MFC-AGG-ID: XaftsRzGMCqkM14pD0zE5g
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8eb5ea994so573116d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446728; x=1734051528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/u1/cF9PD85EfXyRSPB3h8kEgVgxDKJ3kxfHiutEnP8=;
 b=PqQ02f9uYSalALG7Rrla1BOTo+2l+mbgcpRQhlM09m8YUIkVlP6mKFKNyxshJl4W3F
 Q8SLut3/MJQUHJoRzdX7Wn+h20Eo2IN8iKSwamI2cDj1hXqLbtRaP0PBZaysyAhSHEf3
 DStWNymYvNzpRahUQQyQpQxToT67IGutKlbQvOJEGO0MsVZSsL2be7OrI2I5WzHxlF4x
 jmHGaKIxXGptNncOf27zdRmmxVDHGtMurBlkpGaoyF09uTOjG0MbsuDFI1F9FNaTLkI7
 TWz/JmLCazkD8I8Tvxho8zR3Pk30StT3FqFGph7zJ25qCC7T6ndcg5D6uNgRZEoLPcyC
 q2mA==
X-Gm-Message-State: AOJu0YyoqZZvHFuuaZDSMtFAs3DIRcpFKTcYHaCBh6Dnw+hTCQXAzeqa
 qqfUrWw5+t4gXfAi7VoCIrllMwofTl6cRtATTl3udN6z2+SGx7acyRgm2GgxKSiQjkgHN8nJGRy
 GA/nGpo3Rt1uk20b9c6qQSfNGbFACIj7xLgeMadGCVQoSfiAyOzAf3TX0Rq4HXVOt4Ilm734h0O
 pvaB8PUw3WcVqDj8Ux+fMLXd3U5M64mDvjbA==
X-Gm-Gg: ASbGncuxrXpNddNrDzuuX6SaD+IDNi3u8gkWlrXSgTn4T1yQmnNwQAmAYhL2d2ZSoEe
 33V4Av1cmnG6kNKCu8tgRTp8zyaECoRx5DnE/weHIPlycXdu7aWTJM4scOuJBbe1Tr3NgbLtDfv
 L3zhqZICDbJqbopEEUzF3G1kCQs/ObjT4x8f2k80cr3u6YJKDWL8lw4HM/EzmQGJwvlabQUASZp
 IV0fe0aFMFbXw2WW8e7khhlzp5J4Gc4c9TUSRtJZN/uWlQ7ex7sZ1rF1UqtcxrjQVq906y3tgm3
 BiaNecbGj6W62pWfCyWYpMTp/Q==
X-Received: by 2002:a05:6214:2684:b0:6d8:9d81:2107 with SMTP id
 6a1803df08f44-6d8e7132dcfmr14903966d6.20.1733446728565; 
 Thu, 05 Dec 2024 16:58:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEldja1CzrluAZz2bZtPWJ4lXVZKhQwebwnK0Z8A1dFoCgwYTCE/VVZSxC0eIrsP49jtVxyNQ==
X-Received: by 2002:a05:6214:2684:b0:6d8:9d81:2107 with SMTP id
 6a1803df08f44-6d8e7132dcfmr14903706d6.20.1733446728142; 
 Thu, 05 Dec 2024 16:58:48 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 5/7] migration/multifd: Remove sync processing on postcopy
Date: Thu,  5 Dec 2024 19:58:32 -0500
Message-ID: <20241206005834.1050905-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206005834.1050905-1-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


