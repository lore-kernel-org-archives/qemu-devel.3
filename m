Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AE5EB362F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 19:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx97J-0002Mb-IO; Mon, 02 Mar 2026 14:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vx97G-0002MO-GB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 14:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vx97E-0002t3-Si
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 14:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772480379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TPqrzlBjfJz0aE+pYX2eq5KSX0uJqT1FwBezpyy1Q1M=;
 b=UZWU6A8df27xqyn34r8SBjUcs5G6CK1/OfO5FQ+owRRi3yvzAS2GYzPPsJls2fp08sJErR
 lSQdTWBsfLwprSN8cJutPYAb+8nhZpSe/EXp2tTTcWIDybP2njRwE95QcsSVWSexb+jXNr
 GU/U2m/9Eg8Cz2bNlu7aPC/VKpAUakY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-mJik8US2PW6nYbtgJq-z_A-1; Mon,
 02 Mar 2026 14:39:38 -0500
X-MC-Unique: mJik8US2PW6nYbtgJq-z_A-1
X-Mimecast-MFC-AGG-ID: mJik8US2PW6nYbtgJq-z_A_1772480377
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 894BC1956094; Mon,  2 Mar 2026 19:39:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DFF21800370; Mon,  2 Mar 2026 19:39:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/i3c: Fix array bounds and storage in i3c_addr_is_rsvd()
Date: Mon,  2 Mar 2026 20:39:31 +0100
Message-ID: <20260302193931.382228-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The size of the is_rsvd lookup table in i3c_addr_is_rsvd() is 255 but
should be 256 to cover all possible uint8_t address values and avoid
potential out-of-bounds access.

The array should be static too as it's a constant lookup table.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index 8a37099ce3ff..0a266e00a279 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -525,7 +525,7 @@ int i3c_target_ibi_finish(I3CTarget *t, uint8_t data)
 
 static bool i3c_addr_is_rsvd(uint8_t addr)
 {
-    const bool is_rsvd[255] = {
+    static const bool is_rsvd[256] = {
         [0x00] = true,
         [0x01] = true,
         [0x02] = true,
-- 
2.53.0


