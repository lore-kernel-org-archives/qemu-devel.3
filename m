Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB9CD29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfarZ-0004ea-Is; Tue, 13 Jan 2026 04:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfarI-0003sG-VW
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfarH-0003Wa-GB
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UFal5/EXhCIGHOGQKLaPbaoeQMeb4mww9g+nD++e4Q=;
 b=Vn+5Y0V4XcoNi535L8yKVqSD8UBb+Jkyn5azIfZ7K3/+ExdQF8Ak+UueTzDmksXEXzLH21
 G4V1zaQMiuxptiqJ86kMzTJPmk8gvNypqCj3Wod+G97mBmhxgy/dUJXcLf4wfaouQJlfin
 3qm/0LWFNQY8j750wHuAJuRlVgbolc0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-V1OVL4S8ON-COHy-pZgJHA-1; Tue,
 13 Jan 2026 04:38:33 -0500
X-MC-Unique: V1OVL4S8ON-COHy-pZgJHA-1
X-Mimecast-MFC-AGG-ID: V1OVL4S8ON-COHy-pZgJHA_1768297112
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12B8719560B5; Tue, 13 Jan 2026 09:38:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A21B30001A2; Tue, 13 Jan 2026 09:38:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 39/41] target/riscv: Fix build errors
Date: Tue, 13 Jan 2026 10:36:35 +0100
Message-ID: <20260113093637.1549214-40-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
detects a truncation error:

  ../target/riscv/cpu.c: In function ‘riscv_isa_write_fdt’:
  ../target/riscv/cpu.c:2916:35: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 5 [-Werror=format-truncation=]
   2916 |     snprintf(isa_base, maxlen, "rv%di", xlen);
        |                                   ^~
  ../target/riscv/cpu.c:2916:32: note: directive argument in the range [-2147483648, 2147483632]
   2916 |     snprintf(isa_base, maxlen, "rv%di", xlen);
        |                                ^~~~~~~

Since the xlen variable represents the register width (32, 64, 128) in
the RISC-V base ISA name, mask its value with a 8-bit bitmask to
satisfy the size constraints on the snprintf output.

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260112161626.1232639-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ffd98e8eed468645b8ceb8a7adb45718bdc4444d..e95eea024939d2cbb5747781c291fed0e1b07bb9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2913,7 +2913,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
     riscv_isa = riscv_isa_string(cpu);
     qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
 
-    snprintf(isa_base, maxlen, "rv%di", xlen);
+    snprintf(isa_base, maxlen, "rv%di", xlen & 0xFF);
     qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
 
     isa_extensions = riscv_isa_extensions_list(cpu, &count);
-- 
2.52.0


