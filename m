Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652EFE9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsecv-0000Pk-EG; Wed, 18 Feb 2026 05:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vsecs-0000P9-IU
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vsecq-0005vJ-6y
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771409863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqDwu0T0oJAOwK1ffJHuITlC5Gc0NgpKr7ZD1XAqwTQ=;
 b=WrR8Q3yV+j7MP2C67FDDwXgBDcEA1k90EahCyK2trFnG706kE2XZiuOaqMrjq/aQKhRVTG
 8NoqThfjetcaiq6P3FqGMfiEcjTLnnkh5FAywvlUKYYZzcTWp9c4Zhod844UJt7W8uB3cW
 5rNEFEqkEET3S/mJudsh+8bAxcbsWts=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-gUis1d5NO1C08-Q409XzpQ-1; Wed,
 18 Feb 2026 05:17:39 -0500
X-MC-Unique: gUis1d5NO1C08-Q409XzpQ-1
X-Mimecast-MFC-AGG-ID: gUis1d5NO1C08-Q409XzpQ_1771409859
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB1E1956053; Wed, 18 Feb 2026 10:17:38 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6725530001A5; Wed, 18 Feb 2026 10:17:37 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 3/3] qga: Fix VSS provider GetSnapshotProperties return value
Date: Wed, 18 Feb 2026 12:17:29 +0200
Message-ID: <20260218101729.92630-4-kkostiuk@redhat.com>
In-Reply-To: <20260218101729.92630-1-kkostiuk@redhat.com>
References: <20260218101729.92630-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Elizabeth Ashurov <eashurov@redhat.com>

GetSnapshotProperties() returned VSS_E_OBJECT_NOT_FOUND causing
"Snapshot id not found" errors during VSS operations.

Any error in this function causes a similar error in Windows VSS,
so we must return S_OK there.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211101744.757548-2-eashurov@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/provider.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index a102a23fbf..2b5c6f8e8e 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -263,7 +263,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContext)
 STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
     VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
 {
-    return VSS_E_OBJECT_NOT_FOUND;
+    return S_OK;
 }
 
 STDMETHODIMP CQGAVssProvider::Query(
-- 
2.52.0


