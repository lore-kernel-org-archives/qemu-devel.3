Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF45E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnAi-0007SY-Le; Wed, 18 Feb 2026 14:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnAd-0007RE-SJ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:25:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnAY-0006R0-B8
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771442704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7czD35fBIZStNgK+aI8OpctqWGH8PRx3Y4SqgjrnPwg=;
 b=clxHzqC4CAilKolJoqY96d5YxNeaXe79vhp3w49tqVZ0M5MY399pacHabWIGjZw+m9sOEb
 MK4lRq1mTNsrxc+VwQIYC+LJM3y4KgxdrbUkm0x4PN+dIP7eTEOoY04Y/Hh/UjWR92Kpyk
 achkpfVCmJ5LyZ7KfDZtds8Kwi1Y9Oc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-l0ow3qLBN1e3TupRo-MnFA-1; Wed,
 18 Feb 2026 14:25:02 -0500
X-MC-Unique: l0ow3qLBN1e3TupRo-MnFA-1
X-Mimecast-MFC-AGG-ID: l0ow3qLBN1e3TupRo-MnFA_1771442701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E669D1956067; Wed, 18 Feb 2026 19:25:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.233])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B6021956095; Wed, 18 Feb 2026 19:24:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 1/1] rust: use checked_div to make clippy happy
Date: Wed, 18 Feb 2026 14:24:44 -0500
Message-ID: <20260218192444.658046-2-jsnow@redhat.com>
In-Reply-To: <20260218192444.658046-1-jsnow@redhat.com>
References: <20260218192444.658046-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
complaining about not using checked_div instead of manually checking
divisors. Make clippy happy and use checked_div() instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 rust/hw/core/src/qdev.rs | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 145e20a984f..c4a7312168f 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
     }
 
     pub const fn period_from_hz(hz: u64) -> u64 {
-        if hz == 0 {
-            0
-        } else {
-            Self::PERIOD_1SEC / hz
+        match Self::PERIOD_1SEC.checked_div(hz) {
+            Some(value) => value,
+            None => 0,
         }
     }
 
     pub const fn period_to_hz(period: u64) -> u64 {
-        if period == 0 {
-            0
-        } else {
-            Self::PERIOD_1SEC / period
+        match period.checked_div(Self::PERIOD_1SEC) {
+            Some(value) => value,
+            None => 0,
         }
     }
 
-- 
2.53.0


