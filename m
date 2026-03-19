Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E36F1091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3HsU-00089Z-1A; Thu, 19 Mar 2026 14:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HsI-00088q-Ah
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:13:39 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HsC-0001mi-Fl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:13:35 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ca4dfdd88so1594004d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773944011; cv=none;
 d=google.com; s=arc-20240605;
 b=kqsGYLKelSZc61iPqYREcJGBAn93hmHIQhl0ne855COcU84MgJHvNHDr9PqXxTG3Yz
 ltuBQiYpjSy83o8/kj8b2Tbd4Y1c+p/KyxD1q9vivSGD34Y+SU8ajNy4dr2bz/wAhNIf
 WHbELfuwFQ9RJk6fZnb6fDRIUGRrXhv05Jpfy8IUJmQ8YETjdIbQat4wkNheyPynTHtL
 I0zWM0SGDq46jRakyEBWeQNe5V0DrwWJ4w6J+EG/aNVPuOl/YI9b/Jc2qf0OESfNXatV
 /4pnmWX/sSj7yySjgeYk71ajedOLd33yX641JVGUCLuxnwlrfeiTmnllpp9KKBcWOH11
 n+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h6dUmwybOkzd+tc4CxA5WMU2XRCU4BR0Zfvfg3spHAg=;
 fh=WibSQDncNgWSyywKvPHAKYpHRJ63hQ7/by0Ly3U6FhU=;
 b=ZMtv/xcvYwWJaf+2FDFHJLCyWef0Z4J64mnmDoPXNqOn00IdHfipwiEMY7anV0Gl6F
 RWpGPcf+4HCVFwjZF4WtBfVDWxRTcIHQtFiwnA1+EPG4RQpjO+KNRlTN+qfVwXloEkqI
 8NDqnJop0JUdNo5I1RsKX7opVnl7KiOuc5TIQwgg6PpZTjiWgEfgn/J2TcfdR/mvkFzL
 xTde56SNJ/4RQudTwATWQ3Up2971ERd/3/cN3gZUaRaRr8AM7Cyc6JcE9SrdByJFmjkj
 GQ4ILISb5/jironuTJophzzIxCgU/HyjuUOzcYZkUSZWd6vEDcapJawFEhzHey9mWj34
 BeNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773944011; x=1774548811; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h6dUmwybOkzd+tc4CxA5WMU2XRCU4BR0Zfvfg3spHAg=;
 b=qFCLAOUpanfCNG0TchDKpJSzf9ZV3U6jQ+4nF3J1ycp+qta6/uRZfGrcLKMzu5hOX4
 f1dMyFD0H608svtO8MmD6uZEpLVZbxUS9W7BvMGLVadnQwzqEl65QZ+iooFdTZCo3SHP
 LjeyEojn4+At7o612IB3952NyDT0ZauJIuRzOQYAhE3+Eklo1vPzzpmceq3JHDmNLGaU
 +afJNnzEM30cyHMfG8OJZ1KKkMoUIyaVCtrdFLKVubDmZiIzYKVXxTdaPrhFN9YVmcAU
 mX9LChEF4cpL9z0TyNsjCaDof4TmD1T/MDwpg3NjLiJaNpW9VwdEr6V0Aiwr1W3ojYi6
 X5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773944011; x=1774548811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6dUmwybOkzd+tc4CxA5WMU2XRCU4BR0Zfvfg3spHAg=;
 b=eA6i1FwtKEdlW81lPFju02XvbZ8mgaNJtsrnd0/Z0/hoYfZzoj+qdS1sFX5XGaycEF
 ATXom99lipy2eIGf+uvnkx6VI45MOGJMO3FlXdRJk4fQV64a6zEPSFVVhJsNxm6ob3er
 DQxPThEDQ/iCV1wvuRq9IZ5xETnS9rHE92u5t0n0lD0wtUbH7eHyyPSu463+zuvl6ey5
 igQlr2AKyRpDdRS4z9vi+CjF+zXlukYaH+3hgSMwWHeos/t0Ycvp2udDqlhuNThxIhiB
 Tq9EHXRnk+r/NWSzBnjcG9SudoOn9y961Ivz/cRcmVhEtGjgGLi+XMpcIo6Coyp6K39V
 9aJA==
X-Gm-Message-State: AOJu0YyePuOYq3IzqYgWCjZVcVcG0ZfhbrGmZ2Wr2+encry6hYJ956rD
 0eWq4wNPAYVHON/7jXeNLPc+Yk5U5Y7/TsZvj+S2zjVSDyunR8/jGqGB7E7eeH36wsAQ/9ULrWw
 p3rkAMVjo1it2eOvrPporKgM9wX5KUgN6aiag6+qfsA==
X-Gm-Gg: ATEYQzxAp4UGmPgkuUSlc6GVzN/TaprundiVobnqmZqis5k7ZdsDhnkf6e2UuRQ5GLD
 sbKOAnOLwoWxSeXIyYdRNq5+efEOveqbNH6Kk/36i1g4E+KJCIhc4U6Vv/RbLJaox8JIdCWvIBb
 tY3FpZ2u/7/9PnaxZvZXs0DzMSnH+49OXdv1geUX0G5t7P6xzQqg5LEZRTEiDpt0CMZ0JnyT/Sn
 c9cRXH8zNZDopZIeewMbMYp36HhrtY0weqFjYgSAFeW7Slr51aG7a3hmXHMIhBeLR7JaN2PoFe8
 IBP4h9HElyiO0BGHSSlwVU3M7eDhm2REnQjyfiz9/Qplb5xqLoEJY4dcCPJR4C11vM8=
X-Received: by 2002:a53:cc0e:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64eaa7c3e23mr380500d50.43.1773944010734; Thu, 19 Mar 2026
 11:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-4-mohamed@unpredictable.fr>
In-Reply-To: <20260314221529.47841-4-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 18:13:19 +0000
X-Gm-Features: AaiRm50gB-YMmG7ltq34QsEMJRsiadnSsSPzaN4F4omYbrcr72mPhnaAsjbR6g4
Message-ID: <CAFEAcA8v59wSwRvig6NRjWHyvBGY=gPhWFN1B_jD9k+aXqo9Ng@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] whpx: arm: enable more enlightements
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Sat, 14 Mar 2026 at 22:15, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Linux uses AccessVpRegs without checking availability and panics if it's not there. Expose it unconditionally.

The commit message subject says we're enabling enlightenments...

> @@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>      synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
>      synthetic_features.Bank0.AccessHypercallRegs = 1;
>      synthetic_features.Bank0.AccessVpIndex = 1;
> -    synthetic_features.Bank0.AccessHypercallRegs = 1;

...but the code change seems to be removing one as well as
adding the three new ones. Intentional?

>      synthetic_features.Bank0.TbFlushHypercalls = 1;
>      synthetic_features.Bank0.AccessSynicRegs = 1;
>      synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
>      synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
>      synthetic_features.Bank0.SyntheticClusterIpi = 1;
>      synthetic_features.Bank0.DirectSyntheticTimers = 1;
> +    synthetic_features.Bank0.FastHypercallOutput = 1;
> +    synthetic_features.Bank0.AccessVpRegs = 1;
> +    synthetic_features.Bank0.SyncContext = 1;
>
>      /*
>       * On ARM64, have enlightenments off by default

I've taken this series into target-arm.next for the moment --
I can either drop this patch or else fix it up depending on
what the right thing is.

PS: for commit messages, could you wrap the body text at
the usual 70-ish columns, please?

thanks
-- PMM

