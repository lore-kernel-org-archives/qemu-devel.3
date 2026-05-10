Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752C8CD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgi-0006Jx-Ms; Sat, 09 May 2026 22:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgd-0006Hd-9d
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:31 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgb-00038s-Ji
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:31 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso2717896a34.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379268; x=1778984068; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=84NzeKO4E0K6QGx3U+uuPPhbslMAL8hqeCojK1H7E5I=;
 b=WNpOXKVSs38syA0lw2pD/fSbftx8NhW7jZ9tAapqtQFOUWx0KGGFS8bydO6a6HhAYS
 EnG+0F9YA9UfdWHXTH/gDCMhkL0i658VZdic8ufxLkY7BqNwjcZLe45X9qWM6Ji3KamR
 xOGoGUhGVnjYhV6eD6I3ijgBNj54o2cZhCGtco4wKERxshQctdtiF0Q/oWaf9C6OItWd
 2T/LC9vxfWv4AoehL87X7nWSCEF+Dv02VxmfnLpli3sNBbUH4BoBn7hSJaIuvLEHyB0u
 m8p9zaj4gNebrDSozSFQMGOHO4So9zejWjdFDhFBNOR1/i5t3yTQ9coOwnOrQXFPqCol
 oCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379268; x=1778984068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=84NzeKO4E0K6QGx3U+uuPPhbslMAL8hqeCojK1H7E5I=;
 b=ey4soj0Qp72ehOoB5/1ecWxm72aHUad1FVH8k1wuCcmBv7HyoeIDMfcS8ixsExsSkK
 +62a+VWYNeK+qVhctLv7FbGIdFMvKfRPLm+IZknI/pk7/aD0Jm9skDXIOtX9V+C7H6B2
 qxlfsNFBtyafYUY/351n+x8S2ZPVJrfLdbNQCbHbCcDAeuswwX5iJ9lj6osn8pBKhOLU
 TzULVo/v5u39IppoNAxSW0AmSTbTTM/4c3ukqNEWL/0HsQPH9edoLiPDGMyDvEgtS/Te
 G5RJlmJ9ZdMut4EK/eQYs5Y6OSgzILUH858w3tnJICxV4NgzAFVYokqKiTYMzlTgjNTi
 YMiA==
X-Gm-Message-State: AOJu0YxtWi0qD77ag9mC80kt5kp44MR7seJKYY8NiRStai7zAa5ka9dX
 Oh5DYqAKyMshn7L64H1M4/XAOs50ERKaeDnTiJlGrbyB6apXkumsmI1+n4Ud6/8P
X-Gm-Gg: Acq92OEwLDt0omAQafNFq1l6wh99ZC2DgzA1qo6lcPUyDowDbSWaBVbYR8zGrbio7kp
 76587kwhgbLT2htocR3UficZ2aQAnpoRbcT5aQV/9KFlUNTg/5MB8k3aaPgQN8S1p5JhI6jtAA9
 TdXZ1LRgK1RpVnfJhlNw10ZfjZ4L+VcQXBMcARdq6oxVD7zd2BkNDgYFQgz0PlVDxKFQG8yye31
 PLb2+KklCKdt2+nSBex2LYwRon453g8O7CqtzRtma5/kgnq+8ZknbgurAZQlOCmhcwQyWXk80k3
 faKDOeOK9e4GVhTcoD46jgSmqj+MSUfTkWQMzR5X1VEP/2TqvqyaJDfRj1Xr46TdxAYIQ7sc95v
 NYxnAfRSo5VNODr2pidgap8pfuMQ2a3DJjJ82qVYWxtB9yh/cagOdk2gsM9JSWwS98Ing1wtCBi
 8zXMzSD5Q6B6a0kPVWt2PMkwIWRGYW+aF9/iIvP9vHf5m2CiBWjnwg1uCFDo8sYKZHYND+1M+DT
 McaNwHD8GXC/jAftb7ZEDkg1Bu4gTCAxdeJMUkRgzHVyLrzsU1FlDdZeg7M2/QSQSDVxCqCFJ6z
 e00=
X-Received: by 2002:a05:6820:2016:b0:67d:ea53:b9c8 with SMTP id
 006d021491bc7-69b25b76649mr4786855eaf.18.1778379268278; 
 Sat, 09 May 2026 19:14:28 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:55 -0600
Subject: [PATCH v4 32/32] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-32-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and
use CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v1 -> v2:
  - Move this CPU-model correction into a separate final patch.
    (suggested by Philippe Mathieu-Daudé)
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 69e02532c4..37c14663b2 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON | INSN_OCTEONP,

-- 
2.54.0


