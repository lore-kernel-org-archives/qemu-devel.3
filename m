Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6D5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzTu-0003Sf-7a; Tue, 28 May 2024 12:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sBzTs-0003Rx-9s
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sBzTq-0001iO-NL
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716912917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u+6lTdlCQLY9t7njyE3yYhePUQD+Jxl4FSkDW07mqxQ=;
 b=fAT1yO89qYV8pxfi59fSBW3gSohP6Vw1hv2zw7c/STub6BkAQL3aFVCXhuJRskfuT11oE1
 Ev5Ci8MNLfMuYknK+bGf3LdSHginO65D6tpt3+nd29D9t7RNt/TrYbFq2p3CA0MAPorZtI
 qx1dhIGKthaVbeqo7LJzWTaV+StfWhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-FCEzWZLoMbyyJQdnyHMoLg-1; Tue, 28 May 2024 12:15:15 -0400
X-MC-Unique: FCEzWZLoMbyyJQdnyHMoLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42C13800169
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 16:15:15 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9D2C15BB1;
 Tue, 28 May 2024 16:15:14 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH 0/3] backends/hostmem: Round up memory size for qemu_madvise()
 and mbind()
Date: Tue, 28 May 2024 18:15:06 +0200
Message-ID: <cover.1716912651.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a resurrection of the following old patch of mine:

https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg05536.html

You could say it's a v2 and here's what changed since v1:
- qemu_madvise() is fixed in case posix_madvise() is used
- Warnings are reported in case of qemu_madvise() failure
- Size is rounded up in case of live change of corresponding attributes
  too

Michal Privoznik (3):
  osdep: Make qemu_madvise() to set errno in all cases
  backends/hostmem: Warn on qemu_madvise() failures
  backends/hostmem: Round up memory size for qemu_madvise() and mbind()

 backends/hostmem.c | 38 ++++++++++++++++++++++++++++++--------
 util/osdep.c       |  7 ++++++-
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.44.1


