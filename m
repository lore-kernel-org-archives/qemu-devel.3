Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8877C48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUads-0006HS-Fk; Mon, 29 Jan 2024 18:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUada-00060q-Is
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:02 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadQ-0008P5-1Q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:49 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-59a0fb8a802so1709592eaf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569306; x=1707174106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IsJCYKuWrursPA6kPyaSh6Iig/if/7dsXp1H2oDJMs=;
 b=DKQq7lvvL04mHhcWP2tZAhBMd10a3cTJRG9kx+4f2yCSWEBy5h++ZJ8KVCPCzKM/Hw
 HfanTbXsiJDTlCJ/TWtD7c5PfwdyMmiDS8M78Exa9+Tvc6yp29rXDA9m402+JiBY5MkW
 x26ddsW+HI3vNLjdl3ptvz426emQoemm0VMGq+04vpYMK+kyEVNGDT6d7cexVQ69sQZi
 qTpsAMnziISpHwtMPhdoH1s8Hj3ig3iwXilkZ0hFAyw3YT53lwefrGX4h1EUZ4t8ZxI5
 3xR35rCIWevH7b5Whlv+iq+AnO8oMFUKJIZ/aWCDr8G5kmwpmLprbJrOmQlI1WwxnE6v
 vyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569306; x=1707174106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IsJCYKuWrursPA6kPyaSh6Iig/if/7dsXp1H2oDJMs=;
 b=FpLsGvzbpSwpoGbd4YMpss2K35KHKcvEy7IQZc4CRwWdqhB6oiuAUZbTW8qhBR/wh+
 C6OqlwpdQ6gwUntCY129lv/7bYTzm8JFUTzqA9SzwVm677/AIYIWWbMMCWUL5RAIUCu6
 Nf40m5LHgAOviDhhRDmKl3gH8UfKaZXq5BMMA2W/r+d42BSVX5rL1oo7siTKBp94ELbo
 KPhRQRxUSmulRzwIY8L53uikFEm/XXr/4gm14FtZmGCelHpmfN9YbV1i/Bc5y35i5D0B
 R0+w8/rEHk8GY5ywsOpDEDG16GJgakATRdNS8lQgOd35aqiOjIQ39MULCr51XXJ5goaG
 F6sQ==
X-Gm-Message-State: AOJu0YyLeArIT4GGpdX7ex1jv8nh5maPDqW9l7uzz7vXpgywvobZWd86
 GC4FujDlX0jGpsU98t9rnwzekakM6qeKx/fPTDIUgk58Rq/iggInobzFr9WorMha7zERCrCClC3
 GaMY=
X-Google-Smtp-Source: AGHT+IHIPKf9PzEMlhSDLryiovNY3w5s4jjNWpPoBC0npz4kFb7fhMwRlORNMpUcizD7qMaStlBu7g==
X-Received: by 2002:a05:6358:4425:b0:176:81c5:f377 with SMTP id
 z37-20020a056358442500b0017681c5f377mr6922383rwc.36.1706569305919; 
 Mon, 29 Jan 2024 15:01:45 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 09/31] include/hw/core: Move do_interrupt in TCGCPUOps
Date: Tue, 30 Jan 2024 09:00:59 +1000
Message-Id: <20240129230121.8091-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

The ifdef out of which it is moved is not quite right: do_interrupt is
only needed for system mode.  Move it to the top of a different ifdef
block, which preserves its position within the structure for that case.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-18-anjo@rev.ng>
[rth: Split from a larger patch and simplified.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 479713a36e..d6fe55d471 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -58,11 +58,6 @@ struct TCGCPUOps {
      * cpu execution loop (hack for x86 user mode).
      */
     void (*fake_user_interrupt)(CPUState *cpu);
-#else
-    /**
-     * @do_interrupt: Callback for interrupt handling.
-     */
-    void (*do_interrupt)(CPUState *cpu);
 #endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
 #ifdef CONFIG_USER_ONLY
     /**
@@ -114,6 +109,8 @@ struct TCGCPUOps {
     void (*record_sigbus)(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra);
 #else
+    /** @do_interrupt: Callback for interrupt handling.  */
+    void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /**
-- 
2.34.1


