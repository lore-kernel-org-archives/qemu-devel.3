Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684DAC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdule-0005Ax-JB; Tue, 13 Aug 2024 12:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulX-0004jK-Ty
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:52:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulV-0001AJ-CD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:52:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so44051265e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567975; x=1724172775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcli30XoP28wm47c8WADhprJ+6f5OQ2N6n8H2nSEE5o=;
 b=h0gsFBKqd2+tEItQ6TLBdS/rL+9nUBIfXDKQBeo8A1NGFC9yeg92CTo0DJuFeD5oAI
 NPteMnQuq6/lrqpY+aJx6FB23nhfbyimDKCHyLA5VVnuBOwVB/ZTUcO2PzOJQ3KUowXO
 ut6HxiBP+yz5qnJhOCMQk3NsFTH2QxPCBtmkAPVKLuLkSLYdTCzfaPO/tEquAisYHQHe
 3hXBtyBaeA1O+7XgK8H/6vUfhmJ0nyyJml2OzqSBF9Ac0qWstJimt5yVZ+N3zEl1ODzB
 4p9diSpyGc8YGu/PHNtEsTptyRalz2zseLYmPCsgB0VyXBXraqZLComC3c4+/X+fT0+m
 wX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567975; x=1724172775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcli30XoP28wm47c8WADhprJ+6f5OQ2N6n8H2nSEE5o=;
 b=YjGcH7kQAgfd3WWk2hObZKIaHlUR480MotAat9hiXAr+VPFFrHP1fOfTCXia2QkLt8
 RseYoOirU6o5Qh6SPBDujbO1RrSrevbZNuFGdpKR901j1EDfwQOpNFNYUogFOgEQYMvQ
 mti0Jn7gWWttATTujX1Dhbm2JYAL0UuA6MSeHaOsjgyyagRYl+Cpht4V+xiK9WB41sVb
 baYAW5kVjSYUgFKMGvFtixxnu7oNRO677fi3C6mmXM3uEhP7RIRsPnSCK2zPFCAZWZ3D
 L3sHSS/JGB//q7sGhoWOCG1uFDvZ0LEnZah7NJooiTTUcl22/wIuJFI4wuIxmd72jUyQ
 RIXw==
X-Gm-Message-State: AOJu0YzJvf/I1ZVeP7/F3t82a5Rv6ErpUlq4R028Q90tG57XZDVhnnMz
 KGQPXGMrque9XGUJAAXYFphA2iT0kGnU+ybfyllRQ/rVybhJOErl1oGwGmSZ3fMx9/ILMjaYz85
 +
X-Google-Smtp-Source: AGHT+IFZF4sxRy7wE+1ngMM/MIlfpQ7gezjvFJh4ktuZlnZfjY3zTBVs794vdkFZ2xQWmg7nKNnpiQ==
X-Received: by 2002:a05:600c:3103:b0:426:5ee3:728b with SMTP id
 5b1f17b1804b1-429dd236442mr1184085e9.13.1723567975235; 
 Tue, 13 Aug 2024 09:52:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 04/10] target/alpha,
 hppa: Remove unused parent_reset fields
Date: Tue, 13 Aug 2024 17:52:44 +0100
Message-Id: <20240813165250.2717650-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The Alpha and HPPA CPU class structs include a 'parent_reset'
field which is never used; delete them.

(These targets don't seem to implement reset at all; if they did they
should do it using the three-phase reset mechanism, which uses a
'ResettablePhases parent_phases' field instead of the old
'DeviceReset parent_reset' field.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


