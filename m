Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B936210D14AD
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Bxp-0003X4-30; Mon, 30 Mar 2026 08:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxe-0003WF-Ev
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxa-0000HX-P0
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774874593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFmElHq0kE23y5zKJfaLtws9QU4CzXhS7y+3ATsDVc4=;
 b=DUhOHPkBAj7hP3Jj9t7OIoDfDJqhfvQurvZXBgn8qNTSXZVQDe8v9aG3ayRgvMpSDtWmFM
 B/vkC+XCoGtrHIhHEwExKnMw2TUvKMHx+JT2r0pVzfWSGatG/RdgipJE8+mtl2p5xZb0K/
 8alf0jUN2xo+0V74cBoIcS2967/KEMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-RoI2FMD5Mxi6ByEb6AD2iw-1; Mon, 30 Mar 2026 08:43:11 -0400
X-MC-Unique: RoI2FMD5Mxi6ByEb6AD2iw-1
X-Mimecast-MFC-AGG-ID: RoI2FMD5Mxi6ByEb6AD2iw_1774874590
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486f89b7f69so35685505e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774874590; x=1775479390; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jFmElHq0kE23y5zKJfaLtws9QU4CzXhS7y+3ATsDVc4=;
 b=peqscZhslgHeq3mPWfjjRT9rDS4k5Y2qz0ugagMf2gMb4DF5YYf2uBEKuKKdV+RrXU
 +qwsEaCxObCn7qDNhelw6p2OhEWFTMKYBLAqhkaU2XUA0M7A7e8cew3CafYTdsXPyRxe
 llaNtbPU/HftlDAoUbLJAGnUaIkFw+M35ZIaOMcxMr2IOXtWUw46yuBvJJ+ZxfHFwuja
 LfZohJlAIoKUEAKPygSifQKxoeurUHcsL0U9FIi1hkpfYycXH2hvL6//2VZbI7p79Nsc
 aYA9cAgAlCQF9ax2F/STGgVwKsgxcEezv6xecdczxkVWw86BCP++qV0TYKMFZMvragEX
 VsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774874590; x=1775479390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jFmElHq0kE23y5zKJfaLtws9QU4CzXhS7y+3ATsDVc4=;
 b=YP9+ivigqJvPESo5T+P+3MN77iZj7nyepoFnSk9lcBrLjxHr/whSXgVL/UxjVRX7q3
 xBwYAeQEDjRACIJrBljt+H6lxwlqar1u/zTQ5/r+FP/YyB0ililwmd1wWDaeDjyqFO1L
 HuwG0lnhbl/MpxqWmEjW3Sijy3lzX0zgJGEgSfb/aPVCkedQcaOfmT71FG0v6AWOIFO+
 a8tDokzmj9u4gLdYi6ogKDi5CwIzuVE8sVo9ix4y1Fkbo/sP0lRbUGugJmzDtLi0vplG
 lsitdkNnUQm0cKdiWwx5FfYaTlAk0KmYKtI0Y+eqrP3XDrl2qmzqkcYleJYPULfdoA4X
 H6eg==
X-Gm-Message-State: AOJu0YzL7nvyDK9nGNNm1XHoheuAa65efyNlikaljNbryigrNfbYz0wv
 HsEHUvqSeiJFqsU+CkY3moBk2OB8yJpkCFCv1op40FWV+2H6vN/PSYnkLBKlvW0FYzkFllti+8F
 faIXMfyt9aU32DIp7vBZ3Bd+0uWOuPm5Xs/VUEjNXB2iBJX1E56yLRwuj
X-Gm-Gg: ATEYQzwx3oweYaHddnUBpehkEs6ajGuCBWate8rqn2Sh15OpRFooUDKARVtAcHj6RsN
 kNMIFd8DxKmkZWcvMolU21xeCDIrQfRWtl6BD0GxcRay+1NH2oAJp3EYfz1OR7wpLbIdd03uTD6
 TrP42uG97Nel56kulLxcC8TTFZE35L9UA7ocwk1yYSEekXiq8ZxujeJLXi5bDTQ/rt5AjWQLFMo
 NsxmgdK3ijzaJhvPiFdPTNYNRmAZeCXkXAOYe815L+H2VS0W337gJUJou1I52wzut+GNLfA8LHm
 fDeEq72wl8bImVB6ImCKUH3K/p9Gwi9KUEKNCV21mms59XjnstsROI/OJl5Z2suPXbHk26oXSzS
 9jtRyASNqSmw1GJDjbDsUSaxtY885n5HTvcLIMGoEV+tn9pnHIVkWjzgeUN0u
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c87 with SMTP id
 5b1f17b1804b1-48727d45881mr211254695e9.4.1774874590161; 
 Mon, 30 Mar 2026 05:43:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c87 with SMTP id
 5b1f17b1804b1-48727d45881mr211254225e9.4.1774874589659; 
 Mon, 30 Mar 2026 05:43:09 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487306996cbsm165319385e9.13.2026.03.30.05.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 05:43:09 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 30 Mar 2026 14:43:07 +0200
Subject: [PATCH 1/3] igvm: switch to PRIx64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-igvm_fixes-v1-1-03587a5a808b@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
In-Reply-To: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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

Use the PRIx64 format macro instead of %lX for uint64_t values.

This is to improve portability as %lX is not necessarily 64 bit long.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3b5edf15213c845132d0d4c05144a18992f1816e..50f0d6fb9a7bacddce91f095b6e2710ecbc79c6f 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -187,7 +187,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%lX due to existing non-RAM region",
+                "at address 0x%" PRIx64 " due to existing non-RAM region",
                 addr);
             return NULL;
         }
@@ -198,7 +198,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%lX: region size exceeded",
+                "at address 0x%" PRIx64 ": region size exceeded",
                 addr);
             return NULL;
         }

-- 
2.53.0


