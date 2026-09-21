Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB9CC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8l00-0007BO-BV; Mon, 21 Sep 2026 16:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8kzn-00078D-Ej
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8kzf-0002NK-Q6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790023927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cPfUi00zWb0hlb1IyZnX1pKGZhYjpOGs/oMhD040B9g=;
 b=DKVwVB0U0UKx83slpDUjl0lq/BH5tJbFvR2ws+CkQTvba2VkQUdLlO8CQoroz/22Qu6/u4
 1a7u7snZduQX2aIRmdXjjQ0MEPBucDTJJjXDPidI+3NIka+YvNX7DjClaNg3OX7LdQlBot
 BK5CmkUiTWSPjp7ZF6mwsYmXRr/5DR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-BiAitJDGNQm2kDl_Btk-oA-1; Mon,
 21 Sep 2026 16:52:01 -0400
X-MC-Unique: BiAitJDGNQm2kDl_Btk-oA-1
X-Mimecast-MFC-AGG-ID: BiAitJDGNQm2kDl_Btk-oA_1790023920
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67BC7180B5D6; Mon, 21 Sep 2026 20:51:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1C1140E; Mon, 21 Sep 2026 20:51:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 0/9] qapi: convert intros for qga, firmware, etc
Date: Mon, 21 Sep 2026 16:51:38 -0400
Message-ID: <20260921205147.1857168-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

One day I will send patches that do something else.=0D
Today is not that day.=0D
=0D
John Snow (9):=0D
  qapi: convert remaining simple sections=0D
  qapi: convert intro sections for unit tests=0D
  qapi: convert trivial intros for qga/qapi-schema.json=0D
  qapi: convert simple intros for qga/qapi-schema.json=0D
  qapi: split intros at natural cutoff points for qga/qapi-schema.json=0D
  qapi: split intros for qga/qapi-schema.json=0D
  qapi: convert intro sections for docs/interop/firmware.json=0D
  qapi: convert intro sections for docs/interop/vhost-user.json=0D
  tests/qapi: generate output in source order=0D
=0D
 docs/interop/firmware.json                    |  76 +++---=0D
 docs/interop/vhost-user.json                  |  27 +-=0D
 qapi/block.json                               |   5 +-=0D
 qapi/machine-s390x.json                       |   3 +-=0D
 qapi/machine.json                             |   3 +-=0D
 qapi/net.json                                 |  24 +-=0D
 qga/qapi-schema.json                          | 249 +++++++-----------=0D
 tests/qapi-schema/doc-good.json               |  10 +-=0D
 tests/qapi-schema/doc-good.out                |  95 ++++---=0D
 tests/qapi-schema/doc-interleaved-section.err |   2 +-=0D
 .../qapi-schema/doc-interleaved-section.json  |   3 +-=0D
 tests/qapi-schema/test-qapi.py                |   9 +-=0D
 12 files changed, 206 insertions(+), 300 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


