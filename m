Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D57FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxJo-0007zR-SX; Mon, 04 May 2026 13:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxJk-0007z5-4I
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxJh-0007a7-Kv
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/9x8N0EFoTqmp/yevuNO8kNmx0eTKa/yW4aJBYA+n5Y=;
 b=hnUHr280bHkAJVM5h5/V+dEdx/aJ60pnY5KCNdWGNz2yEvBBh5jyP8cRZN9dGfXHpHx964
 IcC2V0KHf932l/5IQdVqbm74ppIOZhThvDR3E71L2KiN+haDjim863QbtYlXblMNBCA4fJ
 Llvyc/7ND9bTdV3rvTxyiTKaZqARJDQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-TjFvg8NcNn6vtbjk_fum9Q-1; Mon, 04 May 2026 13:42:46 -0400
X-MC-Unique: TjFvg8NcNn6vtbjk_fum9Q-1
X-Mimecast-MFC-AGG-ID: TjFvg8NcNn6vtbjk_fum9Q_1777916566
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b7c2ee830aso95086805ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916565; x=1778521365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/9x8N0EFoTqmp/yevuNO8kNmx0eTKa/yW4aJBYA+n5Y=;
 b=s4tRuUdgyThQ1ioGSbggWFucmS8N4zvPIXP9ptvZB/RhoLhUzGpETP0iwbDNG6OAt6
 slf6KEFjhuHgiGzgEMbMU54v3yJM2UW9ya5LtBBscwIhxun5Qr42a/ckhMMBq99RBRV0
 F7dhm4Q1C2Aa71Hs8wo4vbRmBYWEtMyeB5peGw5nejJkO3BgS8Ie19GE1WBzz4Z8itfQ
 +/8MGCKhIOHSnmtfAHlqyddo++Tz7kp05bep6UlK8MNBX4YC2devCL/4/ETyPP/08O1U
 UpeyN2zK2NqfQ2ZO7dvKwdPxiSjxkyfck+Pb0yEcnOUa+VVQSVETfMutiLoH1guD17R7
 YTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916565; x=1778521365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9x8N0EFoTqmp/yevuNO8kNmx0eTKa/yW4aJBYA+n5Y=;
 b=CCkltF74TivOUrDpey4qBiSVlgi6HkeGpWlVbPZZy7SgzB2cEFtTzO2ciNjEPen6R+
 8xVdDAH26cTZ3qIEaCv2QOL1bwqxrMh8O0733kKeQBu2EitLbKWM/Mu3c7afhmX0ZXVM
 oJFMQ9ozISTdfYrr/Gmve6jUL51pJrDJJyF1JKFlvs4Z7xO2wMttfVGedb9oaPGVy7AP
 n2EMKDDmvRIcVkCCZTpdMp3OUdqKTLyGUPBP2ZJ/beFfm37+G1pzkP2dQvGGWp1vJ54C
 aMBOnJAtsGjhXHVWOaj6/M7JKVOCmZs7djMcwVtPq5W2qO1/DYZxgqAbT+XKlAtA0La3
 JqBQ==
X-Gm-Message-State: AOJu0YxxKf4NHHPTfoZZIBgV6fCNlAHfiAZ24ASxDkBCIXTHRV7lOFVq
 TSZtFjR2beFbbveR2Xez8b078R76ftttTifxcEwoWJs9PuGrHuo2OyBjUITXwJin0Kiy8ugFseH
 k520Q4/Bp4u9gQ+VhkWqsuN1ozFnqoNQFhI4+4DyycWmS7Y7nTYFRc0JrbZmvndyRhFTx5RCrix
 wBRJ3HOJvW3m9YOwKUGoVbCDUiiM051/KvrkfuxmI=
X-Gm-Gg: AeBDiesDrdKtCu3O12MBsFTTkA6hC6htnLcLIy5YdD896SmR7ITaGCRcsS3NL2/Sawe
 4WOrTS0AZKU6ZfMxLXKeea9OJ+p6ACGbc9Z+GECCR1+8tu4RSNAuMvuMtJUJP0UroDxLoXi9iny
 OsHFWFahVQCAUo4DBEQjcC40uEtvwix3s8JYLtC3a5mtBk1Rr5mif2o4njhQIAC3iap9EcOj1HR
 MFBsAeUkVNbICARktXp5useCkioHGx9xNszljb7qic7lnKgLwQlBiJPuTVgPM2DWEMql/M+ZyR/
 /XczqM5vwvwkBhGZvlmXIk8+Zb5kQ4Y4/qjDErim5oTio451bLW0h1X0nEu46ZfJfo7wAEGNlzL
 N0TorgLQOV+3X2Ge/1K4GQ+UrrCe5OiQO0ccqZRe9JTFFTZwX6r+u78RhPxJjUg5jCulW+ZNL
X-Received: by 2002:a17:902:d584:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2b9fb0bbb28mr93338815ad.39.1777916565330; 
 Mon, 04 May 2026 10:42:45 -0700 (PDT)
X-Received: by 2002:a17:902:d584:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2b9fb0bbb28mr93338355ad.39.1777916564697; 
 Mon, 04 May 2026 10:42:44 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:42:44 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 0/6] hw/tpm: CRB chunking capability to handle PQC
Date: Mon,  4 May 2026 23:12:28 +0530
Message-ID: <20260504174234.13556-1-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
 hw/tpm/tpm_crb.c                 | 263 ++++++++++++++++++++++++++++---
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  10 ++
 tests/qtest/tpm-util.c           | 110 +++++++++++--
 tests/qtest/tpm-util.h           |   5 +
 6 files changed, 359 insertions(+), 39 deletions(-)

-- 
2.54.0


