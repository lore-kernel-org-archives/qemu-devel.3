Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C91C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5d7-0002IJ-G4; Thu, 06 Mar 2025 02:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5d5-0002Hf-9E
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5d0-0002il-IZ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741246004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bhwDuhJ1tTLGNxTF/qNaU5ImEDZVJdARyHSoIsnYC7g=;
 b=hRwmTHdmIooazK13fZ+viYoWhWTD7VWnfRx51KA2AYNbW9IoWzUP4W6KuDJ6Vt1D7pFB9H
 1lJzwnfB6V0FBOp+OcxGgj5iLcmp3nQyX+ujzdTbg8dnEuqD3CwiQA1JYegduigButDxe3
 xjACfdXQK2SZGjrn/eV8zuwU8VcK3i8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-a7s5IWoUMqmGOJoaqRSonQ-1; Thu, 06 Mar 2025 02:26:42 -0500
X-MC-Unique: a7s5IWoUMqmGOJoaqRSonQ-1
X-Mimecast-MFC-AGG-ID: a7s5IWoUMqmGOJoaqRSonQ_1741246002
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390ddebcbd1so192587f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741246001; x=1741850801;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhwDuhJ1tTLGNxTF/qNaU5ImEDZVJdARyHSoIsnYC7g=;
 b=cpCHITuOq5EjvVUmfxFL21FdYNos5NLj4xZoF/iaSVEq+ra9EOWK4dGvtoEgX6PHse
 /Mhlq/Y/JY4a8PfuYF7wXjZARZ+bA3gW5fB7+92rBhudRgHQlGkyuOgO9yWqQn7PMucI
 zEFERTqIfDgY0T8ssQJvUKlZ5vN0oAP6T4oSFbIRR6W52MfoDn7G5U5N44T14MJdglif
 j+NFBiK+Z0FOo1z+U/Xdxq9RTauJq6/TjNr+0yxy2VYGglaGZ3uSZFDY33RpGIRZqA5b
 BEJq2vQUTuRGDgT9TEEn0YyoMNqMQPcrhZgxW1zuZDofHO1bVuzZSxAYToCG8UsXl5AO
 vyHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkSDgdnP13pD1Yc+BoHHzaw2DgQRL/z6+Pnuymz+A1q7piw3ttX7fESYuls5ZWJX/+gzuhf918U0ZQ@nongnu.org
X-Gm-Message-State: AOJu0YxaUa/04MOoKL3Dkwd2eCI0nrbnhMM9C9uVSFsYXY5Lz0CDuSzM
 GBtCWN38AmUWdJo4rAoz7mAk36tg5r4553YgvOkFQ/eXXHPJaaczSFHQZkwrlSxCLoTCT8JPsjN
 VTs5KtvayD+wsiYFQmyhZ+njmkXSkYeVAPOhcMDfh+N+JumBHz8lASzMgURc9
X-Gm-Gg: ASbGncuZ3j21T+UWITUe6/uZ5AepA7OP7H6wJb+h9nvzxkKdBJSlOX9pqNqb34JWZCE
 dHiryqtxC0Fo9295NohzKrocI70nQvu6UGd68rsxOST06ngwZpD5BOipPIek7rn56YZ9vJQmUX6
 L6WkL1mFWz29AIJXtCWiNZqUcWTSF5kWipjsEU9QC9p+X7kzGDKTz5TofdMfYODtNd9sRI46nZ9
 l3wFKu7ZuXhWJcco3ooShkEwsPw9Jk5G1hOHx0o1WQ9g9Olyq2eYQw1TxsfDm4XijD3XJQmDGo+
 XiSaZRgwotwatn6eLXOokJlMyOK19UagSutfgFkTejtQIyc=
X-Received: by 2002:a05:6000:1f8b:b0:390:f400:2083 with SMTP id
 ffacd0b85a97d-3911f58fa13mr5895100f8f.0.1741246001700; 
 Wed, 05 Mar 2025 23:26:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPfgjvvNY8mfUw36Pftg+Bbp/VOSHoz+LIdTiFdpEFFvRswx90F8BdJskCnZ/fkNUFRRS/qA==
X-Received: by 2002:a05:6000:1f8b:b0:390:f400:2083 with SMTP id
 ffacd0b85a97d-3911f58fa13mr5895085f8f.0.1741246001395; 
 Wed, 05 Mar 2025 23:26:41 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93ca93sm10386115e9.32.2025.03.05.23.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 23:26:41 -0800 (PST)
Message-ID: <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
Date: Thu, 6 Mar 2025 08:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 05/03/2025 17.59, Pierrick Bouvier wrote:
> On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
>> Introduce an API to get information specific to a binary
>> from the binary name (argv[0]).
>>
>> Initialize it from qemu_init() on system emulation.
>>
> 
> What we want here is more a include/qemu/target_info.h, which will allow to 
> query the name of it, and helper for every architecture:
> 
> target_is_aarch64()
> target_is_ppc64()
> ...
> 
> Eventually, we can add combined getters like:
> target_is_64bit()
> ...
> 
> Naming "legacy" something that will be present in the long term is not the 
> best move I think.

FWIW, I agree, this should rather be target_is_64bit() or something similar, 
like target_words_bigendian() ?

  Thomas


