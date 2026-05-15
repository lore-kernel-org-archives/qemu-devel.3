Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0DACD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxp-0002vW-Nx; Fri, 15 May 2026 17:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxh-0002lj-HY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:49 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxf-00037G-V4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:49 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-479eb8bcacbso289553b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880047; x=1779484847;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G/KCzsg7x5qFZl3HqqhMHWlp3AjaXSHyyYoipw2u79U=;
 b=zJhlLUSIBQnykcX4jWHTJFr9riDvZYHviRanGBgHIxYKc/PMYX3BAjCU5v+ta9BBKq
 /o3X7Lxl5RdQk9KhZ28b3bvm3OM+e7Ss15aSzBKpHOMeJWKuZ5u6n66cJbhYuZcjYBwT
 hm8Qw6caT/JIZPcnfMKHWOEwW7bXHQAFEjyGOfr77Ipcr6GSyp3I6tqtn1u5ViKsk1sC
 h+RH14DsBp5gRPo7RpY0+XabkihBihOyS58ciD0UyCuvZxqHJ8kra4xVBZskfZl6xzK2
 N/tqd2Nh/1jcplFiQTPji4nqLmc697VnmUpYKvjTEY0x83oikDxnDyhyUqI1AlMwyG/A
 9HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880047; x=1779484847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G/KCzsg7x5qFZl3HqqhMHWlp3AjaXSHyyYoipw2u79U=;
 b=p+LhMBnrqw/7IBCY08RAxVyH7+e+bzNpFBRNcfBrCJzwAF3dpj5Lioivcyhu0WU71U
 eVj0qj60FADfWD3D2Sv6vivtUXngKLtYNpdXe3I1hK7qm5BMWTcLobNMcmSmXN75BVnp
 GN1rDjsRfvKmaSRpF3dA5fu/FhJ3RE6mQ0DB7/XEW8m/3033XqaZYW+GeqYjQ8KYQWZK
 Ju7KT92IAFYSiHOrgVOOtgLsho1H+LJkorX4pIBKISF947+Rwd0JqUTySJA4HGUFbHrF
 rF8pCYy/UsYJ7ZHD2MiGjs6f25BitVVrhkMf2oCikVAHJorp6S5Kdp3OXqc4F78GyjIR
 VpLg==
X-Gm-Message-State: AOJu0Yw+H5pyIfLyBE3dAD7JX3F/gorMtFeoaHfmbDyaJBj1+JRkCAHD
 tiNKk6jWsojNKK8h/Jyy11DaKWQ9f0E51CXuwQSZgSYOzOau+O0POyBFGcO1pEP5TG/vra2Ixag
 gOqz68yc=
X-Gm-Gg: Acq92OHzJ7R2VNmHbftJAfPABSRjvIp6DiEyQ6rMdQVZ29Cc+Voty6TCzLnbXjfAxoW
 z0ctb09eIt5FnomHrIi/6VlFu1UP8GEhvt9+Vmegzsct94Ba0OEpqmYg8DgO0QvgZSH9o5flEjv
 Kj+vHfAA6prmCSzeR0iWE2hAHl8cdD7K8x4SGHPaRrXRW9FFIj4QbkQ8GfDwJkj8HnblIhYzWPG
 w6aqDr4M1yGTzeF7KfaSyWn1gNUdbzdolcvsEL4S7psy94r354n3ITzRpKdZ+XXPYv1ox4Ex8Ck
 Qo1rCmVQv6N/AJWYACHJRDfQjQXSORxFJaXkXGvDNv+6EonNrHf+GoNjgCJOr1gf+Q4bvu12w2z
 OQqFEflPSsymr0XI7UbIHRuBRKZC0UsRhYVm5Ff1FEOK9UB/bw+260eE8fV8l5MDRtlkG2GOAuV
 YBIWa6PKoNRQ==
X-Received: by 2002:a05:6808:3a19:b0:479:d57b:838a with SMTP id
 5614622812f47-482e592cc7dmr4181163b6e.35.1778880046897; 
 Fri, 15 May 2026 14:20:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:42 -0600
Subject: [PATCH 43/66] bsd-user: Fix problem with extattr_* routines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-43-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ndqCsfqTyWWD0s+vY64gwhF6zYhR3XOoViCCufD0HCE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43m5XDLlSpQGnXELK0zPXP275K+3heS1ldNx
 HDANwSQzsuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AE5qEAC1tBpbSaHNPkZ5Pp8temwx1Mdm/gIH59z0+YwwpmRmnik3huqAy4XOFsgfR4kYUB9VLyN
 MLjVPIyeChGL1kTL0gbfMT2VsVRFsxbCJDBexPKD1IoSj7GM/Jlxw4Cuifj+v1QCP8oTbX5VbbI
 Z2UEdekVbpxhExGfNsxiU2URUdW58CW3tgOf5Awp6yeZtben47CDMtLplYr0y9TzpK4cfPRzQWK
 XA/7WpjbDviCdwQ7HcxPc9cGy6rsJqs8lr63SuTaW/4d6ZfCGEXM6n29fJO8jYQ9dnb6PRx23Jv
 AKU3hbLfUCNOBVMtDqNdbyCjRlwuH5kJRHtZHpXKzg28hh1ObMY+Zp9smBmJWBoDKYRuGMx8Sjs
 vpgSxDkYbsTSev93K5vMEmdrJnvEOAcu0fnuCplivYAc8cjemt+d3sBa1GuNjUiKjLG4jZmC+ZX
 UAQrp+8QWTlHn6NJQxhW8YrDijQBoJx+s1jc/mf25zhp7BhAilnSnD2QKybXc+I/ZLCsFg7OUH4
 yzwB5uqWnSznSMU5YtphH6Eyfr8yhQKGfsAs3faDuRgAj8yHzn+Q8s3IbbZ+WSdit18MFACvRAw
 0desTrAU1OD7vLVJTHqwNsXrf/pZ2GAwsGEttacPpf0WrMlKj74JGVLuruRNWwBaSAEe8j3eYDp
 UbxSfUDfD9DnWsw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22b.google.com
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

For the 5 arg routines, we need to pass arg5 for the last arg, no a
second copy of arg4. Claude noticed this.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f430806e05..f1a49ae423 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1317,11 +1317,11 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_extattr_set_file: /* extattr_set_file(2) */
-        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_get_file: /* extattr_get_file(2) */
-        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_delete_file: /* extattr_delete_file(2) */
@@ -1341,11 +1341,11 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_extattr_get_link: /* extattr_get_link(2) */
-        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_set_link: /* extattr_set_link(2) */
-        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_delete_link: /* extattr_delete_link(2) */
@@ -1357,7 +1357,7 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_extattr_list_file: /* extattr_list_file(2) */
-        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3,  arg4);
+        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3, arg4);
         break;
 
     case TARGET_FREEBSD_NR_extattr_list_link: /* extattr_list_link(2) */

-- 
2.52.0


