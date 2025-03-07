Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB26C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsc-0007X9-T3; Fri, 07 Mar 2025 13:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsY-0007Up-6G
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:02 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsW-0007pM-MZ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:01 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso4392832a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373819; x=1741978619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6baNnWHy0ZHd5ntn8fAFXTjSBc8gCrPqSjCFJWFWZE=;
 b=i0Dn61+wwzXEWZqVaoCZBDJWOvSyoL+WT2hB9QUF3Iv8Il/uV9bOrDKAPJbp+I1ZTB
 8KxJpPLVe1QfNMKFvLI4XixczQPBpPxFTPChYRLgH2baPaqlS5AdukofH04/C6JlZINt
 jnu2yswjTEpht23kthkQy63q/i8rbdYs+cFmcm7+Yg2LQmBIKMA5VozqBYPn15gEyfWW
 XPddsURD1/6YXl3EROrd1FcnjuQRaPl6tpnRIjjhPOMyKJJWvb50pTQsLLPRixmnJMg1
 KKQYscx2GNg7nwqKa0Yl4ujOKaXWKXQ+AZDuHSLqOCKX2sczrmy0dqexuK2o6zWiPnIR
 Cjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373819; x=1741978619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6baNnWHy0ZHd5ntn8fAFXTjSBc8gCrPqSjCFJWFWZE=;
 b=HupBuITScu01Ly5FnJMV598J3YtEFqUQtlJI1nXwFoR2EXSfLoWqUB7QZ8iTFNfr/f
 3AkctwGmECMFTW54A/GU4l5Ce9Yv9ssiDyg0JIGWLnWJfTBcQ0rNJKsqy5OoNzxLttu1
 7YbtAcx2D/H77Fu805Oj9GPw6IXyFYZmnZl85MbYEMNYBwCypI6wcdP/s8xiH1lxFYJH
 rL/zvI+DcRNURiNSA3qtJ9s6DNfcJeq37WfZWdnz7T3XKhEYJcC7plsFTO5VjCjdSIKz
 n5w59nGjcq3L6erjhiVkWbh2S33qmJfHX0Rs6K/nM2k23tYU8IqKKVQwucYeLGnThu9t
 4fjA==
X-Gm-Message-State: AOJu0YzkaegaHaTABafR9G1h1BmSLQgmjBsLPMO4cd6EvbgNNahgC1VT
 sDrF7M/Ekp0P0GJ0z5wtkgI1ujn3OToqKkNXE1Kwsx3MiwA0jof8To1QX1CUFdDWggbbE1X3bE0
 3
X-Gm-Gg: ASbGnctA/B03jPyU+js+3QzFGoYntuFnITjkm3lsMsu3w1VYDEJ8w+fIiSQvD4iN8KE
 97AIAfwfnuLnZ7oHHDlwWDmg8wAptfrclMXNA4JOGxfxCxOEFr6N8OLBvNBqjdRSmuLhO1s0H8A
 aOci3kXrSYdyDkS/pndiMRWyQSRFGalQH1BCb8EIh6klyH9rhxNuZjbTzOBrpV83Da7L7sIbHdp
 scz1HHCQd4WLS+x7ORtY82NgEEqwHNtI8IzxdXd05fPPGt9uQpQrXQzZH9bwgWr1buJEhebV+qE
 gvfnfT+mVTk0sjx8k0HCZv5ZnhMIutTwHarcdkGFbN8R5a5QjlYQ23Xa215rXDWLnZ52Kk4GSfU
 a
X-Google-Smtp-Source: AGHT+IFsw/XOvGJcwXtADDB/hFwtkZ12uAkErnlnwZWRixIpMVNGa5K0GBDNKuSaAegrps9pWFZafA==
X-Received: by 2002:a17:90b:164f:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2ff7ce596edmr6719118a91.6.1741373819313; 
 Fri, 07 Mar 2025 10:56:59 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 16/16] accel/tcg: Build tcg-runtime-gvec.c once
Date: Fri,  7 Mar 2025 10:56:45 -0800
Message-ID: <20250307185645.970034-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 accel/tcg/tcg-runtime-gvec.c | 1 -
 accel/tcg/meson.build        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index afca89baa1..ff927c5dd8 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "cpu.h"
 #include "exec/helper-proto-common.h"
 #include "tcg/tcg-gvec-desc.h"
 
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 411fe28dea..38ff227eb0 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,13 +1,13 @@
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
+  'tcg-runtime-gvec.c',
 ))
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
-  'tcg-runtime-gvec.c',
   'translate-all.c',
   'translator.c',
 ))
-- 
2.43.0


