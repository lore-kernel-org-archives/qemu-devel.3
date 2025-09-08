Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A9CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbLa-0002L6-Bq; Mon, 08 Sep 2025 08:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvbLB-0002Gp-5G
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:51:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvbKw-0005R0-4V
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:51:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so27969895e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757335861; x=1757940661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxPytzeq6dPngJT4hbcEIQRox1Pjr2WlO0kU+VWzsNQ=;
 b=KI6+11hpGUo708lRewtQ8Pte1mbp7EhsEmrCYSkgbXNhHnpTdMg7iR8BLlS5K14mql
 EzMOetdj2IiwMvgiOgbIWAu4j9+hmtwLrQ/TYH9emtjQWqAOJJ7+R1kg1CDlOPYONjK+
 h3aHJ5FUjLoNLIqzJTLZRLJ52fEaAI3X4V0NS9vd75YjEyhmWK+MpS0BbDOHpw3+PEO2
 wpkDrKDsAJEEO0I6ckmHM3AUwwXWJF3rAgNoHImpro8jv1OrmRN/jDdOXq7Fa00vxvu8
 kuaf2PYdKovR4SG+HZPE3Vz1QkjRR00WLalrpNUOqnkNFK3vBg0SLPb7UPDZboILxNK1
 6VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757335861; x=1757940661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxPytzeq6dPngJT4hbcEIQRox1Pjr2WlO0kU+VWzsNQ=;
 b=GC1A9KmsFLemD5mNfuJtsybwRyrh8rZBp50x9asEZcRoyl67WJoCvaO06ok99Bv2Rc
 aLrb/GhTU7+6YYwaZYPlfJNIXmeB/pHT67TeGo9mQgxwaB+81H4iDaComfQlfJGgamiN
 6JjkN9szhKJW2QnADkbgkb65EXFQjAuC/eiI0D024it4L55dJ8hJxuv0hVstOLxZ/YCM
 ntOU3j92VFixxO/xmKwsFeDqPbLRBuRuUR2AYmXIUFn/rZPO9+bO0wif3ucecl6YQRlV
 OUS6yZtxdskeDMPkDqYQIhlPqJufVors3sfkt+oWizvAAgU1/6YIl3huzAbQrAFzkLOp
 tFWQ==
X-Gm-Message-State: AOJu0YzD6efx5ZbjrnLhIiYCEfYWguB/+TQdR8nC3F6QV1gIq+KhQNjj
 GrC9B3kFegP7CrffHt89IXtNesgve3xgfxI8Nmt0TmDFwxvz5OXS9kPntDzTzI1k0uOeCSRY4m9
 jZwds
X-Gm-Gg: ASbGncs1R0ujrCSD3/TQ1sCGj/zTZtrMHmKijBsaSIIVIEquAmj3W9hzNQKFBUp/AXA
 fgwSI3iDraILrIxMyM8C7TBJQEyPF4lgV5GXqszj9Gm7NAu1EBRzmNGCpg/G5WlfDtRfkULTN7N
 qot+o3lJIyqWA5D+OLeUUGRoGq4QVQOygHTKbojOYVYyLW8PQ/q9lpvmbjMdJ7whnDyB4pz36W8
 IRDuIBmidj6j0p0DoscTsFTt6AVfZ0Zx1rWeNnu3UQCf1v28ZfAVUpNO2aaJPArt7xV4GTXgo6l
 U0vIZpiolTDqFuH8qps3a4Hr4WuM6c2/AD81yRw5OUsv9q4NXfc6z9jFb841hokey4/GknxZPye
 2u2i63MmyxtFCPvFg8mUCERDjwLi9
X-Google-Smtp-Source: AGHT+IGsDim/DMSViM56KXy45ZJJdjM1w8uuhVmP2tGMEZ4H5/V+mkgrys6of98GIjOlt/H+9UXilA==
X-Received: by 2002:a05:600c:1993:b0:45d:db2a:ce30 with SMTP id
 5b1f17b1804b1-45ddde0d828mr63620025e9.0.1757335860663; 
 Mon, 08 Sep 2025 05:51:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45deab47e5dsm15240425e9.2.2025.09.08.05.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 05:50:59 -0700 (PDT)
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
Subject: [RFC PATCH] docs/system/security: Restrict "virtualization use case"
 to specific machines
Date: Mon,  8 Sep 2025 13:50:57 +0100
Message-ID: <20250908125058.220973-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

This is an RFC partly to see if we have consensus that this change
makes sense, and partly because I was only able to identify the
machine types we want to cover for some of our target architectures.
If maintainers for the other architectures could clarify which
machine types work with KVM that would be helpful.

Notes on the listed machine types:

architectures I'm pretty sure about:

aarch64:
 -- virt is definitely the only supported one
s390x:
 -- s390-ccw-virtio is the only machine type for this architecture
loongarch64:
 -- virt is the only machine type for this architecture

architectures where I've made a guess:

i386, x86_64:
 -- I have assumed that all machine types except the "experimental"
    x-remote are supported

architectures I don't know:

mips, mips64
riscv32, riscv64
ppc, ppc64

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/security.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index f2092c8768b..395c2d7fb88 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -35,6 +35,34 @@ malicious:
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
+  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``isapc``
+s390x
+  ``s390-ccw-virtio``
+loongarch64:
+  ``virt``
+ppc, ppc64:
+  TODO
+mips, mips64:
+  TODO
+riscv32, riscv64:
+  TODO
+
 Non-virtualization Use Case
 '''''''''''''''''''''''''''
 
-- 
2.43.0


