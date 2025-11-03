Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B784CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrdd-0002Y9-Ij; Mon, 03 Nov 2025 05:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrdP-0002Nv-Bw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:18:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrd8-0003gV-EN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:17:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475db4ad7e4so14954315e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165057; x=1762769857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/Gn6pj9/95Lzbm+SIWtnMyaV4WJR3oCGo7MQI4hS50=;
 b=XJnnEzck6eMss9mezEbv3edbPX5v3f72Iwh7ATUDQAJDV/LTbi9n1KF3QUYNtSQtA1
 M1ePtgJE46hCReXbGcLcHuLQ1kTE2NimHKRoas+gJmj79diYTt/DWMHzSgfmu+54pwsp
 rnYSdxAFkkHwAeiL4Ieusd3W7Aq1t1dbQ9gq4p7NP+O8hq1ioOEb50tPHpqNosf+xXrN
 s7XEML6yWagNVRcjfNHCqADrbV+2yOHG8L17kVtAVLYaSUBlJWhiHGHHwrhEZ0HO37BN
 bxh39sDBqeLUU/wWvXmcGmSYHfAzM+TwXlYsto4SjRD8UcDHx7731qN2FeUt7JLdiGYY
 1hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165057; x=1762769857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/Gn6pj9/95Lzbm+SIWtnMyaV4WJR3oCGo7MQI4hS50=;
 b=YHc0uwvoVLNXfwbjYY7fL3yAL0qKesDRj9dOAWxzxpzo5vq2ocAnYqROkOmlVJqGfQ
 EIIpaqNnBjZhkD4EMAuyVLWiuvvui/GiLFGgb5qc/Q6VU2swg2CsNdcLP19PeQ9TpeUR
 KmH8Y+Et0qj6DxuZoQUUHjttWKLlrbZdIf6X7wLI1ayuNmTq5Y85g2mK3HtacXTRYSIO
 jHcXCozZ78KU0khphl100k69oKc2HimWBnAQuJOl+W3e0FjGXjhhEbDi1FCFhZTXCQle
 1pJDvpQHRiTGblhDK78JHQZJpdvnm8k++OeEe5TAMUtn40u3l7ckCOL5t9ipNDxHI92M
 TUdw==
X-Gm-Message-State: AOJu0Yy0BlSASHtizaTER5zv5s1PaiBGFXYNn85e/OTThZFqVjrFR1wi
 qclXuNI8kYZgaj7INmDRwZt08mkoTR0hiYXDJo96EvqKQognYeDGJxJwcpPmTSoq7oPmGJMkBZ2
 wM7J91K1p9uhl
X-Gm-Gg: ASbGncvEU3av2nCfN+fs/K0v6GhWD+E0+A/7erdthUSJ8fVhTm9mBTMT2o9zbkf6mua
 b1glLpk90PojFJ4tzpipMgxzmTpr6tgSp2TSnu4PNXeZxc+OHcan9iKWWcxAXqh7OinlSPkFuNw
 Fr09mmmV0QDasad3ypzOEeW6O9VIXUFYosykerfZ8aXwU0AtCWy46IY6w3LUhknuL970Gna8nN3
 BEoglkDiAtWSK52njMvhpZGCzvR7MmUaBK6VhiQ8szUSPDhDLqGGeD4ehEL7DJUDBmt+kCYifnF
 OWwgDjas9vYXotxrKDbymRPCeOnn/5y2vbwEzbapTFlmePwvQx4iFVywtiQEvV3qKZcrrzxzicu
 J0oQ/HLdnYylfyZnuMghTRz15Rulal4c+jzWeYxx/OK0WlOUF7XhKrQKj6PWQqQf7o6vPcNA04A
 kuQl8dtgYO3Anu8un69aGQR3EWqi6ImCFei/5HTZRADGCBki4jTOb4N2s7kA70+B4nMc0xTQ==
X-Google-Smtp-Source: AGHT+IGGchD+wIOw2aXOqsLwke9vqYQ4Lq3oeeRPMPF/DZTBQlrrQs8n9AoCfzHlckli0oZf++JqFg==
X-Received: by 2002:a05:600c:1c1d:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-477307d740cmr104585555e9.5.1762165056739; 
 Mon, 03 Nov 2025 02:17:36 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383b45sm148535425e9.9.2025.11.03.02.17.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:17:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 16/23] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Mon,  3 Nov 2025 11:10:25 +0100
Message-ID: <20251103101034.59039-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h  | 2 ++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 5 +++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 14 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index c8e407a1463..96790b49386 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -106,4 +106,6 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 5922eb02e70..02c5d01670d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,6 +356,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 59a2ef53629..8208d345daa 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -972,6 +972,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     hv_return_t ret;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d0ee00425f0..1b189efb4c7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -370,6 +370,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.51.0


