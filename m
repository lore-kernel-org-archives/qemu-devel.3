Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F714E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkw6-0001uf-E3; Mon, 09 Dec 2024 16:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkvx-0001uL-87
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:04:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkvt-0005pI-1m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:04:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435004228c0so6883165e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733778283; x=1734383083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBkW7M45SlBrvwwYNxP0+vEKPB0yLG/gG9W8MkJ/p/g=;
 b=Jy32PSYi3Mw0/ltx8yqs+lqhRQSFp+hQKJ2Ch5XxtmC1nOjvpmHF4w67JS2anaDLao
 70JAGHO66h4gT0eZTL7Pc0QwaJFVOHvdCWWZB+x+pKLuKdPhPXUYn3msZ/GGz2+jW3lj
 WKmDjx+aGZov9MhxY+xidheIH7QJQGNQzdf8p+1L+SwY+/gKkTlHfSaaYkms60bITEr0
 /DIbJNX2Vkfwz7NJqcunFT7imegzHxc6L8irsV66WokJxR0fciOlDmP0Z5XBQcgJ/65q
 PC3hHs0h3ltqMNrHAeozNVXjmLnYH/SE0stTmhTZgYRg5IjFXZ1wY8ErcWqIFs8e7swB
 tETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778283; x=1734383083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBkW7M45SlBrvwwYNxP0+vEKPB0yLG/gG9W8MkJ/p/g=;
 b=cAjDhdM6XPOj9LbMMoi9GqE/rsgOBVM/gPNBfNX5W/5/ixRBlzq7iRmxnJwZdKIAkh
 OIlNNzDCc7wYFtGSG158MSlHivB8twLTyQsjtKvKbsTs6xm/+4X2h4LosdrQ/1y6OK3o
 M3jNQgeTwhhFVqjRirWHHJdDJndqedA3Hmn4L3WRVRJv1zHXTug6gEca9gi/2D13wp7x
 nzlFKsH3ktfdAj0O030tnVbHrjI5lsTMHGaUKXiOWysI7psTedUJmMr0HRuK/MM0NDWk
 t3m582aekC1xJCGEulAXvgk0WfEB5SkA3H5DGU6ULN2zTfG338Od4oCPmgkmsImWDsvY
 dBvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbJuEufoOQth4f8xuy6VejWBqhmuCE7oMHyPpMvrVmFsKU4qNCXd3gbboAOCxO3xIJGFrF31IUFboz@nongnu.org
X-Gm-Message-State: AOJu0Yz4n7PrSjdrl+xhPdR4ALjCUSjM5CryMDXSdTNRxivJ8d/3718N
 l31IeTkgY3URbyJTNEkB0qvBGN5Fa1zfdYsl9HGtAqIaUxvxRoQa8tysFJF5rZE=
X-Gm-Gg: ASbGncudpIC+77f5CcOpOnQXhy4FCWIrDAqKcnXCE1M+4nbF74bJ/1ujCd04E0vXgmN
 1ScceWnA4M+xrdzxNmA1XkSvOSc7dsEqgsZjv2HyhdDrT4E1UuYTB5dukRHq2EHYT1/leIaKwKK
 hWUwI/hTSaQBQUKalRzR6LXAKYw3fcnqh5d0Cw/RL1HCjGJgNl2A+Dh6EK98k9cqfokM2Igcbor
 1WEPOWdjjR0WGOgoJ/hr2pHPebTOumXU7QNw8UBrys4Efqrw9SZWFnNEIvlWJQPHSpm/9+M+hK2
 EY4mqbjqLu2ox2pF7SIVGkzAmjHN78VAE9Sj
X-Google-Smtp-Source: AGHT+IFihtqSBMKE2PcQXoRdKaqy3H7QWfwrOs+5vPgSYMXsRq40S/FKb72JJGEUS524gZhgGwFFqQ==
X-Received: by 2002:a05:600c:5101:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-434fff3d84cmr22283055e9.8.1733778283128; 
 Mon, 09 Dec 2024 13:04:43 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f0d6a825sm85363615e9.20.2024.12.09.13.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:04:42 -0800 (PST)
Message-ID: <c6d03941-6100-46a4-9258-a465ca0557a2@linaro.org>
Date: Mon, 9 Dec 2024 22:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tests/qtest/bios-tables-test: Free tables at
 dump_aml_files
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20241209204427.17763-1-farosas@suse.de>
 <20241209204427.17763-4-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209204427.17763-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 9/12/24 21:44, Fabiano Rosas wrote:
> The dump_aml_files() function calls load_expected_aml() to allocate
> the tables but never frees it. Add the missing call to
> free_test_data().
> 

This is also Coverity CID 1549449 (RESOURCE_LEAK)

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/bios-tables-test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 16d0ffbdf6..1cf4e3f7ef 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -292,6 +292,7 @@ static void dump_aml_files(test_data *data, bool rebuild)
>   
>           g_free(aml_file);
>       }
> +    free_test_data(&exp_data);
>   }
>   
>   static bool create_tmp_asl(AcpiSdtTable *sdt)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


