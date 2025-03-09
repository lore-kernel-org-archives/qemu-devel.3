Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C391C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKq4-00063Z-4T; Sun, 09 Mar 2025 13:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpy-0005gU-6U
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpw-0004u8-AP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2906597f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542794; x=1742147594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DCutmRo13MukVGEmkojmLCPMgyHiIA14FLLQ41OISws=;
 b=Ms92iJ66Al/1ZRkWxxn4O56946IRk65T4m+hDaVStrhe7nUY9kZriwl7PaZYV9z5/u
 0w9+hA5rIhRxSbEKJb3aU0vhNdj+MmFrnz1Ytqb+FMTW4B5FMMTiIYFGM0pw5Egjpd0v
 z4BPB18cPzHw7BwnZylxrxv/YotbGv/2gQ4ykiS/Qlg/gTsaackrS6zVm/w1O3HkRpPq
 7RRwKkI38duLhhDndVx+ApBNiNy0dTmccnlUPlemup3n5Q6IrfKm6iPZHPPfoA5EQJAJ
 S8YptQp9+kEQp1OsZq0CwE0X+gkI1IHJn+Tnv9ge7Razh9gLioioC4OXkZSNtmEbW72R
 Cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542794; x=1742147594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCutmRo13MukVGEmkojmLCPMgyHiIA14FLLQ41OISws=;
 b=S+w+waaXDOduIZ/y5kHO5aV2tQRyFynqXc2rO49d028IZI7zX11N1SIMaxDD/bmlzf
 lmsuddqao2zgea8jMHZnh/jf23OFnmt9WM1nJ+o6NAaOIjYDh0lQ5of0vfqcl/sxvFdA
 uDMfpi7ZNNCml1EPMS+sDr6GMQHniajMVLuY3z3L8ZicvpFexEhVSdA8T6IjPt0QePID
 +N6MvlJEqxnd7/L82IJQKUCoAc4a0nSruq3plryjArIF4Cw/KM0CpeE54Ok5BhxT6FOr
 wVWrl6It3CST6cytS3Jhnlu0FCw5P8Hb0XOhVpOxIUlvpYM6kh4Egco8HOZrMUWl65H3
 7MwA==
X-Gm-Message-State: AOJu0Yxmv63JiWYmhX25K++4jkNKel667lznvL3EumpGkuaHpVVXMGnY
 B5fo0n+qu7ZMMENashzVYMqgAheEIl+sx+ErzTkm67nPltsybCrP+1udlSkm35Ydf+hlHqXYK/+
 0GXA=
X-Gm-Gg: ASbGncs8gWesUpfzeB9y4zu6XrV4/5Arjc87hO636cOX5teo9JX4eUeg13RxHaZ/LTG
 E5z0dzGNBwwaMDVH3MjxG04VPoo0bpf9z3mXkmw9bLYTBOboOk8e8IGPHN+VcqUWFHre54bRT/2
 SuWeiPdQjk9eCWmnUrFXoUOvB/nNi7kfJk+6uU5zyxXqcdsNFFBi77QCn9FNs1S/Evu735Kb+4G
 cAMvU14uxrwBca+S30GSIQSgKZjw8ew7oHJwnFNDq/kae8uj9ZZ7PnfylJPs7dPsjFB5ad2cAOv
 pbIWc6PLyIgiyGn5LVnmXY1Edd45358WjtRMGzxrYvtnLhv6rx+4fgIhxry03+mZRUGt0lh/1Fu
 0MeS+qpjcpXr5WI19XpQ=
X-Google-Smtp-Source: AGHT+IF41uE3v/xRZa8jkExlY8WbcswHVyTRORFvqFbKLGbqfnGw19QWOTyYIKTBb2ZaZ5QYsHlCIw==
X-Received: by 2002:a05:6000:1862:b0:390:fe4b:70b9 with SMTP id
 ffacd0b85a97d-39132d6c5demr8882301f8f.21.1741542794548; 
 Sun, 09 Mar 2025 10:53:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm12511218f8f.65.2025.03.09.10.53.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/38] cpus: Restrict cpu_has_work() to system emulation
Date: Sun,  9 Mar 2025 18:51:43 +0100
Message-ID: <20250309175207.43828-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

This method is not used on user emulation, because there
is always work to do there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-2-philmd@linaro.org>
---
 include/hw/core/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c6df426c947..2d4ebb79905 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -750,6 +750,20 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
+/**
+ * cpu_has_work:
+ * @cpu: The vCPU to check.
+ *
+ * Checks whether the CPU has work to do.
+ *
+ * Returns: %true if the CPU has work, %false otherwise.
+ */
+static inline bool cpu_has_work(CPUState *cpu)
+{
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
+}
+
 #endif /* CONFIG_USER_ONLY */
 
 /**
@@ -816,20 +830,6 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_option(const char *cpu_option);
 
-/**
- * cpu_has_work:
- * @cpu: The vCPU to check.
- *
- * Checks whether the CPU has work to do.
- *
- * Returns: %true if the CPU has work, %false otherwise.
- */
-static inline bool cpu_has_work(CPUState *cpu)
-{
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
-}
-
 /**
  * qemu_cpu_is_self:
  * @cpu: The vCPU to check against.
-- 
2.47.1


