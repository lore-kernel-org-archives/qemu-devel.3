Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B7606A33A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ms47t+PE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7N7-00035u-IE; Wed, 11 Nov 2026 07:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mq-00030K-Ak
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mn-0000aD-FE
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2G0/NvHPW8rwpgqAOqoslL0UPm0eNpV/K/Ju76RfXQ=;
 b=Ms47t+PEDFt1D1Vzzfqpyvv40ARRjhVIhqIPu7j7XLIgTM7h9e+yjMWjG8s4XHBVKJHJqu
 sqNOKldOTHW0owfBbcuMdCxtvYrRGeMj2f0rED7nKaLSvAukOB4n5wDaHApvyVlVCinn4a
 DyrMJiN/EP6cBilSOF7PSbwH7d5R0Zk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-lFdF2YS5NQuxWQu9uYoRsw-1; Wed,
 11 Nov 2026 07:23:48 -0500
X-MC-Unique: lFdF2YS5NQuxWQu9uYoRsw-1
X-Mimecast-MFC-AGG-ID: lFdF2YS5NQuxWQu9uYoRsw_1794399827
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF8281955F11; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75D5B30000E8; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E58B21E6885; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 6/7] util/memfd: Improve error message when memfd_create()
 fails
Date: Wed, 11 Nov 2026 13:23:41 +0100
Message-ID: <20261111122342.634370-7-armbru@redhat.com>
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qemu_memfd_create() reports something like

    failed to create memfd with flags 0x3: Invalid argument

when memfd_create() fails.  To make sense of this, you have to
understand what flags are, and how to decode them.

qemu_memfd_create() computes the flags from @seals and @hugetlb, so
show these instead, like this:

    failed to create memfd with sealing and without huge pages: Invalid argument

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/memfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/memfd.c b/util/memfd.c
index 07beab174dc..a398b246600 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -73,7 +73,10 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
     mfd = memfd_create(name, flags);
     if (mfd < 0) {
         error_setg_errno(errp, errno,
-                         "failed to create memfd with flags 0x%x", flags);
+                         "failed to create memfd %s sealing"
+                         " and %s huge pages",
+                         seals ? "with" : "without",
+                         hugetlb ? "with" : "without");
         goto err;
     }
 
-- 
2.55.0


