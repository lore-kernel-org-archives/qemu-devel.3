Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F95C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Kpt-00087R-BC; Fri, 26 Apr 2024 08:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0Kpr-00086B-12
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:37:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0Kpp-00089K-5R
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:37:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4f341330fso19385665ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714135067; x=1714739867;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84KvDHn/TfmhiUjTSsZnlfjC1UfE24BmSKedho87RP0=;
 b=zrBJ29a+C6CtU2Iu5/wnvq4rzzOlJtVQ9MqVJ48JfyeOP15EvNDy4vo5egcAdOS7o6
 KLR7zr46RFYHqUInfjLUdyXoTfyYOfbJu+L2P5BNc+iTlHkUrNKKkCazrfXN+y+qL7Gm
 T2wO5CIOkIa0dg9hNQ5w/BQ9rz6wIKUe3zIMtY4c1L792rT94ldAP8sXVszM2v3e0jNN
 E5iap3RJCFKqCDobIC1J0tbjslM7V/PmaPeqGDhUV5nZJogUmu7fC7dwNOjC3++7C78e
 TulfKETWNK2752kDnOsOWUjxuy3YOh7Q8zDfnFRhhx97fqJ/1DieBScBDOmABM/b0fK+
 a0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714135067; x=1714739867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84KvDHn/TfmhiUjTSsZnlfjC1UfE24BmSKedho87RP0=;
 b=I960+JCDW+KA/HaIwZl6Mk5YeWSk1olIAEeoaCnhIebOY8EXQCbsDocOSW2IVfqExS
 faGBp4AKzo5bg+myji/uTTn1sHAnyAOIMcyCP2zIsqjLju0EccZNAlseu+jQ7PflNQBR
 bsr+LReXS/pNc/JW4nl/Tf8D12VU88dyJAOg8+9ShGdhyji3TG283K+0Dw8Vay5AZ2y0
 iyHxCDUKaYsCWzZ0aqDXd3zUj/MF33KYJKvZ2FGRLZ65dEas/TcIvASWrRJr620beXfK
 2E7qll04ZakRhdLi6W0xID6eFgsrSyuTDi49NVA7cvfsGhBzfpcaU22i9DvhvktHYRto
 Zw/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZA56NiX/NYHCPPA8nF0yFRH1wHDSfLLm3We0mYemZ0gBRQCUOhtMrSjNRqAQyFDOJ/6Z6iyIH/lcwMXo48t9xw3ozbio=
X-Gm-Message-State: AOJu0YwMjIkP9UoKRxq30uM4T28a0JP0Pnb2fQ77H9k8Omz+vozkIv+i
 elqe3hVjU7MBfE8ssbPaoAS5h3GcosdeHbOGm1tFea6/18kCmTxF7+5ajQT8o98=
X-Google-Smtp-Source: AGHT+IEyT5+5NC0mcxV26KEz5S9fudbXBjcluopxMfaMvGQxS0Dqj/XJD2ZWeXZVN6sWHZa68+NcyA==
X-Received: by 2002:a17:903:11c3:b0:1e5:5bd7:87a4 with SMTP id
 q3-20020a17090311c300b001e55bd787a4mr2751334plh.16.1714135067327; 
 Fri, 26 Apr 2024 05:37:47 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a17090320cc00b001eab1258197sm3094392plb.144.2024.04.26.05.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 05:37:47 -0700 (PDT)
Message-ID: <81397221-8144-47cd-bce9-b3ab7d94c626@daynix.com>
Date: Fri, 26 Apr 2024 21:37:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
Content-Language: en-US
To: Thomas Huth <th.huth@posteo.de>, Prasad Pandit <pj.pandit@yahoo.in>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
 <ac66952e-4281-4250-96f4-dc3d5b518d24@linaro.org>
 <1497808863.2030924.1713955286878@mail.yahoo.com>
 <088ec61c-39ab-4b58-a02f-8897a3e7ae68@posteo.de>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <088ec61c-39ab-4b58-a02f-8897a3e7ae68@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/04/24 21:32, Thomas Huth wrote:
> On 24/04/2024 12.41, Prasad Pandit wrote:
>> On Wednesday, 24 April, 2024 at 03:36:01 pm IST, Philippe 
>> Mathieu-Daudé wrote:
>>> On 1/6/23 05:18, Akihiko Odaki wrote:
>>>> Recently MemReentrancyGuard was added to DeviceState to record that the
>>>> device is engaging in I/O. The network device backend needs to 
>>>> update it
>>>> when delivering a packet to a device.
>>>> In preparation for such a change, add MemReentrancyGuard * as a
>>>> parameter of qemu_new_nic().
>>>
>>> An user on IRC asked if this patch is related/fixing CVE-2021-20255,
>>> any clue?
>>
>> * CVE-2021-20255 bug: infinite recursion is pointing at a different 
>> fix patch.
>>    -> https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2021-20255
>>
>> * And the this patch below has different issue tagged
>>    
>> -> https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg08312.html
>>    Fixes: CVE-2023-3019
>>
>>
>> * They look different, former is an infinite recursion issue and the 
>> latter is a use-after-free one.
> 
> I assume the eepro reentrancy issue has been fixed with:
> 
>   https://gitlab.com/qemu-project/qemu/-/issues/556
>   i.e.:
>   https://gitlab.com/qemu-project/qemu/-/commit/c40ca2301c7603524eaddb5308a3

I agree. Commit c40ca2301c7603524eaddb5308a3 should be what fixed 
CVE-2021-20255, not this patch.

Regards,
Akihiko Odaki

