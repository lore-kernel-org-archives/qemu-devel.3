Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885E4C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnC1y-00086G-QT; Fri, 24 Jul 2026 05:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnC1w-00085n-Mo
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:17:20 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnC1v-0000Os-6v
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:17:20 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6679d88abdcso129323d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784884638; cv=none;
 d=google.com; s=arc-20260327;
 b=XO4/u3z12Rk4vHp/9NHeN0rc6r4/rlRgM2O93iJfyQ1v5honu155BfjcrWhEACAvl9
 3vtROWsmbcP3vibrT7qkxQyDqivI5CFus+gZzyQQsNmGn4Tzt9PT2T9eqgJOkXXvsqpC
 i6pWvZTTRz3s4zdGRgQsYyMtZ3PvYbmWbTsxeiEVnhr6aO9imOcumFekLQqFn0WQ4Usl
 qxtzY/xqeCBsZ2RzTvQB2CaVPEQDulv1qZENLKFrHHV8glBWfDsXMtyFgAmL15p5kN/T
 8Y8QJSKVX1Bu/T4fkpCWOd7/qrindOqeEhtEQpb+RINZBO6h/z+t6bpBZK/PCLTAQ2Xl
 fngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=irN58mUqxkQZ40ty49DFSyyF3AS4XGCjBJ+Y6EbUU4w=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=crDkFZtO72LbA3gqqmMfHD0fyak2GwKKvz7fFbWDUAivsoyJHmCinQCxEoqqlw+r7D
 G6LybcLTmB3T0e0qjtkZR8mHhdIOQJsgzEHVOh9ldr431nzRNqc6ZgDHosKxI/2JySIn
 UHxN+T6Gkj6tNYoM78zRU5yAC1VZA30efc+6S5Grsrg2OmlUsoCfa2+17gS8mCOE4KW/
 ieNcnhSUPHoWvVm48OyhZUGIXPShc+kDvFQa+IKXJg0gjTwlGSr/OAqLQaADcW4+RKAd
 qCULQSvTH5DfPgQF++TRTfMffz2flLix08p5XcvNWqD7RG6CPyVBZBJQTGVB8hoMjyDu
 +IxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784884638; x=1785489438; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=irN58mUqxkQZ40ty49DFSyyF3AS4XGCjBJ+Y6EbUU4w=;
 b=Gl369mtw7cO0iTdAZe6oF/YZATpFIWk8y1I9J5J2c/BJrLAKVuEKxSXz6GZbazwEo4
 Vdelawi1HTSy5xRHcB77CkH/Ear1IUhS2YINnlLbjsSZ1AwfdAHCWiNRAMZZYKH2btBq
 yrw8H0HKuOatWi55CUe7oN4swabb7+nxA8AG+CNpXFrnnK2NNcb3w0CkKmdRPFn+W7ni
 MS06PJSdFMsjmpX0JGa2HsUze3/R1tnZo6FtVryr4kfgBvQ0XR1F7kDTvGAIpEc0dMEK
 UNgRN96PM8c6RaZFlJGWFPMaKuf8PRm1sanYKoG2jBMuJex3+D73TVfTYUZIpa3z8H8A
 G+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784884638; x=1785489438;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=irN58mUqxkQZ40ty49DFSyyF3AS4XGCjBJ+Y6EbUU4w=;
 b=lp01eM/ESo8jHt0+KSivYa/BwEd3dXdiw6n7lHESlKojLfLHDp/JHhESjyI5BAjD4S
 WHKvGK4wShPokyRcB9QMksSX0D2JMeLs54flfnHeEjUMeIN/t87s9iRmmhipDXmGKrN3
 HQ/fZ3G5RsRD78RXIOfeiGEJkUE9/GkMnQ5Nuoh2XTakEPeORKYbS1RaN0xEX3LKhjEq
 OqE1Zx5uVTCV7B7M/gFwpz/bwA9qGnkvKEQ+FAGu5lnO2T/Q+jlwuR7DZ0+CEPopNMWD
 3A0ZAa4e6IpYuqIy8AeoLCni/xfVcDzOq6/A1g8yHSh1DUvAqqFoqcSXWY/2tz7+zCWw
 0RrA==
