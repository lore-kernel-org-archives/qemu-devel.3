Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249BCCCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTq-0007Jv-86; Sat, 04 Oct 2025 03:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTd-0006rG-QV
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTa-00053T-Oy
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso1835768f8f.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562080; x=1760166880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IFjyMsF3o+69IX/obnVSII+rprVYiElJIAa6+8swTII=;
 b=XSwVsNpQQ1ZMAJswpKJtIiWIZ8gFRU4gcFx0sR13+Ee7mEdOt18SfmWVYAgjKXQLEq
 Iv30VcVf1OKcxbKG3o54pyegc2ZrqRpN5n6qmXN9ZAQKrrMT6Zz5yR9MdxM1eTCyseTS
 1zMn6OkR24lzSk1toIPtIOg4xfxpSOh6iu6268VtOIyeeMeBWjpTafnstSkS9uRcdT6n
 i3QmgF7TBPNiwvtpzw6MgTimaOQytMBP+s2Lz5f4widmVx/k9WI6H5nIg9qoGU87YxWu
 gDd+Qe7ycZ/hnvpbe8UXxnr4dAKr5vxz/d8/zFxRXZ98oJLiME9lQaDipTgCSeqEEYab
 ZW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562080; x=1760166880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFjyMsF3o+69IX/obnVSII+rprVYiElJIAa6+8swTII=;
 b=LCRqTCSYJEv/jVdZW5sHhr4zS81TsVdtj+uH1l921t9y3kFeKrC8cN7vPFi94SoUrA
 n4gT7/Yco/gDmcN/TxHkCXWDTt6s1Me+zOKHpPmqcykgyyo13fWm0Z2Bzb9yq3nj1+Bn
 u9+cZqs1/8iJqPgUR7oF/ipbW/UJXwv4jIuqUEZ/DFMEXn/bupyFS5n+ryMFsFTV56wJ
 84fU/oXw1JHUA3zcb4ZnqB1ADpXJPq6rhy7w7n1YOrGrH6nLYW3x7dZJP6T9NCrwLRBG
 BBocIlWa51xyfv7FOcCHeGJsPFc1xxZqaL4IecrguKwGAtnd+sH4qVdKJ7m8eJbZYIh/
 daKw==
X-Gm-Message-State: AOJu0YwoRoe03KIRcGfBhmRr8ydHUlSl7rcfRxisrEOjoGKaXWIkJ6O9
 nj/TeEP0jNIVfypBXMZz34Zagp3IlRtzcHFrvptvcttpNKP1q9hfr4xyoi8ojcEquHFxBjL73eo
 l52ryszGteg==
X-Gm-Gg: ASbGncu6h4rcvhNcmoCyskP8iP60+lHiU1RRJ3LwcKOgSBkkZmos3D2IMpKEwaSEAFz
 6ue07p4XrK+35tcba4f8oKWi4tTmOR1gB1YZP+zwX9wj9la9ZFrZ0fGA7wVKL/HmdmqfFgS1W1E
 yXmzbPKEFAZkqOEGIcmxWL1uxMtpAPVQKnWpqOY1YJ/jjESQv0033eYzxvldUF9QrQdul75ztWk
 Sj6pCRLafKRTPydlpHwwGm5vAQt1MVLnkfT0NjPd/AkgYZXyMR4oajLr6mlwJqYpUVMs3Fj8mxW
 W6r2KXzJElp+7CEw4SAuK5Mtcss47RSoDAxEbKCGdU5hSrEuW8UD7Mr/eol4aFPq5VIv0HvkPG0
 8La+DW2j7kskjFhGUX3WSBeu4k+gbD3qXor4DSvG+Th3jY7vZWgcc0UHRtPhd0get9x7yl7uxDP
 nsQU7LsskDrRjP8DpH8VUx+NRBU7V9cAhFN/S/gL1ZTQP/ZA==
X-Google-Smtp-Source: AGHT+IEa9n3G7fj+2fJDRbEgMjo3RBiMJzRq2iPdOLbS0AJWwummRCzmNXIpAAMPNqIhGnQCIkHW4A==
X-Received: by 2002:a5d:584c:0:b0:3f5:453:77e3 with SMTP id
 ffacd0b85a97d-4256713a129mr3210407f8f.6.1759562079636; 
 Sat, 04 Oct 2025 00:14:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm11064750f8f.26.2025.10.04.00.14.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] system/physmem: Un-inline
 cpu_physical_memory_read/write()
Date: Sat,  4 Oct 2025 09:12:45 +0200
Message-ID: <20251004071307.37521-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In order to remove cpu_physical_memory_rw() in a pair of commits,
and due to a cyclic dependency between "exec/cpu-common.h" and
"system/memory.h", un-inline cpu_physical_memory_read() and
cpu_physical_memory_write() as a prerequired step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-14-philmd@linaro.org>
---
 include/exec/cpu-common.h | 12 ++----------
 system/physmem.c          | 10 ++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6c7d84aacb4..6e8cb530f6e 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -133,16 +133,8 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
-static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, buf, len, false);
-}
-static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
-}
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index 29ac80af887..d5d320c8070 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3188,6 +3188,16 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
                      buf, len, is_write);
 }
 
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
+{
+    cpu_physical_memory_rw(addr, buf, len, false);
+}
+
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
+{
+    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+}
+
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-- 
2.51.0


