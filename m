Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95764C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFA9G-0005z3-P9; Wed, 14 May 2025 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFA9E-0005yc-LU
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFA9C-0001LU-Qb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747221576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uN4tPGZisgSwpEGNWY0lhw6XHa9JjQdTbYnpdKXfNpw=;
 b=huAzNh29DQN3/GslsVWpw7peNKCkDdkZxK4m0laB7YKB+p4di3QpkleGYCVv890k22qvRe
 G8EwUbSA1PRLjKX89nTxJRfmGBc6OnIN4R7h02Lb5cSl5lkhPnpyKkaWgJX1fjsi0aw2T3
 49wYHOTxJzHidwVpdHcxet8NNDuiP3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-uAV_C1qlPg-AMOTyDM270g-1; Wed,
 14 May 2025 07:19:35 -0400
X-MC-Unique: uAV_C1qlPg-AMOTyDM270g-1
X-Mimecast-MFC-AGG-ID: uAV_C1qlPg-AMOTyDM270g_1747221574
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D7691800261
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 11:19:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.147])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E75C119560A3; Wed, 14 May 2025 11:19:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/3] ui/vnc: fix some endian problems
Date: Wed, 14 May 2025 12:19:28 +0100
Message-ID: <20250514111931.1711390-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

This fixes some edge cases in endian handling in the VNC server. These
bugs are rarely going to be visible by default, since most servers will
negotiate encoding formats / framebuffer formats that avoid hitting
the problem scenarios.

In v2:

 - Rename 'client_bo' to 'client_endian' for reviewer clarity
 - Rename 'native' to 'native_endian' for code consistency

Daniel P. Berrangé (3):
  ui/vnc.c: replace big endian flag with byte order value
  ui/vnc: take account of client byte order in pixman format
  ui/vnc: fix tight palette pixel encoding for 8/16-bpp formats

 include/ui/qemu-pixman.h |  4 ++--
 ui/qemu-pixman.c         | 15 ++++++++-------
 ui/vnc-enc-tight.c       | 16 ++++++++++------
 ui/vnc-enc-zrle.c        |  2 +-
 ui/vnc-jobs.c            |  2 +-
 ui/vnc.c                 |  9 +++++----
 ui/vnc.h                 |  2 +-
 7 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.49.0


