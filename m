Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E52F9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrR-0006k3-Rm; Wed, 22 Apr 2026 06:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUqv-0006fe-8p
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUqn-0006pn-Cj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oRhelen1kacIxF1RWgPIjOkfHyI19V8NRB1Vor6+k6g=;
 b=L4BW/lD+hB1VoT077Crgs2aRxPo7+rnJjrcd1u6nKBAdfcZJaBB0JAXhMUyhL0FUKONfis
 A0pY48P4Ws+uvKGoxH3z+UZR2NY9uErrNOzEYpNfeyZ5MnxniCFvjEfhtAIR9fhbvS0LMR
 HEjOLFebOeEZIP2DCxB/r+VtpXexOQs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-NKZMwKhROJ2noztucMRg7w-1; Wed, 22 Apr 2026 06:30:29 -0400
X-MC-Unique: NKZMwKhROJ2noztucMRg7w-1
X-Mimecast-MFC-AGG-ID: NKZMwKhROJ2noztucMRg7w_1776853829
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630753cc38so6902063a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853828; x=1777458628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oRhelen1kacIxF1RWgPIjOkfHyI19V8NRB1Vor6+k6g=;
 b=UnX9E8oOa7BYEOkE7xPp2rfl4hKMADrvv4qtCKYKYi96bfYQZG+JOx96Tlj8OClzB9
 1sq5OFTVl50cbWMT+ybHDCmnuTjDML4vsNfoVcaDaTdQqMmRDG0UnOiTyTj5a/OTKH2v
 rCeE4uueRUFBR0zPDfToq7EjZFnN/cC0ROANxouKmLFXFyBBjqJCnbQoRRDWQBW/qH5g
 HjrcNERHsjSjsuDR/gX6f1qQrdR4Yg0c5lGSXu7PYEsDfCYv0zfJBlGDHCRgaNevgapY
 T5K+YkB+GMJQ8wjcvWcYo35Kt6Xf0f62LaVdp9F/YpyjwYd/LX3zJcPhGS0u05dpH5qg
 f1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853828; x=1777458628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRhelen1kacIxF1RWgPIjOkfHyI19V8NRB1Vor6+k6g=;
 b=XrlB2G/2encNknJt6Oqp4uwXPnHLs4XrfKufGTn/84Vj5hQPZxxu+9K9QgnnZqX8Lr
 tGfWbUSaK4usfTAG7JeA+z7XBgShnRz6JEUg9pFpIaNJu4vnB7lzh+lK1VrWxZtkdLvH
 VnV4CijbRUc7W6Z8eKknF42bQBvHj3tTRTj3QAGkkgMV3QMzLxLg30hlQORkriG7HpKX
 r3GvaaJUNfVX3rt+fekug4yoJ3yZNbyr5th9F+2Bt+R8WznX3DmwoQ1Et0uZzTtcpo5d
 0QCysthbPAHKQkPuJ6PlaYLQxYXyEwybf4Ess4AwuqJ69ZyZVkUtF2s3P5dP37Bvj88K
 lYWg==
X-Gm-Message-State: AOJu0Yz8Hrnc/uLkBk15INKNyX1bu8rxRTBCgDfhXAKvAM1IxmmXWOC/
 dGjoYcjmsxZc4ue5dEifCFqpTUCqRBP/YhxfjvN6YvUxD3TRXqvWo5DSS1VZ1ZpGyfutosX0Lp+
 WDpixc5aHDni2SjVh5SFWQL+fasOVAPCahwrilJevhb9ruRqWsBVdqWkCC2tz541kQFpdi+wcSm
 a2v4mQDhO+hfxZLarYJrLMv5pJdgRse9Dnmg7FZMY=
X-Gm-Gg: AeBDietQHvdNE0ySAvGz/xCKHbF8AbJinruB/Acm2uBSdj+fTseY1BQw76mt7nFH7AI
 a3TybXosZHKp5GNAGwKrOdIK+FRQdVz4Hf9KD8CmJVTihk2QGtloUOSOMTRA6P5UeTTmCeV4C1f
 7xV+DNz1XtDJEUO9Xa6ntLAQ9Gi9vqsq6M6c+Byjaqhl4gNitOtInPExHvM2tx4ydUkOyH0TEmv
 MSqZp+RlqESsgqRZZ9YFCurdnj/tdcB0f1jFaFOQB6jgychloNkBdMybEy2yOhQ2kTzaT+PZGRY
 u0SBquAcO+i77mQRfE85coqzsFkDuUsOK43gVzDZwN53b8DvFTDFCuVdjzhbM/lwhVCnPdCGRHQ
 kvARKmssZPk6J9/s95NWoYQP//mJSIWlaMLSeGnKlfOSpqk/Oyq57PO2wuFaF6l5YcS18lizSvw
 ==
X-Received: by 2002:a05:6300:68c1:20b0:39f:216:f3f7 with SMTP id
 adf61e73a8af0-3a08d7342bbmr16868867637.21.1776853828453; 
 Wed, 22 Apr 2026 03:30:28 -0700 (PDT)
X-Received: by 2002:a05:6300:68c1:20b0:39f:216:f3f7 with SMTP id
 adf61e73a8af0-3a08d7342bbmr16868804637.21.1776853827636; 
 Wed, 22 Apr 2026 03:30:27 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:27 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 00/10] hw/tpm: CRB chunking capability to handle PQC
Date: Wed, 22 Apr 2026 16:00:08 +0530
Message-ID: <20260422103018.123608-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Berger (4):
  qtests: Enable starting swtpm with a given profile
  tests: Use ML-DSA-87 operations to caused large TPM transfers with CRB
  tpm: Extend TPM TIS buffer size to 8192 bytes
  tests: Use ML-DSA-87 operations to caused large TPM transfers with TIS

 hw/core/machine.c                |   5 +-
 hw/tpm/tpm_crb.c                 | 266 ++++++++++++++++++++++++++++---
 hw/tpm/tpm_tis.h                 |   2 +
 hw/tpm/tpm_tis_common.c          |  23 +++
 hw/tpm/tpm_tis_i2c.c             |  24 ++-
 hw/tpm/tpm_tis_isa.c             |  24 ++-
 hw/tpm/tpm_tis_sysbus.c          |  24 ++-
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  11 ++
 tests/qtest/tpm-tests.c          | 102 +++++++++++-
 tests/qtest/tpm-tests.h          |   4 +
 tests/qtest/tpm-tis-swtpm-test.c |  11 ++
 tests/qtest/tpm-util.c           | 156 ++++++++++++++++--
 tests/qtest/tpm-util.h           |  10 +-
 14 files changed, 620 insertions(+), 47 deletions(-)

-- 
2.53.0


