Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F1C982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ecm-0006AG-0c; Thu, 17 Sep 2026 12:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcX-0005uc-H1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcU-0006u7-QC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHxv3zL5OXmdAPFMAHj7uNNc/Awb/QxXo9x+pbmadRQ=;
 b=N22MDNz+B0rbHQSNmV81nDX5WEIAprTWYc1RhQzaN9NydDUEIS7Xulm/1ulpZ9YutZkdgo
 L9WIT2HpTCG4EiFKN2hNYXah6GETEz4Chf4iAlEVfMFzcfla/r9ZTtSBiY9Ai10dBd3QNV
 vgftYTeLfNRlzXKNScwgIPIEQBswKxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-5m_5v15CO1G9tHI5V_TUwQ-1; Thu,
 17 Sep 2026 12:05:49 -0400
X-MC-Unique: 5m_5v15CO1G9tHI5V_TUwQ-1
X-Mimecast-MFC-AGG-ID: 5m_5v15CO1G9tHI5V_TUwQ_1789661148
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A8E1193E8AF; Thu, 17 Sep 2026 16:05:48 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75CC0300022B; Thu, 17 Sep 2026 16:05:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/14] docs: expand security docs with info about security
 status
Date: Thu, 17 Sep 2026 17:05:24 +0100
Message-ID: <20260917160525.1275388-14-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The description of virtualization vs non-virtualization use
cases is a crude approximation of the security characteristics
of QEMU devices.

Document how QEMU can be probed to obtain information on the
security status of type classes, and how policies can be set
to inform or control their usage.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/security.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index 8c42d1a6d83..75e39caedea 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -158,6 +158,42 @@ an issue as a normal bug.
   usually not justify handling as security bugs, nor assignment
   of CVEs. They will be fixed as routine bugs when time allows.
 
+Security status reporting
+'''''''''''''''''''''''''
+
+The QEMU project annotates types to explicitly state whether they are
+considered to provide a security boundary or not. For machine, accelerator
+and device types, only those annotated with the "secure" flag will be
+eligible for CVE assignment. Annotations will be extended to other backend
+and object types over time, to make their security status explicit.
+
+It is possible to control or identify the usage of types that do not offer
+an explicit security boundary using the ``insecure-types`` parameter to the
+``-compat`` argument, which accepts three values:
+
+ * accept: usage of any type will be permitted. This is the current
+   and historical default behaviour
+ * warn: usage of types not explicitly declared secure will result
+   in a warning message, but still be permitted.
+ * reject: usage of types not explicitly declared secure will result
+   in an error message, and will not be permitted.
+
+The compatibility policy will be honoured both at initial startup of
+QEMU and during any runtime alterations made with monitor commands.
+
+The status of any type class can be queried at runtime using the
+``qom-list-types`` command, whose returned information will flag any
+types declared as secure. The ``query-machines`` command will also
+reflect this same information for machine types.
+
+Machine type, accelerator and device security status can be queried
+using ``-machine help``, ``-accel help`` and ``-device help`` command
+line options respectively.
+
+Setting the ``.secure`` field to ``true`` in the ``TypeInfo``
+instance for an Object class, declares that the type aims to provide
+a security boundary.
+
 Architecture
 ------------
 
-- 
2.55.0


