Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECAEC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraAg-0005fT-Kw; Wed, 05 Aug 2026 07:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAe-0005Vs-EA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAc-0006u1-Iz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cKC1Q443HkKmBCPK6f7y7gcM49z2DQPieEv1+CLUjM=;
 b=KYU79/yL2OBOaWIm1eY8rAQ+BKMmANuaEwi7dKJZ25gplsu3oU/GKbllhnyQ+yY+ZZnE43
 TnJhKENqIL5LutmXt1R1avjA7UzXxmSU0xleylNV25yrOegmdmsSTjFnf5+zeAT06vn42G
 bFQ7mLmlTUQ6yfiYtFKu50lmE9bEn/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-QEfGZ37aOBGWu5afr_wqFQ-1; Wed,
 05 Aug 2026 07:52:19 -0400
X-MC-Unique: QEfGZ37aOBGWu5afr_wqFQ-1
X-Mimecast-MFC-AGG-ID: QEfGZ37aOBGWu5afr_wqFQ_1785930739
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09EF19560B5
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:52:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B08F180034C; Wed,  5 Aug 2026 11:52:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:56 +0400
Subject: [PATCH 06/27] hw/usb/dev-smartcard-reader: fix OOB read in
 atr_get_protocol_num()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-6-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cVmgGekfR/ZikK6JZqR1e4rXKDxXKSJXVIK7Fe/G53Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOsCUFhx+zKw2vsNZV98dACxp3uRUeXp8py1
 wqwJRvQhWyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrAAKCRDa6OEJdZac
 5QlgD/0RoJqNnAKyAghvGR/i1ixiAqGDeYC3RTLDdYyl4z0rKSQgo7C1GcELfkGuEtym1m75fn8
 nNTNy1V2qaQEmEekslCns83GbfAwMH9DeljyNmjnOCfAx1NsPuwIg7dqUrj0qh9pjV4Sclvhb6E
 eq4/vPjRdGmtJ/oQm/xDDF0DVBpciKt5CqMHZOZbfRL0HWFiN1QBwiZ8mCnlmlj1v+gr2IqcnXj
 HUQCLyN80Uy42rH0Ij8dJh04Frl0pDR5cMUbJER9pEWEc0fDIj0V/KGVUMWX+wo0ZOhu5TQPciK
 o3fULeKDc0H3bN5PMrv5BHzHlKSKdfDeDAVgTkCRw1YLjjJhpJfkp4B7vRMQgQFOVxebY5wnSwY
 nQ3OuS2lI2/8G/gVwbQ/8hmAX/PyC7HkIDu+Nwi8PpAUino1WsYnIEJEDvSwsu8uZ9zsWra4BRG
 SeTTh7eSHSfxS7bULL+ua4KNQN+lMiPSjx30d8JIwTR40QVafkIgxUqIfibZJohp/VShI4YZ7bY
 xOPi0Ev5UXsD8aBVtVy51gufteIGtNxMCvqOXAmTwrNr/cfTaT9OwuudyPQnX2vmAowRqdaT2X2
 0zdWHVZgWAYqj6cac0AENM/oqdiFOrACtuB3eyT582vd1hFVEU5VStNEjqT3WAsONcC5QATJ9xZ
 fcAocM6y4Or3yvg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

atr_get_protocol_num() computes the TD1 offset from the T0 presence bits
without checking that the byte exists in the ATR buffer. A truncated ATR
causes an out-of-bounds read.

Validate the offset before dereferencing and fall back to T=0.

This is only triggerable by a buggy backend.

Fixes: 2f8f916b6d44 ("dev-smartcard-reader: copy atr protocol to ccid parameters")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index a14062948071..a147cd19f388 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -836,6 +836,9 @@ static uint8_t atr_get_protocol_num(const uint8_t *atr, uint32_t len)
     }
     i = 1 + !!(atr[1] & 0x10) + !!(atr[1] & 0x20) + !!(atr[1] & 0x40);
     i += !!(atr[1] & 0x80);
+    if (i >= len) {
+        return 0;
+    }
     return atr[i] & 0x0f;
 }
 

-- 
2.55.0


