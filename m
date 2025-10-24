Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADFACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCF1u-0003Rr-Qu; Fri, 24 Oct 2025 06:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF1s-0003Qm-IJ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:28:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF1r-0003sg-0L
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:28:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso1662097f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761301693; x=1761906493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9uj9jMqSOpToxNeFYPndZYQj39Bp9DR8WsYK0KAv34=;
 b=NhwkKRn1gRieLN1yKPVwOS2SeHse1PRexa4URFOI0AJx9vjjhD3Yd5te15mNOluKGa
 wKLPfRvi3ilklwmedmQSBRmh7oAzg6zv9cWoGpe4E6faBlA2PFFDwx3c/01fWI1aqswA
 /IBO6As9Ztyj8BblP+hajYbFz++I6nfGT+5+nvApzDGDj26EAl64K5O/rsc1CD9slspk
 aIJl8/IpWfgUKsCERUTltghqU7ILfGxqJ5Mp0wWjqT0r+9HZn5opleSKX7UY72H3cH28
 CV+wRInSwB1qhofdViEUIk//OGnvlS19FLPqJjh70IyMmwSHoJrUCQempZqZN7t0U53s
 l2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761301693; x=1761906493;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j9uj9jMqSOpToxNeFYPndZYQj39Bp9DR8WsYK0KAv34=;
 b=gqmaxEhWdJIH/JDRk+cpjL/yuQqYdYuesh2uuTpolqwYCpX/sovi2DG6fi2UNbp6jH
 Al+OgJ2UAnV5Zav5EsKUuiPHyzggXsW3qJCIHQPVQKqmlWEVyvyIh0IBHAyZF0f31mF7
 HH/g1I0NnVfLUEPoa/8N3QnrAwPo32W43sxCmXddZAYZTvd1Lw1UopnD/F0uSafF3/be
 jZ7DxxIy8meganlHLKAYsmchidGeHeD96aox/p/c+Qm+C6bYbMEG1Taz/kc0E+NaggEZ
 xrEJ5X1BKbqg5C1CATmIndp0/inEd0aYehl9wKSLQ48oME9ZCCdZpUBG4UJUuftsBYHC
 EhRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi96ju45fRX3DZeIVVvszji+gXDcnJonGJNZ6j6GUsqpXYIHPEnVex7FKguuGOEn/fKL71bBc6z9M2@nongnu.org
X-Gm-Message-State: AOJu0YzT59fwxIe/ciUnytF1Vr+SQs+uRBt92HpM5YaA5yeTVafKVN/d
 BYhRptTM7Eo4J9OlbhvSaeNZb117kKWtv2pfObXFGtb5t45N8lwDkX+nL3EUUN6ORZGs4D9lAIn
 8cg437Jw=
X-Gm-Gg: ASbGncvI3XaQvTrcw1B2HfJuGQ4gERe7hIoshJYf5PJDEtWm1w/f9MUuvvxUYAKiwKd
 tJ9+t/3wcEgw+nm86oMtj8Op5PmYqzdCYEf3C4wTYEKo7SpHHBaVvWN1QN9AoJqC35jE/K4nXTJ
 g9ksX7F6nvmJ8q5SZ2tSa2Tvc419y3tSI4N684bTZN8RFovgyJY/3rGjsDe2WgDUFnIfrzChCO7
 GW45Ixu26Y63cQhpbtt94P3OS7z5uh+ogCA3gjsT9SWIj90CQGDUo3DrlP+oPjzcrfE6tPZ1acc
 ZqC+4STZvR2kI4NDwdxKeUV17iu/W6yz1dPHf0FjDM8PxUV1qh5YonNg4W2mweayrayIk6+M8Kj
 HYDSyMkd4Gc6tHHpMY9EG2Mn1d9HYyHSa+CN+jrCA8/enze6sOi3NQCQdUWWExe3xfrk6j42roW
 jXBd13aP0bPjc5GvCnAW+DbWBUPNME4CPD6vd7Dw/kpSfQQwiSXICt0w==
X-Google-Smtp-Source: AGHT+IF67fxQrWpoAe5qzjn39W+1jcMFR1iH5Kot0Zd+DhKWIHWsmZhQjpjYtrQUdC7Q3tMrQys2fQ==
X-Received: by 2002:a05:6000:18ab:b0:429:8d0a:8108 with SMTP id
 ffacd0b85a97d-4298d0a8213mr3365814f8f.24.1761301693233; 
 Fri, 24 Oct 2025 03:28:13 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e7630sm8703748f8f.10.2025.10.24.03.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:28:12 -0700 (PDT)
Message-ID: <07d6854a-4c70-4234-a345-a7546e1374b3@linaro.org>
Date: Fri, 24 Oct 2025 12:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 1/6] core/loader: Use qemu_open() instead of open() in
 get_image_size()
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-4-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024092616.1893092-4-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 24/10/25 11:26, Vishal Chourasia wrote:
> Replace open() with qemu_open() which provides better error handling
> via the Error object, automatically sets O_CLOEXEC, and supports FD
> passing with /dev/fdset.
> 
> Currently pass errp argument as NULL.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/core/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


