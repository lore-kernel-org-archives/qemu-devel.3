Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE85C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJD6-0007ow-MF; Tue, 21 Jan 2025 13:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taJD5-0007o8-8H
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taJCx-00041S-Jp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737484956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jsFMsoInn53NrAxsOGk/ApQlhPuyvv5DEipIT+qTLIg=;
 b=ib6dwdrhBVGOx0XcjYg0nJb5aBbDfJmud4QHrtHeSBg2TfTVG4MB+TpbKWlC97k/y6xXqV
 FUtbbbvR7A3BTvWRE0oFKFX7zSF3PToUm4eCLbJk2rgWblLlrXLnlGa4onRraQeg8Lyvl2
 ct5JPMw0aHCrDSaoJr4hePLUC6cN/e0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-v19wj1qINLWPdNAp10WzCw-1; Tue, 21 Jan 2025 13:42:34 -0500
X-MC-Unique: v19wj1qINLWPdNAp10WzCw-1
X-Mimecast-MFC-AGG-ID: v19wj1qINLWPdNAp10WzCw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so32622665e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737484953; x=1738089753;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jsFMsoInn53NrAxsOGk/ApQlhPuyvv5DEipIT+qTLIg=;
 b=oN41mVldHvx6g7ER/qe6rRDwMvg5eXzzs6hTl7wy6emjNCAmzA6Rb0dyxmbEejLIdb
 8+751iq/MEmRqhHZQxpXuzAFMnZcsh3A/vxbvCGbNMV6Jz1+vx3AlkkrAE5In41ajKY8
 29TNZciVOw4jd2P3rRoTYWfgskZZNKYti8Vf9zjiEeUqq1ghlmySVwDJGF5z/fUdr56W
 4FDReHbqGxE9yXMlZKXQ4CewRvur1GzFaJRKkjf8cmHoqDtAJpgTMd9T/KhgahDoJeGb
 QKq6blaUdrq6VTGkyRsbWZ8d1iwhnCqGyk6XbfjMONd+pz+Eiu3oeHlpkYMyfNKaaTd5
 QWkA==
X-Gm-Message-State: AOJu0Yx6zx6t3eIlf9UPt0H8te9ZJCO2vWBnhZ+MiXrwwazVGkoKu8KI
 FIxNLNB2j1DlQlXPH7iSfBr6b/VA7M314KjDEhj7I0Yho2sMDZZeQTtekqfQgErKt1Cgbg8kGKk
 fbYAxr7feD0u3+/WIg+pOEK4/IgjgHK1Y9Kq11bJdKJT9PRrQ+b5s
X-Gm-Gg: ASbGncukouytYhKJn87JYtdU+dUbTYOu8uEqC21YnFZYmsXYd8MgelCLiZp2txCouAZ
 49fdvV+zsROHQVFx6znwXlVSZKWELk4b5k48mc8KcoSWalkxzKIYFEWtLkxC/o+5jRknP8iV28z
 zvHFX5+1sJQO90Spwn3eZp8maDXQNtZvP1pac1T9iCrfw/mExatFLqi0BtbpuCh40pMY/pHK2Qa
 Yd+9ZVcE8xMOlVkWJzUOIVTpXQ723vE5zDullaZ1Ab53xO/inE5R9VaSMaCTOu0gdJjdyjr+Qze
 ceg289mJxByPAqX4nc3CPlDO1AYAROlJBNPrw3NDOjAp9Lkpe8Ge5I8YRF0rAB6ce4EsCxyRxAQ
 y3SPtd/omJBlsTliamz30PA==
X-Received: by 2002:a05:600c:34cf:b0:434:fdbc:5ce5 with SMTP id
 5b1f17b1804b1-4389145288emr183773485e9.29.1737484953315; 
 Tue, 21 Jan 2025 10:42:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTmBHFf3U2zIpmRroQQCtS6yYz65Zpl0Vg+B5nlRHcF5nSF8WqfDBoZMDj8DhRZkA+EYm4ag==
X-Received: by 2002:a05:600c:34cf:b0:434:fdbc:5ce5 with SMTP id
 5b1f17b1804b1-4389145288emr183773315e9.29.1737484952962; 
 Tue, 21 Jan 2025 10:42:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a?
 (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de.
 [2003:cb:c709:6200:16ba:af70:999d:6a1a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c65b7sm251942235e9.23.2025.01.21.10.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 10:42:31 -0800 (PST)
Message-ID: <51e35abb-7282-45c8-90e3-e9e39f79f9f8@redhat.com>
Date: Tue, 21 Jan 2025 19:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] system/physmem: take into account fd_offset for file
 fallocate
To: William Roche <william.roche@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org
References: <20250121175956.3030149-1-william.roche@oracle.com>
 <20250121175956.3030149-2-william.roche@oracle.com> <Z4_k0u7Gdv5OKa3S@x1n>
 <a01b7a88-6d20-47cc-9631-85d9fdd48a87@redhat.com>
 <d9e069d7-ae18-4184-a1df-ac1dcb98bbb0@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d9e069d7-ae18-4184-a1df-ac1dcb98bbb0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On 21.01.25 19:38, William Roche wrote:
> Thank you Peter and David for your feedback.
> 
> 
> On 1/21/25 19:25, David Hildenbrand wrote:
>> On 21.01.25 19:17, Peter Xu wrote:
>>> On Tue, Jan 21, 2025 at 05:59:56PM +0000, “William Roche wrote:
>>>> From: William Roche <william.roche@oracle.com>
>>>>
>>>> Punching a hole in a file with fallocate needs to take into account the
>>>> fd_offset value for a correct file location.
>>>>
>>>> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
>>>>
>>>> Signed-off-by: William Roche <william.roche@oracle.com>
> [...]
>>>
>>> We do have plenty of fd_offset bugs then.. this makes sense to me.
>>> Nitpick
>>> is we could use a var to cache the total offset.
> 
> Ok.
> 
>>
>> Agreed that makes sense.
>>
>>>
>>>> @@ -3748,17 +3750,17 @@ int
>>>> ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
>>>>    #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>>>        ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>>>> -                    start, length);
>>>> +                    start + rb->offset, length);
> 
> I also had this nit - as I should have used rb->fd_offset.

Ah, sneaky :)


-- 
Cheers,

David / dhildenb


