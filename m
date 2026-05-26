Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C9CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnu2-0004cA-TG; Tue, 26 May 2026 05:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnu1-0004bo-Bq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:16:45 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRntz-0000GZ-OI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:16:45 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7bdf83185bbso100855177b3.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779787002; cv=none;
 d=google.com; s=arc-20240605;
 b=L6+RVneMO+IGG3ReSyFXzNbPTwPRwX4Sg2hCZxKMpbUxajUxgiVOMxkN1RJVLjK/6I
 BuugFwv0VmpIwoBEdmf2d4YvwUCi+eTZS2ByEvSfV/9p8mB1/pP8AcXQiY6R3biVJUJX
 q65Hiy+0CZ3fENUXuZExVWyFScKWxPX6+hM+PnfsKsMRofI/E5iGFdmK68dfmmC7EBYJ
 CAGPPfJeCwxj+98nmtpb3Rjh8ficYWX+OX/tBF7K9PBfensIkNHpmlnhwykryr18XKjt
 vo2/+l7dVC2Giji6L6MypRlQodTdOozFHQxT0VDK0Pe9V4ZKyUwTbGAuD8Lfv9GTyidD
 T7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=qQm5IUUOEJMJxBOveOn6m8VarH/FynIw8RGfUUbzmHI=;
 fh=6WB3AHQOWhs+zS2cjouo6O5uBaUmMIjVRV3nKvv4xAw=;
 b=EmfhH1U0pKAdBLdadux5LnOqIFl0FZkKpDHfdaiXqvlPqjnm3pG8U55fVLe/2grZsj
 k7KqTE/1+Jer5pd/grX3YZIIKHJPrkEvy/oxwVzDE1deLkJHlILkwCBrZIuHOMDSaSJJ
 bDOgfO2QmWOcsL3B86YHM2dKHezdJWprfjEmuZrvcCQOge04xsVxsCqCyUH5y5B/TwEy
 Mxlyt2MeDXrBblXERPHw7S8q0urNaFJtcG3ssXqJr71YZzXYMj+1afnckelwNughtx1e
 js9I5wdB1//b6eMt7O++QCd0xZxZKptFxLo6Ag5bj4a0mtmwepcPBEeSYRzgC6wiAAfZ
 /l1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779787002; x=1780391802; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQm5IUUOEJMJxBOveOn6m8VarH/FynIw8RGfUUbzmHI=;
 b=UjFoDaaPZN4GlwKiaudGeed+/GjAda2MnfYObnenClVINp0Qw3jIGfldleUsg9RIZj
 agtMamDN8TTPSvL4EoN5rvakYe54V/DFbK3/w/dAVOHspGo2TOrkjqPz3x34Qq2ghjO9
 4DeFvZLtpzLcf/xdBh2415SscR6ZJCnHkB+KtbtUpCI6EyXRKYRSemxQpnGY99Y0B0wQ
 RQr650nszVsSp76ZvuY9vGYTMlJkC8lF+fCn+RICSfo3B1Wc6wJc6OOius22W7qKFG+T
 YNs5N1F/waJqt9DWi1eeIklaV1TUpExXe8WLx7NEm5V01sOLgXMyLpohjaxo25VsJ+Sd
 aNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787002; x=1780391802;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQm5IUUOEJMJxBOveOn6m8VarH/FynIw8RGfUUbzmHI=;
 b=qLDud3Ng2bBazhw+pnWiV3OtQJK/rAd6xyrf7EzRnvPckbRbbjLxcYOBcAGHqiT5/m
 XgnFwNBOMDHtAFQKvVODZJ8VtKqHfzt1bsHdWv8rVK6f7nY6uZFGe+hwOtjQqgUJEkKh
 zsmHbYXaGh9VfmzsvZP8th2mr/ekAOSMd5EFi6I9V57GY1X8iYBuvUYY7dGDJdNJlkf6
 +CVywaJIEjyNsXIZolIX+SF29qSCQO5rgZN/6PRUAmtYBKcZh0AyJSiK5hhij6AM7cso
 3wjQszbK3kEWjfAggoAlNfjsk7GmVQ1PmBOlOA/7SWzsA+T+gva+JzV6nb5qFFXt2+w6
 3zLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b37IMBIMHIvOmCFuP50UiYL2+n9/mUO3bv7TNylu+SDbp7uLVxbecoKFR9uffC58pFpCnAcwEDD8Z@nongnu.org
X-Gm-Message-State: AOJu0YyWC7wbT7m33qd3MpIk4UK7k87X6FjvRErw35xsIWQ8jxwDk2GD
 gj4tWLdLrtwpq+2fCdwym4dTkzgW62onrruNl4eRBxMz2N3Du5t6PiRz2qtt/i5o+5LHqBJY120
 jwozmzOMqUwVPUroy9+QoY/Dx3bmD11v7GEOXGvgm0x83+BdKzpVo
X-Gm-Gg: Acq92OHdju8PZmh2a9svFnAA7iUhQDpjqUIJrEyxUqbSC7PRW/I3xRhxnEGf8JwraqH
 r6bZpO2hizVeoxNB0L8ZRU8l4ClnKGzZQvzIIT5ejRuYhH+c0OkYwp3+Hh7Lkgh/77ah7J1YS8Z
 cstyJjCZw2fxTjwxvyOL1lLarkHf0ACZUEqzXzW360NduTxNez6HktWdK+R45Qjbx/NlRuub0ja
 Z3328NCtRx8Ce/eCiUtjJlqHC0WVNhdcOP1/HmuRtw2a2dgL0gXFD2vllT2BJHkUui6KfuPolx+
 Z+n5iGbE7qK92wGw6saGBnLMt0uEq+loslRSmscNMw1bGno5PuOqD9wIok+rU5yBxmy+pNvwvM4
 1Hg==
X-Received: by 2002:a05:690c:6f06:b0:7bd:5b06:b35e with SMTP id
 00721157ae682-7d33b0445d1mr182806817b3.47.1779787002350; Tue, 26 May 2026
 02:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260515142541.571911-1-peter.maydell@linaro.org>
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 10:16:30 +0100
X-Gm-Features: AVHnY4IStFn3JjfVh-J2NU7wXrAW3b0jK0T2sfKJXvi8I3kgoq4xZoMJrJ7eYG4
Message-ID: <CAFEAcA_WZA+XpmEDcrD4YfmQ8re6XeQJRLRQYap18C=1AvviCg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] target/arm/ptw: Flip sense of get_phys_addr*
 function return values
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 15 May 2026 at 15:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset changes all the get_phys_addr* functions in the arm
> page-table-walk code so that instead of "return true on translation
> failure, false on success" they are "return true on success, false on
> failure". This convention seems more intuitive and it matches the
> sense we use for the translate_for_debug and tlb_fill_align methods.
>
> I've marked it RFC for two reasons:
> (1) I'm on the fence about whether the upheaval is worth it; I
> think on balance yes, especially now I've done the work, but
> you could argue the other way
> (2) I'm open to suggestions of whether the patchset could
> be better structured for review

Since the patchset has got review from Phillipe and Richard
(thankyou!) and no adverse comment, I'm going to take this as
consensus that this change is worth doing.

I've applied the series to target-arm.next.

-- PMM

