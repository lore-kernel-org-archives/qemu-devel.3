Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A482CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3QxE-0002Cj-HZ; Mon, 29 Sep 2025 23:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v3Qx4-00026r-IK
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:22:54 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v3Qwt-00028C-U7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:22:54 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 182597402BA;
 Tue, 30 Sep 2025 03:22:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com
 (100-111-81-207.trex-nlb.outbound.svc.cluster.local [100.111.81.207])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id B1262740EAA;
 Tue, 30 Sep 2025 03:22:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202556; a=rsa-sha256;
 cv=none;
 b=E7hDx0vGgmiqhFsI5gSArmieBCgEvhcWlzDzi0Dttj8LF7YFMp0PCNFWfxZnbq/IaloDWR
 ZOJ0UcLlzqgt2esnL47P5xdE1UH1z38X4pkU1AAOpQrgYqXLocTwcLYESLqyv+OmshXfDI
 FON/IvUN74dcvijiClsMygDEgDFqjUfMIaSgVCF/BQYiua9Ye6OX7p6HPBcTwpV424Rxf1
 UcDIVBwVO/J3utsTg2Opbrsjfj6/pM33qi0psHvBNLk721h5y+Nh+JA77pG0aq7tovDvGO
 hAo2D9WFP4DxkRMA7vNNACjZcCOim9xad+5OATZAz7GOd4IdZ+QnBI1KZFAUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1759202556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=JN0+GXZnlRcIr53jJwwDjRJANTOrAhEiLSRgFnV4B/8=;
 b=Q8Iw+3ZGZgxQUkgpthDVGsJzap79UJAUoRcFFgv3XPdhD5Dmibn0VcU1QEcQPI0TeaLa1a
 DJVdJy8orJZ6L6isZW8O/fS9aDLvtxHE8Yn8spmepSDh/++5oHPGlmSKdBEDHXjV2YPS2+
 UC9wwbcTV5iVTFPYix5wnohH5vd+CES2WKqUl3Ytd9ktSoDBJo9w0FE8F8KRhc2FNv7HGT
 juEJeipsNFhkbxxz6ApOwP+BIjJeIKuHlc9n9LXzMhn/rJmZWeNZe6VstYA2AHNYwBvihv
 x1+m1rYNvDUNb/QrmE85HG46nHVaRHYY9A3sM7xLBg5iGaq5o90A1r9lJbqksA==
ARC-Authentication-Results: i=1; rspamd-867694b6c6-mmmr6;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Oafish: 2be22a7027bed86c_1759202556998_3643016461
X-MC-Loop-Signature: 1759202556998:2878416865
X-MC-Ingress-Time: 1759202556997
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.81.207 (trex/7.1.3); Tue, 30 Sep 2025 03:22:36 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfM5pBNzGS; 
 Mon, 29 Sep 2025 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1759202556;
 bh=STfZcHxoRXw28XWRwgLmWXwMCu5bClVaJbQlLpEDfx8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=njfYoZsXSTmZOzCItbosjsJ0VRbF4ToJfSjL0nlxpa1mDSEr21rxMwBiEeObNlnL5
 LqbGrCOYcxIpnQiqYYpFxy19aIcbBUmgE0P/M+8h5ze17mW+E2KHdGPDJz2mRa3vhM
 Vt7oLSctonGT0th5nHO845JpMcjJUYDIHfUinXHlvgdn0dG2KOJbomRG7j6C7p/V+V
 V9ufzGYTKp/QustxhpR0lhowLRLO2I1xX+xN5ckAylJl7CILBtsuoODjQy/AXzrxTi
 BZuzTZWgHOxIxm91JvyPdSUlf4XQxLy6q9dkOjB4Q91OVxLk4tglSDlorzmO0AZXOs
 FtTVbCObNAY0w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, lucerop@amd.com, a.manzanares@samsung.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, dave@stgolabs.net,
 Jonathan.Cameron@huawei.com
Subject: [PATCH 5/5] hw/cxl: Remove register special_ops->read()
Date: Mon, 29 Sep 2025 20:21:53 -0700
Message-Id: <20250930032153.1127773-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

... this is unused, unlike its write counterpart.

Suggested-by: <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-component-utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 2098e9999a88..47a8d905f5b7 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -69,10 +69,6 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
 
     switch (size) {
     case 4:
-        if (cregs->special_ops && cregs->special_ops->read) {
-            return cregs->special_ops->read(cxl_cstate, offset, 4);
-        }
-
         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
 
         if (offset == A_CXL_BI_RT_STATUS ||
-- 
2.39.5


