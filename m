Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50F0C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadp-0006Dn-V6; Mon, 29 Jan 2024 18:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadc-00062g-Ee
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:03 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUada-0008PU-AN
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:59 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so3262050a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569308; x=1707174108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1cRBtAgGqadhUih0VNs9If35/tfCXiaB3lrOMREblM=;
 b=i5a9rgVDIiTJH2x6Zna+rMGZ9ry3IYVk12yXaZjqkGd0ipwbh1qz+uFM8ikkt1K3sW
 rvfwg71e/nnRRbyAS6SWY0cNaUuQQvJuDloXw4Hsbl3y/t0JYlkXFmPYRGvJSl88fAT8
 iYFd7gcPg2MLycCgTnWudsY0X0bnVBUIDIVU3M1mJInUUoE+XWCV1PzglwHNpECPnUR1
 z1eZR4oNZlhuO2X50GB+V2jttHlE4Vq7GcRcostcFnwkqfNj63QmVHiJcgJmCMSaQ0dw
 JP/yQTPjvgy8zJiv+aP+QqMQ2Ba6PetblYCYEnJs/NXdWMYbJDJS+RftkrG9b5MRMus3
 nlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569308; x=1707174108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1cRBtAgGqadhUih0VNs9If35/tfCXiaB3lrOMREblM=;
 b=MkWhUQ5n5y4gDbJlbB6LUNTBjL7RbsZUihdsAXLFXfHrU38EGShHfNxtLW3JUIzZTr
 Oym42LFrMsjdLif66MjU4E3lhU+AaTtqY3uzgEgRndmEuoZgQog/0CmCmF/2MBhDyLno
 vHymHKGL2NDJ4GQoiZh7z6HuY8NjDAlluYcgksHGFreCvxe2pCU95983hXJAlA10pBio
 wKLhVWZPxglebM4bcQjWkPtv6BjYqr6jN8taElK81lI/dj90APhOdcO4GpBANsl3MWkA
 sXrAVssRqjwdlE8Vs9m4IbjlyaORsSy/SlcbhD7rsWlKxUryvD+cyK405XK3Styaiu7Y
 d6Tw==
X-Gm-Message-State: AOJu0YwEsjiyec9x6D1l0Gt9Daf1qObvIG5usxGRoAaoYK99tzVHoL/i
 62kvPVr52yKNtAENESqNKhwILycjIz1jDn3fCJ7J4V/r4Q+ttEl67ZvHir3t2e9OvR38RoMpj+2
 mciQ=
X-Google-Smtp-Source: AGHT+IF5hjK4eLfBJDqxqEY2kQrCH8RgQJ+bIVa1n6TDVT3tEbSY3KYWxOIyJua5WeEe6segQxYqkA==
X-Received: by 2002:a05:6a20:144e:b0:19d:e644:7c9 with SMTP id
 a14-20020a056a20144e00b0019de64407c9mr37092pzi.22.1706569307936; 
 Mon, 29 Jan 2024 15:01:47 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 10/31] include/hw/core: Remove i386 conditional on
 fake_user_interrupt
Date: Tue, 30 Jan 2024 09:01:00 +1000
Message-Id: <20240129230121.8091-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: Anton Johansson <anjo@rev.ng>

Always include fake_user_interrupt in user-only build, despite
only being used for i386.  This will enable cpu-exec.c to be
compiled only once.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20240119144024.14289-18-anjo@rev.ng>
[rth: Split out of a larger patch; remove TARGET_I386 conditional.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index d6fe55d471..3ed279836f 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -50,7 +50,7 @@ struct TCGCPUOps {
     void (*debug_excp_handler)(CPUState *cpu);
 
 #ifdef NEED_CPU_H
-#if defined(CONFIG_USER_ONLY) && defined(TARGET_I386)
+#ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
      *
@@ -58,8 +58,7 @@ struct TCGCPUOps {
      * cpu execution loop (hack for x86 user mode).
      */
     void (*fake_user_interrupt)(CPUState *cpu);
-#endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
-#ifdef CONFIG_USER_ONLY
+
     /**
      * record_sigsegv:
      * @cpu: cpu context
-- 
2.34.1


