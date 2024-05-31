Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801C4C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD38h-0004zq-M5; Fri, 31 May 2024 10:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD38h-0004zh-0i
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:21:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD38f-00052D-1y
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:21:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35dc0472b7eso1965546f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717165307; x=1717770107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wBhT8PLa4mfa9GdNed2XT0ihKpqyvFF1YI1P8sEDZAw=;
 b=MmWmyEvJqt8WZaZ49oGR8HSsWkZkA0WkytAjCQavDKO/V20jdmHdOnFTBeFH0p90cv
 b/asi0mjxp9QBlCO6JpG2zoxIb0VFuWSuU79nKx704zrXU/SkraTcSFiMkOHtnfk/Om1
 Y95pW+Lzpa/dCZhJnbVdfJrCJxiz2bm91p5scuVxBto3sIgwvGrsmKW/vOYuSzfwycoH
 kpK3dwAMzbhO6Wy3V2uA4ALOU4NHHK+kSYayHGR8gAq755bQk1NAxPbC71x7QPw9XAA9
 muYuaOyW9XKymp8YlTOexRxAKe9b+ffCykrmVTMioutMFaY3iEHV5k52EWaHoBfYdDQs
 so2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165307; x=1717770107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBhT8PLa4mfa9GdNed2XT0ihKpqyvFF1YI1P8sEDZAw=;
 b=xIzBJ/y755JCnGxkoQ4sA+qhKUR1lMZCFQ7fKXnTMwhkeTN0S5pFPXK9V/cVO0d3mN
 nH2i/UTKwfuC1yebFk4vPJltOw8g3ycwdmWhRUHcbLOxyufDhh3AYQn5CsOYcwFN598J
 WvqotVtT++GwR6w1Mcyl46wrYf1Yq2TB1LwBvIuF7UssUzj516ImfWbJAcXc2EpfoRzm
 aMbimtSkJ0F86UY0IHKe14SNxeITpdAOQdz3I1/ub39SiDDI7dEFcBH/FfiuWmr4mq3x
 k7QGh+hZ+xs+ddi0/oMCBAm1zv/IOHEfGHhqSd0VM/kderZJADeqHvLT35oADh1rf3n9
 KqMg==
X-Gm-Message-State: AOJu0YyyQm24Uo67tmqMJm2WwauB+dNowq0l2R68CzFjlN0qKSsvnDGj
 IY8Niwg5TcZicjkBf1HriyqptYKZVD9nND2LnkjgesR3xypaEMjVV6YYUl67eCji+F9Xs0HWz/C
 2
X-Google-Smtp-Source: AGHT+IHHzyTE3wMumU39gWI2n3UZH55CzmzZsHno3t7rkW4HiVT3xBS/ZOtAoVNrgetOrDSIVcagfA==
X-Received: by 2002:a5d:4e50:0:b0:355:1ad:90d3 with SMTP id
 ffacd0b85a97d-35e0f3196aemr1382351f8f.55.1717165306571; 
 Fri, 31 May 2024 07:21:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d6e5asm1970356f8f.45.2024.05.31.07.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:21:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] scripts/coverity-scan/COMPONENTS.md: Update paths to match
 gitlab CI
Date: Fri, 31 May 2024 15:21:45 +0100
Message-Id: <20240531142145.482361-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since commit 83aa1baa069c we have been running the build for Coverity
Scan as a Gitlab CI job, rather than the old setup where it was run
on a local developer's machine.  This is working well, but the
absolute paths of files are different for the Gitlab CI job, which
means that the regexes we use to identify Coverity components no
longer work. With Gitlab CI builds the file paths are of the form
 /builds/qemu-project/qemu/accel/kvm/kvm-all.c

rather than the old
 /qemu/accel/kvm/kvm-all.c

and our regexes all don't match.

Update all the regexes to start with .*/qemu/ . This will hopefully
avoid the need to change them again in future if the build path
changes again.

