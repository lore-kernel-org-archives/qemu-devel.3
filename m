Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E8FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISia-0006AN-7i; Thu, 30 Apr 2026 10:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISiY-00068z-7Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:50:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISiW-0006Rf-03
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:50:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso8153115e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777560614; x=1778165414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ml+eAsF0HbAMF6QKQntyaerfj984y3iN2ory8Z/nCm8=;
 b=b1x1bvAu60GJQK0NH+fcm3ScNkYAbNRdFx21L5qYbGpP9Po/sX2ZjRox7Ftc+0uGgl
 +RWWfX26wZGqMFPzOA8myR6pC2yFEEVXUmbUoN18Z1iz/TnqTCJB/k+DCFPF2Fsj79OJ
 K19iENXhNbCAXL79VaYustmTipVfckaR1O++JVI5p5FtLav7K4EjeNqpog9oqHCzMZpj
 CdpZPO5PWh53+sm/vxGM7x2Ayp6OtUQaP6FOfyxs8nL9UeBu8xmrhpJ2+brYW21HwDMo
 t0z1sO1tDUfFjx3BTPYZ+3f/AIYo0DHvn6hd6mnS+To1v5Aj3Ww9VosvZipUNi2KSAzA
 TxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777560614; x=1778165414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ml+eAsF0HbAMF6QKQntyaerfj984y3iN2ory8Z/nCm8=;
 b=g+CZ6OfH5hjW8cMDCFaGdrIzaf6EvvxaXJKt/rwZePr6V4x3d2TzvG5ZrylZuyr7ic
 jFg5BNymSgBhGUopH3/hSvJVsdmpMM0AyZZ3uS7z8QDovFiV9LJ5JitKgTEHeNZwRYHR
 WHEjK8XOTA4pPtb+WZO0iLgCq4t2ObSdJgGwvF248JEbfnBuGzJrvgmI6EJBSQWg0G8E
 OdmSsAk7ym08eAbyadtsm60CvDcCt3wuqH4afZde55U7jH6ty3prPqKgV7UrCNn/Rqls
 XN4Ynppl8MNFpKrJst+qRTUBXu9Ej9IGyjsroaqC0YoEQMW3GlmXjy9aQeTKjIml8IV9
 qrpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rAyutJmPN3lypLQZ5Eec/Vid30gEv+T2ewG/VawbI1n9k9WRKOKDACws/mfwf54+hU/XjJoHw0mDQ@nongnu.org
X-Gm-Message-State: AOJu0Ywi+eqDoP3G1rsCeQOECDVCjIFd0GI0cON4QeZ1GHc+0beLzHSV
 oq+R/Bv/h0zgYMZc1IHpzTNHFkutXuE6v5itaZZ8RG2XI9jT3jS/PxkL5eeoe2mVRLY=
X-Gm-Gg: AeBDiev2qHpGFKCKwhRY7FU+Im6YOrMNgpx9+OLQDtcbNLKDPNRiqQ15H6qa4o7/Ato
 fzbS0AwTKprAhYUYcFusw08SvCEaELxYE1NhWnjeiRVYy+hf1anqXjI5ndX6vR+yrQX+NqGS66b
 m54lSjXz9RDsVsZRYLjSskjUfKlQP+MlvEdUkCNYxemjjU+ZGz0M2mF9/YX1Vg7VanQ27DfTBLd
 st3MN81742ROweyJAL+dbU7WycV/fC48dJo0qjI38U3cO+Gp0wYWn0qNyPmAiFFpKo7fEIl0VLc
 7DAKIyqR007qeYA8kaNpiOG6P946zhYBH2yZug7LG0XDWkPFzjvMwVNZID3ITdzeBRlsuU6ifVS
 clfbDmM42WWJuJmyE9pCiCRnlqCMpa2C5oAT8FhBwPn+T+jdLFmXCbQUqZGPN2dsAiRu4ZfNfMK
 GZVBGPv1NkkDcPCZZdoTw02lltAUHH+Fb6H7UrDMzSfkYou0LYXa6Ozs/gZVZ8z+YT/TIMWqKV7
 DTE
X-Received: by 2002:a05:600c:4e16:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48a8451cff6mr56845985e9.15.1777560613577; 
 Thu, 30 Apr 2026 07:50:13 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822d4b57sm178235345e9.15.2026.04.30.07.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 07:50:12 -0700 (PDT)
Message-ID: <01868fe8-785b-41e6-bc83-4b0057a94fcb@linaro.org>
Date: Thu, 30 Apr 2026 16:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/65] hw/intc/arm_gicv5: Implement IRS ID regs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-11-peter.maydell@linaro.org>
 <CAFEAcA9L7gqa9FFRhWpcPF2Xmr4+OAX13he_McG_CV1xkDAzkw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9L7gqa9FFRhWpcPF2Xmr4+OAX13he_McG_CV1xkDAzkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/4/26 17:04, Peter Maydell wrote:
> On Fri, 27 Mar 2026 at 11:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Implement the IRS frame ID registers IRS_IDR[0-7], IRS_IIDR and
>> IRS_AIDR.  These are all 32-bit registers.
>>
>> We make these fields in the GIC state struct rather than just
>> hardcoding them in the register read function so that we can later
>> code "do this only if X is implemented" as a test on the ID register
>> value.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
>> +/*
>> + * There are no TRMs currently published for hardware implementations
>> + * of GICv5 that we might identify ourselves as. Instead, we borrow
>> + * the Arm Implementer code and pick an arbitrary product ID (ASCII "Q")
>> + */
>> +#define QEMU_GICV5_IMPLEMENTER 0x43b
>> +#define QEMU_GICV5_PRODUCTID 0x51
>> +#define QEMU_GICV5_REVISION 0
>> +#define QEMU_GICV5_VARIANT 0
> 
> Apparently it would be better to use a PRODUCTID of 0xfff here,
> as less likely to clash with any potential actual product IDs
> allocated for this JEDEC Implementer code; so I will switch to that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

