Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177F0CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHvz-0007HL-CP; Fri, 08 May 2026 05:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvo-0007Dk-24
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvm-0000cn-25
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778234137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgmeX5jHLkDK3WGFiB++OFN+ffD3IhKwX0CPlF5Jj8U=;
 b=U9Rcu3fmVZ8NimUmOOmrYNxSoCs0RGqWgJctd/8k+LBbgwYoeK+URZKYGQZE6pYytKq39d
 iJqf2mRuQPZCtH6bGhfD8zFn2xQzGh4VbmGltRrK1ppzt4666eCwsQUt4kVNOGWZezyGo1
 K2ZVkrLybm8pdsBA5pm+NmbXFIRrKwQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-7bZYLvnsNtiVCaMrJowWVQ-1; Fri,
 08 May 2026 05:55:35 -0400
X-MC-Unique: 7bZYLvnsNtiVCaMrJowWVQ-1
X-Mimecast-MFC-AGG-ID: 7bZYLvnsNtiVCaMrJowWVQ_1778234135
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19FF918002CF; Fri,  8 May 2026 09:55:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.50.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEE393002D2F; Fri,  8 May 2026 09:55:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B81CE1800D48; Fri, 08 May 2026 11:55:31 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: [PULL 4/6] hw/uefi: add name_size check to
 uefi_vars_mm_lock_variable()
Date: Fri,  8 May 2026 11:55:29 +0200
Message-ID: <20260508095531.570979-5-kraxel@redhat.com>
In-Reply-To: <20260508095531.570979-1-kraxel@redhat.com>
References: <20260508095531.570979-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make sure the total variable_policy_entry size stays below
64k so the (16-bit) size field can not wrap.

Fixes: CVE-2026-41438
Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-5-kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 24e6516a9cc0..2c83130ebf63 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -667,6 +667,9 @@ uefi_vars_mm_lock_variable(uefi_vars_state *uv, mm_header *mhdr,
     if (mhdr->length < length) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
+    if (sizeof(*pe) + lv->name_size > UINT16_MAX) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
 
     uefi_trace_variable(__func__, lv->guid, name, lv->name_size);
 
-- 
2.54.0


