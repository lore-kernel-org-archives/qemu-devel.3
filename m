Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC304C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 16:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scSKE-0000TK-Ql; Fri, 09 Aug 2024 12:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scSKD-0000S6-1j
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scSKB-0007kj-4O
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723220320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0UsGVevPExuHlVwnG4edp1L381594GSW3WH8eKPvWEY=;
 b=DVG3wuZ1+VKfFzrUOMsa2rjAjErC2EMFIRh0izh9RKyqzXrrZV3J/9eoZFsMMyPej3wzk2
 BeBO5oq7qTSg9887fSycg/hWS/kCj313IkftrvwyXi0hDDB6uHUrr4C1aqIa8mfq1oaPdZ
 u0ctmsmn7UUHEZeRd1eBYqtWBg9gFa4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-X3sV1pboPdefzf1VFjml1A-1; Fri,
 09 Aug 2024 12:18:38 -0400
X-MC-Unique: X3sV1pboPdefzf1VFjml1A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E7801944B3B; Fri,  9 Aug 2024 16:18:34 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EE6D1955F2C; Fri,  9 Aug 2024 16:18:30 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH for-9.2 0/2] NBD: tune handshake timeout
Date: Fri,  9 Aug 2024 11:14:24 -0500
Message-ID: <20240809161828.1342831-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Originally posted as the tail part of this v4 series:
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg01154.html

but not deemed necessary for 9.1 as it is a feature addition that was
not proposed before soft freeze (even if the point of the feature is
to enable interop testing to revert back to 9.0 behavior allowing for
unlimited time when debuging an NBD_OPT interchange under gdb).

As part of closing out the CVE, where the v4 patches used
handshake_limit, the actual pull request used handshake_max_secs (a
bit more self-documenting); I rebased that rename into the QMP code,
but prefer to keep the qemu-nbd command-line spelling shorter.  But
I'm open to any arguments on why the names should be the same, or on
any other better spellings to expose to the user.

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
2.46.0


