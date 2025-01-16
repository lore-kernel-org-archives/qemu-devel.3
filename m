Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D5C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOvt-0002NU-Tu; Thu, 16 Jan 2025 07:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYOvs-0002Ms-9f
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:25:08 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYOvq-00082F-Ax
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:25:08 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e4a6b978283so3527144276.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737030304; x=1737635104; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A6vA39i9y5IA3PTpTj5f7RjAkmv2BL1Souo4U2/iAAI=;
 b=hup4ApAJVZORAZ8Tiaj5DBgC+SU4pkiExuxgDiCwm2PRLHqSnusCr+k9uKdYZUgOZI
 si3UeoMEtcKtyqmLo64MgZ+mlIKDEWVdwgTQiTHMBGw0UHe5MKG88EiEDaUNQlzG48L4
 oi9mfV9NEXpJMAZGWUuvO8LyNlSPa0Ue5Kmx/HJoqbxb14lpNlTe08/hNcgyc064d+UP
 V6Hjw4rdF5hyL5gYSdu2Pshkf1qip+47ujANfAldowAXwQ7FTozZFe1x1wMK7yki8hrk
 n68cK6AgRBcAq4+AFo6i3KcIzfQjKwYXqEoRxjnWHrRgZdDqJeDelMPVKjEcmSlzmLYi
 vbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737030304; x=1737635104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6vA39i9y5IA3PTpTj5f7RjAkmv2BL1Souo4U2/iAAI=;
 b=m9+UHafQFYNcDAQeOlfKjxvXDNRvhGsplDV+jkmIUqCUSOcPwY7hRnSKBzJOxN8n4I
 YKYuySANxk0mZRy0yFDXH3guPINwvPEK7cPnO1CNyyaPj+zXZ24CBlYRkgNOZC1GCssy
 qh07gN1KT175NzGej5W4CrPQ042OL4ZPJoavnJIGG5eVBtKB5rNqzDMS51N89VKC/O5J
 RcQBEIvhB5P9VFWD6q9W1n+92c5r7Yp5Z4l8a6nDTQA/x1p116JpZk7Wkel8I3DmOPa7
 g/J35LrmSgBX4yC/YWyHRedPEp1PkrunIlZMI1VRpDC0UbGgwlXet1PqbQYjr0jzfAc0
 rpPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD9G5yVpc16FXcItl9Viekkc+xBMROQwvhD28Lo8Dv1CDWJodhZ/PYEO5aZgq0RGSi3lOLoLzYuNpw@nongnu.org
X-Gm-Message-State: AOJu0YwPc+lZKwBlw8BDLUsW305Q2lK/KKMBJ+Ju0o+B4EUFun+kAB3L
 oBtDueZEcQwBsvy8ByTNqRyObrAABbtIBYlaVGuQM2T8VWfY111HHTbcXZS6cNMfxRYYy/mE+y3
 RVhYbi/KDdra2we8bwpGsJ9WBmMzv+ygshx3mGw==
X-Gm-Gg: ASbGncsvGQn3M/dXrg/F5CqR7m19Y6Z7WHSPDRD8uXZrGMaQ6CY+ed//WqKxOTWhfxb
 IpBDdSoqx1XCu2IdJfvdcm4G5zUVWI8va2NM1K/4=
X-Google-Smtp-Source: AGHT+IHPIg+iR1sFJBGNyjfieVhjjoZn0h4J1pu7XGljCtipJUX2pGTyF8c54gRee5FYK41PANUp4ffPBZR7yMQG8wY=
X-Received: by 2002:a05:690c:6384:b0:6e2:b262:bebc with SMTP id
 00721157ae682-6f6c9a1052cmr61737897b3.0.1737030304359; Thu, 16 Jan 2025
 04:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
 <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
 <87frljhvzk.fsf@draig.linaro.org>
 <CAFEAcA-4M5W4=JH3s45+9JZnKrVVAgKcRcH+gVqMJqGxRfjrpw@mail.gmail.com>
 <65e146746377bc307affc627f47c4700aaaac4ba.camel@linux.ibm.com>
In-Reply-To: <65e146746377bc307affc627f47c4700aaaac4ba.camel@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 12:24:53 +0000
X-Gm-Features: AbW1kvYD78mmj7oVZm4dHll4PSr6QHy7K0UVUXkC6YpgD6FPm1clJWaKrwlW85M
Message-ID: <CAFEAcA-ZOJUQPGWs7Czt1A1CdyojNoQ2L62Z-MvREgkg6GO4-A@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Thu, 16 Jan 2025 at 11:48, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2025-01-16 at 11:06 +0000, Peter Maydell wrote:
> > The original reported problem here seems to me like it's a
> > problem with whatever target's frontend code this is.
> > This is a single instruction TB, so either:
> >  * the generated code for it completes the insn without
> >    raising an exception (no problem)
> >  * the generated code for it should raise an exception
> >    without having modified the CPU state (so there would
> >    be nothing to do for restore_state_to_opc)
> >
> > It sounds like the target is generating code which does
> > something like:
> >  * do part of the instruction, including updating some of
> >    the CPU state
> >  * then decide it needs to raise an exception, and rely on
> >    the restore_state_to_opc handling to undo the state updates
> >    it did previously
> >
> > The assumption of the "throwaway single insn TB" is that
> > you don't do that (i.e. that restore_state_to_opc is only
> > there for the benefit of multi-insn TBs).

> The problem is not a partial state update in an instruction, but rather
> that on some targets restore_state_to_opc is more than just a
> "restore" - it is also "prepare for handling an exception", i.e.:
>
> - arm: exception.syndrome
> - hppa: unwind_breg, psw_n
> - mips: btarget
> - openrisc: ppc
> - riscv: excp_uw2
> - s390x: int_pgm_ilen
>
> Some of these may be wrong due to unfamiliarity with the respective
> architectures, sorry - but this illustrates the idea.

Ah, yes, thanks for the clear explanation. The "throw away
the TB" design didn't consider that (or vice-versa).

thanks
-- PMM

