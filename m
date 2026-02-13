Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062BBEDF144
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqId-0005wN-Id; Fri, 13 Feb 2026 05:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqqIY-0005pU-MI
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqqIW-0005hM-Jf
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770978075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiNbrB0VahFA151Xrbivqy2NKp5C55oBD0pMpuWv0dE=;
 b=Woa3BGQUImn/XKBnHB3cm8SVvzOQYseiBcXTy008XAQWw2tpGuYrqted3MoWFYzfT5aubf
 bw9fBZI03SlvwLGgrIvylaiG+UAHQYvSor37/uwUNH6PPO8HxwWc7Wdn7LQzetyQH//1Z7
 VKinAZPwe4LlEwT7On5/OU1U0TzH3TI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-XJmaPvlVNEK_YCCNMAQ7dQ-1; Fri, 13 Feb 2026 05:21:14 -0500
X-MC-Unique: XJmaPvlVNEK_YCCNMAQ7dQ-1
X-Mimecast-MFC-AGG-ID: XJmaPvlVNEK_YCCNMAQ7dQ_1770978073
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so10957795e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770978072; x=1771582872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiNbrB0VahFA151Xrbivqy2NKp5C55oBD0pMpuWv0dE=;
 b=PpIkueIXl/4DkqKjMUUYp3L9RMaila4K1a9P66pDZ3W/WlhmRxpjbDN1lQTLwlWScv
 enhmLXmYUPYYbgWABSvDBNipRVgUL3npihUH7kIOKJ7v4Jx+cJ13YXBuxWpfJr0nL2dr
 4DJ0B+ZVhq0eh95mX5HOgNKj4JizkgX0NMX4S92hPiZqIWB/OC15+Uf6Ej3uXb+zw5C5
 lTkDebNWkNqbqC9gURl5EZS9j0QFn2x2Zowb2Q4L3x5L+L0RsKSL0QfNEFFgkJY98cxB
 HCAf+3r+RVx+LEX4PaebpX5cOtH20raatQ4Rdoioiv0Jc/WAv/LUuC8pIMfErGTmmntC
 R86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978072; x=1771582872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EiNbrB0VahFA151Xrbivqy2NKp5C55oBD0pMpuWv0dE=;
 b=dhOJLVd4nWr5pjKRCcL8PIGnDk2zZ4iFxyXWLA5ua5E1CVjhz9B71twqzMavrHtYub
 Wf++kdNN3nB4hRKpsXIpz10a9AnrLpDs+Ts1Vdb7HYMvXuNwAFnW+Bnk/0sGAYeI8XiH
 9iJGbCOKB2faZJKJskEpinEghHNtJR5ABQw8Y22pf0hcEGvAwwxkSdMqjSGVg9q89sS/
 ZwRuxH5L1hGzlRASGVVSGIcgocdz4ILkqeZt8YHf+e9kEmkP8WtqnuusQX3NGy5SMIMO
 Ci65zsBcSQpdfhP4BBlKtbuGWPone5IvQS0tAxFAnTKCUcMP8NDuy5ANNz9CAdBdDu9p
 c/SQ==
X-Gm-Message-State: AOJu0YwPB1ZNNMssrpw9MkITwVbABxVbWhMBkfrx8Qa6LbGSmuRyIE4b
 FU3mS07UB5yJNQSfmdTAiT7wCT8bfeWHaYhmJ1YxR88X3q5I/ga+LMATixf6Uwt9fcbecjf9xFf
 Zu6eAAxvwOMjQULaV4rgdm6smVsmRwfsBPlcE6vtse9cfNO5AUeUOFvw9fxmN4i05UhXZdT9ZKL
 LEdpWGhEEhWtSCVGSfrEa0AiexdQfmEubQCnPn9EXu
X-Gm-Gg: AZuq6aJ4ACTRFv4EamWtkG9uCXlv2EalgwsNh1yj3bYkMHCk2SYsZdoM1R2S9+T+GnP
 uAh2VnWtnCZM+hfW2NW8xY+wZWrr+l8UG0UC6VyS+1JI0pKsRAKz+698im0Qmwe/SBqIiiraq/8
 5daHH3c2+tVtbp89iymwAra5uQDB3xjTULWQEdFxnBz9cC4Sn1EMkCzYF9z6IGHx+cu3gNNjH6a
 II9ADVjxrFzoQvil08t70NLs1C7d3JidfgpVEW9XI3sj/T2laFb0uK7QH0+W9j/oL9w5HgiJN3b
 QY/7ecmJgFm2uoHIM5kSxB80NVGzMf0IOJci4lD5r3cOuRuYA+Dkzr73W9rSmoHPU1e2fnU100E
 BmmVwcNL09NscvgEl6BWUd/R448LNVWFQUISCgndWWUH6KJm1c8ELgDXTY+fXNwu8nkcCVSFQGk
 UvTDu9sA5J/rODcZhcLfMjhBN1ww==
X-Received: by 2002:a05:600c:4e49:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-48373a08300mr21314935e9.1.1770978072639; 
 Fri, 13 Feb 2026 02:21:12 -0800 (PST)
X-Received: by 2002:a05:600c:4e49:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-48373a08300mr21314395e9.1.1770978072087; 
 Fri, 13 Feb 2026 02:21:12 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfaae1sm145503735e9.10.2026.02.13.02.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 02:21:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aidan Khoury <aidan@aktech.ai>
Subject: [PULL v2 29/41] i386/cpu: Fix incorrect initializer in Diamond Rapids
 definition
Date: Fri, 13 Feb 2026 11:21:09 +0100
Message-ID: <20260213102109.107491-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213102109.107491-1-pbonzini@redhat.com>
References: <20260213102109.107491-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.52.0


