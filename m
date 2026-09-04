Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F6C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3o-0006D2-V5; Fri, 04 Sep 2026 15:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3g-0005k5-HZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3e-0007sW-VV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UjKcKZjfqNOztaNAGUvCYkUFXm/hViMltfmNYS5qu0=;
 b=R/Yr4budpjUV3F7sVF4YewFzcU1ENEHBlWPs/xXAmCW/pJPXCxy9xkf4aKXOttGMeMH2+I
 IO0njtKTv9lucgMV/WvPNFk6D6U1DnQ36oJQue87QbcKrJEGOIBIoG22RHvq97Wd36/Ax0
 JlsCUCcfseJeQFgKo9i1mpBA86b/L5E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-xQuCzWotP8mGgqL9D8M91A-1; Fri,
 04 Sep 2026 15:58:39 -0400
X-MC-Unique: xQuCzWotP8mGgqL9D8M91A-1
X-Mimecast-MFC-AGG-ID: xQuCzWotP8mGgqL9D8M91A_1788551917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9143D1893ED5; Fri,  4 Sep 2026 19:58:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 803F630002F4; Fri,  4 Sep 2026 19:58:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:51 +0400
Subject: [PATCH v4 08/75] qapi/qom: add qapi-type field to ObjectPropertyInfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-8-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RzrWcye6kOLM0FYws/ink7WuC4CDlZtTRGBMe3pAJb4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLInlKDa/DZ0YARR3otwfZuK5KqGXTl8SAOY
 0uyi83Ld5+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5Vs+EACIDA7ox74cCtG4JGuhLj28M3/vlRhZ594YjJqG5kCquocdDy3pgZ7x44+NGN+3nAZ9i48
 qqwcvqbnIHPlZPo2un4yd7xE6aWLgmfok/o2D2Q9zjwbdGjQJzt/nW3EzoSKOkRNvaUVnpQMnLf
 f3+z6NDSmDqQ26m5gcIkdzJZOAjOI+rodwE4gfIy0ofWIpnGmOjtuAZvR075ieVdilCguR2SOT8
 ClYJeEkHoFRczWNs8LGVshj0OmI0Ke3efZ0s5JKIsUVW2SFTPpgL585l2ml9n3UzG5QPw4ssJNq
 jAkRPrvfaR4jkyuhLKbHP6ONP4ZK4qKfiD5U8okAqr0RJQmH1pLFGJLP8fGG5T8I/ZPZPL/iaP0
 su7T7bypaYDQA4+p7IgwF37CFE0pb+Z+Jn0agV1lsCSpkqP1yiNiWkCCqfi3vyn30VHKQwHru5C
 3NQPKiy1wx0nyVaTgQbGcXZR3QQMT8JRaSJ9oEMWe1ssinVhk7Shr2NM6VtqBUuBvcqNocb8lee
 YYOitn5KUfwB8JMp3sJMZshqmw3fn2ynnKzKqmUHQbXWBCQrzDMClneh7yYhqZ3AlOS+VWlvUVF
 ntDjyBLaiyNwWUhaDwgBEN4euj3UCY85cZqIl68aBCQcrhGDmwjixIsBFQFWUjO+sJu5TGu+KLv
 zNDiiAsfP1NcXcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an optional 'qapi-type' field to ObjectPropertyInfo and
ObjectPropertyValue. When present, it contains the masked type name that
can be looked up in query-qmp-schema output. Absent for properties
without a QAPI type association. Always absent for now, populated
in the following changes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4a9b7f908844..06add228151b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -35,6 +35,10 @@
 #        qdev device type name.  Link properties form the device model
 #        graph.
 #
+# @qapi-type: the name of the property's type as it appears in the
+#     output of ``query-qmp-schema``.  Absent if the type does not
+#     occur there.  (since 11.2)
+#
 # @description: if specified, the description of the property.
 #
 # @default-value: the default value, if any (since 5.0)
@@ -44,6 +48,7 @@
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -55,6 +60,10 @@
 # @type: the type of the property, as described in
 #     `ObjectPropertyInfo`.
 #
+# @qapi-type: the name of the property's type as it appears in the
+#     output of ``query-qmp-schema``.  Absent if the type does not
+#     occur there.  (since 11.2)
+#
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
 #
@@ -63,6 +72,7 @@
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*value': 'any' } }
 
 ##

-- 
2.55.0.543.g5ebe2ebe4ea8


