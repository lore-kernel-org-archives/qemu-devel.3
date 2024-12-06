Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE8E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgN-0003cR-RS; Thu, 05 Dec 2024 19:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgM-0003cG-0c
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgK-0005md-JJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlpFg1t4p+x/wsjA8Y1ehZs0v0oTzhln8SN7DYaHVqQ=;
 b=bX0J4/XWx8zaeASCxCzz0aAkb7K4G0WRkzzRVVZQ8Hi52RJ2dbw28uQFFOZkVtdZ1oehZe
 biTEGe3+hiDkpfvsdbzifGxtBdiGXQySXtE6aLS1yUavOcHiPB6vQKlPUzN2ZPit1SnfAN
 rBmVhmxPTq3viMVBk+0hnuKjpN2MH7g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-frkpDalANPSdz5MD5Y2AkA-1; Thu, 05 Dec 2024 19:58:53 -0500
X-MC-Unique: frkpDalANPSdz5MD5Y2AkA-1
X-Mimecast-MFC-AGG-ID: frkpDalANPSdz5MD5Y2AkA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8860ab00dso27078726d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446732; x=1734051532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlpFg1t4p+x/wsjA8Y1ehZs0v0oTzhln8SN7DYaHVqQ=;
 b=gSKkHhJi7cDbbhnRmWHMflARIADtBPBGo+0iXsmTFtXI43AvXmMRbGJCeW2c5p+Ukg
 7S4R5XnHXEBUqjMgL8GT50JDPc7pXi0HkNz4syHSGgabPVLClk6XN3teXDgUVJYa/uwj
 48vHlGUurXJXDuFmXlkiPv2HO0mboqVcrhHvbgDFx0C7NhWFYNTl1Q+LObwGfCZb8X1N
 Xc6mRN979Jt+pnfMJB/baqhnBglP2QEsYuNhsXiRb6z8K5xwH5Hi6YnhjhgmXt/Gjrc0
 R+aDpIVbDW72bQ10zRoqnjynuqOwkhAp/9LVCh/6ntXwhKofrl9NTrpHNl4Dn/UeMO/t
 ySFA==
X-Gm-Message-State: AOJu0YxgQBNgO0GXA2l5K0W6pifDhoPukAEurlYeeehFG3dy6YBINZAq
 X0W8A0eAx0FabrXk1QIWZ9+oVubaahwpSs6trvkjaHZ7YY7e0TuWfuDr5z3IDQxvcPJjTRhigfh
 qJnKYqmVxR9Rs2wWm0gqgTbW5UC3f/LO46JUNZu4anwaV82KDqFJxPqK1myzQvmiIzmZ9nJOTqT
 C8TeTqquSgaWXXcBlIpwubcZlBlMnCXMowqA==
X-Gm-Gg: ASbGncsghqfdP4Y6mmj5+vt0O436ZW400vd3fvRfziBlZNNE2bdtnFea7mXaSlUzitw
 U936/bJQ14HFw7WshP3EDxJV5yDMOK4eQd49K3x/i9qMqQgO8r5172UGqDoeitg3MDW+OQ4Q7pP
 AU6NyuFTYTVAVMTR4+Hu9w5yM7S6ZXz1g+Vq2fvM6cpIN/PVC3illcPpQEZEGDXg5+uODJkQZ1Q
 usBdp1TAp1g6IUxU1mSOI9mAlg3UipDfs9brEWj56h1tvLQGBKlfpfsPI7JnA+WXCE4TkeyoN2h
 Rc6C8Dsq/J0TpoxhmtJDxXRyYg==
X-Received: by 2002:ad4:5745:0:b0:6d8:8a8f:75b0 with SMTP id
 6a1803df08f44-6d8e7128d28mr20532646d6.14.1733446732512; 
 Thu, 05 Dec 2024 16:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzrpn8ChXzP6fq6lz8dwmTdEkw/KsgeF2Fo83weEfj60YxFPRjaAk05xlnPU2UU1EVdJnDgg==
X-Received: by 2002:ad4:5745:0:b0:6d8:8a8f:75b0 with SMTP id
 6a1803df08f44-6d8e7128d28mr20532266d6.14.1733446732154; 
 Thu, 05 Dec 2024 16:58:52 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:51 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 7/7] migration/multifd: Document the reason to sync for
 save_setup()
Date: Thu,  5 Dec 2024 19:58:34 -0500
Message-ID: <20241206005834.1050905-8-peterx@redhat.com>
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

It's not straightforward to see why src QEMU needs to sync multifd during
setup() phase.  After all, there's no page queued at that point.

For old QEMUs, there's a solid reason: EOS requires it to work.  While it's
clueless on the new QEMUs which do not take EOS message as sync requests.

One will figure that out only when this is conditionally removed.  In fact,
the author did try it out.  Logically we could still avoid doing this on
new machine types, however that needs a separate compat field and that can
be an overkill in some trivial overhead in setup() phase.

Let's instead document it completely, to avoid someone else tries this
again and do the debug one more time, or anyone confused on why this ever
existed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 5d4bdefe69..ddee703585 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3036,6 +3036,33 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
         migration_ops->ram_save_target_page = ram_save_target_page_legacy;
     }
 
+    /*
+     * This operation is unfortunate..
+     *
+     * For legacy QEMUs using per-section sync
+     * =======================================
+     *
+     * This must exist because the EOS below requires the SYNC messages
+     * per-channel to work.
+     *
+     * For modern QEMUs using per-round sync
+     * =====================================
+     *
+     * Logically this sync is not needed (because we know there's nothing
+     * in the multifd queue yet!).  However as a side effect, this makes
+     * sure the dest side won't receive any data before it properly reaches
+     * ram_load_precopy().
+     *
+     * Without this sync, src QEMU can send data too soon so that dest may
+     * not have been ready to receive it (e.g., rb->receivedmap may be
+     * uninitialized, for example).
+     *
+     * Logically "wait for recv setup ready" shouldn't need to involve src
+     * QEMU at all, however to be compatible with old QEMUs, let's stick
+     * with this.  Fortunately the overhead is low to sync during setup
+     * because the VM is running, so at least it's not accounted as part of
+     * downtime.
+     */
     bql_unlock();
     ret = multifd_ram_flush_and_sync(f);
     bql_lock();
-- 
2.47.0


