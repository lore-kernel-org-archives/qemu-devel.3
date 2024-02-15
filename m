Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E759AC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6j-0002FR-CV; Thu, 15 Feb 2024 01:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6h-0002En-0J
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6f-0005JP-7v
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d94323d547so4406915ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978024; x=1708582824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNAOuzYKunseGhjt30zEM/eN7uq1Wl50v8pWc8K9LWs=;
 b=df1jQ9nn0h3aSO6nnsYW1nF1/3ECGV8+AhgrhIomokIQnflH0KW+3wgGMX/1FEaDl0
 pBGf3EPTOKMG6MRauKwpmcnU/la1Sj9ULKATrkyJ3/kle/jTbRx5Hrr1Etir5OZLeqSC
 /rNdiEAda6G9GqDVCh6gPcSbs7OWkYhkQadRCKRcxiuUQMgic1NYhroNiydabPYwlnZX
 okwkCg6g1HuYeFRSltY17Us9jy99JOLsOtLeO+6QeX3iAJCVqNPKVdac/KxiQGL0KDUk
 48P6qnKhLMZ3NceHPmDEg2J7J5dBYLpuIzZKOjwHOYR11GcKEfnxp7u81b/3cjo9Lhok
 g+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978024; x=1708582824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNAOuzYKunseGhjt30zEM/eN7uq1Wl50v8pWc8K9LWs=;
 b=DB4cq9lgvR61yl7kIsOWkQCJ07z7T2dHJNaEx+e385rnPb4uyayD7lv9hSQorPstGb
 +IyEjxc8r+YO8Umje4CtFVq3vpgo874IpmcBxADz5TY5TaGY0r4OrCn1P7gpmK4eb0m+
 GqbyNEskx0fGszWjfgqsSS3p2xGhrOCu15GD5cQPexspHP9K9k21n1vN7L44LExah8Wu
 /g7gBI51ZYh6dV3Qm9NGBYpVYoYWSECMNsdg+jbjhMAZbG53brVLwb9SaYER7sdk+o2E
 onzyhrjxmoLPFWxsTQ8ytP+HmBw3+3gAYiTyLUBtmDFpWVxynLPIeCmtbT0RO5JXTxiO
 IXwA==
X-Gm-Message-State: AOJu0YzRfPfrZ7zuuW1IBLBALPNNtLaNMBgWmSYwbt2eyLWhnRW1Z93T
 hpDUFjrHlbR/HgYTLj/0Eqo2dZUzqpTSbfOJxhaD+Mxv3oOYC9b/ELZn6UJU6XEzOhVYDrNubXS
 4
X-Google-Smtp-Source: AGHT+IFZ/57uvY7YvXLIrwn1yHMllRkzWECQZhniPiaGQ4xDkMdx0mpTq5/fraMXHc18GdauUW0Vlg==
X-Received: by 2002:a17:903:18e:b0:1d7:88de:cffa with SMTP id
 z14-20020a170903018e00b001d788decffamr1095734plg.19.1707978023844; 
 Wed, 14 Feb 2024 22:20:23 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 02/36] linux-user: Adjust SVr4 NULL page mapping
Date: Wed, 14 Feb 2024 20:19:44 -1000
Message-Id: <20240215062018.795056-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.

We really should be attending to this earlier during
probe_guest_base, as well as better detection and
emulation of various Linux personalities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-3-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8eef893d0..e918a13748 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3912,8 +3912,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
                and some applications "depend" upon this behavior.  Since
                we do not have the power to recompile these, we emulate
                the SVr4 behavior.  Sigh.  */
-            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
-                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
+                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+                        -1, 0);
         }
 #ifdef TARGET_MIPS
         info->interp_fp_abi = interp_info.fp_abi;
-- 
2.34.1


