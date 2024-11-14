Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905CBD68B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBd9y-0000Ao-F7; Thu, 14 Nov 2024 11:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9m-0008RO-Hc
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9k-0002bs-D2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731603439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9P75sNr2f7388ubKnzuEESBswju/QLScY/HhvuOW+Mw=;
 b=WEaYH1vr4wsGXNKD5tdn+GQfEy4f/ZQ9xPJM/7nGHgUpG7w3SannPjeHmFUY1fkFZLZgJR
 qeeIq0oiyfYusJPBV3ruObMI6H+agOfJSSPr6muvbo2Yz8bl7WgXVt7g3TTteDzyYDxP4H
 LRqy4JARcLHX/9y98vAcs+0JfTiqZyQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-f30jzMZBO_enKjfR8VVTbw-1; Thu,
 14 Nov 2024 11:57:16 -0500
X-MC-Unique: f30jzMZBO_enKjfR8VVTbw-1
X-Mimecast-MFC-AGG-ID: f30jzMZBO_enKjfR8VVTbw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EB791954B22; Thu, 14 Nov 2024 16:57:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E81A71955F43; Thu, 14 Nov 2024 16:57:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 6/8] python: silence pylint raising-non-exception error
Date: Thu, 14 Nov 2024 17:56:55 +0100
Message-ID: <20241114165657.254256-7-kwolf@redhat.com>
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

From: John Snow <jsnow@redhat.com>

As of (at least) pylint 3.3.1, this code trips pylint up into believing
we are raising something other than an Exception. We are not: the first
two values may indeed be "None", but the last and final value must by
definition be a SystemExit exception.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20241101173700.965776-5-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 python/scripts/mkvenv.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index f2526af0a0..8ac5b0b2a0 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -379,6 +379,9 @@ def make_venv(  # pylint: disable=too-many-arguments
         try:
             builder.create(str(env_dir))
         except SystemExit as exc:
+            # pylint 3.3 bug:
+            # pylint: disable=raising-non-exception, raise-missing-from
+
             # Some versions of the venv module raise SystemExit; *nasty*!
             # We want the exception that prompted it. It might be a subprocess
             # error that has output we *really* want to see.
-- 
2.47.0


