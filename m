Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1E2109022B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Doj-0005Zg-NZ; Thu, 19 Mar 2026 09:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dod-0005Ks-RC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dob-0000ks-Ar
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G+ka46cDCbKZf6qXhWARPDrbrzX3CHbsezQ+v3RHgls=;
 b=imuJj/wrExHsSQ1V6389+ZLlaR+rHKgSfDxj4UZD4rrtNoCoxjqinlCpEjNisKQFfl5wiq
 T0Y3sbz4FUeYUb7hM4wIkTTj13ZmUZcpBmtfWo4ghqT1uwbZSTx6V2hnediFVDCe3Us9PG
 c6fF2ky0bejenbc9NGvrqwWPm+akLzM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-ZslkILZGMwWa37t1wBo5PQ-1; Thu, 19 Mar 2026 09:53:26 -0400
X-MC-Unique: ZslkILZGMwWa37t1wBo5PQ-1
X-Mimecast-MFC-AGG-ID: ZslkILZGMwWa37t1wBo5PQ_1773928404
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so10299955ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928404; x=1774533204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G+ka46cDCbKZf6qXhWARPDrbrzX3CHbsezQ+v3RHgls=;
 b=Wlrl+pHaIcWR0QrgfdpQdCxgf1Fz6ezAupalYOeJRRdG4ETjPRdFEUN7u7SKvlxFWQ
 S++wMdxrlp48454gzXJq9BB6vLwuNeGYwwCpZ3EFOkrECDHMOOJxzweLp6AHFVnVq2+S
 ztlboiERCWSzK+4fRApP4WRFc5yFlXPATAbMYSwWvIdTGxAegjBoeDDg/HWijEo5Vf2u
 wyYZKfJ0/au8ESVNdiM0iRbsh/LF0BmAZcscj18l5pMD0J9NesoPPwESpn32Br0hfuAy
 1HDusnN6rPHr629wDEAELH225Uilzkgj+eUy/CzRIZEEUNC15NLHDXW0cMD5t4MDMuKi
 w3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928404; x=1774533204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+ka46cDCbKZf6qXhWARPDrbrzX3CHbsezQ+v3RHgls=;
 b=IoiDMmTSKVdfsdtyWOnyup/yd0NkEbcyV914MsKgULFTb5fsM7foXXNyEh6M9l7ZaK
 XCKD4tquqyXpdiZgbKhPNWffZ6m6VN8/VVfyGnMfMsoFVoYAS6YEC3sb52/uPJ1bIA/h
 jNR/d4ZcdAYnqg7OpADTDlRAfmllp4i5Wz/zaQIlheyUSQxpFQFpwS+SDUVBF+8gTUa7
 8WpKOlrwBFQypZX1Xe/w4/nTt6EdOj1bJHwNAwst2RviosRPWhkF0wDFHDmVrfD2qNaO
 1diDN+We4tf+zszN6OhZHNkmhC/gE3e5R1YWfcgWT/OMbtzxYb/prmjfyeMoUGMgzChM
 0LTA==
X-Gm-Message-State: AOJu0Yxf6p6awKUCkDm4VP6X6E8TlWptWkw7DVhruxfoQgzPCjzTSt31
 Bt27JSoxEgJMEWqtRjNGn1CTNuAF7Dqm7mvZZQf05J6T7yED/oX6WGPs4RNJ5Mxfh9Mivnv3MKX
 4Vxj/TPN20EnWRamTsfaD+ZJVBxAJYno+wCMr/6n0vdk0P4xaykvoEnpw/eEcuJxjNkOR7ayi0z
 BKFFgKSBKrQw6L3pCJ2aZwnd7S9wJ3T8m+ep/Fy5o=
X-Gm-Gg: ATEYQzxeTSsldFTx1zOzbWlgBiZL0YcpvDv9M9ajGPAjI68j3O1JEcQo0lCYoAHZ5pM
 jfetpdAAR2GP2OBeS/F3pF9RWVtEtAO0mA/VBPE3DwuUePRMDF9aNtPObUpKJLTQZelkITtSfbo
 awTHj2+QmWZMDaklcw833AjZKFJZCnOaQrlQcSR3U6sCEIz7R4FlG5I4/DRHcSPVB1K0/1s3TAc
 lTBfTDULA3FimGIhhD/G7bENSl7liHZzDQ4CutANyc8qdIQRq/4SiZx8xwLfNQJHs6o8rdqgLth
 XrenKB6M7M2/C0oAYI/pjIecbB4EBj91pRgLjKNToo9uXpkAuTxWBnstFIKOEEYIyMLhGMwG+9B
 J7cD/O3kgHYERb7Td0Y+OvSsoUtW99p8xiwaTwC5+zwC3qqjwoVTiucyRBxotMw==
X-Received: by 2002:a17:902:c94f:b0:2b0:700d:83c7 with SMTP id
 d9443c01a7336-2b0700d86a9mr65019205ad.32.1773928404036; 
 Thu, 19 Mar 2026 06:53:24 -0700 (PDT)
X-Received: by 2002:a17:902:c94f:b0:2b0:700d:83c7 with SMTP id
 d9443c01a7336-2b0700d86a9mr65018485ad.32.1773928403262; 
 Thu, 19 Mar 2026 06:53:23 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC v2 0/7] hw/tpm: CRB chunking capability to handle PQC
Date: Thu, 19 Mar 2026 19:23:09 +0530
Message-ID: <20260319135316.37412-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The included test demonstrates functional correctness for standard
buffer sizes. However, validation of PQC-sized payloads was performed
via manual buffer-size overrides.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

v2
--
- Add the VM migration support.
- Increase the TIS TPM interface max buffer size to 8192.

Arun Menon (7):
  hw/tpm: Add TPM CRB chunking fields
  hw/tpm: Refactor CRB_CTRL_START register access
  hw/tpm: Add internal buffer state for chunking
  hw/tpm: Implement TPM CRB chunking logic
  test/qtest: Add test for tpm crb chunking
  hw/tpm: Add support for VM migration with TPM CRB chunking
  hw/tpm: Increase TPM TIS max buffer size to 8192

 hw/core/machine.c                |   1 +
 hw/tpm/tpm_crb.c                 | 291 ++++++++++++++++++++++++++++---
 hw/tpm/tpm_tis.h                 |   2 +-
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  10 ++
 tests/qtest/tpm-util.c           | 106 +++++++++--
 tests/qtest/tpm-util.h           |   5 +
 7 files changed, 382 insertions(+), 38 deletions(-)

-- 
2.53.0


