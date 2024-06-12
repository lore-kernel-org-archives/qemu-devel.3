Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28514C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNvG-0000vG-Gc; Wed, 12 Jun 2024 09:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNux-0000Ou-QB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuu-0003xc-4w
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2ti5MdYPaT8sRVI8LbSwShzQk9KoHPKLbkpjkZs45g=;
 b=GNVETZCJICESylYYABdVadvUnZkgr8IPCu01C6bxt80cXNVUbOvf9426ymuH5+Qm5nkrB+
 go29Sb09lJjIe+RGqCEHoE6b+utRKeWVO7nD+DsnUPIwzKL2myjGYGp+rQsP8I3WxpfDIY
 hEs3WoI7/EwkcYJpEWIMVJt9qP/H7tw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-pgY8wELfON2cUdHWwdQftw-1; Wed,
 12 Jun 2024 09:21:28 -0400
X-MC-Unique: pgY8wELfON2cUdHWwdQftw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F16A1955E7D; Wed, 12 Jun 2024 13:21:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED2B91956087; Wed, 12 Jun 2024 13:21:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PULL 10/15] tests/unit/test-smp-parse: Use default parameters=0 when
 not set in -smp
Date: Wed, 12 Jun 2024 15:20:50 +0200
Message-ID: <20240612132055.326889-11-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Since -smp allows parameters=1 whether the level is supported by
machine, to avoid the test scenarios where the parameter defaults to 1
cause some errors to be masked, explicitly set undesired parameters to
0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Message-ID: <20240529061925.350323-5-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 5d99e0d923..e3a0a9d12d 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -436,7 +436,7 @@ static const struct SMPTestData data_with_clusters_invalid[] = {
 static const struct SMPTestData data_with_books_invalid[] = {
     {
         /* config: -smp 16,books=2,sockets=2,cores=4,threads=2,maxcpus=16 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, F, 1, T, 2, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, F, 0, T, 2, T,
                                                 2, T, 4, T, 2, T, 16),
         .expect_error = "Invalid CPU topology: "
                         "product of the hierarchy must match maxcpus: "
@@ -444,7 +444,7 @@ static const struct SMPTestData data_with_books_invalid[] = {
                         "!= maxcpus (16)",
     }, {
         /* config: -smp 34,books=2,sockets=2,cores=4,threads=2,maxcpus=32 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, F, 1, T, 2, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, F, 0, T, 2, T,
                                                 2, T, 4, T, 2, T, 32),
         .expect_error = "Invalid CPU topology: "
                         "maxcpus must be equal to or greater than smp: "
@@ -456,7 +456,7 @@ static const struct SMPTestData data_with_books_invalid[] = {
 static const struct SMPTestData data_with_drawers_invalid[] = {
     {
         /* config: -smp 16,drawers=2,sockets=2,cores=4,threads=2,maxcpus=16 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, T, 2, F, 1, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, T, 2, F, 0, T,
                                                 2, T, 4, T, 2, T, 16),
         .expect_error = "Invalid CPU topology: "
                         "product of the hierarchy must match maxcpus: "
@@ -464,7 +464,7 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
                         "!= maxcpus (16)",
     }, {
         /* config: -smp 34,drawers=2,sockets=2,cores=4,threads=2,maxcpus=32 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, T, 2, F, 1, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, T, 2, F, 0, T,
                                                 2, T, 4, T, 2, T, 32),
         .expect_error = "Invalid CPU topology: "
                         "maxcpus must be equal to or greater than smp: "
-- 
2.45.2


