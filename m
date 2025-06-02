Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27C0C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 17:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM90P-0001RE-Vf; Mon, 02 Jun 2025 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uM90O-0001R0-Cb
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uM90M-0006Xt-O4
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748885481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUjfYoFd5VP2l/D1/zyGPHcJJHPlCBN6dsaTtGCZsig=;
 b=GvQLGkt0xfMY4Br0Zyy13kKPRWr5EvZx1Ouv4lf3nbzpkrSyB6o5pck+wofoFPh7jlIPby
 SlrHUucN+sLStxkc9SDKJIU9/FLTINWJWRHf97HLxAmuwtX17oi/48ziFqmPWn7fM16+rx
 5mn4jxh8BQQBVnVvM9dUyqRKV6hdVYE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-JpKK9k2YNNyDWCKeW2hVeA-1; Mon,
 02 Jun 2025 13:31:16 -0400
X-MC-Unique: JpKK9k2YNNyDWCKeW2hVeA-1
X-Mimecast-MFC-AGG-ID: JpKK9k2YNNyDWCKeW2hVeA_1748885475
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DBB5195608C; Mon,  2 Jun 2025 17:31:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 266D51800371; Mon,  2 Jun 2025 17:31:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 2/2] i386/tdvf: Fix build on 32-bit host
Date: Mon,  2 Jun 2025 19:31:01 +0200
Message-ID: <20250602173101.1052983-3-clg@redhat.com>
In-Reply-To: <20250602173101.1052983-1-clg@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use PRI formats where required.

Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/tdvf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
index bd993ea2f07a..645d9d1294b4 100644
--- a/hw/i386/tdvf.c
+++ b/hw/i386/tdvf.c
@@ -101,16 +101,16 @@ static int tdvf_parse_and_check_section_entry(const TdvfSectionEntry *src,
 
     /* sanity check */
     if (entry->size < entry->data_len) {
-        error_report("Broken metadata RawDataSize 0x%x MemoryDataSize 0x%lx",
+        error_report("Broken metadata RawDataSize 0x%x MemoryDataSize 0x%"PRIx64,
                      entry->data_len, entry->size);
         return -1;
     }
     if (!QEMU_IS_ALIGNED(entry->address, TDVF_ALIGNMENT)) {
-        error_report("MemoryAddress 0x%lx not page aligned", entry->address);
+        error_report("MemoryAddress 0x%"PRIx64" not page aligned", entry->address);
         return -1;
     }
     if (!QEMU_IS_ALIGNED(entry->size, TDVF_ALIGNMENT)) {
-        error_report("MemoryDataSize 0x%lx not page aligned", entry->size);
+        error_report("MemoryDataSize 0x%"PRIx64" not page aligned", entry->size);
         return -1;
     }
 
-- 
2.49.0


