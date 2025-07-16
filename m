Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309D3C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5t7-00031F-BX; Wed, 16 Jul 2025 13:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t4-0002wI-Lb
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t2-00087A-ET
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752686743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VmYcaAWrzHYKzdLBAzRIHRGWAPQr/dchlEpupFY0ww=;
 b=BwCM4xoYlLRPxmESGQNRYjqk9gfnSMcKLjVLAYlOMf8XuW7MTSa2+llL9OGJ1gYzQzflOx
 3Q9I2bsOED8ZDB+2R4Cv3pPt4qt48utCIYP0aHPXfjwehplo8oY9dvNE90BZmJUsLDZCg4
 EYFH6/278FoysHQqZwsQNQd04hJzrxs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-6OG9UCZ7ND-o2TJ-d3vfQQ-1; Wed,
 16 Jul 2025 13:25:42 -0400
X-MC-Unique: 6OG9UCZ7ND-o2TJ-d3vfQQ-1
X-Mimecast-MFC-AGG-ID: 6OG9UCZ7ND-o2TJ-d3vfQQ_1752686741
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AE901800165
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:25:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4366B180045B
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:25:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74ADE21E6741; Wed, 16 Jul 2025 19:25:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 6/6] python: fix editable installs for modern pip/setuptools
Date: Wed, 16 Jul 2025 19:25:35 +0200
Message-ID: <20250716172535.3520175-7-armbru@redhat.com>
In-Reply-To: <20250716172535.3520175-1-armbru@redhat.com>
References: <20250716172535.3520175-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The way editable installs work has changed at some point since Fedora 40
was released. Generally, we should be opting to use pyproject.toml
installs (PEP517/518) - but those are not fully supported until v61 of
setuptools, and CentOS Stream 9 ships v53.

Until that time, we can make use of a transitional feature in
pip/setuptools to use "legacy" editable installs, which is enough to fix
"make check-dev" on modern local workstations for now.

By using the environment variable approach to configure pip, we avoid
any problems for older versions of pip that don't recognize this option,
so it's harmless. The config-settings option first appeared in v23 of
pip. editable_mode was first supported by setuptools in v64.

(I'm not currently precisely aware of when the default behavior of '-e'
switched away from 'compat', but it appears to be a joint effect between
setuptools and pip versions.)

Version information for supported build platforms:

distro              python3  pip     setuptools  sphinx
--------------------------------------------------------
centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3
ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2

** pyproject.toml installs supported as of here **

freebsd             3.11.13  23.3.2  63.1.0      5.3.0
debian_12           3.11.2   23.0.1  66.1.1      5.3.0
ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6
centos_stream_10    3.12.11  23.3.2  69.0.3      7.2.6
fedora_41           3.13.5   24.2    69.2.0      7.3.7
alpine_3_19         3.11.13  23.3.1  70.3.0      6.2.1
alpine_3_20         3.12.11  24.0    70.3.0      7.2.6
alpine_3_21         3.12.11  24.3.1  70.3.0      8.1.3
ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7
fedora_42           3.13.5   24.3.1  74.1.3      8.1.3
ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3
macports            3.13.5   25.1.1  78.1.1      8.2.3
openbsd             3.12.11  25.1.1  79.0.1      8.2.3
alpine_3_22         3.12.11  25.1.1  80.9.0      8.2.3
homebrew            3.13.5   ---     80.9.0      8.2.3
pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250715222548.198888-1-jsnow@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 python/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/Makefile b/python/Makefile
index 764b79ccb2..32aedce413 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -68,7 +68,7 @@ $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.tx
 		echo "INSTALL -r tests/minreqs.txt $(QEMU_MINVENV_DIR)";\
 		$(PIP_INSTALL) -r tests/minreqs.txt 1>/dev/null;	\
 		echo "INSTALL -e qemu $(QEMU_MINVENV_DIR)";		\
-		$(PIP_INSTALL) -e . 1>/dev/null;			\
+		PIP_CONFIG_SETTINGS="editable_mode=compat" $(PIP_INSTALL) -e . 1>/dev/null;	\
 	)
 	@touch $(QEMU_MINVENV_DIR)
 
@@ -103,7 +103,7 @@ check-dev: dev-venv
 
 .PHONY: develop
 develop:
-	$(PIP_INSTALL) -e .[devel]
+	PIP_CONFIG_SETTINGS="editable_mode=compat" $(PIP_INSTALL) -e .[devel]
 
 .PHONY: check
 check:
-- 
2.49.0


