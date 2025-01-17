Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22C1C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfmi-0005S4-Qy; Fri, 17 Jan 2025 01:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYfmh-0005QK-JQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:24:47 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYfmc-0001Ig-Su
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:24:45 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21675fd60feso39036035ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 22:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737095081; x=1737699881;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+NydsvECT2thfGBtNF9kzUEjWHoNrZafbKX6bzHBJFM=;
 b=nrvLnooxgwv5pWxeMQUguYzMt2zhRw2gIWRje9K/WNej/oSwgXZ0haejgiTnOVcCt0
 KrNcqsx3P0ieS/XP33HoYNYBgJP6kOZF/f2cm28TxL5aMXnki9b+xGaFvGz+XQpicybc
 rd5F9J0b0PaIET8672AhvjwW9pJ9V3+h+gElthtq8dGCNChy3l8GnnBS6+ocYdwMSG9w
 GYeOr7UKp3X3rBpfUsBA1gIssP7DDdIVxF0Fpy33XvYN2XwTtkTARmkIIcr27LmTtKG5
 yfobRh+duq0sC4/dvqUww1kS7TxMbjFKe7/dEAeeqdlElrBiMCsVGxmbkqvWEqVico34
 DPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737095081; x=1737699881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+NydsvECT2thfGBtNF9kzUEjWHoNrZafbKX6bzHBJFM=;
 b=cA7X8wiuxt8TT8iG4Ly4eXdCbgICDXKBw75H4dVQJwQSlh+gvQxCcOeV+kOUiFPwyv
 htkGe8shjSguga4LYPDhqLjYjDxofKU7X+Mr9XRCJYWtYO6SfXlEFnFbDin4CPYcX3bX
 D3Q7212wTmh1caaZYsOqkZJFic9kCdaNQv3oDWcqJP5F++3TcmPBAPz1CPoBVyf4KAzc
 CPP83EXbKScY98rJGVjJpCQFVx8cY5L1zY2PVXqiIMY1NBuPDDdPJ4elX7NvvZQkqUfU
 RuBZmcE8nvY477V6itrQbL3Wpoa4FUe0vJmw+d9qwYmhlsHr2m2BTna3XglTGm4VriPb
 qUZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoqoxxLyGfEQVhJCnOlDIG8RhJ/5H0EBYXustRuaKp2M2a5hmLPWEByMUDurNkkYNw3qUxwePQNPmu@nongnu.org
X-Gm-Message-State: AOJu0YwqHvn+b/dPBz+hJzsIk5ibyw+SGt2G3dbN2Z4KvgBMZvFrLvT0
 JUsX5JUMAyaD+YBgIBTzarHiJANiu6IVzHISenTRUHKtuxZheJIaiR5vF2h7oZg=
X-Gm-Gg: ASbGnctLSu9hpdZ+gTwXI+FX6oZ4HNY1SIHBqylEtrJ4W4Zmo7q1m/yjNBjhVN+0Ncc
 bF5I5Z1s1zoRX9q1v8Ga6OBLt+ao+uxTi+fyHIfC2IltjULyAPnyo2KIi8N3VAvymLypIArys5+
 Rmq8Y3gRf/pab/UtsxodvpKTQ0v9pjybosqvkO9VCRDbKqXHpFUthBmnvecv0QOHH4jdvOzwfOp
 W0b+dFvqEp4puJU/ytJTCrSYgRZ74nrSCruqFcCLFuVDabg2/Tr+1bjvocfTA3Ben0=
X-Google-Smtp-Source: AGHT+IE/jY55dV0cb7ORI1ZGRABXLg5vb9TMxeIx4HhYtkmKb3eETN9xv4XpHks4Yi5iA4NXQUPFDA==
X-Received: by 2002:a17:902:c408:b0:216:7761:cc36 with SMTP id
 d9443c01a7336-21c356209demr20207075ad.43.1737095081011; 
 Thu, 16 Jan 2025 22:24:41 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d402d61sm8949245ad.229.2025.01.16.22.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 22:24:40 -0800 (PST)
Message-ID: <627beb0f-e6f7-4733-997b-038b70195485@daynix.com>
Date: Fri, 17 Jan 2025 15:24:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, devel@daynix.com
References: <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com> <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com> <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com> <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com> <Z4fezdR1ApN8ZLTS@x1n>
 <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com> <Z4kYxLsIbzq7jWzz@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4kYxLsIbzq7jWzz@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/16 23:33, Peter Xu wrote:
> On Thu, Jan 16, 2025 at 02:37:38PM +0900, Akihiko Odaki wrote:
>> On 2025/01/16 1:14, Peter Xu wrote:
>>> On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
>>>> Functionally, the ordering of container/subregion finalization matters if
>>>> some device tries to a container during finalization. In such a case,
>>>                         |
>>>                         ^ something is missing here, feel free to complete this.
>>
>> Oops, I meant: functionally, the ordering of container/subregion
>> finalization matters if some device tries to use a container during
>> finalization.
> 
> This is true, though if we keep the concept of "all the MRs share the same
> lifecycle of the owner" idea, another fix of such is simply moving the
> container access before any detachment of MRs.
> 
>>
>>>
>>>> removing subregions from the container at random timing can result in an
>>>> unexpected behavior. There is little chance to have such a scenario but we
>>>> should stay the safe side if possible.
>>>
>>> It sounds like a future feature, and I'm not sure we'll get there, so I
>>> don't worry that much.  Keeping refcount core idea simple is still very
>>> attractive to me.  I still prefer we have complete MR refcounting iff when
>>> necessary.  It's also possible it'll never happen to QEMU.
>>>
>>
>> It's not just about the future but also about compatibility with the current
>> device implementations. I will not be surprised even if the random ordering
>> of subregion finalization breaks one of dozens of devices we already have.
>> We should pay attention the details as we are touching the core
>> infrastructure.
> 
> Yes, if we can find any such example that we must follow the order of MR
> destruction, I think that could justify your approach will be required but
> not optional.  It's just that per my understanding there should be none,
> and even if there're very few outliers, it can still be trivially fixed as
> mentioned above.

It can be fixed but that means we need auditing the code of devices or 
wait until we get a bug report.

> 
> My gut feeling is when we need serious MR refcounting (I'd expect due to
> the current heavy code base it might be easier to start a new project if
> that's required.. that's why I was thinking maybe it will not happen.. but
> if it will..), we'll do more than your change, and that also means
> memory_region_ref() must start to refcount MRs, because a serious MR
> separate refcounting should mean MR can go on the fly before the owner.

Actually there is one example: virtio_gpu_virgl_map_resource_blob() in 
hw/display/virtio-gpu-virgl.c creates a MR that can be removed before 
the device. To make this possible, it specifies MRs themselves as their 
and let them refcount without help of the device.

