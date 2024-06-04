Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B5AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvE-0008IN-Ti; Tue, 04 Jun 2024 05:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvB-00088O-GA
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQv9-00029I-HA
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so29701175e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495053; x=1718099853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obtEpkiAsJdiWpm7zcpgW5liQ303qrBraj3NKulpnrg=;
 b=GFdAoyoylMNQ+DPpBG7JKcNmY3lHNdn28Djst9t6qFiZvtlDq31TMKz84dv9aFqDq6
 EkTHHe7N0V5xddDaXzbgGhi0tyAwuQZ8gYBpyRv8WainUeecqXVHjVF6Vn3HUP9qLYdn
 MsiIzhNs4Ne7LU5ELTKVD1Hu0Ku0zA6frSEnheHXUpbFLecd/EqUrUJLrmZkqdsljJ5l
 YMgZSEYiQqhWFYyvWXCeGvT9qatJR99xiILgtFai8tmdHPMVFb+Gh1Zt7K7zNTrYWXEq
 3paZgbVMp5Ue7O6VnUo7SCAC7CKbcGQMAn1jmjOr2k/vuMflCSgOif4oCqNSbtBUPA5Q
 zXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495053; x=1718099853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obtEpkiAsJdiWpm7zcpgW5liQ303qrBraj3NKulpnrg=;
 b=du6/2Yjre1hPNqDpiTPTjmAMHObpxj5wERncHAll42XxdCAPcAXePjTJqAgRRbgMo5
 ICQqc4NZg1fXx5Q/dSqoui276GzNYx31ABdqX+PV3Ae50t2ONSt+wkhmyrGTuNolFuwj
 bmTS+90FbOGgRGev4Gni/YGQFoJETqaGrI9AVy5lxxSf0a7tWlqMOSfbgvnrby1uQs7R
 hd0PII4EW1241qdlMlSPTw1fAtqGc0GWr7h0+uaNIVbIS88Lvy419+eQG38FyL6+P0pk
 6EjvGmHybxaf7g9j5yohqJ1r2Q9jIh6jziIox9BiISxp8qbfAygvQ6dmx1aCcTqHiFB3
 byeQ==
X-Gm-Message-State: AOJu0YzcuosbtAe1CuyZ14j/NXJahjS2aAL0R/ekqhPg+J9IvDarmBBP
 WZP7JR4Z1Ee/7GObJQUAf6YjUNAXX8ysIWyHfFjcOmZC+Q1hQdwq+ZyEPZANn0Gmc242+BnQnW7
 +
X-Google-Smtp-Source: AGHT+IEktRku/zcyjNjox8mle+MVL2eSRUmZfkMxGn7inNrwYrFDVMmbgJ88UHcLC5Jj+skWlhrSOA==
X-Received: by 2002:a05:600c:4e8b:b0:421:3a41:5428 with SMTP id
 5b1f17b1804b1-4213a4157bcmr44589875e9.41.1717495053637; 
 Tue, 04 Jun 2024 02:57:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215447035bsm7234385e9.13.2024.06.04.02.57.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/32] hw/core: expand on the alignment of CPUState
Date: Tue,  4 Jun 2024 11:55:51 +0200
Message-ID: <20240604095609.12285-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Make the relationship between CPUState, ArchCPU and cpu_env a bit
clearer in the kdoc comments.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240530194250.1801701-2-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bb398e8237..be44746d24 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -391,7 +391,8 @@ struct qemu_work_item;
 #define CPU_UNSET_NUMA_NODE_ID -1
 
 /**
- * CPUState:
+ * struct CPUState - common state of one CPU core or thread.
+ *
  * @cpu_index: CPU index (informative).
  * @cluster_index: Identifies which cluster this CPU is in.
  *   For boards which don't define clusters or for "loose" CPUs not assigned
@@ -439,10 +440,15 @@ struct qemu_work_item;
  * @kvm_fetch_index: Keeps the index that we last fetched from the per-vCPU
  *    dirty ring structure.
  *
- * State of one CPU core or thread.
+ * @neg_align: The CPUState is the common part of a concrete ArchCPU
+ * which is allocated when an individual CPU instance is created. As
+ * such care is taken is ensure there is no gap between between
+ * CPUState and CPUArchState within ArchCPU.
  *
- * Align, in order to match possible alignment required by CPUArchState,
- * and eliminate a hole between CPUState and CPUArchState within ArchCPU.
+ * @neg: The architectural register state ("cpu_env") immediately follows
+ * CPUState in ArchCPU and is passed to TCG code. The @neg structure holds
+ * some common TCG CPU variables which are accessed with a negative offset
+ * from cpu_env.
  */
 struct CPUState {
     /*< private >*/
-- 
2.41.0


