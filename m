Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FCBCF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svu1x-0006rG-Gq; Wed, 02 Oct 2024 03:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svu1v-0006p1-DG
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svu1t-0008Oe-UE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727855053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JW4VGa89vYmRv+8xs0N4oACOwKfQgr/eCHimMYMqzig=;
 b=imMIChzrr8ao5+kA66sz+LhSFFfNZjerHuqJtiUFJe2+f6YaPW2teuxQUPN8aq1t6DoswN
 NERX+Qq8HhynbaWMdb8EP4GRlwkttErAiU1S3Rc+roszewpSBBWq6S86L1ohBRfZr5Ku70
 RginapnzzKAdkjJCYPgKWEjok9NqLkQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-0aLi9bRANQCsfOBbg4IkMg-1; Wed,
 02 Oct 2024 03:44:09 -0400
X-MC-Unique: 0aLi9bRANQCsfOBbg4IkMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EFEC1955F45; Wed,  2 Oct 2024 07:44:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C536919560A2; Wed,  2 Oct 2024 07:44:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D37DD21E6A28; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/10] QAPI patches patches for 2024-10-02
Date: Wed,  2 Oct 2024 09:43:54 +0200
Message-ID: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:

  Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-10-02

for you to fetch changes up to b3bd7617dbae8e5f84c27a1ab8df89cba371a276:

  qapi/block-core: Drop drive-backup's "Any other error" documentation (2024-10-02 09:10:01 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-10-02

----------------------------------------------------------------
Markus Armbruster (9):
      qapi/char: Supply missing member documentation
      qapi/common: Supply missing member documentation
      qapi/crypto: Supply missing member documentation
      qapi/introspect: Supply missing member documentation
      qapi/pci: Supply missing member documentation
      qapi/rocker: Supply missing member documentation
      qapi/cxl: Supply missing member documentation
      qapi: Drop "with an explanation" from error descriptions
      qapi/block-core: Drop drive-backup's "Any other error" documentation

Zhenwei Pi (1):
      qapi: Document QCryptodevBackendServiceType

 qapi/block-core.json | 12 +++++-------
 qapi/char.json       | 44 ++++++++++++++++++++++++++++----------------
 qapi/common.json     | 14 +++++++++++++-
 qapi/crypto.json     |  4 ++++
 qapi/cryptodev.json  | 10 ++++++++++
 qapi/cxl.json        |  3 +++
 qapi/introspect.json | 16 ++++++++++++++++
 qapi/pci.json        |  2 ++
 qapi/pragma.json     | 11 +----------
 qapi/rocker.json     |  4 ++++
 10 files changed, 86 insertions(+), 34 deletions(-)

-- 
2.46.0


