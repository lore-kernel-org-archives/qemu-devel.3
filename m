Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78881C982D7
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x86tr-0001aq-VT; Sat, 19 Sep 2026 22:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bodenrandin1@gmail.com>)
 id 1x86tp-0001Wv-G1
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:03:25 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bodenrandin1@gmail.com>)
 id 1x86tn-0001A8-Pb
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:03:24 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469b2e1d5so2047876b3a.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789869802; x=1790474602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=raiDdcZA37qcIE6HVnTuM2pGVhHDVcrzfWqB+myqDvM=;
 b=q2JHEupXz+7hLRWFEWp2XmLfUKjMRwbS33R4DdU5sO6gL6tuocGrlAJjD1wlofhQmr
 u0gFXdbp0FVb+jwrRU4Hbi5pmk8l26NlLUF4YGn/xOPeWaxMWVGmlrLjFGtXk8pslt4Y
 yauIookaRrRkWHzJXF/GDMZLisiQSZlw2F31JGx7VGzRi/+OloV2lB8HX0tgGN2o2RUo
 hW79BXI/syGjiA86uRcRX762k0GyL3+j09vgoH6tsemWaBq+xY7nocUQOrijyvcSgA7h
 yAeqmSa1nvvCWG/gwrOif03nyvee6ATdTi4iCAmnzbQXhYEOouFU8kkmSslswUht2x5h
 E0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789869802; x=1790474602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=raiDdcZA37qcIE6HVnTuM2pGVhHDVcrzfWqB+myqDvM=;
 b=pzK+/jGy9QRLRyFJOsiEAx3W1UP7pJpEbGNZCpg+ewYgTXGVe7nLfgdcbnNfbAdSao
 e66iPHhBILDqkJT1+Ce77jtLq5+LDoyB2KL3Zf4Kv3GFfzae02/0BY3o98fJNm7pWNnw
 Xrgib9AJv7GImcRkFzzIUMGk72RUFTwJMruo8FSETQ93QHmBbXJItX9rQ87+jYNUD6XU
 Hg+F952d4XzfxSuxwB6F8gtWejyb/kuPP3DTA4pxUFk1l7RJwuHO7lsbk9NRrKNLJYWT
 ygzxmoPK+AK9xJef3ym3rOgL7YpDeU4UKApsqinAV3jx55OtQrz/ey0xVrpqoXq5TH+9
 Walg==
X-Gm-Message-State: AFuF++khLPKD0/UGq8BAT6iMJngdiezHsaJsdAI6YwH5CmdUjkO9L+8S
 zcXJttzqRXeq7znoAuMU4hc6W7wfPectcbO5vY7oQjtGFCgyIgJcZgjWtPy1eA==
X-Gm-Gg: AYBFou2ni46W5RB/NcQ6gKrHSveXYvxDty3EvJcWHMj8EDOS7BhsVH2ZTXh7iphoDjq
 JgK7J4E/lhWSqrQmV1IVoKhWV4BQBWjfCQdpR6nuzjG/VhnaBpvPIneoObQwCicf0x7dlSMoqK2
 wkOrvcnezQA3ihu/UYjA1k+Z9sl8ltOtCVgJQX0AOo6ucpBxsuL5OjtAeOcso5VwV9mtKGBfwA8
 8t0iTacWcBMT+TKp7MtvsvQZB2dudCVXGnif8b25RTLZCYcKlv43CsPZTV2YLhPvTS4+juwjXV+
 cE4hU/87WjrBcVPc4VYnFfpZUTDV7tFd6hggLSt2Guw/vOM+sPjfrjI1zhIsnJhNtObSHp3JRt9
 gZwe+zKTd21tTS130rnoqhbfwaO+yCcbkZEaHX35O4G5QLXugxUwcurw6H96dNmLzejgvzIrVXj
 UZqIXZV1qKpNGQXWFHKAgf9ogDZo/tSULF2aOuCYaATFAGx1audTAbTSfVjZIC7Owq+rr0COfKH
 0DRMS/AC35BoI3huDwxhU/1nHxRew==
X-Received: by 2002:a05:6a21:140a:b0:3dd:a197:cf32 with SMTP id
 adf61e73a8af0-3dda197d889mr4877860637.86.1789869801930; 
 Sat, 19 Sep 2026 19:03:21 -0700 (PDT)
Received: from DESKTOP-D94CRUF ([47.153.23.114])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144da432647sm11982242c88.5.2026.09.19.19.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 19:03:21 -0700 (PDT)
From: Boden Randin <bodenrandin1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PATCH] whpx: i386: avoid updating hflags for vmexits
Date: Sat, 19 Sep 2026 19:03:20 -0700
Message-ID: <20260920020320.1466-1-bodenrandin1@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=bodenrandin1@gmail.com; helo=mail-pz2-x10.google.com
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

whpx_get_registers_for_vmexit only refreshes GPRs, RIP and RFLAGS.

x86_update_hflags() depends on state not refreshed here, while the code
using the fast runtime state does not depend on the hflags it recomputes.

Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
---

Notes:
    I opted to remove x86_update_hflags() in this patch instead of changing whpx_get_registers_for_vmexit to refresh the registers it requires because I couldn't find any code that depends on hflags after it calls the whpx_get_registers fast path.
    
    Please let me know if I missed something or if maintaining the x86_update_hflags call would be preferable. This is my first open-source contribution, so please also let me know if I made any mistakes in the submission process.

 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 113f79afb9..79a5256b20 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -744,8 +744,6 @@ static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
     rflags_to_lflags(env);
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names_for_vmexit));
-
-    x86_update_hflags(env);
 }
 
 static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
-- 
2.53.0.windows.1


