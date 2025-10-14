Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3B3CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 18:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8jcB-0000tb-R0; Tue, 14 Oct 2025 14:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8jc9-0000t2-AG
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 14:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8jc6-00080p-FZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760465947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BhpgFY4LwiuKePr+EVvOD9fACdNwCXyrctCHfHZ+FIU=;
 b=L1bxhrVcgmgTPX2Umi/XOLwxagEdLBTPU1ZNpb7ASt6tuJNHz9HGXSSxpGSSBVJWWBQJ7O
 mpGDwrVtxMRecVgmCKbzj52PyDPYPeiJpi00zt7y4n38nMQ6xBlnZff/DWK4M40NdGTVxg
 f0UYgP/GgDc7dhzJQmUY/EMKRYsImEE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-6LYNFticNAm3ZgYsBxzTpA-1; Tue, 14 Oct 2025 14:19:06 -0400
X-MC-Unique: 6LYNFticNAm3ZgYsBxzTpA-1
X-Mimecast-MFC-AGG-ID: 6LYNFticNAm3ZgYsBxzTpA_1760465945
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso7035495e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 11:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760465945; x=1761070745;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BhpgFY4LwiuKePr+EVvOD9fACdNwCXyrctCHfHZ+FIU=;
 b=L6nBL5r5MrfsElO1g1H6DVNyvNCCZ6lTf6mYBBawE9SSgV1Pqm8xCtNUDADiOC3+TC
 rbsoaA7sBP82TFAE9V6ppuRwuvz+PwQRjxNj8zOc68LF+kovCXunOTEdqylOZ1ED2/ei
 xzqPrG3uK6zGWxFmkaByDpeyG0ySjr5OM/iqCAUNEM+AK/RgLBsOQW7OjcFGbIkbWKGA
 mgefgs3cCd5ntrcIGMVZKV30IxvJ3tqSHIsFR3wnqRNUYqq21hK+nY4YkFG9aD9dDJwl
 l7QVsXIHaGMJaZb9LQR1sHYA27PN+s9CTwkXzLi6IwhnBtz+hshwIbDVhaWnlfvDHtgx
 h2eA==
X-Gm-Message-State: AOJu0Yzvs+HIo666iFl6HFhCg4IsbruuCOp1kJOeHN43sltxMo2JEQG/
 JxXT5Y/l5RxmXeuElCEiitXJw7G/MZ4qgu5p66h8dfjhTCAFip1BJLnOJ/+dhaHyPrBtjgAm7Up
 7So9nYSeJC32GuQB4kdCIMGGsjdYmATh7gaomP2Tnyzk5h8lKkz6rdxJe
X-Gm-Gg: ASbGnctcUxqBAZYqsJxJfb0e/9WjjWe8r72mieGTZMLDBEf7klUk+Nq1S49wFXJJJsG
 gom4tUa1Ja5BgYhz9/JUl/TTB/5nLqhgJARH3udrKxxVcDEiTmv7cMImE4d5V4D0N6a6BwnTCQ6
 Tp46VRQkcC74TZkKHj+JQlOncAg4g41ZUCJnvkJyHn5CuJ9PWt5YW81ys/AUm3j5pe7+5eC3kp/
 SN3GnAZ40hzLUvAiF8+JHFS4YzOrg3LyrlgilpTk/Y8d21jDvnQcgSl/yuklEZuPjIJCVCq5Ois
 jpL6OHE9o1aNB8lhi2eAnGCz5XqrUI8H9tHOt6AQG05+8zV4h49fT9aJ7G8CQepLMLUhqut7RSU
 c32Owww==
X-Received: by 2002:a05:600c:870e:b0:46e:35eb:43a with SMTP id
 5b1f17b1804b1-46fa9a9f16emr192093125e9.15.1760465944731; 
 Tue, 14 Oct 2025 11:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWr+ozzSJ+gbFVhc4vxItT+LcXkPpNu/pb0JOGKck4KVSZMtlMM0wMSDA/lKfWmOejWV3OCg==
X-Received: by 2002:a05:600c:870e:b0:46e:35eb:43a with SMTP id
 5b1f17b1804b1-46fa9a9f16emr192092915e9.15.1760465944276; 
 Tue, 14 Oct 2025 11:19:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36ed3bsm169164735e9.0.2025.10.14.11.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 11:19:03 -0700 (PDT)
Message-ID: <c32612d4-3def-47b3-b32c-fbd1ec527012@redhat.com>
Date: Tue, 14 Oct 2025 20:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] testing/next - arm custom runner tweaks
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org,
 Liviu Ionescu <ilg@livius.net>
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
 <c5003498-7914-4d94-bb79-0851c49c47a1@redhat.com>
 <874is1l7db.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <874is1l7db.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 14/10/2025 19.29, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 14/10/2025 12.43, Alex Bennée wrote:
>>> This isn't quite ready yet as there is an in-flight MR for libvirt-ci
>>> and the final patch has to manually drop a couple of packages which
>>> don't cleanly install. I don't know if we should deal with that
>>> upstream or in the lcitool metadata. For reference the two packages
>>> are:
>>>     libcurl4-gnutls-dev:armhf
>>>     libglusterfs-dev:armhf
>>
>> FYI, glusterfs is deprecated in QEMU since a while:
>>
>>   https://gitlab.com/qemu-project/qemu/-/commit/b873463821343c6f702c4195f2168790b09cf44e
>>
>> ... so you could also add a patch that removes it from QEMU now, I
>> guess.
> 
> I can do that.
> 
> 
> Richard and Phillipe reminded me that we are due to drop 32 bit hosts
> real soon now so maybe I should just remove the runner and the hacks
> needed to get it working?

Let see ... the last time I tried to deprecate 32-bit arm, I've been told 
that the Raspberry Pis still use a 32-bit OS by default:

  https://lore.kernel.org/qemu-devel/F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/

... and the right time to drop 32-bit arm is when most Pi users install a 
64-bit OS by default:

  https://lore.kernel.org/qemu-devel/379B4C23-61C2-4AA3-A851-EEFC98A9AFF6@livius.net/

So looking at https://www.raspberrypi.com/software/operating-systems/ now, 
it seems like the 64-bit version is the default nowadays (at least it is the 
first option there, and no more recommendation for the 32-bit version), so 
yes, it's likely about time to get rid of the 32-bit arm hosts now!

  Thomas


