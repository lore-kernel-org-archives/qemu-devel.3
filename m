Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C0AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WT-000176-Bl; Tue, 12 Mar 2024 13:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UM-0006Ao-Kv; Tue, 12 Mar 2024 13:00:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UG-0008KN-Jy; Tue, 12 Mar 2024 13:00:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5a232fe80so40978b3a.0; 
 Tue, 12 Mar 2024 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262822; x=1710867622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbfazfNwbDHEXhZ5H+0LiE5ZtDTwt7WkBcJyAQIfKdU=;
 b=g3gPa5YQMrrcpCwt1up/RJtG7Q8/a8ZI7Z2WCsBTF+BnxEmVXtQBR/HQ7AJ0KGqexT
 JneEhVIwfSvJBc075cJKhESMvowYKiFMyCsLw2uW9CtwI2y9Lip6B1KSDj6u7Bz6OEbW
 fkoHMQijSwU3HMrOaXLQ5Abv6M86r5SdcD7/xxpgcGNtkQ/mRPPF1k0ntIyLbjAU/91I
 fdq1dGYj0wBMSjd1VWdb/9MdXjhNY2CjCbrzdP5B36D9Hcz0QeqyFfNlKIHGtGON100X
 xLHQZfGbb2lHWgmZFkNj/ms8SOQa01iRw3dtyilu2AFyz86780LOjiyUq/mfePIdHM6A
 blpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262822; x=1710867622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbfazfNwbDHEXhZ5H+0LiE5ZtDTwt7WkBcJyAQIfKdU=;
 b=HyPU9DXLoXlPhHr2oueTKVs5GO3XlvNHWNiaTEKEWTkNCJI77RYBa/hsF/tiPQpqPp
 nGI0OdD4njVml9gUboxLV+GPpwEZ/xfGoJjwnTDc0b083hIVYXRT3/xS4h5kArP6JsG+
 L35DyaDT/VMoiS68eK2+dKpE2f4LEZUo98otpFEw5OJXlZOJFQBWQHlgtVQ2Uz0JL8ls
 RH08zGqhpe/H1y1zZlxpcCx2mWEMoFzKMy9lwcpM5UY0oDHRCRnbVg2LuoTsUP7CAhHn
 S4Ufkfd9tRgOJ9dNa3f9V/nhJRz3OVkePNFLDZhpPo2k8mN4KYIUl4Lu4Cqpx8IllTJk
 EWig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1uzh0penhAIn8BblChhX0d9JpQFlf0fFZEFc9bS98ljNncCpyVXZqLRVUCS79nvta7gwJ5T8HPX1mbZ3JVfRgCqxq
X-Gm-Message-State: AOJu0YxXMYI1kdTQnXgJQjr06yJzL8sAgVuEEaOdyfqFcTFucYNT9gMu
 PQ4HIQ5Cpeu7Yv4718aTlsawWljoHM+JZ4C2IimgWuJ+kkU8mQRwSipHHm1uwhI=
X-Google-Smtp-Source: AGHT+IGKbyYj8FLg4m1RHuT++vxFUdBP5WtHa0aGbG5KqECWMghkOWlTPS9TFIDouU1SpFjH8zHETw==
X-Received: by 2002:a05:6a00:1908:b0:6e6:30ef:b7e9 with SMTP id
 y8-20020a056a00190800b006e630efb7e9mr8383pfi.16.1710262822215; 
 Tue, 12 Mar 2024 10:00:22 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 22/38] target/ppc: Clean up ifdefs in excp_helper.c, part 2
Date: Wed, 13 Mar 2024 02:58:33 +1000
Message-ID: <20240312165851.2240242-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Remove check for !defined(CONFIG_USER_ONLY) as this is already within
an #ifndef CONFIG_USER_ONLY block.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 32337c67f4..148b0c3a19 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2663,7 +2663,7 @@ void helper_hrfid(CPUPPCState *env)
 }
 #endif /* TARGET_PPC64 */
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#ifdef TARGET_PPC64
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2738,7 +2738,7 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
     do_ebb(env, POWERPC_EXCP_PERFM_EBB);
 }
-#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
+#endif /* TARGET_PPC64 */
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
-- 
2.42.0


