Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C612CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyJ-0004nP-QA; Fri, 15 May 2026 17:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy3-0003RU-82
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:11 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy1-0003Ds-Jp
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:10 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so167151a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880068; x=1779484868;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AfoLGQH/u7vouWUL8Ri209Pb6hWKCDmVzWrUSAo9gzM=;
 b=psRoek3+e56fAgS9/zeP2+as71hAaQM4RwEkyFHHEMHA2qedFb+lTCj8+t1s4H/gPS
 mADjlEHFvOdaTG25kIMbY5zxRFq/o7R7IOVEry2DqmatmKE4ZoOLZfJguuIwNXZJUSd4
 hMPlGZbeff+UfiwEfSoSW2u1F/aEKun02mVPOclVofOq1A5EsAGvrfW9lGFUlS9dF92w
 J7ErBzLEODiyuUpgjszEzUAHx/stvW/GgxcsTgCjW58ireeubcckG3CzIPggShEAAr0H
 bduqcRsElwbqXp6VmIwE6mEJYw6YJjZSPkQyr97KHcqgWhgNMTeFCDZQhTVkLTozoJuT
 6S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880068; x=1779484868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AfoLGQH/u7vouWUL8Ri209Pb6hWKCDmVzWrUSAo9gzM=;
 b=UU907jL58vB4ybEeanAlqJm/MGuGnGshlq05gnQkyCJrXa37eM3BsDtvQkcXOrsxKL
 J4++bKz4tyD3xTAL0Fat83NBA5oaMPoxaTLdQ7cc7Zg65Q2V0Ud0X+nGjr+/RB1ceSFg
 EggI9IiZqlN03R2SszeaLtBHtzv62T/ZvsWg0crCyqQ0nEJFTYsLEMSRcSZzqqqXxmJ6
 /ljFwOyFhzTmOBJqw+X6rJ8lzUpZX65u+Mph4tzV9g41/6eHDCscGLVIFoG4yrAiVA/r
 cZs/gvF8+aqeyVpFR74G1EvnetHqxeL0iNQ5BH+jgAh8SzSLjK50B5Oxr2J2ZnGKcSSH
 z1og==
X-Gm-Message-State: AOJu0YyEYHjpuSKntfJUMVXBp91Y/Po1+ucf59Qajft4fmXzQh4nfHt2
 ySM5zxiQNHtD3G5woezvtSpVa6snzN2U9I1Ee0dQaYgqRr5YZQ/lyU4LFDZGjOsJWWnaCyTJ737
 oK+HcSqE=
X-Gm-Gg: Acq92OEOnQYArehuKA3W7G6ffC6v5oREbbumbpPhtLW8wl5eT6Bvs2skT7mdFFjhS/i
 msxAtY+QwNkCcaBZ8zL+tEaGdObbyRlT/0crYn82/VVyCnhh9kOkN5LUGSxr9TbZ5AQDVVeJDSv
 gbVV/yda4w7VoOfZGlqjxeqlWLlFF4zZ/91XyPSh2AlfXcqyVZ4lyZXcWtbDkXYKf5ToifZRA/w
 rWdjeE3tZqdClr39lxB+WbukKTTKnaV8Qc+Y49QWygQe0o3PwyJt15jQMz+OM6uO1jDYZvxgy4s
 IPLcVi1iK/uysyCDHc44b4IQKB+pdV9C+OHrQs2N7er9kGyGeDQkhkCOyywJdV2d7Zdk2hJ2p/c
 F1L1RVRAl8Vnb1hAlaEuxw/BmbZ4aBas/ZhZAcw7WaYkLVmIEYINxHvYwr5LCa3AnZh0YTJmrZ8
 Fm1ZJMXsu6sw==
X-Received: by 2002:a05:6830:498c:b0:7dc:c620:aa12 with SMTP id
 46e09a7af769-7e4f2bb65f2mr3768169a34.20.1778880068276; 
 Fri, 15 May 2026 14:21:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:20:02 -0600
Subject: [PATCH 63/66] bsd-user: Don't write back length on kenv error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-63-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=i2JQpkPEoRHvqVKbgLgbPyU3wj5/vSQRplY9z+GdfhQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43ono7Dcpr7/myBhDdWB20npA5KfVQg5b9Az
 rXV+w/exoeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 AKgGD/sHikg4R1pVhnuKlzptjeDLcIbgZNX4bufl9ehE0OJ/r1TQypIzEVHPcKzO1on0hEY8dlG
 bO4YYFO1JBf5HYy9Hy1bYHnUqgl4o3XbC8938w9WtHE8bFf3x3suKHRLPPKNyrmxlglAQlH3Vcy
 0Nrkw4e8J0+tOjSrlyGBoGWq5vL0L9NAZAujPnTVYuVFlfcYDzNTfgRe76YqAzCBrpBync+IHqk
 H3O3bP7HLELR/U9I++DbCA6adKiAlA5r0jRd+Ch8A2jMNP8dJoJr9tpqritDPLvxrjo15g6kGxb
 yg5Wqz5TIACDleU6o1qbBEsNYhCMKj8NyWdUvqOJQkca342DQHvgj6qG41EXVwupVOjFMjI/QAZ
 8wNDrFs1ld4h2NCk3XJ8rlcdrlvKeZQK7Hwx2MmRlTeQTdf51GDuYqlW6V1WahKdd0NY/1upOZ3
 BqU8Nm+rOQ7+WTYaryqPk/FhHihLKekSbiuxSqyJt2+zIGbsMwurSYAptdSsTS2wU09oryLA6B3
 iAZYus1PEBdqu4divo2R+qO23IHNZwkGtGvCsgjmzHD0DlaGEbZaV1KmZy4AMcyGcR+p67nHEXU
 9muaj1IjJt2LlOq3Hh4e1bErwDy++Hr6UiCkFWQSxs+k52kN5tpBFAmqjDGvRv6dz32RcQxE8wV
 mR04tyBgTe6kjLg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

When kenv with KENV_GET and KENV_DUMP* return an error, don't write
anything back to len.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 204d8ebd3d..92c0a5b4ca 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -480,7 +480,9 @@ static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
         }
         ret = kenv(action, gname, gvalue, len);
         if (ret > 0) {
-                len = ret;
+            len = ret;
+        } else {
+            len = 0;
         }
         break;
     case KENV_SET:
@@ -522,7 +524,9 @@ static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
         /* name is ignored, per kenv(2) */
         ret = kenv(action, NULL, gvalue, len);
         if (ret > 0) {
-                len = ret;
+            len = ret;
+        } else {
+            len = 0;
         }
         break;
     default:

-- 
2.52.0


