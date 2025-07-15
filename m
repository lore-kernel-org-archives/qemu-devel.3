Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03570C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbYp-0003xJ-2k; Tue, 15 Jul 2025 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubbYn-0003vd-8s
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:02:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubbYk-0005Fz-R7
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:02:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so33983475e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752570163; x=1753174963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LcHq0HrFTxs+rNgbY6D8KHMnFY4C6mCz3toLyPh8QE=;
 b=aKiiL+/TKEnVnaqb/mYplcunJlrcFXXBtFUzXQ5vQnpdFVFE7VVZfNV4ZKhDpw01TG
 6WfeRKhm4P6/ytL/0HmOOdHuVCqpJmUe4Vp4DOKUAZR8KjA0y3nAOSvqU4MWp/Sb1QBk
 JBSRMJsvMTpULBhXOS39jGRc0Ci4cny98bJmLD9T9r6Aw3ZuzlSZWAIOoLsSsMqxEXIw
 bro6kWjLhAzeaiqhFOpC0trNp+DXIuR/U3FMkHZyctRLcURPbXYGgQFmi2Q7elCk1aBy
 OWSoepF/xIXUj/UWa1N+JHfKx0dfkc7eduR9F8k0BLwApA07wbR5N8n7gcwCXKh6img3
 6uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570163; x=1753174963;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2LcHq0HrFTxs+rNgbY6D8KHMnFY4C6mCz3toLyPh8QE=;
 b=MFNiAWyckPyjeIv4GTuw63xTZz5jEkqrVSOsZnIgpghHRlRxmdJWdby3vuGWzW/38H
 sxs2QO1SDvSxV2QCgFFPktPzoqfXOUXsQK9r57V40x+W8NVnZ8Ir4IPHlQ7tM0AdVGrA
 w5Dl/TMPi5cBJaDCsnnF1CT4kHLjAg3OuQp/vjee2oBd+bMAo63FbuKR8SFQmLS+cxAK
 DhMNh4rOM7rj6j/ZFvbNjjjfPzK6vDAYeLzdPtKXD1KIWX9n1L04ZwyTcCRyfKAEgLpu
 bOLHY3fGWfu0/cWLHmeZx5FsAkmRDuuBKexPYWrpR3wCKlSw+M0+9a76pHDWL7PldYOr
 mQvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWStnbundU2kI3qW7kREePIzDMwfVuoVcK3xM2xZn31xQi+EY+2bnHWx8hf3o6ObnIwwQd/ixCkSNuW@nongnu.org
X-Gm-Message-State: AOJu0YyX8wyJVkN1W8EqFiPNE9HiMgigJyY8XFElNXvXBTaC6vYmNtE2
 qNv+0DqEVUkcLU1iOiVhtl1+EV691tOQjtiRV5tUjrBPeaNKP5vUqdSC2EwRSPyUDqQ=
X-Gm-Gg: ASbGncsr+GSvYrkg2kVE5YLTS0ieL2OuPSjIA9WN3bJ1QE+FIcPNie4DtZNQ4YPt6GN
 KrL7h9GK/54AhzVsTARS7budi7I9pSQ+t8qdLMNO6Ia6z1nk4XNQfI/02s+bmvh+8gIj/PXr2zo
 uXfWzlkqI2ULA/pGEw23mdiZojudECTSSYYB2OFXz+AgnaeOZicq/VQQgaLsISAhBqqjaZqeBzp
 CuK6LGXGoGzbYJ2VWRxQKhQnLluf20OR1kiB+hMKoyzcyjRn5Is9+Q8U2DIyLC2BEXgLtlQe1u9
 hYxHHo6mwdltcLdC0ESkaMB7MabhRq26r5htgmMc0AkmhiPK5TxaLrxm6TnjwL1l7WUdg1z3IsE
 xuJFctwO/e6KN5c6YKVAbhvQ=
X-Google-Smtp-Source: AGHT+IHqlSeZ1+KAkFZge8c9vluXOtEg0o9DbNN24U30cwB0EIjBVOf/34em6C1T35/UKS3eAr3T0w==
X-Received: by 2002:a05:600c:5246:b0:44a:b9e4:4e6f with SMTP id
 5b1f17b1804b1-454f42599b3mr167475985e9.16.1752570163295; 
 Tue, 15 Jul 2025 02:02:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm73329705e9.1.2025.07.15.02.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 02:02:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F4E65F867;
 Tue, 15 Jul 2025 10:02:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v6 03/39] system/runstate: Document
 qemu_add_vm_change_state_handler()
In-Reply-To: <9a4fb69b-540e-4758-9168-60994f58f95c@intel.com> (Xiaoyao Li's
 message of "Fri, 4 Jul 2025 11:40:31 +0800")
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-4-philmd@linaro.org>
 <9a4fb69b-540e-4758-9168-60994f58f95c@intel.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 15 Jul 2025 10:02:41 +0100
Message-ID: <87bjpl25e6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/4/2025 1:32 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   include/system/runstate.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> diff --git a/include/system/runstate.h b/include/system/runstate.h
>> index fdd5c4a5172..b6e8d6beab7 100644
>> --- a/include/system/runstate.h
>> +++ b/include/system/runstate.h
>> @@ -14,6 +14,16 @@ void runstate_replay_enable(void);
>>   typedef void VMChangeStateHandler(void *opaque, bool running, RunState=
 state);
>>   typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, Ru=
nState state);
>>   +/**
>> + * qemu_add_vm_change_state_handler:
>> + * @cb: the callback to invoke
>> + * @opaque: user data passed to the callback
>> + *
>> + * Register a callback function that is invoked when the vm starts or s=
tops
>> + * running.
>> + *
>> + * Returns: an entry to be freed using qemu_del_vm_change_state_handler=
()
>> + */
>
> qemu_add_vm_change_state_handler_prio() and
> qemu_add_vm_change_state_handler_prio_full() put the document in the
> implementation in system/runstate.c.

Generally APIs to the rest of QEMU should be documented in the headers.
Comments on individual functions or internal details are fine to live in
the C files.

>
> Please make them consistent.
>
>>   VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHand=
ler *cb,
>>                                                        void *opaque);
>>   VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

