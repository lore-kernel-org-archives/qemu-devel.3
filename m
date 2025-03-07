Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BDBC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgP-0004zS-JR; Fri, 07 Mar 2025 16:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgO-0004z6-At
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:40 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgM-0001jp-Pm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:40 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso45566075ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384597; x=1741989397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUvuEjETtAwgjY+HHVzD3fRoYrhNXj1rMDKPunM+tus=;
 b=F+g+8vHDpDMKOv/bgDtN/FuHQFjtuooWOzKVxDJNht7hLRyontwpYiimeJD/HjYavR
 1fOnJkeIltyYdVjfThJorSKC+BVxMQM+PUdmxocIKlBuUXloJGGKax7KEHFAPnDUdfCt
 J3Xpf25imh418pfp6+JjFBNmp24BbyqE6zVWR5voCaCrz5pRXQQRFzZyKmsIlAhN6dZL
 O6j0HB85dg+YMHRpoiLl5BQNgwSDiri4010y8NDvHteOMt9st79cBWbQ2S8RoGNb/fP1
 9JocJXBfT6qNVGUBB1SEeVazTDThQ07spSzOpKTWKxDs+C0mJfahHEZSc1gVZBgMMRI1
 H1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384597; x=1741989397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUvuEjETtAwgjY+HHVzD3fRoYrhNXj1rMDKPunM+tus=;
 b=f2EwDZW90ay+4G/y4tjOaZueToKAgjvNgq4awEPX4XyvpDiaO9Vw31JVAjxW1myIWO
 2kIgA5MirHw3EamO89CwZAeZ0Otz5Q9d1FJJLPC/SHFQkmlgYQXxQQGGZ3SpaUQL2MjH
 bYSIldCO7XM/IMnF6yOZEBcDjQMsF/S8h79E5tzR8zqcYvpgGXYpsCuxII0TlYdrxtut
 DnXY1309x9UAldv5GV23Jzj8a1qp1QAVUCh/bh7rUXZ6qZwrePiwxtB3+uUSkmaaR7B3
 2ir0xAc5dQdKTmcg/BR5WMkq63m66XUs56OzPyCjkRTMcKbFCh6h0vFuLdlT+RAYwnfX
 d3vQ==
X-Gm-Message-State: AOJu0Yxyr0atWCXmdBUooxvS2miqmhjCkAeaiO12qL5fh6v8u6xLaeJW
 j2oNatu/a1O4aRSqQk5myxoQwXS7+yiHWh6UyT7GnlJzv7Uqvm07tFd5/X+p4yAHXO+xc6nADK1
 W
X-Gm-Gg: ASbGncv0XaRIFVvGwFlCKdNIxCwFJFtXTYM7qnsOHb9Okz1eXtZJ7GflFi8QmUjUfg4
 LQm/tA25sQKm01CU5p27SnKc/ItqgfVdOfZmqIhTbNoxEn9m93Kx6JuV3GZDcQNl6Q0wayiK+rZ
 ThYpI5EbX/maOzerNqsggWIvbKH9o5xuL4yK0ymlaha5k5zsm5WzHKB0Mk7+030ZH28pvVjELiz
 qNGCPnFBBOwggnssqDS9WX5wKiB82lLmsOSBpP8TWClRJ836BBKnvBUBTcbXFuL1n39gQJTq6b/
 m/sX9nymmjlfsijP3sZCCZ3ocnqNIjDUgC2wz4FYCtPP
X-Google-Smtp-Source: AGHT+IHLPRxB/7hl1LzXp8g7IAxNiV/3hkTKlh4ALyWckQE4KO22jH6W1sRSH0NFB/92LHK2TzzblQ==
X-Received: by 2002:a05:6a00:b86:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-736aaa373b8mr6645441b3a.10.1741384597425; 
 Fri, 07 Mar 2025 13:56:37 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:37 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 4/7] hw/hyperv/hyperv-proto: move SYNDBG definition from
 target/i386
Date: Fri,  7 Mar 2025 13:56:20 -0800
Message-Id: <20250307215623.524987-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Allows them to be available for common compilation units.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
 target/i386/kvm/hyperv-proto.h   | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index 4a2297307b0..fffc5ce342f 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -61,6 +61,18 @@
 #define HV_MESSAGE_X64_APIC_EOI               0x80010004
 #define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
 
+/*
+ * Hyper-V Synthetic debug options MSR
+ */
+#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
+#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
+#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
+#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
+#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
+#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
+
+#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
+
 /*
  * Message flags
  */
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 464fbf09e35..a9f056f2f3e 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -151,18 +151,6 @@
 #define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT                0x400000B7
 
-/*
- * Hyper-V Synthetic debug options MSR
- */
-#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
-#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
-#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
-#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
-#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
-#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
-
-#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
-
 /*
  * Guest crash notification MSRs
  */
-- 
2.39.5


