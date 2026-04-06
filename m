Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3B6F46C48
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9km3-0003rm-M7; Mon, 06 Apr 2026 10:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9km1-0003rS-FN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9klz-0004zF-AN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mk/AFvqMKYlGd/xuxjIjFPJlbZ31peLNGQtW6CDi0Ak=;
 b=iygO02i3a9xXgK7r2KU2w4yy4Zax/oDX/lv7SsEpVEQwxJVfJXyfbHt73IF7lVr0fPC4t4
 uHIihwTyq24/KLWUWc/1+r59ZQhfeiVKezJbXwexmaro77Jq0k9CVwlVJaXTkmQBPjWYYl
 a2RwnJ5WMUZoirX611PsaeHS7+NLaTU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-bS6KcdpfNl6p7dbYvT6FiA-1; Mon, 06 Apr 2026 10:17:48 -0400
X-MC-Unique: bS6KcdpfNl6p7dbYvT6FiA-1
X-Mimecast-MFC-AGG-ID: bS6KcdpfNl6p7dbYvT6FiA_1775485067
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2454fc131so71206835ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485067; x=1776089867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mk/AFvqMKYlGd/xuxjIjFPJlbZ31peLNGQtW6CDi0Ak=;
 b=qkYGfhrAugXuhVWpK1wJSRFdqS1cx4fzU4xq037MiucE8xzP3GZ660oAh/F97px4Nh
 vRo9w6f4qcVW6ztV4ZNC4v7uIGWYLwP+ZDCIN1JtFMFWmBrjftZVHIDtvNPF4zArKhky
 u589uD6BOHelttQSbz4RBcC/POkqmKIM2rj8B5txU/IzTzzBxcIUaScFgWzVH7zsvosP
 56CXR/uwkei+qHYoyyPz72YLF76BKPeuJGCK6YhmtjcT+p6mZ/ugtmYsE93mPjec0NFd
 IswzirKScGsKCZizTHQ18yhBri6+U/FqzgGX5t0ierMdkg8GjqIjgeCnXNlLc+o8cEST
 SGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485067; x=1776089867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mk/AFvqMKYlGd/xuxjIjFPJlbZ31peLNGQtW6CDi0Ak=;
 b=FxOUhgMa23bkkNm5akEzpM8hygLGYskMuqFSZs8fiHvyWhWGhQMgUdoMu+RCHz8ZlK
 ymDQl9Nku2HUgxVkVaq2zS2gz1p9zTc7/cSrR4L8dsmdOGLpcFK3hk4YP/5BGdpLsDgc
 PqFM7YUbo2Ro6an5VXcepXtHhiCzjk3ESUIkAzb1xmaW1av3WvMIXYhF9miFHdmYpkxp
 9clgaBhzuhfb3QRnQLwoPSfps42pTpjykHEWjkTeJdoIjjFodRk4sy3oZ0PKcFGfXCMF
 Nb0K5RvZofu72cPCLphya+WWBOjKhlhwkG9ERkR77UpwZWX/Y7JN95uxXNqggNTBHvl1
 epnw==
X-Gm-Message-State: AOJu0Yz7Mp5I5qRRmmjVHhoSO7/wT/1KegC/Ol8oQZ+A864CSBMSMDFY
 dzWBxxvTPX2NTdtcRxGLAHoduuKHVI+qWBNJJzitLsxRXIFCyJzuoZBKmoYpQewoQ0LcW5Qkbnr
 blTbQFxY87SDS5sivCK8ke2vb2yLIOUeZFDVE7BTGBpBUrceSqXtY6jeD5T+R2Z5qyQzPsk/STY
 8gu0RA1+JCXTU6y+jcx8czGU2nYNtg+8xNHO89S4Q=
X-Gm-Gg: AeBDieuBLUhk2mJrJEJUGHQPTE2wUdOSLcBLdfr/kYZ5ZRr5DOa/Al4YbkcZQgCKcME
 aNpTU8y3U02suVrKf3aQ08ugukEevQ8ugqNp90hh9Mrm+W8AB9tkiplg00vQrDCm3levSHYC7DN
 49Zp64MXKAlIACyrxftrG/IAJ9pdw77aTAsxWB+hz5PCNcoZHbbW++YTYgmDNAWB+Kd4zPpJbk1
 fgHJdNiOBFgKFYrcz8wGZvOAQ4Wxw7vNcNbVa5fBJ627EPZoc72gBASitJR4ffjN+DwLfFcWebp
 M6ILFe9pX0xlB+EFCYkwkbvRoLbzBzUI8b1JM2dU+yhf8IznyIsiqnWxQT3U9LEGsUviEeFXWiB
 VakEEK2AcMR8Pd0BTuyu7jIp78tQLGveFkfRHXixET9vFLUTrZemNETA7B2ZS0UK6vF4=
X-Received: by 2002:a17:903:8c5:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2b281932d71mr141542835ad.35.1775485066642; 
 Mon, 06 Apr 2026 07:17:46 -0700 (PDT)
X-Received: by 2002:a17:903:8c5:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2b281932d71mr141542355ad.35.1775485066068; 
 Mon, 06 Apr 2026 07:17:46 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:17:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 00/10] hw/tpm: CRB chunking capability to handle PQC
Date: Mon,  6 Apr 2026 19:47:25 +0530
Message-ID: <20260406141735.25844-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 hw/core/machine.c                |   4 +-
 hw/tpm/tpm_crb.c                 | 218 +++++++++++++++++++++++++++----
 hw/tpm/tpm_tis.h                 |   2 +
 hw/tpm/tpm_tis_common.c          |  23 ++++
 hw/tpm/tpm_tis_i2c.c             |  24 +++-
 hw/tpm/tpm_tis_isa.c             |  24 +++-
 hw/tpm/tpm_tis_sysbus.c          |  24 +++-
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  11 ++
 tests/qtest/tpm-tests.c          | 102 ++++++++++++++-
 tests/qtest/tpm-tests.h          |   4 +
 tests/qtest/tpm-tis-swtpm-test.c |  11 ++
 tests/qtest/tpm-util.c           | 154 +++++++++++++++++++---
 tests/qtest/tpm-util.h           |  10 +-
 14 files changed, 569 insertions(+), 47 deletions(-)

-- 
2.53.0


