Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B51606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zz/B32zm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqTl-00036j-8I; Thu, 22 Oct 2026 06:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqTi-00035b-Rv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqTg-0001Rx-JY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aJxb/LQrchE7Do5EoHo06BPoac7XryeTlDChwOM+uig=;
 b=Zz/B32zm6/Ineyw0bGPZ3v55Fz1W9w0EiURfDPxxADnFvD/8CqitUu8F3eUUBvIXwR46CP
 xmZbM1P0JEiwzxM8Yh9OhtZCxpz/YVA8PkR54/Ef5UipjNoKbzudU4uTZlp+x1+NnlmYp6
 jb2hYeVuw/x0yHz0rf562HiZKfHGkck=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-SH60MlFWM0COHgekbz5l2w-1; Thu,
 22 Oct 2026 06:56:50 -0400
X-MC-Unique: SH60MlFWM0COHgekbz5l2w-1
X-Mimecast-MFC-AGG-ID: SH60MlFWM0COHgekbz5l2w_1792666606
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99F311800624; Thu, 22 Oct 2026 10:56:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E1FE195608D; Thu, 22 Oct 2026 10:56:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/18] monitor/hmp: replace MonitorDef with GDB
 registers
Date: Thu, 22 Oct 2026 14:56:27 +0400
Message-Id: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNzQ7CIBAGX6XhLGaB/ogn38N4QLq0mNgqtMSm6
 bsLNZp62WSSb2Zn4tFZ9OSYzcRhsN72XQSxy4huVdcgtXVkwoGXIBnQ54huog4begBdF1KbvIK
 KxP3DobGvtXW+fNiP1xvqIQXSorV+6N20Pgss7b5dtukGRoGChtzEw7URJ4d1q4a97u8khQP/q
 QyY2Ko8qqWRheLIhFTyT12W5Q2lMx2+8AAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6140;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3tJeiH8z3Lb55KJMq2K4TPy73X6tPwgstNGrdDqkXWw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evllLHf/aOEy/sORdKsyrugNmGD89bCggogC
 VtYIP7jZEiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5QAKCRDa6OEJdZac
 5Tz6EACEEwGgxFv6SdBRxPxGzPX7ZZoq9h+2Ts/l7zWuxrqhMRt1qLzLPueytUdFEWVB8So3rC2
 UVFobMerOOwuTJrnKCHO53BCUUqN40+34hiHi3hbIJLiXJtE9pMus2gTlEdtj/mpXrQy14PHL4l
 beKvxF/F7qZFwTPuE4YJcx7CoFhJSCGw+d63YIZUgjJ8gbjR9HVDiBTvCWVvyrqZdEE1x5DVot7
 4e1PPeOykGhf6MlnR8g4PtbIJy9d0DCkRWJK96GRlRWQa5kHHU0gcJSLyS3xKMjM+KCcH2luZ6L
 vXt/LsFnd3VHkBcH5LNCJDbuUmlmN1ipWDcOYgkdCuTQCzjXjp06Gw3WEYhe7+wZtlR7CDvXruf
 wHmSPUdiVKQKbvuX2ujfz7lmhvK7a0ceQ/Q2geJUg6h7szIy6/98ZFSRoEAkdGaHcHAtgSKlKzT
 tr/sh7BdAEZX10+KNr1NaMo/iWbn189r/kCwfPW0l5noyFY9t8es6OSSw9kjjNY8p+mk15kk9+x
 A5kxqVH48YST6BkDuFtzrBBA5FhM++GiUT6VdjsEtvrby0tfBHm+N9EJHd3fRnFeCcYOrWadu99
 IPSD+T6ovsmJHQKp4S1GR3+WBaAXNtNeRKdLIHlBEHwqg5LtKiu3aXNYUc0yhwEShDDUPKSUaLU
 VmKLuzvd0+4Lyag==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v3:
- added x86 GDB register patches
  - fix the x87 FPU tag word returned by the GDB stub
  - split SSE registers into a separate org.gnu.gdb.i386.sse feature
  - expose AVX/AVX-512 registers (ymm/zmm upper halves and opmask)
  - expose more system registers to HMP
- renamed i386-segments.xml to i386-system.xml and registered it as an
  internal feature, like the other targets
- moved the HMP $pc removal to its own patch and documented it in
  removed-features.rst
- moved each target's MonitorDef removal into its target patch; the final
  patch now only removes the generic MonitorDef infrastructure
- added MAINTAINERS entries
- rebased onto current master
- Link to v2: https://lore.kernel.org/qemu-devel/20261013-query-reg-v2-0-6f95a2e139a9@redhat.com

Changes in v2:
- dropped v1 patch 5 (CPUClass::get_pc fallback for $pc)
- new patch gdb_register_internal_coprocessor() to hide registers from GDB
- SPARC64, m68k, RISC-V aliases now use internal registration
- pickup trailer tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com

