Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB47C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20D-0006IX-Mr; Fri, 14 Mar 2025 06:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20A-0006Hk-Ms
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt208-00021f-0K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=boUm2Mks8QkQ897Jh1jsnRUHeuiVY3tcnMKEEJ7liuY=;
 b=EPugdb+rJKntEFVyuSw4RT0CPxOtisMa4EDfmE+j4QKjnTN5sxIxx357UjcUxeXtG5rOzr
 ymwr8uSBbNFFMAdPL2ndtMkX1bD4SKWxVaf8QEriylFJlxYlbzp1/c7GT3yyoaLWC03mxt
 W6OEw2z+tlJsDhToz4it8r33jy7Xak0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-QQnXkkzbPwepRnLF-on4JA-1; Fri,
 14 Mar 2025 06:10:44 -0400
X-MC-Unique: QQnXkkzbPwepRnLF-on4JA-1
X-Mimecast-MFC-AGG-ID: QQnXkkzbPwepRnLF-on4JA_1741947043
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA3CF1955E92
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FBD21954B32
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B799421E675F; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/12] QAPI patches patches for 2025-03-14
Date: Fri, 14 Mar 2025 11:10:26 +0100
Message-ID: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 0462a32b4f63b2448b4a196381138afd50719dc4:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-03-14 09:31:13 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-03-14

for you to fetch changes up to a6af54434400099b8afd59ba036cf9a662006d1e:

  docs: enable transmogrifier for QSD and QGA (2025-03-14 07:32:41 +0100)

----------------------------------------------------------------
QAPI patches patches for 2025-03-14

----------------------------------------------------------------
John Snow (11):
      docs/qapi_domain: isolate TYPE_CHECKING imports
      docs/qapi-domain: always store fully qualified name in signode
      docs/qapi_domain: add namespace support to FQN
      docs/qapi-domain: add :namespace: override option
      docs/qapi-domain: add qapi:namespace directive
      docs/qapidoc: add :namespace: option to qapi-doc directive
      docs/qapi_domain: add namespace support to cross-references
      docs/qapi-domain: add namespaced index support
      docs: add QAPI namespace "QMP" to qemu-qmp-ref
      docs: disambiguate references in qapi-domain.rst
      docs: enable transmogrifier for QSD and QGA

Markus Armbruster (1):
      qapi/block-core: Improve x-blockdev-change documentation

 docs/conf.py                                 |   7 +
 docs/devel/qapi-domain.rst                   |  70 +++++--
 docs/interop/qemu-ga-ref.rst                 |   2 +
 docs/interop/qemu-qmp-ref.rst                |   1 +
 docs/interop/qemu-storage-daemon-qmp-ref.rst |   2 +
 docs/sphinx/qapi_domain.py                   | 297 +++++++++++++++++++--------
 docs/sphinx/qapidoc.py                       |  12 ++
 qapi/block-core.json                         |  28 ++-
 qapi/qapi-schema.json                        |   2 +-
 qga/qapi-schema.json                         |   3 +
 storage-daemon/qapi/qapi-schema.json         |   8 +
 11 files changed, 315 insertions(+), 117 deletions(-)

-- 
2.48.1


