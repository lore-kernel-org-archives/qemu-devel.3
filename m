Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B9C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcdr-0006lB-LI; Tue, 01 Apr 2025 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcdp-0006kh-Oe
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcdo-0005vf-3Z
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743517859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+kfLnQBglmM5+wKiuX1vF4W3tlfkGTam78m8db//oIk=;
 b=We46RPkGi+NhLRYJb6r9eQgHPVtdT8C0Hz9hPGTBeQUttDAaYfpoBPW0NewKlo3uFApC37
 2Kqzwd/kFiyVWQnHcuOZLNio+sV2pd/7/5lC5Yy8ShqK4eugTX7ebE1HuoTosLh7soc8r+
 4X+yOoDxf6Kt7uwUvcyMzJMvws09Z3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-3Wg9vijgMcaQTFWIgGuZ5A-1; Tue,
 01 Apr 2025 10:30:57 -0400
X-MC-Unique: 3Wg9vijgMcaQTFWIgGuZ5A-1
X-Mimecast-MFC-AGG-ID: 3Wg9vijgMcaQTFWIgGuZ5A_1743517856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 803C8180AB1C; Tue,  1 Apr 2025 14:30:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7544180094A; Tue,  1 Apr 2025 14:30:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, surajshirvankar@gmail.com,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/3] [RESEND] block: unify block and fdmon io_uring
Date: Tue,  1 Apr 2025 10:27:18 -0400
Message-ID: <20250401142721.280287-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For some reason the patch series didn't reach the mailing list. Resending.

Every AioContext has an io_uring context for file descriptor monitoring. In
addition, block/io_uring.c also has an io_uring context for disk I/O. This
patch series eliminates the extra io_uring context so that AioContext has a
single io_uring context.

Patch 2 introduces the aio_add_sqe() API for submitting custom io_uring SQEs.
Patch 3 then replaces its io_uring context with the aio_add_sqe() API so that
disk I/O requests share the AioContext's io_uring context.

I will post performance results when they become available.

Based-on: 20250326183340.1010531-1-stefanha@redhat.com

Stefan Hajnoczi (3):
  aio-posix: treat io_uring setup failure as fatal
  aio-posix: add aio_add_sqe() API for user-defined io_uring requests
  block/io_uring: use aio_add_sqe()

 include/block/aio.h     |  74 +++++-
 include/block/raw-aio.h |   5 -
 util/aio-posix.h        |   1 +
 block/file-posix.c      |  25 +-
 block/io_uring.c        | 489 ++++++++++------------------------------
 stubs/io_uring.c        |  32 ---
 util/aio-posix.c        |   9 +
 util/async.c            |  35 ---
 util/fdmon-io_uring.c   | 155 +++++++++----
 block/trace-events      |  12 +-
 stubs/meson.build       |   3 -
 util/trace-events       |   4 +
 12 files changed, 316 insertions(+), 528 deletions(-)
 delete mode 100644 stubs/io_uring.c

-- 
2.49.0


