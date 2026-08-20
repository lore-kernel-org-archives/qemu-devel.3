Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577DDC5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yG-0003kQ-6f; Thu, 20 Aug 2026 12:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yE-0003hn-Oz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yC-0005Oe-5c
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuemtEsPrKb6hh5vMB01k49kpuG791S0pZzsaFMqe8Q=;
 b=Sez2JE7awGv01hoGBrG5tYvDoLObZxiN8iMqhUpV53iTV0I9bGN/flzov46p/m3UUA7FSE
 iyhm2rtT1VhYCQFp6cTnNyv59HlYQApQi9B0pPk2Wh3aDlWm/CXnFkBA6yOA7xHRyUThIQ
 Yk46zpwIttsszgvPBkeoqZphS80g+4s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-xU_72qYgPXSauTG90TOB1A-1; Thu, 20 Aug 2026 12:50:22 -0400
X-MC-Unique: xU_72qYgPXSauTG90TOB1A-1
X-Mimecast-MFC-AGG-ID: xU_72qYgPXSauTG90TOB1A_1787244620
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482b88653d9so79663f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244620; x=1787849420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uuemtEsPrKb6hh5vMB01k49kpuG791S0pZzsaFMqe8Q=;
 b=Me3Z17hv1bsXXf6AZRmEXrqjz1aYM1rAJr2sf3qmHW9yImmfzRsw9/wyYUEwaZ4Vyw
 APgwR5lxRwq8eNo9Dp+N/CUQx3jpNKUWF4gPvKCTzuaoxVGqKkZSa+q8h48jA966ravT
 hljSHEvHmtYm6KXrmTqqKKKQco8xsgG1cR+TRHsBXZqnq662DjqAaTR5LiZ8FkryS1Qs
 rnA9+MQwKpkf2tZk4yYIpKoKhXvlulvjW67lJY56mACR7GJiGpemJvHgAo10w9+ZpiOz
 eUmYQ9DapB4wp34r6L3xO6LvaTFRoPiEkZsdeqkeaVU/0Pa+Va8gI5SAd2Z/a8BKhdLW
 AGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244620; x=1787849420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uuemtEsPrKb6hh5vMB01k49kpuG791S0pZzsaFMqe8Q=;
 b=nRuL5FKc7uB1NKFYfEfEz27ApepkoH4OiGY/hr2MpfcMJEl35wIMYiuuclTpXKNM5W
 155UzlkOdi2R9Xr9qTmCdzagDo/PKDLShpM5ScRGTXinhVsIrjZISVPIguMQ+JQP1Zmn
 SqZoT6RBWVEfpCMGg8Im7oM011MPqK1nuwwUQHK2thMBwjZ9w5QswHL5HRBYHoCxypyD
 2kVzM/iL3woyo3Q5Uq2Skf2EzKnT8PoREWIvzHBS9tKcQWRuJM6ZnthnLum7NPP/LjwW
 qLSO3eHwq2ogmcDcFhq9Xbyf0f3nVmR33K9xgoyI2HKgf0PQSWDPxioRg0ejn3ydefIV
 vrLw==
X-Gm-Message-State: AOJu0YzU+az9ceyhfbp1u3vIkW9S78x/iNeDUuBuSq8jYuODptXHbEOl
 3Nt6DV+8EgMlgpYuURKttNae+FUc8HcEs3KDYT1hS49VUW6F4a3ShlQv1y0ENSwS4trPGrFxQr3
 QPb8omi5+swHPKzPVQIGmFnRt9NnuXwyvIlcW41TS/ps2B8xpuznRYEHrjH653+ilDJOPD3sb51
 CR+G95Eb1QiSSRvxeUUqxm5LvEjrKbkw8BKJzq6Qv7
X-Gm-Gg: AR+sD117oUeKnDCVscz4q07qiPuK2tW8VDpK9PtJCaGI8yuQh6u2hhoUbm6uJ7IU6VW
 zYCc4E0O9nGBIvkBQvFR1HNzbMwEsHVHtEklqP9YoWiPg3b9IbhP5o5fYCSbTnOXgb/D48nKMQe
 Mf8psC7CJm9kSDc8CVILdgiElQzyLuI6ayxYqr1XBqgJ+3JK33UGFZj/Dt7VSGVjVQOSwsyJxAM
 EJtmqfEkJsGmr8sPoC8eu7v8n5IlX5kVMK2dpuUkqU3XM63vpwjgheuL/uE3Yj1SIURAoLgRIwU
 YvvBJowMeoK7osWOLkmn0uih8Gi9t2GLVOJypcHw+pYsjIPfCOUcEHs5i3/ZF0SM8g3Z6juyzoK
 pykTwTGFCcVc2IMwEPruHziX7WxLrNyRrknx17n7a9dQPRTbw2/jUiRe5q2Y+XgdXcdBaIdrElH
 gGB9k=
X-Received: by 2002:a05:600c:4f0c:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-499b829df7cmr6765215e9.4.1787244619987; 
 Thu, 20 Aug 2026 09:50:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0c:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-499b829df7cmr6764215e9.4.1787244619547; 
 Thu, 20 Aug 2026 09:50:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14514d5sm14363235f8f.10.2026.08.20.09.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/53] target/i386: allow transition to virtual-8086 mode only
 if CPL == 0 and CPU is not in long mode
Date: Thu, 20 Aug 2026 18:49:09 +0200
Message-ID: <20260820164957.1895963-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

According to the pseudocode for the IRET instruction in both the Intel 64
and IA-32 Architectures Software Developer's Manual and the AMD64 Architecture
Programmer's Manual, a transition to virtual-8086 mode is allowed only if all
of the following conditions are met:

1. The new EFLAGS.VM bit is set to 1.
2. The Current Privilege Level (CPL) is 0.
3. The CPU is in protected mode (and not in long mode).

Currently, QEMU performs only the first check. This omission allows a
transition to virtual-8086 mode from long mode, and also enables the guest's
userspace to trigger this switch.

During a legitimate transition, the EFLAGS register is updated in a way that
allows modification of sensitive fields, such as IOPL and IF (which is expected,
as only privileged code should be able to initiate this transition).

However, due to the lack of appropriate checks, an unprivileged guest userspace
process can now force this transition and freely modify these fields.
This allows the userspace to:

1. Disable interrupts, preventing other processes from running on the CPU.
2. Gain direct hardware I/O access by elevating EFLAGS.IOPL to 3.
3. Crash the guest kernel by setting CS and SS to resemble segments with RPL = 0
   and triggering an exception. Since the kernel is unaware that the process
   entered virtual-8086 mode, it will misinterpret the exception as originating
   from kernel space.

This patch fixes this bug by adding the missing CPL and long mode checks before
jumping to the `return_to_vm86` label.

Fixes: 90a9fdae1f1a ("more ring 0 operations")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3583
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260622082119.11903-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index d5c174b7fd7..6d424349a58 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2077,7 +2077,8 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
             new_cs = popl(&sa) & 0xffff;
             if (is_iret) {
                 new_eflags = popl(&sa);
-                if (new_eflags & VM_MASK) {
+                bool allow_vm86 = (cpl == 0) && !(env->hflags & HF_LMA_MASK);
+                if ((new_eflags & VM_MASK) && allow_vm86) {
                     goto return_to_vm86;
                 }
             }
-- 
2.55.0


