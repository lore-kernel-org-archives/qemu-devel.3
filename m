Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1800AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaX6-0006Fm-AF; Fri, 06 Dec 2024 10:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJaX2-0006FV-C3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJaX0-0004N1-2q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733499972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwPuG4gNtXe4+gl9PX5d8nS0N9dEUXCpX+mHPOpQr9Q=;
 b=Zye3XIHUME0BxAZT58w5WzyH+W4xHDqy0ZpeASZKbmExgMCI+vvjddpy7a28gG97OZhjRx
 xkF1E1La5O6ckkDAllCZyiRysBdjN36ffmKMXbAPebBP9S4FyuMsoUn8wcA78oGkannOau
 9g7tCqJIOCh1oOrw8w2O57dyO3ndhZs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-zIfrP5zSPxeWLfDay1PFqQ-1; Fri, 06 Dec 2024 10:46:11 -0500
X-MC-Unique: zIfrP5zSPxeWLfDay1PFqQ-1
X-Mimecast-MFC-AGG-ID: zIfrP5zSPxeWLfDay1PFqQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f589d8e7so2516076d6.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499970; x=1734104770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwPuG4gNtXe4+gl9PX5d8nS0N9dEUXCpX+mHPOpQr9Q=;
 b=mmak4k68D7LWvMB1WyQob2QwujeMGvjXGC10wUQHlCUc+UNkR6YtEoG7Lbx8fs7OqB
 F3C8VP0aQVGO2ZitHTswC+BVgV36bP+eHp+8WRH0fbD7qr6EEUXIx61qo6tBhR+wo32L
 MnupHlQ8VAS6HSXVeXTwBfecaeO08CX61KmgteQHoDVgvyW6yFbZUh1Y/VKZoIM4Kcf1
 oUCamAhHdP0TPMAmTnm9VuoM8yCSYUTTf2nDUro0yIzjfMMJdHq75l69WVS7Ed46hDkX
 Age5OAxCh5fdSxh0X8yfziKKVld42km2QdnCJUkOyMsypkwP3s9CB+vy7P8JXmLvBaPR
 xSUw==
X-Gm-Message-State: AOJu0YyT11/FTgiKtDKzy4OKGNyTonbPpdXtG7slq59z2EIezEEjaepk
 Gj71MSDveWE4Esjelb4SQaSibqDVoxpDdNmuhYeF8Pth7uyNdNJLgdl1Ckb5Yftx8og0NoIsPHJ
 s28coNj1P5LTOEGBHEnyLh9dWrMDkEVHaTFLzml/kCZu1Bs4McNQ/
X-Gm-Gg: ASbGncuz4SlN9KKbRdEyu1VxILd4hUAbasGAEiiYl6lfS6mA8+ReVxgBR2dEMXvb9UC
 D19aM1JwvILTVfB9CDJlWT+G41vq9LfqshcXpJH8NQ90RY0puc8ylsvh+e6D/EcHGsKIfHmcV7Q
 KLSo/0BYVhq2kgOERmAVgzNKj/xt2zfLxqI8hcLwhyvKlTLJzWdqcoLVk6PcFQUcdweDNZvtlvR
 qns2tN4jLYRnnw+0btsehuCSOfA25k4dit7ELB0PglcXsDFwdhfL7wOlZMgpA8hJnmhJnviZKhM
 fBdk6NsRdNI=
X-Received: by 2002:ad4:5aa9:0:b0:6d8:99cf:77b9 with SMTP id
 6a1803df08f44-6d8e71550ebmr55354456d6.19.1733499970546; 
 Fri, 06 Dec 2024 07:46:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMpBU2/9Ok3KY+hr3dX2d3Mer0aM75jouQJtzFMe6yg5esy1zO5CNELJ5T0aOIj8bU6iLu5Q==
X-Received: by 2002:ad4:5aa9:0:b0:6d8:99cf:77b9 with SMTP id
 6a1803df08f44-6d8e71550ebmr55354126d6.19.1733499970229; 
 Fri, 06 Dec 2024 07:46:10 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6b651asm20140666d6.69.2024.12.06.07.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:46:09 -0800 (PST)
Date: Fri, 6 Dec 2024 10:46:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 3/7] migration/ram: Move RAM_SAVE_FLAG* into ram.h
Message-ID: <Z1McP5JSSMNAHGGk@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-4-peterx@redhat.com>
 <874j3hc4fw.fsf@suse.de> <Z1MSKpiMiPsidzJO@x1n>
 <87ldwsc0eh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldwsc0eh.fsf@suse.de>
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

On Fri, Dec 06, 2024 at 12:10:46PM -0300, Fabiano Rosas wrote:
> > Wanna me to add a comment for that in this patch?
> 
> Yes, please.

When I did it, I also did a few other things:

  - Rearranged the comment section, put all things together
  - Remove RAM_SAVE_FLAG_ZERO directly
  - Reindents

The plan is to squash below diff in v3 post, feel free to comment before
that.

===8<===
From 593227f1b9e678418f5b99ac51525884fa0adfc6 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 6 Dec 2024 10:43:25 -0500
Subject: [PATCH] fixup! migration/ram: Move RAM_SAVE_FLAG* into ram.h

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h | 33 ++++++++++++++++++---------------
 migration/ram.c | 22 ++++++++++------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index cfdcccd266..921c39a2c5 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -39,24 +39,27 @@
  * it to only search for the zero value.  And to avoid confusion with
  * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
  *
- * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
+ * RAM_SAVE_FLAG_FULL (0x01) was obsoleted in 2009.
  *
  * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
+ *
+ * RAM_SAVE_FLAG_HOOK is only used in RDMA. Whenever this is found in the
+ * data stream, the flags will be passed to rdma functions in the
+ * incoming-migration side.
+ *
+ * We can't use any flag that is bigger than 0x200, because the flags are
+ * always assumed to be encoded in a ramblock address offset, which is
+ * multiple of PAGE_SIZE.  Here it means QEMU supports migration with any
+ * architecture that has PAGE_SIZE>=1K (0x400).
  */
-#define RAM_SAVE_FLAG_FULL     0x01
-#define RAM_SAVE_FLAG_ZERO     0x02
-#define RAM_SAVE_FLAG_MEM_SIZE 0x04
-#define RAM_SAVE_FLAG_PAGE     0x08
-#define RAM_SAVE_FLAG_EOS      0x10
-#define RAM_SAVE_FLAG_CONTINUE 0x20
-#define RAM_SAVE_FLAG_XBZRLE   0x40
-/*
- * ONLY USED IN RDMA: Whenever this is found in the data stream, the flags
- * will be passed to rdma functions in the incoming-migration side.
- */
-#define RAM_SAVE_FLAG_HOOK     0x80
-#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
-/* We can't use any flag that is bigger than 0x200 */
+#define RAM_SAVE_FLAG_ZERO                    0x002
+#define RAM_SAVE_FLAG_MEM_SIZE                0x004
+#define RAM_SAVE_FLAG_PAGE                    0x008
+#define RAM_SAVE_FLAG_EOS                     0x010
+#define RAM_SAVE_FLAG_CONTINUE                0x020
+#define RAM_SAVE_FLAG_XBZRLE                  0x040
+#define RAM_SAVE_FLAG_HOOK                    0x080
+#define RAM_SAVE_FLAG_MULTIFD_FLUSH           0x200
 
 extern XBZRLECacheStats xbzrle_counters;
-- 
2.47.0


-- 
Peter Xu


