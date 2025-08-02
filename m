Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A03C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPF-00066P-3P; Sat, 02 Aug 2025 19:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLP8-0005b7-FE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:42 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLP6-0001v6-Tt
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:42 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-619a915c65fso30697eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176360; x=1754781160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuAZkOmaNlZv8AwzpdIipUN5ubagjCWQYNTuWVayrGE=;
 b=jgk1Wv1EqUW/3KvzcKLplJBmEffxkEtOGlGaph9AYfpa19DdYQ/unlWGJKpSnicNt3
 hJulD+4ZGBP3z7BpyMemfJBDDExWlt0gmtrO1KohwMoBlZezaivXjLMyNwdM1rjjm4Aj
 7sERYHat+ufafbZqTK8Py65MyETNB5NiiBXcM+Z5okM6kt05PLa9eWKANrWuLslVUoyg
 SbsVUnRTi5rjbSdyPiXyM/GNjEbT9W0V8XOEB9hrMsbvteqw9YBxWjYjW5lNCO7faEqE
 9B1kMlMyOcjh2FEY6X1NRp5GyJBP1ZKt86Dwsd1r+8Y8aSbohw3EXh8av1NE3dIrX8+s
 1bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176360; x=1754781160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuAZkOmaNlZv8AwzpdIipUN5ubagjCWQYNTuWVayrGE=;
 b=QFKIRAlQOVlxisDVHLpQ9/h+PgHJAB/P0RqscKmWup03/njOXb1NiU0hFID+tP71np
 VmlDoj2c7/Ud85/SBeJ5Htyz8XALlWbVWU3a//Yo0gI1yBsxYS8DQK+voCWePlC3cTip
 GU/qgda6EUELm7ccJw0jRMJ9ziAXUTp9Cy2IPc2OzjjjME8zswjeUDJWjU4uBnAvh3FT
 get7bT31vG2bTC05SVxQDckrfrg/dqBI/NtFYU6O1ymNNJ7Exa94GG6eF4ynGfgyHbGk
 hc9n23sNHHl/DuMSSBgSmOoipiNexb4CFU2RBMEWSKMuwDdlClnoafH3PF9i8bSPkQnS
 /jFQ==
X-Gm-Message-State: AOJu0Yw7NIbLqNBmIK8zcqLVyv8SSsGwd2Am0UVhLFCiKf07wxhh/J7p
 ay5JdMfKK/aUaPFzYy1rbJ56cy8qTJCaWfur/ClN4OLuDLk9bKOudIke4O780VMMT+H9EbZ0ZqE
 QaQPdKhE=
X-Gm-Gg: ASbGncu4oV4XTar75oADFWIg2wTHY4NBZjxw8vCghRaV+09sAQSXznLp/oa2AuBNPDk
 YkVvKUaE9Ar9WwxX7sq+W5Lu7BQsbRiO3MJgxI2Ueju94OpvFKykT59u0vLV4NB2WymNPzFdHMt
 LkXozacGV7iwHsa2cpt0ulVf9fSvt6OJsjBdDPzyfEsqPmGv/zXHKvPdExPaUe9X2DGCLZXiOOz
 1Q18bDeOT1AXvlL2KrcG3FGxs0GOpFw0gVZoSj+PBBouyvXJ+GTv9CvXUAwZvRJEkkqI7WuKmxb
 GZBwCTKL43xB9bmP2Kk7RoAj4b/jyIxHeqJbcsuulmMwdnN5CxlO8Qr78483B5vzvahZ9BBR9/Y
 nVMOgO03qxUqEAX1vkKb7W9oa5RX2g8xL0enWkwOdxvLJXL5dAa+SsFj4kKUKpojVFQ+kXdLFrA
 ==
X-Google-Smtp-Source: AGHT+IHUaWInuTBmHlHZHgmABnmAP/ExGLWeIVwab0Q51gOZQS9QGzmAvhCZZm/aYODq1sL1TEWXpA==
X-Received: by 2002:a05:6820:2685:b0:619:a3cf:4d82 with SMTP id
 006d021491bc7-619a3cf51a9mr554579eaf.4.1754176359766; 
 Sat, 02 Aug 2025 16:12:39 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 76/95] linux-user: Move elf parameters to
 openrisc/target_elf.h
Date: Sun,  3 Aug 2025 09:04:40 +1000
Message-ID: <20250802230459.412251-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h | 3 +++
 linux-user/elfload.c             | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index 4ffe54fe87..1d3c00c83d 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,6 +8,9 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+#define ELF_ARCH                EM_OPENRISC
+#define ELF_CLASS               ELFCLASS32
+
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
 #define ELF_NREG                34 /* gprs and pc, sr */
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 34a2639d85..368c7be0e3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_OPENRISC
-
-#define ELF_ARCH EM_OPENRISC
-#define ELF_CLASS ELFCLASS32
-
-#endif /* TARGET_OPENRISC */
-
 #ifdef TARGET_SH4
 
 #define ELF_CLASS ELFCLASS32
-- 
2.43.0


