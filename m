Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386BFECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6Pw-000362-AL; Thu, 05 Feb 2026 15:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vo6Pv-00035n-2b
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:57:35 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vo6Pt-0005SS-B1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:57:34 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b885e8c6700so252326966b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770325051; x=1770929851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUbUIaJX2ci5rqvp8VgCkUN9A825+dXcSpX06EsbKAk=;
 b=Qzuw+XAKP3TxFhzcmGFdOcFO6RVKfgU3xoKwQtZcymiridt+dAeuJ7mN3BH6L9lljj
 GTm6iprTrkZinYCVFY0WVkDP2isyU8WVFq6veUljeVvXMvxPdPsLlEtuLo3y2x1/jrpx
 +NIRQcGAL/DIP5GxJJDpYrNhl4D+1tX2b31HxkUn+RX/Aba10lHX6NhMjkbJrk/T+1sx
 4fBJMEVj8UgfDkTcGg8Ps6noZppnv87AqWNTC3Z5c+O910mL7p4IYc1IKOrhDxtZ4GRX
 1reZs76ci8BhUlmx8M7bmE3WR4PPkASQ9y7PoSpd7TeEIx0SbQ2rijr9jg2RHgGHH5hw
 VV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770325051; x=1770929851;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUbUIaJX2ci5rqvp8VgCkUN9A825+dXcSpX06EsbKAk=;
 b=rNvM+28G58UFjUL1DarZUjNwT29KAR7Kvy1O+LWUClxbj8PgqU3j4vnyg9z6Uzt6vJ
 qzvEq6XecLoJu+XAoYWZaMAUXuenjbg+r5OiTMr8luJq7dmUxvtWLqtBCR1mNeIVfrIS
 /ByiwqyskknsdgAiL3rwPHzYW7RcoicrGzcBrc7/97hxF6i0GA4hXHQUPpuU8ZmixlT2
 JiQz1l9jSsqH99de/CT8wwJRK1OzT5c6dhcUyuUIR2IeaSn3pgB024UPOQ+BKtAk4sdZ
 eKt1iSt3nVMhmshhqJISiru7fcJwxhOHczCaYpqKOvQLZLRnaTU++/mNvqqGnsIMrhaC
 rHbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJhU+zsyFgF0EQul4ijt/nv7M46bR9FApzMkrIEwssXUecKJqPBlGMGOslZeru+SBtCz8cXZyKol3t@nongnu.org
X-Gm-Message-State: AOJu0YxyszkjtCjmSPrLlwDbuPJpkK+qVJa1dgKwxc243YxC3rqFzCbl
 Vl959j5/u+A6i2qvO7T1A4W1Uvhs6RcBwjNRkyo6iElJ8Knd8vHOamXPTlP03OrbnT0=
X-Gm-Gg: AZuq6aJhVtpZLI8mHEnN4vChKx0RdmCGcIXlZc7cXtt4fOMSMgZmq/qqgFVN21oLVNc
 Zje0gtOLJ54pv2HcZ/iZSxAPv5zTlm+jGPacupRtqi/mv4EMZ13JBWiwfZEwBjRjDUX5SEKLQlA
 vltygzrfGmq+YyxUaNZwSwNkLOqD96EvHCza7gKtSUxK5dDfSiDmKQWe+YsdOAfDPPi/2o7zbK2
 i/PPg1b5P8bYIplNXNn/RPPIck27XKfYlQBOnUd0L3/SdyIM3Rg1fCOZbegoGJCAHGXudIDfai+
 XAl2JoDDQzClEvkDK0cWS27TNXUcPm+dmqb4naXcKNsShCRENcZ9SilYwvecAv2xstYktspCIwU
 a7rNgG8C9AHiommIFrZsGfSYsapcAyLQoV/p9/NGG6rPE5qbW41QNRFFQEXk4L2CMU6WmdowInL
 Hi/HG/9k3I5pE=
X-Received: by 2002:a17:907:a4d:b0:b87:6:3727 with SMTP id
 a640c23a62f3a-b8edf3556cfmr19099166b.48.1770325050744; 
 Thu, 05 Feb 2026 12:57:30 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacb18d0sm18538166b.40.2026.02.05.12.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 12:57:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27C635F8BF;
 Thu, 05 Feb 2026 20:57:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/arm: implement FEAT_E2H0
In-Reply-To: <10F9A8B0-27FD-40B3-9299-E27883823423@unpredictable.fr> (Mohamed
 Mediouni's message of "Thu, 5 Feb 2026 14:02:26 +0100")
References: <20260204131353.2977855-1-alex.bennee@linaro.org>
 <3e6ab807-37df-40ba-840e-4693071691f7@linaro.org>
 <877bsrnzvd.fsf@draig.linaro.org>
 <10F9A8B0-27FD-40B3-9299-E27883823423@unpredictable.fr>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 05 Feb 2026 20:57:29 +0000
Message-ID: <87sebenc1y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Mohamed Mediouni <mohamed@unpredictable.fr> writes:

>> On 5. Feb 2026, at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>>=20
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 2/4/26 23:13, Alex Benn=C3=A9e wrote:
>>>> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
>>>> being programmable to switch between EL2 host mode and the
>>>> "traditional" nVHE EL2 mode. This implies at some point we might want
>>>> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
>>>> enabled.
>>>> There are two values to represent no E2H0 systems of which 0b1110
>>>> will
>>>> make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
>>>> always valid.
>>>> Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>> v2
>>>>   - new helper and properly handling NV1
>>>> ---
>> <snip>
>>>=20
>>>> @@ -3801,10 +3802,13 @@ static void do_hcr_write(CPUARMState *env, uin=
t64_t value, uint64_t valid_mask)
>>>>              valid_mask |=3D HCR_GPF;
>>>>          }
>>>>          if (cpu_isar_feature(aa64_nv, cpu)) {
>>>> -            valid_mask |=3D HCR_NV | HCR_NV1 | HCR_AT;
>>>> +            valid_mask |=3D HCR_NV | HCR_AT;
>>>> +            if (!cpu_isar_feature(aa64_noe2h0_and_nv1_res0, cpu)) {
>>>> +                valid_mask |=3D HCR_NV1;
>>>> +            }
>>>>          }
>>>>          if (cpu_isar_feature(aa64_nv2, cpu)) {
>>>> -            valid_mask |=3D HCR_NV2;
>>>> +            valid_mask |=3D HCR_NV1 | HCR_NV2;
>>>=20
>>> Why add NV1 here?
>>=20
>> My reading was if you had FEAT_NV2 then HCR_NV1 was always valid
>> whatever E2H0 might say. Unless we can validate we don't get
>> contradictory ID values elsewhere?
> KVM with nested virt enabled out of the box exposes a virtual machine with
> VHE-only L1 and above, with no allowance for an nVHE nested guest past L1.
>
> In the Linux kernel in arch/arm64/kvm/nested.c:
>
> case SYS_ID_AA64MMFR4_EL1:
> /*
> * You get EITHER
> *
> * - FEAT_VHE without FEAT_E2H0
> * - FEAT_NV limited to FEAT_NV2
> * - HCR_EL2.NV1 being RES0
> *
> * OR
> *
> * - FEAT_E2H0 without FEAT_VHE nor FEAT_NV
> *
> * Life is too short for anything else.
> */

This is a choice a host can make to simplify things but we want to make
sure we could represent hardware that makes a different choice.

>
> And after taking a further look at the machine readable spec*, 0b1110 is =
valid together
> with FEAT_NV2, as nothing there says otherwise.
>
> *
> https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads

Is this from the XML or the registers description?

>>=20
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

