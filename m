Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA1C52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbknO-0006uz-1l; Wed, 07 Aug 2024 13:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknM-0006tP-My
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknK-0000Qj-Tp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723052993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4TS7ZORWg48o1sVJT03VC1l5ZCwt1N1XlNM04+sEkuA=;
 b=SqyTNDhRcg0PsjLk1c3Khfv46NAw1fmTinZk9jzdZwlv/76Kgp6b8E1NA50ub1dJDbSGo8
 WeT5pIkR3xBlZ9YXVKwihPwA70Td5jOEEsIJqmHkGuJAjstLrQ9uABxgoCVhYy8MISKhM2
 Lfa61oXHN5wMWjInE3Y3UuSsT9/z9+s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-WGQye2X2Py2GbOQdfpRYpw-1; Wed,
 07 Aug 2024 13:49:49 -0400
X-MC-Unique: WGQye2X2Py2GbOQdfpRYpw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9567E1955F43; Wed,  7 Aug 2024 17:49:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E6F4300018D; Wed,  7 Aug 2024 17:49:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH for-9.1 v4 0/7] CVE-2024-7409
Date: Wed,  7 Aug 2024 12:43:26 -0500
Message-ID: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00818.html

since then:
 - re-add a minor patch from v2 (now patch 1)
 - refactor how the client opaque pointer is handled (patch 2)
 - add two new patches to prevent malicious clients from consuming
   inordinate resources: change the default max-connections from
   unlimited to capped at 100 (patch 3), and add code to kill any
   client that takes longer than 10 seconds after connect to reach
   NBD_OPT_GO (patch 4) [Dan]
 - squash the connection list handling into a single patch (5) [Dan]
 - two new additional patches for reverting back to 9.0 behavior for
   integration testing purposes; I'm okay if these last two miss 9.1

Eric Blake (7):
  nbd: Minor style fixes
  nbd/server: Plumb in new args to nbd_client_add()
  nbd/server: CVE-2024-7409: Change default max-connections to 100
  nbd/server: CVE-2024-7409: Drop non-negotiating clients
  nbd/server: CVE-2024-7409: Close stray client sockets at shutdown
  qemu-nbd: Allow users to adjust handshake limit
  nbd/server: Allow users to adjust handshake limit in QMP

 docs/tools/qemu-nbd.rst        |  5 +++
 qapi/block-export.json         | 18 +++++++---
 include/block/nbd.h            | 20 +++++++++--
 block/monitor/block-hmp-cmds.c |  3 +-
 blockdev-nbd.c                 | 62 +++++++++++++++++++++++++++++++---
 nbd/server.c                   | 51 +++++++++++++++++++++++++---
 qemu-nbd.c                     | 44 ++++++++++++++++--------
 nbd/trace-events               |  1 +
 8 files changed, 173 insertions(+), 31 deletions(-)

-- 
2.45.2


