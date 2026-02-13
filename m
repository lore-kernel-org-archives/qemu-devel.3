Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E3BEDF15B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquDv-0003im-0p; Fri, 13 Feb 2026 09:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vquDl-0003hJ-Sa
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:32:37 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vquDg-0006bK-2g
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:32:37 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c307db9aso483785a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770993149; x=1771597949;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=86tCwquiEDvka7I68JbUKt9Nu3C06E3KdF5qlbu5Yk4=;
 b=Zf3X4Dp1lMhuGpqGSEQVaA7m9oMJ517/TtAh/FN2mLcpkoljemrLzO3FLVimOFL+Mw
 s073iQVnpCTkSo0NhN60Tt/twEAglSa6XLrUxgJPq8uOcFqsFkKgcY7BkDz++qzsqGc5
 mKc0hRpvJnSrNueRxG5b3gucfOuxgGMA+sVDsV5/s2aa96iw0TngGio/F8VsDx04CdpP
 5HK6ZpORJsWJSUCwAwc/Vrue4t3nhmB/DbxLCIL1RAsmNEE6CQ+L7t3l23iW0D+/bpLY
 y4AyL8UhdPu/I7EF1HIbCB2NXxWQK8nGPS87J8tOW4vasySMki+3PiIXPI2iL4RV9GPl
 lBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993149; x=1771597949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86tCwquiEDvka7I68JbUKt9Nu3C06E3KdF5qlbu5Yk4=;
 b=kCVxv3nLvLpiqYBorQNN0NdXUNzePvFIs+8ZA/e1qp4iTqMz8Oxsap2PvKdt43+HVE
 7iKOECGN+jtyXGlXwoW/YOij7RbksU2NsbCIHsUjGCRmLHuQXT4ugj0ExYGqXimLjwON
 AaUM7/TEu6W4MKtR6HNk86x//aSeN+uZTZs6q2CpRkxi4tAMjskVsx9mVrdD9B8G+4PV
 UU4QgF7tB9jip+Y7H18W2F0f10qyuuspu/0aXJvzJHtkmLY3psSQwQq0A0Xhf/yDvDOs
 LrZbJIw4QFHYr0K6DZ2wZUcI+MfatNPSNzR/bUV/+WFeDFI/79pQho6Rloj7oOXkeMxn
 /Bmg==
X-Gm-Message-State: AOJu0YyJ00NPgPm2plmP0/po8qEQm7F/A4dI/koBKgnGtArIuDvsZorY
 bL4JzDhMa5czD7j8uiwcULdRM2WvXsa4gREAx+Ue8Y6Y1W5HQ7a35c2bhaFDO1qaXgM=
X-Gm-Gg: AZuq6aJVBWPmT0zLk6K1byTVqSXUz3viQHDy0BDjySYhOKHfDtZu9TFssH1of62HErJ
 zcQ6KTWARhYNcpLpTc6k6vI8QLTJ2XwRWqkNN5Nvz9C49gjGOFtMSp537wJesopC8UYPDXPgx2C
 bKyRNKMW7bev3UZWPYOnUwrrXRjmx/ZyS4PnRZMIbOrS5DVp/Nu4DMS/XNlDpruGIFWfibK2OOp
 eXksB36MLoC71RA8fCN/ivP0stT/j0Rb7ZqyNa9/1+IVlkmUYC1DnP4zezGyz/w2DXs7Qe5qgTI
 Wz6gTX1NNUKtMNoRe0Vvq/6/shj5W81DQ493vA97hwfCgEsrTK+jHChAub9A9Bl1bwnZ51snfI4
 6z/jiv7ccWeV4UT4aYmItAgfEslHYtqrS3RGAXX4XqM3t+nMmXKxtBRyIAdhCoi+6LLuGE+oV4j
 6yjEpEouOrFJ/lNN+xvS9TyuU/XYKYGXAAy5Z749AKiUNO4TvSrj+Wty5li0QcFoXGtTkA
X-Received: by 2002:a05:6830:3745:b0:7cf:d4b2:d664 with SMTP id
 46e09a7af769-7d4c4a359c6mr1232223a34.4.1770993148988; 
 Fri, 13 Feb 2026 06:32:28 -0800 (PST)
Received: from m2max ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a733f033sm6564377a34.0.2026.02.13.06.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:32:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	fam@euphon.net,
	stefanha@redhat.com
Subject: [PATCHSET 0/2] io_uring fixes
Date: Fri, 13 Feb 2026 07:26:35 -0700
Message-ID: <20260213143225.161043-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=axboe@kernel.dk; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

Patch 1 here is the real meat of this, patch 2 is just a slight
improvement. For patch 1, it can literally yield a 50-80x improvement
on the io_uring side for idle systems, where ppoll() ends up sleeping
for 500 msec while there's IO to submit! I noticed this running the
io_uring regression tests in a vm, where I use a variety of block
devices for some of the tests. They would often randomly time out on
AHCI devices, while running them on a virtio-blk or nvme device would
finish in one second or so. I then wrote a reproducer to try and grok
this and had claude dive into this, which helped me better grasp the
various event loops.

Please take a look and tell me what you think. Some variant of patch 1
should definitely be considered, but let me know if this is the right
approach. I can easily test anything.

Also note - this seems to trigger more easily or consistently on
aarch64, which is where I run most of my local/immediate testing.

 util/fdmon-io_uring.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
Jens Axboe


