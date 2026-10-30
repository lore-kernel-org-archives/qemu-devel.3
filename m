Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3ED606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=XbCjrfAR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnTQ-00061u-Af; Fri, 30 Oct 2026 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xMnTN-00061K-WA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:20:50 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xMnTM-0003Fe-LA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:20:49 -0400
Received: from laptop.localdomain (unknown [81.196.141.157])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6469F20B7178;
 Fri, 30 Oct 2026 07:20:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6469F20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793370035;
 bh=RoTPilzhI0RpLGadQWoMd959of4JyHV8Ny5ZCkpFLG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XbCjrfARyzwJOiI8MDXMgkTVF5wELMteg1b4niaaZKxioLjLQqkyOnxDGPLWUplCq
 TMZi9a3cUujjmACktOfw6LvVfYqL9dUx7dmz2fBSLdoaCQF6XvrhzzaiUATK70JYjs
 9zBxRzbBVy0xc4ZbPG9EW1c77uw4/zUYmrrZjjqM=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [RFC PATCH 2/3] include/hw/hyperv: Add SCRUB_PARTITION ioctl
Date: Fri, 30 Oct 2026 16:20:36 +0200
Message-ID: <20261030142037.267641-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030142037.267641-1-dblanzeanu@linux.microsoft.com>
References: <20261030142037.267641-1-dblanzeanu@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 0983e3a58d..5178ed07a1 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -545,6 +545,8 @@ struct hv_input_assert_virtual_interrupt {
 #define MSHV_IOEVENTFD              _IOW(MSHV_IOCTL, 0x04, struct mshv_user_ioeventfd)
 #define MSHV_SET_MSI_ROUTING        _IOW(MSHV_IOCTL, 0x05, struct mshv_user_irq_table)
 
+#define MSHV_SCRUB_PARTITION        _IO(MSHV_IOCTL, 0x0B)
+
 /*
  ********************************
  * VP APIs for child partitions *
-- 
2.54.0


