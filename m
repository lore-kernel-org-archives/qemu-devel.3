Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3CBC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 12:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trFQ5-00030f-OM; Sun, 09 Mar 2025 08:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trFPu-0002zU-IU
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:06:04 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trFPs-0006pY-Gp
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:06:02 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abf57138cfaso635709066b.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741521958; x=1742126758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wceicz0F40kTvySS5vdV/AXzv+d9LJILMf9IQ/VOP78=;
 b=hbTDE5X3o1QUFDIFKxRwImbGM2i3xeU44tmdY5DtgUIZrqxIcy0JzQ6m6dIKVSvz6g
 ZN6JWh/6STS2Xo9L7ZilxGiz6V6A7Gl9aKcF2isjYGOLxvFneGllK8jT8EBKLXkFkF3B
 BaWpriHY/dftsWLrrO7v6T2bbPPuc8hC2kQBhaeLFm/2Tg+U1u+kEnX4m5rmZL+8Q2jK
 jbEV9zrVkrGH23XAvJMnJZatj/OdVUW/02dinh+0827gNnWUior1jh6UducPcReirHas
 5rLAXMHMS6EmfPPQYBg5+tXS6qP6LTr65TG4zdiGTpf75cjfVrgMSstVzlmJnJ6nvnRP
 ODQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741521958; x=1742126758;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wceicz0F40kTvySS5vdV/AXzv+d9LJILMf9IQ/VOP78=;
 b=KsvLK/OcP15cMZJo1tm0UmcI2xb57tjYXmHrdXmRYO+YQE20HdVWRQr/xXaQE0Hpp3
 QKYQ8PrBr5Xx40gEd030ROKuDZ6g49hxXgaHnEf5UDZhBazuyAp1aYAaRuyt1gaerzwW
 LNAD5u/mCrKvLttfoO8mlJSzNmjD+0tmv2AkeJWpA8BjONrjIZ39pWUErgfrWwUBQbRB
 /r9ZU+AiqMdbPo8YuptBdpPGKbFxMfNKZGZuM+47SNMTZ/eqomClhavogBBcD9hJpLQy
 TxYiUUsfmKLnV+mfIIEQDqwx5akkQQuShOUDJ6sCNK/JNhLBUJUvTFELxzMyYhRMBFoG
 78rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+PZx+8UleRoff1tRefZ4IAw6QbTrbKl8LZk0kueoPBDjcY5arcrfXdxIPURZYiHDG8NJIxTqcI44b@nongnu.org
X-Gm-Message-State: AOJu0YyTNZpwoWnFQKVAcLZfWjJJfXdi01d9F3shjBwcLmecgv+kP6L0
 Pp1EpzBxKtAsm0xYSWOXjkFNOPwwy2vgqdaq72kgQ15yx5aRrZqxdOeZ1Hd0qAQ=
X-Gm-Gg: ASbGncuc6Co/fqYWmPEQVjqRPjnCJ84ARZ5RhdYnYWNOxsdrgPUz8E0owHolhudgTKF
 vGyqDG+b9noBmbuo9xOpOdIwZVRk8MTexw2quAAssEC0LRsgJMY4LF8RNEeWe/7+pK2bu8FAaDE
 jzmsmyshrcuTW5YrinoskHourdGSZDlVVxjZdfV/Vkq8Vt/FXaIypUgRdopad/e5rV2aiJPCcVq
 jsWRfXetJRWPaS2SWUHP+PQresvHi6bmlqjA33Z93aaSQ5fKvF1dJRVx/GpJ0TPFBow4+UYgmZX
 WQeUhtcxAOieq0FsZzmISJQnG6zrQLhA7ZjaFCsibAJwa6s=
X-Google-Smtp-Source: AGHT+IHMQ1ZxO1JA+JUNqrvna7j7i5aO1GahWjILXSem9umA4s9sQyUQ9gxjmXNe8tyi0NZrOpKg/w==
X-Received: by 2002:a17:906:564b:b0:ac2:6582:1564 with SMTP id
 a640c23a62f3a-ac265821f85mr755888666b.27.1741521958207; 
 Sun, 09 Mar 2025 05:05:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23973810csm583735166b.118.2025.03.09.05.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 05:05:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E46285F9DA;
 Sun,  9 Mar 2025 12:05:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 0/9] target/arm: Implement SEL2 physical and virtual
 timers
In-Reply-To: <e5c5e542-f28c-4f4d-884d-ee3defd0a330@tls.msk.ru> (Michael
 Tokarev's message of "Sun, 9 Mar 2025 08:24:23 +0300")
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <e5c5e542-f28c-4f4d-884d-ee3defd0a330@tls.msk.ru>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Sun, 09 Mar 2025 12:05:56 +0000
Message-ID: <87msduo1cr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 04.02.2025 15:50, Peter Maydell wrote:
>> This patchset is a respin of Alex's patches, with some extra fixes
>> for bugs I discovered along the way in our existing code (and
>> a bit of refactoring to make the fixes straightforward). It is:
>> Based-on: 20250130182309.717346-1-peter.maydell@linaro.org
>> ("target/arm: Clean up some corner cases of sysreg traps")
>> because it wants to use the renamed CP_ACCESS_* constants that
>> that patchset introduced.
>> The bugfixes are not super exciting as they mostly are oddball
>> corner cases, but I've cc'd them to stable anyway. The actual
>> implementation of the missing SEL2 timers also should go to stable.
>> Alex Benn=C3=A9e (4):
>>    target/arm: Implement SEL2 physical and virtual timers
>>    target/arm: document the architectural names of our GTIMERs
>>    hw/arm: enable secure EL2 timers for virt machine
>>    hw/arm: enable secure EL2 timers for sbsa machine
>> Peter Maydell (5):
>>    target/arm: Apply correct timer offset when calculating deadlines
>>    target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
>>    target/arm: Make CNTPS_* UNDEF from Secure EL1 when Secure EL2 is
>>      enabled
>>    target/arm: Always apply CNTVOFF_EL2 for CNTV_TVAL_EL02 accesses
>>    target/arm: Refactor handling of timer offset for direct register
>>      accesses
>
> Hi!
>
> Which stable series this patchset is supposed to be applied to?
> (Current active stable series are 7.2, 8.2 and 9.2)
>
> Or put it in other words, is it supposed to go earlier than the
> most recent stable series, 9.2?

I'd just do 9.2 because I think as you've found too much has changed.
That should become available in backports while we wait for trixie to
stabilise this year.

>
> For example, the very first patch, "Apply correct timer offset when calcu=
lating
> deadlines", does not apply to 8.2 because it lacks v8.2.0-2122-g2808d3b38a
> "target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling" which touches the s=
ame
> line in target/arm/helper.c:gt_recalc_timer().
>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

