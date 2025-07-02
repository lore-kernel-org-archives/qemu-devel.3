Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9520FC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0rI-0003jM-Fz; Wed, 02 Jul 2025 13:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rG-0003ih-7I
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rE-0003cB-KB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7QVmJTIRhICgBBt46Y/XvdXksqzQtTJRnjAacVH/a8=;
 b=EAxQxG9rAT0V5gORPZiPexboCuvlpCgRCdrl1sIgcdDoWzydEATtbycrCSBi5+hCmgmEC5
 1XNhohZUbNVS+jU/M2qyT16R8P3GA1RZu5fI0BMuPdE+yzdUxWMbQk0TIUI4yGzkXH3xHl
 GL2axTRJM4P2ZXvB5ScbFpVOYBsbxTs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-u_VBoIAHO2WbsH0qWjQaYA-1; Wed,
 02 Jul 2025 13:02:50 -0400
X-MC-Unique: u_VBoIAHO2WbsH0qWjQaYA-1
X-Mimecast-MFC-AGG-ID: u_VBoIAHO2WbsH0qWjQaYA_1751475769
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2C7C18683EF; Wed,  2 Jul 2025 17:02:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D08AC195608F; Wed,  2 Jul 2025 17:02:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] target/s390x: A fix for the trouble with tribles
Date: Wed,  2 Jul 2025 19:02:03 +0200
Message-ID: <20250702170206.212303-9-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

While Tribbles are cute, it should be "triple store" here,
not "trible store".

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250701194241.434183-1-thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index e23e603a792..c017bffcdc4 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -186,7 +186,7 @@ DEF_FEAT(PLO_CSO, "plo-cso", PLO, 25, "PLO Compare and swap (256 bit in paramete
 DEF_FEAT(PLO_DCSO, "plo-dcso", PLO, 26, "PLO Double compare and swap (256 bit in parameter list)")
 DEF_FEAT(PLO_CSSTO, "plo-cssto", PLO, 27, "PLO Compare and swap and store (256 bit in parameter list)")
 DEF_FEAT(PLO_CSDSTO, "plo-csdsto", PLO, 28, "PLO Compare and swap and double store (256 bit in parameter list)")
-DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and trible store (256 bit in parameter list)")
+DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and triple store (256 bit in parameter list)")
 DEF_FEAT(PLO_TCS, "plo-tcs", PLO, 30, "Triple compare and swap (32 bit in parameter list)")
 DEF_FEAT(PLO_TCSG, "plo-tcsg", PLO, 31, "Triple compare and swap (64 bit in parameter list)")
 DEF_FEAT(PLO_TCSX, "plo-tcsx", PLO, 32, "Triple compare and swap (128 bit in parameter list)")
-- 
2.50.0


