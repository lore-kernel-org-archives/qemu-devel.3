Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD7DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQ3-0008D0-Qx; Thu, 13 Mar 2025 00:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaPu-0008Cb-MW
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaPs-0006xX-UN
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tkVkMDi/pDIEPFElQS5jxGW3OwmA4wuw2EsIKB9e5dc=;
 b=H0NkuBC/qTM7vySjaGDo2ZMH7U0n4Rp3g0QdgwxHs1K4wikP9xsfpBw/RWD8e2sJmzLuGk
 H/O9EPh5RToohb0PJNTwX/hH5NNsiCyLt8x6AO0a3SsvyVAOBF6pvSqKnEVDk3d8GGKplR
 sEYlojXIcnrvpnJLTrqytVYERbLW0EQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-4uCseuF2OKuIqmlz4bvrqA-1; Thu,
 13 Mar 2025 00:43:27 -0400
X-MC-Unique: 4uCseuF2OKuIqmlz4bvrqA-1
X-Mimecast-MFC-AGG-ID: 4uCseuF2OKuIqmlz4bvrqA_1741841006
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20C5E1956089; Thu, 13 Mar 2025 04:43:25 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4FC21955BCB; Thu, 13 Mar 2025 04:43:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/11] docs/qapi: enable new guest-agent and storage-daemon
 docs
Date: Thu, 13 Mar 2025 00:43:01 -0400
Message-ID: <20250313044312.189276-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add namespaces, turn on QGA and QSD.=0D
=0D
John Snow (11):=0D
  docs/qapi_domain: isolate TYPE_CHECKING imports=0D
  docs/qapi-domain: always store fully qualified name in signode=0D
  docs/qapi_domain: add namespace support to FQN=0D
  docs/qapi-domain: add :namespace: override option=0D
  docs/qapi-domain: add qapi:namespace directive=0D
  docs/qapidoc: add :namespace: option to qapi-doc directive=0D
  docs/qapi_domain: add namespace support to cross-references=0D
  docs/qapi-domain: add namespaced index support=0D
  docs: add QAPI namespace "QMP" to qemu-qmp-ref=0D
  docs: disambiguate references in qapi-domain.rst=0D
  docs: enable transmogrifier for QSD and QGA=0D
=0D
 docs/conf.py                                 |   7 +=0D
 docs/devel/qapi-domain.rst                   |  70 ++++-=0D
 docs/interop/qemu-ga-ref.rst                 |   2 +=0D
 docs/interop/qemu-qmp-ref.rst                |   1 +=0D
 docs/interop/qemu-storage-daemon-qmp-ref.rst |   2 +=0D
 docs/sphinx/qapi_domain.py                   | 297 +++++++++++++------=0D
 docs/sphinx/qapidoc.py                       |  12 +=0D
 qapi/qapi-schema.json                        |   2 +-=0D
 qga/qapi-schema.json                         |   3 +=0D
 storage-daemon/qapi/qapi-schema.json         |   8 +=0D
 10 files changed, 303 insertions(+), 101 deletions(-)=0D
=0D
-- =0D
2.48.1=0D
=0D


