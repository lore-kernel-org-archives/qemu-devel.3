Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A849C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4uk-0001ZV-Sp; Mon, 03 Feb 2025 17:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf4ui-0001VV-RS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf4uh-0002JZ-Bz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738621649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6n84EVl+QathsgycT1XNfNmLRO0wbFQY8xOrcR50UYU=;
 b=WQjITAneaC5cGt9e3aLpWUU50JWn5N0DEVH7P1fKghIKe7Jd7jWqELrC5JVMxwVetPAHZX
 Hc+0doGy0ssWJrKIqGZZdOH5hjiWtKciM8E4jUrwa8EO/1k/tJ1OaTo4jKESbfjKOyezAZ
 lJrZIXe/g0WbQx2dReNxYBpzqXiNaF8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-wj8pAB15Plap_zaXAffmaQ-1; Mon,
 03 Feb 2025 17:27:27 -0500
X-MC-Unique: wj8pAB15Plap_zaXAffmaQ-1
X-Mimecast-MFC-AGG-ID: wj8pAB15Plap_zaXAffmaQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E874719560BB; Mon,  3 Feb 2025 22:27:25 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.73])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D8D419560AD; Mon,  3 Feb 2025 22:27:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Subject: [PATCH 0/2] nbd: Allow debugging tuning of handshake limit
Date: Mon,  3 Feb 2025 16:26:05 -0600
Message-ID: <20250203222722.650694-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

Reviving a patch that has been sitting in my tree for a while.  It's
mostly useful for low-level integration testing (such as debugging
libnbd as an NBD client).

Eric Blake (2):
  qemu-nbd: Allow users to adjust handshake limit
  nbd/server: Allow users to adjust handshake limit in QMP

 docs/tools/qemu-nbd.rst        |  5 +++++
 qapi/block-export.json         | 10 +++++++++
 include/block/nbd.h            |  6 ++---
 block/monitor/block-hmp-cmds.c |  4 ++--
 blockdev-nbd.c                 | 26 ++++++++++++++-------
 qemu-nbd.c                     | 41 +++++++++++++++++++++-------------
 6 files changed, 64 insertions(+), 28 deletions(-)

-- 
2.48.1


