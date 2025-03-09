Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67490C35FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKrj-0001i5-DK; Sun, 09 Mar 2025 13:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrI-0000gI-PW
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrG-00055t-VL
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso1652323f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542877; x=1742147677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CGXaL8bhbJQMTQdj5Pf8aW1qHhXb7o/C2DGt766w624=;
 b=jEp0PQNjcOj9qQ9rdqRZmHYpQJ8FXCOSGxnrNeY/s4D0wdfDlUfIWUzAxHAQLgJjOX
 1m1vXVibGFET/XIgGfqcbY+9AnEypc/5Tdbld0lRkaKVXHxAr7Ud4h25vQCAAALD4xZu
 Bpa1ymKtaLXsSNExN7K5fp+IQU4GPrl7cHNf5CdKhbpar20NOThBPrsRcU2iyIBLpD9J
 UDv06W9tdnKfSBHyP6LLq2knLXRyUqzw/Qfc2czufWbDh5hb9jz+6PWbanW7u8vmSxNn
 d5rpJ3X4PI5x3Ijr98lsw9RoVjVNt+xxVRbr9Xt3EHgEU5raQ33v+ZuJVfKWgcJcJZ8f
 Eteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542877; x=1742147677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGXaL8bhbJQMTQdj5Pf8aW1qHhXb7o/C2DGt766w624=;
 b=GN1ZvyfhpJfXMZKDoIE5jAvKDSp5W0ABIGG+Gsi6UJZ4T3XM/UbnVZ4ErqUKzWB0BX
 ck9Ws6T4YW4XOdsSE3uKPJmq19HiZ+5wT92sm4fqv2RiswPhxcxFc7++RnbmaT0JqLrq
 UHknO2HmlF0qZAXqSqsWzP9Q67cAQfNBDhZB226K4uoVzz0YemqfscxFPqzkUoVte9m1
 OSKwMMOnZgwVwq7L5z6AW8QbfhajeupveDoIAoPspDuNLVHiHRAGyr9EPzNnpWlLd4vG
 NA2f+s4dpSlarVKikSsS9U/7jgu4R+Qk1XWDPnfCk8ucDfvqiYOAB+xR7PALLy8vgxjd
 mhDQ==
X-Gm-Message-State: AOJu0YxwFopyqh7qlZO7YGofqEf5exw95deqyXPiEW6JCtMQSOvcPVZH
 LRUPiIP8VlogaFTd8b7Z1+EI9WQETz2OOh74i8vN0ZuuYg/Q2Dato20KjQ4oyr2+AaiUzWptHfh
 gMDU=
X-Gm-Gg: ASbGncvoPQBE+JR1xap/ECT5samx6ktGZncTaGdLDuS5eFCgr7rUUEXfnHfNZTqb0p3
 UgrqljvBXRlG58nHaMDMIkFxhgPmFG5eA819GBYtKWoAyKC6YIoAPmoG0RL3BFUj7WlDK7IUnhe
 2rJDALLBVyACPONf7QfWCCo2o+a7fd5Mc7kGc+7dAaXwuI9nMSukoZWPD7CzrGOdDIZIOFbjxUj
 19WGzsy4aL/MRF1GrjDP8KWS4YEl0/Ged/wlcqv8tDcS72efGP12xAO279mJMAPjZtXawher0uD
 3hJ+/FZFcf317ek/SUlzHAQlVQNrJrODiOVkt/p6nyLL32zLXxq3STtSGiXZt77xmmLUQujjmZP
 K91hAmj3RQHzWxdeyq8s1O/mCBYNGHQ==
X-Google-Smtp-Source: AGHT+IEM0gvxMdn/qxT/newV+JdwB5XTKf2HdGUgYcc4nahMLhKh+Z0oCsQeuFcNuNRIvCQfbgle+w==
X-Received: by 2002:a5d:59af:0:b0:390:de66:cc0c with SMTP id
 ffacd0b85a97d-39132de1bbcmr7048339f8f.46.1741542876772; 
 Sun, 09 Mar 2025 10:54:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfb16sm12347309f8f.29.2025.03.09.10.54.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/38] target/s390x: Restrict I/O handler installers to system
 emulation
Date: Sun,  9 Mar 2025 18:52:00 +0100
Message-ID: <20250309175207.43828-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-19-philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a750e7a343a..6e2c98de97a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -356,6 +356,7 @@ void cpu_inject_stop(S390CPU *cpu);
 
 
 /* ioinst.c */
+#ifndef CONFIG_USER_ONLY
 void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
@@ -373,6 +374,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
 void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* mem_helper.c */
-- 
2.47.1


