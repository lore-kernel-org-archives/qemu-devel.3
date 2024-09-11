Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C4EE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 17:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soREB-0007tJ-J3; Wed, 11 Sep 2024 13:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1soRE9-0007me-Ri
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1soRE7-0001VG-V0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nob6LzqNR+EH7hgFBFB/TQv0U03b1zvd3bdL6La4bdc=;
 b=iY7sCmFPjCTgt0OLp/f4eJ0HdL/WLgA8hloa6cZ9pi2WyC9EOKhIszgUidhQGnWOE0HZUV
 D0Wbkj6EL/baN3pai6xmobF83hUR6F6E0mwlDhs6eDmjcjPp7J6tT7AWBBxfrlaKyCGdir
 aNMvGuNzu/LtQqRq1t1mucH96notLic=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-giZIKKqsNxytzHW1IcmGlg-1; Wed, 11 Sep 2024 13:33:54 -0400
X-MC-Unique: giZIKKqsNxytzHW1IcmGlg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9b41d95efso17636185a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 10:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076034; x=1726680834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nob6LzqNR+EH7hgFBFB/TQv0U03b1zvd3bdL6La4bdc=;
 b=UnbUpx5XFDgjPQavLmlAtYiVQRzNoeSGeq4zCLMnergXUo1O4lOejfiI36aO2D8COg
 O554jbJpO1nmv7DUIciN+k+mAnLfRhEudzI/DmQ9exK7XG7kFyq6T2tVNbLhfb1OpYMZ
 tBVa6HV1lJKBysk8VUHe7ntzyMk95BT0Q/zHRKta3p3QkNENF4N4E1oHYUHZ0ZJSlY62
 ntkOaI5LsiA07NGJGVns5DWhtfzbdQAZ+ytadI9BBsvreyhiLxYFUPSMU1uQEjP0bgvg
 OgjQPdHQLVqpvYXvmG1PdOJHZKQE1YvGT6f8t6+OcJ5DHpMQv4S8e7c9PL8zV4tT1TPZ
 mIDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHAioDPUDaZT2M/V+KAVZ80qoSXkY60Oxra8TLutOa46f/sXFoB22ZzKDiqlecvfyRHFSAg8H07v23@nongnu.org
X-Gm-Message-State: AOJu0Yy9cQVammDfcPEVl1adiVGQ3LERjecTHxjjXv5goCnBXAci1oIt
 2MKpK/6IqqsZmVRG9RVojJYFVdptsWixp4Hyrc81tlAufXRvUquF9K6Sfwf8hk0Ok0p7nNYp7S3
 cGiIhWNBjx/BIQ2OXL2iGd16XHj2x905zE5jdQLM8jqBAVjeEVD0t
X-Received: by 2002:a05:620a:2905:b0:7a1:c44d:eb32 with SMTP id
 af79cd13be357-7a9e5f7c58amr11628185a.54.1726076034222; 
 Wed, 11 Sep 2024 10:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDf9Hal+g0kexb6IG/T7tA1nMJ0N1dxN8ucvuVFSG1mYVI6LnUXD2EKs8KvAKo5kvzkQgpkA==
X-Received: by 2002:a05:620a:2905:b0:7a1:c44d:eb32 with SMTP id
 af79cd13be357-7a9e5f7c58amr11626085a.54.1726076033886; 
 Wed, 11 Sep 2024 10:33:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7946b0csm446483385a.23.2024.09.11.10.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 10:33:53 -0700 (PDT)
Message-ID: <6beb87db-d963-48fe-88ee-abc4f55dd3d9@redhat.com>
Date: Wed, 11 Sep 2024 19:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
 <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
 <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
 <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
 <014b83a8-d733-442b-ba33-a24c35e46f3f@roeck-us.net>
 <bdb443f9-376e-4d4e-8c06-9ba0c5482c5e@redhat.com>
 <09457da7-e692-4d9f-92b8-361f14b7a1c2@roeck-us.net>
 <CACPK8XfqOE-GJWgUwC+Kh5r9nT2Jo42R2zdka54sURDiR70j5A@mail.gmail.com>
 <b9b2d800-38d6-4fa6-9ac3-9604fb6f9ff2@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b9b2d800-38d6-4fa6-9ac3-9604fb6f9ff2@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/9/24 17:10, Guenter Roeck wrote:
> On 9/9/24 04:20, Joel Stanley wrote:
>> On Sat, 31 Aug 2024 at 05:41, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On Fri, Aug 30, 2024 at 10:09:25AM +0200, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>>
>>>>>>> I solved the problem by adding support for IBM Bonnell (which instantiates
>>>>>>> the TPM chip through its devicetree file, similar to tacoma-bmc) to my local
>>>>>>> copy of qemu.
>>>>>>
>>>>>> Hmm, did you copy the rainier-bmc machine definition ?
>>>>>>
>>>>> For aspeed_machine_bonnell_class_init(), pretty much yes, since I don't know
>>>>> the actual hardware. For I2C initialization I used the devicetree file.
>>>>> You can find the patch in the master-local or v9.1.0-local branches
>>>>> of my qemu clone at https://github.com/groeck/qemu if you are interested.
>>>>
>>>> Oh nice ! Let's merge the IBM Bonnell machine. We can ask IBM to help fixing
>>>> the definitions (strapping). Enabling the PCA9554 is good to have too.
>>
>> Instead of adding Bonnell to qemu, could we use the Rainier machine? I
>> know the kernel device tree removed the i2c tpm, but there's no harm
>> in it being present in the qemu machine.
>>
>> The bonnell device tree should boot fine on the rainier machine for
>> your purposes.
>>
> 
> Yes, I confirmed that works. Ok, I'll do that.

So I will drop the bonnell to avoid redundancy. Is that OK ?


Thanks,

C.



