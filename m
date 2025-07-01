Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C2C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQE-0005CP-2B; Tue, 01 Jul 2025 07:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ6-00059p-5r
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ2-0003Fd-6f
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xnb6fY77tTZ5nf3Ugq1ke10+nz2hG2kWSwmOHbAyR9g=;
 b=F9mtPScTMHzlq0gd5Lef7arunFOoxIxhqPI97LJfbSsOxTcJtNaCU2zO37PDU82NUqrMvI
 h5+/ZKBkxgLybNnW1R4a6jw8kyUvh3nfN/Mk2LF8UFiVUZUVdf2n7qUQYkKZIOVYnWZC/t
 /K0JmRcyd8gXnDoNC2Jkw3V2g1grKBQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-6r_JqRcGM7-JECYHY1dCiw-1; Tue, 01 Jul 2025 07:44:55 -0400
X-MC-Unique: 6r_JqRcGM7-JECYHY1dCiw-1
X-Mimecast-MFC-AGG-ID: 6r_JqRcGM7-JECYHY1dCiw_1751370294
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so2808055f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370294; x=1751975094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xnb6fY77tTZ5nf3Ugq1ke10+nz2hG2kWSwmOHbAyR9g=;
 b=H6lpwCFtbYDenPfln1MWKMvxfLaS9pBXrh2JRHj8mZ2fwwqG6w0d2tKsF+cMwAvzL5
 53Kc4a0D4sa9neUbiGl//LLzBDhVXi0cGmi2JUhyYQQPJXrytW6u7AkwfYfNZ/KxHm4K
 eiZBYXeyF4C5pynDIVyGC2BQxj9axZ1P1MQSb2eo+/CYoZ/8jbbHjRgpmaeuZitRvYOq
 P+GiII7qCjPGuxXAQFVb52AvhLAHVVDe8cxRasmVVdPIKgrqIc3l2hL/JrXWG3EqvjbI
 DmMXcM1jNy0l+l1WIHT28aRUiPAkomlvD9flYOqmO4B34eyb9Jjrsn6G/erKs+6m/ddU
 9Baw==
X-Gm-Message-State: AOJu0YxTvooY56NHLDJtsTpnFAjYiGy5XDnnf1irSC9LCy6t5/xwaUdM
 qe5UaCU1inxE2M3I0KQvzcxVGG0vTIgk9BPFhPybS3RSY/BXOJtRQ0hCycS8rfbWpIqz0pkQcyr
 Wij292czg0gjGs/+Xh+KAmNVvgmx+A6cDGDz12KSGf+NoTz/2SU2AQLsf
X-Gm-Gg: ASbGncvtaRiNf64XJ0M959kdr/l6Cwo7gBbbVsIWmnIbVPLMzGVIx6mzQOu/SEvvdIx
 MCCycglIFeSJTrDwUEcHctrZ3cX78s9KYNxHBVK5gFd/YUGEWxpqk0jshJ8JOkfU9y+TRFaCMPk
 gzrfgGO07BNlY0gIfom/b3yYrH3VI24NiTzAej4S2/SGT3EjJGeS1+e1JqD5O/6oIltUny9tvSl
 EXrqyUodU7Q2ydipbtzDqw50dDTlLoTxfahgfRI0Wdh9Uz6PxslcHYKWC+4lb9v3NBK0cIQeRLq
 sdFZ2UDLNAkreI4slMjQd3KBfWjW+lVr0Y+RL+/7h4iBVRwdaMfY6f3ycchO3oCkG7hXLWNmJWB
 YZ9+6
X-Received: by 2002:a05:6000:25e8:b0:3a4:e8c4:7a78 with SMTP id
 ffacd0b85a97d-3a90bc9e3eamr12601742f8f.52.1751370293822; 
 Tue, 01 Jul 2025 04:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSNOWJQyimuD7LPvKUBTfe6V4kPOXuANgbtrBAWCiOMYuVHrcDGYZwRx4dbM251wKQUMI4UQ==
X-Received: by 2002:a05:6000:25e8:b0:3a4:e8c4:7a78 with SMTP id
 ffacd0b85a97d-3a90bc9e3eamr12601722f8f.52.1751370293379; 
 Tue, 01 Jul 2025 04:44:53 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f92esm13149118f8f.90.2025.07.01.04.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:44:51 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 03/21] fuse: Remove superfluous empty line
Date: Tue,  1 Jul 2025 13:44:19 +0200
Message-ID: <20250701114437.207419-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index b224ce591d..a93316e1f4 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -464,7 +464,6 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
     }
 
     if (add_resize_perm) {
-
         if (!qemu_in_main_thread()) {
             /* Changing permissions like below only works in the main thread */
             return -EPERM;
-- 
2.49.0


