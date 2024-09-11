Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6EDEE4997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLTx-0005b0-Vl; Wed, 11 Sep 2024 07:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTu-0005Zd-8X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTs-000125-I1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726053951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vhwCBk2ZWYFWhRFHI8Z/E6euJodSL2HJef4fiXRkQgM=;
 b=SQCjXxLovmCr+8HgCql0Is63o+8RpS6S7r2tcpAQ9RDVGMnb9oXOnEp4yybqLqckcjlz8g
 JwtReCidjlzcbhzr5jvguawsaI10zjgLQwZEnBf2jI3O7V7rVYZTdrBllER7hi9c8nolQ0
 lmUO79gmVIRaQjcct2pXxA3Zqu2xUlc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-IqsZOpF1Nr6iFoUL9ZMMsA-1; Wed,
 11 Sep 2024 07:25:50 -0400
X-MC-Unique: IqsZOpF1Nr6iFoUL9ZMMsA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4AC319560BD; Wed, 11 Sep 2024 11:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D00119560AD; Wed, 11 Sep 2024 11:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1479921E6A28; Wed, 11 Sep 2024 13:25:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, arei.gonglei@huawei.com, pizhenwei@bytedance.com,
 jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jiri@resnulli.us, jsnow@redhat.com
Subject: [PATCH v2 0/8] qapi: Supply some of the missing member documentation
Date: Wed, 11 Sep 2024 13:25:37 +0200
Message-ID: <20240911112545.2248881-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

This series gets a few of modules off the pragma
documentation-exceptions list of shame that require minimal effort.

Many undocumented members still remain:

    module          type or command                     #missing
    ------------------------------------------------------------
    audio           AudiodevDriver                      12
    block-core      BlkdebugEvent                       43
                    BlockdevDriver                      39
                    BlockdevQcow2EncryptionFormat       1
                    BlockdevVmdkAdapterType             4
                    DummyBlockCoreForceArrays           1
                    ImageInfoSpecificKind               2
                    IscsiHeaderDigest                   4
                    IscsiTransport                      2
                    RbdAuthMode                         2
                    RbdImageEncryptionFormat            2
                    ThrottleGroupProperties             19
                    XDbgBlockGraph                      2
                    blockdev-reopen			1
    machine-common  CpuS390Entitlement                  4
    machine-target  CpuS390Polarization                 2
    machine         CpuS390State                        5
                    DummyForceArrays                    1
                    MemoryDeviceInfoKind                1
                    SysEmuTarget                        27
                    X86CPURegister32                    8
    net             NetClientDriver                     10
                    String                              1
    qom             ObjectType                          48
    transaction     AbortWrapper                        1
                    BlockDirtyBitmapAddWrapper          1
                    BlockDirtyBitmapMergeWrapper        1
                    BlockDirtyBitmapWrapper             1
                    BlockdevBackupWrapper               1
                    BlockdevSnapshotInternalWrapper     1
                    BlockdevSnapshotSyncWrapper         1
                    BlockdevSnapshotWrapper             1
                    DriveBackupWrapper                  1
    ui              DisplayProtocol                     2
                    HotKeyMod                           3
                    InputAxis                           2
                    InputButton                         7
                    KeyValueKind                        2
                    QKeyCode                            119
                    VncPrimaryAuth                      9
                    VncVencryptSubAuth                  9
    virtio          DummyVirtioForceArrays              1
    yank            YankInstanceType                    3
    qga             GuestNVMeSmart                      25

Note: The Dummy*ForceArrays are purely internal, and should be elided
from the manual instead, but that's a different project.

Based on my "[PULL 00/19] QAPI patches patches for 2024-09-10" rather
than current master to avoid trivial conflicts in qapi/pragma.json.

Based-on: <20240910164714.1993531-1-armbru@redhat.com>

v2:
* Rebased on latest QAPI PR
* PATCH 1: Tody up a "since" while there [John Snow]
* PATCH 7+8: New

Markus Armbruster (7):
  qapi/char: Supply missing member documentation
  qapi/common: Supply missing member documentation
  qapi/crypto: Supply missing member documentation
  qapi/introspect: Supply missing member documentation
  qapi/pci: Supply missing member documentation
  qapi/rocker: Supply missing member documentation
  qapi/cxl: Supply missing member documentation

Zhenwei Pi (1):
  qapi: Document QCryptodevBackendServiceType

 qapi/char.json       | 44 ++++++++++++++++++++++++++++----------------
 qapi/common.json     | 14 +++++++++++++-
 qapi/crypto.json     |  4 ++++
 qapi/cryptodev.json  | 10 ++++++++++
 qapi/cxl.json        |  3 +++
 qapi/introspect.json | 16 ++++++++++++++++
 qapi/pci.json        |  2 ++
 qapi/pragma.json     | 11 +----------
 qapi/rocker.json     |  4 ++++
 9 files changed, 81 insertions(+), 27 deletions(-)

-- 
2.46.0


