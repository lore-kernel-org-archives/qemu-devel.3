Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28A6EFCD93
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXv1-0006iK-Tm; Mon, 09 Mar 2026 06:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc8.v1-bc5a8c139306438c8aa897b8531ee6e3@bounce.vates.tech>)
 id 1vzXuy-0006dm-F8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:56 -0400
Received: from mail133-21.atl131.mandrillapp.com ([198.2.133.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc8.v1-bc5a8c139306438c8aa897b8531ee6e3@bounce.vates.tech>)
 id 1vzXuw-0006aw-Op
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773051336; x=1773321336;
 bh=QmvvVATKQ50AA0m6zrz/a7Fjd6LYEMyVctWBsInMFz4=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=i9CJMochPAc4flC5VMgGTAojWq52b4XSNY2pC/uL9DcWwQn4F94408ADQJG9uQ/Sf
 V80KvmXdm+Bn24G0V5B0YER6pxkXap3mFnMi6qgE+VGOST0qoVe6pH8Q9O+t+DHPIY
 P2nrJzWdnuZOlaTsgrs9L8kDE4haLXMrEhULMIAVqOgj2Ucx97n0lCZvpNDiiMm4yP
 MMAbHnDs40f2y3037pm9aYxyYnAQ73wTr2mS2jpneRYJX9ig48kNsaOjEu2hpaAREj
 HW453OjPaFqzjXNH2LV4YtC/slq6q2w8IFyj1DVXQ9QfxaKNJX1lbir4uP701nsTPo
 YCUfJ1ai3YxIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773051336; x=1773311836; i=anthony.perard@vates.tech;
 bh=QmvvVATKQ50AA0m6zrz/a7Fjd6LYEMyVctWBsInMFz4=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=fCDoiRJmfU+KFleseFj882cOYUpO2P3j8sOcu3HyN9Briwt3HHFfvX531LTa1d+0B
 HVnyW7FTZSR5HWXI9JlrjfuEpuu8ZfhXW263DgkpsQzRIy5e0IoM9AOC+bKcV6c30t
 Wkn8vcKAZW3fOzOV7e+cnIihcb9O9wNSoz4AhizQOysQMlj+7wWs+zB42ymEgDD8zr
 ZVlOcxVSCX+IDF/R67+jDovrw1bduM7KEpYWJ/MgOCM+aFlgJh8HTdLtuzcy58TY5w
 9PBLE9XD0SHFSkV0ZfO+K/awnwMp4Hj/8mX/eJYFlDdp2SoS3jAXHwEVmpNPIY8vGZ
 /I5G5TaTccjmA==
Received: from pmta13.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail133-21.atl131.mandrillapp.com (Mailchimp) with ESMTP id
 4fTtF41fCXz1XLDy1
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 10:15:36 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=203/3]=20xen-hvm:=20Emit=20RTC=5FCHANGE=20upon=20TIMEOFFSET=20ioreq?=
Received: from [37.26.189.201] by mandrillapp.com id
 bc5a8c139306438c8aa897b8531ee6e3; Mon, 09 Mar 2026 10:15:36 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773051335748
To: qemu-devel@nongnu.org
Cc: "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20260309101529.25695-8-anthony.perard@vates.tech>
In-Reply-To: <20260309101529.25695-5-anthony.perard@vates.tech>
References: <20260309101529.25695-5-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.bc5a8c139306438c8aa897b8531ee6e3?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260309:md
Date: Mon, 09 Mar 2026 10:15:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.133.21;
 envelope-from=bounce-md_30504962.69ae9dc8.v1-bc5a8c139306438c8aa897b8531ee6e3@bounce.vates.tech;
 helo=mail133-21.atl131.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

When the guest writes to the RTC, the write is intercepted and emulated
by Xen and the time difference is broadcasted as a TIMEOFFSET ioreq.
Emit an RTC_CHANGE QMP event when this happens rather than ignoring it
so that something can make use of the information (e.g. the toolstack
can persist it between VM starts).

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <20260108135406.1879210-1-ross.lagerwall@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/xen/xen-hvm-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 59c73dfaeb..b55d7f4a94 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -4,6 +4,7 @@
 #include "qemu/error-report.h"
 #include "qemu/target-info.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-misc.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -471,6 +472,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
             cpu_ioreq_move(req);
             break;
         case IOREQ_TYPE_TIMEOFFSET:
+            qapi_event_send_rtc_change((int64_t)req->data, "");
             break;
         case IOREQ_TYPE_INVALIDATE:
             xen_invalidate_map_cache();


--
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


