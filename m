Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D34AC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rL-0002oe-FC; Fri, 31 May 2024 16:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rK-0002oA-B1
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rB-0000mh-UW
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7024003a515so1426338b3a.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187287; x=1717792087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I5AIESFtrUMD1hQuKA3I+WccmKNRTFcn4Ekg/Hl2UI0=;
 b=DkJtSKjUKHMiRN/F+oxks0qyPaz/ahMx84uRLK0AccayBBTJzPNkNQgxTTFK0/m28p
 O6IOYdZaDNsIJoHWXqzwJJtfTWuQsa4ToECsaiabpNs/BOUKskfGo2RSBFrR3xDx1dGc
 0hEeqxmnGiIdUOsKbRoE8ZcBGK2V2C2bRcAzrx58UjVYmQRVSXiHZbDoJjLhmKCrWqc7
 zpmNSUvRYqGPGOoUkHLXE74aiWNdz+6riQlLUWpzZkTtvHj1cSc/5cyP5UhdJKETctD0
 MsovEm6sWWUvEt6mxZrIwAtpSRMCCvLgT1LUmHPwlJu/dGiRWqAXCGFfbU2AJER9am/H
 A8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187287; x=1717792087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5AIESFtrUMD1hQuKA3I+WccmKNRTFcn4Ekg/Hl2UI0=;
 b=QwJ9vxtp9g6oSE7LVZ4I+aIFUeKE+s0w10Q1Psu9a6lEmjpnisOt7vFNHm3Eqo1bAy
 dgqKI6hS1CYXQGZgqgC9P+88lseUWp0uiGHX08qrpU67JPhlu8SorgOzDMd3vGbzcHRy
 P9/GrKRcMt9rbOCMiyUK3J9icmgcfx+TQypFBFEH9b6JndiSpeU62sSm5m+Pn7/O1lAO
 ofOYEPF3j0xJ8YZbUih5LLGyaWZebTtiOiE2EjyKB98SJHr8DX4lmVjxwUv5um2evZxx
 qHeytMNf7KVN4z4Kh0xSyLKQjD1u2YmkIQ9GmXUU8LWyJ94G0aNiqdTGj6OFntkVTGGZ
 z5NA==
X-Gm-Message-State: AOJu0Yxs2vX2Gt2Nu/VXvvkAE+GzvpAnjv2BZ46xdWwqAIEiL9XknKH4
 n+sj2t7G9VbUGLsUpfpU1HrAdWHXJVZaPGK5leoFldRDrgPH6rg75Nsb6pJ5pWUJqXMoBGKeZw4
 z
X-Google-Smtp-Source: AGHT+IFFEPVGsekt3PQdP+OgeUCMgcaOo3XL5b9DXS+IKO+WbawcCsAYk3zjdzqUk11gkO4meBsv2A==
X-Received: by 2002:a05:6a00:4b0c:b0:702:301f:e522 with SMTP id
 d2e1a72fcca58-7024780b1d8mr3015682b3a.19.1717187287239; 
 Fri, 31 May 2024 13:28:07 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/8] hw/riscv/virt.c: aplic/imsic DT fixes
Date: Fri, 31 May 2024 17:27:51 -0300
Message-ID: <20240531202759.911601-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi,

This is a series that is being spun from the reviews given on patch 1
[1]. We'll fix some DT validation issues we have in the 'virt' machine
[2] that aren't related to missing extensions in the DT spec.

I'll leave to maintainers to squash the patches as they see fit. I
split it this way to make it easier to bissect possible bugs that these
individual changes can cause.

These are the types of DT warnings solved by this series:

/home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: $nodename:0: 'aplic@d000000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: compatible:0: 'riscv,aplic' is not one of ['qemu,aplic']
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: compatible: ['riscv,aplic'] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: aplic@d000000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
(...)
/home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: $nodename:0: 'imsics@28000000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: compatible:0: 'riscv,imsics' is not one of ['qemu,imsics']
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: compatible: ['riscv,imsics'] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: '#msi-cells' is a required property
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
/home/danielhb/work/qemu/riscv64_virt.dtb: imsics@28000000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#

[3] explains how to run 'dt-validate' to reproduce them. To generate a
'processed schema' file what I did was:

- in the Linux kernel tree, run 'make dt_binding_check'. Please note
  that this might require installation of additional python stuff
  (e.g.swig, python3-devel)

- I used the generated file 'Documentation/devicetree/bindings/processed-schema.json'
  as a 'processed schema'.

Series applicable on both master and alistair/riscv-to-apply.next. 

Changes from v1:
- added patches 2 to 7 to fix the dt-validate warnings on imsics and
  aplic notes
- v1 link: https://lore.kernel.org/qemu-riscv/20240530084949.761034-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-riscv/20240530084949.761034-1-dbarboza@ventanamicro.com/
[2] https://lore.kernel.org/all/20240529-rust-tile-a05517a6260f@spud/
[3] https://lore.kernel.org/qemu-riscv/20240530-landed-shriek-9362981afade@spud/ 

Daniel Henrique Barboza (8):
  hw/riscv/virt.c: add address-cells in create_fdt_one_aplic()
  hw/riscv/virt.c: add aplic nodename helper
  hw/riscv/virt.c: rename aplic nodename to 'interrupt-controller'
  hw/riscv/virt.c: aplic DT: add 'qemu,aplic' to 'compatible'
  hw/riscv/virt.c: aplic DT: rename prop to 'riscv,delegation'
  hw/riscv/virt.c: change imsic nodename to 'interrupt-controller'
  hw/riscv/virt.c: imsics DT: add 'qemu,imsics' to 'compatible'
  hw/riscv/virt.c: imsics DT: add '#msi-cells'

 hw/riscv/virt.c         | 36 +++++++++++++++++++++++++++---------
 include/hw/riscv/virt.h |  1 +
 2 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.45.1


