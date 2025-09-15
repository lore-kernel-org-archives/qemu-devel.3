Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69321CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBgh-000776-BC; Mon, 15 Sep 2025 12:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBgL-0006oa-BE
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBgF-0001Zj-Jq
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757952224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXf7KIZQkJ4sNGcOnDqOGl6a1muhBQ/W0R6vYuP0OAg=;
 b=BIKjez4q/fqnIXXk1+2sMEaQgS73vrkkYKOAr1tK/iA1mfO/sBw12nLT1gBzSDSoX7nhZL
 Dq9i9K7eipDDl5U0wrT3tiwfy0BJy2Fo7xLubyy3/vrs8oh4NQwTJH+vNhp8cMKa2lrBKs
 rkq/0mSdyLlfV2b2vA7g+cWk1juiqNQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-7O84aVE5NW2IIs6-NVTE3Q-1; Mon, 15 Sep 2025 12:03:43 -0400
X-MC-Unique: 7O84aVE5NW2IIs6-NVTE3Q-1
X-Mimecast-MFC-AGG-ID: 7O84aVE5NW2IIs6-NVTE3Q_1757952223
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8217df6d44cso855774085a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952222; x=1758557022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXf7KIZQkJ4sNGcOnDqOGl6a1muhBQ/W0R6vYuP0OAg=;
 b=IYnN4PMx/Kbj6pTrPwj0PQ0vur/MA0ix8ySZdblpMu2GEnoSmIgtblL/vtyVd2vyGP
 OJTApny1HmtnzOXTH/Mxo3hOKmYBXQtAK9u37yEZe5p1Rrddmtlr/FE+2tf9v89St47y
 AY1fPMR7wx8Aj+S0EzRDLJwtaxYnTT9mCEtORrV8SQlf5Ahxas3QWKuznBHT/A6SAsye
 UPIE0R8pR3nbd0/bI6v3DF3dPshP2MW8IwpuiAFtYB9nd+HhqpqgLVRMmkIBNlks4spv
 PtN1dy1kzVL/Ziw69vd87nlyw2NbPjNQj3XXPODzUy5q5Iinfm6uKFsJ8nFjtRoNN0qS
 Zdqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmTRgJMWvy2o+4PJqiRcXjn4Z1z7Au46j/We+zcby/vVE78EODesSo2ddCgldH2bJuWjcKFjzpVJCJ@nongnu.org
X-Gm-Message-State: AOJu0Yxm4yse8/CSIesbcvOHTMRrnJ+8zmQ61ZF7ADdCaQeIeY5xHkLi
 LxpZ15RoXlTUuK+fJ4d4pNYkElsMneGyAzyMosnNDhep3ylSmEsIubcPZCehSb+x5fA68aX0Hw8
 QgY2wnBljwtmC021II80DgC+x1ZSIRdCTwqnlsBypoGvIFy3NTOlgvNML
X-Gm-Gg: ASbGncs4RhkQ6ne+bb9tN6rY7sb0iRReOWHnewtTMMtTf0u/D/GojgN4kWIjRK3/1HO
 Y9pku5fKsJkuigiTAU80m+t8UGyB1WqBbhPIMiLcEAEgSxh/VolfGDfKjwKXH/135e6VEGhMMgx
 VBetyrMaRog8tfbHgLH8stImrHPeEedl9H+g2adDjKkcKURI6uPUCE6Ggu5ewH2I1mMGt79ATqh
 IJnv4+E6nUr0f4eFtXZq3pDjR22/IDGhdF9wmm81eUKFqJE+4ADJMSSMA+UVnCUnJlt62wPyKih
 khj+BGRoL12EI0u0ys7Yd5KDKjfE8A==
X-Received: by 2002:a05:620a:1984:b0:817:ee72:f1e2 with SMTP id
 af79cd13be357-823fc98766dmr1834850985a.31.1757952222279; 
 Mon, 15 Sep 2025 09:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUKzhwPRoSClIs4pLExmAXmU6Jsy7evMAMpkLcxhxxO3gYdk50VG95LP7oTUVL/8ea4BXtXw==
X-Received: by 2002:a05:620a:1984:b0:817:ee72:f1e2 with SMTP id
 af79cd13be357-823fc98766dmr1834845285a.31.1757952221683; 
 Mon, 15 Sep 2025 09:03:41 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820ce19e020sm796565385a.52.2025.09.15.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:03:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/2] memory: Fix addr/len for flatview_access_allowed()
Date: Mon, 15 Sep 2025 12:03:27 -0400
Message-ID: <20250915160328.2080723-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915160328.2080723-1-peterx@redhat.com>
References: <20250915160328.2080723-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

flatview_access_allowed() should pass in the address offset of the memory
region, rather than the global address space. Shouldn't be a major issue
yet, since the addr is only used in an error log.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250903142932.1038765-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 311011156c..ddd58e9eb8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3027,7 +3027,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
@@ -3118,7 +3118,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-- 
2.50.1


