Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06689F36C24
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEiSJ-0000CO-53; Mon, 20 Apr 2026 02:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wEiS2-00008N-Jk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 02:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wEiS0-0008K6-5a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776667781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GU2deRWbajSFRwqWRixl/uXMDf5uGjjmU+yTI3sgtz8=;
 b=LQDY2pdUldXPSvnE1Hpr9UCgPpUIlJx21WcrKXSucaxd2bjaihVGeIKa31KNggThV52LAS
 +qv30LbFRexkCRK/hpOBaDYSCodH4AI+6zIkdso5NkPly0qOmBgl0gtsaDkQhSDLuP7AjO
 ked4rqwcNy4oGdwdx3rtRTtYAUFozL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-lHwC9x6xNX6N-3-KKsG64w-1; Mon,
 20 Apr 2026 02:49:37 -0400
X-MC-Unique: lHwC9x6xNX6N-3-KKsG64w-1
X-Mimecast-MFC-AGG-ID: lHwC9x6xNX6N-3-KKsG64w_1776667776
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F4EE195608D; Mon, 20 Apr 2026 06:49:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 240B01800906; Mon, 20 Apr 2026 06:49:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm: Remove hw_error() for the unimplemented CM_LMBUSCNT
 register
Date: Mon, 20 Apr 2026 08:49:33 +0200
Message-ID: <20260420064933.64765-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When writing to this register, QEMU currently aborts:

 $ echo "readl 0x10000018" | ./qemu-system-arm -audiodev none,id=snd0 \
    -M integratorcp,accel=qtest,audiodev=snd0 -display none -qtest stdio
 [I 0.000000] OPENED
 [R +0.001907] readl 0x10000018
 qemu: hardware error: integratorcm_read: CM_LMBUSCNT
 [...]
 Aborted                    (core dumped)

This is bad, a guest should ideally never be able to kill QEMU like this.

Now, according to the "Intergrator/CP User Guide" from:

 https://developer.arm.com/documentation/dui0159/b/porting-integrator-ap-and-im-pd1/registers

 "The Integrator/AP CM_LMBUSCNT has been removed."

That means this register does not seem to be implemented on real CP boards
at all, only for older AP boards. Thus it should be fine if we simply
ignore this register in QEMU and handle it like all other unimplemented
registers in the "default" handler of the case statement.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3407
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/integratorcp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 0bf519b6bb8..28d478eb52b 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -107,9 +107,6 @@ static uint64_t integratorcm_read(void *opaque, hwaddr offset,
         } else {
             return s->cm_lock;
         }
-    case 6: /* CM_LMBUSCNT */
-        /* ??? High frequency timer.  */
-        hw_error("integratorcm_read: CM_LMBUSCNT");
     case 7: /* CM_AUXOSC */
         return s->cm_auxosc;
     case 8: /* CM_SDRAM */
-- 
2.53.0


