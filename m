Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6993CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSfw-0001Dx-1j; Mon, 27 Oct 2025 15:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSfn-0001Az-NT
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:14:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSfg-0004q0-NP
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:14:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso64194215e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592458; x=1762197258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ze1HeQwneioMnf4Ze6ioGnVXWQX8YBJ4TneOP9JJPbo=;
 b=ZeE/Og0aEwEltLv+6zSgBmXWZ1y7XmsPkR1UIju95TxcY7iWen5nl2TBEOAxNuS8zS
 dOVBfUQET4Tvso5h5Ch+GwZEYELBT9rE4nR4w6kQwLNjsxY+hCW3Na3PxbFJ6haY71XY
 CPaJUphEE1lJl+eC+mn1+JA9gZn05lBJwd7mCBn8Md41a8TCXRyUpIvV40hFHq+kEOcN
 i+TbetxC0FauCPJaM2IAnDJVkfCfRpOilvsudu0Y0WxzTm8NmMYq5KPWxQx7SsRq3kV+
 Adr7YA5c1GbFYgWpYLKqCecLCChMMgAbw8+y1GJq9YhwjPa+iZwJlo3CoKGyQQSRP8zl
 z4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592458; x=1762197258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ze1HeQwneioMnf4Ze6ioGnVXWQX8YBJ4TneOP9JJPbo=;
 b=OkC5CEtlh/rSTn9MX4wZO1YX8KlKDY5CzpkuF61evaVwDKmwq8Ox5JvR3KKUQr9Wuv
 EOftOHePJNEuigITCTrfiV4zC7vPFPMPToCvtuSG4getEfRQP9Bla1OYlUXQuXjn2dnk
 rV6p7snRJkC9X0HtmTYZGB27otxlReVme3f8hTpPq3351uduSyvQdQEsZnWknPaAC8D4
 ae9eSE2vqCHxQwcy0wRzkgB4QjLJRTI5T6GejBIgLGzpQTl7b1H5hL5/gfxFRyJ+1nSm
 Cs7haMqrRTEjDbhwFwhKiKJkepcSmVjp803hCocvjvs4y3wSfWoU3LVi92DoUvSEkGl8
 I7DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpHE0n+2lnRAG5kRSgSo2eNYdyCTXyynMEaLmoc3nvs5KvwjDggZBMdu3YDdK5xT0tkDEMtjMW40vo@nongnu.org
X-Gm-Message-State: AOJu0YzPc/MsmwjPbP4Su0kNR/eX8S/vVo42iNSdE5T/uAFUkSWC35tz
 ijUtmocIsy9V8Y2dgygujVP+2NBlDjPn4y4CA/YD8lvmsmT/AVoRrwahRHsCx/9WH1Y=
X-Gm-Gg: ASbGncsutWZFYjTNBBjojDrq00ynOndvPUbdVcBxTDQMXK3tTcRAZv7DzNqA+v5uw9Z
 A8XlvSAUWIvcDclgnp8vfkjBoeu+9JtU4cNt/xRADGIzapIN7B1ny5bjypH06bSbWGp04Kn4sNR
 zNL08c6bhgYpZKTny0eSLaPVNVX/nryz7SzqVVDT3C1qCM9bO11ed8CdHQnJpz5kUM5Pq8V1onY
 Q5lQk84ghHlykgNEqkqZ+suoe9LOuJyJID5trAQ/VfR/6TNXGERM4DVGCcEtEMkXuvwxj4ULNq+
 LD0z10YgaRjznxQoIPB7C1I/VYRBL3IwsPZi6gV6trKGrd1fyvKkH6dw3f6CzjOXuuu//gd3s8m
 fX1GniJdx/uuXX6l/t6got1Kkn+gVN+KZOsYbtP8Lwja8yIKViWh16GxKPl8UcovNKGGBSRZvSV
 UXHBR0JIIsYRAh/dKJ9G12hKMAX4QpKiNwiSKT5jRTRSQ=
X-Google-Smtp-Source: AGHT+IHc9ZeJ2F/prmKPtuWawnnz6kgY8imn0zgOgZLy8B4nqZPyG3oEa3Ll5Hz4sh2bjGhJ54EJbg==
X-Received: by 2002:a05:600d:8386:b0:46d:cfc9:1d0f with SMTP id
 5b1f17b1804b1-477182e1357mr3464165e9.19.1761592457826; 
 Mon, 27 Oct 2025 12:14:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca569sm15454761f8f.12.2025.10.27.12.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:14:17 -0700 (PDT)
Message-ID: <d66bb755-0f35-4eec-8919-c37a48330282@linaro.org>
Date: Mon, 27 Oct 2025 20:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Remove an unused state field
Content-Language: en-US
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>
References: <20251027075232.95262-1-clement.mathieu--drif@eviden.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027075232.95262-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/10/25 08:52, CLEMENT MATHIEU--DRIF wrote:
> dma_translation has been moved to x86-iommu and is no longer referenced.
> 
> Fixes: b6b49c2cd6c2 (intel-iommu: Move dma_translation to x86-iommu)
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   include/hw/i386/intel_iommu.h | 1 -
>   1 file changed, 1 deletion(-)

Queued, thanks!

