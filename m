Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D59DC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 23:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgY7w-0006wN-4E; Tue, 20 Aug 2024 19:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgY7v-0006vp-8k
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:18:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgY7p-0005OT-6A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:18:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20219a0fe4dso32610375ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724195931; x=1724800731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGF7z297/xnHxlZCMEYgn+RL88gp3O63Z0S/sZh1neY=;
 b=aB1VB3/AVksk7FKX6x/lpSYmuDpeNMo8bgv0Ih7xMsQ0yit1Inapd6qW+EMXSvtp0R
 Af7DtmVRUjzBz3tGkDydrNbwYDUG0O5hcAgbVxvUk1hsoRBM35IIuUcEhuTAew0Z+M0r
 D1EoAxgzVnBD1+cVCaBsmP+FJTMMqkGqvURDCbSP622WwQbbNRqaJFWmNFD4QqfxQwYw
 4JbbBnRkgZHZbMBN/DrtwealwlhV4m0DXOGyCmIQC1RX0vaqhs7CVCLlc2iUagaDFVK3
 /mpQyZQ8JfGgC9oK6U85dD65WLziMYq4DiPB6vkuIrEPiafQWwdrDBjXXuca56jsjdhZ
 BlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724195931; x=1724800731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGF7z297/xnHxlZCMEYgn+RL88gp3O63Z0S/sZh1neY=;
 b=D1/8LagFD270tgdQ+3C9mKBs/8yi0Ipwn/P3sk+3yiOM4f4pbJSWh4LvLs+JkVzrtE
 YwB6xjsyDvRmPu8jZh6V95GBnmyokKT+izqYKd2k+PsKu36zD5VG1H5b0IR4Zu7rWBtW
 wt8zz2fKQuPWUcsImaeXVdcrXRaVHVs8lQoRrHxM6Fnj+WSKiBqlEnuepLvxBycoh/Sr
 wLDgpB6ZthserqVjY5w50OnrhhFM8TUu0PWrBX091DZsd0dPBjh+WbzJTDGawoAvSHMC
 vmR7NOIPNyAh8AvgldVc9MiIyBi+dh7coeuICQeBqDr7N9AWFEFWvx0rzFbB9lbKd3wY
 F9gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdF3TA8EnGNucYMLT3aYUSZw+0+uIa+aA57DKSHU1OOgxhWubB8qcPJmn6UE47IZ2+x6ri3LVb+Klu@nongnu.org
X-Gm-Message-State: AOJu0YyVCXOZZRWvbtHrmcB6x7Xym7qwDBMWU+vfrsRhwnG8iBVNA6jL
 fTn0eN6MSivq/g0hdHcumxE2gofnRrwoI0S8UTicGi+/WzEm/B3UxMmdCdqIk6yJ5fIyR007zKd
 e++s=
X-Google-Smtp-Source: AGHT+IGcgyS3EvdvKJH+0hVFxFEPTpVfDAAM0WMxUfSFCooUsBVn1O/1tWSKiLGcbdk1m5dnEXXe7A==
X-Received: by 2002:a17:902:be09:b0:1ff:6b6e:d2bb with SMTP id
 d9443c01a7336-2036807427emr5340715ad.45.1724195930960; 
 Tue, 20 Aug 2024 16:18:50 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038b320sm82650375ad.193.2024.08.20.16.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 16:18:50 -0700 (PDT)
Message-ID: <7800dcd4-5bdc-41b8-b059-1506ec1ef3f2@linaro.org>
Date: Wed, 21 Aug 2024 09:18:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/pc: Remove vmport value assertion
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/21/24 09:11, Kamil Szczęk wrote:
> There is no need for this assertion here, as we only use vmport value
> for equality/inequality checks. This was originally prompted by the
> following Coverity report:
>   >>> CID 1559533:  Integer handling issues (CONSTANT_EXPRESSION_RESULT)
>   >>> "pcms->vmport >= 0" is always true regardless of the values of
>   >>> its operands. This occurs as the logical first operand of "&&".
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
> Reported-By: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7779c88a91..5302fd96b4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1221,7 +1221,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>           isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
>       }
>   
> -    assert(pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX);
>       if (pcms->vmport == ON_OFF_AUTO_AUTO) {
>           pcms->vmport = (xen_enabled() || !pcms->i8042_enabled)
>               ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

