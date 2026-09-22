Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236CCC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964I-0000qK-Li; Tue, 22 Sep 2026 15:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963b-0000Xv-1i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: from mail-oo2-x1b.google.com ([2607:f8b0:4864:31::1b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963Z-0002OB-H3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:34 -0400
Received: by mail-oo2-x1b.google.com with SMTP id
 006d021491bc7-6c72bd8a02fso112465eaf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104892; x=1790709692;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CccOh/rw39PcDyv2TBNp+uDQws9Pq5eD14ZTcp8m9SY=;
 b=rJUr2zInGhwLdBtFMkVnGL9XQmBvBrp2DsC2ESy+J4egilkMwStmGxb83FbuJ7Lh8b
 HGfNybqCwkZeIQ4W7+r0udim39G+/oexlc68QZVFR+zI+qPISjtrTACrUBfqso9HlKXI
 LgioViRcoJVoIs54sQIFwru3NKCpGIE+AzLsJStwxi5IWAblcccTHHWd8QRrzLaMINkD
 3V+LdykDjDeR2vE0lT4UI4cmPKGuZ/DebO75YFbiuGWR4FYi0XOZZBMtMAeQ3/0i9GFP
 1ApfIMANXAb6QgfdkyQwcHOOmM5gkp9sGvmDg7yvQdemB8+syGBizLgplh4lPPMJ4K3v
 l41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104892; x=1790709692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CccOh/rw39PcDyv2TBNp+uDQws9Pq5eD14ZTcp8m9SY=;
 b=CMm3fXvYb84sIbBO9p3gcTVMbbgUD7yPqSK8eUGyPIf0zaR6bM3tE3Yr1jzGHDQfJM
 3fq+sm0zMagdQAlbdVOrwk3JERwUF07wA5ZyiLwydISk6cGM/mntbObyT3MQlSUHlMwF
 RuE5tCEqd431EgMqP01E9DyfMdUIJTbLOkldBn2zHFhDJw6Aj/I+1r6mNz6KNyceOTW2
 kVN1kXeOYdx5a+TVmeno1cPlK7o2DP4HG/f339JpxnsIiHF/0Xp6swt1fZBhWFN/DmN/
 X+p2QW3j0YxnV7x+7VqRz7bsRZZN5byF3Y7AE4G+tofr9J+jBsuDRYhG0WJe90GW04Tu
 DHog==
X-Gm-Message-State: AFuF++mnjCmaw9+cKzkjvL2Srl1wo6Wi9JMEc2qHPddxbjnxGzdntcHi
 dY9wJ02cUjuDTxqB7JuIUxe/bhAgKfDKG1648RV5PIqOVfWTa1iHC+Q6S8D7Cmbjt80X3IVAihl
 1REdgHxY=
X-Gm-Gg: AYBFou27RCnPPEsbFrL4nQuyOpVFz/E5hKxpdR8zTvFHvKI7S4vC3UD587JIPOXtdGQ
 1hWRFl2Sf5qExS30xDDgAviJxA/92OaQiscAfqMxzXEtwVp+0ZwLXU4Y7hd+loHRSfdNxETS8Qm
 ZztD1UrDlhbXTaGt1DOTS/4peXJP/cZFY5Us13OljB8Pr2RXpSrzNIXWbI1LwLe7PKuSIrfAIHP
 ZB/btY6KOWVCzx1Hg89gyUEmAhQcb3AhjdilneI/aaAsSSa/B+8HpF2ZmJDBrTTEmUdXFuxgbsw
 2W2a6Tn/9EnKERG3D2kH0iWmU2bxxQivgI2Jc2JX83/N774U6FJMZL/xbkcYHSkxEzeW2BzOzof
 UJ+1WFNMFcvgzqRVi51FPxRluJD/fQuJ1EcJjR1UnX+Yv6aIy2kWQnCn+Lh/JqwDWrodmZdmVH4
 bWQd9c4KkOyUx3bgy1XSQTvx5jOkvnQx+rJFfz4PzafdcVtJcQMtHr8s0HVblSt68daJzb
X-Received: by 2002:a05:6820:1507:b0:6c9:80d8:a1fd with SMTP id
 006d021491bc7-6d2d230abb6mr401015eaf.58.1790104892409; 
 Tue, 22 Sep 2026 12:21:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/11] bsd-user: Initialize per-arch child registers
Date: Tue, 22 Sep 2026 13:21:02 -0600
Message-ID: <20260922192109.98467-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::1b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x1b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 15872f03fd..eaab062d3d 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1629,6 +1629,9 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
 
     new_env = cpu_copy(env);
 
+    /* Init regs that differ from the parent. */
+    target_cpu_clone_regs(new_env, 0);
+
     new_cpu = env_cpu(new_env);
     new_cpu->opaque = ts;
     ts->bprm = parent_ts->bprm;
-- 
2.55.0


