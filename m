Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D3E6F06F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vaN-00014D-G7; Fri, 01 Nov 2024 13:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t6vaJ-00012k-EB
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1t6vaI-0000uJ-3b
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730482637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1F10KIvwm/4s1+NFV4H9i4T8ADuisiM/587six17Ks=;
 b=Ikwdof/kJk3xBNDZLttlVeHp3yLqfsJ6DYV6oaOHtzApoxTcwa0e/PrCQSL8iVvQUUYxQA
 WzT4W3La0R049MNlXg5imH27klntl0nhQ7ktAUuQ7h0SDYn70qM6E0INhRZsGorvbESZAg
 3qZ/U9r3mAZhHcu/qc1SNg9TVbG6k24=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-DI-zKlJYPWGSyerD5R412A-1; Fri,
 01 Nov 2024 13:37:14 -0400
X-MC-Unique: DI-zKlJYPWGSyerD5R412A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A4C11955E80; Fri,  1 Nov 2024 17:37:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.82.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 718E819560B2; Fri,  1 Nov 2024 17:37:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 3/4] python: disable too-many-positional-arguments warning
Date: Fri,  1 Nov 2024 13:36:59 -0400
Message-ID: <20241101173700.965776-4-jsnow@redhat.com>
In-Reply-To: <20241101173700.965776-1-jsnow@redhat.com>
References: <20241101173700.965776-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Newest versions of pylint complain about specifically positional
arguments in addition to too many in general. We already disable the
general case, so silence this new warning too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg            | 1 +
 tests/qemu-iotests/pylintrc | 1 +
 2 files changed, 2 insertions(+)

diff --git a/python/setup.cfg b/python/setup.cfg
index 3b4e2cc5501..cf5af7e6641 100644
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
index 05b75ee59bf..c5f4833e458 100644
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


