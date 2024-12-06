Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83203E77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgE-0003a5-K9; Thu, 05 Dec 2024 19:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgD-0003ZD-6A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMg9-0005iM-1i
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=es3XBObQHiGtgZBVTVbSw3WDegXk2q8ebNuAwrDJ0N0=;
 b=Dn711r+rrs9wHwbEzkNVDvYWJIybIpGIETjizzb9Sb1znKomRCaxlheHQ710RDE793W3Ye
 B+4DAW1HBqvA35h0/Iz6FAKGWMaowLabYfYcrWIBubzqE6ejAWa+XhFTlhQqYiKObpor3+
 KflVG+01NyOhdolNu4OUcDNJZqGf0/Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Uv6HYEu0NyCVRxUGyinsqw-1; Thu, 05 Dec 2024 19:58:41 -0500
X-MC-Unique: Uv6HYEu0NyCVRxUGyinsqw-1
X-Mimecast-MFC-AGG-ID: Uv6HYEu0NyCVRxUGyinsqw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d893f0027fso42036656d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446720; x=1734051520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=es3XBObQHiGtgZBVTVbSw3WDegXk2q8ebNuAwrDJ0N0=;
 b=ixnn3rs78YZxjKPeN0ZQW7OS+mfqMdatmQxYe9ASwS8gW4g5K7DVh+lqtd9JnjlHJQ
 qijqaC8/cxbKvMuvlK68cTtEcZsVCFn2isR4qPZxGecGwntLMPgw9JyTfoISEqE0h+dp
 XUgbgoC5CNYP2WGFHPw+kWXluLBv7vT4qXt7roqvfRzmbn29ogHPAHfu5KlCp2weucaJ
 aAbldfFdIsWPrpaDW6Tu04pvCC+EE+5XxioI3Oq1USBLkFh2lH8I0ddwBaBLxXH/LKce
 0jcoch0ya7q+A4hayv685NSi27NcMrYSEWgwE8mLz64ms+OeJ9faJxj8/80WI+PMQL0g
 mBdQ==
X-Gm-Message-State: AOJu0YyXLJ0W/tRMv5csmqtmgjD9K8wfEkWeWspisgpe9iFHuAcbbln5
 0yfbSMQVTkHwfPaTeX0P7g6tBaebJja3qzj5IyDk2cTrnLWkMhPcwAd4gIui96OxMcgYDIlCbwF
 1o/7MSECR5RVeCGHMmMRf31TmMpKnyr3yQGPaZjWECTAb2+X6oNGY/jzwPy5Z22f0D+9mnZ2Bx4
 VnCJ2E+zodtGaRPvWVimiFw3qW4d8Z8rRjTA==
X-Gm-Gg: ASbGnctdT4w+unLpAU7p1Pu3LaeJigmT+JiLXbhOg8yPQX9z9xBwEnaXzu+Qd6GU9oa
 qi+KDE+eRgPzmxlT2ffRMUNkluwKke/+AWsShZlPUU/92Ta3gSqJuFRAGpTEQByDO2Wu4mHwY8r
 fzoYKhsKKx+K67Mz42zSWQCKNBtFrTl+/knYCE+of+7yfE+M3zEVxgMiqKW1r75uthdJNg7V0sT
 y1Ayc4W0GaX8y/pekMW0vQgCdfH09fB7LHS5n/s01SSeE4JuMcSPJXZ3jmkoHB4Qqxqc2EMmBU7
 QHCKEdY1fDxB5hxo0WGSF7Lpdg==
X-Received: by 2002:ad4:5c46:0:b0:6d8:7ed4:336c with SMTP id
 6a1803df08f44-6d8e70a2743mr24885956d6.9.1733446720024; 
 Thu, 05 Dec 2024 16:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUWRkX/DMHW6ZCiAHXl9KlYYZWdaC3iIDx0eVNrUEzC4vIQRmJBnzXGJUDRyid7bDrenVBIQ==
X-Received: by 2002:ad4:5c46:0:b0:6d8:7ed4:336c with SMTP id
 6a1803df08f44-6d8e70a2743mr24885556d6.9.1733446719594; 
 Thu, 05 Dec 2024 16:58:39 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:38 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 1/7] migration/multifd: Further remove the SYNC on complete
Date: Thu,  5 Dec 2024 19:58:28 -0500
Message-ID: <20241206005834.1050905-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206005834.1050905-1-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
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

Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
complete()") removed the FLUSH operation on complete() which should avoid
one global sync on destination side, because it's not needed.

However that commit overlooked multifd_ram_flush_and_sync() part of things,
as that's always used together with the FLUSH message on the main channel.

For very old binaries (multifd_flush_after_each_section==true), that's
still needed because each EOS received on destination will enforce
all-channel sync once.

For new binaries (multifd_flush_after_each_section==false), the flush and
sync shouldn't be needed just like the FLUSH, with the same reasoning.

Currently, on new binaries we'll still send SYNC messages on multifd
channels, even if FLUSH is omitted at the end.  It'll make all recv threads
hang at SYNC message.

Multifd is still all working fine because luckily recv side cleanup
code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
recv threads are stuck at SYNC it'll get kicked out.  And since this is the
completion phase of migration, nothing else will be sent after the SYNCs.

This may be needed for VFIO in the future because VFIO can have data to
push after ram_save_complete(), hence we don't want the recv thread to be
stuck in SYNC message. Remove this limitation will make src even slightly
faster too to avoid some more code.

Stable branches do not need this patch, as no real bug I can think of that
will go wrong there.. so not attaching Fixes to be clear on the backport
not needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..7284c34bd8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_ram_flush_and_sync();
-    if (ret < 0) {
-        return ret;
+    if (migrate_multifd() &&
+        migrate_multifd_flush_after_each_section()) {
+        /*
+         * Only the old dest QEMU will need this sync, because each EOS
+         * will require one SYNC message on each channel.
+         */
+        ret = multifd_ram_flush_and_sync();
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (migrate_mapped_ram()) {
-- 
2.47.0