X-Gm-Message-State: AOJu0YzctO5KzhgU50/pPk4oBeTIH74slm8SFagA2QZugmSrVGu2oT/W
 t3M6jksweFdpFMyW2blRbnF0qVCEwiKQOvxIH68udzFMKQKQ1uZgWGlyuj+TKbAlKGYGJhWyWxE
 2BMdMMG+QmjLE+/uNmejGdtGmsf0I8ksZFEzaR0R++A==
X-Gm-Gg: AR+sD13tC1T9rkb8yKbZVP2IAbOJDaUXOkA8rQuf7ljPZt28Ea3VU6PCzQXxQiyuYmx
 xGo9U5XZVosLKvMN6tZH8A4rakdEXujXC1DLfXbI6PUU1x39kKc4P59WSSLO7tyxEhF3lb609vA
 Oeedeqg8qiCLpSIwRBZaCnzbL1AQuEBRMDkbnyxeCoQIak/Lj0cJM+RMM22eYBVPr64NnqyVvFZ
 pX73Fuh/7pjEsIX7uR3XpMmnj+A7Cr+KML87xN/7qqqrMmLvfqTV5WOUnGZ3rgzFHOxvBNa2rJc
 PONAItrwwmd4L+cwWwObWpRoHVU6nvfoefJMcT3xBjqOWaYeKYtJ7Njd
X-Received: by 2002:a53:b19f:0:b0:667:8014:c3f6 with SMTP id
 956f58d0204a3-668a4f8a3f7mr1232487d50.83.1784884637889; Fri, 24 Jul 2026
 02:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260717174412.88258-1-dingtao0430@163.com>
 <20260717174412.88258-2-dingtao0430@163.com>
In-Reply-To: <20260717174412.88258-2-dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 10:17:05 +0100
X-Gm-Features: AUfX_mx7rKkngbGD_RKEtXKHtpJU0t3FlMxkbdrdQQDn7le9W9hxh0DE4PJePKA
Message-ID: <CAFEAcA84shjJhXraFvULN1nODCBmk7GB4UTnBtTVoEBFdnrxtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] aarch32 cpu secure register tcg migration
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 17 Jul 2026 at 18:44, Tao Ding <dingtao0430@163.com> wrote:
>
> In TCG mode, cpu_pre_save is called when saving state and cpu_post_load
> is called when restore state. There are two key functions write_cpustate_to_list
> and write_list_to_cpustate that use kvm_to_cpreg_id to obtain the regidx.
>
> However, during the processing of kvm_to_cpreg_id, secure state information will
> be lost in aarch32 cpu.
> The code in kvm_to_cpreg_id always add the NS flag.
>      "cpregid |= CP_REG_AA32_NS_MASK;"
>
> The final result is that after migration, some secure registers were not restored,
> such as DACR_S. And this register will affect the CPU's access to the address.
>
> To fix this issue, a new function kvm_to_cpreg_id_with_secure is added to
> restore secure bit information. Call different functions according to
> different modes to keep KVM unaffected.

This is definitely a bug, but I don't think this patch is the
right fix for it. The problem is that the 64-bit kvmid doesn't
currently have the S-vs-NS information in it, and so any time that
we round-trip between a 32-bit QEMU hashtable index and the kvmid
we lose that information. The fix then is to define a way to keep
the S/NS information in the KVM ID format and have the existing
kvm_to_cpreg_id() and cpreg_to_kvm_id() functions do the appropriate
thing to convert.

I have a patch which I think ought to do this, but I also noticed
some other problems in our handling of secure/non-secure banked
aarch32 cpregs which I'm investigating. I'll try to send out a
patchset next week.

Thanks for the clear repro instructions -- those are very helpful.

thanks
-- PMM

