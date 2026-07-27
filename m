Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805A6C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNs0-0003BG-LO; Mon, 27 Jul 2026 12:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1woNrA-0002sy-Kz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:07:18 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1woNr6-0007h5-5i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:07:06 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-51c0c45c580so19250231cf.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785168421; x=1785773221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWDhSCatsvVBgysnE4dKyrZLegQikMTZmIdP+bsvfx0=;
 b=LlQQAkqi67NWVG2uqIO8HA7J/nx6gxs25BTANJRnwFe8X2D2nQb1PvjgItPAhoOfVC
 8pSa4gfNwxbd/naNs/O7nAIFzlVEQMNkAGhlQ8BYEPOT9KyWDBKuV05kYLGue2y3GiH6
 xKRI3KkaQCblvfW/QyObYe3Ws9Cq9ZRibyiebJPQ8k89bF2AUhzOiERpT/ytb77R8qRQ
 1rScYfpPNBIa3BMcGn1EytV+TpX1+D61A4rhLCJBGVely3mGei3CCaWier1Qtpx1DeIO
 e5BfC+EuHrwG1oY/W1V/nM/yK/bzS+MJQ8iTdrUPhAC6KqYNKZtDjPY6t9goQ5LNT4qq
 hnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785168421; x=1785773221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWDhSCatsvVBgysnE4dKyrZLegQikMTZmIdP+bsvfx0=;
 b=PJWSfgoFROlcmYfF/3Gg0lCwHrYjbpHli0z9BviveJdwhV1XFb9k6GorrKFQaq9Foc
 bTcOFNmID76byd3SB0LAotvy+H7XfBPr7I1auhyF4jrElhnMwlXnOKSVXYhnuMiJsN3x
 0ul6+ixAyf4aPAv62ozn578osQeoBqxUvt+5sk2WDP23JADNDKeRjMDtsw2FVeucEzT9
 fVI3n5AVZXUUafJ89pr2SXa537RZk2ua2NwltN0WgTGj5s9wBY7jqjkTyr7GHKxMDMJb
 NvjYBO6MQn3AZO/ypAr2rrS9Ime2pbFnsJg2PGwHq88ekHXKkKos4l6DK0MPFwCm0zWF
 gFzA==
X-Gm-Message-State: AOJu0YzwWZmcHZpaeFOu5EMF7OKjU7l3T2jL4HuYLnk6Btpxj8fq9U8C
 nFX/oJMealTetOVs19SsP8196bp8e3KFt4VacrZpLIvOQJA5vO8RKr0/ea0hrA==
X-Gm-Gg: AR+sD109dQXSNbSFSwSYvS3vmsP6bJ9NFENuyohv4BwotOWUhPG0VX3iuKA7YFoRfR+
 aOX8LgcsXppCWTc0ODomsAwh+ag6m08Ti1N7ZeKnkeWtHyF2co19xy/J1R++Wt7rUpCSNaG/013
 QLSEMbpqAp4DYq329GPRugpJRqgd5AHyvJ3lQTTzu8CyNJ8ecK24rHXaoryt2LqwGeYGALRqrpd
 Pmn3E2fCN3GJp1MVbNlzeV+Fo93yZHij/7+mbAYH+vSVZoQeku5gVnJUcYnME7Fz/R1PCW4Kjqt
 2uUUAeHTEe4dcyEV7p76o/BOXl21vK9bSDK0qI8c7wA/KwV0bQlniY8GBHqFEjqE0+8G5oUYNXk
 sfeoOpRB72bITLSVkKy20M9xCRrmstOxUJ0tG+5+xxbMUKt3aeNLeqHdpB1mS7LCcEs+kht0xJz
 7sJ5qhcNKVHce4XkB2CSU1Nhn7P1gFko8qYSkM8KdogeY=
X-Received: by 2002:ac8:7d16:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-529d176e899mr1511121cf.30.1785168421168; 
 Mon, 27 Jul 2026 09:07:01 -0700 (PDT)
Received: from localhost (host05.distrikthotelips2.d.subnet.rcn.com.
 [207.96.107.85]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529a2a0b23esm57156631cf.27.2026.07.27.09.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:06:59 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2] linux-user: fix guards for the fsmount(2) syscall series
Date: Mon, 27 Jul 2026 12:06:51 -0400
Message-ID: <20260727160656.2821120-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=mattst88@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The fsopen(), fsconfig(), fsmount() and fspick() implementations are
guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
macro exists, so the guard is never true and the entire series compiles
out. Guests calling any of the four get -ENOSYS, which for example makes
systemd's credential setup fail with EXIT_CREDENTIALS for most units.

The strace bits for fsconfig() have the same typo.

Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscalls")
Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/strace.c    | 2 +-
 linux-user/strace.list | 2 +-
 linux-user/syscall.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git ./linux-user/strace.c ./linux-user/strace.c
index 3a81cc95f4..af1cf9548a 100644
--- ./linux-user/strace.c
+++ ./linux-user/strace.c
@@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)
 static void
 print_fsconfig_cmd_name(int cmd)
 {
diff --git ./linux-user/strace.list ./linux-user/strace.list
index e363892e0a..ba1c1dc0ae 100644
--- ./linux-user/strace.list
+++ ./linux-user/strace.list
@@ -1725,7 +1725,7 @@
 #ifdef TARGET_NR_fsopen
 { TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
 #endif
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)
 { TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
 #endif
 #ifdef TARGET_NR_fsmount
diff --git ./linux-user/syscall.c ./linux-user/syscall.c
index 3da5530d42..740142825d 100644
--- ./linux-user/syscall.c
+++ ./linux-user/syscall.c
@@ -9740,7 +9740,7 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
 #define __NR_sys_fsopen __NR_fsopen
 _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
 #define __NR_sys_fsconfig __NR_fsconfig
@@ -14485,7 +14485,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
     case TARGET_NR_fsopen:
         {
             p = lock_user_string(arg1);
-- 
2.54.0


