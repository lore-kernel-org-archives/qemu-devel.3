Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06D0ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZ9a-0007Tp-S8; Tue, 14 Apr 2026 04:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZ9Q-0007TU-AT
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZ9N-0003iV-Vd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W2rAN5fPcIF7SrGv2GjPwSusr1gYWjyFYBjsVcpDLcI=;
 b=IDLiewr73EeqSugWAkkIC2KbS+/Rh9Qwpl5BsIN++731gHxTIs/htPZt08sZNt5sS+NVQ9
 enzHbG9WarGE1alpuRv8zrBwZ2v3Mw6KFfRuH6DuGftMST4SgldZSTSNs68jl56RFXxpK8
 cB5NKbkDcYHehvUTLMABonETs93GRJA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-nkxX8wUvMmiAgqfhR6OFxg-1; Tue, 14 Apr 2026 04:29:34 -0400
X-MC-Unique: nkxX8wUvMmiAgqfhR6OFxg-1
X-Mimecast-MFC-AGG-ID: nkxX8wUvMmiAgqfhR6OFxg_1776155373
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so38426565ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155373; x=1776760173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W2rAN5fPcIF7SrGv2GjPwSusr1gYWjyFYBjsVcpDLcI=;
 b=LinMieLRNQMgG7uLC2vF0OI4QPZ46m/Yctr57CFhenPhIsczSiggr+mXnsbi3Clw3C
 S41CDraOavRkbUv/p6ch04TGMvYRMTvRU29GJ5xjFwbcP5wS8SypX05wZrfFX3v/+79A
 /iEThX98GF7R3HKsKG6pwaPuEmaXfmgyuersoVxa3uFil2wAZcLrE157vJVx5mwmp7FU
 5UOS9qGqJiGLyqUaBOnA/YnepIRMBNuZlnX1iypjDXlrZlgzR1riHkmCGMGzLaRmZcnX
 Vw5ZGXtSipNcfDgO0XZyQzbU7D/HT03HFRsTwDBmEa69U/Z9RpTPv8yszNP2GT5eeBBC
 gYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155373; x=1776760173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2rAN5fPcIF7SrGv2GjPwSusr1gYWjyFYBjsVcpDLcI=;
 b=hvvGs4SlcaIIfhxIiNugQskF0BDxo1vgGdx0AzIpPVJipqKH5gVdqC26G9TYbVq2qY
 5KT34j0uGQXHw95Rwurr7lqWr92wbIucT62L3XwWXlKY48N6OFF3ohlm2QP1YNV1pNxb
 CsRCROI4hQY/tEbtycPhEKSsvEYoO3A25ITIO7/BPAa2wDixyXpih3XoV4meXh4Uizsu
 jX6ScVrRcp8k8otD9y+6eR5hLdZHBV1bADqC89FhC6PV6WX326P/dHr8i15BRTTUwHZW
 nL3cDKLdmioru6DIDLHsC7FaGzEoPIpQNiF6Vwp4VfYM4lMM3GI9eyNhx98rNcI33VWv
 3L7g==
X-Gm-Message-State: AOJu0YxWzuN2EIfaE8i84oJBwTBOCCS95npjXmrW88prrhkyTGU+8m9U
 ZOHFsunzd4i8KvPMrDvRQKVGy2VR6RrYHb9TEvquiGl2xMIQr8w4WwWfAc9je7Wwvw5nYhMcHyY
 tAlcEECP1M7elAoIP2wqbnOiZEBm4RxtoKSz7scH4Ss+PEdQ4QyCdJ/yk4NU0rJGygGkU6j9qms
 DpnWWPlP57W55Bqi6d0GA1AnPVsesKpgp7+7XNTtc=
X-Gm-Gg: AeBDiesW9SaDiCsA9M1m3ITAIYHD0cZV3aBDFhgNe4PThpx98lY8T+y5+0pELw+93c9
 MbHL6jHNNgVsPzLtnNFJKd2gCOWR1orhdhnwcJeJL8kX/8P3f68uJl3Ga34SB3Yh95OV3L79IpD
 MadKNquwYXTcNOqxJIoQesqF0NqPItL71gvtnWt/GdTgD7f+Er0cCJKcCVeeTC0UUajbHESchC+
 0S+v2XfubZ2oUx0v+iFeOXHXtMo8LWHROI3kaIalXnBJzqJZIMqGmRJ+zrOtRLnFTz15iMjWJaL
 Id+0M2gdkRwY83bJLQa6LaIUqCAPGxcxfEG9Z9xF0yL6CsHIsnCLRU+3KeRUf43LZqIoBEFJVtx
 i4GkisumjGO3GfyeivAN4rukB14TVMEG6ZszMrn9IK9ah0pah0sM3aHLzpp/bq7M=
X-Received: by 2002:a17:903:2b05:b0:2b2:ccfb:8387 with SMTP id
 d9443c01a7336-2b2d5a3fab3mr169636755ad.28.1776155372993; 
 Tue, 14 Apr 2026 01:29:32 -0700 (PDT)
X-Received: by 2002:a17:903:2b05:b0:2b2:ccfb:8387 with SMTP id
 d9443c01a7336-2b2d5a3fab3mr169636405ad.28.1776155372387; 
 Tue, 14 Apr 2026 01:29:32 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:29:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 00/10] hw/tpm: CRB chunking capability to handle PQC
Date: Tue, 14 Apr 2026 13:59:05 +0530
Message-ID: <20260414082915.112122-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
   Link: https://lore.kernel.org/all/20260406115247.4879-2-armenon@redhat.com/
2. [PATCH for-11.1] hw: add compat machines for 11.1
   Link: https://lore.kernel.org/all/20260331140347.653404-1-cohuck@redhat.com/

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

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
Based-on: <20260406115247.4879-2-armenon@redhat.com>

Arun Menon (6):
  hw/tpm: Add TPM CRB chunking fields
  hw/tpm: Refactor CRB_CTRL_START register access
  hw/tpm: Add internal buffer state for chunking
  hw/tpm: Implement TPM CRB chunking logic
  test/qtest: Add test for tpm crb chunking
  hw/tpm: Add support for VM migration with TPM CRB chunking

Stefan Berger (4):
  qtests: Enable starting swtpm with a given profile
  tests: Use ML-DSA-87 operations to caused large TPM transfers with CRB
  tpm: Extend TPM TIS buffer size to 8192 bytes
  tests: Use ML-DSA-87 operations to caused large TPM transfers with TIS

 hw/core/machine.c                |   5 +-
 hw/tpm/tpm_crb.c                 | 237 ++++++++++++++++++++++++++++---
 hw/tpm/tpm_tis.h                 |   2 +
 hw/tpm/tpm_tis_common.c          |  23 +++
 hw/tpm/tpm_tis_i2c.c             |  24 +++-
 hw/tpm/tpm_tis_isa.c             |  24 +++-
 hw/tpm/tpm_tis_sysbus.c          |  24 +++-
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  11 ++
 tests/qtest/tpm-tests.c          | 102 ++++++++++++-
 tests/qtest/tpm-tests.h          |   4 +
 tests/qtest/tpm-tis-swtpm-test.c |  11 ++
 tests/qtest/tpm-util.c           | 156 +++++++++++++++++---
 tests/qtest/tpm-util.h           |  10 +-
 14 files changed, 591 insertions(+), 47 deletions(-)

-- 
2.53.0


