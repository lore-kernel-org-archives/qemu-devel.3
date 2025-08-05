Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9F8C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIGg-0001MZ-Uw; Tue, 05 Aug 2025 10:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ujIBt-00052U-Mn
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ujIBs-0000Z0-8k
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754402335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GKyjAF1T0/GAqwDn8LgjZkRRlTpwxzT/SzAVolKSSM4=;
 b=Kfo+cu5OAoO/kfIXESNEi0tvnQAz4EXRxPxMj+ywP+GOmmBeo1gskekd0scFNYHC9ukQ3s
 Fb4J85jmu3Aymik5fRN4LFVk4qAgiFCUoykv/AIyu4sqLsX39Ig/W8ypnzl7pW5DXKZE42
 umiAYC0qx6wAhF/4zO6hxFQLc/mVWqM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-uJ_bXDOJO1yKZl-eiyNcGQ-1; Tue, 05 Aug 2025 09:58:54 -0400
X-MC-Unique: uJ_bXDOJO1yKZl-eiyNcGQ-1
X-Mimecast-MFC-AGG-ID: uJ_bXDOJO1yKZl-eiyNcGQ_1754402333
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e6a5428a76so603590285a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 06:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754402333; x=1755007133;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKyjAF1T0/GAqwDn8LgjZkRRlTpwxzT/SzAVolKSSM4=;
 b=fioEZr3Cdqob3Wyfv+t8npAHU9+kavkXG/eteIcABYh0wm0z4/87hW8WSNDeWIboYR
 kCw1esBtHITmAgpT8z92tGn3UJ6ko2m8K6uKcdV4BOT0L2FrKuMkFSVqtRYEMxw8q2mg
 9C0b5IPv4GgVpSQWdgQGSFL0UPAulCwheLBtM4CyfEHHJY2fhG5WEcQ30BEeAdm/vE+I
 EymxZt7W/QQXxOpn6BlBA7xG3xbenvewgMJcxvicKv3a16pHOqE514YFx4FUdNxuXvCZ
 utts24Y0IrC0E7QcXIuo1aiuJCBcE7ncSNsLOGbcSszSds8EVNH0to+hU4n+fhOtCSjy
 tIDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjgjQurL73Zu7yoilOb6dUsOznbpAcW5Rhnxec4JWhnajB3XreVHhr4+GTWKV89QmpswZXLluj9xq+@nongnu.org
X-Gm-Message-State: AOJu0Yzr4sfMR5nRTlFMdKPxjFy7KbBQdfXYAa7sFDKkILAusCK8TRnF
 eWQsAIFkeivm1OcmchobcZiUzuvBTseqKZJkGIFzDFiuYS2IkrPoAZfaE2QkV7TqOO6x1mYqO6e
 4VEY7WNa28BQ7DxczhZPBx4U9qriByTUoW/ZtCCsEP8Fc3IceY6VDi+x8
X-Gm-Gg: ASbGncugG7LKdZBlZpuXt/BnRDGiVxFu9G2a7yvGSxy8O/ZZjwOdTXRk3CU5O3DKIz1
 sLZ7Wt416Vra3X5SYqpYk4qSblJp1bSJzM/DYlBHbsz9OvVgOC6g2Wqf8ugQj2mWDqwiT14I6Z9
 NW5eQ/ctx6JZJXPUCWH+Cbj53XbwFXEFCy9kMVXFCRmzIl8HoCI0m++FQNVa42/a9yrCaho1JQr
 Womzp+wMHSs9gDx55qwq+g6q/uyrHOjMJKQODOOmh9esRx/0wSRLtM6SYYhH8m/AZcGKjg7TYcs
 96jVdayiAX92RAEMQxcO5XdWhC70FCIAdwlpwpC3NVGkO8chikDd2+kSMFDFX2KH
X-Received: by 2002:a05:620a:28d6:b0:7d5:e374:e2bb with SMTP id
 af79cd13be357-7e80acd2b1bmr568955885a.27.1754402332783; 
 Tue, 05 Aug 2025 06:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PzJ8GV8MzIreCj9FHP7l9ORpZh2/2yYEO5S68aTU9f23jnYFGHac/9+w+vd/0JH207gwWg==
X-Received: by 2002:a05:620a:28d6:b0:7d5:e374:e2bb with SMTP id
 af79cd13be357-7e80acd2b1bmr568951685a.27.1754402332268; 
 Tue, 05 Aug 2025 06:58:52 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f72a5e2sm671050985a.66.2025.08.05.06.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 06:58:51 -0700 (PDT)
Message-ID: <4c25ddac-c83e-4b93-9aca-d2aa0e86cb24@redhat.com>
Date: Tue, 5 Aug 2025 15:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] tests/functional: Move arm tests into architecture
 specific folder
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-8-thuth@redhat.com>
 <2065ee05-8313-469e-bc66-075038ea2904@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2065ee05-8313-469e-bc66-075038ea2904@kaod.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04/08/2025 14.28, Cédric Le Goater wrote:
> Hello Thomas,
> 
>> @@ -1187,7 +1187,7 @@ L: qemu-arm@nongnu.org
>>   S: Maintained
>>   F: hw/arm/msf2-som.c
>>   F: docs/system/arm/emcraft-sf2.rst
>> -F: tests/functional/test_arm_emcraft_sf2.py
>> +F: tests/functional/arm/test_emcraft_sf2.py
>>   ASPEED BMCs
>>   M: Cédric Le Goater <clg@kaod.org>
> 
> Currently the functional tests are matched with :
> 
>    F: tests/*/*aspeed*
> 
> This needs a fix and I think we should be a little more explicit.
> How about :
> 
>    F: tests/functional/*/*aspeed*
>    F: tests/qtest/*ast2700*
>    F: tests/qtest/*aspeed*
> 
> ?

Yes, sounds good, I'll change it in v2.

  Thomas


