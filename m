Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40FBC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Rp-000892-GQ; Thu, 08 May 2025 09:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uD1RQ-0007gY-4k
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:37:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uD1RL-0003o4-8v
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:37:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso205036566b.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711449; x=1747316249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jbxqI9YoX3yFI2KB0O83dxnlleOQaSlcM5QbcjVntg=;
 b=ANZMXXvCl3yclrt/f1HGnsGuFXHT+98i5hmBwEIOs1TNZH2N0EH72XFujoCqLR9hra
 h/N9/ths81QghwyCVozZuuqqb26eWrhctA7rH/+776oX96kTJtxXhSdWsvaDawJTPyCz
 Cnw7lbh7H+PRc//b5KqStznDL0Y41gA6Nl3IU0mH3/0rmmRLoSbPqEgUZtqgxFHFUsmA
 nrGwYNLparC7VU4SBVyJma0kRku3am7YX4S/JDHiFu5VJoxD8O2FG7tzYwbV/ddMOP2l
 Z0zeJOR7Wxe0XtKW5ZB1YwYgzSfmQ92dq2QDB6yw7nBYwka31mJZphXuq0xXJ1CKp05+
 oasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711449; x=1747316249;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+jbxqI9YoX3yFI2KB0O83dxnlleOQaSlcM5QbcjVntg=;
 b=hwDMUh/4g8CezJK2T1Ng39YXw5QAOVnwbh9fpuP0jqnnRWB42qQp5SroaA14vgZfNH
 u0vFcW8iw+nbre/folCx15Vyio24DXq4VfFZf8CJfGpGh/KXzObaDEaEngeeGqq8TJa4
 2El9tc0F2L+W8yUGCR907LLTGPebGPLekAvZEvZHUI6Fh9/0qyhOGiFbu2im99/PK4M7
 9yJjhImzF5fDG5DKx1FTLY9FSJSMXbb9x2LWpb8M/niWXAPzWWLeSvhNISaGEgewoB4m
 0yG6LQf9nPxbdfmrrtI0VVKleNmE9QsonLkzYB6pkxrf1xYeJBXwTQelJrGLibCvbOWL
 8MEg==
X-Gm-Message-State: AOJu0YyKfkpNFdTnmSak+tRJkeY4puHtX/txkWlNBA4Xc0KvTLlwxGW3
 U7u9id+NBMAKCwh4i+2JP8U+Cf+iIRDDktSFI4VjciaaOT9b1KbgNSBViVEjvtE=
X-Gm-Gg: ASbGnctKo783MyOpH7OKoi+vmOccSuTHB/MByxnoaVzooscpbhOOHJX/DsRUV1RJMIq
 YyxLMDln1pQNi1yi4MNfLKY82mxS02KgbQ7ghu+uKe1IRKgEJm8ARV7S5p9irZ4RYQT07ti/JzA
 LtXWNlzn2BqKJ+3sARRQT71dgmZ0X0TUahNh81pyU0KzdA5pZH8VM+JnPUP8/pYvZu8IXOBUm5R
 RuI5tazj6d3GXoKUvuoLsoDdijKBDmtquE5ZKy7kvFpnb+qWpSxpN8ak8P0AUqQgHcaSrncL99I
 1BobRLxIc+UXBgeCfBkwNiFB6+lZM8tiQBbKEkBD1cg=
X-Google-Smtp-Source: AGHT+IGwYCeu6ipx8SnIuvLN53t0q2TvGVEWPOzxBDeL/rq61IJqfJp7cA6hJ9cOuPR2PJlRzgDKrQ==
X-Received: by 2002:a17:907:c296:b0:ace:d883:3aaf with SMTP id
 a640c23a62f3a-ad1fe6f62e7mr326991566b.29.1746711449042; 
 Thu, 08 May 2025 06:37:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7781b1d2sm11139496a12.39.2025.05.08.06.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 06:37:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A8E45F767;
 Thu,  8 May 2025 14:37:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Julian Armistead <julian.armistead@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] target/arm: allow gdb to read ARM_CP_NORAW regs
