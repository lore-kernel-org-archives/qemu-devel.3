Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F5AC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RHH-0008KD-M2; Tue, 15 Sep 2026 07:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RHE-0008D7-1m
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RHC-0001pv-3l
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13yTLm5brikKpqrnLL3A85YqWuKvAGicciGZdgduuKw=;
 b=Tjr3lLkERtY0F5rSdudX7AlrYe8ffp/EwOQDyv8tKdxTXPjlSufYbelqn8N0zziBE0WZOz
 sxaT5k81XDYpDnKRI4GeTK7w0vJ54a7uhMn8DXwM3RDhe6Zpr50y0gC6EuVbT9hIa5vdEd
 7R0OiZzm9RgS/0fp9QOy5LXqpdMy9IU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-kezkAa7dOEO39tE5HXpQNw-1; Tue,
 15 Sep 2026 07:24:35 -0400
X-MC-Unique: kezkAa7dOEO39tE5HXpQNw-1
X-Mimecast-MFC-AGG-ID: kezkAa7dOEO39tE5HXpQNw_1789471474
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A9981955D59; Tue, 15 Sep 2026 11:24:34 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFA41956045; Tue, 15 Sep 2026 11:24:32 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 16/19] qga/vss-win32: check GetLastError() after
 FindNextVolumeW failure
Date: Tue, 15 Sep 2026 14:23:34 +0300
Message-ID: <20260915112337.43307-17-kkostiuk@redhat.com>
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

FindNextVolumeW returning FALSE can mean either normal end of
enumeration (ERROR_NO_MORE_FILES) or an actual error. The code
treated both cases as end-of-list, silently skipping any remaining
volumes on a real failure.

Distinguish the two by checking GetLastError().

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-14-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index b3daa060ac..f14c47f9f7 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -461,6 +461,13 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
             }
             if (!FindNextVolumeW(volume, short_volume_name,
                                  ARRAYSIZE(short_volume_name))) {
+                DWORD err = GetLastError();
+                if (err != ERROR_NO_MORE_FILES) {
+                    err_set(errset, err,
+                            "failed to find next volume");
+                    FindVolumeClose(volume);
+                    goto out;
+                }
                 FindVolumeClose(volume);
                 break;
             }
-- 
2.55.0


