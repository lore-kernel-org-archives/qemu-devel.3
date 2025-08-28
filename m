Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3DCA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbS6-0003Ca-PV; Thu, 28 Aug 2025 08:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRQ-0002Mr-34
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRO-0007D2-B4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:19 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7720b23a49fso940154b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382957; x=1756987757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjEwI1V0xJg5eU7+azAEOYSVdnzlWFhERe/P45oUe0Y=;
 b=nVYKZJSwzjk8mRtqxyHoJeRauJVjB/lhFPmA62unfYW6uS9iXxQEWqQwh40N9Xqv0y
 KF7bSXxY6WbnhCt5CaFEU536qr1DD5/anh9mHAQpB/nyXotrcSidwOjMfrj4xw8VQzgf
 yUhBXJ36v7pViEptUXM5ECviIDZz3amjQoq10n7J65FqwxSRVNrFf6gEeI0FC32v1rRp
 Du0OUWXi6j4R4ZONjC4kW+nMXlQR3URRVkpq8gSW1oNS60X/keP5Aas6LZ8GGspolVbG
 rN1FRnh7UqE+jhR8m13vTH/6SGDshvNF2EyecyOgJFHwxk8B+kXKAhPZb0xlh1w9usDC
 2EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382957; x=1756987757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjEwI1V0xJg5eU7+azAEOYSVdnzlWFhERe/P45oUe0Y=;
 b=I0QDqj+TYioit3NnYV3Jsw/nY0c2nJkXgPB7yYmmdlBFmhyEEAwiLZBpkTVQ9gP7vP
 QPcbWIxlWTo1lQHTURMrO2CDLLlekoiol6Pa2UPQGw4O/zTFRVnj26U7EKW3vnoX2rJC
 08vPIlyx6eY7Hbr6tLzEXuEZ+R+niMdFSJnLRtnnWymKUDo70nWEeVnEME8oTgMhSL8Z
 8nxvIBgagDvtM04INov2rki57Ik6rkFM8QqkMTvZQbN82xQcmh/kaR34rCnjVRVHZC8I
 cwQkPIfHz5yJFhn10f6CwgR0nkpmElbOt0fk/xMQXJ/P7PSoUO1Ppv0C6pEIItw93D3z
 8LuQ==
X-Gm-Message-State: AOJu0YxXINO4EHtX0PwwLUOrObxNbznuveT7n5EallcMZwbY3ARVovRA
 CFuR1/DdXapy+lfVY8ryFAanSzb+2IOfi1MLu0ZBnqq39MdpdgXEsv8yRl7PSLwzOLicZIcR51T
 ktCusvIs=
X-Gm-Gg: ASbGncvPbsvrO/5ZnLBR5JXVuNzS0iq9z3J7AZTMSfpMeJH3CoH5SJTGSF0sIzYVMWt
 tPGfxfocVQKfI8RWBktYnZN5Vs3BpnoM/KXiQQtwMBGMjnz6bYRazw+wh9auYFCSfk/yedC5l0D
 Q6dJQ75Dum6EhpjDXnhHWSqPJcLmjiCvX88Ai10yZIC8Ng1UeoXe/LLh4HUUm9wfeemrEtdgsuk
 vKWqUFePwklChsJAq6HUNkYuGP9wM6Mho7Lr7RHB9sjGr27igcXW6V2BBMXymvb2/zYrsTuxdfH
 RwhNwANxibPouatKJitVKU++Vvrnc7ZoG2ceCxGq6MegN/KFlIgmns2D04euasHuCTNKQBvFj9W
 h7/16ykQvIVKg73swD4044Tqu1Jy/F2AjggAVfM6dYKOQ5ts=
X-Google-Smtp-Source: AGHT+IE91wV+wKVAYbBK/OswY4S91vIJmmgkrjNrTU9aev2gux2NPPNPW9PN75GivPm7SDAq8Tz83g==
X-Received: by 2002:a05:6a20:bf29:b0:243:9c68:a031 with SMTP id
 adf61e73a8af0-2439c68a272mr7398234637.57.1756382956472; 
 Thu, 28 Aug 2025 05:09:16 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 14/87] linux-user: Update comment for target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:23 +1000
Message-ID: <20250828120836.195358-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

The only thing now used by generic core dump code is
target_elf_gregset_t; ELF_NREG and target_elf_greg_t
are now private to the implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 930701f08f..74f88dfa68 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2859,12 +2859,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  *
  * #define USE_ELF_CORE_DUMP
  *
- * Next you define type of register set used for dumping.  ELF specification
- * says that it needs to be array of elf_greg_t that has size of ELF_NREG.
- *
- * typedef <target_regtype> target_elf_greg_t;
- * #define ELF_NREG <number of registers>
- * typedef taret_elf_greg_t target_elf_gregset_t[ELF_NREG];
+ * Next you define type of register set used for dumping:
+ * typedef struct target_elf_gregset_t { ... } target_elf_gregset_t;
  *
  * Last step is to implement target specific function that copies registers
  * from given cpu into just specified register set.  Prototype is:
-- 
2.43.0


