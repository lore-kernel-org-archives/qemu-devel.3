Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100ECE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 08:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqCj-0002VH-FZ; Sat, 07 Dec 2024 03:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wannacu2049@gmail.com>)
 id 1tJqCh-0002V5-So
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 03:30:20 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wannacu2049@gmail.com>)
 id 1tJqCg-0007VP-Be
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 03:30:19 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215b0582aaeso22263485ad.3
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 00:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733560216; x=1734165016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwNXRIz9eTHMTH+71GRacS+jyI+hYb2s7RV2DenLLds=;
 b=NuBa6NdOCaekK7mOlwnSCXaurHX64eOfc4Sz3mNljDE+jIY7d3oYIydKm1avbsfWgA
 VN5kMbmvGup7gi5FrxV10yMgYP5AkleqzyS7cuB3gEZkNXtQ4Ps0w1a/Wf40NlGJ3POr
 /H0bW3Ps/JBQ5OX10BPD31A5HHgt4/gfTEHW1LWNPzkmILxbQeGSXRbBq9zUAyEDqPlu
 HN/2H3y8iXPMLPyv18WfLq4R7xM4SFOiVkL+apcKvJGJjkT37mjS5QmtW9PKuIzVp2s2
 cP5dNp8PKwuYidy0akvuYaGwQE8S6TyLGbsRHCuriXY+OHzfP+T/jJw7hQ4y4ijWMfjU
 kqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733560216; x=1734165016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwNXRIz9eTHMTH+71GRacS+jyI+hYb2s7RV2DenLLds=;
 b=V8740LyNREI6p/jp8vPbsRZC/NR2/kpDBZnbhWGWUI0PtEaoQx/Y2UIcjT6If+upAB
 HKg2jNhhwfgNAM0R6PqU8cIacJZmPN+JQqXg6qF75zwUQzu4Ne3KlwZUC3R3XWPIiYR2
 Dkw/KAJQdwJcGy1JGWUg40VuJyMmhDkwnVEbUkwhf84ypwatcJRxaPF9KLXmTKgTFnK3
 JrfjY62ZdAmlYm+osKPx7lqla+B+4pepeFz+VgJARHCFcP19jD6D1Zcl9lQSlmqnn5eq
 GhEaQdZBnyyUwDfpQ1FJ9ziBQ2X38RRE2/szQpA3xkskS4wmU1Wzma1VCX7eCfc/x2cQ
 sxdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp0fEIpF8fG9hywbO9NZJVyRHugHIZ1n5NK84ifSOfX42g+EZuaV+vnHCY57j16TQNa+0pRChR81ZS@nongnu.org
X-Gm-Message-State: AOJu0YzOk3ojCYUCufKHFirDESHxL1z2+zrJmrK6UWeWCbufRTDpYQTA
 +hQywiUrwaSnZBtbVNxN4N9P6IB794icEMsRqIdzIlWT/h9sIYac
X-Gm-Gg: ASbGnctbOq5hWmZ6ZhAYqQQDk8TcAE2+chDyIUng3qS5W8i7zWYpVXmJAkFfHwXTr8F
 VbYkiN694hAdGsSX0FSkWCNM5rVp1PeRnNcmGHrut1WvwqcFWXrpCXiRfgYNc0s7Q79/WDRTLhq
 R7nd2apL1CEeq50X7pq+sO8aoGEG1637+G9XfK2BerSvFEemwYt30VKXDId7igNoUzeIA5UOGtQ
 oo4QHhwOKJ7zy0p01Q9BIFbYcNtLVzDWMVfkq679cSxgJD0nYkMGwP9px/lFP2SKA==
X-Google-Smtp-Source: AGHT+IEmNHY70Gn1hUN9zB3lkIs21y7kKx807HlhCEanQ3QqIVpyhSt9ZOEihcYQLsBczhSujQS84g==
X-Received: by 2002:a17:902:f689:b0:215:b07b:c57 with SMTP id
 d9443c01a7336-21614dc4f9fmr63237725ad.47.1733560216187; 
 Sat, 07 Dec 2024 00:30:16 -0800 (PST)
Received: from localhost.localdomain ([221.232.56.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8efa162sm38622865ad.125.2024.12.07.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 00:30:15 -0800 (PST)
From: wannacu <wannacu2049@gmail.com>
To: richard.henderson@linaro.org
Cc: eduardo@habkost.net, pbonzini@redhat.com, qemu-devel@nongnu.org,
 wannacu2049@gmail.com
Subject: Re: [PATCH] tcg/optimize: Fix constant folding of setcond
Date: Sat,  7 Dec 2024 16:29:25 +0800
Message-ID: <20241207082925.58868-1-wannacu2049@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <f4cbecbf-9b11-4fbb-aabd-080f83c608ce@linaro.org>
References: <f4cbecbf-9b11-4fbb-aabd-080f83c608ce@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wannacu2049@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

> The problem is stale data in tmp's arg_info, correct?  Better would be adding 
> fold_and(op2) a few lines later, after finishing setup of op2's arguments.

You're absolutely right, stale data in tmp's arg_info is the root issue here.

> (1) The inline assembly is incorrect, and (2) the test does not fail without your patch. 
> So it is difficult for me to tell exactly what you're trying to test.

> Problems with the asm:
>   - using edi directly instead of having a as an input,
>   - passing uint8_t a, but using all 32-bits of edi; upper 24 are logically garbage.
>   - not adding edx, ecx as clobbers, or better as temp arguments.
>   - initializing res, but not adding as an input, or in-out argument.

Thank you for the detailed feedback and for pointing out the issues with the inline assembly.
These points are all valid concerns, and I'll work on addressing them in the patch.
After reading your response, I tested it again on another riscv machine(licheepi 4a), and the
issue still persists.

In the error scenario, the `sete` instruction corresponds to the following op and op_opt:
op:
 setcond_i64 loc0,cc_dst,$0xffffffff,tsteq
op_opt:
 and_i64 tmp14,cc_dst,$0xffffffff         dead: 1 2  pref=0xffffffff
 xor_i64 tmp0,tmp14,$0x1                  dead: 1 2  pref=0xffffffff

> I *think* you want
>
> unsigned char test(unsigned a)
> {
>      unsigned char res = 0xff;
>      unsigned t1, t2;
>
>      asm("lea -0x1160(%3), %1\n\t"
>          "lea -0xd7b0(%3), %2\n\t"
>          "cmp $0x9f, %1\n\t"
>          "setbe %b1\n\t"
>          "cmp $0x4f, %2\n\t"
>          "setbe %b2\n\t"
>          "or %2, %1\n\t"
>          "cmp $0x200b, %3\n\t"
>          "sete %0\n\t"
>          : "+r"(res), "=&r"(t1), "=&r"(t2) : "r"(a));
>      return res;
> }
>
> But as the test doesn't ever fail for me, I can't tell.

I also tested the updated inline assembly, and the test failed as expected.
I'm not sure why you couldn't reproduce the issue on your side; perhaps it's easier to
reproduce on an RV64GC machine.


Thanks,
w

