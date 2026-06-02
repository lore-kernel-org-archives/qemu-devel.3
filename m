Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7730BCD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 23:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUYNs-00035B-E6; Tue, 02 Jun 2026 19:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNq-00034f-KM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:54 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNp-0008MX-5h
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:54 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 54A0462F2F;
 Tue, 02 Jun 2026 23:18:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com
 (100-101-141-32.trex-nlb.outbound.svc.cluster.local [100.101.141.32])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0982B62B1F;
 Tue, 02 Jun 2026 23:18:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Spot: 2b67ec0f0938dd5a_1780442331265_451508995
X-MC-Loop-Signature: 1780442331265:3454953683
X-MC-Ingress-Time: 1780442331265
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.141.32 (trex/7.1.5); Tue, 02 Jun 2026 23:18:51 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbY3GnCz107p;
 Tue,  2 Jun 2026 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1780442330;
 bh=2mGLD0wl25r1asFKim0hraTc613N8Kw+BsTweRKBvoo=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=FcJjX5X0SEZ34VRIKdic6J42a6aneyxDPcWIZuLrLcfLOu9x2HqxZp735KAVX1GaB
 zZ9jKZFtCLKYNWTuocCA4ckI/26B+JMuBi2JTfbMEWuGrNlhAIjNOBNuWa40tR6/oV
 Lf+kGtwQVi7LS6zrnaF0BQzUiVccy4kBILbyXGwxbiZzSJn3arl+J/eFU2RDE4NbqT
 yyIZPZsmf+CCjhzTWuCbIg1h4CAGcFHauOpz+PKB4iVTjM0XMNwYxUVRst2qClwb1g
 WDs5feDAUep6J84V18zL8spNw1pWqbCrr47BfKrd1hxU/Jlc6VY/pdRWe/Cj0JIlzf
 6WeHI0Lgnw54w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 3/4] tests/acpi/cxl: Update CEDT.cxl for host-only default
 restrictions
Date: Tue,  2 Jun 2026 16:18:05 -0700
Message-Id: <20260602231806.2469011-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602231806.2469011-1-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

With the default CXL Fixed Memory Window restrictions changed to
host-only coherency, update the expected CEDT to drop Device Coherent
and Back Invalidate from the advertised CFMWS restrictions.

[064h 0100 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[065h 0101 001h]                    Reserved : 00
[066h 0102 002h]                      Length : 0028
[068h 0104 004h]                    Reserved : 00000000
[06Ch 0108 008h]         Window base address : 0000000110000000
[074h 0116 008h]                 Window size : 0000000100000000
[07Ch 0124 001h]          Interleave Members : 00
[07Dh 0125 001h]       Interleave Arithmetic : 00
[07Eh 0126 002h]                    Reserved : 0000
[080h 0128 004h]                 Granularity : 00000005
[084h 0132 002h]                Restrictions : 000E # Changed from 002F
[086h 0134 002h]                       QtgId : 0000
[088h 0136 004h]                First Target : 0000000C

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/data/acpi/x86/q35/CEDT.cxl            | Bin 184 -> 184 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/x86/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
index c35f3882eee67aa5613af427234d1ccd196aa249..15e30750b4d963eeced503204a5213f755892b77 100644
GIT binary patch
delta 36
ncmdnNxPy_)+0`Xv2Ll5G<L8N7Rg8QSTh)2^fLtCRz6ZnrtV9Q{

delta 36
ncmdnNxPy_)+0`Xv2Ll5G<Hm_xRgC%*Th)2=fm|LSz6Znrs#OQB

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b4646b5b3147..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
2.39.5


