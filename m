Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D094E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 07:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKv2t-0007Zq-43; Tue, 10 Dec 2024 02:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKv2q-0007Ze-Rz
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 02:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKv2o-0006F1-NZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 02:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733817151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JKlXGrKeTFunvC5peaFF/0ruPSZrKGL0CWqoOxd+z3Q=;
 b=OD+TXvHknIz7ta/cx77V6DozTrbOiaS9LlKRueO98d/QbxwFNxwb+Hi3J+/hwbwP8aBhCM
 BfevlmLDOB2LFRItLWRj+Jnob42l/neKCaXZwAXoCQlN9NupZEfbTq48JbBXfDyoQ3r4Q9
 k1qQ6DeSNxq9mhNUiwEuOXlE0TIsaTU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-DJnLgDZmNi-gDmvh4R9zYw-1; Tue, 10 Dec 2024 02:52:26 -0500
X-MC-Unique: DJnLgDZmNi-gDmvh4R9zYw-1
X-Mimecast-MFC-AGG-ID: DJnLgDZmNi-gDmvh4R9zYw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa68fd5393cso191892566b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 23:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733817145; x=1734421945;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKlXGrKeTFunvC5peaFF/0ruPSZrKGL0CWqoOxd+z3Q=;
 b=H/XpdSJm7Wg5xRHMaj1CkrP5+4ftcKxAuqolZvOSLL0mIN/aXTJ7uvCYFN0OJZyire
 +ZJEHHF5qCh37IuQZu2SH9p08YDFxSL/uCy5uKWhI9ktZ021l2/3Gtfz/JDl4zcjESmW
 NxrZELiaZIQkKefC0lyKlQTmXQHfgUrikhtHEafCRNapKvUeoi+15Dr79wm4uTB+Ht5A
 rP/bkfTL3P+OIikTZgkTGW0GefPZCvqnLfyXF3BmgQQzUSwvqvi1KzrBr+G5PM8QtuI6
 LBcvbb7BYESAXkzIK8GtUs3LnePBhPq3ZQ5ySjLGZQF6nG0i6ZEWrkI+wRrAy/4t0QdY
 vQRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Ob/Hi3VLKRRxcFWYuN8gzDfDEz/LNFqPpfUIIYfmDDO+VluPxPKL4mIDqNpdM56oExLyZ4xCKFFI@nongnu.org
X-Gm-Message-State: AOJu0Yyx+gECnbbyWjWGkkFJBCW7t43UwEL2HmtmYJHlxj+JPdA0eQjM
 /1kAYWBERtf2UKBok/27B1HUVq+BpnWg5up384gr64WrQMTYvQa2y45E4jnf3WY6BP77LnQ04El
 JLDvp7Sx3XhK80cVYwAjkCh9THOIRwv7eVgaTXWDrnZc3NIm7dBOZ
X-Gm-Gg: ASbGnct4fa05H1ByA766SjxxxLgloYJHooVVyVJhXBzJZ647713wWLe138ZTuqDbi8f
 CZ8PLXAc3zMdDRRNxHNbAM8t3oNRUVs2LPzxe5nXdq6avizpedAtc6UFO4vrLF0RB6I0xaMb20n
 WIck75/UBAcTSqIMeSZSQ/9K41id8BAquOoPsSxUnanMVV1ZeQWDwC746a6wLPgtLHrjh7tZiZf
 CMUgyDLdCkv+wRA4ILX0SRPJdtomRL3d9ienlfcSUfrZjyCYTPajsXWyCA54Nvt1CvOMBuk4avM
 iTdQXvg=
X-Received: by 2002:a17:907:9705:b0:aa5:3fe7:4475 with SMTP id
 a640c23a62f3a-aa6a007319amr230221966b.11.1733817144921; 
 Mon, 09 Dec 2024 23:52:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrYh7q6lADu4HrMV2O6q1CH164wg1/SJQZ544CfesXtwEFXCCNtu8F/eJjkKHhgwZME3BMNg==
X-Received: by 2002:a17:907:9705:b0:aa5:3fe7:4475 with SMTP id
 a640c23a62f3a-aa6a007319amr230220266b.11.1733817144636; 
 Mon, 09 Dec 2024 23:52:24 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67f26cff7sm329357466b.57.2024.12.09.23.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 23:52:24 -0800 (PST)
Message-ID: <a88854b4-5004-4734-9fc4-6f34eafba5a9@redhat.com>
Date: Tue, 10 Dec 2024 08:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-3-pierrick.bouvier@linaro.org>
 <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On 09/12/2024 21.33, Philippe Mathieu-Daudé wrote:
> On 28/11/24 21:15, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
...
>> +For this reason, we disallow usage of bitfields in packed structures and 
>> in any
>> +structures which are supposed to exactly match a specific layout in guest
>> +memory. Some existing code may use it, and we carefully ensured the 
>> layout was
>> +the one expected.
>> +
>> +We also suggest avoiding bitfields even in structures where the exact
>> +layout does not matter, unless you can show that they provide a significant
>> +memory usage or usability benefit.
> 
> I don't think we should mention "significant memory usage benefit".

Why not? That's the point of bitfields, isn't it? Or do you mean it's 
included in "usability benefit" already?

  Thomas


