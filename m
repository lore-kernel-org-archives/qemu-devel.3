Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E83CA0FFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk34x-00051J-MU; Fri, 30 Aug 2024 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34w-0004va-2S
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34t-0004aS-0i
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso21542675e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029897; x=1725634697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWQjPb3i634Zotb7v4ULsj+3Isgg5EVUzD8LzfKdeFM=;
 b=lGjxQNAEW+L52VbTAe/vAJ+xjSvHlaTBsKB8ZNAK4NsoGOwhkbLHsMIAjUfpUGjWs2
 e5MrL//iuQevDYCNEGEESzt9vvImf+s1+9aXLBf9mlHF+hdPioR22qQrxUsVzxVcmnoQ
 M0aodLg+5TnG4IM9uOjBa3mJYTQHZsJw3K7D5789QfZU31QAhhu5p3XKhgVukcRj315P
 zcKkKfmyuGLTRWTgtWblOeHr0gmqTcSTh8p5mOVt3CM91E7YQN7k2eQpVaC35CgGfFF8
 1fFO6H8xpQaw21RAQABkpZB+q3FnHsMrVTaqmXTgSaXATIxy50WeUjGwB1uSGfqQK+GI
 mkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029897; x=1725634697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWQjPb3i634Zotb7v4ULsj+3Isgg5EVUzD8LzfKdeFM=;
 b=Tr6CcsvXvz81/j1gmh5yuw4D8sVfRN5ogTH4zJJBLmCiNC7QQodMoDuLbJ31QcRWwd
 +Lseci25qpSQGriA1ttPK4bOPRq+GD4Be8zt/9LVUIC5uj1Xd0aNg/SwGiLpqjKYYUi1
 IUyHGdrDEABQ3VqvHmlOpWxDtrIMlJLMTAeUwciAAWh175hpifLB0aqdEHs1KJZgikhZ
 BrgnwoO1AHYT5O/CWwDQBjKKCN+R4IClaoG0r/P56EZkCLbeUAoKF6bItHkNtaB/Mq3p
 bBCSAtauuKOxsnNHxSvnexsTZ9eixi5MKXRbJwYKpL+qhbly/W4NDpPI06oyKsHFchY0
 0AIA==
X-Gm-Message-State: AOJu0Yx+/P9Gpmlp0RQxKqADyw+NcnwWWa0v6YGKV8S5NJQAE9eq1gAU
 VG3pgjM8PNYk9su+fh554vDN0C3/pbBRe3IdoRjB/VGHAizVOBzAoDfAWYFJT/u2UUPC4JmBmwt
 c
X-Google-Smtp-Source: AGHT+IE9a7+SFfB7y7x0WWvGzQOr5fHLlBzYgcJ18mVDkk9jvcyZNDC1sVERWaD+79MnFRrji7KfUA==
X-Received: by 2002:a05:6000:c8e:b0:367:9903:a91 with SMTP id
 ffacd0b85a97d-3749b526808mr5610257f8f.11.1725029897304; 
 Fri, 30 Aug 2024 07:58:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 05/11] target/alpha, hppa: Remove unused parent_reset fields
Date: Fri, 30 Aug 2024 15:58:06 +0100
Message-Id: <20240830145812.1967042-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The Alpha and HPPA CPU class structs include a 'parent_reset'
field which is never used; delete them.

(These targets don't seem to implement reset at all; if they did they
should do it using the three-phase reset mechanism, which uses a
'ResettablePhases parent_phases' field instead of the old
'DeviceReset parent_reset' field.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h | 2 --
 target/hppa/cpu.h  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index f9e2ecb90ab..3556d3227f8 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -267,7 +267,6 @@ struct ArchCPU {
 /**
  * AlphaCPUClass:
  * @parent_realize: The parent class' realize handler.
- * @parent_reset: The parent class' reset handler.
  *
  * An Alpha CPU model.
  */
@@ -275,7 +274,6 @@ struct AlphaCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 2bcb3b602b8..d34710f0aa9 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,7 +281,6 @@ struct ArchCPU {
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
- * @parent_reset: The parent class' reset handler.
  *
  * An HPPA CPU model.
  */
@@ -289,7 +288,6 @@ struct HPPACPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
 
 #include "exec/cpu-all.h"
-- 
2.34.1


