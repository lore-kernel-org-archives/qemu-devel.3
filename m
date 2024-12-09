Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2163BE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXYc-0004Ov-2W; Mon, 09 Dec 2024 01:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tKXYa-0004Oe-28
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tKXYY-0004R0-Cq
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733726865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RDABT13Wpw3bgMFtsKZ+iwbSnNh30pSPJxpMvGxWEM8=;
 b=QULwle3qCtgkPFB2HGDt7j3mmALhUvxMyjdyjMRMDSYhgH5vez3Da2c+DHPgx48C+hetij
 Wf0sRfyEXwVrW6dbrnGw++XG7MNFg60VeiQfDCDJnR/0ccRuk+cheqwNXKwnkDTlOmXpmy
 YXlUZXPEyWnS3u6xFS7ApEpcL7EbSVo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-kTVsWWMPODmvSdtn7720DQ-1; Mon, 09 Dec 2024 01:47:39 -0500
X-MC-Unique: kTVsWWMPODmvSdtn7720DQ-1
X-Mimecast-MFC-AGG-ID: kTVsWWMPODmvSdtn7720DQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434f0206a83so7250415e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 22:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726858; x=1734331658;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDABT13Wpw3bgMFtsKZ+iwbSnNh30pSPJxpMvGxWEM8=;
 b=HcPUBN17p34PSO23pBJnGvvm50Ya8zmMxkFJu1rD44X9FMvxLgUZWHzv4V2+3k35k5
 Ak9YLXczTDLmtIBo8cfkY1p1h0fOFjY0RufCkuTTen4748MZYm+DdbG55ix+LW2OLBke
 wjsRl2fLU7VEi8E+DOly7bIVkDROtx/TJUIpuyiNEUG/AmLqc9GwP7n4LpPv/Zdanw0D
 +P/r4d/tgPwB+e820zkB5t4fGGSqIyPlDx3eQA49s8v8No8QxHouqICyXBRHnxZH2EXZ
 dRlL8i8qAxpCUUveDsN7vKWFn/c+AVP3R3Mpher4l0NxL2/lRiTVjOxeliOPEhYmNePZ
 9mtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkjbRAjRfI0KSKLdphO37D/W7qDMU92bcQ9OC2tt5eKm7jkovJQ18Y/88lES0rNlNcpDDNFiOgiLiH@nongnu.org
X-Gm-Message-State: AOJu0Ywf/iXhZFKNkqOXTOHbCXew2gGFz2gf7tx+ni8RMjjnsvMZshq7
 xTZPO/hfCXQP7oVYZgR+1nv5dJC+nc9StNT5A5xqW/E7Rdcfyt0QYG7MR//bey7IrhpVV6XEX3e
 ees9K1pZ/AE2vPkKGjX8paHod0yNM4hw41oy68w8ZaBSfcOAO83Fn
X-Gm-Gg: ASbGnctn0cP62lr0Gl00oX1gEsKuLrcgnwDra7z5KWuLwKuWNBZGsqPfy4cceVqVFcA
 FGDtOCL2/YhSc+FVZAGBcvm8Y7/LbCQiFvNgK8/iPRUKQXyu6MuOLaMih78Yq40vTOshHY34mOi
 faQX5lqa07pvMQM/1dWGtIOIFGHEpPxW71LTwSMwPJ260WrQajZ/deG2oOIq7hL96Kzir1tX+E1
 +K8DBoN860RixRdc0s9ZjFIx+9RcWim8+Cy6DaQ9XHA7InUM8NOQTLRaRfPK+4gYwjjaAt9OwGg
 pD5H2ctc2JT4
X-Received: by 2002:a05:600c:3caa:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-434ddecff93mr72783155e9.26.1733726858421; 
 Sun, 08 Dec 2024 22:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkP5TA1X0N3O8M0Y6g0mElJUeI9Ke76rq+IpjP8lwxoZjtOwtA3TprS73rCA2kGo1DVFif8A==
X-Received: by 2002:a05:600c:3caa:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-434ddecff93mr72783115e9.26.1733726858092; 
 Sun, 08 Dec 2024 22:47:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4008sm12099402f8f.22.2024.12.08.22.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 22:47:37 -0800 (PST)
Message-ID: <b4c2869f-859e-4c16-8161-b1b48cb253f5@redhat.com>
Date: Mon, 9 Dec 2024 07:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/functional: Introduce a specific test for
 ast1030 SoC
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241206131132.520911-1-clg@redhat.com>
 <20241206131132.520911-2-clg@redhat.com>
 <743c8876-91eb-46ae-a3ea-4bee0ddb4e89@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <743c8876-91eb-46ae-a3ea-4bee0ddb4e89@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/6/24 14:48, Thomas Huth wrote:
> On 06/12/2024 14.11, Cédric Le Goater wrote:
>> This simply moves the ast1030 tests to a new test file. No changes.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/meson.build                |  2 +
>>   tests/functional/test_arm_aspeed.py         | 64 ----------------
>>   tests/functional/test_arm_aspeed_ast1030.py | 81 +++++++++++++++++++++
>>   3 files changed, 83 insertions(+), 64 deletions(-)
>>   create mode 100644 tests/functional/test_arm_aspeed_ast1030.py
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index d6d2c0196c76..ef593d4b9928 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -18,6 +18,7 @@ test_timeouts = {
>>     'aarch64_tuxrun' : 240,
>>     'aarch64_virt' : 720,
>>     'acpi_bits' : 420,
>> +  'arm_aspeed_ast1030' : 10,
> 
> We've got a default timeout of 90 seconds (see the end of meson.build) ... no need to set a smaller one, so I think you could simply drop this line.

OK. I will drop this change before applying.

> 
> With that line removed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 



Thanks,

C.



