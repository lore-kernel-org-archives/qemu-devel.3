Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746F5C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wvu-0007TR-J3; Mon, 07 Sep 2026 06:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvs-0007Sq-Tj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvr-0007zu-F8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDPaDZ31rXmHOi4fEYTXZA0sNPkfrX0n1+as2Wbnawc=;
 b=JQQg/RSPcgVSoOikd8zOM91fPy5nBTAm07805/r5+qV1OQJZyzy7a7LrcneUoMFpcUUlaW
 s+gnSphMm6CDAsS31i6zAjWAKKPEhO4ycZVwWMIV1zZonkqUKpXDVtQuIwR4HrS2KqeAHC
 GwAZgO8XtqrIVmiG7ZbYbVMDrg8DAEI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-I6jBpeCiP4KItiagv0kGXA-1; Mon,
 07 Sep 2026 06:50:33 -0400
X-MC-Unique: I6jBpeCiP4KItiagv0kGXA-1
X-Mimecast-MFC-AGG-ID: I6jBpeCiP4KItiagv0kGXA_1788778232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DC1F195399F; Mon,  7 Sep 2026 10:50:32 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D57A1800598; Mon,  7 Sep 2026 10:50:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:05 +0400
Subject: [PATCH 07/17] qga/vss-win32: allow pceltFetched==NULL in
 IEnumObject::Next
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-7-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sE3uIFGnEo4hDRu1e/HgY1dit7ftoN+pRaba1ze+UZY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjatGdmfNhg8dk8K+UsOmg89Aryca2kLT6E
 JnW0Xm5loqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5TchD/4luzFxN/sMu0OndOhwyl4bMDDFV0owffYYZMOuJUojhXtOsu9N/+Nm68dxw11NxMazG25
 +Ke/0Kx1FgrzEwvCgqI1YlGqUhlN6QxNb8CR//cKwRwDcMm0C0TZL7pDKIc75OLC8Yg5DSWmtKj
 b15EJOvp7tDgWKIR+hMxr/TK6+/3N8PSGyOoNoZCGdI/mBpeeM9zJS1ByPuCHyu2sil4tuszD5Y
 QnP4/5GGu3xmqf1Pj44x2KHmKySLy54oVdfq/7QLKibMP86hqucrAZI2VyHBgSwwCRZPEbrZxCE
 mLYow+nYnHNjNTaav6YnQfduqDo+yAuXNffKqI8MVBgIgsOL/o+wzZ11SlPEi8fiH0lLPsS6WRz
 OD28HDmtTpLsbbDF0Jv0aOuPzajIoIBe062HHgrDUy8ISnzX39hX8IGfohquvatvGuPxtyHIOTk
 GBDH6wMcmtSXNI9sp55R31PQv3esNu9X0BY7jrEhasDb68zRAXfkgCo5hPMAWRDoyU1Yvp7v1Q0
 nqWXwBVjiFUiCvbD+sk5bF6beLp9R12PSOhjmAelibYuHfdAjzmpaOlMNoTB9PRqHhxi0j5YPW4
 dJksjfJYEQnHzrDRkZ47w0h4GTiHxzVeW/JiritNX6mm4TxTZXPY9zT7QS6BhHezC9uYWOWnFhp
 KTVbvWVGWGsF3gQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The COM IEnumXxx/IEnumUnknown::Next API allows callers to pass NULL for
pceltFetched when celt is 1. Guard the write to prevent crashing.

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/provider.cpp | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 79906dcc24ae..377571b94881 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -117,7 +117,9 @@ STDMETHODIMP_(ULONG) CQGAVSSEnumObject::Release()
 STDMETHODIMP CQGAVSSEnumObject::Next(
     ULONG celt, VSS_OBJECT_PROP *rgelt, ULONG *pceltFetched)
 {
-    *pceltFetched = 0;
+    if (pceltFetched) {
+        *pceltFetched = 0;
+    }
     return S_FALSE;
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


