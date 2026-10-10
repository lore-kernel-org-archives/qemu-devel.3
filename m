Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0DCA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFSnH-00043A-HV; Sat, 10 Oct 2026 04:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFSnD-00040e-3c
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:50:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFSnA-0002Bm-QK
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:50:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so3463015e9.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791622254; x=1792227054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G+tz0bKnxIdUUmEqjeK+D65iiI9pOg+Ler1x1SpkwIM=;
 b=JbsmQjCOt8IQyj0Gr1IJripIze4cvlpHof3KyjIYtjCgJZwbrULhs6JglntC60cQZs
 4E3pLWPkcVa053fL1yIv9O+N/TrCioZqIpAlshAPIjx6+cImzs3xcmwaeEIIZWuN9594
 HncsSTbBcn4NEjTIDbRg41uCYUk8pTw9zaaxDeNaj0Nwf3cbllVz9ECG4aq3vMnaR3oW
 W5bKulkrsAxglSyl9rZUEme77Uj++oFAftw3YlWKqWAWYa80QU2WGFqrQmweAuqJXmQ5
 wTa6S7tDBZ0kwb6Dh+ZCwNLzp6+f2OoTFguc2QNKJNfdyFNosKgMy6kJMag0oABFKobu
 u9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791622254; x=1792227054;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G+tz0bKnxIdUUmEqjeK+D65iiI9pOg+Ler1x1SpkwIM=;
 b=1erXKYsX2HK9sO7/YRomDHAWbyDz688SlshmLqpIKB50rHcv1CjPlpwAlAhb9YrKaK
 ZSqW0j2BFJJtwsjjxcdsMwpBtYp3QaVAkmmYifofPFvgWMuWhb9XyYZq7pzHmhjovbTd
 vWShHX3ewg9pgmy02GhT9JGmUWucoxOPZ7BXlBx+GSZSE0hhnhU3mqDXMcsfq1cAmIoc
 LbWlaXc1iYwqm6JOyPHeghZbjF89dSvANj/STp9JJO7giADWudito7PJMxdZHPEr6zt6
 tHuM9slgc6KOMkQJlPRZOchFoH39uRDyad9et0dVuJBzxGLl9rIacWFnURTrfc558Dfl
 PTLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSN0ASJeomffFrsi0KEryt/qaufAZl34C3irZ6p22ylvv8IvSi1F409CPLECpErTx4fABeDHHxscgD@nongnu.org
X-Gm-Message-State: AFq9FYKesiIBLux32VhuXi+aGlWfG+rJVKE2FgysdL9Yp1w1nG+AhdyH
 c1X6kxSqEeWF+YueJdXKpXUWrFWcfAk84sZBfd4x1BtCWeUUqp3MjQGwJQGwrOYsrL0=
X-Gm-Gg: AYBFou2moUYKtKr0TJZt7jsLR1v2fZNjVYY2pviga3mI9gv6nUGIij5ksmj2kexdR3E
 xxHdUNMzTXbGz/iRBEVRgSYrVDCQWBtF6NbaMTohCAdkHM4Ug11qxykDFhz7MW1lG4Hx76cvo3q
 nkOANPfMr1feegVRNAPEb0g9NZjvoV+Kkla8guhN+TcKRXhz+wWrgrrunIFbNlQKOcLNz7ytpD4
 jivGmwCJYgqH4cyi20Sc0cX5DQB3ffVpmrPKhx6UOWn8vauZQZkGUAMEnNyKAVxlouKceIq7dLn
 0x+xn6qtaBncA0hBSi24px4suMlTLhl3kkgJpKtb7Mmuk7X9fj1Gogqo1uoKANI+EgP5p7XekX1
 kix4ytFfdA+0ihsF8USQ5kfIwxD2RWFxbkScoP0mwCeXnlYXqULWouyf8uHoIOm03plNcyZ+mpe
 GkeOqEq+m+CSVjW5lZWnsnwhvgRQDmhIq4pCXkaGwxcSS/jOMbzIBRpAoD2XB8ejh7Z3J5RoGRx
 5BWm7T9rNNbzIrBvpUT7aphDgfDdD3krrzjemAr5j/FZUN3gUx3vcs=
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id
 5b1f17b1804b1-4a18e47aa9amr85372485e9.6.1791622254409; 
 Sat, 10 Oct 2026 01:50:54 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:a2d3:66fa:95e6:7d81?
 ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c198134sm117269455e9.15.2026.10.10.01.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 01:50:54 -0700 (PDT)
Message-ID: <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
Date: Sat, 10 Oct 2026 10:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: Rick Richard <rick@sloservers.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 imp@bsdimp.com, kevans@freebsd.org
References: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/2/26 12:52, Rick Richard wrote:
> A non-PIE qemu is loaded below 4 GiB. That includes every static
> build on FreeBSD and Linux builds configured with --disable-pie.
> With the identity map (guest_base 0), a non-PIE guest program can
> be mapped over qemu.
> 
> Only use the identity map when qemu is loaded at 4 GiB or higher.
> Non-PIE programs are normally linked below 4 GiB, and PIE programs
> are loaded at or above it (ppc64 Linux loads them at exactly 4 GiB).
> 
> Signed-off-by: Rick Richard <rick@sloservers.com>
> ---
> On FreeBSD a static qemu can't be PIE, so bsd-user is always loaded
> at 0x200000. pgb_dynamic() picks guest_base 0 because the initial
> image doesn't overlap qemu, but rtld later maps a non-PIE executable
> at its link address on top of qemu's own text.
> 
> This isn't BSD specific, I was able to reproduce on Linux as well by
> disabling PIE.
> 
> I tested the fix on Linux with static-pie and --disable-pie builds,
> and on FreeBSD with aarch64, riscv64 and x86_64 guests. When qemu is
> loaded high it still uses the identity map. When it's loaded low it
> picks a non-zero guest_base and the guest runs normally.
> 
> I couldn't find an existing way in qemu to get its own load address,
> so I used __executable_start, which both GNU ld and lld provide. If
> there's a better way I'm happy to change it.

There should be no need for this at all.  The probe sequence should 
notice conflicting addresses and adjust.

What's your failure case?


r~

