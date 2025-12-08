Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC6AD3B7F8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 16:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSeFb-0001tp-7t; Mon, 08 Dec 2025 11:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeFY-0001tI-Ct
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeFV-0002as-AE
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765211885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K8JNACDdYxJFrmxVoYIGsW3k71RO4oeppLLHlls5T40=;
 b=Y6COGkUsxa3dsyjpYMrRMiwZMfGuyf0/fB1FkhNtpzUpdNO+d2kFGZCBT+REyfVeD+Fptf
 19Zn8D3bHOwGc28zjf5NTaFmxNX+L8llqzYyexHtB/V7YGqTb8h7aESXqML4HkqhyedJ3x
 j6v439Me6JahgGWFAp7AGTFC2D+8Pxo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-a2OrsP4dPXixfPyla8sMaw-1; Mon,
 08 Dec 2025 11:38:02 -0500
X-MC-Unique: a2OrsP4dPXixfPyla8sMaw-1
X-Mimecast-MFC-AGG-ID: a2OrsP4dPXixfPyla8sMaw_1765211881
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 262E21956052; Mon,  8 Dec 2025 16:38:01 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.22.88.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 105DB30001A5; Mon,  8 Dec 2025 16:37:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com
Cc: maz@kernel.org
Subject: [PATCH 0/3] Generate target/arm/cpu-sysregs.h.inc from AARCHMRS
 Registers.json
Date: Mon,  8 Dec 2025 17:37:02 +0100
Message-ID: <20251208163751.611186-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce a python script that generates ID register definitions
from the Registers.json file included in "AARCHMRS containing the
JSON files for Arm A-profile (2025-09)". It generates the content
of target/arm/cpu-sysregs.h.inc.

Since [PATCH v8 00/14] arm: rework id register storage
(https://lore.kernel.org/all/20250617153931.1330449-1-cohuck@redhat.com/)
ID regs are generically stored in an array. Auto generation brings
the capability to enhance the list of IDregs stored in that array.

Registers.json can be downloaded at:
Arm Developer A-Profile Architecture Exploration Tools page:
https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
Open Source 2025-09 item.

This patch is a rework of:
[PATCH v8 12/14] arm/cpu: Add sysreg generation scripts
using a python script instead of bash/awk and using a different
entry: Registers.json instead of linux sysreg file.

Soon we will offer the end-user the capability to overwrite some of
them through the KVM API.

Eric Auger (3):
  scripts: introduce scripts/update-aarch64-sysreg-code.py
  target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
  target/arm/cpu-sysregs.h.inc: Update with automatic generation

 scripts/update-aarch64-sysreg-code.py | 133 ++++++++++++++++++++++++++
 target/arm/cpu-sysregs.h.inc          |  56 +++++++----
 2 files changed, 168 insertions(+), 21 deletions(-)
 create mode 100755 scripts/update-aarch64-sysreg-code.py

-- 
2.52.0


