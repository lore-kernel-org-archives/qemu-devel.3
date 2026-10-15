Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E0CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSJ-0002nH-B6; Thu, 15 Oct 2026 08:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSH-0002m4-E0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSF-0005Ht-M9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnp48zFz4N856ZPIHl/UMCcSs+S99equ6ItzvQY97UU=;
 b=Plh0WZVvWDn5swC/Jli2GBl1JvWwPJ1w5fIDzV8zuFDTdLB9cYDT5WojBjzL9tRxoZkAbb
 KPjeXzdiCExQ3ftaMktyyjrEnxT8AMeZlv3lDIuJE7EsTltpLgs2T2PMHhd+E6AxBYpmUV
 XZWzGt40VlVPki6vbn7G+MHRh+D2v8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-LhhRM2m1NkSEHwE7GCuNSg-1; Thu,
 15 Oct 2026 12:21:01 +0000
X-MC-Unique: LhhRM2m1NkSEHwE7GCuNSg-1
X-Mimecast-MFC-AGG-ID: LhhRM2m1NkSEHwE7GCuNSg_1792066860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 583B3180074C; Thu, 15 Oct 2026 12:21:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23650180029C; Thu, 15 Oct 2026 12:20:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/8] target/i386/kvm: Fix UBSAN shift error in MTRR mask
 computation
Date: Thu, 15 Oct 2026 14:20:48 +0200
Message-ID: <20261015122055.888209-2-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On AMD EPYC processors, raw CPUID leaf 0x80000008 reports 52 physical
address bits. When a machine type such as microvm forces
host_phys_bits=true, the CPU ends up with phys_bits=52, causing
MAKE_64BIT_MASK(52, 0) to shift by 64 - which is undefined behavior.

Fix by only computing the mask when phys_bits < 52.

Fixes: fcc35e7ccaed ("target-i386: Fill high bits of mtrr mask")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260722120437.697986-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/i386/kvm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a72b6e6b74cc7e16bb721d9a32332a0ed8473fc1..da922f72d71e00bd10ce087ccc9828c9692501d0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5064,8 +5064,7 @@ static int kvm_get_msrs(X86CPU *cpu)
      * we're migrating to.
      */
 
-    if (cpu->fill_mtrr_mask) {
-        assert(cpu->phys_bits <= 52);
+    if (cpu->fill_mtrr_mask && cpu->phys_bits < 52) {
         mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
     } else {
         mtrr_top_bits = 0;
-- 
2.56.0


