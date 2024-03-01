Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5735C54E55
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByU-00067B-89; Fri, 01 Mar 2024 18:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxv-0004xN-7A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:56 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxs-0004Gn-GF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:54 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so2310666a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334411; x=1709939211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CLMQSQQhuvxkYJMehybPxufQXltsEjsiCdZyGsMtXw=;
 b=WUGWO6bOH9q4Yr8A9dKtGy777iWoWKXjoGV/5add2D96Ey0DVLJNzWYHKH2lVUvyNK
 eCyRQ2SVEW1pz/E65v4a37NxiSBOETnF5Lxh4Uw2ACp393L7Sn6yzqO7bLgNnPyqbedX
 0VO7DmeJ3kQ8516xOmb49HtKM8XTf9NLeOJ3ExROjD1eH1k1jKOgDIMEZP3Popif50f2
 Lk7Q49LmRhMHGZVfDpesbuDk3PZGbQ4eAZufqBDJpUjePUfipSmVmC7BJ3nCm24aG2UW
 ceT0ECWJvOPug+MyZ5N7kpIRi6N+pbYxTDE3ZR/Cicu8zEknt2WWyu7sEjlFGUpNDtyU
 NYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334411; x=1709939211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CLMQSQQhuvxkYJMehybPxufQXltsEjsiCdZyGsMtXw=;
 b=eLfwYXjO/qV780pS1mG026unQji5RidHRTMOoriO80ibey+RU9o/tBcu/gkR4tTgVR
 Q5JwASSARSk8Og9XdHOOI6GzWHZK5scuQDeLdk7NLMKKdavLPUuW5Weei/C9FyHyNVmN
 K9I3XApatFuxm1TzMXGvUTaEY7OsDTnv2UndAuKX+jqe5dxwB0WU9s5oi8fcXAj5C3On
 vCB6l/vxP5h2N3IlA4u01biFkhffnanyOqnsqrEZ6eA6GY1qd68p2murHEogGd7CoSkb
 urvpe5vyaaNdA3aTr6seFKCCTJrjFfa8g2hsR+bAynF8w0Ta64sICl9PLFcmpyENSJP3
 4f6A==
X-Gm-Message-State: AOJu0YzB7GMfBzYlPVDBAkc1D6ygqMuBxwsjua7ugB+4HimW1oOwwgGa
 83O2RpzCIi1DvH+VIp0ei3CRh3ZkgptU/TTO6i+aB2IOmaVshmyviwNLdXv7P5HgWJzqMmSRwFn
 I
X-Google-Smtp-Source: AGHT+IFt03SSpREzKVP8WDSa+AzcSc+40i3Ongn4dYqWswT8N7WBVrvVDJWw3FpDO7oKFEIN1ZTB2g==
X-Received: by 2002:a17:902:e741:b0:1dc:30f1:b8d3 with SMTP id
 p1-20020a170902e74100b001dc30f1b8d3mr3825027plf.18.1709334411111; 
 Fri, 01 Mar 2024 15:06:51 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 21/60] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Date: Fri,  1 Mar 2024 13:05:40 -1000
Message-Id: <20240301230619.661008-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

AT_PAGESZ is supposed to advertise the guest page size.
The random adjustment made here using qemu_host_page_size
does not match anything else within linux-user.

The idea here is good, but should be done more systemically
via adjustment to TARGET_PAGE_SIZE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-5-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 561c11ff37..0f135f6b6d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2679,13 +2679,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
-    if ((info->alignment & ~qemu_host_page_mask) != 0) {
-        /* Target doesn't support host page size alignment */
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
-    } else {
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE,
-                                               qemu_host_page_size)));
-    }
+    NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
     NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_info ? interp_info->load_addr : 0));
     NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
     NEW_AUX_ENT(AT_ENTRY, info->entry);
-- 
2.34.1


