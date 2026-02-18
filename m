Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374BCE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfD-0003tV-Lq; Wed, 18 Feb 2026 08:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfB-0003pb-5R
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshf2-0005Hh-09
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNGtHA3kcdOL2SVcnUEo+P1ksEysivVPpQTbAQYAGcw=;
 b=iFCc3302pjs/PE6hTzevM6QYVNl0sx98KM+UU42YV1HuVMGSriI/EuEQnFnpCXDy9xh/p4
 1mKFI/IrXgM85ov20vIKH8Cen+R61YqfObXn/hWh66I7Rg86isJ4FGaHEIi+K4R89O+XvT
 GamJLEK3RGdEKY6mm2Mj724zWtY7gqc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-hdgelCW0PjO0dimMrVNx9A-1; Wed, 18 Feb 2026 08:27:05 -0500
X-MC-Unique: hdgelCW0PjO0dimMrVNx9A-1
X-Mimecast-MFC-AGG-ID: hdgelCW0PjO0dimMrVNx9A_1771421224
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435991d4a3aso3508161f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421224; x=1772026024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNGtHA3kcdOL2SVcnUEo+P1ksEysivVPpQTbAQYAGcw=;
 b=kfA7iLv8Pa0vvoxELeloKQr2gUp5kEEV8RraNBayCDTyOstqUAEFOQBpOMY0bHx7jV
 ls8b+lYqM0OSwpXakNGDsgWC9W2krP6Rh4/UVzcTppcQVN9E5SB2BhRfpo604PgoVW/b
 OfsqvKHvOnmC35az9IlU1FlJblH40bSJaOi6OnkVmNi/Jrs2+961hQeDifLLGTUotKeH
 WHaC7U9t748CIMMD8BKiJ/Yy//n/eNhZwy5F6fCQOaMlzvYb0GItEfO5ne/pG94VAr9T
 mXEeNKJkQNeznjlGVr/WnrTrP4+nYe/CHjLfjFIM1rcFq2W56Dc/dIMVOaoj4INe0o1Z
 F9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421224; x=1772026024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNGtHA3kcdOL2SVcnUEo+P1ksEysivVPpQTbAQYAGcw=;
 b=MO/DDb6fM+xFf0qXBPodBv+mmgNHwhMW2wwTcdx6LrU2xvKhjWX9zJmqd3EPa8b9P3
 VwEuML3a1CtV3SD6Ytca98CGhVCo1QRz2BlendrVCJrxpRX4lbKfCBOipNMSO2oXVFaE
 Hb+HH3dFrIVayrvHauzsf0QjlTSNaAi8ZzgF3GtIGHOFiSsrTwjYIQ91V3iX56nlFDLo
 1McYcINCajWiE4y6as/zLgXIjqw84WWbXgvUfSGagUxi0B+Zr1e3671a8uz/hLWPOQOw
 r61GATi9iIkHTR/wftB07Q1usD70K66w2/poq0y6NULqKUvkkFEMA0aIwZk5WwX+PTdN
 f3mg==
X-Gm-Message-State: AOJu0YxG2dolzSrAOxIGrfSG7csiJgaSz4OKupwV8mIo8qxUi0BpzkPL
 HV47ukGyQoB7Rn2Vm5fHo59sTLW4KPCRxTiUSYNZZjIqy2p3BlJiJ4dZrrIvu+ac5PS4Xkn/KxO
 vNqHboLok7Jwcs/BCftQM/Si5DtndH0c4QFBA9l4se7c6r2v+t4OH6V6t
X-Gm-Gg: AZuq6aLb5wZb8pcqRa2WHLCuCkfEnBr/an8+lerIIutsAEKeFtvhUKES3FXKRwh/hhx
 6aaZFhd0lFTgYrPOwOpVzIGpBHQCA85aBna5pUDi2QfIylK92VV2P7wJ9c2GTCFLdMO1pcgNFgq
 M/nafcgK/G1iJjbMY/nhb/2joIf/05vRLcEtPjxCMJ0XQ+ZZvWpGsdeG8V0OVhb+mSZlEYjZMIY
 vmI4rYld6aPIIumZ2tRBwPvqXknLT6Dq3QLpxku05k5+QdqKrl6NMeY9yDPueMRa/8EKJUT4nXU
 Qd5vAxmuAVJql027lUBQGxMemCTai/alvvfQqcSkhhHx1/dhvS9mD4iwAip/O1XMQiFZ1JGbRjg
 nsdJeWzXWG0ILiAxBUzldbpnDRERt9UaXDVhk764qWhzhS/Z4AZCx2Lw51XcUeA0s4q26froUVh
 SQHn83
X-Received: by 2002:a5d:5f53:0:b0:436:3536:f694 with SMTP id
 ffacd0b85a97d-43958e0e72amr3221025f8f.22.1771421223990; 
 Wed, 18 Feb 2026 05:27:03 -0800 (PST)
X-Received: by 2002:a5d:5f53:0:b0:436:3536:f694 with SMTP id
 ffacd0b85a97d-43958e0e72amr3220983f8f.22.1771421223529; 
 Wed, 18 Feb 2026 05:27:03 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5d156sm45786805f8f.5.2026.02.18.05.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:02 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 08/24] fuse: Set direct_io and parallel_direct_writes
Date: Wed, 18 Feb 2026 14:26:17 +0100
Message-ID: <20260218132633.29748-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In fuse_open(), set these flags:
- direct_io: We probably actually don't want to have the host page cache
  be used for our exports.  QEMU block exports are supposed to represent
  the image as-is (and thus potentially changing).
  This causes a change in iotest 308's reference output.

- parallel_direct_writes: We can (now) cope with parallel writes, so we
  should set this flag.  For some reason, it doesn't seem to make an
  actual performance difference with libfuse, but it does make a
  difference without it, so let's set it.
  (See "fuse: Copy write buffer content before polling" for further
  discussion.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c        | 2 ++
 tests/qemu-iotests/308.out | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0422cf4b8a..d0e3c6bf61 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -582,6 +582,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
 static void fuse_open(fuse_req_t req, fuse_ino_t inode,
                       struct fuse_file_info *fi)
 {
+    fi->direct_io = true;
+    fi->parallel_direct_writes = true;
     fuse_reply_open(req, fi);
 }
 
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index aa96faab6d..2d7a38d63d 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -131,7 +131,7 @@ wrote 65536/65536 bytes at offset 1048576
 
 --- Try growing non-growable export ---
 (OK: Lengths of export and original are the same)
-dd: error writing 'TEST_DIR/t.IMGFMT.fuse': Input/output error
+dd: error writing 'TEST_DIR/t.IMGFMT.fuse': No space left on device
 1+0 records in
 0+0 records out
 
-- 
2.53.0


