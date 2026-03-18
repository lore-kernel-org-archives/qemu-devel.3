Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22144103E160
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oQo-0003bB-5V; Wed, 18 Mar 2026 06:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQZ-0003VS-O6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQX-0003KM-JE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so23943995e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773830819; x=1774435619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSwkM0P/J5XAoRgFils81Qyg6RKqLdXdbIdwNlenliE=;
 b=KrYM7EiX1BSTm06EvQPeyTT1n/uA1T+7AhBxugn3+duAsA+p2xelXlnNUuC5AoWZR5
 /FMM4OgzfqiW+IzFs+8R05vbDxUZx1feKKa66W4YemmOohmU/0hzk1XsQsIP1nWaWup5
 wM4qbj75ZL6IZ//siMoROpUUkL6iMbxWC72cG5OpyZiVa8iDVE7J0B3t0hJhCFw1VNxQ
 HqCD2/eKwfCenxzMeG6kCOOr/RTsYnW0naVIXJJOQN7wewfdR6IIqcq8Hx5oMDTHze2s
 8AG2xrhb17rJHz4Q/1iZ1DSjPssqEloVSl7/8J6B9LXVMwITwCNEwVRPJHUNFh+AVRtD
 bJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830819; x=1774435619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VSwkM0P/J5XAoRgFils81Qyg6RKqLdXdbIdwNlenliE=;
 b=QOCtB2Rz17BfzYCiY5U8lIyt8yn4Smy8ICcozStnmZY5SrThJbpHAdCCtZRHqHoT5O
 18NiyJwSLyR2qFx1CIJksvufjG5zqsZvEBQinP4lAN1BL1YjxKosyqsHd5uSDW5njWoZ
 zfaITf4ZLp0eOzBKKt13MN4eTR8VcsNvhzp7FZpxpmAphLRYH8snrvE9KkxrqjZj9gvF
 62C7E9kwkF95Z479112++l/oVWmLwRCKzOoKMhyMnOlaGGoZO+lvFiF4e0ZuRmufIW4h
 BHh+Yw8ubmJJPRkZhmvtDNytlnnz2llsqcZ/TxOo0jGSSHl32N3KgMIF2ZzOHV83jPXc
 Br6w==
X-Gm-Message-State: AOJu0Yw2kUBuy+p59CCNtf33DnFOp/u0yWiekVY9l1+l9U3uC+YJP8/I
 eVfsR2IHReknfWsMNkKUjtawr9EoywF0XsyWgyg25QQi7ds3fNmOJW03ED+E007r
X-Gm-Gg: ATEYQzyL/ZDGE7AJDG8FmzGcV9t/Z5J9F6hHF8Q+v2/IHNNL8KCpW2vIuWyWfm7aVDH
 kPNlMDvlJmITSoiTOybBIp0enQLAPDgblkkyvaPWuFgI9RSB56cj4fkn22RNrhA/gNj5rsp8X/l
 kGDPcWbZ/g+GyQdUv44x7pPQDXZqtZIOyoCM9Dm3WngQKc5mWATmv3c61vBEISs3cdB7QIFqjQw
 Td0XPptNWM1G8QmEhJOzv13M+68gt13Ci8y6Ezi0nX0STRmR1M1oMV0XnSGDOCSrm7ah5uP2Oo9
 f2t0Hoofr21XNPytEXiRSHpZ93aKbgaeEc/6JsVDcyU/C6M/cJ2N2lIbLPwzlYw66Mkg0kTOCl5
 idZJklhz6UBS2RPJ4y3+pfFb7ePWJzEruGBpmFcyy8GVZAC6XvPQn+m27Ix6Uue4q9uzPb8Hi6F
 rNSGVCzHoSv4V8FHvIrqz0IGwMZVF7OHkIxMjNteHz53sP7Cvbj1/fufemCEjoaFnWyw==
X-Received: by 2002:a05:600c:4585:b0:485:39d4:2dd9 with SMTP id
 5b1f17b1804b1-486f45708e5mr49754255e9.33.1773830819279; 
 Wed, 18 Mar 2026 03:46:59 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-80-194.adsl.net.t-com.hr.
 [93.143.80.194]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm56471095e9.3.2026.03.18.03.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:46:58 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pierrick.bouvier@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Subject: [RFC PATCH 1/9] target/arm: Add API for dynamic exception injection
Date: Wed, 18 Mar 2026 11:46:32 +0100
Message-ID: <20260318104640.239752-2-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318104640.239752-1-ruslichenko.r@gmail.com>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement arm_cpu_inject_exception() to allow external clients,
such as QEMU plugins or asynchronous timers, to inject exceptions
into the ARM guest.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 target/arm/cpu.h    |  4 ++++
 target/arm/helper.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..f1d2d6e240 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2680,4 +2680,8 @@ extern const uint64_t pred_esz_masks[5];
 #define LOG2_TAG_GRANULE 4
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
+#ifndef CONFIG_USER_ONLY
+void arm_cpu_inject_exception(int excp_index, uint32_t syndrome);
+#endif
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c5769477c..73df3a9e6e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10241,4 +10241,59 @@ ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
         return ARMSS_NonSecure;
     }
 }
+
+typedef struct {
+    int excp_index;
+    uint32_t syndrome;
+}  FIExcpAsync;
+
+static void fi_setup_exception(CPUState *cs, int excp_index, uint32_t syndrome)
+{
+    CPUARMState *env = cpu_env(cs);
+
+    cs->exception_index = excp_index;
+    env->exception.syndrome = syndrome;
+    env->exception.vaddress = env->pc;
+
+    if (excp_index == EXCP_VSERR) {
+        /* Serror syndrome constructed from vsesr_el2 */
+        env->cp15.vsesr_el2 = syndrome;
+    }
+
+    env->exception.target_el = arm_current_el(env);
+}
+
+static void arm_cpu_inject_exception_async(CPUState *cs, run_on_cpu_data data)
+{
+    FIExcpAsync *excp_data = (FIExcpAsync *)data.host_ptr;
+
+    fi_setup_exception(cs, excp_data->excp_index, excp_data->syndrome);
+
+    g_free(excp_data);
+}
+
+void arm_cpu_inject_exception(int excp_index, uint32_t syndrome)
+{
+    CPUState *cs = current_cpu;
+
+    if (!cs) {
+        /* If we called outside CPU thread (timer callback, etc) schedule async */
+        run_on_cpu_data async_data;
+        CPUState *cs0 = qemu_get_cpu(0);
+
+        FIExcpAsync *excp_data = g_new0(FIExcpAsync, 1);
+
+        excp_data->excp_index = excp_index;
+        excp_data->syndrome = syndrome;
+
+        async_data.host_ptr = excp_data;
+
+        async_run_on_cpu(cs0, arm_cpu_inject_exception_async, async_data);
+        return;
+    }
+
+    fi_setup_exception(cs, excp_index, syndrome);
+
+    cpu_loop_exit(cs);
+}
 #endif /* !CONFIG_USER_ONLY */
-- 
2.43.0


