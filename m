Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FA9F31E57
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAs4P-0000La-IL; Thu, 09 Apr 2026 12:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAs4M-0000LN-SG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:17:28 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAs4I-0003J4-5d
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:17:23 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6507a7d2eccso1144587d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 09:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775751441; cv=none;
 d=google.com; s=arc-20240605;
 b=OHjHJTN+jhqsmLVcWy8l364U4lUL4iF0oSGd7jGF4Cer28haeb8chmfyAvcNI5/+6R
 RH+P6Hh2hP78+EGS7i3sJRCqLxQcj6m+TXipw28EYxlYedr3oUK2GUrG8LhlP/yxgMMp
 us3YLVpvQqEujfBmduUK3b5pt3At7tcFGl9el8jBzokH5MdKzLA5mCoE3isegp3oSjwu
 R42a6exWKHjCNN3IXuadP0fW0vagqr9AmsPDBMu0j5jMYGcdF1B0Dj0OSrJKbBzA8cA6
 A3IzbW/pRYpO9qMzqSuVabuyfusutiDpmKEXof2EWOH03SAme4/iIkplExBcQ2dIrfwM
 RvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P/ZnN0f0wUnGZgYsNB0YAHdKqMgxio/+kVecTuolZnw=;
 fh=VQTX0KcHLYp0W1xh5qMyMVzUksc/bNzicpit96Uxm2w=;
 b=U5UjchHWKB0+HYOI4xAvVLhriBZj8EEQKUfStiIZQaRF/INVk6PGCvwiA7MIYHt76U
 BvnLANu3EFzUBjCjC08h8zAFPsMp4Ac1FGQDs5OSoZD+eMmkfrl9YwFkE68ekrP5I/Sq
 dTKTL8Jaqj3ejqu3ky8IutkO4msWWiXW3PTbdherldPkT+w4n5TEVAOIDc40e2dA+i+V
 9y3g6mOVXiJjFvpp5WP5k0/AJKZxo6wMLcoHKP9zp+0rAOcyyBkYazUr+4sjFWLrAtx1
 cUod3BPrgJUpdacNbwPlRiPA4zpAcELL/nm6o9CzbusbocW/7tX+znt5cVP9+p3Pvn9Y
 RIww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775751441; x=1776356241; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P/ZnN0f0wUnGZgYsNB0YAHdKqMgxio/+kVecTuolZnw=;
 b=bhoGODsteXohxl4OfRFVK4+QyrJhg1Kax9XvlGE7rMC9+mhrChOwYjFFXrrq8nUp0i
 5O3OAhd2AFLhqrWOG6D/4NdVdb8BcMruIxSj2bQ9jraU2u+e0Ul17UvaSi7TgeF1ykfs
 g0+7vQiaWPG2DRtb462y+Xe52LFcJGYV5YL8QROozUQTPM9KBiklDk9Nd0pYhsbPmy5W
 fpam746kCkStrXcC1yk4TT30RgknB1DAwQ5UQ5+QIHEQz6H7JaMY84i3BZR9i0iL6k8m
 00WZftgb8iMrAgCuCG1UoMVQxvsIRJDbZW8GIm/upAJX0BDo6rbtga7ZCVR/UvdLQ6oG
 aXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775751441; x=1776356241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/ZnN0f0wUnGZgYsNB0YAHdKqMgxio/+kVecTuolZnw=;
 b=oTOInHMHif0HEiTJS6sTVHVjaepqhpd5uRO/KsWnlM4aEJgVheTK4fGHGrWnWEAAQ1
 1Wo+TVRlhbXlSp4HEEEbLPkcMa/tTxjL9y+zDAmVeymEQ4DfuA6AWTNeYZ2msSupL+p6
 LRd54THPbq75bM/VwKc58kTtWN/UkoFqnxMVYjEyyUdLLu0ubWGVmrVWy/3t1bR1RzQ0
 xsVjRydA6tjHDBv9ZcuIE5AeLrEN4hr0u4TX9a/BV6BVMHbOpjs8SZpd3jc0T2eauJEB
 JWX094sZBhAepPzeJgORN/0dkAXCNzo7q8BphvIGyhQPp3Evy3C4tFDVb0+fB1k6qafs
 Y7Pw==
X-Gm-Message-State: AOJu0Yy8MePamNTnvwGEZjxFzzLlkTir4xbRBrmDTvyrdFG2U4fCfp/C
 sjnI1Ur8VTIKMeuViefR+Iy8UbOmy+/rtWIGwZ0DLyjOSkpwoqsis+P3J/t7oPQ5nUR7AcQmUwa
 GIVnRwZwp9AtaBXkj6pat3otGh2tj2TAAdaTVnGyjsw==
X-Gm-Gg: AeBDieuG/fZs9/0wpISJxZw0DtLV2XYawFmpvFlJROmUodD6FLJP4rVhh0/tsIsw4eV
 +hcdXTTTJKyA8RsrJKLjx8BJa7e56NfF0g9Ni6PhLRwx09Z+pJfde7s+VFj0jRbAfnq2W1iCTw9
 HuzGabGhwiToqVUvDqp27TXOMGtcLnWDXDuhohFKABk/RsHKt4b02zYZNfKeiCUtAgLTPJN1kj8
 vML/R3d/l+KL//13HmzFbB97+WazVqWGeQzq3UyaiSxFzghj8Pzv05KLvCvSS8pOLptjeZdvxhS
 40SKCRHLbRgKh5NYHWCvWC7TCdeuf1ZyEVysz80N8dIpZtzAzZCAEV+1mYu+J1TTAh0=
X-Received: by 2002:a05:690e:1914:b0:64e:e82e:8413 with SMTP id
 956f58d0204a3-650598d9194mr19720821d50.1.1775751440575; Thu, 09 Apr 2026
 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
In-Reply-To: <20260408184228.44242-1-james.hilliard1@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 17:17:07 +0100
X-Gm-Features: AQROBzBD4M1uxmn4nmj9JyvoskAY4hwwSca4IJTYjvIIgQCJw84Y9VE6vqwNQtM
Message-ID: <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: James Hilliard <james.hilliard1@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 8 Apr 2026 at 19:43, James Hilliard <james.hilliard1@gmail.com> wrote:
>
> MIPS glibc startup expects the thread pointer to be live in both
> CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
> cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
> unchanged.
>
> A guest can therefore successfully execute set_thread_area() and still
> reach __pthread_initialize_minimal() with k0 == 0, faulting on the
> first TLS-relative store.
>
> Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
> MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
> updates follow the same path.

Where does the kernel do this? Looking at the mips set_thread_area()
https://elixir.bootlin.com/linux/v6.19.11/source/arch/mips/kernel/syscall.c#L87
it looks like it sets CP0_UserLocal plus the tp_value field in the
thread_info struct; and I can't immediately see anywhere where it
would read either CP0_UserLocal or tp_value and put it into k0.

I also couldn't find the MIPS glibc code that uses k0, but I
didn't look very hard there as I don't know my way around the
glibc sources -- do you have a pointer to it on that end?

thanks
-- PMM

