Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E0510D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B8e-0003HO-OR; Mon, 30 Mar 2026 07:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8a-00032E-RJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8Z-0005vJ-0R
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SofHkglzIlj7gRwriJoYpIXXE5BjbplBzBVQuvwtZxM=;
 b=CIl4FmFyAfwSZu7ijckhpvqHQKKDhmdUvUopdDTowhDsMYa+BrHQp1tM2JtCtjdBPdMWdZ
 JNPR2nT5LMTZyri3nIGxiwgKx/eGXF6v1POgSSyJ6B1IMBV7MwU1FYz544NH+CyoSJxKjx
 Rr0AtyTFrlkRXHtlRwh8K+NPc3x9Nsg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-Z8a-alT-PAOB_mHNIMl95A-1; Mon, 30 Mar 2026 07:50:29 -0400
X-MC-Unique: Z8a-alT-PAOB_mHNIMl95A-1
X-Mimecast-MFC-AGG-ID: Z8a-alT-PAOB_mHNIMl95A_1774871428
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43cf7e96d4cso1432316f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871426; x=1775476226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SofHkglzIlj7gRwriJoYpIXXE5BjbplBzBVQuvwtZxM=;
 b=rxqcLwROLmKiZe2nB+G62duAIVRnInSSSIw8Ban6Mwh4aCSIk0hDfM6OsGFb+QZPo+
 kuw8UMAd+kfA1MVzjpQq6+QhtSUUQy2O4lDLu7kBBxk13rM8A++T8Im3IufVs+6kqEbg
 X/CYR0KV/KonGA6iJGoh7xxKbW5WlBlFuzo/debEPhc1RbkPUWjbztyzd1vMLGA1PggR
 1WA5RRea921J8Uc3Ez27h6sAhEUWN0/E2myu5XTd1Qad5izvBCVTRV5K+Pc0ckqNcxgE
 yTN9NoHGz0GQ3vmPxk/WslLegFbtZ6p7A7ynx1f9bCzyMzS+QKjO84eQuZpOJX2OBnPJ
 Hrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871426; x=1775476226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SofHkglzIlj7gRwriJoYpIXXE5BjbplBzBVQuvwtZxM=;
 b=pu3nBOLxl/twx1Q6iIctw7BQZ2E+uyQ6XCSxokG/Jo43+mGinq9uMC5ZMV+EnGRLvo
 eqkGqNeUHpkLqfmJvC7bDtrHLs5ZcKp9q9FfCBu19n2KuIqBE4bgHVwoPT0ydbdpasKH
 ZaP6Iy5uKH3e95lZ0y8wUvyjg8aRdPkYXt573Q+XQed4t8MFch6kHgHufBXUGwxXPSkV
 xcEwiiI1sNpChZwA62C8swcL5AF8rVtDmYmA6ZiZ7Xz6YcGJm7mfDPeGqoSYQMBqEq+c
 fohEyh6irnlq+z5x5mtF0Lf4i9jw4tTjkZFfq80i3JpGHlKRxbqf5uEJoqVqRctjDBFj
 VI2w==
X-Gm-Message-State: AOJu0YwsSiFY3logwhYyUIHaQ6vbK3lFeTm7Xii1rxDQ8k5/rNpXtBqV
 jvev0wYZzEmKFfOilyn+/Oy5hPFiWG1Smd6lrXASzQeB8NDLknK2ovwZ6a1dOfr9aaVDtNVyd30
 KGwNWJlcwAnTeDUY+d/cXh90efvNoUZWqwL9q9fryofWr6E0ll9qL9sdVBgOq9GCyJp2KIGR28P
 950oQJGvgaUNJRwpWEYhCB/vaIaEtVW2tTi8xhBqLr
X-Gm-Gg: ATEYQzxRpiJh61EUxa09/biRCckaTsw+knqXeOUahXXDZNudH8aboyHI8wPLRUr3ziD
 wrBtUNTuT0WjgGyqLovYO2biMR1eIujmALort81rGIICJrfH8GZl0kqKqqW08doPyZ1W1v0aY/n
 vjHbCjXcZ+bwJHA1IbqSbgykamCwSMlqvyfT2TmLu3xfUwrc2yNyF42CbBpQhLG+aYDTM//kxr2
 KiHs8WpZsUc/Ex+LZK+SLReDAO3ZpDnUY1gC0KXP81jPNW3BYQsKRc1GkzaxLjoO2qx8YMWpVq+
 W8bopi1ha/bNQODRVpWTjzryq4ncyc7fqXnQptHf3S1BUHQAXXyFr24QZGer/8FiKN0IXFowPU5
 WKjA3gll3a3WHa9R2dXRKEZ+7UwlP2jx4JcIDrCXBjfuQl3PxrUTIpC2VJTM+fGHFYpWbGWZfo8
 19hk1Bs9wheAr00xGDKlMK/xmu
X-Received: by 2002:a05:6000:268a:b0:43b:45da:f296 with SMTP id
 ffacd0b85a97d-43b9e987d45mr20423212f8f.11.1774871426284; 
 Mon, 30 Mar 2026 04:50:26 -0700 (PDT)
X-Received: by 2002:a05:6000:268a:b0:43b:45da:f296 with SMTP id
 ffacd0b85a97d-43b9e987d45mr20423138f8f.11.1774871425717; 
 Mon, 30 Mar 2026 04:50:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2727sm20201581f8f.2.2026.03.30.04.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/12] whpx: i386: trace unsupported MSR accesses
Date: Mon, 30 Mar 2026 13:50:07 +0200
Message-ID: <20260330115017.256211-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Not actionable information for users, so stop
having it displayed unconditionally.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/r/20260327011152.4126-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 1 +
 target/i386/whpx/trace.h      | 2 ++
 target/i386/whpx/whpx-all.c   | 5 +++--
 target/i386/whpx/trace-events | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 target/i386/whpx/trace.h
 create mode 100644 target/i386/whpx/trace-events

diff --git a/meson.build b/meson.build
index 407eef5b4ed..daa58e46a3c 100644
--- a/meson.build
+++ b/meson.build
@@ -3687,6 +3687,7 @@ if have_system or have_user
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
+    'target/i386/whpx',
     'target/loongarch',
     'target/mips/tcg',
     'target/ppc',
diff --git a/target/i386/whpx/trace.h b/target/i386/whpx/trace.h
new file mode 100644
index 00000000000..b7c090deff3
--- /dev/null
+++ b/target/i386/whpx/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-target_i386_whpx.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index acae61e089d..e56ae2b3433 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -41,6 +41,7 @@
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
 #include "emulate/x86_mmu.h"
+#include "trace.h"
 
 #include <winhvplatform.h>
 
@@ -1921,8 +1922,8 @@ int whpx_vcpu_run(CPUState *cpu)
                         1 : 3;
 
             if (!is_known_msr) {
-                warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
-                vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+                trace_whpx_unsupported_msr_access(vcpu->exit_ctx.MsrAccess.MsrNumber,
+                    vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
diff --git a/target/i386/whpx/trace-events b/target/i386/whpx/trace-events
new file mode 100644
index 00000000000..ebdfa34b281
--- /dev/null
+++ b/target/i386/whpx/trace-events
@@ -0,0 +1 @@
+whpx_unsupported_msr_access(uint32_t msr, int is_write) "WHPX: Unsupported MSR access (0x%x), IsWrite=%i"
-- 
2.53.0


