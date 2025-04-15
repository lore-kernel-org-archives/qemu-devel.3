Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA43C369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 13:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ftW-00024O-26; Tue, 15 Apr 2025 09:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4ftS-00021L-Hs
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4ftK-0002XP-DX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744721991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rsAyM+l3bNdyTmdx4JYU42s3Q3BA1WTBQ9jfm5ELsyw=;
 b=JUoJe0MIA9ptrTwDEmAsD4NpX3ar8wJgvjm036ZssRFipc6iOTkRU6AW1D5XCW5Sc5mYA4
 w7GTYPvvLVMw89llGwfebyqrYwbhwEiGrgUb3DZqkxtOzk9vWqamu05JcJE8d3c3B0pSNR
 51qO2o9geyFgcu+yv86FBeGmMhxDecc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-IwuH-zYNNlq2GBwg1j9iCA-1; Tue, 15 Apr 2025 08:59:50 -0400
X-MC-Unique: IwuH-zYNNlq2GBwg1j9iCA-1
X-Mimecast-MFC-AGG-ID: IwuH-zYNNlq2GBwg1j9iCA_1744721989
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so34373625e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 05:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744721989; x=1745326789;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rsAyM+l3bNdyTmdx4JYU42s3Q3BA1WTBQ9jfm5ELsyw=;
 b=KpSTF4WbfjCP4MiXy/y5mT3u3+uL7d/1sVU6f749oUxmauKSdXMqrIbTYy0ar+1IEG
 nDxo3+zrFVVrhTh6z8TLQ1xnKftf6x/f02XuTeJ2+mqhEqJsGlmh8tFbV72flBPm5/ag
 O/3h5S/ffeSYl3bEv0VVec2LhXtpxyjrHyJxLCJdu62hgtK48t60gTU/idOL7CL36Hou
 KDbu45TaNXkVZaxOf1K8CxafwFZ0tORCC6N5h9dHQ42cak84ZZn6G4cvph0WWK149tqf
 Pk1V2wbYfyOk3hGdQJpBngztCrCI10nSOpGISHvlLh6qsTbICpnbjsJqcxNg5Lm1H0pI
 iBzw==
X-Gm-Message-State: AOJu0YyumwsbX1830kuityPxXSo7oTP0Ef92VQZOoGXbLLbBrIJwzwzQ
 GS0gfLuQWI03Jqfab3Pvv8nZnGZsxKoyKBg6rst14/PbMJWIgklLFwpBJ/vFNM3MA5BEOj03Gsx
 kWNbpjVlRomhtWM8gNgeE6zQYkt4tZdWVOmqu3apdUeo/TpVu4u1W
X-Gm-Gg: ASbGncthYPa5b8ST20t6hO7IOJ1/arkg0g2aa23wEGDWUVt4KMsDo31xeyx9PxnF5AB
 2d7Iq/DdsQExR38ysYhWvLyy0QIXZQNAzHF+1zs6DmyFeRvIDjdJY+gTMbTv9usYEe5eNDKoMTM
 X+2XsWQvM7YJm0yR/HBT9KQRbDCGrZm0TKJGVl3rjzxH9TJvOJKqR9I8gYwGNf7IBdTReI6Cu+P
 BJ0PwHb9vxGGIrqloCXeXsA8EDTfgXlFpUvjl1H3pE+ptw+6+GfiyF8UH6xEsUhPYHi3wtQiSxP
 KsB1ZTDvT5joMvJI
X-Received: by 2002:a05:600c:3baa:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-43f3a9afe0emr162841175e9.27.1744721988836; 
 Tue, 15 Apr 2025 05:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEJDN6JGr0VO0UJ/ql6RCqaIO54c/XuNhupEQTPeEVq7SwoeHyjuKd1SBV+KbYl7kZX+fJTw==
X-Received: by 2002:a05:600c:3baa:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-43f3a9afe0emr162840955e9.27.1744721988403; 
 Tue, 15 Apr 2025 05:59:48 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4404352a536sm13818825e9.1.2025.04.15.05.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 05:59:47 -0700 (PDT)
Message-ID: <fd485969-cb3b-458b-a1c0-b461fab5f22d@redhat.com>
Date: Tue, 15 Apr 2025 14:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
 <ed082405-06a7-4407-9230-3a9b7e91406e@eviden.com>
 <CABgObfb4knJpLiPsQY35dFbT6kpS6p4iKcjHTeUn3_9A_8XSpw@mail.gmail.com>
 <88a62763-cb43-4984-91c1-ead8136c7d2a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <88a62763-cb43-4984-91c1-ead8136c7d2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/15/25 13:55, Philippe Mathieu-Daudé wrote:
> On 15/4/25 13:51, Paolo Bonzini wrote:
>> On Tue, Apr 15, 2025 at 1:51 PM CLEMENT MATHIEU--DRIF
>> <clement.mathieu--drif@eviden.com> wrote:
>>> On 15/04/2025 11:30 am, Paolo Bonzini wrote:
>>>> Caution: External email. Do not open attachments or click links, unless
>>>> this email comes from a known sender and you know the content is safe.
>>>>
>>>>
>>>> On 4/15/25 08:18, CLEMENT MATHIEU--DRIF wrote:
>>>>> Address space creation might end up being called without holding the
>>>>> bql as it is exposed through the IOMMU ops.
>>>>>
>>>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu-- 
>>>>> drif@eviden.com>
>>>>
>>>> Please use a separate lock instead of the BQL.
>>>
>>> Hi Paolo,
>>>
>>> We need this particular lock because some of the functions we call
>>> require the bql to be held.
>>
>> What functions do you need?
>>
>>> Is it a problem?
>>
>> It depends on the function. :)
> 
> memory_region_set_enabled()
>    -> memory_region_transaction_begin()
>       -> assert(bql_locked())

Oh, I found Yi Liu's reply that came a little before mine.

Yeah, then I guess this is unavoidable (short of adding locks to all of 
memory.c---which would be a good thing but...).  But please mention this 
in the comment that you are adding; this:

/* Some functions in this branch require the bql, make sure we own it */

describes the code but does not explain it.

Paolo


