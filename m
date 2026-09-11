Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A0C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAm-0004oU-18; Fri, 11 Sep 2026 05:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9o-0003eM-NL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9m-0008Eq-W4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnxtJwJv6yUaxvWZxIjniMMKZkL70PYqB4D9wt2Y1j8=;
 b=B22r16bNl0+50JfjkXbc1zZ+xz0z9CW22uxaYOG8XPMxOTubBvSVlZfdBuq9BU0GExGgZI
 oJ9ss7+Lr/Pkk4bu1f5xFtxV0LZz0I91iVmFFbpUs5CRMQJnVmGhX4f0C0WEiydb5GcwDR
 cSbrrq4WyYBhMdejKbcxKJ5nBflnkZ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-UZgfuDZEOLG8YFFlOMyXUw-1; Fri, 11 Sep 2026 05:02:48 -0400
X-MC-Unique: UZgfuDZEOLG8YFFlOMyXUw-1
X-Mimecast-MFC-AGG-ID: UZgfuDZEOLG8YFFlOMyXUw_1789117367
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49d1a778b9dso6297995e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117367; x=1789722167; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wnxtJwJv6yUaxvWZxIjniMMKZkL70PYqB4D9wt2Y1j8=;
 b=ouGKhrHOGQd1bu/dLOH3i+3OypbGd6zdXMVBtDk2FmvKE8CjNEgrXGSE0Mp60oraMJ
 VhIrT+cKrYkVPU9LOiM4KRKiL8Uuxcw0QEv/7Wgvw8ihC8i5ZUaLQqXjjiyMNg7i3wSD
 Vmk6hBJ5tuCUumPo++ksQjxKWNqW/bBsy4jsAZdlKqD3ihjk5l4mTgoUIy/QTzvOqwFp
 8S6QDSiVxXAwA9Cj37JZcnhBPW6F6gNdIUkaGg0T8jRpzi2dl4jIYqG301mqBe5sd20I
 yqYagj7aA96Qeqed2XsGVUdblPfeeKpNNa2wsZdUVmVr/sXM7xUoIjkx/YGjZEcTnNCy
 nkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117367; x=1789722167;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wnxtJwJv6yUaxvWZxIjniMMKZkL70PYqB4D9wt2Y1j8=;
 b=nMXlbtQ5yZs5CtGn1RbNJ4LC5q1+jryBULnrTxGejcgZ2YV1KHlof5U2OPGQWidNRF
 jufysi7U8cO7osiVR8N2fzxs0T9mKr2OFvIwkGVw/L4tgxFQARMbNpTJ10aYAMXXMFBJ
 U81RiCC3NizJxkq7ep4FV7ruXTBbQpNCqX+ifFJ6SiRGeaSUkviWcu/2UwIpITmdnQfi
 GEj2v7g8Uc6Qo9lLT+vLHy7Z7VVwl/AMMuU90WENoIfQws2Gq7V/iFYLkAcBMFdr3Wq+
 rNKJ51vixyG8ZjEHFR/3/dagwrQBD6I1PKQw7dUcEUsdP/2YZ/jSuKQRX00ITk4EtUZa
 aLfw==
X-Gm-Message-State: AFuF++lgvzxGE3xbVKGYgdjC5KYs6D0MGEsvTEe7NlyIggvTfttT/I4Z
 S3nlyNfmi9ua2vFSUzyuelfDVhmaxAsHiayb7RlHVBTcPuPmaCFXksUDiIUP3LgL2MTcCYgPWBB
 MiNpLaF4IH5/4eHej1A1WOe8CGNlSs2ppy4QtaqWLEGvguQD9FsExAiJNEEpQ2KuI99fE1egupT
 19auYv5MGVlfb+0eQQo2i0bu2bEu2lOrWcDQ==
X-Gm-Gg: AYBFou3oDegBgHmoQzsO/NlmN/7OTEBzYoYuG/uWzYPuue9VM+xEuXcbEyyB5jgy+fJ
 VsE/RykC+K9c0nZFta9mBKTsb3c6VOHT60kANp9IzC5GDarCFk1r06U/zyXgbPEQJwN1vbl+eIT
 QQjIaP02kw1rRHPOHjgFFkNaKmar+1eRYIGHW0aSKxO0QgE+5P3sUy5u7cB+Mx3wRdXCFLcfoQX
 UGwzzwgrZbSn24pE+i62hlXxdnN8Hq0qYLmgOUA8gVIb6q9akRImBnzohPECRHF7/GW+pmc4a7S
 f6GrzPefOAsY7VAfhjh/85BdWLvvYFvhICy71KlM589SUaTssLIc/S6XfnEYe2pBMt1FV6Ggg5L
 kGWfGpgENXMoYVCSIqHapWM8=
X-Received: by 2002:a05:600c:3513:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49e619c0357mr55971385e9.7.1789117367319; 
 Fri, 11 Sep 2026 02:02:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49e619c0357mr55970485e9.7.1789117366727; 
 Fri, 11 Sep 2026 02:02:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a33e34sm39031965e9.0.2026.09.11.02.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:46 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v2 36/75] hw/scsi-disk: Fix accounting for IGNORE, ret > 0
Message-ID: <ca9e91dc1095b38872e803e94ddb0b1a758f3ce7.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


