Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC032C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPdQ-0000m2-1e; Mon, 29 Jul 2024 08:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPdI-0000Pl-Pi
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:37:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPdH-0002RA-01
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:37:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3685b3dbcdcso1527320f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722256661; x=1722861461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=15kywinEh0XlKdvxnTsvCBRl5sX9zJ2wlmMGWqlCqys=;
 b=uYKMT9Aw/iczC+7PeNVapdsruAodmnUzBwkeMVh24x/mo66MkNy+YqphLM+QOCL75g
 xoMGo8MhCjQmn0Mr4RjZVAOCHiOc+xfiKy5Dp5XbO2aKSM/hlA2ZJuu0J/SBuhqi0lcV
 edIbNFtE9ba9E8hWitIkHgJHApiO0dcEQ5uwpi5X8IaATvmXbUdJOwft++oKhLWfmurl
 iS+f/8AFjHkZZs6huBgH2oD4p33bHHdrBVLNoC+VoD/YrL/B4dKqstxakA1J/2N1MhqI
 H5jErOvP/2ux9IpG/8N2ScJF2WFzR3k9j8nrKEsi9jKlRXMQsrKhqp+a6dpqYktEIKwK
 r1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256661; x=1722861461;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=15kywinEh0XlKdvxnTsvCBRl5sX9zJ2wlmMGWqlCqys=;
 b=FEFcgcap7yk9+0FAHzHNY76H2rLCFnIUrUfxyO0WnWa2GwpciGc+4gG/LI2/i/fp9+
 b2Z8w4iJ47VfpXoXv3htNGlvx56TGHyea25tLCyy1OmO6ytti6fnwvknTFiGoXpP/dZt
 KFbwWIhxPL29L4N1PANyNCQEKS6zLKyT8vwSkyqqFAT60yfzW73eEiLUBY/JneLN1xf/
 BnA3ChqIurXdOaDY54OfeuNTrWCBh1cyrRxKYXLjNBNbyLzpG3LUCUiVtyVjgDqvn5Q4
 ZEo31jC+3YGl9pT4QpHskH1rGAgX/ANfBgxFLWauujl1a3nLSqfRRzbnac39WqCD3kqB
 dpWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb0EDo4sEPK5LTBIhqd+LAX74Tf4bqf7pxPOmYgwl1+ZqIUrj4wkDpI0kdoqHx7dJjn/l5ffUX9I8memQrbF3JtdF9/00=
X-Gm-Message-State: AOJu0YyQZPbx6W2xfhtmNM/Gtlu3HmlscB1Sy6fwI0Mih7XXygVxc+V/
 nuDxGMGqeLXHpfq3Eoe2iDupeCkF/sr9gjwJaNiPryeHsyOJQAgYfjY5aDTbh3k=
X-Google-Smtp-Source: AGHT+IGn4pe95bL9KoThwZl1lDasryCHFXK8uFeL8C8A0uJCyMMsvlG3Tvl5Y3lmASKgmgDPoDwGZQ==
X-Received: by 2002:a05:6000:1546:b0:369:e72c:876c with SMTP id
 ffacd0b85a97d-36b5d35390fmr5728486f8f.45.1722256661265; 
 Mon, 29 Jul 2024 05:37:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fcb78sm12158951f8f.53.2024.07.29.05.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:37:40 -0700 (PDT)
Message-ID: <8f9d55a4-9da1-4868-bde7-8ced341bcbd6@linaro.org>
Date: Mon, 29 Jul 2024 14:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/23] tests/functional: Convert avocado tests that
 just need a small adjustment
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-7-thuth@redhat.com>
 <24fad245-6410-487f-b70c-1832f2adb267@linaro.org>
Content-Language: en-US
In-Reply-To: <24fad245-6410-487f-b70c-1832f2adb267@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/7/24 14:04, Philippe Mathieu-Daudé wrote:
> On 24/7/24 19:52, Thomas Huth wrote:
>> These simple tests can be converted to stand-alone tests quite easily,
>> e.g. by just setting the machine to 'none' now manually or by adding
>> "-cpu" command line parameters, since we don't support the corresponding
>> avocado tags in the new python test framework.
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build                  |  6 ++
>>   .../test_info_usernet.py}                     | 11 ++-
>>   .../test_ppc_74xx.py}                         | 74 ++++++++-----------
>>   .../version.py => functional/test_version.py} | 13 ++--
>>   4 files changed, 53 insertions(+), 51 deletions(-)
>>   rename tests/{avocado/info_usernet.py => 
>> functional/test_info_usernet.py} (87%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/version.py => functional/test_version.py} (78%)
>>   mode change 100644 => 100755


> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


