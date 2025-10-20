Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BD8CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAm5w-0005z6-QW; Mon, 20 Oct 2025 05:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAm5v-0005yx-SW
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:22:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAm5r-0006lz-Ml
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:22:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4710683a644so36784925e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760952138; x=1761556938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWRjhxb+gyKvKWcOh9+4cyOuV0mefOIUwVxvlJJDpQY=;
 b=GCtq93cplsYccWuJCul1rjSs2Am8mttFbU6PH/t44bQANNjflozm6/J89yHo/ji2TJ
 MJwGcct2OVwNCIjbeIkZTXVwdQMt4CJRPh0o1XZaO72OtFkpDs7U3FiPjAA7iZr9XK9S
 HOPWpCh3+3j+e1rPHeEbtXVVglPav7SL0lRMcdzY1jBnHVqkn/WhMln78uY1y/3Nsqzo
 lm55ERYktq/8xgyhl52AlDemEpRG1o7N6lUWqeqsGj7tJtvFAAOPUbUQ1y4ZkLaSbQIt
 NjA2KBzG2IOlQXPeCBODA+vNl1/+1erqlWKqE3maLjgLbEqIDUnRf4cNlv6YkFc1Vajh
 N/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760952138; x=1761556938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UWRjhxb+gyKvKWcOh9+4cyOuV0mefOIUwVxvlJJDpQY=;
 b=Zv/3sTdzJ00p9uAe8oxTz57BCcFLSJBXDUCfSh/kQ2DOXqQZx+Xd1Gq0MYBe+5Wpeu
 0QecmMNo2yMX9QnYPpZjsN3sNQSDxHojckx3KlWNv8cCuSg4ycwrrz9yoeOGOOusciNo
 DWi18QlvN/FfOiTGu0F8Iz7G7aArWivZFFIx6RDDLHuoatZajO8yDvXqzhazJWl9aRez
 tTj6ymZIPdR+RKG8900/pS2NONDrYhrma3e33oyQwLf8vVg6U+NtW7ptiObPLYMBZRSR
 EXwTtFSto6BEDhWPMBJGHtuU4yTHL5d1V8T0wfr6gYEC1SrwHxh+3SK7SqUEZ8rmyv0q
 5b2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXhgVMwlRyMWG14MKOg7lXsBSCil9Ab11kTU7cPxuWpJV/SJ9abB5PKyFSpHRKgXTUdR74A4D9drSg@nongnu.org
X-Gm-Message-State: AOJu0Yyn9W0yRyCYJwfjBXZnI+WanH4JWSXtOMOczch0vIi8v1QWC4NE
 tr24rqJBxWx7T5kxrlVzqbrSFxxlLFZjkXclIYNbeTkYMtT+WK8Qe8aXNPOJCBILA23+0YVSsj1
 OcxM6v+M=
X-Gm-Gg: ASbGncsV1Dh8Ni56kUNoVDJYteD1hLPWj+fDq5c2FyysLxhVcsJ2CnKhwo7t5Ymj/Sl
 AaBiRRjZta5yfMvs2OeNM76b0bbmC59NXJ7hXYOUXnMA0V3amTqLPLOjzlw6RKzpwqFcmMvGLYJ
 iYlEsoOye7IBnMUntoZMlLO8wq7nQfVrfinezIQCG0zZit3w+7nV5KwPtp5bEpmLu5ND/8nqbxH
 ml8JVnxAhUKrvl5mRsKxxXuMUOTQXm6K8V9YsfCSvNNJH+xtkLEaAEs5Ho1iPgbesaDGfrGrtfp
 8MqQ/BD5Zc54sb7IGTP6bbOBYuJLNlEAdwt1MEYTdCmvHVT+CwZgrcTrQwQvwrynx7+fz0tV649
 KQbN/fiiD1Uki4x+p7lYujrnPuhceoabpLFOsAAwJ/Y0PKh00KLr/S3F1lythjLNGyQ6NkmIC5w
 UNv5kfiDtpLSET57BGlPO196tojTxSL7gqON1Vg6xeFgu6cqNLz7dFGg==
X-Google-Smtp-Source: AGHT+IGk9JerB5VH5Bc1+wspOurenN6W4CswekXAcxBNYBPP28lYrksG6ZcsoSNFNlvKDEgFtqW+3A==
X-Received: by 2002:a05:600d:42ed:b0:471:331:8058 with SMTP id
 5b1f17b1804b1-47109927255mr76796565e9.7.1760952137598; 
 Mon, 20 Oct 2025 02:22:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4714fb1b668sm154729265e9.0.2025.10.20.02.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 02:22:16 -0700 (PDT)
Message-ID: <102a9874-27db-4073-b4ff-dddeb450ff5e@linaro.org>
Date: Mon, 20 Oct 2025 11:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c/smbus_eeprom: Add minimum write recovery time for DDR2
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
References: <20251008122502.9DA8956F301@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008122502.9DA8956F301@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/10/25 14:25, BALATON Zoltan wrote:
> This is needed for newer u-boot-sam460ex versions to pass the DRAM
> setup.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/i2c/smbus_eeprom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 0a1088fbb0..26e211b31a 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -288,6 +288,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
>       spd[33] = 8;    /* addr/cmd hold time */
>       spd[34] = 20;   /* data input setup time */
>       spd[35] = 8;    /* data input hold time */
> +    spd[36] = (type == DDR2 ? 13 << 2 : 0); /* min. write recovery time */

We are adapting DDR2 values on a method written for SDR/DDR[1].
Better would be to split and correctly document each format,
using proper values.

Anyhow, for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


