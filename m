Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E1C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOw8-0001OG-CQ; Tue, 18 Mar 2025 00:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0001EL-F2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvR-0008SO-BH
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225df540edcso68625445ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273496; x=1742878296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7b7Pa/XivG7M4hjK9jqso2S4d+dz1DGry6GtvIR3C8c=;
 b=KWZbl+v7Bs/kss0BYGp6DXqxgf2RJV2wxi9kkOrpEQ4/t+mB7aB3Fd82FqUYy/0aOt
 X+ZkuQvkFLZnUma6qXQ3vTBqYIwO5b7DX83s5GYkvJRGKQtZlzzEvOULbRslc65KID0h
 PXKUTlFL1UEzo3fpx86FC2E2FgWCZuJCjVdNKK0b9YbZXx/wHq9tcTkQ52VflqoYVnt5
 O2RMXhHTxlTSKqa6QCvmEEzCQOlqSCDM7GpBnPMzcQqbpl3megIZ7rBEt1tr3Q4TBCO1
 w3vMG3TnRLbyIkACaWl+PjUmxaxbC2Up7VAyLOyHErN7AWrKOHVUMEq52P2pRp9xsgoh
 L1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273496; x=1742878296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b7Pa/XivG7M4hjK9jqso2S4d+dz1DGry6GtvIR3C8c=;
 b=itPb2+9GxXQdmHousakXWIjthjifi5U7pFipvC+NexocbNZGOqImcJdkPrnAJIRqes
 iTCR5ezpmmgJxTp9B8D6h7ZTq73g8IVkea7M8WuwGdJTZiw3haCFZO+vhCcrSnW5CPT+
 1Ua3IYsvLhLtbzr88k5IIc9j7+W6k9zcHzvxvkw/Pm2V2p8FhC++BEveTt4OlDkemV8d
 nw9LPoSScpMFUy2LuN3xAU0J6K4J9Gp6lGGqoEXKCIX6Krk7KXDoblCnmX4wK4VkqFj1
 lKQsQ3NYI3mb6nOePNQCVg/2WV0FTxc+w7cvHg8bJH2/h4S9epMpmAZO6NkZbd1riJ+o
 uDzQ==
X-Gm-Message-State: AOJu0YyC8SOLRdZifuGXzxa79YGduBY2uy8ObU2wFibSRyUdEaF51FjH
 Hl6kSYchJ/yLj8x2qu6ON+wsZIUv5/GCp+9pcHSegkV3njjA0lVZXCYc/rZvLP2UcQcoVyhAa4D
 m
X-Gm-Gg: ASbGncsenhJXuYxdL24zlAbMMq4Wz5c/bmRIbB77xmeCledN0CHfzuH2ISd64IkMojD
 CM0Rr2iUspL8Rw6AAyTiRnauPfj4dkuQFpmCEfAMBJKGzA9lY8BPSANGUrcczns6MofVawGqEr+
 +9QyvlBAJ1oSc700c8ZVuXhQCSx35totQejpMzOOMl0l4kbH7JRfUbhE2l7bFmoY6XpgIPZHbRG
 Qpdf1EoJIT91ls0G2kCXF6oGYXYSUnn40CVuVLx8S3xBiCttNjXB0OJJHmY8BZ/QB56Y0qQMnee
 lBN0zOsfkMyxh1EFP3cs5JCol0vJ1kP6TwaViJq/qDLU
X-Google-Smtp-Source: AGHT+IGfy+Qdd4zIdkaKpSIgsiwDKH+mdyBXjzWe2NY8Kt3gZWsIWhQbMwLpqie8RWdAjPyywqbjZw==
X-Received: by 2002:a05:6a21:1f8d:b0:1ee:b5f4:b1d7 with SMTP id
 adf61e73a8af0-1fa4f9540cbmr3123721637.7.1742273495989; 
 Mon, 17 Mar 2025 21:51:35 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/13] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Date: Mon, 17 Mar 2025 21:51:15 -0700
Message-Id: <20250318045125.759259-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

We introduce later a mechanism to skip cpu definitions inclusion, so we
can detect it here, and call the correct runtime function instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/target_page.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 8e89e5cbe6f..aeddb25c743 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -40,6 +40,9 @@ extern const TargetPageBits target_page;
 #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
 # endif
 # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
+# ifndef TARGET_PAGE_BITS_MIN
+#  define TARGET_PAGE_BITS_MIN qemu_target_page_bits_min()
+# endif
 #else
 # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
-- 
2.39.5


