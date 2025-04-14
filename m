Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56CFC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 03:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4AmU-0001uz-6R; Sun, 13 Apr 2025 23:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4AmO-0001uA-Bt; Sun, 13 Apr 2025 23:46:40 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4AmM-0004S4-9n; Sun, 13 Apr 2025 23:46:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af523f4511fso3339536a12.0; 
 Sun, 13 Apr 2025 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744602395; x=1745207195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAsRgZLaOPa/VCFdT446Q+y4cyDf/DSb2Leklt7car4=;
 b=QIWArHE3g60qzocOpu1cIIFajiYs7/7w6mDP9LvuC8OgwsJWJhF0qiEDXVRJFc9Lmf
 h5fCt0CN+Rk5Lb1X150NalylQIIV9ow4y46MEViloUrr6Rh+TMphz2JP5IWtD5t8LIpR
 XadDlX3bNvzSnfg4RY5FRxzkN+4+I1IeSF0LbVADQ5GkDwjPl2xU5VsfzgwmzEuFBzPD
 bH/D6Cdw5bcxXi1rPZ1Ym30vfyE+JA87drAsKGhdJ8Y5iu86mKc28UMceXAhzNelr6yx
 t/3fpjQS0IyIqadFfu9geLa03EAhRVhaZtSWXT0aXN7ync10J+ZGsQBc0DZ26EGcguCF
 738Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744602395; x=1745207195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAsRgZLaOPa/VCFdT446Q+y4cyDf/DSb2Leklt7car4=;
 b=AV+GE3xXeIABQvoUwyCx/L5sod5hpL8qaxl2G3mTjO9yeVLWL3Yuql1r0BdSh8kEdc
 u5UaJ0cDUGEcoXx99TbvxoRGkz1OMjNEeqUTWrh+Gtx2ft6BsJmbZlMimHAbZ/Be6bvJ
 vCTmLqEMV2Hve+pr5tuDgF3JhHEs1NBXmfMz6kWugpmZLSsnk1b13Gc8KEsAJxW68KjJ
 KRH0hydVJd//BKk5ICyqASt75spMYlpwSmbv9jq0PJTWDPBwa0PAVPEtTKt6P6dh+QD/
 LSKQlO6pJv31GrlxMiLh6u+pDQuzkBpZIP6Mq2Js1c0uOwBtshYXY0KZnq85Urr4wJCu
 Xcdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFaK78zzjoSR3uvveZMHeEDexgie17zmURCsDoMTFHujhke7pr5uJZC+Rw2eXr+9HyecbMdxOn/4VLkUI=@nongnu.org
X-Gm-Message-State: AOJu0Ywri2zxPX+g3A0y1ihwcvEKSVzEvxOIdW6YzmtI0l/zyBduXSYM
 tbhs8pOJ0437LMj1awEDUDmYFgfKMRp/laIsVszBaMTQlIbzh1KBaSIQpw==
X-Gm-Gg: ASbGnctvRThhl4p5W8qPwEYxrWmDZtJbDQazJq5hV8RiQLKsQzB8zlXTi3+cNkO0G+Y
 ZM9OLS6TcCNRZbdBV7rqZnFIer2ddrrVjMuiPxMW+SKQZKi0G6ioFD91lWCS+TC+YNONz8K58nn
 kLyoouDTAQ0pqUe6U5pbvnqCmYj4CdBs6pVUWr5hDkQ21MxsPwJyn7RorlAv2+tMovFFACJNM66
 8U4aIkCoDb+VbXKWyPW5cy5PQBuX4WG6Z9IgHqLg7guqcWA60onDh0fbi1c+YCmacX1vvM9CFbP
 nTvIKfGvWmizDHdf/30qEPwf34NHNeWAJj85eoQ9
X-Google-Smtp-Source: AGHT+IH8wffaPIheLC5VZZTahest0xWcRsDooNQQYpEAVXQin6MmQBXdaQoraexfohz3KSIZqeczig==
X-Received: by 2002:a17:90b:2dc7:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-3082364a77cmr19605350a91.17.1744602395370; 
 Sun, 13 Apr 2025 20:46:35 -0700 (PDT)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm10276052a91.12.2025.04.13.20.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 20:46:35 -0700 (PDT)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: ziqiaokong@gmail.com, qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org
Subject: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
Date: Mon, 14 Apr 2025 11:46:26 +0800
Message-Id: <20250414034626.3491489-2-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414034626.3491489-1-ziqiaokong@gmail.com>
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On big endian systems, pte and updated_pte hold big endian host data
while pte_pa points to little endian target data. This means the branch
at cpu_helper.c:1669 will be always satisfied and restart translation,
causing an endless translation loop.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c4391d96b..bc146771c8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) == MXL_RV32) {
-                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
             } else {
-                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
             }
             if (old_pte != pte) {
                 goto restart;
-- 
2.34.1


