Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A81E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7T-0004OE-5E; Fri, 06 Dec 2024 17:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7S-0004Np-89
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7Q-0002Qn-QT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvHR9rHEEMJo9JZLh5TSkXPd0q/isxl0gB/rbbaO7XM=;
 b=E7an8IHVM1UtU/l6xkyk3OEkO5VaOHy4hjN61cR5cFb0FkqfllvX3ju6JOZF/ZUQCK194R
 Zx7Adcy+bCiDqnA3UZAImo4EDnH8Cxwh0DzFZQ6Sfxkn3bJCmFnh9RfEBBoU2vvc4LPtp/
 rmx8UWOh/OEeMXfrM71tRF7p/81Q9XA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-5R1fxT0cNsGTrEDvG5NKaQ-1; Fri, 06 Dec 2024 17:48:15 -0500
X-MC-Unique: 5R1fxT0cNsGTrEDvG5NKaQ-1
X-Mimecast-MFC-AGG-ID: 5R1fxT0cNsGTrEDvG5NKaQ
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841843a9970so230784739f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525294; x=1734130094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvHR9rHEEMJo9JZLh5TSkXPd0q/isxl0gB/rbbaO7XM=;
 b=FceGEsGLhWvcQVnsSBBIb9Ucs16WGmrbtUU5IKZ+K3Eehr2wjun/NiZWXwuCBYtDJY
 LDtnH02mL5TRZQV2Dd7XX+O5tMXePCtGUqWg+WTftRZyHnrbD5bdQi/lxE1XFJnv8fer
 GnP947IzD9WvGgf01yEBSs0Y8bKkotoUu4XN4WVaeDvQ43qdfN8/HSFTTLkzPwp7TdBI
 vdEaIF9I2sqgY+JZpeKB9N+P7X0ou3Fp8Cu28w6x2J60MdfYfzxMId0AnNMJCgtXYFBe
 HdkeVgimD7me0nIeMvIlTXGvHO2Vre2/WQ6TRzT+rowy5BQ0rZc6pHecxaiRYUEtTtYu
 97UQ==
X-Gm-Message-State: AOJu0Ywy+BYjnV5urKsilS5f3tGA4DLnS+FXfkvLVH/bMU+v1d4nbVDl
 V364QzKky3w1yD9ZLlEcyGATgGeEz2pGvLdeZVUujyomo3GoPe/VeZfAbEHG6nT3i341BiHFTdC
 wbk3p5cFXlTqr+Xy/QnnY1lFUr+9uAYbJejBw0fM+4Rs6zAeaA6IXr14hMLLkiaye/ZyA6TEhbC
 xKD0GXfbXT2jr7OzaaCB9qTZwhAW/9M+LHIQ==
X-Gm-Gg: ASbGnctbeFaLhKwlTzvaR8SlIRh5E0dvsR4jHvZ7pgbh9ufIIAGAmxUU8/KsuGUdGfO
 bJ0a/NQGUUOeKMv9d8BQy8A1VWyQZEtXFs5+SwPddv/An8YXYqITQbp/ywBtWBa2kGpV1hQc3VL
 lmjifIM7wha7VuWeZzDaXMQmtSk9joQbsjeXMQtQJcujAPXRquN1H1O94N6lOgvASzquDWWnxrU
 GkioCRZTwHwCkSTnwl3u8xERrR+as+CQCLFDv8UezXulofChR2gPUy6Z5aiZJpJtm0pmh1PNMG8
 xfnbKmhdceJShs9Y17pcPer/jg==
X-Received: by 2002:a05:6602:1681:b0:843:f220:fa34 with SMTP id
 ca18e2360f4ac-8447e320bb4mr593948439f.15.1733525293893; 
 Fri, 06 Dec 2024 14:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEnQbTD764YsgJU6wJvcXio05QurkaJ9etDyonwrFfQDi9mpDvJDOgRRjxXCTwsng7iuo37Q==
X-Received: by 2002:a05:6602:1681:b0:843:f220:fa34 with SMTP id
 ca18e2360f4ac-8447e320bb4mr593945539f.15.1733525293524; 
 Fri, 06 Dec 2024 14:48:13 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:48:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 7/7] migration/multifd: Document the reason to sync for
 save_setup()
Date: Fri,  6 Dec 2024 17:47:55 -0500
Message-ID: <20241206224755.1108686-8-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
 migration/ram.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 5d4bdefe69..e5c590b259 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3036,6 +3036,31 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
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
+     * Logically such sync is not needed, and recv threads should not run
+     * until setup ready (using things like channels_ready on src).  Then
+     * we should be all fine.
+     *
+     * However even if we add channels_ready to recv side in new QEMUs, old
+     * QEMU won't have them so this sync will still be needed to make sure
+     * multifd recv threads won't start processing guest pages early before
+     * ram_load_setup() is properly done.
+     *
+     * Let's stick with this.  Fortunately the overhead is low to sync
+     * during setup because the VM is running, so at least it's not
+     * accounted as part of downtime.
+     */
     bql_unlock();
     ret = multifd_ram_flush_and_sync(f);
     bql_lock();
-- 
2.47.0


