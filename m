Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E8BC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 04:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAJi5-0007C6-BT; Sat, 26 Sep 2026 00:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xAJi4-0007Bx-Dp
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 00:08:24 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xAJi1-0003kF-TB
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 00:08:23 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-6730c3bdb35so973191d50.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790395701; x=1791000501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G1/6L7zFRucLyE06BWvN8kaFjslq8xwpqPU7To1IRo8=;
 b=SrkTiLM/dXzZiJnY89/f/XerPeiHFORkYipwjeQApWYco3M9MA0J9x2yE3AEaBAfAD
 vOyZqvWirWfPwRNVc4aqfNPPFI3zmjtpwTSr27PXGzWuBnOqfs7V0y3GudyDHwtydiFq
 iHO5FHCqQ5II2F8T7ixoCX752YmazNyCU3ucLghJmq0NE2G/lsUkBKXSvbcH6gud2D/2
 Izr30ec3THuE50t6xwWDOomM2wohwnfiIiWw8FAsnPJl3TUGQ3hj2wl4waeadvy/ygre
 y4u15/KwD7A97hxJp19A2/UwnIDi2otnGL4yrnRyDel423A4t7Ohzc5e5jhp5hJYg/ft
 FuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790395701; x=1791000501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G1/6L7zFRucLyE06BWvN8kaFjslq8xwpqPU7To1IRo8=;
 b=zVzv08uUiiZTibqQzmte3RunMDYOud828l1laJR6fUb4MIiqLYdKO75CXTO6T1nnz/
 ANIwKVrdKnmioJv2+2X8ari8WKy2WXcm5vdJdPBgajqbLk11Dh2d/ICrphjFFDKJfMVR
 /MDiqsMWiDnSZQT3x4zaE3vim07NG6OR+CJSE5KFCfIC2nvWIP2vZwuUu7rtcAgfFzNT
 PN6dg+lCDI0zOihaHr2OVvmJap4Hf7+KrTMVpQ0tGh6ZJ5GHWrMkES3sjpscRrwaK2G3
 Ngz8LZkzDB7OMT23FMfWqouUle8BEv3JjrAsM9Ns/YBAIXXgTyjfNmpPckAM6vj16hnQ
 bFYQ==
X-Gm-Message-State: AFuF++m8cJSOcByXPIg2POrIU/gDN7RP8SHsBYKvypsuKc+jKDFufiqj
 Jminw7NUEmeDWYk1KrmaV6d3JfvZH0qowGRNRP6Oxs0hBDeyu/3ajcuzIjOhHA==
X-Gm-Gg: AYBFou0Zyd0rfEyJ6W1EZDyRXZIg4iwup/wrveN8zTEadk19EF3019oDTNT1uB/4zEf
 4TogFNRFuD2f4eeBKLwlCc/p1btS/gmgKQeBp0k9L5QUd1iAGwfuUwOKmTcYtqbeD3MZ3eBo7Mz
 xHgzj/KRsUYDdL0c7vHwbM+2zZnnc6OL3sLLR4buOxdfSuFLb/eEZt+yPkm7MYpD0rcVMjA6Fo0
 X2xNcMWXvMzEiKY8t11elnbdMzDyIThI2+qGNRXumDC1SrZbmK4XkPy2/PbmQSXvd8Du2A7hFyP
 Xr/EzO4fE8sFnUNTSepfu+E20c/OmwnVRIVOBXDDh8jFMDFD2QsNHgkHlJsrRzrm+7aC0VYOFbo
 HdY3MfXjq69HsEGhGdm75Mq6U4nbccTXl8MctJTUbc9J0mri0G8yeip0VQC2rzvO7uDmSrQBWkS
 9ruhEmjlNRPetAXWgx/SVjb4J2/C/BMQeJvgFdmfUhJEnw5gIudU0xSUdslWJOTHXYt1AoRbg=
X-Received: by 2002:a05:690e:4386:b0:671:3e0d:68 with SMTP id
 956f58d0204a3-672ed2b603dmr2350509d50.15.1790395700587; 
 Fri, 25 Sep 2026 21:08:20 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-674e5a7a556sm297111d50.19.2026.09.25.21.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 21:08:19 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/3] linux-user: add elf_core_eflags() hook for core dump
 e_flags
Date: Sat, 26 Sep 2026 00:08:10 -0400
Message-ID: <20260926040812.725493-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let targets set e_flags in the core file header. Default to 0, as
before.
---
 linux-user/elfload.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git ./linux-user/elfload.c ./linux-user/elfload.c
index c4bdaa146a..c188fa03c3 100644
--- ./linux-user/elfload.c
+++ ./linux-user/elfload.c
@@ -144,6 +144,10 @@ typedef abi_int         target_pid_t;
 #define EXSTACK_DEFAULT false
 #endif
 
+#ifndef elf_core_eflags
+#define elf_core_eflags(info) 0
+#endif
+
 /*
  * Provide fallback definitions that the target may omit.
  * One way or another, we'll get a link error if the setting of
@@ -2212,7 +2216,8 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
         /* Create elf file header. */
         hptr = header;
-        fill_elf_header(hptr, css.count + 1, ELF_MACHINE, 0);
+        fill_elf_header(hptr, css.count + 1, ELF_MACHINE,
+                        elf_core_eflags(ts->info));
         hptr += sizeof(struct elfhdr);
 
         /* Create elf program headers. */
-- 
2.54.0


