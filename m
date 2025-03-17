Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A0FC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSV-0000pS-9S; Mon, 17 Mar 2025 10:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSD-0000dm-9q
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSA-0001BN-FB
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so10349415e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221707; x=1742826507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tYj3G1szAGFvKi0B3MWQ+0XMe12lN1gxPElsZir29Jg=;
 b=b3XIUzhUe0vQRqU+ffWKcVh4kDU4rMY4cf0/8+JNq3VTxOTB7MWCAHrGxKRPx4vQx1
 EkHPCRDbFmGScneDxVq+ZLRlUeThYtpDRJdQ8OMhgMfLJQ44un/UjUuteDucl3YJo6lv
 ooDJuaIozPXtGdjZOHTUQugX7zo1fpm8DH4SYekbi7PxVoSHuoRHwaXJDFolyhcHahFy
 Z0XwgJ+wYWEodJY6hZIGt8/u8YE0ILIbSMWCJbmXTYnDm16cn/l2i+Lp9KH8snurLNre
 WbNvLvwMKTvDYjjPYuAukdgt+YmKuE77NrY5kBilIPX3urrpC89BY4TXQl8f47og+C/I
 2bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221707; x=1742826507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYj3G1szAGFvKi0B3MWQ+0XMe12lN1gxPElsZir29Jg=;
 b=Zv05KYYg+M1e5slErzph0cgofLSm/hgqsPAtCTR7CkqYlj0JAamMVHUrfZEh5r+twZ
 owEgVXjEo4eICSBGqRmKbtzEZSNTkBpGOMOvp7wHQOvcjfK85EBIjr8Ww+db1qnraQtz
 836y0Thtz+3c6aD/cSwKApII2U/z5+VBBIKwl+4/WlD4YF/y2rGmalPB/d/x2e/lfpRu
 A9bIocwyVfc6BrSDhpkyAE9ynIydrKizsXUPYIbBblEV/7nyTXhHufJgZkRsD/g0Ky1O
 InJbY0Uk0hGtsSfJLxmfe1u29QHMSPaLj08TrHVvjs3pFq1Z8Kk9VM/4fcOR1qMAWsqv
 IYtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY1jjXy/r/yS9xUdHwKt7tnXr8YnSzm/3/WCXpsrwdt2qn9l8PYlmptjhOSL04TD5hBOhbyYdM6ESb@nongnu.org
X-Gm-Message-State: AOJu0YwH7pZDijmu8aInFw48ut6PVAZ1b9j6nLK92IrvTrmEv3i7Ed6E
 4JPj7m85WUbQL3NwWorfr4TkRGpgrJL3JwjC7jN29fHhliQliO6CZT+eKnsRRui/po5QLfrR2go
 M
X-Gm-Gg: ASbGncupPqzVnxlWbsa1os6rJpPCVj9m8W5nEksBWuX4mE4JvCmp9AOumYZTi9/+UDl
 uDy3/BW4e03lVTYgyvA1tc0M1jBfJ3PTJY5Ng8WfnxZXXw1wGrm1SdUWm+yKOt1FKPNVk4PpRqV
 ezEXqngKUPGM7kBwBlUHtq8Ywsmy4B/XKtZSDfuDJoaPtbSn3o4bMqygbVZwjQkG4ODNKqbYHsD
 bLUUHA3oRIKW56Cr/DcwmL/lNLzS0IgS9NXcx55K4mxnF17wgtZqQNQOqElxGPbaGNwUZs+GR65
 Ii38Xv7+fBZF/y+4l4ObokFNZDPqY+9dNNjogfjjDuyYuSwbjGI=
X-Google-Smtp-Source: AGHT+IHUudbHrgd6qG1Y7VmBlWkjN8df/w9ap7+NWjr6UcefN0AwPycY0R1WkIGRbw+wWNtvcewmiA==
X-Received: by 2002:a05:600c:3146:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43d1ecb33b0mr126241885e9.12.1742221707629; 
 Mon, 17 Mar 2025 07:28:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 6/9] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
Date: Mon, 17 Mar 2025 14:28:16 +0000
Message-ID: <20250317142819.900029-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Currently we provide an AArch64 gdbstub for CPUs which are
TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
TYPE_ARM_CPU.  This mostly does the right thing, except in the
corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
and which to the guest is in AArch32 mode.

Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
behaviour into TYPE_ARM_CPU we can change the condition we use for
whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
This will mean that we now correctly provide an AArch32 gdbstub for
aarch64=off CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a14c269fa5a..a18d87fa28b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1694,7 +1694,7 @@ void aarch64_add_sme_properties(Object *obj);
 /* Return true if the gdbstub is presenting an AArch64 CPU */
 static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
 {
-    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
 }
 
 /* Read the CONTROL register as the MRS instruction would. */
-- 
2.43.0


