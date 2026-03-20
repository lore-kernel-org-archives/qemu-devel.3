Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F12108B8ED
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3X5x-0006yp-69; Fri, 20 Mar 2026 06:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3X5u-0006wp-VB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:28:43 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3X5t-0008Hm-Gn
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:28:42 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64e8cdafeffso2582954d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 03:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774002520; cv=none;
 d=google.com; s=arc-20240605;
 b=ImNQk3sjlLIzj96oU7/bhhrurp+qR78XovgP5gyvVoNU6OtfxufRpDQpfY5Do2wVpV
 IjhL906kvjQI7JlvVT24YMQuQnLGSCTu4cChQeEeuzGUcpiF4iOO+WAOpPNod5yUfg7b
 u6EKiGZ33iuc/1tv4NZfezAVRxKHTUK8yUiJDT1ifeopfUBI3njUV+kv0XqV87mvWVSQ
 gPzMIFU9n/6KUW3CXL33L8FfN2peukb9Pyb+jxO/7zqeTHPxAJCm7oKh/aYnTM36fty9
 aRXbnEJIf1PcKU/nYS/EKAWfr9nK6G5diyokT6jNBbyFcpJNN3S68bwxo9kD682X6ELY
 FriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ftDVjc1lykJ4+8OQ8IymmDv9IAZH6bBmh1T4cjf25S8=;
 fh=9++N6Qh2BU0Z9FOidl0eHc3bs49pQ2S9UrfQkUwt7zE=;
 b=lo2J2U5DFi35BP8uxXgL+rf4g7kPCbpMZiAgaXWin0KLdy8NLcx5atOCKwepRLuEWW
 d+YOC1s/IvOqFTOvebipJteDvIQ1amqrxAe7SqGim+1jl2BUXy0NWXMsAwcsHDymc69h
 bJS2sPvD5+kMDKWDk54FErFyfj1KbREJOtJnRqrvroZ0ZcvtVqTCRo4itNbdRS0q8dYP
 Q3ieDcKPGnhqj3bWZPV8lJWywyUfvwmO4PYm35QiAFW2eL2keBxtbep3/pSoHdkSRAW6
 R8penBvp5YpSGtSlqA0pEhRmg6YlDeHHZ0nfla3lNHq0oj1Q8Hr9xPwuEJCM5B0OmLUu
 qwRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774002520; x=1774607320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftDVjc1lykJ4+8OQ8IymmDv9IAZH6bBmh1T4cjf25S8=;
 b=eeAI/eK6h61uIMib+U61KNxxaMLMHJYHBIx0SrrT4t0oL0G2/led4Z76/iiD5QcMDm
 k6Q8Pa4JotYuNRRPY0/T6XxIQkXm5v1XttP+i/OTQtWp6RfRAvIxZXfzn7KUyRvzCVmz
 oENBqfL+FUWWGCpXQQZ/yoL8pHjEUK1DWd02F3xBY5pbSNfy2EM6T6mySBP+D9Bh67ba
 ONSBcQ/HGMM/raFUj6ZYseCPqKelg8kah+tLRujMd3ap5ZjKMFjpmsLVEKS6WBLThn0E
 MVQaAGJvsH6kJHW4Fz7lpmuG/xGWGmhV7hMHaYY0gjBkfa8afE4KQtxJOERHWk8CqWjf
 UDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774002520; x=1774607320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ftDVjc1lykJ4+8OQ8IymmDv9IAZH6bBmh1T4cjf25S8=;
 b=ZNieVaOislMKhMzHzAI6PgsN0IXDAP0mzXEF671i+8UEcN4zwfEeaXXUsIr0kU60Rf
 fm3i0RNzlWSmtekaOf8/VusK+5xBnAchqMjM9TxDRrkil+UgFT8yNkpbBjxKAErXkGma
 sykxY5L8xpLjVsdBa7YFjruce3ks9FXoj1HfXBKk+lNGa6N4rzwLN/H2aSJSWJOU+K+d
 n+4aAQ7fwykLLBSMtfaRzOCrahgiih/6NOu1cYKr5JIEOP5Kh/Iw/67lqFNjWYPDvpXP
 gEFWdCeH68gbaNGdgzgslNqM/f6CeJfcvWFHAtqmEqs/mtm8b8XMJN6sgd2R5lm8zhnN
 RM3g==
X-Gm-Message-State: AOJu0YyeOzgy8Ag5dw9Xr5QGEkmwBJZ1GxqzkXgWXyY/3jN4TTAczUeQ
 keCFR4W3QI4sHb/oL3p59iUoxF7L5bwdC+xB7BGiJjv/zQLCnmeOTDLfq+QkY+F9JCqEA+DhYKa
 5Z2cYAcT9wHIvxn8Z3/VzG4WyrNLT53TFPnkcwkX2jg==
X-Gm-Gg: ATEYQzycfKLfABC1p4uHrHi/mLVsW0H32yhnZd+HE6MM+cMdeLxDN7xKm9B2ZXeeWNH
 5elPmGYWR8XWR5EzRPtpBH2hd2mFaGkAqbFB5jwZxVyd+2fofLXM0VyYGQlkNXw+bjMnNof47p/
 Fhn9sH5ecDrcXP12plDm/jfSUbXiGCoPMo9o0Saf7cLYewawESf4pXn2eiHcSqBCQv/BCKTW5io
 DQVjpGANTavA7WoIvHMpSykwSGbAaOZo6dSGWMupqlCIeuJjNN/C7kfsfdypSH2RHA0Ec7AA+1S
 Z83WK8NHPRfBzsdzSiMKc8LWcYPmfGlGG3qb6Qgkc2vdA01uPOZL6af/bCXPttImVD8iba76tLa
 A7g==
X-Received: by 2002:a05:690e:1341:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-64e9ce746e4mr5909433d50.33.1774002519945; Fri, 20 Mar 2026
 03:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260319104414.66367-1-philmd@linaro.org>
In-Reply-To: <20260319104414.66367-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 10:28:27 +0000
X-Gm-Features: AaiRm52qN88KA0k1C2AETQcj-KBNSPO9j0WdvTs_ZM-sGPPlrjz7HD8GNPvVRbI
Message-ID: <CAFEAcA9kmZp-ExsV-8k7fZ1nsGOyvnPZQ9tD1hrCTihxy=uRpQ@mail.gmail.com>
Subject: Re: [PATCH-for-11.0?] configs/targets: Restrict the legacy
 ldst_phys() API on ARM / Aarch64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 19 Mar 2026 at 10:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Commit d751921cffd ("hw/arm/omap1: Remove omap_badwidth_*
> implementations") removed the last use of the legacy ldst_phys()
> API. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
> hide the legacy API to the ARM / Aarch64 binaries, avoiding further
> API uses to creep in.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  configs/targets/aarch64-softmmu.mak | 1 +
>  configs/targets/arm-softmmu.mak     | 1 +
>  2 files changed, 2 insertions(+)

We might as well take this now, it's pretty safe.



Applied to target-arm.next, thanks.

-- PMM

