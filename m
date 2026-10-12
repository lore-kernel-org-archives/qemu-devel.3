Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C46CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjB-0003BQ-Sw; Mon, 12 Oct 2026 16:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMj9-0003Ad-R9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMj7-00034A-LS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7vn9BqJ6kPiJoiJ6QqSAH339LMoq4dWe7CZ269bMPU=;
 b=UUctXUCxXNS7V+otszvTl0dhMXMZ6gl6IpNY/NMZ3lHxXlDevGS+UwLFDQas0PyRV0gRdb
 LFNIjm9l8YKI89HWPQJh9nvKlvsRgvNa4MMafWlDz1LHb2rK88gAAvRGIqJgLMCAz3Yl3P
 ux82kaR+FCn+q1LvHRTWAEG7SoLIdZE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-_Oc2JoRlOladP8PXb5PQGg-1; Mon,
 12 Oct 2026 20:34:18 +0000
X-MC-Unique: _Oc2JoRlOladP8PXb5PQGg-1
X-Mimecast-MFC-AGG-ID: _Oc2JoRlOladP8PXb5PQGg_1791837255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68182195395F; Mon, 12 Oct 2026 20:34:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 495431800473; Mon, 12 Oct 2026 20:34:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/10] monitor/hmp: replace MonitorDef with GDB
 registers
Date: Tue, 13 Oct 2026 00:34:03 +0400
Message-Id: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02N0QqCQBBFf0XmuY3ZzTJ76j/CBxtndYNcm1VJx
 H9vNYJeLhw4nDtDYHEc4JLMIDy64HwbwewSoKZsa1auigwGzQlzjeo1sExKuFZnpOqYk00zzCD
 6nbB17611K74chvuDqV8Dq9G40HuZtrNRr96vq/+6o1aokDC1cQzZw1W4asp+T/4JxbIsHySXQ
 ge1AAAA
X-Change-ID: 20260910-query-reg-80cd59cf4707
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3975;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zG+aaLed+0qtXU8b1NdJUr7sF6B2xEEI2f/D/er7QKw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURAstRFjuxyF/fd4LEnpy52U6mnXs8UmPQOO
 W6ZIOyvrPSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQAAKCRDa6OEJdZac
 5S+cD/9EdythbdtJ73KU2MOtyIyKjQhOCDsWEKZXyKqrKTVrj5RArXDVHyY1shs3xajnWXhHZFA
 d3q6hiTtBQ7vVJmrvs3K9N8f2YlAbtmpURes7Uuc1Hn8lxfgedx0cpKJuCMeL0NUAtu8LRLWUjG
 d3ACvIZyTLcfEwaeQQLTxST8NYuHUTLQGOmi3pnzaJAoxY9hC9r4OtmfSjG3rQeRqTUt2y70Jku
 plnCTSXFZA/JOV3LB9KlolPSiUzu8V1iYP+3LdKcMw64yiF6oTndUf0hIA2b6U/PUHWZ28vZKBt
 9YzGrOlwO/5xuatPbjAdPMEPMy1dwTdnHZDXH/U24uSnC2XwX81hov7nRoec8qKv9vMEKNW0gq3
 hxjo9b8zTpfGbDxNIIfJVN4kgQTbkXcRX9bEnqSYzua7aszMD7Ppoz6ETGwppx7c43nd9xqu7u3
 ISeulki20AZieMV6kFEsDw/UWNWfEWcdYSD+zP1TP+cZFD4GABJyq0mR5IxfLm3j+DQS99tyeGT
 tM+Uw/7UMeVgwd4A9XuDsqGDdgooLr7x+yvuXno/XaW766A7k3zRdkjSBYUe93A/dyLl7+E7chU
 RHozk/wImdZS99yYUcmVoHZJsUQTyDZt/nad4DhzY4LKOh7uky57ifAmUD8VPROtJT/HnxDor9g
 kVul8N3gxq1erMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

HMP monitor supports printing $register expression. The lookup
was done via GDB stub registers, and supplementary MonitorDef
HMP-specific tables.

Migrate HMP registers to use the GDB infrastructure and remove the
legacy HMP MonitorDef. Internal registers aren't exposed to GDB.
This also drops HMP $pc x86 fallback (use $eip/$rip instead).

Known behavioural changes on RISC-V: CSR lookup is now case-sensitive
and vector registers now report "unkown register" instead of a
target-specific message ("Unable to print the value of vector vreg 'v0'
from this API")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2:
- dropped v1 patch 5 (CPUClass::get_pc fallback for $pc)
- new patch gdb_register_internal_coprocessor() to hide registers from GDB
- SPARC64, m68k, RISC-V aliases now use internal registration
- pickup trailer tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com

---
Marc-André Lureau (10):
      hmp: don't crash on invalid register
      gdbstub: fix next register base after register gaps
      gdbstub: set feature->base_reg for dynamic features
      gdbstub: add gdb_register_internal_coprocessor()
      target/i386: expose segment limits via GDB
      target/m68k: expose system registers via GDB
      target/sparc64: expose system registers via GDB
      target/riscv: bypass smstateen check in debugger mode
      target/riscv: expose register aliases via GDB
      monitor/hmp: remove legacy MonitorDef infrastructure

 configs/targets/i386-softmmu.mak          |   2 +-
 configs/targets/m68k-softmmu.mak          |   2 +-
 configs/targets/riscv32-linux-user.mak    |   2 +-
 configs/targets/riscv32-softmmu.mak       |   2 +-
 configs/targets/riscv64-bsd-user.mak      |   2 +-
 configs/targets/riscv64-linux-user.mak    |   2 +-
 configs/targets/riscv64-softmmu.mak       |   2 +-
 configs/targets/sparc64-softmmu.mak       |   2 +-
 configs/targets/x86_64-softmmu.mak        |   2 +-
 gdbstub/gdb-xml/i386-segments.xml         |  14 +++
 gdbstub/gdb-xml/m68k-system.xml           |  32 +++++++
 gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++
 gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
 gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++
 gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
 gdbstub/gdb-xml/sparc64-system.xml        |  22 +++++
 gdbstub/gdbstub.c                         |  85 ++++++++++++++----
 include/exec/gdbstub.h                    |  21 +++++
 include/hw/core/cpu.h                     |   2 +-
 include/hw/core/sysemu-cpu-ops.h          |  16 ----
 include/monitor/hmp.h                     |   6 --
 include/qemu/typedefs.h                   |   1 -
 monitor/hmp.c                             |  46 +---------
 target/arm/gdbstub.c                      |   8 +-
 target/arm/gdbstub64.c                    |  10 ++-
 target/i386/cpu.c                         |  32 -------
 target/i386/gdbstub.c                     |  24 +++++
 target/m68k/cpu.c                         |  22 -----
 target/m68k/helper.c                      |  47 ++++++++++
 target/ppc/gdbstub.c                      |   2 +-
 target/riscv/cpu.c                        |   1 -
 target/riscv/gdbstub.c                    |  56 +++++++++++-
 target/riscv/internals.h                  |   3 -
 target/riscv/monitor.c                    | 140 ------------------------------
 target/riscv/tcg/csr.c                    |   3 +-
 target/sparc/cpu.c                        |  19 ----
 target/sparc/gdbstub.c                    |  38 ++++++++
 target/xtensa/cpu.c                       |   2 +-
 38 files changed, 645 insertions(+), 321 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20260910-query-reg-80cd59cf4707

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


