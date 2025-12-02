Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0D6D12687
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 23:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQZSh-0005N2-P6; Tue, 02 Dec 2025 18:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSf-0005Mn-BW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:09 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSd-0005Xt-2K
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ij05XewpBbCbn2Ccjv0QrGhWbCDg3G/nGzZ3nHyRsJU=; b=DOvxju4d04qwFOQR9Cwy4SAEIX
 xf5Sve+QjajjOr7eU6Y2qAq6XfijBF3YM5R+R4pG8WEh47i4jxEJhfd6FHui6jkA4HnYmwAQAdot0
 fK3L0YTsAnnpME0Y1got6hW71l4xoY6P7vLS+bgiuKXYe6AMMJZa7NCpfaU16LQNan83i+Uvk0S5v
 V26Thj3d7w0qoMTc4VO4Igthug+vtc9p7rMfibgtV7qjfzUeQ68AlT/6s9RNWygFx1Q3XW+gT2NC+
 KJwqFRaMBgm8+DSqQzUu00+yPoeuyTPFkGJjd3EKmuW1HaK6Rr2+xlFhYLmB7rs3QdkOY3r8TbjWX
 86pzYNrQ==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vQZST-0082ga-9Z; Wed, 03 Dec 2025 00:06:57 +0100
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH v2 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
Date: Tue,  2 Dec 2025 23:05:53 +0000
Message-ID: <cover.1764716538.git.asb@igalia.com>
X-Mailer: git-send-email 2.52.0
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

This is a resend of my previous patchset which unfortunately seems not to have
been applied (see
<https://lore.kernel.org/qemu-devel/cover.1753857212.git.asb@igalia.com/).
I've rebased on current HEAD, checked it works as expected, and added
Reviewed-by tags to the patches, which all received review.

Repeating the summary from last time:

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
2.52.0


