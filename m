Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52736C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugufN-0004ym-Jq; Tue, 29 Jul 2025 20:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJW-000553-Nq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJV-0004jK-50
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso7915594b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833896; x=1754438696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SxXNmNqWMUeslWUNuofoobvvYxt/1wv93E6nr48LJXA=;
 b=oUy9EuZ2JnbW4ByD21NBMNSNmscB1B6BZVtWv94U4H/tKJLjimTj1viZzgNizB/spT
 sDt5TXUw2cDE1Ee4GI8Ln8Ic/dbH6Yk0/YN1HgbBGa0JVRYiTnihzBvNAOP1E6f3igEN
 I2btHIqlU0J4GwzGrdCvNrz1NA+ArTb8VNLsyljcNE6K1LQGHn39hWYqCdLysFx1ep17
 XJ4/ntSid/NmOMDytk25zyXSUKUZLmAcBnH9bGkmTA97FeHRzCmaeKoUulcxWSr/4ZUM
 TNWixLNOzBDStbCFYBGjkebJlLiUfJc4R6MwlFZSRd8aG3gvO7RUXse2B0ZOitb+sKiq
 WDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833896; x=1754438696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxXNmNqWMUeslWUNuofoobvvYxt/1wv93E6nr48LJXA=;
 b=GfbkVVxRrOD/gn4JcPkLEqsv/mbOxChXT/nUK0amGgxeNyS85A12ux3NhL7K2jejQ7
 N6MMlg8neBqr+iS3+42tiKkNVIQ39BJMOEq23AU+Z/2Q7FHgVQupxR9VXrYwbew2rMIZ
 aR36m+vSnIw+2VQBzPEOxRm8a0MXuf7D1w9AvLTBHbbEmutg810vDUaws6BQbvyD3Vfp
 RZDaEPss7A+8flex1H7AzyhQ8/iaLdoIEYdarvMq7sWsfji0dQMyoMoISKFnqTiRW2+A
 Ee6IaGU5RFoBkv+4kl1wpDafOoRUx1q3OZJ3qpFyUsOKwzzWC9ahFWczap5mmvcn8Bpd
 40nA==
X-Gm-Message-State: AOJu0YzJEBHLDlV3jwsBHlv4PuE3dv/fABaDnrQcOcoHO0S/d0GVA8sr
 qcS+wcpgxQpWO+amqgYApWj0qop8L0z8gqAU3jLP4WTZ1657DWwUxA7Ns0jqJI4645fvTujuH9U
 ZI3a8
X-Gm-Gg: ASbGncs1bnzti+DyFcSpjTl+gjtz5/ScnpCoU4Yz1rcBD2ICfLvUW6nYJniGr6PfUbd
 CWhfi6Pq+TojnFAu8bsG5IokJRCKl4PTC1bhGNRc8RefUpkKJO0q4BlI6d6ogN9YkLJTDjC7rD7
 /JJKAoPQ5FFvjy9WnzGcUGH3JgrdjAQD3JQFK7b21hsuJCBzV/eV35wiwUct4QHWOwjaUsrUB3k
 2xKxHsRKHoJZPX7vHKdS5u5v473H9TSwZay4jGMNhSZoGGxB+mbf7mUMLSDZ7K7wWFsmcXHB0vW
 FraJyl4cLRHPBvmQbqK8T0y1Q7yk87TA409cqGIUQ4LoFwoMxe4Y/P0vIpJPM4pPLQfDCQB7Ow5
 nTIEaScS5wtNPIi444FaogLqEsBJ+jy0eMoOETiJj6jQl0ykxCxle4h6KuNrKOKRfRcDIcJZ1Xw
 sEPXNzpBT66Q==
X-Google-Smtp-Source: AGHT+IEcwIuICd65dWt68IZ/Tpi6EQxt0EDV33p2kVOAdZ/XOHL7o4TvH9o5Zmke6cLwW6PwOxLgJw==
X-Received: by 2002:a05:6a00:288a:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-76ab2b576aemr1658209b3a.14.1753833895620; 
 Tue, 29 Jul 2025 17:04:55 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 78/89] linux-user: Move elf parameters to hexagon/target_elf.h
Date: Tue, 29 Jul 2025 13:59:51 -1000
Message-ID: <20250730000003.599084-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hexagon/target_elf.h | 3 +++
 linux-user/elfload.c            | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index eccf207f6b..a9f6d77fc6 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -18,4 +18,7 @@
 #ifndef HEXAGON_TARGET_ELF_H
 #define HEXAGON_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_HEXAGON
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b67bb7deab..25a3d5c9cb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,13 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HEXAGON
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_HEXAGON
-
-#endif /* TARGET_HEXAGON */
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
-- 
2.43.0


