Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B11C05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXQ4-0000kw-Lr; Thu, 18 Apr 2024 15:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOR-0007g3-DD
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:01 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOO-0007IC-6B
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:59 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5200afe39eso131757366b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468353; x=1714073153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akXy09tUeGr6mCjhMUDCOqgVvIVDrIu0xemDF/6ToBg=;
 b=w9Tvs5ydrAfdcvCpUw1hnTnuV0alj/n+NqHob3B5ivBx86udhY17/aiKGMoZH4sdI+
 rtQ2xi5KMOV2HLdHrJD38edvafwScUwon3MvgaMsgWTNQE4rq8U/aZnZYv6ux5YnQCyL
 I6JCqTkwVWn8dFCXsv6A/J//ceza4QDI/4sVVyk0PYIYa5CtMvCSJ94pjLD6NvQb0Dcs
 5nTEirbXjKM+H0lvuY98apBHTq8mvoqY2/bJnvSOAKtLi0vIbMjpnquxM/pf4/GxMI1q
 JzyXtbtV5BDXfv/6oOpPlaXsqrFjqhSSe4XrREPSwuj08P1EQW5fur/RuqHkPh+J/Bse
 4OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468353; x=1714073153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akXy09tUeGr6mCjhMUDCOqgVvIVDrIu0xemDF/6ToBg=;
 b=NltsUME2Mm/NDkyXahIdGsKD/Wy638YYtrmpuSvmiXoblVN3l88iXwoIKeKSSVZTXW
 76nY35Sfg5BXtZPFhBda5dgRHqP3+caSfSyuzq5RVLcnhRqoo2dUG6wWUhvia4/YdBw0
 QOGtkoD9nZ/BVeZTki/F5+d0VUIcw4vY31lXVUKVRPQsHA7lWpoqvdr85q4J5pF7cTn4
 Vu30+BgoTg/VFOcAs/et0o7MNHz0OV7GArU/Ds5P5KSsfbTwRfZh0zP1XYX0L2pHhpnS
 Xv4+WUZR3XNC4agayCisI2HwH3bIZR1oQKEdCp8EP09xEj98g/fr3AJrUK7OvROoO0DR
 MGXA==
X-Gm-Message-State: AOJu0YzzyRf8IbQj3+MYWsO6qpY0uFSH3POheTrdCCmVZrAGOoiyzTpp
 n7VNfom+janZ0tp4tg6AlIHd/XqB5i8TTXLISDIABgLFNnqdiWFgmg9+O0pbflBUXWVxejfFbH9
 I
X-Google-Smtp-Source: AGHT+IGHWdMJNoXaAn2jkLARpnzm1AkwDW/nssSUAmn21RnLFR4YTnbmDPzOOELnW5gLZFOLDS380g==
X-Received: by 2002:a17:906:915:b0:a51:c964:3cb7 with SMTP id
 i21-20020a170906091500b00a51c9643cb7mr50934ejd.61.1713468353390; 
 Thu, 18 Apr 2024 12:25:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a1709061e4700b00a52244ab819sm1270026ejj.170.2024.04.18.12.25.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:25:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/24] exec: Restrict TCG specific declarations of 'cputlb.h'
Date: Thu, 18 Apr 2024 21:25:03 +0200
Message-ID: <20240418192525.97451-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Avoid TCG specific declarations being used from non-TCG accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 6da1462c4f..ef18642a32 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -22,9 +22,14 @@
 
 #include "exec/cpu-common.h"
 
+#ifdef CONFIG_TCG
+
 #if !defined(CONFIG_USER_ONLY)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
 #endif
+
+#endif /* CONFIG_TCG */
+
 #endif
-- 
2.41.0


