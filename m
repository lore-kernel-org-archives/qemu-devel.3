Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F334AEE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOLW-0006XU-4t; Wed, 11 Sep 2024 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soOLJ-0005yb-Gf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soOLH-0003i8-8K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nCSGmabAbktdkuEljTpR/oki8Hsh9VvT3OCK7m/h5M=;
 b=b3c0CGyO8ShKefueqYKDsZOVNzMSp1yvMdWChczNt0kSqLtmvsGPT8N9AIY4E7eJMANVZP
 hQYuYu8vfawYIR5jjl9o571pnKzStqns8ra7GQoRSiyLwhwPtIQp44U2GsZYjplTJSkfKG
 dBNV1ixrdtssgyhMqcLpNGPP+RqEx2c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-TmmAwJWiPTeCC3kgYPMvyw-1; Wed,
 11 Sep 2024 09:12:11 -0400
X-MC-Unique: TmmAwJWiPTeCC3kgYPMvyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E70871955D57; Wed, 11 Sep 2024 13:12:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 869C61956095; Wed, 11 Sep 2024 13:12:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C7C321E691E; Wed, 11 Sep 2024 15:12:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, eblake@redhat.com,
 philmd@linaro.org
Subject: [PATCH 1/2] qga/qapi-schema: Drop obsolete note on "unsupported"
 errors
Date: Wed, 11 Sep 2024 15:12:05 +0200
Message-ID: <20240911131206.2503035-2-armbru@redhat.com>
In-Reply-To: <20240911131206.2503035-1-armbru@redhat.com>
References: <20240911131206.2503035-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

The note talks about "unsupported" errors and QERR_UNSUPPORTED.  The
former is vague, and the latter makes sense only in C, not in external
interface documentation.  Fortunately, we don't have to address this
anymore: recent merge commit 3b5efc553eb got rid of these errors.
Delete the note.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 495706cf73..0537bb7886 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,15 +1,6 @@
 # *-*- Mode: Python -*-*
 # vim: filetype=python
 
-##
-# = General note concerning the use of guest agent interfaces
-#
-# "unsupported" is a higher-level error than the errors that
-# individual commands might document.  The caller should always be
-# prepared to receive QERR_UNSUPPORTED, even if the given command
-# doesn't specify it, or doesn't document any failure mode at all.
-##
-
 ##
 # = QEMU guest agent protocol commands and structs
 ##
-- 
2.46.0


