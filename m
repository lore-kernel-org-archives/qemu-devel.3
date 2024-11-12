Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26C7D42BB7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAupg-0003La-L8; Tue, 12 Nov 2024 12:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyO-0000LU-5B
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:36 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyK-0007NS-5h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:34 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cf0ffe6db2so100652a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429749; x=1732034549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoPkJ0wMhnW0S/o/HYXprlPhCaTxkHpkjlxptT6glCk=;
 b=ZVkF99iOze+yRupDJ4SD/IA4OlRespi0F3uOnXJhF3LzxLOoUaw8H8M1NLcTCSl0Ei
 sgtSJGpZZLHXnHH6e+HPRGvnj6NZR50p3+a+p2HwZjDNuIU3qITKrs5iZMN6iZH04lt9
 SxSOa0EMocwFh/cSYLAa0DfYNnt/dtOBrSLN0bzqdfHsKNx+2Sp0Q0jtHgAz0tuvWycW
 UnbjGG+zUCmIIczSICiBhgB+vIdpOBFPqvHyR7fhRk5cUErjRlFudfn5HtcoqAwqUsN/
 Uf7mZJkguTewITWmzF5DVav9kzFf+QC7RQIJ8zHF2QWV9u8r8f0FUQiY7mU7vRUNZYbj
 23nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429749; x=1732034549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoPkJ0wMhnW0S/o/HYXprlPhCaTxkHpkjlxptT6glCk=;
 b=koeMRu96/O/1luaavKRwnUFPtnJQ1sc4E/OYBU4XH2NP7NLUonMzvxLjrF75U0BmvB
 gbS5mnWQVInYMuSxoP8e88ZmEfe9+NHptKevbDttpnrVtiobafJXhhlQGJZSrVnZTF3F
 Nsj+1b6QX6rNHpu6tRBfzdVpbaXj1SJjnaucx1UVuLu7w7ediLoVb3/9D6BG0QUPWxMZ
 z32BqPuuQZNMo09Yyu8CWLvhtwzLZWYJGAwrazZkl5MsJK2lt/jinpnfCusTraB359oF
 +vLNJs9y5Ta9GtiQ3ieIAFm0oGLz8nyfZsxdYRquHyxQzussYJjSiw1d2EuFyq5gS7Tv
 k6Jw==
X-Gm-Message-State: AOJu0YxPKPlaeT8HPynuQeM5u0po/WEG9BibrRf+22Fs9xjHiY4MG02r
 3+9VnYdVFOoRzEyTwFmaBaJNrCK15Ofg2BxDZ0Z8dGJ5jqJz0PP2QkF7T3YK
X-Google-Smtp-Source: AGHT+IGJj/z6S8yaqnOsrJ21WuYaAXFYiVMMms+v8ua1iGSfU3TLEhGWqFDWdQas1Et6WgqxGzPpWg==
X-Received: by 2002:a05:6402:210a:b0:5ce:debb:6446 with SMTP id
 4fb4d7f45d1cf-5cf0a446838mr5524957a12.8.1731429749233; 
 Tue, 12 Nov 2024 08:42:29 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c8130dsm6137004a12.88.2024.11.12.08.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:42:28 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, pierrick.bouvier@linaro.org, berrange@redhat.com,
 Faraz Shahbazker <fshahbazker@wavecomp.com>
Subject: [PATCH v3 2/4] Skip NaN mode check for soft-float
Date: Tue, 12 Nov 2024 17:41:28 +0100
Message-Id: <20241112164130.2396737-4-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 12:37:38 -0500
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

Skip NaN mode check for soft-float since NaN mode is irrelevant if an ELF
binary's FPU mode is soft-float, i.e. it doesn't utilize a FPU.

Cherry-picked 63492a56485f6b755fccf7ad623f7a189bfc79b6
from https://github.com/MIPS/gnutools-qemu

Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 linux-user/mips/cpu_loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 462387a073..07c1ebe287 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -304,8 +304,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     if (env->insn_flags & ISA_NANOMIPS32) {
         return;
     }
-    if (((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
-        ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0)) {
+    if (info->fp_abi != MIPS_ABI_FP_SOFT
+        && ((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
+           ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0))
+      {
         if ((env->active_fpu.fcr31_rw_bitmask &
               (1 << FCR31_NAN2008)) == 0) {
             fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n");
-- 
2.34.1


