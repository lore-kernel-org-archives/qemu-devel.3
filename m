Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701BDC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nnj-0006ik-Gg; Thu, 10 Sep 2026 19:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lPT-0004IU-7q
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lOM-0001OP-Un
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnxtJwJv6yUaxvWZxIjniMMKZkL70PYqB4D9wt2Y1j8=;
 b=OIMNGTwZF63l4ZtaKra18IlwsDGZC58zdth8iAewv2VvMIqm0+ny+atCvrIO8TYK4S6zmT
 ldR2vR+gnLQbcfUT7glNzMLg2YmEUDWCLDqCyDICigVeG0FgitarpuYtSSNn3u8pa3v5hM
 h68pcMsl9mCVrvKPfTVbORvRHvZrUPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-pw0JO46NNDGiX9GwiPj1ww-1; Thu, 10 Sep 2026 16:13:34 -0400
X-MC-Unique: pw0JO46NNDGiX9GwiPj1ww-1
X-Mimecast-MFC-AGG-ID: pw0JO46NNDGiX9GwiPj1ww_1789071213
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso2083445e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071213; x=1789676013; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wnxtJwJv6yUaxvWZxIjniMMKZkL70PYqB4D9wt2Y1j8=;
 b=eaEONQ7+AUtUhH+vgIfJpClq5hvTOfMaM6qO/i/Bza36eMhLzKbfqh/L/B6wmB7LbP
 xIoQ5MAdzOvuJaD9iu0uz6ez8fAYlagMMo5N/dsuQxVBo1374kSSR8ZRq11GjanE0GNY
 Jh9xuLC2wfa0wTP5d0qdQ7Pa5+kJNcII+vfuL+NpVQ7BkkjEBvVwTpdoA0oL6XIgocu1
 WZgPKgAIl0uD55gTzQFcdxbUb5TAKJcGfO54cIRNEqVCopoAVM/AXDbuX49jDkFhwfgl
 2/LQ/IlNaObJ7IG6GNtUYKKEw0nxm/HP/1/DKJaV5SdVq3uudj21EDhW+0+ZC5AIYDcU
 qsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071213; x=1789676013;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wnxtJwJv6yUaxvWZxIjniMMKZkL70PYqB4D9wt2Y1j8=;
 b=HA4FQyFVw8ylN/oWYibjcXC86YjrjBpfG9y6KMJIjtZ8Ttm3qeL22hThLBpMm19ac0
 RQ7GXZ5j4Wx6nrCp47BM4C+EAPi0zBvCbzMJd/dI00+vPAAoMyjH/pm3mh40T2PraDqp
 Ei3cWLJXVbRjsac8ut7XqGSuR8sAP95/6dxtwNbrQBGQK4M2xAikrDu9ij0q4qsXYSM/
 vjjOT1KANKInnvXQoj5aYSdBVyGus2IxM2g63vRtzrpyv45at05DWUAAxBF8Mjx7yoTB
 hNecixjhAzl05+OL1LKFS2SPcUEdpo32jGt4394lGy4TdBcFLSqKDxDNUAvV48eXOnwH
 OmwQ==
X-Gm-Message-State: AFuF++k094/U7Kh3VvVzMbEos2JaLlJHuChl4IIYe6DnpP3B6abvXmrl
 JytgrxrjLJNSi+pR3AfYYT52rctGw6/v0YPjV6YM7RjoWwNNLCs06zkEVTxT624HaV2MI8yJCMl
 8DeJ+tZK7CHJFnDF9VVGIPvNoFyHjpbY7D5cmUO4n0bwJoA8TRzOMsUEYqzlzswq5E9IVL//4ge
 xbye9fTh80BG7s7/EhqapBxBb2k/c2KAnDDQ==
X-Gm-Gg: AYBFou1njtzTe32Y7fj93ExedkJoKKymst9vk+x16G3m1sE6JTktWB4yotpQUUzkyuz
 IW4IlE+qiwZxzrSWMWnBBIupapMG4bxuzZTBf0ycr7yVc3sLIgv8TqEwqkR6LddI5m+rclAQVKm
 9jHA+rrbmp+O8zraa7Qtc6rTN1UH3LN7JLEsINLmpr/h0tNmv1OXaPYWQTO3/7Av66283conReC
 /hLm6dDl9LLRtgr1+Jzefo++bIb6Mn4Op/UPjilTW/Rbv9wVDrIrG1xUihb/PZk7yK1hwe+HDYm
 w4yhugoRplNwh5vDb1ddGdRX/4Cx25Acgb0YjCFiU2x3+hjmy0NSdNlHlahQJ4+DOPeBfcPGg1M
 PnK/BukpQwGh7Pmw7mDVEiKQ=
X-Received: by 2002:a05:600c:1c16:b0:49d:1a02:4797 with SMTP id
 5b1f17b1804b1-49e619bb9bfmr9928855e9.17.1789071213275; 
 Thu, 10 Sep 2026 13:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1c16:b0:49d:1a02:4797 with SMTP id
 5b1f17b1804b1-49e619bb9bfmr9928405e9.17.1789071212794; 
 Thu, 10 Sep 2026 13:13:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac4397sm19161225e9.7.2026.09.10.13.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:32 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 50/90] hw/scsi-disk: Fix accounting for IGNORE, ret > 0
Message-ID: <bdf35f1c8aafe4215dc7cb216f98ebbd71c3ac91.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

When encountering SCSI error status (ret > 0), accounting is left to
scsi_handle_rw_error(), but the BLOCK_ERROR_ACTION_IGNORE path in turn
leaves accounting (block_acct_done()) to the caller, so neither side
does it.  Fix this by unconditionally calling block_acct_done() in the
IGNORE path.  Yes, this will often result in it being called twice, but
that is a no-op, as block_acct_done() resets the cookie type to
BLOCK_ACCT_NONE, and will only do accounting if the type is not
BLOCK_ACCT_NONE.

(And given that the conditions on who does what accounting are quite
confusing in scsi-disk, for me at least, I prefer this unconditional
call rather than guard it with a condition that has no obvious reason.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-7-hreitz@redhat.com>
---
 hw/scsi/scsi-disk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a42f7d8e77..deb33ac1dd 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -318,6 +318,13 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
         return true;
 
     case BLOCK_ERROR_ACTION_IGNORE:
+        /*
+         * The caller may have already finalized the accounting cookie
+         * (e.g. scsi_dma_complete() for ret < 0), but calling
+         * block_acct_done() afterwards is fine (just a no-op).  Just
+         * make sure all cookies are indeed accounted at some point.
+         */
+        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         return false;
 
     case BLOCK_ERROR_ACTION_STOP:
-- 
MST


