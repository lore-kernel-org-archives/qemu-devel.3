Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E04C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtiB-0003MD-Fr; Mon, 05 Feb 2024 02:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthN-00033F-Qt
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthF-00064N-VV
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SgWvRRVLfDSycZuU/B2MCbto8cA5NTtz5gxWqqYBpE4=;
 b=EQLg7rGSSdC+je9Nr6NSdQrrpMIyLqGPvgsk3hc8uibSKEDJ2nZI/sy2+AySgT0oHuj2hL
 iRWz9bEu/0CX8gP8sEtNAUbzrety0I6uAbTkJFYNEboijdGENizm9BJMSGIsXDAdgXy3A2
 7AbjqOPwBurWDt0SG9iqGeTgUdZ5SQM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-37b8N56mPJSBsKL83P-bdg-1; Mon,
 05 Feb 2024 02:47:12 -0500
X-MC-Unique: 37b8N56mPJSBsKL83P-bdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BA463CBD50E;
 Mon,  5 Feb 2024 07:47:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41DBB40C9444;
 Mon,  5 Feb 2024 07:47:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A2F621E66D0; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 00/15] qapi: Require member documentation (with loophole)
Date: Mon,  5 Feb 2024 08:46:54 +0100
Message-ID: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The QAPI generator forces you to document your stuff.  Except for
command arguments, event data, and members of enum and object types:
these the generator silently "documents" as "Not documented".

We can't require proper documentation there without first fixing all
the offenders.  We've always had too many offenders to pull that off.
Right now, we have more than 500.  Worse, we seem to fix old ones no
faster than we add new ones: in the past year, we fixed 22 ones, but
added 26 new ones.

PATCH 01-05 are bonus fixes & cleanups.

PATCH 06 makes missing documentation an error unless the command,
type, or event is in listed in new pragma documentation-exceptions.

PATCH 07-09 improve the "QEMU Guest Agent Protocol Reference" manual:
they document eight members and arguments, reducing the number of
offending commands and types from nine to one.  The 25 members of type
GuestNVMeSmart are left undocumented.

PATCH 10-15 improve reduce the "QEMU QMP Reference Manual" manual, but
only a bit: they document 54 members and arguments, reducing number of
offending commands and types from 117 to 65.  467 members and
arguments are left undocumented.  A few of them are not actually used
in QMP, and documenting them is not worthwhile; they should be elided
from the manual instead.  Example: DummyForceArrays.

Remaining definitions with undocumented members:

    FILE
        DEFINITION #MISSING
    ----------------------------------------------
    qga/qapi-schema.json
        GuestNVMeSmart 25
    qapi/audio.json
	AudiodevDriver 12
    qapi/block-core.json
	BlkdebugEvent 43
	BlockdevDriver 39
	BlockdevQcow2EncryptionFormat 1
	BlockdevVmdkAdapterType 4
	DummyBlockCoreForceArrays 1
	ImageInfoSpecificKind 2
	IscsiHeaderDigest 4
	IscsiTransport 2
	Qcow2OverlapCheckFlags 8
	RbdAuthMode 2
	RbdImageEncryptionFormat 2
	ThrottleGroupProperties 19
	XDbgBlockGraph 2
	blockdev-reopen 1
    qapi/char.json
	ChardevBackendKind 6
    qapi/common.json
	GrabToggleKeys 6
    qapi/crypto.json
	QCryptoAkCipherKeyType 2
    qapi/cryptodev.json
	QCryptodevBackendServiceType 5
    qapi/cxl.json
	CxlCorErrorType 1
    qapi/introspect.json
	JSONType 8
    qapi/machine-common.json
	CpuS390Entitlement 4
    qapi/machine-target.json
	CpuS390Polarization 2
	query-cpu-model-baseline 2
	query-cpu-model-comparison 2
	query-cpu-model-expansion 2
    qapi/machine.json
	CpuS390State 5
	DummyForceArrays 1
	MemoryDeviceInfoKind 1
	SysEmuTarget 29
	X86CPURegister32 8
    qapi/migration.json
	MigrateSetParameters 1
    qapi/net.json
	NetClientDriver 10
	String 1
    qapi/pci.json
	PciMemoryRegion 1
    qapi/qom.json
	ObjectType 45
    qapi/rocker.json
	query-rocker 1
	query-rocker-ports 1
    qapi/run-state.json
	GuestPanicInformationHyperV 5
	watchdog-set-action 1
    qapi/stats.json
	StatsFilter 1
	StatsValue 1
	query-stats-schemas 1
    qapi/transaction.json
	AbortWrapper 1
	BlockDirtyBitmapAddWrapper 1
	BlockDirtyBitmapMergeWrapper 1
	BlockDirtyBitmapWrapper 1
	BlockdevBackupWrapper 1
	BlockdevSnapshotInternalWrapper 1
	BlockdevSnapshotSyncWrapper 1
	BlockdevSnapshotWrapper 1
	DriveBackupWrapper 1
    qapi/ui.json
	DisplayProtocol 2
	HotKeyMod 3
	InputAxis 2
	InputButton 7
	InputMultiTouchEvent 1
	InputMultiTouchType 5
	KeyValueKind 2
	QKeyCode 119
	VncPrimaryAuth 9
	VncVencryptSubAuth 9
    qapi/virtio.json
	DummyVirtioForceArrays 1
    qapi/yank.json
	YankInstanceType 3

