Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67ACD68B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBd9o-0008Sz-Dk; Thu, 14 Nov 2024 11:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9k-0008QP-M7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9g-0002bH-IB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731603436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PA544ebOcakPFC3z9NuydEbkGdh39B4Q/lJdIbCHIYE=;
 b=LnDvUQwZ1EwFsAB7jcxTjgkW7eu7++JfrtXEeFAd85sDWumAE4c/psuf3SsKhwwjOet2yU
 xQjoIjBJ5W7GGtWq6oApCw0oTJV04d8ZnK90Bb2pEsbHLd6eC9PyHzO0649dsmNPBk179I
 t97qFuvDQ1wMo34LCdyJG/VQdI0z5Hk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-IFmEHiDXNGSObIv1SqJW2g-1; Thu,
 14 Nov 2024 11:57:14 -0500
X-MC-Unique: IFmEHiDXNGSObIv1SqJW2g-1
X-Mimecast-MFC-AGG-ID: IFmEHiDXNGSObIv1SqJW2g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81B7A1956095; Thu, 14 Nov 2024 16:57:13 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC1581955F43; Thu, 14 Nov 2024 16:57:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 5/8] python: disable too-many-positional-arguments warning
Date: Thu, 14 Nov 2024 17:56:54 +0100
Message-ID: <20241114165657.254256-6-kwolf@redhat.com>
In-Reply-To: <20241114165657.254256-1-kwolf@redhat.com>
References: <20241114165657.254256-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Newest versions of pylint complain about specifically positional
arguments in addition to too many in general. We already disable the
general case, so silence this new warning too.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20241101173700.965776-4-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 python/setup.cfg            | 1 +
 tests/qemu-iotests/pylintrc | 1 +
 2 files changed, 2 insertions(+)

diff --git a/python/setup.cfg b/python/setup.cfg
index 3b4e2cc550..cf5af7e664 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -142,6 +142,7 @@ ignore_missing_imports = True
 disable=consider-using-f-string,
         consider-using-with,
         too-many-arguments,
+        too-many-positional-arguments,
         too-many-function-args,  # mypy handles this with less false positives.
         too-many-instance-attributes,
         no-member,  # mypy also handles this better.
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index 05b75ee59b..c5f4833e45 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -13,6 +13,7 @@ disable=invalid-name,
         no-else-return,
         too-few-public-methods,
         too-many-arguments,
+        too-many-positional-arguments,
         too-many-branches,
         too-many-lines,
         too-many-locals,
-- 
2.47.0


