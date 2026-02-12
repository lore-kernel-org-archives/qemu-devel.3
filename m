Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD57EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvT-00061M-4i; Thu, 12 Feb 2026 09:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvD-0005df-Va
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvA-0006DI-R8
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5C5V9mlyEYrUFXjVMKVGDiElN7K/7aJObqEFirrLrY=;
 b=OoeVw73P4FtSkO7Ocr5s3N7jffOplCltEqJrhNcXco7Q12Ibfg2DvVoduu2byEaQezBQKt
 h35UsTiPvsUNUb5Ypg4H8jgXGTKpFZLMIAI9DiH2fRo2v7AumAZ3DI+0BdE7OmC9nnD3MF
 cjmo1jLw9zALWna85EWo8g+rSRLqeoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-eNIfxoBIPUyySskhtKw3-w-1; Thu, 12 Feb 2026 09:43:55 -0500
X-MC-Unique: eNIfxoBIPUyySskhtKw3-w-1
X-Mimecast-MFC-AGG-ID: eNIfxoBIPUyySskhtKw3-w_1770907434
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso58790365e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907433; x=1771512233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5C5V9mlyEYrUFXjVMKVGDiElN7K/7aJObqEFirrLrY=;
 b=fuLGuZ4d6sjrU+ZxN2RrUoOFjneAOFTyjBIOJikoE8LQkC9SylW1Fat3HAFWZaeWj/
 xpoNFHGpfL1MdDFOE/+mlFWQc6v2aVKeOaTCmWPHUf3oqa9eWZ1vA2KuCWWmuYG4pW/h
 YYV3xVy9Xbg8VMMSeGd1ac/3rYNXZ1qBWVEcgfwdAAPzUtekkct5jnEtpbzadCSQ8CVO
 UnnJcFfj3H2tnjm+bx/fmhnsBc5WPR8zcFe8G5hKcq5U1Mm3JqH4e+cXx4a2nn3iZudi
 draQ3DNC4Ia7fBlCA3RQsxO2MaAvZtL7HB09/9MZIN/co8/XnwawB6F/NcqwWwLy5tdF
 SfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907433; x=1771512233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F5C5V9mlyEYrUFXjVMKVGDiElN7K/7aJObqEFirrLrY=;
 b=oqaCMId94dNFwnUdg5KVm0pAQZPa5nWeeexI3ucb8dZVmXSmxnrrzC4H4JPB7sGE3p
 tcfgHE2GxWi3vzPJSDOKZ5snA1YjBfGx6Vx8pnhSGXTfeR6/1vMv7FgT+JNw8SGk+WWZ
 7x4uG6ElfMHkU7ZKrDfwt5VBwEbpOl6qaD1tNIcv+iAilXlcjllVXaBdtTGUuXOz7//8
 k/brpxKbeFijBK4ouwZML8UXwh0ynuvjywgibbvo7zFQAUze7N182q5+tvdk7p7yCZzp
 1QpVvtzpjdxBBobgL9hlQzXVlkFOzZt6f3mXoB7Nfpl1Ye8CXOqpW/tMv1ytgjdLdW3Q
 rykw==
X-Gm-Message-State: AOJu0YzjHpzCRBue+hi40+8H9gfJcD6MgijNRe1JCbpGCCXL8brdowJH
 IfcT/5rOp1YYcJlmkNufovkEGIHGiWzrpkqBn7y/XuyLCsIbzZqOHahQE0743vZWNiVI0KDXVWN
 dW8Gcy8atOB1D2lDHrh43VWyzJT9KUkv1gaK+6kXL/Q7ycQJKKA4/qbSFr0tXD2ViiGdR1Hc/ZV
 x9Vb0uRuDSPaWLSY2OMe1zs13RzPYI0qEOVDzjXEyI
X-Gm-Gg: AZuq6aLbQeDnxrJur1r54+OHmuJ9LI76iUhgMS+MFvCKND1BpINoBR2AeU7NU+CxT8p
 a3WiI8Vro9BitCc81EY0thSp+17cutRjIM2M5wGh0g4pfL2tNJZ7aHklR/qpNKLPE5RMsEIuqpK
 JAxc8b7Irv1qsPpPgAY8h0mp9s8zikDXF1KQKM4wf7gjnEYALe0vowVihHL+DtVlI0B5b/YpZ0R
 8ZuGX4mL12RCOJmCdQuu1Sg7mJCoKukaquei/p/Xbv6rXeiIt9SATsBnq0s4UiFhURcVCcSJw+C
 Hnb5j+qtrjBQv++pgO7ibGBkOHn+mqHoeVFHc7i5AIs04FBcQv/qOcXO23/JqVLfX/tGqxZZZpD
 kjF6ru4G2FdGP6T0eX/fvZNo0dA401Tg8AiGXhrb+2QIjv6ixdj4nOFiwyASU9IJ6R15EF9IrNZ
 XSHkWW/R6MU5rfSG/Tcfw3get1/a+q5WAcWSJyuoRrpB8wBnCvFzk=
X-Received: by 2002:a05:600c:a0c:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-48365717d44mr41443555e9.26.1770907432943; 
 Thu, 12 Feb 2026 06:43:52 -0800 (PST)
X-Received: by 2002:a05:600c:a0c:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-48365717d44mr41442975e9.26.1770907432400; 
 Thu, 12 Feb 2026 06:43:52 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d989165sm157738145e9.2.2026.02.12.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aidan Khoury <aidan@aktech.ai>
Subject: [PULL 29/41] i386/cpu: Fix incorrect initializer in Diamond Rapids
 definition
Date: Thu, 12 Feb 2026 15:42:31 +0100
Message-ID: <20260212144244.22579-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aidan Khoury <aidan@aktech.ai>

The new Diamond Rapids x86 cpu model definition that was added in 7a6dd8bde1
has an unexpected comma in the `.features[FEAT_VMX_EXIT_CTLS]` subobject
initializer, causing the prior initialization to be overridden.  For this
reason `VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE`
is not included.

Fix this by replacing the comma with the missing bitwise OR to properly
combine all the flags into a single bitmask value.

Fixes: 7a6dd8bde159 ("i386/cpu: Add CPU model for Diamond Rapids")
Signed-off-by: Aidan Khoury <aidan@aktech.ai>
---
 target/i386/cpu.c | 2 +-
 roms/seabios-hppa | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 201c5d5c210..eaa01438c1b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5579,7 +5579,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
         .features[FEAT_VMX_EXIT_CTLS] =
-            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE,
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index b876684ec39..3391c580960 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit b876684ec394856a8cc2523c57b3dc784dc119d4
+Subproject commit 3391c580960febcb9fa8f686f9666adaa462c349
-- 
2.52.0


