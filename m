Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EC2CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9P-0004u9-QL; Wed, 06 May 2026 03:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9O-0004tX-4N
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9L-0000bU-QL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n40BxiZzWNA7TuKxnmwNj5nS/1nPkGLYu3DAPy4QD9U=;
 b=LZ54rPHiDIX7SAvmy3xRg9dSi5j2aSPcBiLwr5j3pfGlK6h/h3xPAXqeb+J+0BCqKFRVQB
 0yHDqXFrVBxY7XI3cNKBMXlrc3MqQFQEq7Y7z7z8+XYek1ZSQnphC4mwIziUtDnVCGaZW5
 CKD5ZBKln/cAcNhve6y5vkd0FsHTgow=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2onX61QoN5meBtZJn3NjUA-1; Wed, 06 May 2026 03:58:29 -0400
X-MC-Unique: 2onX61QoN5meBtZJn3NjUA-1
X-Mimecast-MFC-AGG-ID: 2onX61QoN5meBtZJn3NjUA_1778054308
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b7c904d476so50977805ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054308; x=1778659108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n40BxiZzWNA7TuKxnmwNj5nS/1nPkGLYu3DAPy4QD9U=;
 b=qynYCiJshr66FvgKtIIlWnCUtEnuHpfstZQ/GuXAthGFP7ILg3qlkJCo4wCTHqflU6
 nWZuYDLbtxk7nUy6cHEz+fOHMfMoYxFrOc6qRRZqKG87lgbseBuXJfXSfplmfeCL3hlG
 SaCimwEeQJluwzSRAAicpROZabWxbf99SBuzbABjoMI9rnzUzm0bVJAB47CDilzmOBj/
 094Q859vbb6T08WDiU9+BvhUDn74CN3lc8xsAitrHpnV9orXMvGd8LDzdlgDGMxrX/sK
 oVNePPuda56JZ1/gGDFatO0RgguZbNiPHGMQv7kQkWfaNxz5Hd6bmq6xBLkcYO9xXh8l
 +AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054308; x=1778659108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n40BxiZzWNA7TuKxnmwNj5nS/1nPkGLYu3DAPy4QD9U=;
 b=EQ6Z4j5FVQJntsPL4Mx4pMVOx8XsRJYhBn2Zm50w825GUoW2CJDHe67NayqYbM/8LN
 zDOkM6V/wBXD6M+tYViHi3zyh0cS9Zqo/xqLvxR0e4HTZiWFobOwDaZXluX4D6upw20I
 XXEfIVtPnLNDp5PASYUHUfjW/PSmOTKg6Zk60drd5JqNULeFRpynanHOCGtlW344gltu
 pQNspcUjAAN9kKDFUN4q6CIT3xWtna8wuwvL9X7VhlmZPqhwuFUHPBhumP8LUUfs/n6P
 RR3ma9gih9AIiOmjeyrBhLhsiiCMMY/1nqT/glSG7XecJGL4hdX5wyCTsDDK5FWLr6xT
 YvOA==
X-Gm-Message-State: AOJu0YzxL3kdROw52PV+kp0N3lMFxSlKNZ3gABslVDFPZta9WpK1N4Da
 ifTuO16RzgjgghVZJKySyOw2hD+lyqrAFxeAdC3ciHos+t8KlT5D2ZZEW6SyX6sWeBAQ3QWOnOD
 M4IbJ885EnFJ+ZJFdmSFDEwqzYfZxgsTqQT/6FsePvOlG/AXvs5ACNirWG6umaSXYEBIyea73qZ
 cm/WA7NY7qVjZBQ37Yq9PMCkta8xkHJbIMu+fwtcc=
X-Gm-Gg: AeBDieuC34/plPu/HzGcM58jVDm23Gg3fzsHibgUnTdjTLS5gF8iO/sHXgQQhbEy9ez
 m4zDLbU/ijOHj2U0fL5kC2dIIHlLm7RuXhYjMXar0fsB1+VoEgAjmn8Rtq6dELouSAhfOXUfmWa
 B8SWG1/voVMwK6G4/nqJfUXtah+gDoAJ90Yd1F90DYRCy87UBSeLO8OdfH4o7GsnMlm4bfav7v9
 BtztMMDpcaRyARTGzkUDOTqfQFrJC7qLRXl9+HRuekwo7DKgnvb53IzVGmmk8uKo/RvotNlqKQ6
 asfwgnywdIqocA65mQM9rtgc9HOt7JPG2Hpvl0FYs9VM3Wyv/NBhkhaWe7RzG0rEXv5sgYTJ8il
 KfBrB0YljPZ6J8AcH2j4VWnIWuCux9YIpMztfGEeb1Iftjj5UF9QphcmzIYsMA8ApOYjVA0An
X-Received: by 2002:a17:903:13cf:b0:2ba:1756:aea7 with SMTP id
 d9443c01a7336-2ba78b4402cmr24082385ad.2.1778054302906; 
 Wed, 06 May 2026 00:58:22 -0700 (PDT)
