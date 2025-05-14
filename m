Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D5C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDOr-0004zv-Ru; Wed, 14 May 2025 10:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFDOp-0004vl-VQ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFDOo-000135-8B
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747234076;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2BsONOjDivtTgtkFsn0yv2PnUrWsXcvAaV+8U9+UuA=;
 b=KGBXjTy31yU31oYdSZKll1JahUtZ3PSKZAmIM5TRodPJUVcZPOvbcctta0Jvzxt+AuCNmw
 LThlMSSwnWlGFDLL2SA534T/JvS4mD1RGYaD55pZShNuRys7DV0I6QIl8lVki2c85elpAZ
 4S7eu/6b8Oqmoe0HbPey7vPvnGslTBg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-E_kpMnSxPJ-gzbbGdaCqjQ-1; Wed, 14 May 2025 10:47:54 -0400
X-MC-Unique: E_kpMnSxPJ-gzbbGdaCqjQ-1
X-Mimecast-MFC-AGG-ID: E_kpMnSxPJ-gzbbGdaCqjQ_1747234074
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a1fa8742a8so2069248f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 07:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747234074; x=1747838874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2BsONOjDivtTgtkFsn0yv2PnUrWsXcvAaV+8U9+UuA=;
 b=lbNKmOe1qKtD4kFVB4lmatyHyVHym5VWW1y7UvglNVOFL6ZOElKsHQNUKONNJOSAfc
 K8EDVgWTi5Lw/1ogENZ45y0Y1N5JnOb5YTHMnw+MONPNXDxcLdChk/zb016u0+XP8eTB
 CNWbzP+4XKbbs0OlUISbbDxJi8dgTKR5FSjjRywm5kExHg3GsatD/DHI6u93DwSS/nGh
 ic+fO2FI2KWDOIwcCPTkRUtq98xKSHALmMXVj8FuE/0PryFaZAIFgMOyhaF1C/o5k7Os
 7dZPZKVpI1sIt1uYsBWS6G6hgWnRp4wY7h8F5tQwhnDGFM4km7O45t8cqLCtDSc3vzgT
 FptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvjVJWio9ouMVH6CC9/mpBi+p+GnBLuaBdKZ8BmB2VLzPZ1F1eHotowS4ipKVoLBlrfIy67YRIpZ5B@nongnu.org
X-Gm-Message-State: AOJu0YxHItyfyczvzpiEH2Wde523fnhZvM0G3SqSHMkwDMrAPsSpUK7d
 zLbquESGvrXpZ/YbkwOE426CtLJ0p8v1B6l/VLyIQkfLHBitZjx8FEH3QqZzkhs8/4XMGbhLILM
 jgy5dolfL0ox8heVlSe1hRyL1Tx+K52/0nU8D0Jf4dnX6eEk89fLi
X-Gm-Gg: ASbGncvQ+lR53gMI3lBMnqQnFFSozBXi2JXsL5mYj420VCrs+JmNU0yFNsfjoIt2ia1
 QlKAxIiT/aAqW1QhErTVKKDJk1zKv36ozsf0colqBsRR25AlCnVn0i2pOrRkj5tQRLmjvrs9RAa
 JRcLHTu7C6PPAjrBYcZAU8QR5hlOtqzeOBuW0TbKvdzsmXxnqtVRu3vARPXzRx8mrm01V1RIg07
 4G75e5q14Vc/3kJYZnuJ1jhXzYeC8dKBNxvx7QZK74v79M/WawdbUNN46AqWt0pkXrZ1wpj3vDO
 PuQI60EV7/zoi0KWFfFlhssj0bNPQjuy9wWO687S9OtOABw+NYgMHunVbS0=
X-Received: by 2002:a05:6000:2207:b0:3a1:fed3:7108 with SMTP id
 ffacd0b85a97d-3a349927544mr3236552f8f.40.1747234073718; 
 Wed, 14 May 2025 07:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSU/glQYPaDOKhV61rdaTt6qL+5rdXjEA8/73Ln5jAN35z/SkLF6fJczukQ8V9uFKDnlfNXA==
X-Received: by 2002:a05:6000:2207:b0:3a1:fed3:7108 with SMTP id
 ffacd0b85a97d-3a349927544mr3236510f8f.40.1747234073308; 
 Wed, 14 May 2025 07:47:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2af7sm20184529f8f.52.2025.05.14.07.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 07:47:52 -0700 (PDT)
Message-ID: <c8f14e69-21b2-403b-99a5-b34f4c9dc2c5@redhat.com>
Date: Wed, 14 May 2025 16:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
Cc: "agraf@csgraf.de" <agraf@csgraf.de>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <dadc4acd-97c8-4647-9467-89cd1966a6f2@redhat.com>
 <4fcfb4624f90491ebb238de76f04e4e5@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <4fcfb4624f90491ebb238de76f04e4e5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/14/25 3:47 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Tuesday, May 13, 2025 4:30 PM
>> To: Cornelia Huck <cohuck@redhat.com>; eric.auger.pro@gmail.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> alex.bennee@linaro.org; maz@kernel.org; oliver.upton@linux.dev;
>> sebott@redhat.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; armbru@redhat.com;
>> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
>> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
>> philmd@linaro.org; pbonzini@redhat.com
>> Subject: Re: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64
>> KVM host model
> [...]
>
>>> We still have to deal with MIDR/REVIDR/AIDR differences by exploiting
>>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?i
>> d=d300b0168ea8fd5022a1413bd37ab63f4e5a7d4d
>>> (in a different series.)
>> Shameer, do you plan to contribute the qemu integration of this feature
>> you developped on kernel side; or do you allow us to integrate it in
>> this series?
> Yes, it's on my ToDo list. I'll first go through this series and then work on
> adding the above support on top of it.

OK. Thank you for your reply!

Cheers

Eric
>
> Thanks,
> Shameer
>