In-Reply-To: <CAFEAcA80-CWEQYwTQPziUxm5V1K93VZstLh2r9mTGkD5QueKoA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 8 May 2025 13:07:40 +0100")
References: <20250507165840.401623-1-alex.bennee@linaro.org>
 <CAFEAcA_0cf=XEbH9VQdTHqu1wekSmFDLdqnnzpcwnshCT-UUCg@mail.gmail.com>
 <87zffnmidy.fsf@draig.linaro.org>
 <CAFEAcA80-CWEQYwTQPziUxm5V1K93VZstLh2r9mTGkD5QueKoA@mail.gmail.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Thu, 08 May 2025 14:37:26 +0100
Message-ID: <87o6w3mdex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 8 May 2025 at 12:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Wed, 7 May 2025 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> >>
>> >> Before this we suppress all ARM_CP_NORAW registers being listed under
>> >> GDB. This includes useful registers like CurrentEL which gets tagged
>> >> as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
>> >> registers. These are registers TCG can directly compute because we
>> >> have the information at compile time but until now with no readfn.
>> >>
>> >> Add a .readfn to return the CurrentEL and then loosen the restrictions
>> >> in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
>> >> be read if there is a readfn available.
>> >
>> > The primary use case for NO_RAW is "system instructions" like
>> > the TLB maintenance insns. These don't make sense to expose
>> > to a debugger.
>>
>> I think we could re-think the logic:
>>
>>     /*
>>      * By convention, for wildcarded registers only the first
>>      * entry is used for migration; the others are marked as
>>      * ALIAS so we don't try to transfer the register
>>      * multiple times. Special registers (ie NOP/WFI) are
>>      * never migratable and not even raw-accessible.
>>      */
>>     if (r2->type & ARM_CP_SPECIAL_MASK) {
>>         r2->type |=3D ARM_CP_NO_RAW;
>>     }
>
> Well, we definitely don't want WFI or the DC ZVA etc
> "registers" to be exposed to GDB or for us to try to handle
> them in KVM state sync or migration... ARM_CP_NOP is less
> clear because we use it pretty widely for more than one
> purpose. The main one is "system instruction that we don't
> need to implement". (CP_NOP + a readable register is a
> questionable combination since the guest will expect it to
> update the general-purpose destreg, not leave it untouched,
> but we do have some.)
>
>> > If we want the gdbstub access to system registers to be
>> > more than our current "we provide the ones that are easy",
>> > then I think I'd like to see a bit more up-front analysis of
>> > what the gdbstub needs and whether we've got into a bit of
>> > a mess with our ARM_CP_* flags that we could straighten out.
>>
>> Yeah - hence the RFC. CurrentEL is a super useful one to expose though
>> when you are debugging complex hypervisor setups.
>
> One problem with this patch is the one that the reporter of
> https://gitlab.com/qemu-project/qemu/-/issues/2760 noted
> in the conversation there: it will allow the debugger to
> read registers which have a side-effect on read, like
> ICC_IAR1_EL1: we almost certainly do not want to allow
> the debugger to acknowledge an interrupt by doing a sysreg
> read.

Doesn't raw_readfn offer these semantics?

    /*
     * Function for doing a "raw" read; used when we need to copy
     * coprocessor state to the kernel for KVM or out for
     * migration. This only needs to be provided if there is also a
     * readfn and it has side effects (for instance clear-on-read bits).
     */
    CPReadFn *raw_readfn;

So maybe:

        /* We can only read ARM_CP_NO_RAW regs without side effects */
        if ((ri->type & ARM_CP_NO_RAW) && !ri->raw_readfn) {
            return;
        }

And I guess we can strengthen the gdb helper to NOP any writes to such
registers.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

