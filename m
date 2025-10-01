Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8FBCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3puU-0008Qu-VE; Wed, 01 Oct 2025 02:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3puS-0008Ql-85
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3puM-00045U-9S
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759298499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4j9m1zWPg0NJnvmr6Vai0gt2CyAu661WGMaQ1o5FHSw=;
 b=OQXoarjjmNTdzxfRh0/cbozQ0sHsVR7q8HpsYJCqTMy3s48v8Dsw2aeWvUsatVeUrGjVV5
 L0edsj2orAR/L8O0NeSQ7LVgN6GYLkA8cJ/txpI3WRFenAUJSSTSn42MEmA6g80+vpce+a
 /CPy5mySyHuf10Vlo2NCKsjdAQcVLwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Rnmu19I4PEyJtVaoQv3ASg-1; Wed, 01 Oct 2025 02:01:38 -0400
X-MC-Unique: Rnmu19I4PEyJtVaoQv3ASg-1
X-Mimecast-MFC-AGG-ID: Rnmu19I4PEyJtVaoQv3ASg_1759298497
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so37523035e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 23:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759298497; x=1759903297;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4j9m1zWPg0NJnvmr6Vai0gt2CyAu661WGMaQ1o5FHSw=;
 b=ivx22W2BK6NbeYSbBDVUvhuQCr6kIejA7HljzVs+k4JyiArV6NztlIMpKY9PYXNQPa
 Ny6RP9a7KA9wzB8cvqKlz/i2VKoKTJUH5S92iei9WL2/uBmNTamBBxYNJSuOZlsZdAgf
 CmhIlEFbt8Rv8xB3GuUSGRt+SltvGgnlvSRN3a2wKGgfyYhxktolURD+cvWYA1RscDX5
 c8bfaPVYaiPXt37pZZW1YITr4Rg5QbTCgD6HmMjV9Da66iPaJ8ZVTB0QxxFF7DvCnZNJ
 PT1OkqDtumIlSiG0TaoP6arUgwMjujC+h5fnihRiUKA9FnOFJ5feT7gWcQO/G8HDYlqx
 UAfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7T1Hsq8Zi0rfg1vkLnwktjMcImN0i8q2NLUJcXTZxn2S3lrSUNmn0J8RBHZwA2y1j8IiXTNEz4+YH@nongnu.org
X-Gm-Message-State: AOJu0YwwaDKcimq+zMW8jD/ey0ojywxDMXJ1KsRF3JC4mKD9SL2aHKEB
 YGT0dzv+YcGTLZHgfK1vXWTrXAnukZYqhcFb0u/G9KBQuy2D3Ww8qEs+dcuL7lBG98N9OAFvaXI
 2X3SBMrOzgqhBRq2QWHO7zDER/HRNpn2Srd1fxgpgWsWNBqqVcRv67u6T
X-Gm-Gg: ASbGncvhaJS72RP5eRqHJ0Q436DbuhlJB5YofpUW7i24m41hB6Lx9g/PBM7ZnIQ8Uy1
 wBZxva6/HjqspzmdjdWtdp9U/5VjASiOwXDRh371TP96Q5Zv9p5Rj4liRp0ovKIPWl3wmjs6m/l
 nks0DVtChJsVIXMzelAhn/mnV9lpIsIVg+UeezdOW12Nvq7mFOgvUik7vyGN3tKf2uobhEluwSD
 hJDdbtSnkjGGwZBKtrIUwp5NWt+CesXrwDM2v3kwi+dmbRWUnUhFPAokFfbRLfuZdwxAqRLsfGU
 lV0y8WO3ZxEiss3Dzx3js3qYvVxmfefk+GQh38j6elEh3A4x5W4LHhbZhBA6ftnb6LG9trqb1Fm
 0hSEM611u
X-Received: by 2002:a05:600c:34c9:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e6126a54dmr20386515e9.24.1759298496513; 
 Tue, 30 Sep 2025 23:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgF2AX5NpS3L2LiCWjgGb9n1XL6wlyJAKUrvwxEfsWjLG0aLHnty2dnc1jgFiPJpejkkF2Cg==
X-Received: by 2002:a05:600c:34c9:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e6126a54dmr20386135e9.24.1759298496063; 
 Tue, 30 Sep 2025 23:01:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b633afdsm28326895e9.2.2025.09.30.23.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 23:01:35 -0700 (PDT)
Message-ID: <95deaf2d-7b41-4820-a35a-e67a0c980530@redhat.com>
Date: Wed, 1 Oct 2025 08:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v5 00/14] Support PCIe RC to AST2600 and AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
References: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
 <12fb1c21-d53d-4418-8782-791ea97dd54d@redhat.com>
 <SI2PR06MB50411B9E75AA4EEEF40A31CFFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SI2PR06MB50411B9E75AA4EEEF40A31CFFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/1/25 04:20, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [SPAM] [PATCH v5 00/14] Support PCIe RC to AST2600 and
>> AST2700
>>
>> On 9/19/25 11:29, Jamin Lin wrote:
>>> v1:
>>>    1. Add PCIe PHY, CFG, and MMIO window support for AST2600.
>>>       Note: Only supports RC_H.
>>>    2. Add PCIe PHY, CFG, and MMIO window support for AST2700.
>>>       Note: Supports 3 RCs.
>>>
>>> v2:
>>>     1. Introduce a new root port device.
>>>     2. For AST2600 RC_H, add the root device at 80:00.0 and a root port at
>> 80.08.0
>>>        to match the real hardware topology, allowing users to attach PCIe
>> devices
>>>        at the root port.
>>>     3. For AST2700, add a root port at 00.00.0 for each PCIe root complex to
>> match
>>>        the real hardware topology, allowing users to attach PCIe devices at
>> the
>>>        root port.
>>>
>>> v3:
>>>     1. Fix review issues.
>>>     2. update functional test for the e1000e network card.
>>>     3. update license header
>>>     4. Adding "Based on previous work from Cedric Le Goater, with Jamin's
>> summary
>>>        implementation.
>>>
>>> v4:
>>>     1. Initialize pointers to NULL when declaring them.
>>>     2. Use distinct variable names to resolve memory leak issues.
>>>     3. Update functional tests to verify assigned IP addresses from
>>>        Intel NIC Ethernet interfaces.
>>>     4. Introduce pcie_mmio_alias in AspeedSoCState instead of dynamically
>>>        allocating memory.
>>>
>>> v5:
>>>     1. fix memory leak issue. Replace g_autofree with array.
>>>
>> Applied to aspeed-next.
>>
> 
> I saw that this patch series has been merged into master, but it looks like this particular patch was missed:
> https://patchwork.kernel.org/project/qemu-devel/patch/20250919093017.338309-15-jamin_lin@aspeedtech.com/
> [v5,14/14] tests/functional/aarch64/aspeed_ast2700: Add PCIe and network tests
> 
> Could you please help check on this?

my fault. I'll include it in the next PR. Sorry about that.

C.




