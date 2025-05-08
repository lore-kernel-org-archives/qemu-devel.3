Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D4C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzlS-0007x7-OR; Thu, 08 May 2025 07:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCzlP-0007vR-7M
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:50:07 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCzlN-00079b-BX
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:50:06 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad1e8e2ad6bso180842466b.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746705003; x=1747309803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LowKzubtaLSYHwjDIRe0OvmAO4YDRPvBCnibMEs+9IQ=;
 b=nZSWP8Zekh4wPcVQNp3CATwr+b3SvcDabQLl7AQOr1hM3x7oIxPpbF3ZzlpQQwMImm
 UDF2hcnE18pufd8vXKYR1JZJm0vy3NN7PIjgeQoNamYNJOz7oQbI8Q8WgOwQbdvZVkBF
 roqPCgegkMN18+ppo0M8HThEzrJg47+Q4Mpwpsj1WDdy6GT1SnUj7iuFVlCkZhlzkiB1
 tfDprzjtWcLM4au3bcf18TJIHhPIf8Gr+M6YzbA8sSaY4iwidfkScaEX9R4293sImFik
 gb5CzVAQj/WzvIj+LLuTWA2CtWtAgWspVWBWy68yJzbClFsLFuSmVKBSYThglpYIrW/n
 KRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746705003; x=1747309803;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LowKzubtaLSYHwjDIRe0OvmAO4YDRPvBCnibMEs+9IQ=;
 b=tfZVBpT6bg3/QId7AaAZ6WB3QucxBWa1gvviQCio1OqLeRgpiQakTmkq+K8BuF+jUG
 KLtpDxqfyAU9kB0QMg7PN2wwlHD+aUdOe21Usjv1icrPx4ozJhL6ty8IPEkb9oZgtl9o
 u05ud5MmceMuj58fwR3V8Ew/qAypDt+o3MXSQjNDTPgh0boUSl7OedzFx0Y5oHIaljHr
 oSnyOWrClmtFKRzWBdPwg6+HDA8Iz45c1b4UgkCNIswFwIyTOBknE52It5MSzFpRsfkY
 0obsDUPTEfo//6O2z40pshqBGqPI5QdP7JAPqFbY1z8xMO+I4VqhEvVavsceN0oPu55W
 aQUg==
X-Gm-Message-State: AOJu0YyYML8yMUWwpr6fpGvYX9uOC16OEh1f70r3kcktuVdHwitk8ivI
 Ua5cD2UHVTt5dG6dVOwVmPOd/E4k6zE+3FP4CWjoW4cuXXDikKJ1wtH7Fk8icso=
X-Gm-Gg: ASbGnctZ5fsnijCzmudeG8M6Cf6YBDGLfoTbUkMy+SQbLbOzHkQd0wQFREEyDeurQDW
 uOOLfIOTJRUIMP0cZkt/SimXC4GaLDlj6t7pR+0Bx2lXYJYub0ORlSM+2pu+BaRVgvol/cSgK0F
 9Ihl+kTNnDjj3vRjHUKwN6wkqKQXBk/F3MThWwV5suTi4ocUHCosNDDzMWVVF8KkdvS56y84/Vk
 +Ecod/527Oyc76wuowgKQyIAp19IRDZDpCP9ZiC4i7pb13ICpza4aBljjK5HwAwcDI4fKPiWgtW
 uSRT5TDpbH70ies7BnGsk34bNzhlsOzfaoe7lGNmpvw=
X-Google-Smtp-Source: AGHT+IEMeWXgKS8lRnFGWTh+el+4wd9+9N/4D73LTt7ElafAcLQAz1mdWg66BGSYsWzrInXa1a2AWQ==
X-Received: by 2002:a17:907:8689:b0:ace:4fcf:702b with SMTP id
 a640c23a62f3a-ad1e8ce1991mr668729966b.28.1746705003320; 
 Thu, 08 May 2025 04:50:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895087d1sm1070134966b.128.2025.05.08.04.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:50:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D0465F767;
 Thu,  8 May 2025 12:50:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Julian Armistead <julian.armistead@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] target/arm: allow gdb to read ARM_CP_NORAW regs
In-Reply-To: <CAFEAcA_0cf=XEbH9VQdTHqu1wekSmFDLdqnnzpcwnshCT-UUCg@mail.gmail.com>
 (Peter Maydell's message of "Thu, 8 May 2025 11:08:31 +0100")
References: <20250507165840.401623-1-alex.bennee@linaro.org>
 <CAFEAcA_0cf=XEbH9VQdTHqu1wekSmFDLdqnnzpcwnshCT-UUCg@mail.gmail.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Thu, 08 May 2025 12:50:01 +0100
Message-ID: <87zffnmidy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

> On Wed, 7 May 2025 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Before this we suppress all ARM_CP_NORAW registers being listed under
>> GDB. This includes useful registers like CurrentEL which gets tagged
>> as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
>> registers. These are registers TCG can directly compute because we
>> have the information at compile time but until now with no readfn.
>>
>> Add a .readfn to return the CurrentEL and then loosen the restrictions
>> in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
>> be read if there is a readfn available.
>
> The primary use case for NO_RAW is "system instructions" like
> the TLB maintenance insns. These don't make sense to expose
> to a debugger.

I think we could re-think the logic:

    /*
     * By convention, for wildcarded registers only the first
     * entry is used for migration; the others are marked as
     * ALIAS so we don't try to transfer the register
     * multiple times. Special registers (ie NOP/WFI) are
     * never migratable and not even raw-accessible.
     */
    if (r2->type & ARM_CP_SPECIAL_MASK) {
        r2->type |=3D ARM_CP_NO_RAW;
    }

> If we want the gdbstub access to system registers to be
> more than our current "we provide the ones that are easy",
> then I think I'd like to see a bit more up-front analysis of
> what the gdbstub needs and whether we've got into a bit of
> a mess with our ARM_CP_* flags that we could straighten out.

Yeah - hence the RFC. CurrentEL is a super useful one to expose though
when you are debugging complex hypervisor setups.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

