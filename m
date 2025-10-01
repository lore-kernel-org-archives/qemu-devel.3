Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6ECCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ySV-0004RS-5N; Wed, 01 Oct 2025 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ySN-0004In-EO
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQP-0000rr-4Z
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so57401705e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331239; x=1759936039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C42/g+0ka3x6Y+pYcvJ/oLioyVbWee9ufrhd822gyA=;
 b=lxOxu10nX/5NAUsftF1fEfaP596+wwcyHADtf2Bg6g70woIu2/5ELd2Be9fQkDENes
 /kiaYkNmbx8iMp4zFg+42u4qvoYnV8/1PuRvwJ94K+KSe0vHdm041NhkRTaZaMbvHoxv
 YOcs9VgucT846875wVZItRioxuU64De9lhOWB/M4yC1eFcsJLL930rnMYb6h8BFnYMBT
 Wt177Q0ctn7+dI8HUv1JwniO+gmEd33gn3vQmPqD2+VAbpb3/gXpVDQlUByDXLjH1E3r
 GcEWzQ+mYQL40fV2j4xH+4LP/GtNzsgWxBze4Mm+vNtpIUh5/817RNTLGu5PF+q0cGXw
 /15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331239; x=1759936039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/C42/g+0ka3x6Y+pYcvJ/oLioyVbWee9ufrhd822gyA=;
 b=whn3OwOErKczSqoxfJgb6nX5A685hvrTcc1b4DWgCXcLfgaWpVID7eUVnPyzE+2K8a
 LpIxk6Z9pJnybKdI0DtTApt/6jyhsukgm3+Xt0t97LheuSXZTxuyMBtPgYkhE9XkIg+W
 KQcNGMyzR3UdTWtFWgVbCI7WxGDg8ns0Yw87qDokpjv41Wo4S9fvGAwzARei3yYKYKmR
 siO5JY0SQpna6X2f5jHMVBdetALfjSb2j4TRaHXxmUM7N3YEhbZmhmTh4J5La2e9FLss
 mMA+q7e2ILdFoUOVDumL+G2Yyp8h8ih4958pKvT3UKoSJ4Lf9Gie3l0x9T732w23TxrH
 Oohg==
X-Gm-Message-State: AOJu0YyngMsM5lAYL8r+Uqf00hHrEjoy2+0SBbnDkGHqlCudeAz9/4Wj
 GnDv1XoZcXC0ml9K/1bY8GIlfJWzsTAe5a2rMPjVq1L/Fv9WlZAqxDNsnZ7XmSqaberroW6Df1L
 6HoTZ81G3KA==
X-Gm-Gg: ASbGncvm/aFsVyx8cfMaKAWHaK1qG0q61Z42ejMOh7LymSSEvph0VO7Fk3cZknFCw/E
 3h3lmvHp89FD3LY1UapDmbPdxT3uklLs78K2mNGUg4tCZryqX7WAhFjkPbU6xNoR5kEkWUg1nzU
 /2QN+T/oPM0S6EOgEbwk45+mbY9LX/gxqm0CmoCMXsxLMdPJbEVz0phJtXHY2/ivEp5iHXVuVZY
 VCgGbOLDiTLt9jMoF0227XwtD0ZYqxTW/uE/goLPeJKxdbPpDvHBjolHFrCR38M6B7Mp4MLBXY6
 /t9S3ppr1k/552oPGYkl3qhgf0nO8M4EOXY3HKRCzKQrX61BjiYReTMfCxT3E6BRUjGVJFeWjlv
 R9LuwDP9IbFzS6H1+eaULiUGEV75jI69COIdUus08EI4v+oJAMmL7NTpDOLIiNfg8JRNsGCjaKb
 DcmmnmWp8Zikrxey4ecoj8WeH0jylvRPg=
X-Google-Smtp-Source: AGHT+IF/75mknZcUFVld4k25ibBW5an9rIxlCHvWPhGUKdqmIQ2eXg+Qp+sCollNQ71J/V4FjW/XTw==
X-Received: by 2002:a05:600c:3b27:b0:46e:4784:cdf5 with SMTP id
 5b1f17b1804b1-46e61219f94mr32963235e9.15.1759331238590; 
 Wed, 01 Oct 2025 08:07:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e675b557fsm17554035e9.0.2025.10.01.08.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:07:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 21/22] exec/cpu: Declare cpu_memory_rw_debug() in
 'hw/core/cpu.h' and document
Date: Wed,  1 Oct 2025 17:05:26 +0200
Message-ID: <20251001150529.14122-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

cpu_memory_rw_debug() dispatches to CPUClass::memory_rw_debug(),
move its declaration closer to the CPU API. Document.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h |  4 ----
 include/hw/core/cpu.h     | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 910e1c2afb9..ce64a999035 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -150,10 +150,6 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 
-/* Returns: 0 on success, -1 on error */
-int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                        void *ptr, size_t len, bool is_write);
-
 /* vl.c */
 void list_cpus(void);
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 0f7eda1a10d..1e928f57c99 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -685,6 +685,26 @@ int cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque);
 
+/**
+ * cpu_memory_rw_debug:
+ * @cpu: The CPU whose memory is to be accessed
+ * @addr: guest virtual address
+ * @ptr: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @is_write: indicates the transfer direction
+ *
+ * Take a virtual address, convert it to a physical address via
+ * an MMU lookup using the current settings of the specified CPU,
+ * and then perform the access (using address_space_rw() for
+ * reads or address_space_write_rom() for writes).
+ *
+ * This function is intended for use by the GDB stub and similar code.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
+                        void *ptr, size_t len, bool is_write);
+
 /**
  * cpu_get_crash_info:
  * @cpu: The CPU to get crash information for
-- 
2.51.0


