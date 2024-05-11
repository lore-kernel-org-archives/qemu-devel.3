Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F70C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lJ0-0000Nb-UX; Sat, 11 May 2024 07:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIz-0000Mu-6G
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIx-00070i-NO
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34d7d04808bso2029923f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428458; x=1716033258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlF/qVnfBB0/mvdhSrl0HFniC4poDP63wiS0TvU6Y90=;
 b=fic8w32TpSa2js6kN7tOih53aYku+zDAQ/KMgdT0Ig5cHW76WyH7CeguWeAL1IIscU
 DBf4PjV1u9a6st8P6vBb2Dm4LXN4HD0TDYIhL4KfEzfkKNNnxesWyMe+FZd+hD96biu7
 /lbwG8uUIaFKzJ0NtqryD2JITJvPu63No4NjuuFTnTuen1KyNI/Jtqln0XkCRMrgc7Ed
 QYwwnd94m9a8X4PcNJ0yWefndcAkyno4wPL4cywC/B9ZHkUASr28wsxhKLo/En0gyK35
 Em46zaLV5Fw28yyNOyqs2w1ikpy9odHgact+ntoSCCAcxIMrCbG4ljMAY/+eg8dTdc0E
 2hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428458; x=1716033258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlF/qVnfBB0/mvdhSrl0HFniC4poDP63wiS0TvU6Y90=;
 b=DJ/g44ZVlah59IeDmiYJmt1IdjiXoaMRWQOHUOAu9RH6nqH1m+pxFu9XvpmidP0ixc
 7ibAhTLSGQeW03QuVJ3vpBOQJmxQU/FSrW+ucVpUsbxtA7V2VANPN7rCOpCOPsv3vHUE
 J3dZnezCB3y4fn4f8Y0rZEM4YVtxbd8EYrefj1FDjgJS2u2qNaasFZRfMf7yCsEnXKPf
 g7AELr1whxxyNfS488dZ3tZ9pYBO4y7HNqcHflsm36QsMzx+cWteRIliL+IPDZdIhM9e
 +jOqx9xJb0ylk8bw0FSp8l3R576OkRDVkK0TS9Qhz+f42PWh1TeILP0r4D9P7aaVvOjy
 1/4g==
X-Gm-Message-State: AOJu0YyidRH4tY17aRyJ7VrINWUXjgR3Jhzb55cDtZVTNKeY4a5RTNa8
 h6wU/vZS2mpechi/pp1Ukk3pf7lxOlG3sIUr1ImKAnZgATO3sm1rsmb32pfaa/856fLEodfWD/z
 VelE=
X-Google-Smtp-Source: AGHT+IHdyFMhOQnxoXVFaqs77mBMeqYqKKdp6nqtc4FvoJCSoFgRLASw7wogaN53Jpz4WlVDg7nd7A==
X-Received: by 2002:a5d:6650:0:b0:34d:7f17:1e22 with SMTP id
 ffacd0b85a97d-3504a61c818mr4198469f8f.14.1715428458340; 
 Sat, 11 May 2024 04:54:18 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 16/17] configure: Enable loongarch64
Date: Sat, 11 May 2024 13:53:59 +0200
Message-Id: <20240511115400.7587-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2f7c580..39275a2 100755
--- a/configure
+++ b/configure
@@ -54,6 +54,8 @@ guess_arch() {
         ARCH="arm"
     elif check_define __i386__ || check_define __x86_64__ ; then
         ARCH="i386"
+    elif check_define __loongarch__ ; then
+        ARCH="loongarch64"
     elif check_define __m68k__ ; then
         ARCH="m68k"
     elif check_define __powerpc64__ ; then
@@ -141,7 +143,7 @@ Some influential environment variables:
                prefixed with the given string.
 
   ARCH         force target architecture instead of trying to detect it.
-               Valid values=[arm|aarch64|m68k|ppc64|ppc64le|s390x]
+               Valid values=[arm|aarch64|loongarch64|m68k|ppc64|ppc64le|s390x]
 
   CC           C compiler command
   CFLAGS       C compiler flags
-- 
2.34.1


