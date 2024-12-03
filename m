Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C4E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIM8U-0006JD-HC; Tue, 03 Dec 2024 01:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIM8S-0006Iq-Fn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 01:11:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIM8P-0005Tf-Rs
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 01:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733206304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xQoAkXjqDIGqIBCzYjarwH1dEHgmUsV/Es5SFMqR04o=;
 b=ICg6aLG652PRtFBZnpiPI721+y8CJY8pNHL5Mwo96drYzi1j4jVNk6pXaGkOf+IU5Mzlkg
 KPEhvej5NpRjMpP0CmIweUGDbU5JqzcEqSNINyh9acHrlc9AExCHYJb6wXxToueBogZyAB
 V7U3ofH800NyG8kId+4AffcB8/3wi78=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-26TOS3KYO0qODIFBS2LE_w-1; Tue, 03 Dec 2024 01:11:42 -0500
X-MC-Unique: 26TOS3KYO0qODIFBS2LE_w-1
X-Mimecast-MFC-AGG-ID: 26TOS3KYO0qODIFBS2LE_w
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa53efda0f2so301194466b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 22:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733206301; x=1733811101;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQoAkXjqDIGqIBCzYjarwH1dEHgmUsV/Es5SFMqR04o=;
 b=Q+yd9yGAHAK7rlR5QwQASiHhqIctgIfnCkSrVv9MaXYX61YYLSe8pQwC80jVTzSeSw
 F1lRkLL38h2EA2XAYTvYN+aPvknoraC02E+aOdOCkuxOjcdtL9f5+ct9GncFKDAu8aYW
 qLIDAK8hccr5jlnekozTL7VoVbk5sG8FnFytcn4QtQtU/ISKSNM7VVAF0UeoiU3gAyeT
 3688rweYYOnjge/WBbewKd15Zl7Xq1+T+QaMu6BwMdYy2jLumYnoFbhSr/MZIaf7aYwc
 cXEASsJbYINBLqA4AlkihEIuCxTVXxa2jDCwVqi/Y7VcHjrpgA7Gjg16OLqoDe9gA0Ml
 YY6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI4ugEn4LCGzM2d0ve9Tfxd1Ej9u5utatCt2n66P7ywQkMmovjKqKaNS26fcxsSVa+83I2I5bwEsRg@nongnu.org
X-Gm-Message-State: AOJu0YwbzEkG7LHjkurrQhTkwztRRgv514fAdVwGeEGNOLnqrkipKC7E
 rfYvd5bg2joWlOoL/H8OanX6YbwX32g3qV8oYmlWA5vX0WIUsjO5/pT733qllh58PgUZZeC/aY5
 ACsBqNaxmGRVfdWwSD2cbOVVR8yK9OpegYXnmpdDsnQWFvFh6X61h
X-Gm-Gg: ASbGncs6d0IIkQkwMEUubjnf292HeWGwlpx8CFDEvKS02NZnTaHtI7gW54cYLQTatuZ
 k7B702QE9AG/MjYTcHhlyJMEMWpNYjOwpTIGdI6A5aC2Z2hK3tuRe1TGVbSuYabio+OXkIxy5bY
 kzaSZ8oibOT8AaMImwWygywE8VM3ukMLEJVU/wUd0rMJXeNiK1yl/18wq94f7LSYKScobtcvMPP
 ck/kUEhY1hWi8KIVv7DcAYlkhds049OWgPD6hSTmiOaheYJf8X7D5322Jxp2rBvm4Fb8RJ27fsL
 /mtaxw==
X-Received: by 2002:a17:906:18b1:b0:aa4:ce43:65f with SMTP id
 a640c23a62f3a-aa5f7f00614mr74320966b.41.1733206301605; 
 Mon, 02 Dec 2024 22:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZkQj6+wKz0QKpBdf436wu5PdK98SwBmnX3J16plg5s7v+GtH0IIGJz5WIM8HJdqNEU2ZttQ==
X-Received: by 2002:a17:906:18b1:b0:aa4:ce43:65f with SMTP id
 a640c23a62f3a-aa5f7f00614mr74319366b.41.1733206301279; 
 Mon, 02 Dec 2024 22:11:41 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59994064fsm573261366b.174.2024.12.02.22.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 22:11:40 -0800 (PST)
Message-ID: <ce9fcfd6-b196-4dd3-b42f-e5f3c5beb37d@redhat.com>
Date: Tue, 3 Dec 2024 07:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? 0/2] tests/functional: Fix tests failing when TCG
 is not available on macOS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241202204020.55665-1-philmd@linaro.org>
 <9c4408cd-5fee-4242-ba6b-ebf2bb680d83@redhat.com>
 <50f8076d-aa90-4b47-884c-ac3937ceec89@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <50f8076d-aa90-4b47-884c-ac3937ceec89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/12/2024 22.01, Philippe Mathieu-Daudé wrote:
> On 2/12/24 21:56, Thomas Huth wrote:
>> On 02/12/2024 21.40, Philippe Mathieu-Daudé wrote:
>>> Explicit the QTest accelerator to have these 2 tests
>>> pass on macOS when only HVF is built in.
>>
>> Could we maybe rather add something like this at the top of tests/ 
>> functional/meson.build :
>>
>> if 'CONFIG_TCG' not in config_all and 'CONFIG_KVM' not in config_all
>>    subdir_done()
>> endif
> 
> I'd rather not:
> - these tests don't need anything of TCG/KVM/HVF
> - we can run functional tests using QTest [*]

Ok, but then please switch to "-accel qtest" instead of "-machine 
...,accel=qtest" since the latter is legacy and might go away sometime in 
the future.

  Thanks,
   Thomas


