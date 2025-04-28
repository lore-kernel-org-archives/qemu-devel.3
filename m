Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE1EC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TbB-00035Y-6P; Mon, 28 Apr 2025 14:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9Tb5-00034l-Ie
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9Tb3-0002o5-7z
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745866371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ujA7JAZDH39O5GzbxLd9yBg9Zg19MmGiqtKzJ4j/R1E=;
 b=M4zONTbo1R1z36qjMMZO37uPjAyQIT2nHWw3a9kW4VTjjmPHdWAsc3A+PSv6e9CbucWdyV
 OcOE8IbW4rGffGMwq2SBpPRWyMxPdu4VQYxtV0nP0ZkYAu7v+P2TZhoVAiiOEIAQDtWfbf
 vwNp6TO2fcexWQafBobk4zEuzV8hABo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-kJuZwre6M7eIsYNW6gowuw-1; Mon,
 28 Apr 2025 14:52:49 -0400
X-MC-Unique: kJuZwre6M7eIsYNW6gowuw-1
X-Mimecast-MFC-AGG-ID: kJuZwre6M7eIsYNW6gowuw_1745866369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA8121955D8D; Mon, 28 Apr 2025 18:52:48 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DA51180047F; Mon, 28 Apr 2025 18:52:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Subject: [RFC PATCH v2 0/4] Revival of patches to implement NBD client
 multi-conn
Date: Mon, 28 Apr 2025 13:46:43 -0500
Message-ID: <20250428185246.492388-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

This is a rebase of patches that Rich Jones first posted in 2023:
https://lists.gnu.org/archive/html/qemu-devel/2023-03/msg03320.html

I'm still leaving the series in an RFC state while I'm trying to
improve the code to better play with all of the multi-queue changes in
the block layer in the meantime.  In my own testing, the patches as
presented here are not making any noticeable difference in qemu-img
convert to a local destination file (multi-conn=1 was not much
different than multi-conn=4, although I did validate that multiple
sockets were in use and the round robin code was working).  Other
benchmarks did show improvements, such as qemu convert targeting an
nbdkit server on a curl backend getting a 20% boost when I ramped
multi-conn from 1 to 4.

I have more patches on top of these to post to the list once I can get
benchmark numbers that make more sense.

Richard W.M. Jones (4):
  nbd: Add multi-conn option
  nbd: Split out block device state from underlying NBD connections
  nbd: Open multiple NBD connections if multi-conn is set
  nbd: Enable multi-conn using round-robin

 qapi/block-core.json |   8 +-
 block/coroutines.h   |   5 +-
 block/nbd.c          | 796 +++++++++++++++++++++++++------------------
 3 files changed, 479 insertions(+), 330 deletions(-)

-- 
2.49.0


