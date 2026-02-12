Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB45EB48E6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSOw-0001mM-4X; Thu, 12 Feb 2026 03:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOp-0001i0-95
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOl-0001Zz-CW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62fbNyXOrCl7euGwjO06XPPerP37OxSU9/Ge6DrdZK4=;
 b=fJrvdaupXDfUcU1KkI9AoLH2uzKKYwCbfDFVcw2DfP3wfx8UiCEvhhlOAD3GvFwoMzCmTE
 HnKmpxtV+HE0/JpTJx/BxnmXYJajiLuodIUcHpjPyRMG8aKl7kZ85u0p1uQ5zzQxo7VMVR
 OrzAFe5xBBwrhSN8coXuvRW+5kH8J3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-a3B6b3csPM-2NyMc62SHgw-1; Thu,
 12 Feb 2026 03:50:03 -0500
X-MC-Unique: a3B6b3csPM-2NyMc62SHgw-1
X-Mimecast-MFC-AGG-ID: a3B6b3csPM-2NyMc62SHgw_1770886202
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBA6819560B5; Thu, 12 Feb 2026 08:50:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4253730001B9; Thu, 12 Feb 2026 08:49:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 09/14] fpu: Restrict parts_round_to_int_normal to target
 precision
Date: Thu, 12 Feb 2026 09:49:22 +0100
Message-ID: <20260212084927.258642-10-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently parts_round_to_int_normal() assumes that its input has just
been unpacked and therefore doesn't expect non-zero fraction bits past
target precision.

The upcoming DIVIDE TO INTEGER use cases needs it to support
calculations on intermediate values that utilize all fraction bits,
while at the same time restricting the result's precision to frac_size.

Delete the "All integral" check, because even though really large
values are always integer, their low fraction bits still need to be
truncated. For the same reason, make sure rnd_mask covers at least
fraction bits past target precision.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260210214044.1174699-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 fpu/softfloat-parts.c.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b7..79b56014ab9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1118,11 +1118,6 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         return true;
     }
 
-    if (a->exp >= frac_size) {
-        /* All integral */
-        return false;
-    }
-
     if (N > 64 && a->exp < N - 64) {
         /*
          * Rounding is not in the low word -- shift lsb to bit 2,
@@ -1132,8 +1127,13 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         frac_shrjam(a, shift_adj);
         frac_lsb = 1 << 2;
     } else {
+        /*
+         * Rounding is in the low word -- compute the lsb offset for rounding
+         * and for clamping to the target precision, then map it to an offset
+         * within frac_lo.
+         */
         shift_adj = 0;
-        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
+        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (MIN(a->exp, frac_size) & 63);
     }
 
     frac_lsbm1 = frac_lsb >> 1;
-- 
2.53.0


