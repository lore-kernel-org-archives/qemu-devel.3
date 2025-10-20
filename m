Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92CCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnIE-0000o0-D8; Mon, 20 Oct 2025 06:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHq-0000fc-CR
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHo-0000FL-9X
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so23118405e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956722; x=1761561522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QqASWvK1t899Gg+yC/9t/MGzsv3GeI3HMvGU+Y6Meg=;
 b=Zm8d6DkT86o3ebTFlGokFemniQU2KSQF5cMHFYmemrVHOf26bk5ca6z7O7GtWaxvA4
 c87AWFYUfZE6/eVXEP2XIo+SsTbfydtPi8GPF3aWs2wv1ZhOJZEYO3wPrzx7HVOc9oi2
 Z9zTAOaMwawnzdFGNmLic196CCrh5bw1J6DChDzZ/MdJTrvrcrkpl2HAm3g06SBvfsJ4
 8m7EVfrMGYwvdJ+DnOLenxj25i5ytWHnGG7Kn91OowGiBHIQEM7kUnlIjf3l5xA1VLKt
 yW3NBBeyK7GH8t/qB237QJCMRCFLB5n8sSK5Y0ei+MtLhbKqN8Wsw7zrF/5Av13Nq6t3
 mnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956722; x=1761561522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QqASWvK1t899Gg+yC/9t/MGzsv3GeI3HMvGU+Y6Meg=;
 b=W6SFKk7zurXsEupI8cit2mNxUL7Rs+ZTuPn+EmM1xjkY6lgEqNJEvP9rZsdoPDIDm0
 2/S6tEtzutc/UI1uzt8LprNCLRb0mX5Ro/4DWpp9hljUDoUpQQgKfimgBcYO+ZpkfCGy
 BVW7ewiG0iVYG0B2s/qfZwyJOjkYsZnAg4NwN+TE/yGucEH3GTK+Ql/K8yXrINNJbvrE
 I9cYDVQvrJnAOKYxJEWgEqvnfwJvdvbXbkymkKekmM/MWjphLJul5seBKcm8SrcHoAZZ
 ZiBy8LD73JRg1fXe2lCIOsaj8z2RwPF4XfeGH4hITKuLfEQTuGJLheMrhhyTDz8vcONy
 BQMw==
X-Gm-Message-State: AOJu0YzJmectBdp999hSZ96aRcvUQFCHVS+FrQOMrM4hxEE7URbjXDgh
 aq+WYgn15hJ7AK6IJuMknJdDhD4gk5DykcPzMPnZHKbv53hycIZxVRbW5qtYuAoiTGpmARI6EgE
 95OK583A=
X-Gm-Gg: ASbGncuw8UP2acNVmE7GvHe2wOi09m0O2lQ/38cCQLyMExxjvLpd4/dJ3BF4uU08qhC
 Jhf5D+fzwvWZbghVeo1tCaarRmzIEMvJjClapXBBE9FDnKAeccxjxWAQ2luBqHZHjtuzZ12XFl7
 c4M0JyQKuzVuXQOwMU384MUe/vEN7vTXQiy2htgniQ8e+uGf1XQZJ1fY6QlvQA3lUYDHB2qzrqD
 mfN4uHCnzskT2wmioHOQZQEWDFpoUXAqbqwu2fbUYEGS9qd7Vd9IYW01A5kUKYTY4Idkjmqc+4H
 IXStmTdqQvfpBamlA999fahBboZiEDRXS3b0wHmhJZQL1bBtv6JH62FAz5LflcznmqZPpOd9Pwm
 cCUumocDMceRZSnnDlQQfgHn3D3cqCCtuEDI5uTr5KxEnVwpfyk5PoEgQ4NCi6JZxgddrDW6tu7
 Nxo7weFNREC6CwG7qUbZSo68NgSFXkDnXDOBbfIXZbEer0UhAJiIJFfOkj7xSG
X-Google-Smtp-Source: AGHT+IG+2OrotMm39mO/NMpFJE/4JTcqijQrOf5TAI7bKDmv2wXdxouIqwoMumQUqKhnsP0tNIQR8g==
X-Received: by 2002:a05:600c:3513:b0:471:1415:b545 with SMTP id
 5b1f17b1804b1-4711786d625mr98567695e9.7.1760956722179; 
 Mon, 20 Oct 2025 03:38:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca4931csm117818495e9.0.2025.10.20.03.38.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/18] hw/ppc/spapr: Remove deprecated pseries-3.1 machine
Date: Mon, 20 Oct 2025 12:38:01 +0200
Message-ID: <20251020103815.78415-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b5d20bc1756..2e07c5604aa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5032,28 +5032,6 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 0);
 
-/*
- * pseries-3.1
- */
-static void spapr_machine_3_1_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_4_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
-    smc->update_dt_enabled = false;
-    smc->dr_phb_enabled = false;
-    smc->broken_host_serial_model = true;
-    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
-}
-
-DEFINE_SPAPR_MACHINE(3, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


