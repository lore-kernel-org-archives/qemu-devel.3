Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA24CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6pV-0007dO-Ep; Sun, 10 May 2026 12:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6pT-0007cw-OP
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:16:31 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6pS-0003gk-8v
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:16:31 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4042fe53946so1313672fac.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778429788; x=1779034588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jAUgqUZ1WEn+W4oDjOTsOJyMNpbaAkzETP432yjgKwc=;
 b=XnCxtZaIvn3kSgtlaYxktTWzyvp2R27dpozRmdItl22wrFVd/3PIvd/x6pfyJ5lAI/
 +Pxabd61lA2vzjFlLOl49E3hTPRTzTMb0MLfBnhgytsaFGSAwMX4JrPp1IMsFcLvWVWc
 gCJ+I6jcgwe4cdHfmKX1H7rmmGzGiHmJj40kWZfeQ5Ljn8Ez9EQZRKjP1atZqk3yQ4DW
 W+DLXjT5LlwCklsXCulQShxh12SKmiwnktW/xJhBWFs5ZIlm2mox7hG2tDruml8Xr8Ej
 ribZ29H/PqWEbUn7t5bULGD70cvzEyxmzGRJj9uMtATiXPtA/TrJFG4+TcnDb7cEQVRK
 P4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429788; x=1779034588;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAUgqUZ1WEn+W4oDjOTsOJyMNpbaAkzETP432yjgKwc=;
 b=aDVlIAW7pvLCTo4mA7vOWfGvTg8PTM3UjmBSYaAbPPqzyWHTAu0GCcA4sSulRYIxiO
 2rS6f4cMcmWR3h/F4q+aUL3zHFCHcQ1hwbgPIF2+syq4QCI9lpNk/n8b36b86LPYDv8d
 k4U+Vb4JRyXkDKUw3sdspL3Yuqm5kDiN68/MbSvGgEqI8SdIne9tUPfili3bhJJH1CIj
 Gs9FBaFxVBkSh8QgEYwfQ//OoCYJrEXH/ZkmYj0xcx3EOn7v+rUd4W9IAwf20q7K5vsQ
 9L0KHsL0d1rIeqyki6xn8sN6GSpKlZlH+wqzYAV4Y1XtMuzTeW9sLFEoMwNASQ8Zp09G
 zrxA==
X-Gm-Message-State: AOJu0YyZW9TxN6j2fuq6J3JOfCie04QbgP7OhrK2/ayJ9UFvukhvir3m
 3sBOoOg4U+IJ1WcF0fRALMFVQRclUWiDKNCw9sKVX1Buzx5ikPmjqykSi/LhGNCoL1MbOGIZ0ze
 BwFuU
X-Gm-Gg: Acq92OGLCj1lWrIsklTx2XnAL/9bp9lVL1OABUC0kUDjorMt2ZyuBM5w4PHtTaSUEMs
 /dnDllXIpEsfD/uteP/3HQkHK46FZ8erfmQNrqZ/1Pou3vW2kDyU8mYlXTjVLmFYPlL4n5YHzH7
 gdKDcbBqKfxVNrrrRLvH9M0sNut5l4W40W+8s11iW8dAZB44dr7cow9EohfaTqNkhA0swB65Ka/
 wzf92s2/qrOKiJCXvMCtfh4BavPdf9MVjgk+3RlgEBV1luKCfShddooq1fTsn8ZQEuJBo4Vqf40
 Nx1/0aE0ANUs17aepMuJ3ueCqWiacjCTTjQA7MIiMd/7luUhqyWVAfeZfSXklH2hpKTR58A7B/n
 sAcA7okAk02BRMe0gFjanX/RvVG3oQukAquI9TEY/0dJhC+h26NEY1Ya37PQxHxS+kuij38a1tL
 J0w4t9ncAF4YTnKoEIXTHN5OecDnjeB+4/8pkPaF+RobGxkbArKuUAZJtGkAsORrsbhlWjSgeDK
 EtRlwxRfRG5mZF/YA6v
X-Received: by 2002:a05:6870:e0b0:b0:430:29c3:9d15 with SMTP id
 586e51a60fabf-434f5577a52mr12325188fac.1.1778429788222; 
 Sun, 10 May 2026 09:16:28 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435574490b0sm7700387fac.17.2026.05.10.09.16.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:16:27 -0700 (PDT)
Message-ID: <f2af3df7-75a4-4a7c-9009-ea42e7a0988b@linaro.org>
Date: Sun, 10 May 2026 11:16:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/32] target/mips: add Octeon SAA instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-11-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-11-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 5/9/26 21:13, James Hilliard wrote:
> SAA is an Octeon+ instruction that atomically adds rt to the naturally
> aligned 32-bit word at base and discards the old memory value.
> 
> Add an Octeon+ feature bit, enable it for Octeon68XX, and implement the
> common SAA/SAAD translator with TCG atomic_fetch_add_i64.  The MemOp
> selects the word or doubleword transaction size.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split SAA out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Gate SAA/SAAD behind an Octeon+ feature bit.  (reported by Richard
>      Henderson)
>    - Use the i64 TCG atomic add path for both word and doubleword sizes.
>      (suggested by Richard Henderson)
> ---
>   target/mips/cpu-defs.c.inc         |  2 +-
>   target/mips/mips-defs.h            |  1 +
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 19 +++++++++++++++++++
>   4 files changed, 25 insertions(+), 1 deletion(-)

I beg your pardon here.  Given that we implement only Octeon68XX, which is Octeon3, 
there's not really a need for new feature bits.  For clarity, we could rename INSN_OCTEON 
to INSN_OCTEON3, but that's not really necessary either.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

