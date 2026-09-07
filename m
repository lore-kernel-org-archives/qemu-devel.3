Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15C1C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Ww6-0007b3-DL; Mon, 07 Sep 2026 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvx-0007VL-KE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvv-00080L-Rd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SDEgsKrneUTjzP9rpa9htRqpgtiaPsTwDGZ0OeRxWY=;
 b=J9j4SItHNNVVQWtn6JlpwHCJI8B/Mo7Es3N/ytSdYI68fNGOqA4IFCs4Mbnu3HRUYIxh3o
 bUdOEAM34tk0gOpRj2ocyX40s7v5LJbENfkDKK37rFKDVtGxFJj9RlevEtMCBji+R2xhdS
 iBAE1tczMLiQm4Tbetx1jQEqaI9X+sw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-eecZnx3wM7Ct-G-HQCo7Vw-1; Mon,
 07 Sep 2026 06:50:38 -0400
X-MC-Unique: eecZnx3wM7Ct-G-HQCo7Vw-1
X-Mimecast-MFC-AGG-ID: eecZnx3wM7Ct-G-HQCo7Vw_1788778237
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 189711954AE4; Mon,  7 Sep 2026 10:50:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 199F83000223; Mon,  7 Sep 2026 10:50:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:06 +0400
Subject: [PATCH 08/17] qga/vss-win32: return an interface pointer for
 IID_IUnknown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-8-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0aYrIKGtm/kXJExFjJ3h2ZPtuJa9+ErLTo3d1cGeSh4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjLM2ZhsRJt+kJhNTMBEpWXcMYeujqLSC6O
 iMD34dh02aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5dx+D/4qHdXewMfi51+VmxXyYXeZzUgQNkTLcW/7fDJ2e1ImQlVSlPCCY3qlVXUWqwOFVevNVCQ
 pzLUTtcioFuz1jxcKi5bwOS3iQ6W64/BxavvvXZkFXeYxzpudXkDXAxeO4FufU8MdA2WI+FoJoV
 qq3ZjxnusCKoM87SozkZgCc5m5JXM9h+W955ViJEe6Du6oDDPvHbh76dCnT4RLj25iRaPewPhvp
 FlWb3yCER9HbFPQn2/ogfjW7P5ptW5sLcoXUN+8wDcEm2lSKqiUBLZigkxsrGoyRNOcsQKLU8O+
 g0Kkrfwh1duf1vvQzybsS7bvCqOAlw1c7uxT52al3/5+7OjMa9lfZGQq7C4nvnw0lu+JYO+3L08
 pwTp/K0V0quEVzN+2vsm0JV3GlSaHJFAl1LpubAM1XwAOYZIMYUQgwXOhmEk3WheeVaJqwZb2NB
 rsjCrd7yUSVJ1Rsf/mM09mxDv9tHxLZ3mzr1ypdZumKVXEcB8MsoLNjL20crikclgDGsHGyTiMH
 21SwE0nEtyNYOckOm3wd9qc9NVCbsRe4SNTfHquzHlNzqyWzIeO3WL5f4I/qiYSbkI4UFDhR54h
 1n+VLckGn+J8ULM7Xi4AdgPhld1McBxMh/qkCv0hBe3+MQ9mCIrX1VYtKCHXittde/p+a4Eq3cN
 9J8IX0n0Kdb25Zg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

CQGAVssProvider implements three COM interfaces, each with its own
IUnknown base subobject. Returning the complete object address for
IID_IUnknown relies on IVssSoftwareSnapshotProvider remaining the first
base class.

Return the IVssSoftwareSnapshotProvider subobject instead. This selects
the canonical IUnknown identity without relying on the complete-object
layout.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/provider.cpp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 377571b94881..44c3c74bd2f2 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -212,7 +212,8 @@ CQGAVssProvider::~CQGAVssProvider()
 STDMETHODIMP CQGAVssProvider::QueryInterface(REFIID riid, void **ppObj)
 {
     if (riid == IID_IUnknown) {
-        *ppObj = static_cast<void*>(this);
+        *ppObj = static_cast<void*>(
+            static_cast<IVssSoftwareSnapshotProvider*>(this));
         AddRef();
         return S_OK;
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


