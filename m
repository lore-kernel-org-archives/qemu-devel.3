Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED9C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RHF-0008HS-FA; Tue, 15 Sep 2026 07:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RH3-000835-7y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RH1-0001oS-Kz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jloJXwFZRD6FL3VYyH1bTDaUCCcwl60wVrzdVoXKKM8=;
 b=OVnijIwb8+HLv+digBpjP42CMVXGF2jBXPpp40PRkNBJskK1ppTEqcODvC28aGrJcaZ33Z
 6PCUM59CFr4nXGsSH5r9eLT3dKBWqKeV7FLkZvR5SeycXYbc09neAOSWWgsy7c6v2YcOkY
 Lrhq1oNkmJrgq/gn61hQWGe40h6nSxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-mEefcD9kM264tk4FRmwFyw-1; Tue,
 15 Sep 2026 07:24:25 -0400
X-MC-Unique: mEefcD9kM264tk4FRmwFyw-1
X-Mimecast-MFC-AGG-ID: mEefcD9kM264tk4FRmwFyw_1789471464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A4BC1955F2E; Tue, 15 Sep 2026 11:24:24 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87AA51956045; Tue, 15 Sep 2026 11:24:22 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 11/19] qga/vss-win32: use GetLastError() after FindFirstVolumeW
 failure
Date: Tue, 15 Sep 2026 14:23:29 +0300
Message-ID: <20260915112337.43307-12-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When FindFirstVolumeW fails, the error was reported using a stale
HRESULT from a prior SetContext call instead of the actual Windows
error. Use GetLastError() to report the correct failure reason.

Fixes: 0692b03ee135 ("qga-win: add support for qmp_guest_fsfreeze_freeze_list")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-9-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 1fd73312ba..d7907c2306 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -434,7 +434,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     if (!mountpoints) {
         volume = FindFirstVolumeW(short_volume_name, ARRAYSIZE(short_volume_name));
         if (volume == INVALID_HANDLE_VALUE) {
-            err_set(errset, hr, "failed to find first volume");
+            err_set(errset, GetLastError(), "failed to find first volume");
             goto out;
         }
 
-- 
2.55.0


