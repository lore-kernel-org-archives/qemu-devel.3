Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E839AC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9W1b-0000Gc-ER; Wed, 23 Sep 2026 19:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1Y-0000Ef-TB; Wed, 23 Sep 2026 19:05:12 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1X-0002UK-2O; Wed, 23 Sep 2026 19:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=TtHbwOG
 AO+XX41MhpULuGYafjkQI92WiMG3vjlEpskUMMi/97Wb0tr8VyNLJQauiG7jc0gzLtXXmV
 Y6Vi/H6Ko99kRdcEIRTJd8jIcpU5sxAygBxrHGSACt6tXfCKIkIGc10iVtCHUy4ny/u1U3
 uyhwlR4vEZwUCzfjQnOp6nvvfXDGP2Wy1lVk4xP84Gc040cJrpRP863zo9CSkBY27I1FR1
 zZfw6FHE2r2L3SiehENlzeYN+ZdbND3WCiFOux/gKQowzD99ZocKZx62t7XGwz0lyVTKzn
 xiv/S+82BmD7pVP133xmJrNui71gUv9MmyAjmIeSxYhLS1LSgAr/I9w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=M
 km+KyibtmSV4IoXqwCl40aRBmyXZMIQvf3Uhy/TitY=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=JmT4p7BeEzOrUPDC
 mv+KrdtGXEkKrnOfuhxFGNsT7Ii+m/xkyelXHWKDZrYobJDpwPqgylEgDfcGzor4Kmzlvw
 g/SYGYmQU3P7pSD/iuext0N1B7LoASqPutbE1HXOUQeTlLcINPI0cpI+6ft4fMA6e3lh4e
 UzuWnQsA9NlLa2tuKPdaBBVeUOUg7qiarpzd3L64DP0lV3jSyHM5VCwlNwA80O6/fjwnWO
 KcciqLaoK5l5mnZ+FqYeU6fWThufM1PJNmh2k0Qc0LNT7iSTTtCFFfsjw+c1zjSTJTkw7p
 B/wCpGF3QJC3TDheW9QH8rxs17kWTAMhc77STLlHiwXnxQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=d0fqNH94; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=zkDOJAID;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Mkm+Kyib
 tmSV4IoXqwCl40aRBmyXZMIQvf3Uhy/TitY=; h=date:subject:cc:to:from;
 d=korins.ky; b=d0fqNH94cfhkcwKKcpF2FykUByC88Ywrufu8aK7B/c8M/pPtFOqfPJS
 TJcHb+ESywPGE2qedzPncMhHyf30J6DxVE87Xa3fRkJ/omtVdiZx32wYER/kLCIQKipYs5
 WKa/1b6k0b3wkD7tORD0jEayUjEY0TWhIYqFUzz7etBtvK/g/A6QaoIzJ6wF/aGKz8knc1
 UaUmxtpTKwXlNHW+XjT2yzEq9j7ajOdbyC+cru1mor7qpfTzMy+JJxbXEwRjhktKEkH2kM
 S++GXt9/XYcr+zZcpjjP2gbLLSZrjLsXscvFKJmvtikPdi/E8W4McXnb+c+yMKm3z2tQz9
 2WNLh6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Mkm+KyibtmSV4IoXqwCl40aRBmyXZMIQvf3Uhy/TitY=; h=date:subject:cc:to:
 from; d=korins.ky; b=zkDOJAIDJsuwRxzWOvEsMh99IRjVkF0rv0WbRWneOIyaRmySR
 B+IMbGzolu2b4VC6+RWEn1jpjb5LZEz0tIvDA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 5e0ce5d8
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 24 Sep 2026 01:05:05 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 34386f32;
 Thu, 24 Sep 2026 01:05:03 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 0/5] mac99: Boot OpenBSD/macppc
Date: Thu, 24 Sep 2026 01:03:06 +0200
Message-ID: <20260923230452.3765-1-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Greetings,

This is the second version of patch series to boot OpenBSD/macppc.

OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
reassert an interrupt still masked by CTPR; the edge triggered
decrementer does not raise on zero; successful CUDA ADB replies omit the
original command; and the fixed CUDA shift register delay can stretch
packet delivery past the guest timeout on hosts with coarse timers.

This series corrects these four behaviours and adds a functional test
which boots the official OpenBSD 7.9 macppc CD to the installer prompt.

-- 
wbr, Kirill


