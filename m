Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10A0C83026
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 04:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVjKU-0003TZ-4Q; Sun, 29 Jun 2025 00:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVjKQ-0003Si-HO
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 00:07:42 -0400
Received: from che.mayfirst.org ([2001:470:1:116::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVjKK-0003h3-UH
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 00:07:41 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; s=2019;
 t=1751170054; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=gz5jYZXnCsGywPkWD5TA9AWcuJJGyFu9ZSh92vhZbK4=;
 b=q20M50+A2drCvHhbP37GUaf2YLO/+SLFGec6Cfk8JSPRNVB/H//nKF91FjOlhJGTE5SAG
 xob2cvFQUiXMEdACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net;
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1751170054; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=gz5jYZXnCsGywPkWD5TA9AWcuJJGyFu9ZSh92vhZbK4=;
 b=GNDSBqioRPR02agltaIzVdZrBOcVIJsWsK7FVspP07jzAyxlP+6cIJDh7FF1vqEZWTIJT
 W8ObSvxbQs92mg8p7nI8ypJVAyus2RGdcnbtT8sbEiJvboZTezvuNio18pE1v9kJT4o7gW+
 bI4sW8pjn9LOTKPo1VenwBegEMMyZx9CmvJuPPw7oha6Zm2vOXGXvdvVk1GhniFeDSRs/Jy
 3cXVt/D4MfAeJ7BVxNH3jEPZFZks238MfqiGmHQxDxwDAsFuLrRWeoLC1Wwp8yaEJJK38Qc
 PcnMZssfwR2AzdAiwCdoUIi36onlL6/dhT0s72RIK5H3iiTK8xjk5k/3uYxA==
Received: from fifthhorseman.net (lair.fifthhorseman.net [108.58.6.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by che.mayfirst.org (Postfix) with ESMTPSA id 8EA1DF9C6;
 Sun, 29 Jun 2025 00:07:34 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
 id BFD6713F6B3; Sun, 29 Jun 2025 00:07:25 -0400 (EDT)
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: qemu-devel@nongnu.org
Cc: dkg@fifthhorseman.net
Subject: Clean up (v2) of Socket Activation series
Date: Sun, 29 Jun 2025 00:03:58 -0400
Message-ID: <20250629040723.1696325-1-dkg@fifthhorseman.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627180331.1370235-1-dkg@fifthhorseman.net>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:470:1:116::7;
 envelope-from=dkg@fifthhorseman.net; helo=che.mayfirst.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


This is a clean-up of the code I offered yesterday to improve socket
activation for qemu.  It resolves a couple dumb bugs i had initially
introduced, and reduces the line-width of some of the new code.

This is addressing https://gitlab.com/qemu-project/qemu/-/issues/3011

I welcome reviews and feedback!

  --dkg

