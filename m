Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21D2CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUbV-0001OY-0O; Tue, 16 Jun 2026 10:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbT-0001OI-VM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbR-0003xw-UT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imfkb1TdhURklEm/PqnlSD4UK086FObFpUfx+QsC6mY=;
 b=DF/Wy2jYpGQOhxpBK7QLMPZXPmJp1CRpKKqjVD7noH+3r84tnKJJGTSOFMGy+jMoSptWRl
 +lAKKmNdeUq0IvofinBriVcHl2/TwYBZalH46E9TQWREzNMkzcZa3j34RA3fEJ8dpdZlAC
 d2errJ4orx1Gn51cXY/vDuTU9Ch+WO8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-wjmddUdZMH6NUIEkTqZoNQ-1; Tue,
 16 Jun 2026 10:17:18 -0400
X-MC-Unique: wjmddUdZMH6NUIEkTqZoNQ-1
X-Mimecast-MFC-AGG-ID: wjmddUdZMH6NUIEkTqZoNQ_1781619438
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25A211955D59
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB30C31D2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 462CA21E6A03; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 02/14] python: temporarily restrict max mypy version
Date: Tue, 16 Jun 2026 16:17:03 +0200
Message-ID: <20260616141715.2974467-3-armbru@redhat.com>
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

The newest versions of mypy do not support targeting Python 3.9, which
we still support. I want to address that soon, but in the meantime
it's nice if the tests pass.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260611042332.482979-2-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 python/setup.cfg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index 8097593397..ad4121a58d 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -40,7 +40,8 @@ devel =
     flake8 >= 5.0.4
     fusepy >= 2.0.4
     isort >= 5.6.0
-    mypy >= 1.4.0
+    # Max ver is temporary until we drop 3.9
+    mypy >= 1.4.0, <2.0.0
     pylint >= 2.17.3
     pylint != 3.2.4; python_version<"3.9"
     pytest >= 6.0.2
-- 
2.54.0


