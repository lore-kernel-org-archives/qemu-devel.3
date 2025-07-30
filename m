Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5754BC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 13:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh6gY-0006eS-4O; Wed, 30 Jul 2025 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0Wc-0002fc-Kp
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:54 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0Wa-00042P-Dy
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Cc8WroKDvyi+rKvxiv9LDaIj76hb4Z/hp4JgZMFCEmU=; b=eFDDcRQq4XFfJ7Ma4AZbBniFMB
 n7reLexKQlwOwzElHlF66lK79EQLxbzAcfnr1yT11ln4OvkEKCjTMm4e6OeO7ZkcXqHt1ywzBtmSY
 /9o41ooGsIDNoP5+vjRc9EV8fAQza1kZ/O2DLt++N1D0KEK0sQYi6+pZSWB7icCAhthtP1KJDOwa3
 iQi/Pa35cUWLW1xS79IVWjfxI/5dDs6P1C5zfCrHG7gnTwhIB8JEMOdAHEgezXLWNuilbEB2n285n
 YNMjrXRbUBRmNcQBMlU1QxJh/j2NkI0flzThFDAiSmR0XCVkxl1jOamZ4J/GfyKq0h3CSPdTsGmIm
 BavOXp7w==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uh0WO-005nOk-0l; Wed, 30 Jul 2025 08:42:40 +0200
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH 0/5] contrib/plugins/hotblocks: Minor bug fixes and add limit
 argument
Date: Wed, 30 Jul 2025 07:41:38 +0100
Message-ID: <cover.1753857212.git.asb@igalia.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Jul 2025 09:05:34 -0400
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

This series contains one minor feature addition and a series of small
bugfixes/improvements. The addition that motivates the submission is to add a
limit argument for the hotblocks plugin, allowing you to control how many
blocks are printed rather than being hardcoded to the 20 most executed.
Setting limit=0 and dumping information about all executed blocks is
incredibly helpful for an analysis script I have downstream.

This is my first contribution to QEMU. I've attempted to follow all of the
guidance in the "Submitting a Patch" guide, but apologies if I missed
anything.

Alex Bradbury (5):
  contrib/plugins/hotblocks: Correctly free sorted counts list
  contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
    blocks
  contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
    PRId64
  docs/about/emulation: Add documentation for hotblocks plugin arguments
  contrib/plugins/hotblocks: Allow limit to be set as a command line
    argument

 contrib/plugins/hotblocks.c | 20 ++++++++++++++------
 docs/about/emulation.rst    | 12 ++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.50.1


