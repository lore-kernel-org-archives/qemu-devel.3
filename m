Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26970C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Dn-0003qq-AW; Wed, 17 Jul 2024 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dm-0003lP-1e
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dk-0001UD-C5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXoFjCl159AHrGpQIEjGcmsIvasGwlDdO6dihSoH6fI=;
 b=C87n+BANPr2jAAMEo+jx80Ysc4saDKGooj+5mf2rnogG3SJU7Q6cTgCs1flm4ckMwLXaZe
 zxdlgTl/wWP2p3J3TlsjR28yYW6MgbPtTErnV+rajJtXrB3Skq2YLkbBATIxrhNbwRzLgY
 5KcVj0OnB8AK8kSdiI/qTyyNXYucc4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-elmF9XNeMXyM6XSKsBZx2A-1; Wed,
 17 Jul 2024 06:49:14 -0400
X-MC-Unique: elmF9XNeMXyM6XSKsBZx2A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E736919560B6; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 698DD1955D42; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8F5B21E669C; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/14] qapi/sockets: Move deprecation note out of SocketAddress
 doc comment
Date: Wed, 17 Jul 2024 12:48:58 +0200
Message-ID: <20240717104907.2962784-6-armbru@redhat.com>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
References: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Doc comments are reference documentation for users of QMP.
SocketAddress's doc comment contains a deprecation note advising
developers to use SocketAddress for new code.  Irrelevant for users of
QMP.  Move the note out of the doc comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240711112228.2140606-5-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/sockets.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 4d78d2ccb7..e76fdb9925 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -179,10 +179,6 @@
 #
 # @type: Transport type
 #
-# .. note:: This type is deprecated in favor of SocketAddress.  The
-#    difference between SocketAddressLegacy and SocketAddress is that
-#    the latter has fewer ``{}`` on the wire.
-#
 # Since: 1.3
 ##
 { 'union': 'SocketAddressLegacy',
@@ -193,6 +189,9 @@
     'unix': 'UnixSocketAddressWrapper',
     'vsock': 'VsockSocketAddressWrapper',
     'fd': 'FdSocketAddressWrapper' } }
+# Note: This type is deprecated in favor of SocketAddress.  The
+# difference between SocketAddressLegacy and SocketAddress is that the
+# latter has fewer ``{}`` on the wire.
 
 ##
 # @SocketAddressType:
-- 
2.45.0


