Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F7AC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54GL-0005ix-TW; Fri, 11 Sep 2026 12:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G9-0005CF-T9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G4-00062n-EL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UjKcKZjfqNOztaNAGUvCYkUFXm/hViMltfmNYS5qu0=;
 b=M0CUmwkEJQ0fE68mbHGRpGPYEAnzqc/jhDP7//JuSQiERDrlnQISJemQw0nGzkqqytBCH3
 tsb4SCSVO+6LcEqPbYEyEPutvLwxh5GJuruYZlEj3KsOXbkNoWqbEEAEKwHPalvyw6pEYQ
 OVxrcvo2nZJgzh1HylZAZz8vYRKJVrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-7r5-_at7MmiAxtuZ8MMwcQ-1; Fri,
 11 Sep 2026 12:37:29 -0400
X-MC-Unique: 7r5-_at7MmiAxtuZ8MMwcQ-1
X-Mimecast-MFC-AGG-ID: 7r5-_at7MmiAxtuZ8MMwcQ_1789144648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C9A818009CC; Fri, 11 Sep 2026 16:37:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E28F180029C; Fri, 11 Sep 2026 16:37:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:42 +0400
Subject: [PATCH v5 08/62] qapi/qom: add qapi-type field to ObjectPropertyInfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-8-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC22vY1NTuNn8xf4Y2N4WnLaDZAee/91RI8n9
 xWssgxyd2CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttgAKCRDa6OEJdZac
 5Q4/D/9UJEGdgHDpdj6zOHnBJ05UOg+DQH5luoJV/LmyIBZiQ787g6SbvI4l7n1mwnk9ffFi0AN
 AlAgnEkd/tYkspnXnSJ/Kj6IJPPLy/WOcpHSJqAG2Shzui07drD8f+nXfkHvWq5ni8sqi8tXlGC
 34qA+tRslPaPFjSpCve8Hp8eiF/y5QQI6obqHHzuvbOEkRYbBs3IaxN4dcfHwibdVn3tnH//HNM
 zPsxJtUw+mjDlXq7S3CPKzqD5eJZBQixOvTlAJPk2lmjqHxbVmIKbvdQHcu38YZmHV8KAQgNkQO
 Lm5VlPwjg6dnxKUwwndpPO7jwGskbD1Uih2ql+0SkHhDaT0Tv5VFtA8mNhP8YESwevZtMobmBjV
 zunQ3Q0SELm16vSl35oAd7i9YeZ1szYoOBCMXnNgl194dKjYLW+1Feoh3yCdGPRMVca1RYVehZL
 NvyVrhO1jm2SmU7sv/PwdbJ1560Dys/RexKHUiJ2OiEZ624y6y52mzoLQbhAvHyPTTQ2gctbpLU
 uSgsJFrDCGzru4ITZ6qEcdHQcxn82WNcsYkn100OrHoEGHrpD32M/dxn9mH7lEJjvJPXE5WKxpk
 unwed5NtWdg5RSgGSqSKh45F57ebnpc/yr5sNV2iYgPORFLCqSleihMe0UYNaU1V0pJliMS6N93
 Zts57bEVJZN/m7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


