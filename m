Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A5DCD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxd-0002VS-UT; Fri, 15 May 2026 17:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxc-0002QO-Py
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:44 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxb-00034r-7X
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:44 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dca4debedaso351868a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880042; x=1779484842;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h+NVhjFIiLtaVRihGXIH9ttcpzwmJB5APMopVO0qrs4=;
 b=bkKlu7rBz3FSY3+PHt5VqUWvxcmWzMbVZcqZmYmes1jv7RdU/A/B7vJgIAaPcGCx1R
 8cG9RczxONq8b5rT17G5bgfoPyyYqMG2OPyvYfQTQ1Lb80pu5PuTxV3DEHnj0fybJkXj
 CvuR5AwZdSUZucBYmHI0M3flE3aAtlHR3CpHYtMqcvfGlvliI5GsLlpv9DBPVoIBhRW9
 noYV+6g2c9YwNkHakOqTfzny9FtnYqN74OXeKN2gTqhYvKAvsGZUf+J16q9KkOZAhr/C
 KjLcUqEQEQ8pyoln6vo4Pt+WJXVY+46e3T5MURQcHSxdBJ7YdWqDE3pIb9nrkTRQkgri
 koRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880042; x=1779484842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h+NVhjFIiLtaVRihGXIH9ttcpzwmJB5APMopVO0qrs4=;
 b=IQz2rExsVSB/mQdPO/RQb+dcUzeTDBM17kVqRPVi0uyksvt5s2ELAQhya2WMlJpZr+
 MdArEOzMW0EBIcEisVVCHyxiljrKTyTsyYVSgApYaN8yssLBW/jNCQNrg9WzyNquI774
 Pz+8TxOSfIzKb0frWMp6j0oa7FP2vdmbUTcd4u0IhPy+hGe/VCNIgkz+8WPk9fGwHtBq
 L8NQPRn3YHF+QSSTPYppzeAz/e/UrDXyjAyZx+W+mwkorRAdaVKUqfCN/R+mmqqRyfu+
 uIMJBsVTORx/MCfZ5uOn2ePCpxnp7MmZ7uKA7HJYXodZBz0TAyvUIwtqBSMk2Yvfwwx1
 A/kg==
X-Gm-Message-State: AOJu0YyVBcZVAEXNhycjjovFOBK98ctI9gbTWy63EPgKKnuf8iA54AIK
 Mydw3QWGRrGT3/d48YH8StV4UGKMqH49gdoEKUXS7gPTefEM1QmOoUco+yktpBZaPiZrMLIVpiu
 p7P6wui4=
X-Gm-Gg: Acq92OEbLgdsZ5cF2lE4QR4ze9uYz+IQSO6JdqRgbrdS4nwBbEI7sUeXOT97tf63SMv
 On73JrhISABVcMZDYgvL6ySk117nacHIir9cZ/+OmxbHDoFL3rimhZbPBkkYC9CDT4GmNdvrSLj
 YXxN5nNWCfIw/xidnsOXAGK74zDDw8AWQ4TEo6MmzCUcv95TZsyPAE3SDSJDVOVcGEZRpWwnLdA
 MWZryLNqUGALC4u5FyxAHWibuefSVQXNK5b1yYTOfSbknXXIfJHXvxJ7OVUNbI78ipPhsZcCYI7
 5WaqU0faAhYXyhhV+rorpHY6YACEhY/L1/V0+klii4COQ7qYTgWsC4BuR/nJPszFYnqi3yq/QpL
 /nHCHmeytR9VetR9R49sTznq/x4fFbz3FgCcfSb3aEFABYGkfLBeTwpE1Gt95/Sng/+Qs4xiBeZ
 4l94Qp0MxwZg==
X-Received: by 2002:a05:6830:6183:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7e4ea06d27cmr4105805a34.5.1778880041864; 
 Fri, 15 May 2026 14:20:41 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:37 -0600
Subject: [PATCH 38/66] bsd-user: Remove dead watchpoint code from cpu_copy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-38-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=/Sr1aqgifLh2JvKGGCVN4hEJgEcNvipkIFC3FyYSfs0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43ls7NH2S7tv+dYyxCU9WlAZugwLnTY3ngKu
 5Poboh7m4qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AB4OEADA+wQpo9/dusIadPDFPmRWzLgqlNbAej7LSQrVJRyueAYwx3BBwdimZSYLrIWvDFEFZzM
 jiNJBk8CS1CQpFFnO+3zAtPiuNRts17859kzhSfVWllGxAamorjV/4QiN7QCz6vy4pqcAxwePnf
 ueeWepmGERjEBrM9QkHgAhYC0t+LfDx+xqpqRYVc4qT2v2fjo/0M8mYgZV36I4PfRUkMJIAQXKN
 lmCdTr2y9w26YZzzO9chJ2bSjErQ5c9in6KLrFVGiR/j/wPWGYJfFE8q1lq3ga825ZWpm+Ki31h
 09uMWE2VQt3TQBd33MgFVvU2k/hVmbWkMc4hsmqgxRWBiSeSQwPsVedMW92rCQLmefEGntFa/oB
 dUMX5fIhNAJl0FdX/LyI8dyQR15aFNgP+lDiOPUYxWHJL4IiSkVy4me8AEWYlWZDHA55MaGBTIF
 T5eC6kgT1uiFbZnd9I5JZBHB63BSnJ13FroplGjXzP2iEbEH/+GqnAm+IKgKHwyoeKTDcZsXraL
 F4Jp4XQYFdkxBgmDEeaD6dLEgUedbrFs9uXhcz0jEYCNQhSxEL/W9kQUNSa41ZLzjNEFbNNCO6N
 kFBUvKaeOCKdh/bk8yn0TyFETQ65LAfu1FYH3yNq/fDPshyjyStieYYny+KGIjAgKcU5cgqvTL6
 QG7CQM912YEUnrA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Watchpoints cannot work in user-mode emulation because it requires
the softmmu slow path to detect accesses to watchpointed memory.
Port the equivalent linux-user cleanup from 48c8c5e886.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 415852d88a..a79ee52cc1 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -233,7 +233,6 @@ CPUArchState *cpu_copy(CPUArchState *env)
     CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = cpu_env(new_cpu);
     CPUBreakpoint *bp;
-    CPUWatchpoint *wp;
 
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
@@ -247,13 +246,9 @@ CPUArchState *cpu_copy(CPUArchState *env)
      * BP_CPU break/watchpoints are handled correctly on clone.
      */
     QTAILQ_INIT(&cpu->breakpoints);
-    QTAILQ_INIT(&cpu->watchpoints);
     QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
         cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
     }
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        cpu_watchpoint_insert(new_cpu, wp->vaddr, wp->len, wp->flags, NULL);
-    }
 
     return new_env;
 }

-- 
2.52.0


