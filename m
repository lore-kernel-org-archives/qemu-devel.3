Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6554D26D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJnE-0001BC-Dn; Fri, 09 Jan 2026 16:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJnB-00014o-NE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:13:09 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJn9-0003Rd-41
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:13:09 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34c71f462d2so3916874a91.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767993185; x=1768597985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ep6AbMFObwFrSUkLKkYawYpTV92B5hUK4Qj6xA4NfG8=;
 b=h7wmwZnLwwLF0RSGHT+pI1KC0+WSEuWjbcE8fpp4GcrQS7jLuJsMJSYufydtGQTnqn
 KvjJgiOXkDRNLnbPjCKnFOGRKIukEWWO1FZD7J81TOXzRIkp2Q+9FPL46PiAyRKLHHYv
 83J+25StPJXv8r8jF1H02y5a51s48pv4y0PDAOCCEK/7A9pu7zPhz8VTVkPh8XZbhdSe
 JIrGbL8fS1jim4ghXqGzQYnCi8Fmkrtv5OOK9eV9CtWdzC1f/pYNonKzs13kIFZ/aZHr
 ZM2qjOs4uLEmIrvu0Qgx7/WIrIwaWJSxneTeyj6UwbKQzvnTN3ltNMt0qAi4HnnKLVz1
 EacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767993185; x=1768597985;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ep6AbMFObwFrSUkLKkYawYpTV92B5hUK4Qj6xA4NfG8=;
 b=Ui9/IdNzqxxOnN38xGmiAkf1Or+sxWE1p0BgKEjJ4Zd00DeNUqDBHHANBYPPjOKA22
 lr9osj6A5vOxWSpwV29a4zd6b/zmNnNCVWVZy1evqqk92aYv17L2U2kwqARQXBi1AWTX
 P9S929L+0M9HjKumSaMiKfoJBGwKPSypswHCsln/mDMybn/IuSzZi6uHK81+Ttb+IuM5
 tKtYbWSBZkPg+gKmpQ22UatPyG36nUDxJ3lAgMJ3E/8o5/rh0qRy6ARJFbQkMT3AvvRy
 RhIb/jfYp4NRVh98vKKPlKqoQuyG9A6WmUL0josW8dP96p1Hgd9kuQCKEuAfCO/Qqv8O
 vjIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvggPwgtLEhiaW0Sql8IxaW2kixyC/VSty3Fc9mWQhVWOWeM6XZNEVmz0WW+b+48/GEE0id3lWwlu1@nongnu.org
X-Gm-Message-State: AOJu0Yw75x1n68K7X9pBVm0SytEnNsLJ+aiNJu/rI7l0F7mzPyLMZ7wb
 mt/uuNTVwIKNpBkxQ39xmwu6v3eYhN3d6/bpjx9kXZsXGOh8OQFje0uLddnxoVJdBs0=
X-Gm-Gg: AY/fxX4+CkC/aAtIZ8zOEmpxMpIgNhbMh9kbafATV76jljjTMzc1u6JGXqJMvMQPBy8
 STUBW2dxP15gYW9KMXEDsvje72H1cWjlsM/aycwv6HzRL/5wwtf53LcRG3GuxOT3qg86pIhiBTE
 umOLyAtJwHfs2/erLGCck7djSEW8LYvJiaBebhUbx0cOGw/Y8cnJPiA3vSngn4P4AMy/+ilIMmV
 fPc0JrIp+/0GSd+DTtlPCdoXw0jm1gUT04wQlHr9VJurY+VXvYmBJ5Z7BpjDjzOdoBbTaB+688Y
 eV7yJnSFHXmrnoRDoNSg/X+U8A4h4Ma/1l/4s5Z2r2ZKOFxfz1fx/fhYYO4pIdhIQCDT1NvVJ8v
 l1KMFyTs3U3y2j0JGpSQPPieS8GCLfFei3aSCkVBodUUm5lf0RBfRQHr/bF0/sUG23lOf5ad+sR
 3COSBl4RTLLz+YjhHuVqCE39N1d2iyLknXHsIQ
X-Google-Smtp-Source: AGHT+IGE/HnxMH3DLW9DwtdOXTBMv1sv0nr+yGAPASoGPToIjnmHFXpkyMW5saesI9TaMLyC35Nhtw==
X-Received: by 2002:a17:90b:48d1:b0:340:c4dc:4b70 with SMTP id
 98e67ed59e1d1-34f68c7a6cbmr10961369a91.6.1767993185463; 
 Fri, 09 Jan 2026 13:13:05 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28f6cdsm11246329a12.6.2026.01.09.13.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:13:05 -0800 (PST)
Message-ID: <3839145b-3b44-4ee8-95cb-4ae49fc1a0ae@linaro.org>
Date: Sat, 10 Jan 2026 08:12:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/29] target/arm/gdbstub: extract
 aarch64_cpu_register_gdb_regs_for_features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/internals.h |  1 +
>   target/arm/gdbstub.c   | 53 +--------------------------------------
>   target/arm/gdbstub64.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+), 52 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

