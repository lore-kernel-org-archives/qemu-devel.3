Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07650CCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lR-0000xG-LE; Mon, 03 Nov 2025 16:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lP-0000wR-D6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lG-0005Fm-KG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wIT/Q1/yvwXzarYjEbY8I5UPyz6fRTqd+O6Q6gEZcQ=;
 b=iRfHOt4JP2gA7RGBkIIyPFP8xLoJTrGP38X9HbO5Uvw8X515VLN1hUwyvB6STB2plo5z7E
 9t5mjlku7CsKExinkVv0RWu407QyBTw+N/6BloysUPjDMN7CxB0M1DJsQ9vl/P0eS5ufSp
 chCI1UKhGMyImVgL8kIFGK3u5jpYRkw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-814QGo5dP0u0TxEQNuob6Q-1; Mon, 03 Nov 2025 16:06:42 -0500
X-MC-Unique: 814QGo5dP0u0TxEQNuob6Q-1
X-Mimecast-MFC-AGG-ID: 814QGo5dP0u0TxEQNuob6Q_1762204002
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ecf9548410so157398481cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204002; x=1762808802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wIT/Q1/yvwXzarYjEbY8I5UPyz6fRTqd+O6Q6gEZcQ=;
 b=N47Ai1Sa7Ukbs6SEonq5a3Df+yrIU/Tlwa0d0gijYOigBjBl/jEcEmb9fu93Es9TeP
 kFnBrlifCsREmy1MG/YQCYj/6O2QMwhVJZECwzrAH4ZiHTHaOQ7VnCbpaDFx2PfnYrYP
 zBOZDd3i2nlGZB9dDj/E8RwMHZkU/uk0ENjOwdmyCH9ectLxYazozW9p3Rrt3FCH7/VB
 M0vVTz/YEuxoVN2ui1EXG0yaiXEbD+YPvRly4DMnGiDjAUBNk6tJl97gPiqGJGMRvnHO
 FzuX28rKJreKX5X6SW6b6KD3V+UOyYKXcHum/pRVTl8f8Wx8kseJHmeQgO/o3P2DkPCf
 9B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204002; x=1762808802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wIT/Q1/yvwXzarYjEbY8I5UPyz6fRTqd+O6Q6gEZcQ=;
 b=lyyufLXnlUYwlPoUtZ+F4uVaRkGKcyj1DUxfWwobTEZLsctGIq1XNQyixqdsYIzIU9
 MOr7ieFSmSQKOUB5DnwjsbzrBCqmu4AmX1iEzj8rQ8ZBHWQMbsqOwMRTT1LYrin1VTo9
 vQaE8LhMRVxVrnH9o5K56cft3XK+Dnabg7z44qA5hfNRULxHSdm4+kXLHhy7Zw8F/nVZ
 D8wHHB5tek/uCYCcBSQq919hejCRLsgBsRzP8hCs7+ggEeAovQz3I5NzRaYAcIIzeYut
 /EZ7n5eNPkrGu6xoTa8aOt7j1Jm0S9wHK1Iojrv8NvZNARrRQx9e7rJPok40Z+Uks905
 ZKAQ==
X-Gm-Message-State: AOJu0YyKcqAjkA5ndwfaYmVDhBfzlBFBc3pugLe3fpwXOp9DUUhtBjhl
 z/x47yYjcjOgksssbEl+y8gbOoK3b3wZe2gCtGaVEv5TMWBZhCvdNIrK5Pjbztd3Tlq2l6LuDnQ
 4llfADWGfa6/mta+xpOlIKpKNh0KcX6ZamhHySH2Y/RYUcVFm5lTxNAa79CsccLoDvso4UTW898
 UH7EpYJ+WQFZ1ALPuqn2ab4wVYQFm69oyHFW91gg==
X-Gm-Gg: ASbGncvl60Yt2j/dev60XkzMM1B0BJ9BwEN01sRS3QXFewVQt6XDj4SK0WCPb5kRmGV
 8wWmgE/TKxlyxON88dMlpIuYz3ixLzSBofbO0wxJ6zBbQ5qXYUZx/rToj06tOaigPRHTWH15whv
 CHpHDzMN+XMMZ48P78vrVngGIY2vpyjrwYAwn332wJ6Hl/BZXsnEtZO2QRt6n4w3owi8evaEX55
 GwD8rKcXrdQlb/SJ6LJMCAb8v5clnwaBb/9vowDBzY83fnLdqP7gbfycjpS3APyaKqhbNuJt+jI
 m3UAyxNG72Odi+1avpYboxGacfLzaQ5Ov9Anozcxoc+WIMhd/EzeTvF/Xqbk5OgX
X-Received: by 2002:a05:622a:114:b0:4ec:edf0:561e with SMTP id
 d75a77b69052e-4ed3100c097mr163275721cf.63.1762204001683; 
 Mon, 03 Nov 2025 13:06:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfYIAcG7UH4VPOmB/TFVo+IrpUQJIlxfNo+gZojt0C1DqiNnnUqZsGFEGwZsDkJ/JZjmTa2w==
X-Received: by 2002:a05:622a:114:b0:4ec:edf0:561e with SMTP id
 d75a77b69052e-4ed3100c097mr163275021cf.63.1762204001070; 
 Mon, 03 Nov 2025 13:06:41 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:40 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/36] migration/cpr: Fix UAF in cpr_exec_cb() when execvp()
 fails
Date: Mon,  3 Nov 2025 16:05:58 -0500
Message-ID: <20251103210625.3689448-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Per reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com

Fix the issue by moving the error_setg_errno() earlier.  When at it, clear
argv variable after freed.

Resolves: Coverity CID 1641397
Fixes: a3eae205c6 ("migration: cpr-exec mode")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251021220407.2662288-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 087ca94c87..d284f6e734 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -152,10 +152,10 @@ static void cpr_exec_cb(void *opaque)
      * exec should only fail if argv[0] is bogus, or has a permissions problem,
      * or the system is very short on resources.
      */
-    g_strfreev(argv);
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    g_clear_pointer(&argv, g_strfreev);
     cpr_exec_unpreserve_fds();
 
-    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     migrate_set_error(s, err);
-- 
2.50.1


