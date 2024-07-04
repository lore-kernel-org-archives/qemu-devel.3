Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7100CC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOnD-0003Xc-GW; Thu, 04 Jul 2024 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPOnB-0003Uh-3a
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:54:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPOn9-0002Ez-7x
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:54:40 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so1070591a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720108477; x=1720713277; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyz6MO0o1ZQ7jec6svcJsnZQzb5WUcVMNCW1YAIVeJc=;
 b=japqO5XPGsI0I15r68ml6GfQ99rfW5gaMvG303yN4wz2HB6DazFG6XpoyfVMxmlrwi
 FKXERVFb6A0+QOCgo99HShc84DGCs7eNG2ZdoCEk0nRMMMyxzKmR5ILQFfyZ2OCl0XFX
 zoReyTTcpoqtSshSfTPpoX8rWjb4CV/6TnK5mVzoDyC4p/m3cHcR11fQt9FNwjJpwfHC
 qa3f85XJpJPpzTONg14TuOnLPu35qm14+40EfWSbcDIRsoI7V8rfA9WodQg0f4B7HALi
 pkeS5ZNgKNXgViWiEaVh3Vrsx2miiBWiYECzd1rI7YjPiWoGF+dVI5Cs9KTVZngeW1Ab
 D/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720108477; x=1720713277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyz6MO0o1ZQ7jec6svcJsnZQzb5WUcVMNCW1YAIVeJc=;
 b=RMi8hcAFqXNXuE4UEI++o21sDW8BllmBYFyL4qpTk1JAMk/iIhU53kBG8T3PgAEBlb
 iWhyiEiW1YyYdu4zWq1mHlYk8SiloeTUsXuUFmhHYmPIkdC3lDc/lKNvPOnARbaHt4W0
 bxmK6eQR5yaoUfgJkpgNA7jgkzfuLkPZyZMx3DKY8A2Utu7ySziT5k7Bx1eGYb397ou4
 MA8VOJSF75JQnpWsNEhNxp9d+j+zU8CihBO4qL9aFpQlvqUpRoj/IAaJGH09oRiWAYh6
 aqSHdJUO6vq6ieO+6f25Y9timmb8eOUAl5L1NtXRS9oFgAlKEyrMwA4IjqBrwGZxooM4
 8vWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcPHvGLEFSRXdNyUisV0xS0b2wNpK0lbF3mvElEDGuFao2k0QvB0kCXnvnskFd6dLLd3ccrEwzJCK6DJAe3L5mE4t+kEc=
X-Gm-Message-State: AOJu0YwCqRzYqfp0TiI4Tz5oeoTh/rSYaV+zn1Xglz3cF5wD2RsgkFRP
 oiViM401SPU2tHYC1UawVhjlX32r27m67Ers49IMeXNwh4YM4wl6kWKJlg0JsI++wCcOjRXG5rv
 k8m/8+e08vjrqdzhJbxWDp6eZrN2CXku3Wb+6bQ==
X-Google-Smtp-Source: AGHT+IFtJc9rfRUQOqGDqVkWngTz0E0opcedNiC2Jpq6ifMm4vN1zygYW0WXH4HLUEcOkMsXoEHeVqDlkg8yO7segy0=
X-Received: by 2002:a05:6402:3583:b0:573:5c4f:27a8 with SMTP id
 4fb4d7f45d1cf-58e5cd1222fmr1442990a12.35.1720108477315; Thu, 04 Jul 2024
 08:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240618160039.36108-1-philmd@linaro.org>
 <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
 <6dfa4bb0-e4c5-46c9-93e5-d30f3a26592a@linaro.org>
 <68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org>
In-Reply-To: <68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 16:54:26 +0100
Message-ID: <CAFEAcA_Z8ap1SbyWJTadPwD212-G15DEoDas7xXjfMCya_O0DQ@mail.gmail.com>
Subject: Re: [PULL 00/76] Misc patches for 2024-06-18
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 18 Jun 2024 at 21:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/18/24 13:15, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 18/6/24 22:06, Richard Henderson wrote:
> >> Fails testing:
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/7129004955
> >>
> >> qemu-system-tricore: ../accel/tcg/cpu-exec.c:1082: tcg_exec_realizefn:=
 Assertion
> >> `cpu->cc->tcg_ops->cpu_exec_halt' failed.
> >
> > Doh sorry, I tested but hit a libusb issue on this target and mingw64,
> > tested there and thought this was the only issue and missed that.
> >
> > Hmm cpu_has_work() is defined inlined. I'll just drop the 3 lines
> > I added to Peter's patch and send his unmodified.
>
> No, the assert is exactly correct, and caught a bug in the previous patch=
 (55/76).
> Without your assert, we will just SEGV in cpu_handle_halt instead with pa=
tch (56/76).

Yep, we're missing the setup of .cpu_exec_halt for tricore.
I missed this because I used a grep for the setup of .cpu_exec_interrupt
to find all the TCGCPUOps I needed to update, and for some reason
tricore doesn't implement that hook. (This surprises me because
I expected every guest CPU to need to provide handling for
interrupts. But looking at the callsite in accel/tcg it does
indeed allow a target to leave cpu_exec_interrupt NULL.)

Though we won't ever segv without the assert() in patch 3:
tricore doesn't implement a halt state, so we won't ever
try to call the non-existent cpu_exec_halt method. (This is
why my local testing didn't catch the missing method.)

Anyway, I've squashed this in to patch 2 and re-queued the
series to target-arm.next:

--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -169,6 +169,7 @@ static const TCGCPUOps tricore_tcg_ops =3D {
     .synchronize_from_tb =3D tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc =3D tricore_restore_state_to_opc,
     .tlb_fill =3D tricore_cpu_tlb_fill,
+    .cpu_exec_halt =3D tricore_cpu_has_work,
 };

-- PMM

