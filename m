Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD651104C007
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HEW-000619-8R; Wed, 11 Mar 2026 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0HET-00060v-IP; Wed, 11 Mar 2026 06:56:06 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0HEQ-0002bX-Ca; Wed, 11 Mar 2026 06:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f50bQegETQT2t5Q4U1ezah3fUIIRzkMj9TH1D+bqLj8=; b=VpBD4zNMubLLab2mvY2CtT8zeb
 ZSBBDD83MMj1w8QwxRAbQpq7BAqaFCNG93N4zFbUSFpKYs7Fqt1aFvt2B07wS6ZGHyMbS8aYnIQ0O
 HgpCpHXldHAcepSUcQcqeltBHiFE+x7oqZWqT45fD6l4tFxHxHra9RxFbaJlkcEQwwKKRiUejbvJl
 A7AQreNMm6UNdZU5xvq6fcNDJUKMJN0tIeUNrjDv0IJ14v7R6UFYLj3ynjWgSvGoakcANN71AYV/P
 DePQ079IX54ytxUASfTU7tAsgGau9AvUlkQZtRvP08TxKtiKKRSn15E8Hc3/cycRHbS/LLjUGqpNX
 nyqzfBAA==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0HEG-00DR9H-T2; Wed, 11 Mar 2026 11:55:52 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1w0HEG-000000008sL-3Ax9;
 Wed, 11 Mar 2026 11:55:52 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>,
 Jorge Merlino <jorge.merlino@canonical.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH 0/1] throttle-group: Fix race condition in
 throttle_group_restart_queue()
Date: Wed, 11 Mar 2026 11:55:44 +0100
Message-ID: <cover.1773226379.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I haven't been able to test this but I believe that this is the cause
of the race condition.

Please test it carefully before applying it :-)

Regards,

Berto

Alberto Garcia (1):
  throttle-group: Fix race condition in throttle_group_restart_queue()

 block/throttle-groups.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.47.3


