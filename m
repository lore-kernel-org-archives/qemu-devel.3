Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28BFFA1FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdlQ-0003dE-UN; Wed, 22 Apr 2026 16:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlN-0003F3-Ez
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlL-0002ea-JZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so54524405e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888090; x=1777492890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XUAPjvfETyaF1LcO83CMB9i5YoVQlzQGnkm+idRhG8Q=;
 b=W9QT1Vtt6bgv4pu+UGU6vSEB7NnH/VWl+w75yv57+KotGvinisp3f/1m+ErVpa/v1q
 TbGO29YzNRsL8RrHeAJRex1S7Pg5K7kEUkvAqnxOlaGzO8UI9phFrbO2+b/5fbKFzJeN
 xrMeO6R2h8/UiJn4vml7yDt4Rm0MOtny5Lpeio9JhxfSndOoqiNNsOIK0/oLqt92g1lg
 /xnA6X3yGabGyJAbfboPceFZ6jAnuUjOBeT/GqyyJxZBHIMuOFKQI2bC2Ofd9OSSYB0/
 ldSo0extnn/jlNPqWyyv8+iJbvN4WDBfEmDF+SfnLZPTNnpBBonQZqaq224tKQm4ySpP
 Xyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888090; x=1777492890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XUAPjvfETyaF1LcO83CMB9i5YoVQlzQGnkm+idRhG8Q=;
 b=LxZxT4690JnqeJBmEkGV0PLyNSSb/fOnfTYhdXsJpTdxx60xit+Xcv+BlHc/nZvOZb
 TZmQn8sjPfC122lgOAY9KsDUr8GyEw5k7lD7ubSHJ9uBlGCVOTLNmF/QVF/NqVKRwshR
 G2OOIsT2SIhf/xsnfr3dBI29vvogDax9joN1CxkYgxFqmitezClBcO4fkVTJkiAhnXCE
 FTdKFuYIQnU09gUIGZ1jP8w418ZAqjiphcO0xz9//DYGU5faJmH/tfkisrPQelLrF0ti
 MHU/DIWBiKXZHJLr5uAgL3hfc94Y1DzkawiOym/b94sWlgw57yKM0ZYhVj6z/PIeFf+W
 nCtw==
X-Gm-Message-State: AOJu0Yy+y1QlaC1hKnIOSGCT3oNvdKy39zWWbK8AgO8+1lQJYeR1zhmS
 44w7wnH7PR1CORu71hrfOyoalMLqfnN5IZp9X+X5r4NCR1QjqoXLnJPkRj3TlFPqAFnOxoI580c
 l3/2KzFE=
X-Gm-Gg: AeBDievjv8n56sWmzVfYuzK7g7U2YuYHbZ2CccsbHnXQWAUOPKbF2tqxUqDJUTr6LWZ
 PXYoIdSwtknnCjAK5/1V2yRuiBQcaCS/kzs4cRW0kKrqXHPXEfK8P6YvNQ5vXx7jkD/hTao/jyf
 sUad45KHK/aChimDykXZHErz1r0Dv5WhkP0jy03gj7v5ogMAAJCPH86NeUhhXD+G0LYoImZ5lCB
 nbuTnxQvZn2qg8JeJcSM/tA9mkakCzlGq9XWRdQqEF3VUcPoazXJlHPuJrhcu/81cdvN+nFT/Lt
 8e8id+2+G0kr7AotseXJCvUsyhj18E2oC5a89JH+tpSZkfoGyuprbnwFKDKcvALMiO61Wc1VVMI
 WhdqPBvnbOxve3Rp5btKf9nA8IbGBGw3wmrpo6SkLl/spRz3jDTpoUhAMan5nRZhOmr3ePlgYfr
 9VgJ0ZLfqwNt0mvNS4Plz0YSzplogP5UtuMswziX1xXPMWlkO3ZnD1m4VW22ITZ3bDk80DPHTrv
 sXdR1qrs5o=
X-Received: by 2002:a05:600c:1554:b0:485:439b:683f with SMTP id
 5b1f17b1804b1-488fb775fd5mr320977425e9.20.1776888089381; 
 Wed, 22 Apr 2026 13:01:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm437715325e9.9.2026.04.22.13.01.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/48] docs/specs/tpm: document PPI support on ARM64 virt
Date: Wed, 22 Apr 2026 21:57:29 +0200
Message-ID: <20260422195746.88865-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

Document that tpm-tis-device on the ARM virt machine supports PPI
with dynamically allocated MMIO via the platform bus, unlike x86
where PPI is at the fixed address 0xFED45000.

Also add hw/arm/virt-acpi-build.c and hw/acpi/tpm.c to the list
of files related to TPM ACPI tables.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Message-ID: <20260327173209.148180-2-mbawa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/specs/tpm.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index b630a351b4f..ba2b0d72674 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -187,8 +187,32 @@ The location of the table is given by the fw_cfg ``tpmppi_address``
 field.  The PPI memory region size is 0x400 (``TPM_PPI_ADDR_SIZE``) to
 leave enough room for future updates.
 
+PPI on ARM64 virt
+-----------------
+
+The ARM virt machine supports PPI for ``tpm-tis-device`` as defined
+in the `PPI specification`_.
+
+Unlike the x86 TIS device where the PPI memory region is mapped at
+the fixed address ``0xFED45000`` (within the TIS MMIO range), the
+ARM64 sysbus device registers PPI memory as a second MMIO region
+on the platform bus. The platform bus assigns the guest physical
+address dynamically at device plug time. The ACPI ``_DSM`` method
+and PPI operation regions reference this dynamically resolved
+address.
+
+PPI is controlled by the ``ppi`` property (default ``on``)::
+
+    -device tpm-tis-device,tpmdev=tpm0,ppi=on
+
+Without PPI, guest operating systems such as Windows 11
+ARM64 will log errors when attempting to query TPM Physical
+Presence capabilities via the ACPI ``_DSM`` method.
+
 QEMU files related to TPM ACPI tables:
  - ``hw/i386/acpi-build.c``
+ - ``hw/arm/virt-acpi-build.c``
+ - ``hw/acpi/tpm.c``
  - ``include/hw/acpi/tpm.h``
 
 TPM backend devices
-- 
2.53.0


