Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FA0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 06:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHdCf-00081G-UD; Wed, 21 May 2025 02:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCb-00080l-VZ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCY-0002tT-NY
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747809916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSAsYct6oPz/pfHeUFNoV24YshfJsx++R1eXKA6djEc=;
 b=BvhgMxTsAi6NxL3TDBY7yPdCO3djPncQtLRLWUWeRsTJlA5ng4mg+tv7wJpoEA8eqNbHRc
 JKucumNjmgFn6Q3wkEZ9CMPyKQtanddUNQvYbo0/yhRTPEElto2KD+DZbxCcUQ1hGecsqc
 cEg3E3rgmsnrtXvWHI/0bm3sSB71jtE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-wfYx73xENGuuKb3oE2CaWQ-1; Wed,
 21 May 2025 02:45:14 -0400
X-MC-Unique: wfYx73xENGuuKb3oE2CaWQ-1
X-Mimecast-MFC-AGG-ID: wfYx73xENGuuKb3oE2CaWQ_1747809913
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E0101833498; Wed, 21 May 2025 06:45:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F067819560AB; Wed, 21 May 2025 06:45:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95CA421E66E3; Wed, 21 May 2025 08:37:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/4] docs/about: Belatedly document tightening of QMP
 device_add checking
Date: Wed, 21 May 2025 08:37:08 +0200
Message-ID: <20250521063711.29840-2-armbru@redhat.com>
In-Reply-To: <20250521063711.29840-1-armbru@redhat.com>
References: <20250521063711.29840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit 4d8b0f0a9536 (v6.2.0) deprecate incorrectly typed device_add
arguments.  Commit be93fd53723c (qdev-monitor: avoid QemuOpts in QMP
device_add) fixed them for v9.2.0, but neglected to update
documentation.  Do that now.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst       | 14 --------------
 docs/about/removed-features.rst |  9 +++++++++
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 44d3427e98..9665bc6fcf 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -187,20 +187,6 @@ threads (for example, it only reports source side of multifd threads,
 without reporting any destination threads, or non-multifd source threads).
 For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
 
-Incorrectly typed ``device_add`` arguments (since 6.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Due to shortcomings in the internal implementation of ``device_add``, QEMU
-incorrectly accepts certain invalid arguments: Any object or list arguments are
-silently ignored. Other argument types are not checked, but an implicit
-conversion happens, so that e.g. string values can be assigned to integer
-device properties or vice versa.
-
-This is a bug in QEMU that will be fixed in the future so that previously
-accepted incorrect commands will return an error. Users should make sure that
-all arguments passed to ``device_add`` are consistent with the documented
-property types.
-
 Host Architectures
 ------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 063284d4f8..92b5ba6218 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -722,6 +722,15 @@ Use ``multifd-channels`` instead.
 
 Use ``multifd-compression`` instead.
 
+Incorrectly typed ``device_add`` arguments (since 9.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Due to shortcomings in the internal implementation of ``device_add``,
+QEMU used to incorrectly accept certain invalid arguments. Any object
+or list arguments were silently ignored. Other argument types were not
+checked, but an implicit conversion happened, so that e.g. string
+values could be assigned to integer device properties or vice versa.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
-- 
2.48.1


