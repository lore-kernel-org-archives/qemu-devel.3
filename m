Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B20C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWa4C-0007RE-Oe; Tue, 01 Jul 2025 08:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uWa4A-0007QW-Di
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uWa41-0007Hx-0Z
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGPqbrmHv+i7SsnSijcCRZni8n75UlYBq8wiyg7uDEM=;
 b=JPDdAN8zaoGssxgP4EicGuCFc/EhTS+SIYsxWm1VTdfOyTPXToD6R/YhkdK6v3y7iL2fBj
 8dtAjg5Y8Wi+u1+A3cDZ2N68h4PZ+04n7Rbb2lU20yFuThR+ZjYIDJX7e8b7FsIilb2cyK
 jU9S7qKgsrpeFQmvArShAL/eJgm49AY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-DZhmX8ONP7C4Ttws7xgLRg-1; Tue,
 01 Jul 2025 08:26:11 -0400
X-MC-Unique: DZhmX8ONP7C4Ttws7xgLRg-1
X-Mimecast-MFC-AGG-ID: DZhmX8ONP7C4Ttws7xgLRg_1751372770
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3A1B1944AA9; Tue,  1 Jul 2025 12:26:10 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C85C419560A7; Tue,  1 Jul 2025 12:26:07 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Dehan Meng <demeng@redhat.com>,
 Elizabeth Ashurov <eashurov@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 2/3] qga-vss: Exit with non-zero code when register fail
Date: Tue,  1 Jul 2025 15:25:57 +0300
Message-ID: <20250701122558.31556-3-kkostiuk@redhat.com>
In-Reply-To: <20250701122558.31556-1-kkostiuk@redhat.com>
References: <20250701122558.31556-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

QGA installer uses rundll32 to run the DLLCOMRegister function
from qga-vss.dll and perform VSS provider registration.
rundll32 ignores the return value of the function and always
exits with a zero exit code. This causes a situation where
the installer does not know the status of VSS provider registration.

This commit forces to change exit code when the VSS provider
registration fails.

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/rundll32

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Tested-by: Dehan Meng <demeng@redhat.com>
Message-ID: <20250620083132.28347-1-kkostiuk@redhat.com>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5cea5bcf74..6ee2f44a10 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -385,7 +385,10 @@ out:
 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
 {
-    COMRegister();
+    HRESULT hr = COMRegister();
+    if (FAILED(hr)) {
+        exit(hr);
+    }
 }
 
 STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
-- 
2.48.1


