Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516DFEE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLU3-0005vY-J0; Wed, 11 Sep 2024 07:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLU1-0005pl-SY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTz-00013K-Vy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726053959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jcDBU4owQbBxkclDor65l8lSzSIuAVoWdS2D2Q1iluo=;
 b=A12P1J93C+zP+g0wBVpXNu8T2bmNCbgRdSbZvr0Kg4/kzGYttmOh1Wl/d6EJQFqTzAkvr3
 zu+vVrA4mt7giIBa8/1hubKaZGm68TR/jLPBJ01AlQ2QBjEH5gvAZi83SsQ1POorsoZHYS
 Kq7kum9AWJrD3hkytHQfp63FVkfdqSg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-CdlHh2SYNguXfoWI6xwnPQ-1; Wed,
 11 Sep 2024 07:25:53 -0400
X-MC-Unique: CdlHh2SYNguXfoWI6xwnPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A3021956088; Wed, 11 Sep 2024 11:25:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AC0B19560AD; Wed, 11 Sep 2024 11:25:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EA3021E68BD; Wed, 11 Sep 2024 13:25:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, arei.gonglei@huawei.com, pizhenwei@bytedance.com,
 jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jiri@resnulli.us, jsnow@redhat.com
Subject: [PATCH v2 8/8] qapi: Document QCryptodevBackendServiceType
Date: Wed, 11 Sep 2024 13:25:45 +0200
Message-ID: <20240911112545.2248881-9-armbru@redhat.com>
In-Reply-To: <20240911112545.2248881-1-armbru@redhat.com>
References: <20240911112545.2248881-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: zhenwei pi <pizhenwei@bytedance.com>

QCryptodevBackendServiceType was introduced by
bc304a6442e (cryptodev: Introduce server type in QAPI). However there
is a lack of member description.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Drop QCryptodevBackendServiceType from pragma documentation-exceptions]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/cryptodev.json | 10 ++++++++++
 qapi/pragma.json    |  1 -
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 5e417340dc..04d0e21d20 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -27,6 +27,16 @@
 #
 # The supported service types of a crypto device.
 #
+# @cipher: Symmetric Key Cipher service
+#
+# @hash: Hash service
+#
+# @mac: Message Authentication Codes service
+#
+# @aead: Authenticated Encryption with Associated Data service
+#
+# @akcipher: Asymmetric Key Cipher service
+#
 # Since: 8.0
 ##
 { 'enum': 'QCryptodevBackendServiceType',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 108e574678..023a2ef7bc 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -61,7 +61,6 @@
         'MemoryDeviceInfoKind',
         'NetClientDriver',
         'ObjectType',
-        'QCryptodevBackendServiceType',
         'QKeyCode',
         'RbdAuthMode',
         'RbdImageEncryptionFormat',
-- 
2.46.0


