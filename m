Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C811EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udnaS-0003SY-OF; Mon, 21 Jul 2025 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1udnaN-0003N9-EM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:17:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1udnaL-0006MB-3c
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:17:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so39071205e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1753093045; x=1753697845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2L8nOUhRFz8Qd2H2+y83xVXbQVi2gMHd8RFg/bFXMCw=;
 b=jKC7DXisa6npACNDrO+pgK/3g3ABZlEM5DR9re+mlHccRL4hYhcb3diGg0ii59oa5b
 9R8ZaDYwLORUIW/ZJ3tc793P9gQ3FzQFsQL4r9l0AC1Z27vKj9IV5fMdMO+s/a0ZfrDH
 0d0pRYecWBo04Ms9MSbDRX9xBAhksoZAve2pvniCySD8P4pY9pOSXDqWdprjTSAc+FKV
 3q3WaIzhohktBFO7m4xSePFJc7ZPQiKOBFiuRPvLNUZjFLrtDig7865Y3u5wjTzC5kf+
 nUP19gAkEh9Rl13vytAKOyF3ggwKwFDAVht27cC9nMt0q3dQsOlsZFvrIx8cdGKzRWFz
 VHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753093045; x=1753697845;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2L8nOUhRFz8Qd2H2+y83xVXbQVi2gMHd8RFg/bFXMCw=;
 b=pn7CzFY9Z4X/qlzIU4NOGocWyvOTGrmwrNLE/XrQiN4vNOUClQAENYHCbZ686PwIRx
 c4CXG60BV8jk4UPzn1URybQ0IP7/7qu/jpISSd57K488NLVBh3y13yZ4bzTWYj8hXETI
 QLssnIcY7JzNjJ4dkwiWJYwvohEHyy4+9rx9mB62R9o8ezp6GxyLg1ExyKYwWqQtMukZ
 XLKlO6BfBBQO61W5PqXxMaipyp32krgqGj91WUB09E7CjkjiUnwmW+kIhKBRfGvYpJJp
 rZr6gTg9WblKCaDh1Lchrk2xoCKO4e4/ZfVRE+308rvqMMieC4efgOX7hi2g+7FILBLS
 Ya6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbEpVj3HuRAP5anGrGI0NjIVfaUha+w9d23yXTgrjel6jQVEg7uCFx2ppC4bLNej1HHLnkTyfJwwvv@nongnu.org
X-Gm-Message-State: AOJu0Yy2tzuaBZ16qtJO1E2gTOge/g5K3+AChZKHIzgzB3EdbNPyD/D/
 eywGC6WqDUz1vDCclgwd7Vo5QqjvCLWILKZmUrCxw6kdnXEJ/9wd2OYQPIB0OYQY/gq2lrglPEz
 MLQjE
X-Gm-Gg: ASbGncuU854U/7GutSSYbFzpB1knsZ6Yrasjgj1G7hJj3l7IpLn/BQJ0sG6VocKjdEc
 d0ZPN4kSz2geNvbXoxsgoz0KDF/gK3RTI3tbbmIqd6ys+pkKAIa1GWszf5bhkAtz54htWS0PN/r
 KBLIKyN0jlC/oK851U0bOsVWB4hHS6S+WZGWLq6RxIcILUZAa8D+SyiTUpkrvWU0Ea76sgLfrNe
 xM9+6oVjLvIwqZ55dm/r0zb0CSJprXGenSFJVziaUtspyih1wxe9vxo2bhbwJndWNfQcoTA2nXd
 wd7VecXHsSF1I/9BqoK3/mixBQWaUSP8quaMV0ah/W07IbU0qJ1RuTodi4dEQjP0fxeTOOLCKr1
 XA3K/HIXwlmq23wQZhMQ25Ct7WTxM88+8RH4z408z5eXVcGjCEYVX+sONYiNP4J7C+mHlgPVo0F
 Zyv87lFGjwfYVFTZIhfL2ix+gfB2bXEJLF89gJ9EyV1whh9v6cNdtzwPc=
X-Google-Smtp-Source: AGHT+IGD2z7sMV5r9LkaIWTLYLxVo/iO18rZpGF4CgXRRlqBAx+jsowtTyIf18iIhKhB1ZTxesuyLA==
X-Received: by 2002:adf:ef8b:0:b0:3b6:18c0:8b6d with SMTP id
 ffacd0b85a97d-3b619cd25efmr7646889f8f.28.1753093045417; 
 Mon, 21 Jul 2025 03:17:25 -0700 (PDT)
Received: from ?IPV6:2003:fa:af22:cf00:2208:a86d:dff:5ae9?
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e89c739sm153933755e9.32.2025.07.21.03.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 03:17:24 -0700 (PDT)
Message-ID: <5f9cc1ba-4b6f-4a87-8aa8-cd684c9fa3e1@grsecurity.net>
Date: Mon, 21 Jul 2025 12:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix CR2 handling for non-canonical addresses
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20250612142155.132175-1-minipli@grsecurity.net>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20250612142155.132175-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.157,
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

On 12.06.25 16:21, Mathias Krause wrote:
> Commit 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
> accidentally modified CR2 for non-canonical address exceptions while these
> should lead to a #GP / #SS instead -- without changing CR2.
> 
> Fix that.
> 
> A KUT test for this was submitted as [1].
> 
> [1] https://lore.kernel.org/kvm/20250612141637.131314-1-minipli@grsecurity.net/
> 
> Fixes: 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---

Ping!

Paolo, Richard, any take on the patch? It's a regression fix that can
easily be verified with the KUT test failing after the commit mentioned
in the Fixes tag and succeeding again with the below fix applied.

Thanks,
Mathias

