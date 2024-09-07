Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494EDE6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smmkI-0003Zc-KB; Sat, 07 Sep 2024 00:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smmkG-0003Y5-VK
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:08:21 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smmkF-00015Z-Ed
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:08:20 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so18013666b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725682097; x=1726286897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tjc9Msr4YUPJKlxz8ubrQZ7LClT+ogvdXNJRb2f1C/U=;
 b=BQF6wv0atyoTg/5eC5UmNKvlTxfbR/VtDcVc1ozd2CN8IGf1ADbqiV/8/jPqoz4v03
 cbtqjbsuNATy84uPZ56mgVXbOn15J5Fej2YIOeiLGWFHfocRDuTu1hMiBufD74yDNce7
 TEykjtxBFqGNy4H6KcpsbXEWoFX3gtFmHF4vBDfyCi9orS5aM3Iiir0SFCILtysX/oev
 FMMLht5Q9xK+MzJdUzlk6u8vGKe0oneBdL1MPGI7IGl5nYNoUzMR9bid9CCeKxdpaZSN
 u753As/NbuLpcVa5eb4p0GoYCyw32y7ZpAqqxvbipTGSa8fCbbFhDC0/93uCjjKWYYDz
 8ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725682097; x=1726286897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tjc9Msr4YUPJKlxz8ubrQZ7LClT+ogvdXNJRb2f1C/U=;
 b=emUXPUX9/ijF7Yzz2p7eUB5+ahr0UEmzYtC8cKIhZ+SvIT31jG9aFZlcd+YriOro0G
 RQ/+3SzNvWq+rqt90d8q6owUKYpCi9HBkXiQPQyYha9w6/Sb1UTFSuvFJcUlapODeqh1
 gKslAvHcCMdJXgP5WG05ASdLP81iDe6Z1keMa1VFGyl2g3nncjnkSpsQhlj30+vgBmJu
 NIESvuv5M88Gw5Nys64wVpAb18xhhRymks5wwFod7NlTTzIVwJD9kuCkc654Rp6B30eT
 +HyytBebwU6+VlxqXGr58UpexNCm4prr6kH+wWgeyvYxv3h7HBH/HqF6J52gCWhIPJ+Y
 k93A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ+v410vv569PIOfyjr67EEsKIAm3eAY/vPSI59jscwwSWdtcTD/LfQJKlw7Guzw556at3Uzj5akPI@nongnu.org
X-Gm-Message-State: AOJu0Yxuc6yDvlQMicBGPcsIrYHQP1HGrCX9+IMsynZBI2E5eQ2KJPxa
 3Pp8m40ZBynEykSfpH4ZPon6a8T87CgmCaaMq2gt6h0gm/dn+hTbYc5nv9dkbcE=
X-Google-Smtp-Source: AGHT+IEb41EJgiOyka82e1PNXmJjlsYUiJZ+CoZagX/aDPsFbeJuyZSMU5gdST2Voz6HQtN4F+2TQA==
X-Received: by 2002:a17:907:2d9e:b0:a8a:91f4:fd30 with SMTP id
 a640c23a62f3a-a8d2494b9d8mr51857266b.56.1725682097118; 
 Fri, 06 Sep 2024 21:08:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ceed73sm23742966b.174.2024.09.06.21.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:08:16 -0700 (PDT)
Message-ID: <7dc385ca-46bc-4572-8212-7bd49d09e536@linaro.org>
Date: Sat, 7 Sep 2024 06:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/jazz: fix typo in in-built NIC alias
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 arikalo@gmail.com, jiaxun.yang@flygoat.com, dwmw@amazon.co.uk,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240906230138.335995-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906230138.335995-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/9/24 01:01, Mark Cave-Ayland wrote:
> Commit e104edbb9d ("hw/mips/jazz: use qemu_find_nic_info()") contained a typo
> in the NIC alias which caused initialisation of the in-built dp83932 NIC to fail
> when using the normal -nic user,model=dp83932 command line.
> 

Cc: qemu-stable@nongnu.org # v9.0
Fixes: e104edbb9d ("hw/mips/jazz: use qemu_find_nic_info()")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/mips/jazz.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
> index 1bc17e69d3..0d44e19707 100644
> --- a/hw/mips/jazz.c
> +++ b/hw/mips/jazz.c
> @@ -128,7 +128,7 @@ static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
>       uint8_t *prom;
>       NICInfo *nd;
>   
> -    nd = qemu_find_nic_info("dp8393x", true, "dp82932");
> +    nd = qemu_find_nic_info("dp8393x", true, "dp83932");
>       if (!nd) {
>           return;
>       }


