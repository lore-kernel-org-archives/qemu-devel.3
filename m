Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0C9CEB2C5
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 12:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKFLn-000587-5K; Sat, 15 Nov 2025 07:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKFLl-000530-EK
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:25:53 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKFLj-0003Ks-KY
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:25:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4777a9aeedaso26432915e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 04:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763209550; x=1763814350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0bMHb4X4K7dLBTFhdqOHfEjno0MRByMmJn7VEL8/NyY=;
 b=MvXB5iITbPX8JapC5JYhGK2G9DwdFso7DLs1Y2d+bKyTfaJ8QlxXKAIOJ/fOBGX796
 CbiLlI7KUaGYKQ+kHv1mu7dgniuUoNu9exOOd0MP8hV1N34i3ssfvWlElmQCjMFaLcdV
 j0mrr9YGXYHRcyXyesnyP6+F3UQJIYHQ9mP19W8yC9eHi1kq0qbjr5szeJpGsJj458wE
 VJUDquXid1x/MARjzvphSsHEVoT/ivRx09zapiLm6SHFOX4J2eLdeCUUS/ejQPBehAR3
 L/jhJK7XqsAx8mQwiUrzyLTvl6rWxYZ6NMsoU0DKycUj7jYgtGFGF8sJc7Ivgja8g84Q
 wFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763209550; x=1763814350;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0bMHb4X4K7dLBTFhdqOHfEjno0MRByMmJn7VEL8/NyY=;
 b=nQ7Cc/mpb5OtAqKOcI4cfzORt/BU7/huw/JSjSeLROitYlqRbZqTuUINp6SOwaTqMh
 3qO6kFYgrm7tWHK9xjX9g59tHECvvUwNbDaIaJkNVUpNGXKvotTXFsxE6iQ/qP1HpOVd
 to9PTUHqwo/LYnaa/nhGiCbWbamrt/oAOkhs0efthDxyoRstyT+/QSte6Xpwmeru0aXp
 ho/KqLAfPKjQtUn0EB+5FKi4omE1COfD5gf4szP5ZxyM8+nkdSph/RNi2BzZw1wt1A2t
 my+huL3HDxpSfqm+MBecOFy6hnHpZtOJOgh9BpwaWDXxo0kAQ58PtdOVprqmZuMCAVTn
 8vxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWidBowZIM/XtcFRloahsGhAbCuocruwKU31zeTIPnVoPFMWI9JsGQRi3Qg3Q69XStrCP6NLgeaXdvU@nongnu.org
X-Gm-Message-State: AOJu0YxXCPhGODPyfbtVjPd/m6T893Dcc5zhsrRFHD2QWV0CNJcXSgbL
 khGkYDLkb+VQMNVoyv18mkgHSkYsKx5YJpj34HN1gEl3Ufyv+h9VwQPkbN6b52JjCTAJ1tFKZe8
 bYNFbk2A=
X-Gm-Gg: ASbGncsf0GbWg2FYa4E2AcJCDFSzz0lVut5uW8RBsNFqEt6Zg9JsQko/xJM6EIPl5Pj
 LZSUnUxBmBwWwqssY6mMf5ENC35e2xzBtm0L3a2IrZPpUPt2AtMgul4zIL7gwvljm/ZmhqI/Jge
 C1XnHlP6DP1SQmCLKrFPFhiiOjKALWAsS2wfy1eYEOvuWPViUQ6flY3URybNl25T53Jb/6OWL8G
 UIe5sqvhZ3kQQQD9fmEonxIczNh+LxWvqsFk56PiCQLFht07ocw8Qm1mnfGJLB7fVwjBuyd9B8s
 rkINTsWPZbgnTAHl3cAnzWDaQcNQKx61jTPOtqJfKEAe/3MFJyOt5WItIBJ4cSZ+/0s7z0rhRfs
 hJ4YtlkrMNcTx/fRFOKeHQit5qDeRpWfK+fKU7TYuO9YBSg7ULguSzSyRpSue+U2t0GKXrLgWC5
 zzdgVQRLMHJW7wqbHi5gjbNP8oH65Auf9I30IMQNUt0WP88sct780di1jScGjH
X-Google-Smtp-Source: AGHT+IEX5yoCK5pNY3rsBBLmBpP3MqVUZYi67OFDlBm8WonucxHFBIVuT6rq3W2OV5GfL/dHR3JLVQ==
X-Received: by 2002:a05:600c:138d:b0:475:d8b3:a9d5 with SMTP id
 5b1f17b1804b1-4778fe5de6fmr62026735e9.10.1763209549562; 
 Sat, 15 Nov 2025 04:25:49 -0800 (PST)
Received: from [192.168.8.105] (115.red-2-141-104.dynamicip.rima-tde.net.
 [2.141.104.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bae816bsm67028455e9.0.2025.11.15.04.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 04:25:49 -0800 (PST)
Message-ID: <b6d5aa11-eef1-4cda-b008-79ba8ee89e1f@linaro.org>
Date: Sat, 15 Nov 2025 13:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: fix stack size when delivering real mode
 interrupts
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251115015410.185195-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251115015410.185195-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/15/25 02:54, Paolo Bonzini wrote:
> The stack can be 32-bit even in real mode, and in this case
> the stack pointer must be updated in its entirety rather than
> just the bottom 16 bits.  The same is true of real mode IRET,
> for which there was even a comment suggesting the right thing
> to do.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1506
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 667b1c38696..227336c4ef2 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -1161,7 +1161,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
>       sa.env = env;
>       sa.ra = 0;
>       sa.sp = env->regs[R_ESP];
> -    sa.sp_mask = 0xffff;
> +    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
>       sa.ss_base = env->segs[R_SS].base;
>       sa.mmu_index = x86_mmu_index_pl(env, 0);
>   
> @@ -1964,7 +1964,7 @@ void helper_iret_real(CPUX86State *env, int shift)
>       sa.env = env;
>       sa.ra = GETPC();
>       sa.mmu_index = x86_mmu_index_pl(env, 0);
> -    sa.sp_mask = 0xffff; /* XXXX: use SS segment size? */
> +    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
>       sa.sp = env->regs[R_ESP];
>       sa.ss_base = env->segs[R_SS].base;
>   


