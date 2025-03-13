Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C484CC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWv-0005Hr-9m; Wed, 12 Mar 2025 23:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWN-0004ia-DG
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW9-0007pj-0V
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22438c356c8so9205865ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837551; x=1742442351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0yH4U6h2oXBq+kGt0lALY89FbRQ4QUGXJxA7WeVWJA=;
 b=qYbiNJ79rPb9EPEi9iSMArjdoGO67LwV5NVCJkFiPzm+COj/kvBOIE/jWmAdyQvR8S
 c3woiO41GLGjq8O/qPd20dxt1hkvGyN9KPRBrfqB55SksjaAevbVVUfYGmRmFBW7P6kr
 CatNaLPxOE7vxAwsu+lpnko1EbK8EIsoC3DvbwCVodon7/zIjHuJeRZWvedP3wPFZMmZ
 DBwxpr0PRg8VKTFaj4FDwc+HhU7D8HHoQESLhhbk6zSg2loP63uOTlEVNECVAJWSv5y/
 ulA8GO0/+o2+5tWcnUBncRzAitOgz79DoR34QMmD2TPPwDdRomXVBDl8ig38QhjDdS2Y
 1CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837551; x=1742442351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0yH4U6h2oXBq+kGt0lALY89FbRQ4QUGXJxA7WeVWJA=;
 b=rm92ydKCw+ccab8EPwg5uYd0SasN0w5XiaHQy+YSo0Mguxoe/fJYtH4ase/GbQqXWh
 T6Lhs/kEv0qwme36aAatoFN0xKkMmxhW6DlnE125MwDdZ4MBMNes4jAH3hl8yng3svce
 49i+Je+96uKi/lKkHOCY10mDEfujGm2NdXQcAQYVScW9ezG2bV5O/uoGCINhzuegxtZ0
 R08Kyeo/+FXyy762K3HhAou2Ir46vBRR713Vn4xMfEfaH/e8GjIm9ndd4bA/6o6zGODj
 zIx5fQZfedVvvjyYHwA+gu261aSMtf9ZvQmnmAlI9xWFClvw1XJdknrWAM6jGCyPcMTT
 oUcQ==
X-Gm-Message-State: AOJu0Yyqqt00LJenWEcTb4G70e1IEQ4z2hW8J/OtoSK4nWo+xEOnz8fy
 WVpEFlYZjk/C0CT2xloAFoWhhqYGS/DPIknw0rpMNPvqNkky6R6IkqSfXdrrp4m7he6n3EVsCee
 N
X-Gm-Gg: ASbGncvixp0UDiozTdGk6bJl7ocn1wrZKFPHiWqh6nZDEDWXqUk29Fdlqk/86xQ3j63
 Fot63/UL/SmS56zj5Jk/nLyOynhnR34lmyX1xEPSNjQnvACUtTsOp2UqBDqZvSPOmcAoTagBd1+
 GCzPPHhG37A9mQvB8GaA7BGrZc88uhzWJwfkRJdX2Jx2uhJMOckM+p7I3qujxnUOOKZudv060pF
 z4cjc9KgUVJ8CUzd9hyhjcp8TeKL20y7c6YgC1/ZHhq3nsvJGvNbKC8u84BvMnKa6DsEAFBzC/P
 /6uIiAfgElNZnopa5RblWinfdn+A/AFNSS83QsifuJkffjeqaDOvK18oZpyMjjSwKwus2qmjRqX
 d
X-Google-Smtp-Source: AGHT+IF790jE+Vd/coklpPUQ2vL2HDzDMyV7reDn5GSnY5cyo0ityyRPs8mwzquMCjvhIMa8FuMw6Q==
X-Received: by 2002:a05:6a21:648f:b0:1f5:70af:a32a with SMTP id
 adf61e73a8af0-1f570afa5a2mr29301983637.32.1741837551518; 
 Wed, 12 Mar 2025 20:45:51 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 31/37] include/hw/core: Drop ifndef CONFIG_USER_ONLY from cpu.h
Date: Wed, 12 Mar 2025 20:45:11 -0700
Message-ID: <20250313034524.3069690-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2fdb115b19..59394212fa 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -614,8 +614,6 @@ extern bool mttcg_enabled;
  */
 bool cpu_paging_enabled(const CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-
 /**
  * cpu_get_memory_mapping:
  * @cpu: The CPU whose memory mappings are to be obtained.
@@ -676,8 +674,6 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
 
-#endif /* !CONFIG_USER_ONLY */
-
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -701,7 +697,6 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-#ifndef CONFIG_USER_ONLY
 /**
  * cpu_get_phys_page_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
@@ -758,8 +753,6 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
  */
 bool cpu_has_work(CPUState *cpu);
 
-#endif /* CONFIG_USER_ONLY */
-
 /**
  * cpu_list_add:
  * @cpu: The CPU to be added to the list of CPUs.
@@ -1143,8 +1136,6 @@ const char *target_name(void);
 
 #ifdef COMPILING_PER_TARGET
 
-#ifndef CONFIG_USER_ONLY
-
 extern const VMStateDescription vmstate_cpu_common;
 
 #define VMSTATE_CPU() {                                                     \
@@ -1154,7 +1145,6 @@ extern const VMStateDescription vmstate_cpu_common;
     .flags = VMS_STRUCT,                                                    \
     .offset = 0,                                                            \
 }
-#endif /* !CONFIG_USER_ONLY */
 
 #endif /* COMPILING_PER_TARGET */
 
-- 
2.43.0


