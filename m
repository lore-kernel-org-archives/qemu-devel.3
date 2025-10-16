Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41086CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9NmM-00021Z-9H; Thu, 16 Oct 2025 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9NmF-0001zx-EM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:12:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9Nm4-0007D0-Jm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:12:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo91163f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760620322; x=1761225122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XOUFNZvpHvqjnm/AtQ2K0Ky2w9UxP0NVE0y9sfgq5R8=;
 b=XhF08UrJ+8tx+TuUe3l6gYI6u/zxNdARqUFZFGzMaxe1FwubBWeNTbzGBqSlkNiXdt
 7hSs7N1eitfPH3uzPe42/VWebiNAtXfB6JOJlB9aTZgUaFtStk8gbrCJ99ePuu9tsrtG
 8FMy9zXoBbeGHxTpCM1cR57vVU/JywnYXKoN3IEQV1GYGnUpi3WwsPCyu7iA0Awzp/t3
 VfvfYLrGcx5RtIq1Kd3VfBJJQRVo7/QU5Udshwou0ci7MvxZgbSpjuEuJJUnSn/p4Uyz
 x20y3qzCN4g4O/adh5sK2jFa134/WcnjHHVJs4pp6Tlqpyty6J0iLMAJoeGaN/ESc+AE
 I/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760620322; x=1761225122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XOUFNZvpHvqjnm/AtQ2K0Ky2w9UxP0NVE0y9sfgq5R8=;
 b=hMfDTVsQeNNaMEBpXi6gdtx5iwBwhWZd+rPdfN1C9ZKucwrYugWJKaHWHBDjqD3R14
 SFicFX5t0Qdqy8w7x5t8WRz9jTgPohgtqY1oDywBrm+kdPM19DVJj3mv/cj8AWzXrOSv
 P0EEgGKJuCG7gop8fCEELX+KVs/+GZJEwd+ZRSIFpJ3vghZCiqYuytaG7wqYsVAUl5SM
 1pWTe2BtJRGBOD0BlFc0ob9HuWizd8tbiuTH0IsYR8oG6JGjN/URqTUbZ+SizKp35M3z
 mfHaXBQEnx6qaBZKg3BMxj951nBjX1Tuqp0hJpptQf6FBgkJINVdf1fAChkAzFVaNYHR
 5jpA==
X-Gm-Message-State: AOJu0Yx6jU314dlhgIG3kUBDXm49l8q9wzgf3i2R0ONP/0wZkeEX7QTn
 6lAvM37+gkDO/lLozdY4NzQhtLbBUxDIIui7T2vHGJUXFHSuo0PZ+mSMMlYWi/m09gT3ylkGJq6
 o6peG
X-Gm-Gg: ASbGnctowAWkRWzTMNqVa785vx47W1Ze06cZXp8xoVfOC0gmd4pzX253IJ0AlIaDahS
 W3OjlIATsmblpsep8LHZx6q3WDQapLRlvkbAWf+vD+9axMfmppnO2Y0YSMQBnXf0rWOev0KZ95K
 PqVhbV8JqShXdtnqofhFicajk7xKy8ml0sBnOoAoTUFnLX+ytsN/PpyqxLPajhsDdapzC+/QSwG
 gXKIElv1xaS5SxCmMwZoEiWfv8uQaQUjj8yCdCZpPfv/jpsHbUfynJ9qjoGl0WGu1AsStTwrxu5
 dKqG3Tv149QG1T/3ruXIK1jz9XmvDZgjYv4l2K0Ltma/47TONjII2AcWb+OvrVR83Ysct8WUUk9
 3QkjT2PRLTofoeIEr8tTYW0bCoy0LBC2D4YdjOzkUCjfL57bhM/mZyxAEtjETqclkFN4BN6qlge
 h0VCsYd8E9zE7x/KVBJ9wpDlOxkSBX1+M=
X-Google-Smtp-Source: AGHT+IFbroAqjxKopL/8oWTHIEPp0sO95JEtiIY9HxkTTxB57rQwFTtY3xXmFhLIKybwLh1K7gC2pQ==
X-Received: by 2002:a5d:5d02:0:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-42704d9b22amr30802f8f.43.1760620321700; 
 Thu, 16 Oct 2025 06:12:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711443e81asm28033515e9.10.2025.10.16.06.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 06:12:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH v2] docs/system/security: Restrict "virtualization use case"
 to specific machines
Date: Thu, 16 Oct 2025 14:11:59 +0100
Message-ID: <20251016131159.750480-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Currently our security policy defines a "virtualization use case"
where we consider bugs to be security issues, and a
"non-virtualization use case" where we do not make any security
guarantees and don't consider bugs to be security issues.

The rationale for this split is that much code in QEMU is older and
was not written with malicious guests in mind, and we don't have the
resources to audit, fix and defend it.  So instead we inform users
about what the can in practice rely on as a security barrier, and
what they can't.

We don't currently restrict the "virtualization use case" to any
particular set of machine types.  This means that we have effectively
barred ourselves from adding KVM support to any machine type that we
don't want to put into the "bugs are security issues" category, even
if it would be useful for users to be able to get better performance
with a trusted guest by enabling KVM. This seems an unnecessary
restriction, and in practice the set of machine types it makes
sense to use for untrusted-guest virtualization is quite small.

Specifically, we would like to be able to enable the use of
KVM with the imx8 development board machine types, but we don't
want to commit ourselves to having to support those SoC models
and device models as part of QEMU's security boundary:
https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/

This patch updates the security policy to explicitly list the
machine types we consider to be useful for the "virtualization
use case".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
changes v1->v2: updated the list:
 * remove isapc
 * remove ppc, mips, mips64 (no machines supported)
 * list pseries as only supported ppc64 machine
 * list virt as only supported riscv32, riscv64 machine

I believe the list to now be correct, and I think we generally
had some consensus about the idea on the v1 patch discussion, so
this one is a non-RFC patch.

---
 docs/system/security.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index f2092c8768b..53992048e65 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -35,6 +35,32 @@ malicious:
 Bugs affecting these entities are evaluated on whether they can cause damage in
 real-world use cases and treated as security bugs if this is the case.
 
+To be covered by this security support policy you must:
+
+- use a virtualization accelerator like KVM or HVF
+- use one of the machine types listed below
+
+It may be possible to use other machine types with a virtualization
+accelerator to provide improved performance with a trusted guest
+workload, but any machine type not listed here should not be
+considered to be providing guest isolation or security guarantees,
+and falls under the "non-virtualization use case".
+
+Supported machine types for the virtualization use case, by target architecture:
+
+aarch64
+  ``virt``
+i386, x86_64
+  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
+s390x
+  ``s390-ccw-virtio``
+loongarch64:
+  ``virt``
+ppc64:
+  ``pseries``
+riscv32, riscv64:
+  ``virt``
+
 Non-virtualization Use Case
 '''''''''''''''''''''''''''
 
-- 
2.43.0


