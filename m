Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B43C41513
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWK-0007zV-OF; Sat, 22 Jun 2024 08:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW8-0007lN-90
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW6-0000JT-1C
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3627ef1fc07so2171509f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058008; x=1719662808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q80ETzRCCkCb3DcVGTIB+XWfmYB7D+9l5kess+RF8D4=;
 b=bQxtYzMBazJ2/9gpWUJa8htFChCyM0nnIJNxAE8PeJ12vf+bdPCeWwaZZttCKKzKr2
 nkUd41gS0MycbXlJqvXQsGzsBDmDYN42Z1PAvIK69hhtMncT8sir5wpD7xJgr+t6fJLx
 cko8GxHkcXUSuEIKvz2g3nsY3cVwiVtKFf2fGtFvz58BE7Bz1uP6BGJT2bqvT50V3s8R
 LOCaRTgnreZAPNxOQQfA8U+AvwYrHKL0I+QNkIKBBiw/Km5zgUB9d6hkzJUjwdq/hbKy
 aKa+PQmWpHujqHJ+WR12nuxL1mx5mZqSWPsWGK4pTDzf9t+3ZaOl4lRFCegX53VawqKA
 dyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058008; x=1719662808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q80ETzRCCkCb3DcVGTIB+XWfmYB7D+9l5kess+RF8D4=;
 b=mWaBNhKgP5+ySAPKYFMheYEMR/0jn6fb5bgfrUI+MN/WRMmas7XxC8xQ9/PnopxD47
 BinIBGpqb27cvVvNAjnjfugFaTYL8c4p/F7lOK/93jqDgP4f7IkyWmyHQlFbz0f1wB3t
 aoDSF4fGm6Iz80vBBtIRZh48yAFCvJ3/blSD2K3NcF26DmyJoWgnOtZj1i8j77knl6Dx
 XW1ZH+T34nzUeTdqwaUzy5nEAnY6Q62bz94nNTfhJQm6SuP9Uag2kmBaOsuDDPIjEBNq
 YqbfmIWkvMdBkDF4QQOg4mISz/I6VLqEi+5vqkXKaIduo05Tq3ZtuXgcA56ppxgoeDnM
 1dgA==
X-Gm-Message-State: AOJu0Yzysn3Veza21BGb42izH6GY/iA+OcqINLfVApyieuRvGz+gprId
 3O8WgGtPDpeRRA/UoJo29P5uykd24AeDQR4q9e0XLpHp3V77QQCTdmMrF5PwQNRWG9qFry6rCLu
 dgdg=
X-Google-Smtp-Source: AGHT+IExwuWBoGhx24f+Fq8mTGZfliIsOz33+VDEzSjoAxAyf2Cefc1CoVhiJ1oCVJdnbdyAtKQehw==
X-Received: by 2002:adf:e9cc:0:b0:354:c483:a469 with SMTP id
 ffacd0b85a97d-363170ed457mr7401920f8f.1.1719058007726; 
 Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] scripts/coverity-scan/COMPONENTS.md: Update paths to
 match gitlab CI
Date: Sat, 22 Jun 2024 13:06:30 +0100
Message-Id: <20240622120643.3797539-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240604145934.1230583-2-peter.maydell@linaro.org
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


