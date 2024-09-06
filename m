Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8072CCE7B0A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYmz-0001JH-Oc; Fri, 06 Sep 2024 09:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYmv-000195-IQ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:14:09 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYmt-0006gK-LJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:14:09 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c26311c6f0so2569249a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725628446; x=1726233246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujVXhfb4wueIwGCYF9g3bUERMGIQ1HcQriWsBezJLyQ=;
 b=iHpKz6CIuqFI5KEb5xXow4hh+VQu9cAKpO/E152PC0o1s3XZYFgSoJVWQh5vS25GrQ
 D1q5DvPScheBkF0uL3vDQMRebKahmp/+orK7/NYzVAG0aPdNThrN2UIUTA0TyCO6lM/H
 WbZVu8zAk+HJBrFhED3M9Y+WwKTc2jZfm+55pzUPn1B3c5GuECrL41MnhOrnqUYcK6hd
 EWQ1zfj8p18QCLRZnY3O1PwOHKxQPeMr3r2z/782Rzs3Nk6aZ8tx+Vt3zVha2OAMJHJS
 SN30Sge5nwJsOEzO6IBm7+XY5QKQgxJfvEYP3/FoFVGcCftv+s4/8XwM0GPNeo07OWoH
 p5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628446; x=1726233246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujVXhfb4wueIwGCYF9g3bUERMGIQ1HcQriWsBezJLyQ=;
 b=p8ziVHZbhUuNhfT1B9CpCnYWoK8ZE74BAVc5IlmdIqI7aYTKIrnzFet0PBM35MLRCz
 KymTCA0RE/itcP9oEewN03AtYHZFoQejHTd0dESls87zFYgLFHlcqKzbC9ObPZwMWzQs
 n0BvxR7+m7xk+sKVmpZ6ixGX/3+aZJ8PT0GMVUYLQxuKtwpSdxiuLEteMxJ0KRfTODQO
 42AYw+iWzI3oBv2H061TFuoe1Q3joiuvLiRvZHR+R+NMtccmh9JKU7HKJ7KCUSCepqeZ
 I7l1DWKIrRovblou9TkaMznYsoLIFDtZ8Fe49ySKZNRfCB9vpbGUNPkyDQRBs4ogjQ/r
 NV0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVLPAvHoHG2h6VNHANko4BOoIK8nCTv38DZpvBI6Eh5jPaCWABoum5EpLmUPk/ZkqWxtMUxwAE7QuU@nongnu.org
X-Gm-Message-State: AOJu0YyCgTI/sXzzpCvVvI11dNAgPTRbVDSIsBdvlBn536DTq3wB4wTy
 s1DNNAkS4UaXdyuJKtTYX5yHymUYjVEh2h9QUNtqpdTzyV7bgtd4M6M6l9l9Iqx3M6vbTRjQAKs
 5
X-Google-Smtp-Source: AGHT+IGSjmNkE2rqQNeoOMrLAm3JiuDUy87HnlrzTTerNyPHpaYy2UEWLIXmpSaY0+NfJGIs/zOfkA==
X-Received: by 2002:a05:6402:1d55:b0:5c2:7699:fa95 with SMTP id
 4fb4d7f45d1cf-5c3dc799e03mr1589731a12.19.1725628445852; 
 Fri, 06 Sep 2024 06:14:05 -0700 (PDT)
Received: from [192.168.55.118] ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc698f69sm2450620a12.71.2024.09.06.06.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 06:14:05 -0700 (PDT)
Message-ID: <c9fb3811-fb75-44fd-a177-7ed67d43d55a@linaro.org>
Date: Fri, 6 Sep 2024 15:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] fifo8: add fifo8_peek(), fifo8_peek_buf() and tests
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair.Francis@wdc.com, tavip@google.com, qemu-devel@nongnu.org
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Hi Mark,

On 28/8/24 14:22, Mark Cave-Ayland wrote:

> Mark Cave-Ayland (9):
>    fifo8: rename fifo8_peekpop_buf() to fifo8_peekpop_bufptr()
>    fifo8: introduce head variable for fifo8_peekpop_bufptr()
>    fifo8: add skip parameter to fifo8_peekpop_bufptr()
>    fifo8: replace fifo8_pop_bufptr() with fifo8_peekpop_bufptr() in
>      fifo8_pop_buf()
>    fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
>    fifo8: honour do_pop argument in fifo8_peekpop_buf()
>    fifo8: add fifo8_peek_buf() function
>    fifo8: introduce fifo8_peek() function
>    tests/unit: add test-fifo unit test

For this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'm OK to queue it but took some notes while reviewing:
https://lore.kernel.org/qemu-devel/20240906131217.78159-1-philmd@linaro.org/
If you can have a look, I'll queue both together.

Thanks!

Phil.

