Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E3E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDV5-0005b6-6Y; Thu, 05 Dec 2024 10:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tJDV3-0005ai-Lv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:10:41 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tJDV2-0005KO-6f
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:10:41 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53de8ecb39bso1443880e87.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733411438; x=1734016238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tZN/imqR9tvxlIknkTQXLTdt5ltqSOgCSVPhrXj949A=;
 b=q51kpMcge0fWUOB1blJhO8ptLgze1u8kIP1EpmDOYX0WHyzEPOO99csA3NEgqW5ZmK
 PndkGq8qFC0qjEMhxDC7aAf/6LzU2NzpBfs+YOlVeKynEoS4Xmwxd8F0BryII9U4Wh3K
 nJtb9riY+jiiHEoeVYsl9MFtZDFRAcFHih6HOXFyI/moZlNFlp5seqto7y9BR4q2IkvS
 7EVSW67/9yF1QbVqvv898ez2koqcIkjCBEkrmkRbVJyupzGL4CMLm+ZzYVgcqPpROLwB
 PyL0hsYAgRjfr9tYCXO7aaIXEodhR/RnI1CnKoP7Erw8q0gNAN18ANqTwJlAcb0aO2xq
 8QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733411438; x=1734016238;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZN/imqR9tvxlIknkTQXLTdt5ltqSOgCSVPhrXj949A=;
 b=fOfVBeSeI39VfEin4W/hxYLTfPIw2khr6quMzMkqa7VV+oxMf3YDuO2rgN4a0zfbk+
 qHtujw4AqhQNaEDYsL2av+cz09H0B9E7SYIqGVNIIqiVNIg3Oo+bkmhMh3+h5HukJAzs
 oah7o8k+7GH6LceaPeYbGRO7zcmvvcJTA8YlCMqivNZZErFet/pmiwxbAqKh0yAnoJsD
 /cMo98vk5yTAiAF4X0jU1fDRhl5pr6YYx0WR7Ft5uUzyLY4nhBQroDevV1f3Mr05OhOf
 KdEuzuPFu5SSEPJScs6fDRuBq756YHMDRKhpIuToFyj0WmF5/Vuulbjxzfu3s3D+Pd7z
 xt4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn5DRJw1pZDnZe/owS5eKnI8nV7VyjD30X9QbGP3k+cU9a+ILeiBGVzXtGm3wnx4fYNb3l9Cu8COYk@nongnu.org
X-Gm-Message-State: AOJu0YzHnotuEQROl440FxwVnWrceyZ+v9dqr1NXWO+e2WhlHTlSeSJK
 pQcSoFPb7iYx5j++AcCpmvAyy3n51ft0edwBovAelYS1cEdeCUlqYrHJ44Zhb2w=
X-Gm-Gg: ASbGnctK7sTr/O5oWtlEiv1bUO/IrUiPWYKchlvSBqxd2jBj5t+caXM2w2K8c4Irnrp
 X9szT1fbsm7QKiesAXQy6rtf+J7nf1V6Nv5E6TXG5LPzOXKzc+DIzxiYn5Vun0E+Djfc2I3loGf
 1dbDTjxaFqkLa1y5avm4xa+wNYuCDZ4pEGH8tUPZJ1g9kopceXJWkSGg4WfpJbLquz08+RUey8D
 ukCoYKW+ScaSkaddgowS3CnkHy824DOGNmZWcxPJahcJJ1qsaU/TCJ96s35BtshW30GYgtdb/HG
 7FCS6+3BL7mi2ssvFYKGR4hiykkx028=
X-Google-Smtp-Source: AGHT+IEie+K55PScUSA5EMRM9kOKXFD0oWDmC8Gs/TK3X92fyPU1y3ZLU6M7kee3wlZO5eMjmeIgfw==
X-Received: by 2002:a05:6512:1249:b0:53d:df99:c5ac with SMTP id
 2adb3069b0e04-53e12a3197cmr6841131e87.36.1733411438186; 
 Thu, 05 Dec 2024 07:10:38 -0800 (PST)
Received: from [192.168.210.26] (83.11.36.235.ipv4.supernova.orange.pl.
 [83.11.36.235]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e22947958sm268242e87.54.2024.12.05.07.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 07:10:37 -0800 (PST)
Message-ID: <641a4d44-1406-4d3f-a87a-a12fe156b2fd@linaro.org>
Date: Thu, 5 Dec 2024 16:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, leif.lindholm@oss.qualcomm.com
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
 <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
 <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
 <c4245af0-3dd4-4cf6-a786-c15fa079ad05@linaro.org>
 <18ba737f-d669-4e6a-8319-fb5052223b26@linaro.org>
 <CAFEAcA-P5P4AJidWcGgUScBTe9-K_C4Qm9N2o2XWnfiT81LU=A@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <CAFEAcA-P5P4AJidWcGgUScBTe9-K_C4Qm9N2o2XWnfiT81LU=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x132.google.com
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

W dniu 5.12.2024 o 15:53, Peter Maydell pisze:
>> This is sbsa-ref not sbc-ref. Let it just have that 2GB of ram.
>> None of existing SBSA systems comes with such low amount.

> Yes, I think I agree here. Changing the default RAM size based on
> whether the CPU does or does not have a particular feature is
> unusual and not something we do on other board types, and it
> definitely doesn't match the general intention that sbsa-ref is a
> "looks like real hardware" machine.
> 
> The problem with using 2GB, though, is that it doesn't work on 32-
> bit hosts, which have a max of 2047MB (and

Do we do CI on 32-bit hosts?

RME tests (queued to testing/next by Alex) already use 2GB so in such 
environment we would have failure anyway.

