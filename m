Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02655C83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjf55-00079q-Hd; Thu, 29 Aug 2024 09:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sjf54-00078o-DE
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sjf52-0006lC-IK
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724937650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FujBzl9VPO7tRn/0GvYAeVabP6YIXQGJKNEh3IM8hfM=;
 b=en0B0ohJVrRUmF08SDSWXt4HPqrD6Nlk4k/dcYqafbQv3iNRTitm5faUFn+iVnrjm18bgr
 aDdguPiwPjW8bWGU7ROJx8w/GB/wsSpmVuOyfc7Xuu6LhMUN8kZ5xfzTXZksY8BixatTHg
 q7MpohSYCjFfI8Iv4mZtkKIqPRVTzkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-WM1KM67UNOaDd2WepQzMkQ-1; Thu, 29 Aug 2024 09:20:48 -0400
X-MC-Unique: WM1KM67UNOaDd2WepQzMkQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42b8a5b7fd9so6973785e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 06:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724937647; x=1725542447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FujBzl9VPO7tRn/0GvYAeVabP6YIXQGJKNEh3IM8hfM=;
 b=GPIlliWUOuljWMJ8Yseph54e9AkU8sF/9hzTMCl/8PKyMmcLlmNPugROvcCXq9ndJq
 2PLJr7cEtxje2TJ0Yi1B54o1KEL3VJrP1SQxxVa0X3GmDYQm0QYF5UED+iIljE+cHN/0
 PcviO7ZbGiy/qcBYszQGKOKlfSLm5tBGfdYUQZ3Djt+iHf2I1942c2BrO1x7csnR4NHW
 lqzRl6ekf0S39hOFzrlbLerLe3cTAbEfuGkAzMeXkOY6VAV8J9lRBao/xgvgPYPPWliX
 Qz8+6uy7Tjz+0qxXjH6duetLZmlfzjvqfInSE22Yp7me0fdO828OQLUV5LT24rBb7dmC
 J5eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXZDkKLtve0S8TErvHtFfKJChVe45h7CFk1dKDNkP1J5UB8UwdzaCJT+wqmCYEg8Waxa8LdBG52ra@nongnu.org
X-Gm-Message-State: AOJu0YzHxZxnQTQqy9gy3gr2tDNRd9tFLEqxgcs4tAg3HtKHySC209vJ
 s5OjBW8VfwBFqEANwWW2Wifp8u9BoVlOfvtNIIdL0vLLXhQMzCDVhy7fpd1ed2vbRwJPyoVe/XM
 L21yzWKVmNXdFJuurjWBC7BnLekWy7+gj8ujjVHqzHau/Q5NeAFdc
X-Received: by 2002:a05:600c:1c83:b0:428:2502:75b5 with SMTP id
 5b1f17b1804b1-42bb01b9299mr23815425e9.11.1724937647380; 
 Thu, 29 Aug 2024 06:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJBlyoR4vI7genBSEk8dbsJFDy7MLQJGieRVP+kkbFU7TvcfUj5FfLG47nhkKIIxuG4yBBRQ==
X-Received: by 2002:a05:600c:1c83:b0:428:2502:75b5 with SMTP id
 5b1f17b1804b1-42bb01b9299mr23815105e9.11.1724937646801; 
 Thu, 29 Aug 2024 06:20:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee94265sm1416591f8f.47.2024.08.29.06.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 06:20:46 -0700 (PDT)
Message-ID: <bbd8ca55-16b7-4279-8f2a-7d60073d1b1e@redhat.com>
Date: Thu, 29 Aug 2024 15:20:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Peter Maydell <peter.maydell@linaro.org>, Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
 <172493399778.162301.4960007495977124327@t14-nrb.local>
 <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> 
> (My s390 box is running Ubuntu, in case that makes a difference.)
> 
> Maybe you could put the kernel and initrd somewhere I can
> get them from?

I am also trying. See :

   https://www.kaod.org/qemu/s390x/

These were generated on my x86/f40 laptop.

C.


