Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE82FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0XTw-00005t-BJ; Thu, 12 Mar 2026 00:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTt-00004q-8I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTq-0008Kq-M7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773289019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1IdqQ31Xkj9sm7/CP2j47kKUOLqV36FeqdkFZKpEkuM=;
 b=duj9/8Hrw+0Vp5pqNpfaYY9DGjZ8XCgTmMMEIyZZGp6dz6lD5UEtM+Yp4tXAN/gW+8tyTa
 Azdph6DZJHNlCQ0akaSrAyi14k94PRmR/cv5NC4M7A3cGeR4IYg73eWWgfQJH0nupJ62wA
 xy9m146t4StOIwMDm9Vm6PPeFecmbWU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-orD2AF0KOFiOs2pjFmm22A-1; Thu, 12 Mar 2026 00:16:58 -0400
X-MC-Unique: orD2AF0KOFiOs2pjFmm22A-1
X-Mimecast-MFC-AGG-ID: orD2AF0KOFiOs2pjFmm22A_1773289017
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso2857132a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773289017; x=1773893817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1IdqQ31Xkj9sm7/CP2j47kKUOLqV36FeqdkFZKpEkuM=;
 b=O+qbPDgBUT5p5U+GJ/bx49cr2AYVIcYFF37rCRhyClIjTFmkeAR4ShGEBxBWiAsMaY
 6Fjmzcnsfnutw2dhl4/WJ6WSwdAMX+C08rCOca8gE/xL8U86ABRI3thQ3ly67nRUCPWx
 DzNUenAWnaDNBfBSTUripUYMYDZbX7nIwsnSkJYcEjqb6Yi27ZOyHSy9GsjpB/F3jg0N
 EchV47c2td6RKNg7ujeqFpdrH3/bZHSxHklvyvyMpkWj63ETlsuVqAJwuv1rqV+zfYYh
 1JvZNRTtiJKobJSumLoEKjJ/W7t25ZwNPuXShyllbke5y4zppHPGsdtoq50L0y9WsGBf
 qXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289017; x=1773893817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IdqQ31Xkj9sm7/CP2j47kKUOLqV36FeqdkFZKpEkuM=;
 b=Od6Uf1Lb0wW6hrqhHcfyvRDPt4LaO6fNPRw9jVl0NqX99UqVLbehBNonCanHOUBeV4
 hqnhrw3KbeC3+H3ccuFsl5lAFgcNVQJAvyoGClqRNqVO2yTtBYs/JHc+1uXNSMXrMIDi
 5goUokgpTjj2PYUA+5A+Ww/ElFbyRNn89MsYNR+80y+zepHrDxjO+vAuQZbkZYSjtIY4
 lYCa/YbLcu5p7bjlmc7/wlHz4vRR/XxK6TBcBTbOQuPkyJdJAzI5/RuI8UeC8hkIWNgr
 njwrx0pvMoM9hg705dY4lpD1LFT01HWoKSt5to3Rf2bFVC/1hEAIJljW4Cll8WAVJYA9
 fbig==
X-Gm-Message-State: AOJu0YxNz0Xc2aelvZGrpP/4PPRaEYY5SZpEzA61lPNP91O+q0oeqrr9
 vqzLNP3nnLOWBuY66XqufOilrwUGUYLyMvtzKJtZxxfOoMZYd5+eckqJ/0K61nKul+9Cav5jyrb
 xCFeEatv/fY0uz2TvjgWmydmIbtSkTiV3b1EDFawoxQAKN9Qf7zVZgLj+Dvls0JTlw3tW16/acr
 hzK8o2fTqAjBTPxjHHqCIfxobKHJnNOThxap4AKag=
X-Gm-Gg: ATEYQzxg14B66kN52ysyMJocD9STEBy1FJvQje3UnhpV1a7zjJRMDyWHeWzYsoNOExj
 oAG4pWxrekVuwVDEAOAipSaNbB97mMIW9+rB6hLnJ8itIzZSQGXVkaeKw/7qQwduP3GsP5woFoE
 sEM1fc1YmlA9ra+jNvO0nvW4Cn6Wn0+lgbSrpuNsAtQBwBzgNnaSiupWj2+OLEfjQ1xA/J5DqX1
 0rc3qSHbtlw7rMOgqCzPYSMV7QywPnhde76suwghgqinvCdWB+Sk2K4E55bWYI624JUnmTVhHVt
 5ezNA1JbRPkqDL12YQRDueADtOkBMWJc0PErg3ySgWKM/zmyrdDudx/YGF1OsAiDyRVpVBd8HMt
 MwmdEDLdlSb3EsZQrcohMd81rEoTjGe48z8yGSDixhTWo/Xa6wl1LVtoX4SyF3w==
X-Received: by 2002:a05:6a20:728b:b0:398:7a23:2779 with SMTP id
 adf61e73a8af0-398c612f234mr5056618637.52.1773289017138; 
 Wed, 11 Mar 2026 21:16:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:728b:b0:398:7a23:2779 with SMTP id
 adf61e73a8af0-398c612f234mr5056579637.52.1773289016625; 
 Wed, 11 Mar 2026 21:16:56 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e498sm3634490a12.3.2026.03.11.21.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:16:56 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC 0/5] hw/tpm: CRB chunking capability to handle PQC
Date: Thu, 12 Mar 2026 09:46:45 +0530
Message-ID: <20260312041650.181411-1-armenon@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

At present, VM live migration during a tpm command execution in chunks
is not supported. We intend to add support for TIS interface in
the future.

The included test demonstrates functional correctness for standard
buffer sizes. However, validation of PQC-sized payloads was performed
via manual buffer-size overrides.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

Arun Menon (5):
  hw/tpm: Add TPM CRB chunking fields
  hw/tpm: Refactor CRB_CTRL_START register access
  hw/tpm: Add internal buffer state for chunking
  hw/tpm: Implement TPM CRB chunking logic
  test/qtest: Add test for tpm crb chunking

 hw/tpm/tpm_crb.c                 | 167 +++++++++++++++++++++++++++----
 include/hw/acpi/tpm.h            |   5 +-
 tests/qtest/tpm-crb-swtpm-test.c |  10 ++
 tests/qtest/tpm-util.c           | 106 +++++++++++++++++---
 tests/qtest/tpm-util.h           |   5 +
 5 files changed, 256 insertions(+), 37 deletions(-)

-- 
2.53.0


