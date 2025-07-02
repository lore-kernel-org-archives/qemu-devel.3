Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9491EC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfi-0007XO-GR; Wed, 02 Jul 2025 08:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfa-0007Rn-F3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:34 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfO-0000vk-B8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:34 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso1833693fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459659; x=1752064459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhQUB7hyHDeuRRxTVEXkMU9ZRf7I73lwX5zX+yyMAK0=;
 b=VOiKUZTutNNEzuW8XCeLzO3gMyUreWQO/1yFleQv4QmRHQXeV8xrMFhRVCXNNFLm1N
 TxktaHvGCHgeINJZv4hNdxJx2JZVm8qxPM5PZM7HMjiZDqyvC2NHIf4LYEZDe9q4w7pP
 i2LzqVzLIvHi1WKeQh6pqAjiiD4a0IjsrBex0/7WXvxRKAO9j15qdgDh4xsp5ZU43MNv
 XqFuYJZZUJdLJZpnzfk1XsIKPnMOBiCPO2dCSHKChgX0o9DbzKidQrWSTIFh2WwdSFyI
 yYTlosYKwLH5VeHoeO8iTVLMJUSr5E9t3USFapTAn8UofJOMz6Vq/4jiYaIYIS1qoBvH
 DYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459659; x=1752064459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhQUB7hyHDeuRRxTVEXkMU9ZRf7I73lwX5zX+yyMAK0=;
 b=LrWbjDMqRs5tUktwnVbKVEqyTQip9+rs5nl/Fj+KN9afVkPbUe6W8xmgRK9c9mSyTu
 yGRlk4IbKY2YTxGQgzSLfST3b6RHgWiRLvz+MWN1DzXQOIYW7Vo/RwZGK6MNpwy8l+3O
 9wtEXhjBsoKI9BT0mPw5MpMB3jKq7KJwHgXmMozoBFbS3QTk7xm9JVDO4Q+SEHG9USab
 fonjdF+WD3z5GdI9ForJvwpwNHZw1iPGIjr+xmQApcgPOj9soCfMuhpZoTZhDfQX4dWb
 ZQIzmusYTckcFlYbNE0jfTSoJsVKJ6tJdmGfCYCp0jadRUFiWRETd893Ay1rRV7TRuWx
 Whfg==
X-Gm-Message-State: AOJu0YyGs0YUTcHcjTj4FYM+3qAqJBzmnVHxzOv7GZvSLfYWEjQBPG7R
 FwfT9DFyQgZEkPgtKTM59cVA46g3dxNds+I9Ka+Nx5wiKlzqQ0lU+FLA5jb4ExT2fFhcQm9ZnVp
 7J3yMzIQ=
X-Gm-Gg: ASbGnctCZ374rgd0KzKru5M77/u4IpPRc7g+1y6Yg5jbYShVUu1qrb2Z2N7RoTIcE39
 vfqdrqVH4GxFpgBlIRBHajqvmiyrFfZTTmt9HLQmJ35PuPIqhfCqUbQHBbtz1WzB5BERHxb8oOc
 GxOStqF8FRlsZosXCSvTIIUg4kGDKaaEDdALhLfz9NVTcc5HdykIRpixj1yGOb+udGMCcPZKXaq
 AnPr5XNnkd9PEVQOV61MOSO5g8QXrTbaCEHUeaSCdZmy0MM8DIpO3Ml83z8PRRDmU/ZjEneU/d/
 Y4hf4v/7BZwH0QmAExzxq1ZjkUbB4lOM+lA6eckVUuIvKZxnM4c98Bv7SBa1YAXK00zQSg==
X-Google-Smtp-Source: AGHT+IEcDWtPLEy7RhS7Q+mCxqkzo7OTKngVLFVDWsJJM/vTgAcRXo2MHw5vhpcQsh+m358YLCYy0w==
X-Received: by 2002:a05:6871:89:b0:2e9:1fae:4aef with SMTP id
 586e51a60fabf-2f5a8a4eadcmr1921677fac.13.1751459659480; 
 Wed, 02 Jul 2025 05:34:19 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 05/97] target/arm: Add ZT0
Date: Wed,  2 Jul 2025 06:32:38 -0600
Message-ID: <20250702123410.761208-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a 512-bit array introduced with SME2.
Save it only when ZA is in use.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/machine.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a6a54a605a..f3c83702f4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -715,6 +715,9 @@ typedef struct CPUArchState {
     uint64_t scxtnum_el[4];
 
     struct {
+        /* SME2 ZT0 -- 512 bit array, with data ordered like ARMVectorReg. */
+        uint64_t zt0[512 / 64] QEMU_ALIGNED(16);
+
         /*
          * SME ZA storage -- 256 x 256 byte array, with bytes in host
          * word order, as we do with vfp.zregs[].  This corresponds to
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6e73368ef9..6986915bee 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -321,6 +321,25 @@ static const VMStateDescription vmstate_za = {
     }
 };
 
+static bool zt0_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return za_needed(cpu) && cpu_isar_feature(aa64_sme2, cpu);
+}
+
+static const VMStateDescription vmstate_zt0 = {
+    .name = "cpu/zt0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = zt0_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
+                             ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool serror_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1096,6 +1115,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_m_security,
         &vmstate_sve,
         &vmstate_za,
+        &vmstate_zt0,
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.43.0


