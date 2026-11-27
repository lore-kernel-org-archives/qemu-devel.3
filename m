Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A12606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MSQRmD9i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWrE9-0005XB-4E; Fri, 27 Nov 2026 03:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWrE6-0005VU-5J
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:22:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWrE4-0004TS-Ar
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795767756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jG1aP347qO/KLAwgo5lAIpdbHTXW6q8QszWbXW7v4Jk=;
 b=MSQRmD9i7dtSsIv0Dezl966A16uJijflyZb6WgAAVE8kLXYsxBvDHFki/M3MEqxeM2wr/v
 qZDP6iYwwnqbCSh5VColKhtGOQJazCX51JcrZPpniORKk72Z6jLB+IU8ShXP8KhoG8HH8B
 gfdG+wr1Pb2PMQpez3DQj8W606pPwmk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-paAwE8d2PbWbcp-dPvDwcQ-1; Fri,
 27 Nov 2026 08:22:32 +0000
X-MC-Unique: paAwE8d2PbWbcp-dPvDwcQ-1
X-Mimecast-MFC-AGG-ID: paAwE8d2PbWbcp-dPvDwcQ_1795767751
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E12B19560AA; Fri, 27 Nov 2026 08:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4561801A70; Fri, 27 Nov 2026 08:22:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A929A21E6880; Fri, 27 Nov 2026 09:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 2/4] python/qemu: Don't choke on unknown members in QMP replies
Date: Fri, 27 Nov 2026 09:22:26 +0100
Message-ID: <20261127082228.3907768-3-armbru@redhat.com>
In-Reply-To: <20261127082228.3907768-1-armbru@redhat.com>
References: <20261127082228.3907768-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The recent addition of @qapi-type to ObjectPropertyInfo and
ObjectPropertyValue broke the corresponding classes in
qemu/utils/qom_common.  Reproducer:

    $ bld/run qom-list -s qmp-socket /chardevs
    Traceback (most recent call last):
      File "/work/armbru/qemu/bld/pyvenv/bin/qom-list", line 8, in <module>
        sys.exit(QOMList.entry_point())
                 ~~~~~~~~~~~~~~~~~~~^^
      File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 230, in entry_point
        return cls.command_runner(args)
               ~~~~~~~~~~~~~~~~~~^^^^^^
      File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 215, in command_runner
        return cmd.run()
               ~~~~~~~^^
      File "/work/armbru/qemu/python/qemu/utils/qom.py", line 179, in run
        rsp = self.qom_list(self.path)
      File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 192, in qom_list
        return [ObjectPropertyInfo.make(x) for x in rsp]
                ~~~~~~~~~~~~~~~~~~~~~~~^^^
      File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 52, in make
        assert value.keys() <= {'name', 'type', 'description', 'default-value'}
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    AssertionError

This asserts "no members we don't know".  There are two more like it.

Adding @qapi-type broke them.

docs/devel/qapi-code-gen.rst section "Compatibility considerations"
stipulates that "clients are expected to ignore [members] they don't
know."

Delete / relax these assertions.

Fixes: 0eee31cf1085 ("qapi/qom: add qapi-type to qom-list, qom-list-properties, qom-list-get")
Fixes: c750c02891a8 ("python/qmp: Add qom script rewrites")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261118182005.1066151-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 python/qemu/utils/qom_common.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index ab21a4d364a..e5bae1c7421 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -49,7 +49,6 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyInfo':
         Build an ObjectPropertyInfo from a Dict with an unknown shape.
         """
         assert value.keys() >= {'name', 'type'}
-        assert value.keys() <= {'name', 'type', 'description', 'default-value'}
         return cls(value['name'], value['type'],
                    value.get('description'),
                    value.get('default-value'))
@@ -80,7 +79,6 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyValue':
         Build an ObjectPropertyValue from a Dict with an unknown shape.
         """
         assert value.keys() >= {'name', 'type'}
-        assert value.keys() <= {'name', 'type', 'value'}
         return cls(value['name'], value['type'], value.get('value'))
 
     @property
@@ -103,7 +101,7 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectPropertiesValues':
         """
         Build an ObjectPropertiesValues from a Dict with an unknown shape.
         """
-        assert value.keys() == {'properties'}
+        assert value.keys() <= {'properties'}
         props = [ObjectPropertyValue(item['name'],
                                      item['type'],
                                      item.get('value'))
-- 
2.55.0


