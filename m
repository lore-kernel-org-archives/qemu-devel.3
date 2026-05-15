Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBE7CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7Q-0000jC-63; Fri, 15 May 2026 06:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7N-0000h6-Mr
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7L-0001fw-SG
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so106125035e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842206; x=1779447006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YKbmlybhLrxLnmhC1Thmc4r8WHSL4g1H/3NFgasRJQQ=;
 b=t3icP+DmfY5abqtMISkHNLvZW9URRrP6tlBdRqtUMoVA9SJtnomEcimLu5Qm/5GXO+
 oEydnKGD5RNedhNcTKAPhl4P3AhlUtzrgt2Ez8rYh3VrrGXrzd9cLIYgTgyluKKX6+7r
 sY+PwnsUGhbQjdYTBuiTsn92Y73Bh8J8+rmaoQHai3zklsqqKawA1zD80Zu6Ifiwv0Wz
 2MosoGEoFsP6W8MvCXcpltL6RXqy6T1bF43475WrWvwG+GZx8Q7UtTC6naV/bD4T3T97
 AxPjHUOnz7HAWP/XUrKxQFyxh49QMrgKJYUUM4kkqzoH+dIVxQ1oIqbaJ/NHNcLh9cZE
 VaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842206; x=1779447006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YKbmlybhLrxLnmhC1Thmc4r8WHSL4g1H/3NFgasRJQQ=;
 b=ReSOCuyi2IFSvglyVxIJi/Jn1a+QlGO0Q1GgWWt7XSTvDjjLUxlf5h8KAPPbX2NVrQ
 5aT12w2EHK7vw1uFIXi1WPwJDzebX7HjTDT8dCLdTuyJsbqLVr9RjuTK+dvgo9p2ZxcJ
 l3YFeeTU7rszy3M1+DgarXFfUV0tjuBqHB/6rSMcRuPPrnKsoP+6k01iYfHsV5a3lKPu
 y8Gp1NtujDt40gsnzy4aG47CR9Ec28lHL0D2uqB5DAWo+4W0+15SqhIVfMJqevBNCzVw
 PsOu5r9Yzx7qct0j8rx4SmEcZkgo1OsioC6XkPn/bxw7L/+ya6W/mil5/EyWL7k/xs13
 H7Mw==
X-Gm-Message-State: AOJu0YzkkLDMBqwpEGQXr7JYUAe6lx2Uxjm6TJaO7i89D53TsfMlxlgr
 EncZ8/W2D5Lf7bO+iBIsfYX7xTO/8XSAwkd5LASISXZzac4xwguu/oz2beE50avFPcdbQVlD0gC
 rK6js
X-Gm-Gg: Acq92OE/LeuVu48F5V/r9bO9OYO95sggAInzqPWGTQZGlEw3B2+dBPWaccHT5sZ84Ar
 AtjhfxljoU/js3kPVWyyI/Cg/vcdkZMGQnr9wpdCDHsO/10DvICh4cx13xm0B8PniG354plNrJo
 DcfRCktAbMfcA1Ceo37MFuaa+mC5uxe2JxoJNHLTq/rcq4nHndfrzdTEjJ3OjbylXdTVb0ymOnO
 +Lvx3xu1S8VcBSY5WIkCOlLBOFXZi4LSodDht0kvdFgD9DmZM4N07u58YBorWtIjAJX9JI0jDS/
 8YAPPJnIELEYM6HiQKEe2wosTUQnif9CbT2Iletf87jL9wwryCC/spHi/ssxpw/XBQE7YCTi1FG
 coUQmKjuJJr0P3T94zFrlOVfTTWFhL3lLBrUvczPTPC/HM+SzoyZJ8V++SEoQCciTGJvRIVBPQA
 DLwQd7FC+iDpqmT92TtVQlz5zsSVRzeiZDOKYl7iIEEEtFKITC42qqnwalezENdM24JhIBT82PQ
 bVCmJ6TlNf9tB4fDFm12BC+qkoYFlw=
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-48fe60e1451mr44655695e9.4.1778842206370; 
 Fri, 15 May 2026 03:50:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/23] hw/remote/machine.c: Mark x-remote machine as OK for
 AArch64 and AArch32
Date: Fri, 15 May 2026 11:49:38 +0100
Message-ID: <20260515104945.4145203-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

When we updated Arm and AArch64 board types to mark them for the
target_machine_typename() filter, we forgot about the "x-remote"
machine type, which meant that it disappeared from the set of board
types exposed on the qemu-system-arm and qemu-system-aarch64
binaries.  We didn't notice this, because although we have a
functional test for it, it requires the KVM accelerator and we don't
run the functional tests on an AArch64 host in CI.

Mark the machine as being OK to expose in qemu-system-arm and
qemu-system-aarch64, in the same way we do for the "none" machine
type. This fixes a check-functional failure on aarch64 host, where
it would otherwise fail with:
   qemu-system-aarch64: unsupported machine type: "x-remote"

Cc: qemu-stable@nongnu.org
Fixes: eb796c55513d9d39 ("hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260507194728.2034696-2-peter.maydell@linaro.org
---
 hw/remote/machine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index ced782f6a9..df08f64019 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -24,6 +24,7 @@
 #include "hw/core/qdev.h"
 #include "hw/remote/vfio-user-obj.h"
 #include "hw/pci/msi.h"
+#include "hw/arm/machines-qom.h"
 
 static void remote_machine_init(MachineState *machine)
 {
@@ -148,6 +149,8 @@ static const TypeInfo remote_machine = {
     .class_init = remote_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { TYPE_TARGET_ARM_MACHINE },
         { }
     }
 };
-- 
2.43.0


