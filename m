Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C698BC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHltN-0001de-04; Wed, 21 May 2025 12:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHlt8-0001TX-To
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:01:54 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHlt6-0000WB-JI
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=enlFxh323jZpljGCPePiujgkIPEkYgD+LM8rYSRQpHI=; b=3JRnwx/c4fNvgSqDbHcziW13JZ
 UAYnJW7m1juc/N49snwNRjLxIXjD4eSCdLvjUczIqMzN7aXPmkSrUlaKauiBaF7ZcDQZrrT+2GOpL
 sqLoiZo1gBKrhDNvy4pCJRlQo9ByLmo4ex5LcQk2Hd+WCrRM7k9nTt1p+2/WffGF7iGBkSWP+Y04R
 fqIZ70UWkYzLB8kJg3Q9Y/v61GAo2afn2BBTrAk36dzdC+zmOezqAJKzyJoRU3Qgki+Xhv1iCp5DC
 7lRa9Obfb9+CTPiW1rl2Lc4xHptXzeWeVDBKRKxCGCPZ2C060lB5jkaPmfP4pw4L2JKeLirmJbAGI
 kHnXyX2w==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uHlt1-001e7G-Cc; Wed, 21 May 2025 17:01:43 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uHlt1-000000006R6-0gWr;
 Wed, 21 May 2025 17:01:43 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 qemu-devel@nongnu.org
Cc: ben.dooks@codethink.co.uk
Subject: RFC: lowrisc_eth network model
Date: Wed, 21 May 2025 17:01:39 +0100
Message-Id: <20250521160142.24715-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As part of the CVA6 project we're working on we did an
ethernet implementation as part of adding a machine to
emulate the FPGA build.

As part of this, we've done an MDIO bit-bang decoder
which might be useful (although we can get by with
just the ethernet MAC part)



