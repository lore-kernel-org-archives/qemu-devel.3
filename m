Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E5ECA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 03:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulfyQ-0005Kg-7v; Mon, 11 Aug 2025 23:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1ulfyO-0005Js-1Z
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 23:46:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1ulfyL-0008RB-HL
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 23:46:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76bd041c431so4418713b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 20:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754970405; x=1755575205; darn=nongnu.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wTTfVfNn2jNYere0UA8MeKK5TYdApHf+rQhpWOua2NU=;
 b=WhPMEVaIDLfyp4vKYJs4CveslD/kUvYtJskBbWxSslrW6kyRd57tc9v7K2WEKaRGlN
 +deehxpL+djCbNFueKYbgiKB9IDg4Sy6E/AKAcvDZyYJxlg3g5NoAoB7djm9vzut89W5
 3naztvbALsH160PAzkZVRwpt7xbq3p+xjk2OeL6hVJYWhm1atI1KU1iwwL68m8juJ3tR
 ACxJD9Rq7Y/gserFeM2iapJFttN3ieGU2uTkx6m9SCJoeELFLRQxF59/BR12akdU1B4f
 k6zzqhTbJq/MymLYNvW8tAN7X/HX2/YCq9f2CjdDZxIM1vSMOpOgtuyJXMBags35OD8i
 XqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754970405; x=1755575205;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTTfVfNn2jNYere0UA8MeKK5TYdApHf+rQhpWOua2NU=;
 b=vKTI+nJio+Jik9y5Y5wnNY7sH7wlTHZnN2pQQxw2uvzNzJB6W7cGkCox/lWMsoBPmZ
 ic17gY4Zy+qzTwGRdQ8ek1EP4oEidDsdG2B7Ibw1rToDdwuJD2A66dbE2J3a4iBmJTGa
 CNkW8ejgePtOzr+aH2Ee0i5bIzS32iuZLHLU04tn5asgG1PjPiFccP3ZZIRvLc2Vb0C9
 mIIAURv+eRaYxeFIq9zftbHdFYQP3P9JwJ2FTscVxy/pqkKvC8BuCp1TeT5b3eunSLZx
 39fGTFps0vF9sLEuPiEzq4skJypWLG1hcInwl0i5dco47lxIHOwCUZZToMlG1mToBwiS
 LB3g==
X-Gm-Message-State: AOJu0YzqxNY+CAr4XQud9Tv10o+3SeC/6oVA2F7nw+IrjYQlhENHpMem
 Ef7pDPhaMLj/Y1kik+9i0qz1wqWliMs0uz4UaGjWLIUM/h3Vdft/KU6yX2xXudRkQbY=
X-Gm-Gg: ASbGnctYw2nRZb1b2M6xxIeY1GUTe64bLPCXnLLWMax2vKH5hKFoeBIxGrRRDJtYtQW
 IZfijGINXNJ0MM+H9BPfGMv34xJIDi2NeXADPmNbLt3loc4xV4Uetx/BDMf3LOxW9n2KTEka3W7
 2qlDDJCwJMwYsVUfZRje3Tc+ZTDA6J0YjSNd3lVqOTj6xPEnqqhM5BJNgQ8QayvgJXPcLeok8Ah
 FYiNkvnl7qP7+Q0D1svv1s0j5WH6X49T+HXXmL+l3OHrvHHBMexAlYZQ8mYQ0nczt028xWNLI9R
 Gk/EbGwi5/jxvZN0teRL84NpeMg71ugsTijPXrkMYkS7QotdpdaGMS3SBIU5BqwCayIk55k7bsp
 Dam/eML5QKtPfn43Hl5xEljhDXJRtVGCxfWw8awRYOYY=
X-Google-Smtp-Source: AGHT+IHLGR6W5lTshcA2v0sdZBIZIztOfS1YCMlZwtW8wYCj/wlgwWvUyoMy/+6rwC/CLu+ByiaLEw==
X-Received: by 2002:a05:6a00:1ad1:b0:748:ff39:a0f7 with SMTP id
 d2e1a72fcca58-76e0de1be98mr2699934b3a.9.1754970404991; 
 Mon, 11 Aug 2025 20:46:44 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:567d:588b:eb7d:58f7:a07e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce93da5sm27890219b3a.50.2025.08.11.20.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 20:46:44 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 00/85] target/arm: Implement FEAT_GCS
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 3 Aug 2025 09:28:28 +1000")
References: <20250802232953.413294-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 12 Aug 2025 00:46:41 -0300
Message-ID: <87jz39mcbi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=thiago.bauermann@linaro.org; helo=mail-pf1-x431.google.com
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

Hello,

Richard Henderson <richard.henderson@linaro.org> writes:

> Based-on: 20250727074202.83141-1-richard.henderson@linaro.org
> ("[PATCH for-10.2 v9 0/6] target/arm: Add FEAT_MEC to max cpu")
>
> Tree: https://gitlab.com/rth7680/qemu/-/tree/tgt-arm-gcs
>
> This includes the prerequisite features, ATS1A and S1PIE, and
> not a prerequisite but closely related, S2PIE.
>
> This passes the linux kselftests for gcs, with a 48-bit VA.
> I also include a few smoke tests in tests/tcg/.
>
> There's something subtly wrong with a 52-bit VA.  Most everything
> works fine, but the first GCS lookup faults on a missing level 3
> page table entry: a Translation fault, not a Permission fault.
> The kernel then panics.  Either there's something amiss with our
> implementation of FEAT_LPA2, or there's a kernel bug.
>
> This includes a best-effort linux-user implementation.  Since we
> don't have softmmu in user-only (yet), gcs stack pages get normal
> read/write access.  This means we cannot write-protect the pages
> in the same way the system implementation can.  But all of the
> other parts of GCS work fine, which is good enough for testing.
>
> Changes for v2:
>   - Add arm_mmuidx_is_valid
>   - Revise and merge back the linux-user/aarch64 changes for
>     syndromes and ESR records.

I finally managed to test your branch with my GDB patches for GCS
support in Linux userspace.

Most of the GDB tests pass. The only failure is in a test which sets the
GCSPR in a process to a bogus value. This causes the process to get a
SIGBUS:

(gdb) set $gcspr = 0xbadc0ffee
(gdb) continue
Continuing.

Program received signal SIGBUS, Bus error.
normal_function0 () at /path/to/gdb/testsuite/gdb.arch/aarch64-gcs.c:121
121	  __asm__ volatile ("ret\n");

In the FVP emulator, the process gets a SIGSEGV instead, so that is what
my test expects:

(gdb) set $gcspr = 0xbadc0ffee
(gdb) continue
Continuing.

Program received signal SIGSEGV, Segmentation fault.
normal_function0 () at /path/to/gdb/testsuite/gdb.arch/aarch64-gcs.c:121
121	  __asm__ volatile ("ret\n");

I don't know whether this is a bug or just a different permissible
behaviour, in which case I can easily adjust my test to expect either
signal.

I'm using Linux v6.16.0-rc7.

-- 
Thiago

