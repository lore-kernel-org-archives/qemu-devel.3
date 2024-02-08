Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6103C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXvRr-0003SD-9b; Wed, 07 Feb 2024 22:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXvRp-0003Rb-L2
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:51:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXvRl-0003IT-Uv
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707364292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FzjtqD9g1P0GMG1W2aQTqyesNTs9euHE6BFk6r+XxDc=;
 b=XBitjq27J+6gwLs3JHjb/zwyB3ocKPAZ2nOk4nuGRw3vF6yxvPF2JeNahg+js4Q21fdggm
 MEqTazg5D+ILc32Fx5xHPHQNw5et5kkhPXNQdwlNacQ+Anh8TdKkyS+EY9N4Im7OInVDVO
 HSKfVdXLzhOPG2YGz872qu/6YOXSi9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-tm-fnEsTMLiEYneP5-vqtw-1; Wed,
 07 Feb 2024 22:51:31 -0500
X-MC-Unique: tm-fnEsTMLiEYneP5-vqtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0103B1C0512D;
 Thu,  8 Feb 2024 03:51:31 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AFAC2026D08;
 Thu,  8 Feb 2024 03:51:27 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] migration: cleanup TLS channel referencing
Date: Thu,  8 Feb 2024 11:51:24 +0800
Message-ID: <20240208035126.370620-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Based-on: <20240208030528.368214-1-peterx@redhat.com>

The patchset is based on the latest migration pull request.  This is a
small cleanup patchset to firstly cleanup tls iochannel deref on error
paths, then further remove one unused var on yank if the cleanup applies.

These are exactly the same patch I attached here in this email reply:

https://lore.kernel.org/r/ZcLrF5HN920rUTSw@x1n

It's just a formal post, collecting one R-b from Fabiano in patch 2.

Please feel free to have a look, thanks.

Peter Xu (2):
  migration/multifd: Cleanup TLS iochannel referencing
  migration/multifd: Drop registered_yank

 migration/multifd.h |  2 --
 migration/multifd.c | 44 ++++++++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.43.0


