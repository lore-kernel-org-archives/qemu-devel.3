Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC4CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu77u-00007Y-5j; Thu, 04 Sep 2025 06:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77q-00005o-Du
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77g-0005Pt-Gi
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b88bff3ebso6228215e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756981397; x=1757586197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sVOgytoa7Rgm1zLxtei1J/KNHixNy8iKKKriI6vpRg=;
 b=yLmuIn1JM7FLfL+HRbYk3qaXbX8daSlSvnr+KnkBbNJZyN/E8KJ7IXhXo/BaJ5herr
 4bUNrXkruwHpXY87hhxnzLUxtlIIBUCBFMP+zHmNCpvcRCq46OAYLA7a5yOdt0Fj2/46
 VBjTY5vG50dHCDWtuIg4F0S0whX4rVCrbbimZlJWP1vtyGaRlXdDCJX8Vz76+qYaPKBx
 +kiBHsbGp5ScZv0oeIrjn3P4U3vjRj76rYi48qlK6FOct4UaK5WL8H0Jv71deHE6kFck
 mS8kR6NJs4QiQi7HQ5MToDHdS9cnKwTAvEirs3Xt38RU1qHakit9EsbhfZ09v440xCtC
 Dlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756981397; x=1757586197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sVOgytoa7Rgm1zLxtei1J/KNHixNy8iKKKriI6vpRg=;
 b=XnEneGdywpscIcZMNQcXiUWVOrIqrjYSYpD480c8SDu6z60P5zB3zMINk/FUUnKRKd
 aHULSN1JHnxuFYi7Kiz0jySHKoOaLpJpFsnrUbCTiSIlHJtxLzkh/BND+B3V4ci5v73j
 67P75AV4UK5WmsUKRIl8eQsBugFVYDrbEjcFSoclPDbgyzRsiRP9LQk0gXT718L57HAL
 +QV3t+Rqa5PTjd0DmMt54I1bJTfa4vd0mjuLpfg/saH6wWEKmmEmfhfCKV+dtyaiAkKY
 Zo4DFVkpD3UcqKqGPZf/OuzmaKlu264x77hCroMYLQQDvslbxgZkCfmUntO2yWphaFiV
 dqwg==
X-Gm-Message-State: AOJu0YwcQJI/+SKBx9PyEZSSyHny9YhIGQn5ei0ueHcIgc0VdsckEFrJ
 noUzu04JzIwHulxS+w8VlolsysN1Zy2GMffsiM7C7fKr84lfeNX8ijDSfAYAmCvl2G/BV5rmq6R
 a0xNCGr0=
X-Gm-Gg: ASbGncv7brxrjvimaq7T8bdSd0rCVe5lDatOJq/vKqvpTxKeMH869yj9beC2QwACgzi
 R3+ToKhA8c6HSe4hN1LvJ+VUpiVPRtgN1LPZRG7PJxJPwF4yP+MQZjSTvocsggSiJPVJx+NCJL4
 TbOi7ZFtlZkJthAcyh+UkcSY8yuQWTgjkgBrXt8OjOU2Q27uECdxyx1Mgen6dMO+P1znFWXJ47U
 Grwq/xcLQHbCB22JCViJfxE3nfFRo/vGp2s7Vix1z8Z9wdDgPb84XscLmz/WJrNteIxku8l6Uxq
 mfRX15/HRKSNIZ+cln75365KNzzOIZbL0EolH3fuFKO4ueyYEl8gCwCNISVKAuEmjOvGhAM+Zpx
 eALYsDLSVnZB4ciXoxCogc2uTmIff9PgLJqn+kGjyLSif5g==
X-Google-Smtp-Source: AGHT+IFZW6vFHa1/5Zvt0YCr3p3OJjpJkvyVRye0Tf4v8SzY51P8lG+wjrPKdNKOI+8V+VKSf0EByA==
X-Received: by 2002:a05:600c:4711:b0:45b:9c93:d22b with SMTP id
 5b1f17b1804b1-45b9c93d49dmr59874235e9.2.1756981397275; 
 Thu, 04 Sep 2025 03:23:17 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm147699195e9.19.2025.09.04.03.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 03:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: floss@arusekk.pl
Subject: [PATCH v4 3/4] linux-user: Populate vdso_sigreturn_region_{start,
 end} from sigtramp page
Date: Thu,  4 Sep 2025 12:23:09 +0200
Message-ID: <20250904102311.57383-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904102311.57383-1-richard.henderson@linaro.org>
References: <20250904102311.57383-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

When a target does not support a vdso, we generate a sigtramp page.
The only thing on this page is a (set of) signal return syscalls.
We do not need to narrowly restrict the vdso_sigreturn_region;
simply record the entire page for all such targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 28f0909d1a..1370ec59be 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1974,6 +1974,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 
         setup_sigtramp(tramp_page);
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
+        vdso_sigreturn_region_start = tramp_page;
+        vdso_sigreturn_region_end = tramp_page + TARGET_PAGE_SIZE;
     }
 
     bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr, info,
-- 
2.43.0