Markus Armbruster (15):
  docs/devel/qapi-code-gen: Normalize version refs x.y.0 to just x.y
  docs/devel/qapi-code-gen: Tweak doc comment whitespace
  qapi/block-core: Fix BlockLatencyHistogramInfo doc markup
  qapi: Indent tagged doc comment sections properly
  sphinx/qapidoc: Drop code to generate doc for simple union tag
  qapi: Require member documentation (with loophole)
  qga/qapi-schema: Clean up documentation of guest-set-memory-blocks
  qga/qapi-schema: Clean up documentation of guest-set-vcpus
  qga/qapi-schema: Plug trivial documentation holes
  qapi/yank: Clean up documentaion of yank
  qapi/dump: Clean up documentation of DumpGuestMemoryCapability
  qapi: Plug trivial documentation holes around former simple unions
  qapi: Improve documentation of file descriptor socket addresses
  qapi: Move @String out of common.json to discourage reuse
  qapi: Add missing union tag documentation

 docs/devel/qapi-code-gen.rst                  | 14 ++--
 docs/sphinx/qapidoc.py                        |  6 --
 qapi/block-core.json                          | 26 ++++++-
 qapi/block-export.json                        |  2 +
 qapi/char.json                                | 28 ++++++++
 qapi/common.json                              | 11 ---
 qapi/crypto.json                              |  2 +
 qapi/dump.json                                |  2 +-
 qapi/machine.json                             | 14 ++++
 qapi/migration.json                           | 48 ++++++-------
 qapi/misc.json                                | 12 ++--
 qapi/net.json                                 | 12 +++-
 qapi/pragma.json                              | 67 +++++++++++++++++++
 qapi/qdev.json                                | 12 ++--
 qapi/sockets.json                             | 48 +++++++++----
 qapi/stats.json                               |  2 +
 qapi/tpm.json                                 |  4 ++
 qapi/transaction.json                         |  2 +
 qapi/ui.json                                  | 14 ++++
 qapi/yank.json                                |  4 +-
 qga/qapi-schema.json                          | 58 ++++++++++------
 include/hw/virtio/vhost-vsock-common.h        |  1 +
 include/net/filter.h                          |  2 +-
 chardev/char-socket.c                         |  2 +-
 util/qemu-sockets.c                           |  3 +-
 scripts/qapi/parser.py                        |  7 +-
 scripts/qapi/source.py                        |  2 +
 .../qapi-schema/doc-bad-alternate-member.json |  2 +
 tests/qapi-schema/doc-good.json               | 14 ++--
 tests/qapi-schema/doc-good.out                |  2 +-
 30 files changed, 317 insertions(+), 106 deletions(-)

-- 
2.43.0


