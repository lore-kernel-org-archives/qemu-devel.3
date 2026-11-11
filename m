Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB193606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KzUSvcrR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Mw-00031a-4C; Wed, 11 Nov 2026 07:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mo-000302-OT
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mm-0000a5-Jk
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kZHDLdcMPQF2c+X/8JIDsOlxf3Jaf21/H3YaEkZ+pQ8=;
 b=KzUSvcrRTlMIKSZNyQ5Ge2pyu5fDHmY/FvQ9VP52DylqvnSE2zra/SYNnmL0G4uvhvFrJC
 qDavnaUbv68QRHLTChmxiE9XNQL/7CmlluZU6blwSHoON7UnkajYVFebyOudIC33frfR19
 SmZ+4ED6NWc1OPbj3cIhgUjAy7a4Rdw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-JrRaI3zYMLKjBrSmwcgwBA-1; Wed,
 11 Nov 2026 07:23:46 -0500
X-MC-Unique: JrRaI3zYMLKjBrSmwcgwBA-1
X-Mimecast-MFC-AGG-ID: JrRaI3zYMLKjBrSmwcgwBA_1794399825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF77519540C2; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 928D31956087; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3716821E6A04; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 0/7] backends/hostmem: Make QOM types and properties
 unconditional
Date: Wed, 11 Nov 2026 13:23:35 +0100
Message-ID: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I recently checked qom introspection for dangling child and link
types, and found one from sgx-epc to memory-backend-epc.  I reported

    Subject: qemu-system-x86_64 appears to have sgx-epc, but not memory-backend-epc
    Date: Thu, 22 Oct 2026 14:58:16 +0200
    Message-ID: <87zew5j3iv.fsf@pond.sub.org>

Daniel identified why: we register QOM type "memory-backend-epc"
conditionally.  He called that "rather dubious".  We found similar
conditional registration of "hostmem-memfd".

This series makes them both unconditional, along with a two class
properties.  It also improves error reporting.

Markus Armbruster (7):
  backends/hostmem: Drop redundant validation of property "size"
  backends/hostmem-file: Drop useless validation of property "mem-path"
  backends/hostmem: Improve error reporting when method alloc() fails
  backends/hostmem-epc: Register QOM type unconditionally
  backends/hostmem-memfd: Register QOM type unconditionally
  util/memfd: Improve error message when memfd_create() fails
  backends/hostmem-memfd: Add huge TLB properties unconditionally

 backends/hostmem-epc.c   | 12 +-----------
 backends/hostmem-file.c  |  9 ---------
 backends/hostmem-memfd.c | 35 +++++++++++++----------------------
 backends/hostmem-ram.c   |  5 -----
 backends/hostmem-shm.c   |  7 +------
 backends/hostmem.c       |  3 +++
 util/memfd.c             |  5 ++++-
 7 files changed, 22 insertions(+), 54 deletions(-)

-- 
2.55.0


