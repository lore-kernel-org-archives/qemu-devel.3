Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0791DC02185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 01:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYENw-0003YG-Cg; Wed, 15 Jan 2025 20:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=104bc4e84=wilfred.mallawa@wdc.com>)
 id 1tYENt-0003Xh-B9; Wed, 15 Jan 2025 20:09:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=104bc4e84=wilfred.mallawa@wdc.com>)
 id 1tYENr-0004Dt-HY; Wed, 15 Jan 2025 20:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736989759; x=1768525759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RIcE4V9Oau2BlIHui7UckYA4eT7nPs0+wP+wuZKNg6E=;
 b=reR8xH4bQeSvuyJsVsZn34pDDdzj4hfTaq1p4XNNWU64lNUSZdJuu2CA
 6UVv3QIsCf4s5az+gGjqaMfrgVAI1JW9ynP2FnFy4dQK6yBmU++je4vnm
 a1JxMrkW3tfV2s5/iCmRZBJgake0i8FEdwaWneguSNVlXL+4C/WkCtQh7
 Cp7PFc6y/aIzs+Sjfu9oXMCoTHUgURdmsWxO4AR++pBGWm6v+m9YQec7+
 EJaqyjF96WHRxJ0nAkzPTcg79iNbg6qzlkYg54o2PFiSJ8HiA/yn40Ygr
 tczkBLqnaVk+7mPL97fykANlSSGj7ZpY14oPKBUNjjogiYGyy5ULfLe07 A==;
X-CSE-ConnectionGUID: uKb/pkYGQiyaZWeS0+fVDg==
X-CSE-MsgGUID: DpjyAkRNT26mSua+NIXS0A==
X-IronPort-AV: E=Sophos;i="6.13,207,1732550400"; d="scan'208";a="36036489"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 09:09:16 +0800
IronPort-SDR: 67884eae_KlBupYu34GYman1vMH9LAReNkN9sDIo1IgH+MR+8cKrpFUm
 RKqpZ5WYgvzMipG/WlsJQwKkaWc071lDa9h56Yg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 15 Jan 2025 16:11:26 -0800
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.165.91])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2025 17:09:11 -0800
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: alistair.francis@wdc.com, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC v2 1/3] spdm: add spdm storage transport virtual header
Date: Thu, 16 Jan 2025 11:08:55 +1000
Message-ID: <20250116010856.95115-3-wilfred.mallawa@wdc.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116010856.95115-2-wilfred.mallawa@wdc.com>
References: <20250116010856.95115-2-wilfred.mallawa@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=104bc4e84=wilfred.mallawa@wdc.com; helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Wilfred Mallawa <wilfred.mallawa@wdc.com>
From:  Wilfred Mallawa via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This header contains the transport encoding for an SPDM message that
uses the SPDM over Storage transport as defined by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/system/spdm-socket.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 2b7d03f82d..fc007e5b48 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/*
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct QEMU_PACKED {
+    uint8_t security_protocol;
+    uint16_t security_protocol_specific;
+    bool inc_512;
+    uint32_t length;
+} StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.48.0


