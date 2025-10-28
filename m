Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A46CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDciz-0007kv-Dz; Tue, 28 Oct 2025 01:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDciw-0007kB-C1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:58:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDciu-0005Ag-K0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:58:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-474975af41dso37754835e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631101; x=1762235901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQes5LeOA8vkPfaUoODaZwI5RRRB72LYmxLKv5qcwg8=;
 b=mRky6laQi+8EPLKrgCspLQf9bJcaCucSVTaHQXgn5s/2e1GPVjHE9hOTnBpWPXnQF3
 5z5RkOj35sFdkTSVdmqteM1xHC1Oe67j4ykvEDFmOXXr244Ezx/y3vgUhu2G2QrV/0ZX
 c+/QWLqFvsDt+rURSzCbruRv1tzEKtBFrhr+a8kd+rDrCjGTTSilp7NCTzrild/hlG0B
 Z0Q43EmCeA+p1oy9XRxOsegflDrdKm6AQCkUY3F2TjGY/52D+bY8ilD60QcG3kB0SkSh
 JHm/zREmGQdbfJT1H8b2wmCRlVR7NA2mbf49BnIEEt/wo95Wilh9Pr9Y1S+huBPLht1S
 5j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631101; x=1762235901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQes5LeOA8vkPfaUoODaZwI5RRRB72LYmxLKv5qcwg8=;
 b=URaOGtJ6xrSn7WMWvOvmTy8XpPpMTWZTpeRLSGh2MFL/D2WLi82rzNCB0jIgXxct16
 R373MCE4PeU+JgFBvrmUaKYV3cvrzTUGETdfAlau1IiplRriyjKHb6jgWnVD+V8ICtVC
 SqKlO58PzfeXBKX2tZC10HKDFw3kLmb+Gz+LYg3+bGXsqgbXnGDDWAga1oAjFz00BXLi
 vhJFWEULkspKVb9nWqx66RQpqXoCDSPAHz3p8pldTlv05/Yix9lxfps409xa6rR7fLrQ
 8cpTco19nIxrLdrkR9cjFoY0Tq2jgg7+XIpeKJ1Fxmcia/LE+Vaz+fJfRbovwCm/jnDm
 3Smw==
X-Gm-Message-State: AOJu0Yzf7oKwMzVvyni6NnDX5n3eL31gAAOLK2pcEp2jOxWQ7qyjVUqP
 Fc41x64K7oaxZR4IGYDsbLCUYndaV4nofnAMulXmzuWKj7V/HQ6sS5bdz/+UI3Qu8nNBaCSq6yv
 VewjdxMM=
X-Gm-Gg: ASbGncvWLkt6ThEos08RznJr5OnYf5aWf3ym7rPP/ZZX93VRsjwiNQZCjMGnmNtFEL/
 ezriPPJsOgqsCbckK7Xgk2y9qrHgpDDHzBqMcliPWypU+H56jS8bm9V20hi10YYjiiBoOBdNYcm
 o74H4Mcd5XVCmfppPqb4foYBrTOuaFe/WR5mR8SXe6Wdyncn+7P/RONRO8s+SPCc4SNVodAl+h+
 aldOExlUfECPEjadtgtcDkYUxe7M/SUHasf8nWliXUsrMy8OwKozkwixAuK4fKMDWRHcPt9dmej
 memvU7TETQT1EvkHUbmScuDLZK0wnFXRUdJwSpCbc/kegdgB8V+39RctyOIGCozoE7aOrjomZtB
 WkvLvUf7Glb8wApdXYxPOtkH/1YvlQMrjnkcbQ8MJSGoGoIBYJaAdu0tcoCBpxhlDbBOXZDqDwd
 sFryBB97e7cMCLpfAv8ogs0tAHIzrr9Rq1OKmsyyfAP2eBEhIxi3476gE=
X-Google-Smtp-Source: AGHT+IFp8VT48Ql+53i4mrWS48pgyMYG3Z/P3ai2L3tGtyhJlFPRkbyVaAlOMAuIUrBwr1iAYW9TXg==
X-Received: by 2002:a05:600c:8209:b0:46e:326e:4501 with SMTP id
 5b1f17b1804b1-47717dfe812mr15272855e9.10.1761631101359; 
 Mon, 27 Oct 2025 22:58:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771906af34sm10491105e9.14.2025.10.27.22.58.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:58:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 22/59] accel/hvf: Guard hv_vcpu_run() between
 cpu_exec_start/end() calls
Date: Tue, 28 Oct 2025 06:41:58 +0100
Message-ID: <20251028054238.14949-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Similarly to 1d78a3c3ab8 for KVM, wrap hv_vcpu_run() with
cpu_exec_start/end(), so that the accelerator can perform
pending operations while all vCPUs are quiescent. See also
explanation in commit c265e976f46 ("cpus-common: lock-free
fast path for cpu_exec_start/end").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 ++
 target/i386/hvf/hvf.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 79861dcacf9..c882f4c89cf 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2026,7 +2026,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
 
         bql_unlock();
+        cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
+        cpu_exec_end(cpu);
         bql_lock();
         switch (r) {
         case HV_SUCCESS:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 28d98659ec2..16febbac48f 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -992,9 +992,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        cpu_exec_start(cpu);
+
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
+        cpu_exec_end(cpu);
+
         ret = hvf_handle_vmexit(cpu);
     } while (ret == 0);
 
-- 
2.51.0