This change was made with a search-and-replace of (/qemu)?
to .*/qemu .

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As usual with COMPONENTS.md changes, somebody with Coverity admin
access needs to make all the changes by hand in the GUI once this
has gone through code review :-(

If there are any other changes we want to make to our component
regexes, now would be a great time to suggest them, because this
change is going to involve "delete every existing component and
recreate"...
---
 scripts/coverity-scan/COMPONENTS.md | 104 ++++++++++++++--------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 1537e49cd5a..98d4bcd6a50 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -1,157 +1,157 @@
 This is the list of currently configured Coverity components:
 
 alpha
-  ~ (/qemu)?((/include)?/hw/alpha/.*|/target/alpha/.*)
+  ~ .*/qemu((/include)?/hw/alpha/.*|/target/alpha/.*)
 
 arm
-  ~ (/qemu)?((/include)?/hw/arm/.*|(/include)?/hw/.*/(arm|allwinner-a10|bcm28|digic|exynos|imx|omap|stellaris|pxa2xx|versatile|zynq|cadence).*|/hw/net/xgmac.c|/hw/ssi/xilinx_spips.c|/target/arm/.*)
+  ~ .*/qemu((/include)?/hw/arm/.*|(/include)?/hw/.*/(arm|allwinner-a10|bcm28|digic|exynos|imx|omap|stellaris|pxa2xx|versatile|zynq|cadence).*|/hw/net/xgmac.c|/hw/ssi/xilinx_spips.c|/target/arm/.*)
 
 avr
-  ~ (/qemu)?((/include)?/hw/avr/.*|/target/avr/.*)
+  ~ .*/qemu((/include)?/hw/avr/.*|/target/avr/.*)
 
 cris
-  ~ (/qemu)?((/include)?/hw/cris/.*|/target/cris/.*)
+  ~ .*/qemu((/include)?/hw/cris/.*|/target/cris/.*)
 
 hexagon-gen (component should be ignored in analysis)
-  ~ (/qemu)?(/target/hexagon/.*generated.*)
+  ~ .*/qemu(/target/hexagon/.*generated.*)
 
 hexagon
-  ~ (/qemu)?(/target/hexagon/.*)
+  ~ .*/qemu(/target/hexagon/.*)
 
 hppa
-  ~ (/qemu)?((/include)?/hw/hppa/.*|/target/hppa/.*)
+  ~ .*/qemu((/include)?/hw/hppa/.*|/target/hppa/.*)
 
 i386
-  ~ (/qemu)?((/include)?/hw/i386/.*|/target/i386/.*|/hw/intc/[^/]*apic[^/]*\.c)
+  ~ .*/qemu((/include)?/hw/i386/.*|/target/i386/.*|/hw/intc/[^/]*apic[^/]*\.c)
 
 loongarch
-  ~ (/qemu)?((/include)?/hw/(loongarch/.*|.*/loongarch.*)|/target/loongarch/.*)
+  ~ .*/qemu((/include)?/hw/(loongarch/.*|.*/loongarch.*)|/target/loongarch/.*)
 
 m68k
-  ~ (/qemu)?((/include)?/hw/m68k/.*|/target/m68k/.*|(/include)?/hw(/.*)?/mcf.*|(/include)?/hw/nubus/.*)
+  ~ .*/qemu((/include)?/hw/m68k/.*|/target/m68k/.*|(/include)?/hw(/.*)?/mcf.*|(/include)?/hw/nubus/.*)
 
 microblaze
-  ~ (/qemu)?((/include)?/hw/microblaze/.*|/target/microblaze/.*)
+  ~ .*/qemu((/include)?/hw/microblaze/.*|/target/microblaze/.*)
 
 mips
-  ~ (/qemu)?((/include)?/hw/mips/.*|/target/mips/.*)
+  ~ .*/qemu((/include)?/hw/mips/.*|/target/mips/.*)
 
 openrisc
-  ~ (/qemu)?((/include)?/hw/openrisc/.*|/target/openrisc/.*)
+  ~ .*/qemu((/include)?/hw/openrisc/.*|/target/openrisc/.*)
 
 ppc
-  ~ (/qemu)?((/include)?/hw/ppc/.*|/target/ppc/.*|/hw/pci-host/(uninorth.*|dec.*|prep.*|ppc.*)|/hw/misc/macio/.*|(/include)?/hw/.*/(xics|openpic|spapr).*)
+  ~ .*/qemu((/include)?/hw/ppc/.*|/target/ppc/.*|/hw/pci-host/(uninorth.*|dec.*|prep.*|ppc.*)|/hw/misc/macio/.*|(/include)?/hw/.*/(xics|openpic|spapr).*)
 
 riscv
-  ~ (/qemu)?((/include)?/hw/riscv/.*|/target/riscv/.*|/hw/.*/(riscv_|ibex_|sifive_).*)
+  ~ .*/qemu((/include)?/hw/riscv/.*|/target/riscv/.*|/hw/.*/(riscv_|ibex_|sifive_).*)
 
 rx
-  ~ (/qemu)?((/include)?/hw/rx/.*|/target/rx/.*)
+  ~ .*/qemu((/include)?/hw/rx/.*|/target/rx/.*)
 
 s390
-  ~ (/qemu)?((/include)?/hw/s390x/.*|/target/s390x/.*|/hw/.*/s390_.*)
+  ~ .*/qemu((/include)?/hw/s390x/.*|/target/s390x/.*|/hw/.*/s390_.*)
 
 sh4
-  ~ (/qemu)?((/include)?/hw/sh4/.*|/target/sh4/.*)
+  ~ .*/qemu((/include)?/hw/sh4/.*|/target/sh4/.*)
 
 sparc
-  ~ (/qemu)?((/include)?/hw/sparc(64)?.*|/target/sparc/.*|/hw/.*/grlib.*|/hw/display/cg3.c)
+  ~ .*/qemu((/include)?/hw/sparc(64)?.*|/target/sparc/.*|/hw/.*/grlib.*|/hw/display/cg3.c)
 
 tricore
-  ~ (/qemu)?((/include)?/hw/tricore/.*|/target/tricore/.*)
+  ~ .*/qemu((/include)?/hw/tricore/.*|/target/tricore/.*)
 
 xtensa
-  ~ (/qemu)?((/include)?/hw/xtensa/.*|/target/xtensa/.*)
+  ~ .*/qemu((/include)?/hw/xtensa/.*|/target/xtensa/.*)
 
 9pfs
-  ~ (/qemu)?(/hw/9pfs/.*|/fsdev/.*)
+  ~ .*/qemu(/hw/9pfs/.*|/fsdev/.*)
 
 audio
-  ~ (/qemu)?((/include)?/(audio|hw/audio)/.*)
+  ~ .*/qemu((/include)?/(audio|hw/audio)/.*)
 
 block
-  ~ (/qemu)?(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
+  ~ .*/qemu(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
 
 char
-  ~ (/qemu)?(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
+  ~ .*/qemu(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
 
 crypto
-  ~ (/qemu)?((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
+  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
 
 disas
-  ~ (/qemu)?((/include)?/disas.*)
+  ~ .*/qemu((/include)?/disas.*)
 
 fpu
-  ~ (/qemu)?((/include)?(/fpu|/libdecnumber)/.*)
+  ~ .*/qemu((/include)?(/fpu|/libdecnumber)/.*)
 
 io
-  ~ (/qemu)?((/include)?/io/.*)
+  ~ .*/qemu((/include)?/io/.*)
 
 ipmi
-  ~ (/qemu)?((/include)?/hw/ipmi/.*)
+  ~ .*/qemu((/include)?/hw/ipmi/.*)
 
 migration
-  ~ (/qemu)?((/include)?/migration/.*)
+  ~ .*/qemu((/include)?/migration/.*)
 
 monitor
-  ~ (/qemu)?(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
+  ~ .*/qemu(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
 
 nbd
-  ~ (/qemu)?(/nbd/.*|/include/block/nbd.*|/qemu-nbd\.c)
+  ~ .*/qemu(/nbd/.*|/include/block/nbd.*|/qemu-nbd\.c)
 
 net
-  ~ (/qemu)?((/include)?(/hw)?/(net|rdma)/.*)
+  ~ .*/qemu((/include)?(/hw)?/(net|rdma)/.*)
 
 pci
-  ~ (/qemu)?(/include)?/hw/(cxl/|pci).*
+  ~ .*/qemu(/include)?/hw/(cxl/|pci).*
 
 qemu-ga
-  ~ (/qemu)?(/qga/.*)
+  ~ .*/qemu(/qga/.*)
 
 scsi
-  ~ (/qemu)?(/scsi/.*|/hw/scsi/.*|/include/hw/scsi/.*)
+  ~ .*/qemu(/scsi/.*|/hw/scsi/.*|/include/hw/scsi/.*)
 
 trace
-  ~ (/qemu)?(/.*trace.*\.[ch])
+  ~ .*/qemu(/.*trace.*\.[ch])
 
 ui
-  ~ (/qemu)?((/include)?(/ui|/hw/display|/hw/input)/.*)
+  ~ .*/qemu((/include)?(/ui|/hw/display|/hw/input)/.*)
 
 usb
-  ~ (/qemu)?(/hw/usb/.*|/include/hw/usb/.*)
+  ~ .*/qemu(/hw/usb/.*|/include/hw/usb/.*)
 
 user
-  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/user/.*)
+  ~ .*/qemu(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/user/.*)
 
 util
-  ~ (/qemu)?(/util/.*|/include/qemu/.*)
+  ~ .*/qemu(/util/.*|/include/qemu/.*)
 
 vfio
-  ~ (/qemu)?(/include)?/hw/vfio/.*
+  ~ .*/qemu(/include)?/hw/vfio/.*
 
 virtio
-  ~ (/qemu)?(/include)?/hw/virtio/.*
+  ~ .*/qemu(/include)?/hw/virtio/.*
 
 xen
-  ~ (/qemu)?(.*/xen.*)
+  ~ .*/qemu(.*/xen.*)
 
 hvf
-  ~ (/qemu)?(.*/hvf.*)
+  ~ .*/qemu(.*/hvf.*)
 
 kvm
-  ~ (/qemu)?(.*/kvm.*)
+  ~ .*/qemu(.*/kvm.*)
 
 tcg
-  ~ (/qemu)?(/accel/tcg|/replay|/tcg)/.*
+  ~ .*/qemu(/accel/tcg|/replay|/tcg)/.*
 
 sysemu
-  ~ (/qemu)?(/system/.*|/accel/.*)
+  ~ .*/qemu(/system/.*|/accel/.*)
 
 (headers)
-  ~ (/qemu)?(/include/.*)
+  ~ .*/qemu(/include/.*)
 
 testlibs
-  ~ (/qemu)?(/tests/qtest(/libqos/.*|/libqtest.*))
+  ~ .*/qemu(/tests/qtest(/libqos/.*|/libqtest.*))
 
 tests
-  ~ (/qemu)?(/tests/.*)
+  ~ .*/qemu(/tests/.*)
-- 
2.34.1


