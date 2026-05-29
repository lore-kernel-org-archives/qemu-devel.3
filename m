Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2FACD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqIy-00045N-If; Fri, 29 May 2026 02:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqIw-000456-Uw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:02:47 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqIv-0008Cx-DM
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:02:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so8291021f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 23:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780034563; x=1780639363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QO6u3WT3AtIhhzaUfvAGwiN7V/AC+oSX3dWC/886Yh8=;
 b=xTVzGTRsopwNXeEoF3NKpHYFQrP9ROd38EiRrSwsaEEmako4zsUCEjGhujupy/k83y
 AIzrn67KchBskDdbR0eQyk7Xjn8sBJyWqsrHXGMVvpTewhLtYlU9KBG2vvIMdt95fExV
 dkB2bgsIYquzoVcnQx0GufTJgIU1kJxomNcVNDM9lz/1jvNWqzig1fwADinADBC2EtNN
 G3fD3sPnqyaJFHBbBZUZqDgRcbvsMoMKsVTklJgQSultj2Hbjmhh6dO7pbH3ZJjseDYu
 WFZUJzDdv0c/SQ2+xJWCrnMrV+O58iq2YfBAMb1gxT5zWKcMKYkq6pVRm2K4vcpxdGHV
 m73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780034563; x=1780639363;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QO6u3WT3AtIhhzaUfvAGwiN7V/AC+oSX3dWC/886Yh8=;
 b=U18vKPxUUJfBqjBxPOuIzeOWEsbCGYAvwxVXp5IVz7SHIPhAhRINDzS9L2G1IJlvpP
 EnUr+L6ppr3aJqktsd+lK1LXYRO6PVILW+5kXqbpKkVClCXpg937jNDphgaLmAvfLdtQ
 8G7hu8oZWAsN6PR8B0uzg2dD10nRhhe6G11BZRlwkv3f2BytlHrKai8m5Vll8Nj+/OGH
 cN/L/kCmX1Cgc0KNty0c4H4rgnSuuA59dKLxFPRrqczA+XiIzi5E/ELFXJzS6ae1KiZn
 9G7BIFN0uAPfYrvPRi31mT8bjEJO12y4AjLsrMzUgsKTtdZ4HMgfv4PZXt8y2tsU7d9R
 aAlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ81IqkMPGiQSHL3eMAvpmOa/L1Bp6ZFeoriC9U1uLOh85bnJZ///CLGNBz9YuJcuZi8hz7cblVj+cBl@nongnu.org
X-Gm-Message-State: AOJu0Yyx7oOgA8RdE0yo+aNA1365axsnfiToIoJKvIH1gH33M1cbVP0J
 2yocDeh1iw+Xa50OktW16lnnANqlZQvOqPm2FZBb9ingMjwUEYizOtfdQlJuZlQXpJA=
X-Gm-Gg: Acq92OF5xoVjSD3/OUqq1R47YzrdsGrPzuK0i38Yi3rYDuu0KVNUol5KUhHtOZck8Ea
 86WCvKYzqGvMhsEGwoFqOp1aj/uWhpBA3R0oQCojz/mTR49nwEOUkfZBj47iWLtvJ6K0GKqHorY
 C7FUkx5mMck+VCTlcGTblk5J/uHGG26CTPKAbxFdGYLRH/HYi7OQUn6T4gGDRmLcTzBLWymUKaa
 pwzNArigmJseaR2BYcKbykwl/a+wlAPnzfm84FQ/cxkKkuC9NUjd05uDntfbAD5jTIlYeUFJiCk
 VGm5C1wooMc5k8WbyLV1WF+bgNj4NBLPzjpDBHCZFfaZSRk+SjnfSzQH8EbuGOmIjdWbkT3ndm4
 3kcAa5SGufxgoJZonwnyAifxIMGG7oy2msj/+SUq73HeR+QF34+kcJPWsRDVlBE/17n11T2eIN4
 CFx8r/pv5kc5xAlnbiA5KzSK4jwlhdDdDpzOF533OsvHYXTcrBrsQoamriyhS0o2LYp+K/38PX5
 aW2
X-Received: by 2002:adf:fac9:0:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-45ef14640e0mr1212358f8f.34.1780034563100; 
 Thu, 28 May 2026 23:02:43 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef32fabcasm1280789f8f.0.2026.05.28.23.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 23:02:42 -0700 (PDT)
Message-ID: <43cecf30-0d35-43e3-872f-d472ed2b795a@linaro.org>
Date: Fri, 29 May 2026 08:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cutils: replace hand-rolled qemu_strnlen() with
 strnlen()
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
References: <20260529023839.55302-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529023839.55302-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi,

On 29/5/26 04:38, Bin Guo wrote:
> qemu_strnlen() uses a byte-at-a-time loop with an XXX TODO
> comment noting that the host strnlen() could be used instead.
> 
> strnlen() is POSIX.1-2008 and is available on all platforms QEMU
> supports (guaranteed by qemu/osdep.h).

If so, there are only 3 uses in the code base. Maybe drop
qemu_strnlen() altogether, using size_t in the callers?

>  The host C library
> implementation typically uses word-at-a-time or SIMD scanning,
> which is significantly faster for long strings.
> 
> Replace the loop with a direct call to strnlen().  Add an explicit
> cast from size_t to int since qemu_strnlen() returns int while
> strnlen() returns size_t; the cast is safe because max_len (the
> upper bound on the return value) is already int.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   util/cutils.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)


