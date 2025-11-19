Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48192CF34AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhwH-0000Pw-0f; Wed, 19 Nov 2025 08:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLhvt-000056-J1
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLhvp-00036v-Ml
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763557748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Js6BO4VeBey2OiZe7AjXj3GXLYuEHV85DWPD2FEQA2I=;
 b=C29Is0ujG1XXyz/FtjNuYxoFFXUXTsShKG9WJtMrG1ghsyelFcqFGH5atcBiRy1b/3TxPG
 p88JRqYQMiCraA/rnmpJRLaDIEZpy+CS6OpMVDQMkJAJL5ignENRNJmDJhRqX5b55jQurg
 39Dy48qiVHVNZGu7XDWRyQjxa/Cg/JY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-WePI68LnPQCITVv1F2bMiQ-1; Wed,
 19 Nov 2025 08:09:04 -0500
X-MC-Unique: WePI68LnPQCITVv1F2bMiQ-1
X-Mimecast-MFC-AGG-ID: WePI68LnPQCITVv1F2bMiQ_1763557741
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E5D219560AD; Wed, 19 Nov 2025 13:09:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720CA180047F; Wed, 19 Nov 2025 13:08:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 766DA21E6A27; Wed, 19 Nov 2025 14:08:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
Subject: [PATCH 0/5] A bit of cleanup around Error
Date: Wed, 19 Nov 2025 14:08:50 +0100
Message-ID: <20251119130855.105479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Note: the last patch adds a drive-by FIXME.  I asked for advice on how
to fix it:

    Subject: Incorrect error handling in xen_enable_tpm()
    To: qemu-devel@nongnu.org
    Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony@xenproject.org>, Paul
     Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
     xen-devel@lists.xenproject.org, Vikram Garhwal <vikram.garhwal@amd.com> 
    Date: Fri, 14 Nov 2025 10:16:58 +0100
    Message-ID: <87jyzt0y9h.fsf@pond.sub.org>

No reply so far.

Markus Armbruster (5):
  hw/core/loader: Make load_elf_hdr() return bool, simplify caller
  hw/nvram/xlnx-bbram: More idiomatic and simpler error reporting
  nbd/client-connection: Replace error_propagate() by assignment
  error: error_free(NULL) is safe, drop unnecessary conditionals
  error: Consistently name Error * objects err, and not errp

 include/hw/loader.h         |  4 +++-
 block/crypto.c              |  8 ++++----
 hw/acpi/ghes.c              |  8 ++++----
 hw/acpi/pcihp.c             |  4 +---
 hw/arm/boot.c               |  6 +-----
 hw/core/loader.c            |  8 ++++++--
 hw/nvram/xlnx-bbram.c       | 18 ++++--------------
 hw/ppc/spapr.c              | 16 ++++++++--------
 hw/riscv/spike.c            | 10 +---------
 hw/xen/xen-pvh-common.c     | 13 ++++++++++---
 io/channel-websock.c        |  4 +---
 io/task.c                   |  4 +---
 migration/migration.c       |  6 ++----
 nbd/client-connection.c     |  3 +--
 nbd/common.c                |  6 +++---
 tests/unit/test-smp-parse.c |  5 +----
 16 files changed, 51 insertions(+), 72 deletions(-)

-- 
2.49.0


