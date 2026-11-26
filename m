Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bhv7D4cB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIv-0008Lv-Vy; Thu, 26 Nov 2026 05:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIb-000891-6l
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-0006gy-Mg
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jRuQtKWXsw8xjP3Y8zAUSVvZyJx78bUbweo6OikbzOI=;
 b=Bhv7D4cBZMFXGUnntIgvhrDKUfhPghBsYNbyoF09Xg85OQCEUlJ+i6kNomH8tKTGBQM2AJ
 r3xjPqGqiTlFvdU9rTz+xAL8Q3cBS8saiY7OogtpttBPh11TUnw1xqjUK17ue/KTGe8xcP
 Zh5mYWgMc0ODAaROOFVjxeNCIx0jk3g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-FqPud7SnNfmMj4qGJj08iQ-1; Thu,
 26 Nov 2026 10:01:43 +0000
X-MC-Unique: FqPud7SnNfmMj4qGJj08iQ-1
X-Mimecast-MFC-AGG-ID: FqPud7SnNfmMj4qGJj08iQ_1795687302
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A88CF1955F18; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FE301956087; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B781721E6A04; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 00/16] qom qapi: QOM introspection interface cleanup
Date: Thu, 26 Nov 2026 11:01:23 +0100
Message-ID: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QOM introspection provides a "type" value that qom/object.h calls
"pretty loosely defined".  This lack of discipline has turned out to
be problematic.  There's a zoo of "well-known" values consumers need
to know, and these are documented by handwaving or not at all.  The
values for child and link properties need to be parsed, which is an
anti-pattern for QMP.

Marc-André's "qom/qdev: associate properties with QAPI schema types"
provided a much better alternative: a "qapi-type" that can be looked
up in output of query-qmp-schema.

Except we still need to parse "type" to recognize and make sense of
QOM link and child properties.  My series closes this gap.

Three parts:

* PATCH 01-08 replace most uses of ObjectProperty member @type.  After
  PATCH 08, only printing help in type_print_class_properties() and
  copying to result "type" of QMP commands qom-list,
  qom-list-properties, qom-list-get remain.

* PATCH 09-15 eliminates in-tree uses of this result.

* PATCH 16 deprecates this result.

This is for 12.0, obviously.

Based-on: <20261117103629.2612744-1-armbru@redhat.com>
Based-on: <20261117105945.2802923-1-armbru@redhat.com>
Based-on: <20261118182005.1066151-1-armbru@redhat.com>

Markus Armbruster (16):
  util: Move QMP command query-command-line-options back to util/
  util: Wean query-command-line-options off ObjectProperty member @type
  monitor: Fix query-command-line-options for -machine integer
    parameters
  qom: New ObjectProperty member @qom_type
  qom: Inline object_property_get_type() into its only caller
  qom: Simplify object_resolve_link()
  qom: Wean "is child?" checks off ObjectProperty member @type
  qom: Wean "is link?" checks off ObjectProperty member @type
  qom: Extend ObjectPropertyInfo so clients don't have to parse @type
  qom: Wean HMP commands off ObjectPropertyInfo member @type
  tests: Wean off ObjectPropertyInfo member @type
  python/qemu: Wean off ObjectPropertyInfo member @type
  qom: Extend ObjectPropertyValue so clients don't have to parse @type
  tests: Wean off ObjectPropertyValue member @type
  python/qemu: Wean off ObjectPropertyValue member @type
  qom: Deprecate ObjectPropertyInfo, ObjectPropertyValue member @type

 docs/about/deprecated.rst                     |  5 ++
 qapi/qom.json                                 | 74 +++++++++++++++----
 include/qom/object.h                          | 15 +---
 hw/ppc/spapr_drc.c                            |  4 +-
 qom/object.c                                  | 56 +++++++-------
 qom/qom-hmp-cmds.c                            |  2 +-
 qom/qom-qmp-cmds.c                            | 18 +++++
 tests/qtest/device-introspect-test.c          |  4 +-
 tests/qtest/qom-test.c                        |  8 +-
 tests/qtest/readconfig-test.c                 |  5 +-
 .../qemu-config-qmp-cmds.c                    |  9 ++-
 monitor/meson.build                           |  1 -
 python/qemu/utils/qom.py                      |  2 +-
 python/qemu/utils/qom_common.py               | 28 ++++---
 util/meson.build                              |  3 +-
 15 files changed, 151 insertions(+), 83 deletions(-)
 rename monitor/qemu-config-qmp.c => util/qemu-config-qmp-cmds.c (96%)

-- 
2.55.0


