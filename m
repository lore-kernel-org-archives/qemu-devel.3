Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B58CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoAz-0002YF-NV; Mon, 20 Oct 2025 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAx-0002Xa-I9
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAu-00017h-CC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so39465125e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960138; x=1761564938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJ9NGAEw6N6YXfZFK516do0M00rTnJSh3CYQjYCLSO0=;
 b=BnvC6NstohVNSngMeMMHzhibWYIzZF9Hb0jrVtryBHWDQM3SBp22SbkqamK2TAz6kT
 iT1jGpCapalarld/HZJ51gl2YDnLzZLNavF7H+6W1zr7JHwHkByN0Ts63k5qZnfbGkBl
 eDk83q22JKQbKAaY7+O5R/ox51f6S9cxtO3lcDRiAgqB5ud6yrC+ughIRcuYRqcDUbVK
 DN9f3PIpL1dN90CGIQ/NPXfCwvxU9Mf+lnwuCB+AwskRBxRTk1nSCyTq99ENWP9DbK+V
 63zCyYLPjvYbtzkSDFWGOTWQB0juIDrPih5lkiR8B+3L8KIMDUYTytnu0gBwbcyBLJzh
 uf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960138; x=1761564938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJ9NGAEw6N6YXfZFK516do0M00rTnJSh3CYQjYCLSO0=;
 b=NJyN7vb3qNsIqetGCP/YKF/b9DPSdl6BUoaR0/u3miTy+sUH9jXk+26kH+ejNp5BVV
 zm9ik25bz+8BYu8Xu8L+MZVUZRzHeerC4xvqoUbwd09WvqXo08Hz8vaq9XEWylracLAX
 T6RxxzLMkxKulb7r5fSMd5TIiXBJwVCET0bmfAqEK05bDU0Ul4aG2cEatqdIHDAw9ym/
 WW4gThjvFZZOZzwEddy0B00PgjpRQ7UnPTcrSXIfa6PECAV2nNjKH7br6nv73CleYcSx
 +Kb+gKWf5hPvfJxbdGuiUqaxGyVT5gq7WzG09rGlXXxboUkMtqjz6nwR5pR44lnv2Pmz
 Xz3g==
X-Gm-Message-State: AOJu0YzLZeoID4STI7UpJoFPSmdmBAOwgdPHx/ns3eTBfGzrvASRJmD/
 J9JqeJHRNGiHA+zxrqK4gzqfC3j/RiMsHpvKxtxoD9+4qZmtjZXPJRxhoi57fIliFDWG3sR/Oma
 2g29zqNo=
X-Gm-Gg: ASbGncuHwnBZRlmJFSLIjsRuCfJaME7rDujvDDmisB87ymvdIxNLThFUAi2u/U2RhkR
 xJsM5XBOktNRYp+KQyjUm+XJFWPCc51KgGyuU/K4IGDIUVVbuV9qaCTNClWxq8CycxulS1t9y2N
 GI4NSDH2M9fhoeiIeMqGbqcjMhIaOVFMh7o+lY+b/vMz+bi9pYdH1Nez9HLO9/NsGpZxDeeJEcZ
 7OB676AH6CcLLxU7Q0qwHxMs5Hm8NtgBB7iWlKlXR4Y0asikEagCoDcjbzSNtbb0QrmPBYzAc2K
 vnpx1yQ3eLLs4xYwqSKBVd/9Aw1dlsJK5AQ0agaf0Inqh2UrNgPpHE6571756H1L4NE3tQNvZ7o
 iu9HZ4yNL3QPRXH7pcIIqmKXX55LNUhvO/LAhbrxyeLIv/QJjNauKHgEruCgsiu2d2DMnxcTro+
 6TjdOIXKFLT7S2IvQZXzA7ygzO0tKY8K9fqDyY8SeI73bjmuSvGmF+wndK7OcH
X-Google-Smtp-Source: AGHT+IH9aVP2HDqi6fupN4F23f6aoUioti0VFzylksj46aoAXat7G3nwhgRBvFJu1VfuUwA74SWURg==
X-Received: by 2002:a05:600c:528e:b0:471:7a:7905 with SMTP id
 5b1f17b1804b1-4711791cba1mr121926425e9.34.1760960137640; 
 Mon, 20 Oct 2025 04:35:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c91sm225443755e9.11.2025.10.20.04.35.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 04:35:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/18] hw/ppc/spapr: Remove deprecated pseries-4.2 machine
Date: Mon, 20 Oct 2025 13:35:20 +0200
Message-ID: <20251020113521.81495-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 hw/ppc/spapr.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30ffcbf3d2b..97211bc2ddc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4912,23 +4912,6 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(5, 0);
 
-/*
- * pseries-4.2
- */
-static void spapr_machine_4_2_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_5_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_OFF;
-    smc->rma_limit = 16 * GiB;
-    mc->nvdimm_supported = false;
-}
-
-DEFINE_SPAPR_MACHINE(4, 2);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