---
Marc-André Lureau (18):
      hmp: don't crash on invalid register
      gdbstub: fix next register base after register gaps
      gdbstub: set feature->base_reg for dynamic features
      gdbstub: add gdb_register_internal_coprocessor()
      MAINTAINERS: cover x86 GDB XML files
      target/i386: expose segment limits register to monitors via gdbstub
      target/i386: fix FPU tag word in GDB register read
      target/i386: split SSE registers into separate GDB feature
      target/i386: expose system registers to monitors via gdbstub
      target/i386: expose AVX/AVX-512 registers to GDB
      target/i386: drop HMP $pc
      MAINTAINERS: cover m68k GDB XML files
      target/m68k: expose system registers to monitors via gdbstub
      target/sparc64: expose system registers to monitors via gdbstub
      target/riscv: bypass smstateen check in debugger mode
      MAINTAINERS: cover riscv GDB XML files
      target/riscv: expose register aliases to monitors via gdbstub
      monitor/hmp: remove legacy MonitorDef infrastructure

 MAINTAINERS                               |   4 +
 configs/targets/i386-bsd-user.mak         |   2 +-
 configs/targets/i386-linux-user.mak       |   2 +-
 configs/targets/i386-softmmu.mak          |   2 +-
 configs/targets/m68k-softmmu.mak          |   2 +-
 configs/targets/riscv32-linux-user.mak    |   2 +-
 configs/targets/riscv32-softmmu.mak       |   2 +-
 configs/targets/riscv64-bsd-user.mak      |   2 +-
 configs/targets/riscv64-linux-user.mak    |   2 +-
 configs/targets/riscv64-softmmu.mak       |   2 +-
 configs/targets/sparc64-softmmu.mak       |   2 +-
 configs/targets/x86_64-bsd-user.mak       |   2 +-
 configs/targets/x86_64-linux-user.mak     |   2 +-
 configs/targets/x86_64-softmmu.mak        |   2 +-
 docs/about/removed-features.rst           |   8 +
 gdbstub/gdb-xml/i386-32bit-avx.xml        |  20 ++
 gdbstub/gdb-xml/i386-32bit-avx512.xml     |  31 +++
 gdbstub/gdb-xml/i386-32bit-sse.xml        |  54 +++++
 gdbstub/gdb-xml/i386-32bit.xml            |  46 +---
 gdbstub/gdb-xml/i386-64bit-avx.xml        |  28 +++
 gdbstub/gdb-xml/i386-64bit-avx512.xml     | 108 +++++++++
 gdbstub/gdb-xml/i386-64bit-sse.xml        |  62 +++++
 gdbstub/gdb-xml/i386-64bit.xml            |  50 ----
 gdbstub/gdb-xml/i386-system.xml           |  53 +++++
 gdbstub/gdb-xml/m68k-system.xml           |  32 +++
 gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 +++++++++
 gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 ++++
 gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 +++++++++
 gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++
 gdbstub/gdb-xml/sparc64-system.xml        |  22 ++
 gdbstub/gdbstub.c                         |  85 +++++--
 include/exec/gdbstub.h                    |  21 ++
 include/hw/core/cpu.h                     |   5 +-
 include/hw/core/sysemu-cpu-ops.h          |  16 --
 include/monitor/hmp.h                     |   6 -
 include/qemu/typedefs.h                   |   1 -
 monitor/hmp.c                             |  45 +---
 target/arm/gdbstub.c                      |   8 +-
 target/arm/gdbstub64.c                    |  10 +-
 target/i386/cpu-dump.c                    |   5 +-
 target/i386/cpu.c                         |  60 +++--
 target/i386/cpu.h                         |  25 ++
 target/i386/gdbstub.c                     | 373 +++++++++++++++++++++++++++---
 target/i386/tcg/fpu_helper.c              |  24 +-
 target/m68k/cpu.c                         |  22 --
 target/m68k/helper.c                      |  49 +++-
 target/ppc/gdbstub.c                      |   2 +-
 target/riscv/cpu.c                        |   1 -
 target/riscv/gdbstub.c                    |  57 ++++-
 target/riscv/internals.h                  |   3 -
 target/riscv/monitor.c                    | 140 -----------
 target/riscv/tcg/csr.c                    |   3 +-
 target/sparc/cpu.c                        |  19 --
 target/sparc/gdbstub.c                    |  38 +++
 target/xtensa/cpu.c                       |   2 +-
 tests/qtest/test-hmp.c                    |   1 -
 56 files changed, 1383 insertions(+), 478 deletions(-)
---
base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
change-id: 20260910-query-reg-80cd59cf4707

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