X-Received: by 2002:a17:903:13cf:b0:2ba:1756:aea7 with SMTP id
 d9443c01a7336-2ba78b4402cmr24081955ad.2.1778054302241; 
 Wed, 06 May 2026 00:58:22 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v7 0/6] hw/tpm: CRB chunking capability to handle PQC
Date: Wed,  6 May 2026 13:28:07 +0530
Message-ID: <20260506075813.120781-1-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The move to Post Quantum Cryptography (PQC) changes how we manage
memory buffers. Unlike classic crypto algorithms like RSA or ECC which
used small keys and signatures, PQC algorithms require larger buffers.

The new version of TCG TPM v185 (currently under review [1]) supports
sending data/commands in chunks for the CRB (Command Response Buffer)
interface. This is in line with the initiative to support PQC algorithms.

This series implements the logic to send and receive data from the
linux guest to the TPM backend in chunks, thereby allowing the
guest to send larger data buffers. We introduce 2 new control registers
called nextChunk and crbRspRetry that will control the START. We also
add the CRB Interface Identifier called CapCRBChunk that is set to 1
indicating that the device supports chunking. The default maximum
chunk/buffer size is 3968 (4096 - 128) bytes.

During a send operation, the guest driver places data in the CRB buffer
and signals nextChunk for each segment until the final chunk is reached.
Upon receiving the START signal, QEMU appends the final chunk to its
internal buffer and dispatches the complete command to the TPM backend.

For responses, the backend's output is buffered. The guest consumes the
first chunk once the START bit is cleared. Subsequent chunks are
retrieved by the guest toggling the nextChunk bit, which advances the
internal buffer offset and populates the CRB data window.

For this to work, the linux guest tpm driver will also have to
a) probe if CRB chunking is supported
b) send data in chunks if the command length exceeds the chunk size.
c) receive data in chunks by sending a nextChunk signal and accumulate.
These patches are posted upstream:
https://lore.kernel.org/lkml/20260324181244.17741-1-armenon@redhat.com/

Dependencies:
This series has a hard dependency on the following patches currently on
the mailing list. They must be applied first for this series to function
correctly:
1. [PATCH 1/2] migration/vmstate: Add VMState support for GByteArray
   Link: https://lore.kernel.org/all/20260422082214.10390-2-armenon@redhat.com/
2. [PATCH for-11.1] hw: add compat machines for 11.1
   Link: https://lore.kernel.org/all/20260331140347.653404-1-cohuck@redhat.com/

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

v7
--
- Removed error_free() after calling migrate_del_blocker
- Typo fix be_bufer_size to be_buffer_size, and removed a redundant
  check.

v6
--
- Removed Stefan Berger's patches to make this series CRB-only. The
  complex TIS changes will be posted later.
- Added a comment in the post_load hook.

v5
--
- Expose cap-chunk only if the binary is run with the new machine type
  (>11.1). Remove migrate-buffers as this property is not needed.
- Add x-allow-chunk-migration internal property that will help in
  blocking migration from a source with 11.1 binary and pre 11.1 machine
  type to pre 11.1 binary and pre 11.1 machine type.
  In this case, the source supports cap-chunk, but the destination binary
  is unaware of the new buffers.
- Add post_load_errp hook, to validate the buffers before the VM is
  started at the destination.
- Check if cap-chunk is true before processing nextChunk and crbRspRetry
  from the guest. Patches 01, 04 and 06 have undergone changes.

v4
--
- Add migration blocker to prevent data loss and new hw_compat property
  called cap_chunk. The chunking feature is now only visible to machine
  type 11.1 and higher.
- Rename invoke to Start, to comply with the TCG TPM specification.
- Use g_clear_pointer for safety.

v3
--
Patches 1-6
- Fix the issue with subsequent nextChunk signal from the guest while
  the TPM backend is not done processing the previous request.
- Add tpm_crb_unrealize() to clear buffers
- Update hw_compat to 11.1.
- Use newly introduced GByteArray VMStateInfo for migration.
Patches 7-10
- Add Stefan Berger's patches for swtpm profile support, TPM TIS
  migration support with extended buffer and related tests.
  NOTE: I have removed the "WIP" prefix and the "TODO" regarding dynamic
  allocation from Stefan's final patch, as the static 8192-byte limit is
  sufficient for the current requirements and passes all local testing.

v2
--
- Add the VM migration support.
- Increase the TIS TPM interface max buffer size to 8192.

Based-on: <20260331140347.653404-1-cohuck@redhat.com>
Based-on: <20260422082214.10390-2-armenon@redhat.com>

Arun Menon (6):
  hw/tpm: Add TPM CRB chunking fields
  hw/tpm: Refactor CRB_CTRL_START register access
  hw/tpm: Add internal buffer state for chunking
  hw/tpm: Implement TPM CRB chunking logic
  test/qtest: Add test for tpm crb chunking
  hw/tpm: Add support for VM migration with TPM CRB chunking

 hw/core/machine.c                |   5 +-
 hw/tpm/tpm_crb.c                 | 253 ++++++++++++++++++++++++++++---
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  10 ++
 tests/qtest/tpm-util.c           | 109 +++++++++++--
 tests/qtest/tpm-util.h           |   5 +
 6 files changed, 351 insertions(+), 36 deletions(-)

-- 
2.54.0


