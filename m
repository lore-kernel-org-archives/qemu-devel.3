Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B55C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 01:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZhPO-0000BI-Cu; Thu, 01 Aug 2024 21:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPM-00009q-HO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPK-0001wf-G8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722563317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9uFJRE9LT2GDABzWrPy+vqa1ZqrveZQtNa1KSxb+l1U=;
 b=jEAXy3uqWP0B1HY9JxvRuctlwncHY6k5enfOJN1SIEJEZJn8nK6pQm3wjuf+or97ZHQfEJ
 zy2wXHf4eJ30hAkF09B+Gw8Xmk5XXqHsmSp16MmigXooqXNvcqj/Dm8eWn/UgsP5aMGGSd
 Fh8GoWpd3zMOPJLZei0BMUWUbiXPoWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-rSigsGCbPXW5Dgddu2Zjmg-1; Thu,
 01 Aug 2024 21:48:34 -0400
X-MC-Unique: rSigsGCbPXW5Dgddu2Zjmg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 270941955D4D; Fri,  2 Aug 2024 01:48:33 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B356E19560AA; Fri,  2 Aug 2024 01:48:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v2 for-9.1 0/3] Avoid NBD crash on nbd-server-stop
Date: Thu,  1 Aug 2024 20:32:05 -0500
Message-ID: <20240802014824.1906798-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg01609.html

Since then, I've applied with Red Hat to get a CVE assigned (a client
not using TLS should never be able to cause the destination qemu to
crash during live storage migration), and will update to include that
number once it is assigned.  But since the issue has already been on
list, I see no need to further embargo this patch attempt.

I've also concluded from my audit that Alexander's initial hunch was
right: there's nothing simple we can do to prevent qio coroutines from
reaching our callback into nbd_blockdev_client_closed() after a QMP
nbd-server-stop (I could not find a graceful way to close the qio
channel and then forcefully wait for the coroutine to finish), so that
function has to be prepared to handle late clients, but the fix in
patch 1 is a bit more involved than Alexander's attempt since we must
also not corrupt a subsequent nbd-server-start.  Patch 2 is
insufficient on its own to prevent the problems, but reduces the
amount of time that a client can hang on to server resources after
nbd-server-stop (the client will see EPIPE rather than being able to
carry on a prolonged NBD_OPT_* conversation).

[I'm also aware of some Coverity analysis pointing to potential race
conditions in block/nbd.c; if those need fixes, I hope to also post
patches for those in time for inclusion in the same pull request that
picks up this series]

Eric Blake (3):
  nbd: CVE-XXX: Use cookie to track generation of nbd-server
  nbd: CVE-XXX: Close stray client sockets at server shutdown
  nbd: Minor style fixes

 include/block/nbd.h |  3 ++-
 blockdev-nbd.c      | 39 ++++++++++++++++++++++++++++++++++-----
 nbd/server.c        | 14 +++++++++-----
 qemu-nbd.c          |  8 +++++---
 4 files changed, 50 insertions(+), 14 deletions(-)

-- 
2.45.2


