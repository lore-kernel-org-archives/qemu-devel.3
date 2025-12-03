Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC314D15D81
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoXO-0006NX-Vv; Wed, 03 Dec 2025 10:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXM-0006Mt-SL
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXK-0002g3-L9
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764774776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QSSvGaOHzLrn0VUmURLHM/pJaNUbuj3FTvQ8aiMLuuk=;
 b=iLuW4liyjtkK5/fE+SgFAgyANSDuIr8FCTicQoz9F7sTgT5jNCzQaY0rCDF+LOtXz2UXBl
 1D/Sb7wA9jZ4EQFcg8m20/xs5FaNFQzPNw4BJQSt/RjBbJtWjbD7TkoPrNBPmm/VcX1laH
 asa2/lXE7ipjsF53yvkPlnIGD4+K850=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-DNrNRs2yPqaAhF3iB11wHA-1; Wed,
 03 Dec 2025 10:12:55 -0500
X-MC-Unique: DNrNRs2yPqaAhF3iB11wHA-1
X-Mimecast-MFC-AGG-ID: DNrNRs2yPqaAhF3iB11wHA_1764774774
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEDEC195608A
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 15:12:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A9F5180045B; Wed,  3 Dec 2025 15:12:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/6] vfio queue
Date: Wed,  3 Dec 2025 16:12:43 +0100
Message-ID: <20251203151249.2707207-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 05f36f7c0512c40a8f929e8ba2ca3c825198f234:

  Update version for v10.2.0-rc2 release (2025-12-02 20:09:51 -0800)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20251203

for you to fetch changes up to 23c586abf2e12843894189c4742c8ea55c594cd5:

  vfio-user: recycle msg on failure (2025-12-03 15:07:47 +0100)

----------------------------------------------------------------
vfio queue:

* Fix vfio-user issues reported by Coverity
* Update vfio-user documentation

----------------------------------------------------------------
John Levon (6):
      docs/interop/vfio-user: update protocol specification
      vfio-user: simplify vfio_user_process()
      vfio-user: clarify partial message handling
      vfio-user: refactor out header handling
      vfio-user: simplify vfio_user_recv_one()
      vfio-user: recycle msg on failure

 docs/interop/vfio-user.rst | 554 +++++++++++++++++++++++++++++++++++++++++----
 hw/vfio-user/proxy.c       | 206 +++++++++--------
 2 files changed, 620 insertions(+), 140 deletions(-)


