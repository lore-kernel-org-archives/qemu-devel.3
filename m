Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D554CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kYD-0000Aq-1X; Fri, 17 Oct 2025 09:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kYB-0000AB-05
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kY7-00082b-2e
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-421851bca51so1520220f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707867; x=1761312667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lg9/iN3U42dGIjpzQABpfRLiLFnwtWVL68CvT+og75o=;
 b=NYs/QSZiU/ZnU08xphuxVpBzsXWR9yESVxGSXkEoQLy8oGdZ60fyiM+b3fUhDNJPiY
 j/AE8LKXXqfAQjWTFyG09TDBb/9MUfue8EO2Kxl7cWG8nCAAMUY088XNkVkXE0Tlsae/
 KRl3Uil1gBTaQu+CfpJsiZReskDwJpPR3D4EUFLgWsLJOpSxZGnMCiQX1qY2WBW/NWS4
 zqSYUaYczYHwRmh3zYQ5EQ3erLpH2dBjcgBi6Mc+uqSYjFkx5Qr8HCq2BWyxLk2FW1uB
 u2ZnizAoTqIkXno74TobAIa+PpJopuHHw0VZIXgLwVtdeBoLFUO6rozle1p6oP4Aava7
 tIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707867; x=1761312667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lg9/iN3U42dGIjpzQABpfRLiLFnwtWVL68CvT+og75o=;
 b=YB2vEz3Lbfgeh14utuU1tBW98UW3oqimRh0jlsv3ItfTEjGXrOd9nP4IqyUFkUYuoq
 srOzennULyhzEFcG4PdHNzgp5qAJmHXYPVQCyjv85S3xAulowQWCQCwquUz7+6vEQhIV
 rudlaZZkY6Dp5v/N2dGmB+i8EALALSRDJF6A1V9hElWjP4n2C1TmHIDbIXrqmTCGhXqj
 zD9S+Jhn/0dKW4uHxcETuxxWRphx4d/Jx67yMoxBWYFOmAIkfaJz1NHFTzYbJ+FCnJcF
 HSrenmay/bXV4arQsBlA2XiXQV/9tWTTIXeUIfO8eG+OIPd9fNauy5S1nNkwqKgwByl4
 VTdA==
X-Gm-Message-State: AOJu0YxgPJNSvid3oLQMP7IIjqfjyoXrWI+G7xjxNT9H6DZgq04qF4ve
 WhJBBL2A8L9r15UN5v5zSdDpeWilp/9nB/lC6TDyFR+4QjGzm3qN6LJUmEahoyYsd3G0vBo7D4q
 jOIx1ihI=
X-Gm-Gg: ASbGncvyXCr8oen6oS2YNvt2B+10kYhvbY41oTsBi3EEY6ARyhYhqylTRPCZtGeEDd6
 /dkhHS/9VFAlKeq41ykgBMAdhboqFk/b1FzvXArrJLXCh68nr7W8vIaSyEh5FtGwkzdPW9V8sUm
 Lfdh/37JHwXLVksBI2OVnFVv6L3UWmV+Eo5kmtSuea9GoyPpZU+4bikdTxbwcMCk145mD/7QqKA
 UM0Vyc2kUPB04KQUZZcqdi6cuDPNLSxSsJ9itWRHlrSe0hfb2ZtiLsZnajyxlyvgY0cPWoFP9d7
 2PFUuaaXQTHN9DhJ/9raPi2/TVVofswdWIEQ43v9pDa5HqH0iXDMJDuocptW1pHobAem3LsNq8Q
 vW38Xxmetg1fYejz2m8MTz888L2W9AMJvMrfbiYnQDJ40KceiTViiHxRNWT2AAl9P4SogILHY3C
 nsSWrwT7huquu925TprmrFSQ4vIxukFcffThw3Gu0CJSZ5ww2PTuToEUbQS32K
X-Google-Smtp-Source: AGHT+IFCK5e7LgLE0Mer+Jb7OyyOIFesW2b3vQifBr9tzBgz+s7LB2CWu/D4myxXrMDcDrX2fouseQ==
X-Received: by 2002:a5d:64e4:0:b0:427:45f:ee21 with SMTP id
 ffacd0b85a97d-42704d90029mr2823118f8f.27.1760707866829; 
 Fri, 17 Oct 2025 06:31:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4270665ef67sm4475230f8f.28.2025.10.17.06.31.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:31:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.2
 machine
Date: Fri, 17 Oct 2025 15:30:01 +0200
Message-ID: <20251017133002.61410-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 390d427dc41..bc8e9f4c34b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1007,18 +1007,6 @@ static void ccw_machine_8_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(8, 0);
 
-static void ccw_machine_7_2_instance_options(MachineState *machine)
-{
-    ccw_machine_8_0_instance_options(machine);
-}
-
-static void ccw_machine_7_2_class_options(MachineClass *mc)
-{
-    ccw_machine_8_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
-}
-DEFINE_CCW_MACHINE(7, 2);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


