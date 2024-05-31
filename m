Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBBAC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3uP-000072-RU; Fri, 31 May 2024 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD3uI-00005S-UU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD3uD-0005WY-M9
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717168251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K4oEwtUX0pMFdgjjI7HtiL04Z8IgZg383kucjqMhKJk=;
 b=FUJEwVjDkRZjdnjt6ami09ICdbz4XOBsizvcCBij7XeJXjHCVmvyZQx1awfFtgyq0omres
 BK5sqrAwQP3DTGg9GAb4MJ/9AonraVuYmMCrFr7NgicnbsGB8O7p0aR1TLgSi+w1nUz9XV
 0N95qiTkHp9nD/vHgyFJqWlIrbtft1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-oPiUVEzGPWiXpBRRMf0cNA-1; Fri, 31 May 2024 11:10:49 -0400
X-MC-Unique: oPiUVEzGPWiXpBRRMf0cNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4E9185A780
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:10:49 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 364BC3C27
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:10:49 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] backends/hostmem: Report more errors on failures
Date: Fri, 31 May 2024 17:10:43 +0200
Message-ID: <cover.1717168113.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

v3 of:

diff to v2:
- In 1/4 I've reworked setting errno because of how posix_madvise()
  behaves on Darwin,
- In 4/4 I'm now using size_to_str() to print the page size, oh, and the
  error message now contains the backend name too.

Michal Privoznik (4):
  osdep: Make qemu_madvise() to set errno in all cases
  osdep: Make qemu_madvise() return ENOSYS on unsupported OSes
  backends/hostmem: Report error on qemu_madvise() failures
  backends/hostmem: Report error when memory size is unaligned

 backends/hostmem.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 util/osdep.c       | 16 ++++++++++++++--
 2 files changed, 52 insertions(+), 10 deletions(-)

-- 
2.44.1


