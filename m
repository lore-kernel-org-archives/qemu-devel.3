Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22EFD44D56
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zxG-0003zJ-Kr; Thu, 07 Nov 2024 05:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zx9-0003lt-Nm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zx7-0005Uc-RY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730976084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rY0dDJ/Vbufbu/6I8sdWrx/boROixBRb4O3APboW+Q=;
 b=CIlo4NVSpwBLij39HZ+mXumQswatvIAZ0WjADhhCJfhis8ARrfEFV43Oe6/RuxWyET7xcf
 usefmw4tm8Ub7+o2SjptEg56T2hti/Hvu9tX+fvJRbkv4OaRFBBzxec+UrtkGsQDc43aHD
 oBYgcOsiMEUV7J0ljdW6slXd1gwRvBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-bicAMX9WOSCABG3BDIIeeQ-1; Thu,
 07 Nov 2024 05:40:14 -0500
X-MC-Unique: bicAMX9WOSCABG3BDIIeeQ-1
X-Mimecast-MFC-AGG-ID: bicAMX9WOSCABG3BDIIeeQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 175011955BC9; Thu,  7 Nov 2024 10:40:13 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75BFE1956054; Thu,  7 Nov 2024 10:40:11 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/3] qemu-ga: Avoiding freeing line prematurely
Date: Thu,  7 Nov 2024 12:40:01 +0200
Message-ID: <20241107104001.66039-4-kkostiuk@redhat.com>
In-Reply-To: <20241107104001.66039-1-kkostiuk@redhat.com>
References: <20241107104001.66039-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dehan Meng <demeng@redhat.com>

It's now only freed at the end of the function.

Signed-off-by: Dehan Meng <demeng@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20241107102155.57573-4-kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index b0704ad423..cf077eb03d 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2138,7 +2138,6 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
         fp = fopen(route_files[i], "r");
         if (fp == NULL) {
             error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]);
-            free(line);
             continue;
         }

@@ -2212,9 +2211,9 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
             route = NULL;
         }

-        free(line);
         fclose(fp);
     }

+    free(line);
     return head;
 }
--
2.47.0


