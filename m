Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FAC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKxvF-0002Gt-Aq; Fri, 30 May 2025 07:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uKxvC-0002Fw-R3
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uKxv7-0000uH-59
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748604543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qoFTXr5ujWZGuCwSBQ5pWwvq9xxHtxT+ce4lJ74ZFpc=;
 b=TzqEtQk7mCF0SBx72ZzJZX0LearClICefE+OvvYXeCm1bQswP8DY73ClqPQyusLQSZa+xx
 xHBLf+HO+3deMM27wnv6Xs8Kx0PwuLcNAX2o/MUBitqqzhSHFz/tkKEzyF76m1w+PTATxA
 ljwTrP72O0gPfh+6rQ7ggK6T51+8WQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Fgs2-mf8NfKu3nV0xFB4Uw-1; Fri, 30 May 2025 07:29:02 -0400
X-MC-Unique: Fgs2-mf8NfKu3nV0xFB4Uw-1
X-Mimecast-MFC-AGG-ID: Fgs2-mf8NfKu3nV0xFB4Uw_1748604541
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so120333f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748604541; x=1749209341;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qoFTXr5ujWZGuCwSBQ5pWwvq9xxHtxT+ce4lJ74ZFpc=;
 b=DQX49N4bvLxhyVVJdNjOmaEHWqm9M9ICkaHg6DttXA7CvNxunO8Tc7nX0RfDbgsJ/p
 RJkHZtHZ8hTCvdkLkRCd+sgVthz/tJeFIoiqsmjAPHpoiKB0o5ohhYhhwxGTQCwvdaBH
 3z8wmDd/P3kktMf8bM+781s5ob3cy9EYQB1ifYfk3ZvrVZWG64A9LZetaXMW84jrMHkm
 KEiozPhAquPazIJ6SSK3WiycUQcFmSQ6RITafIM09Y2DGi+32AD1VQ+Pu48qRQvzrdtc
 hcm6GXtqnZamJZI1XbeHxlN1CVW5CyoN5TvanQ9V0uyFIvkwg6c8ON2nKJPMp+HrYSTK
 82PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWtnARjPtVbAHk6Ez0W0LkINZtu38/jgfqJOae8N/3WMfVaSJK6CTpORZdY8Sh3bkkTpkeGms0nFpB@nongnu.org
X-Gm-Message-State: AOJu0YzQIwI4iuCt+CPMARyBn4CC4R4513ZG5q5bySpEMA6TOd7xuIft
 62VaN11Z7hXIoiwTyi/K9mFoR8FRVvIp96HxtzjlMPYozow91C5DZO6r7KamSaQahUovBfdBH6w
 ye0FKTwWH6IvYrQRiQTEfSOP6KegHpztvRVMT3yD+A+0sR409oHgwLwS/
X-Gm-Gg: ASbGncs0TbwdkLH7p6+Z+SqWINjaTR0HjXgznmviqc47VV+vITdx+JjyLIW7iJkzjkM
 cwzCM4s9YnbJ57TYkxjKs0f2MswQP6lpbm3rOAkxjlE/6DJ8ucjSEsMCrpjdIYiEX6fKaeAWpHW
 xwx1LfaDWUqqQYeil5f3GFgBOjfX0HoElz8kRzmHIwGIUmea3wR+pPbL9jdNQHVMTtKCimePHXM
 NXfu3bWh5tdc38lU2xQ2ijzp9SIbCL1M7K8/3n0iCKuZUWxFWf9W1JcsnWV2zGDyEVl2P6FJaBB
 5qasgFkQoOStb5dWa9lvdFvC3eviGNuGeevzsPOb1tlrZtaBcOF3
X-Received: by 2002:a5d:58dc:0:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a4f7db764cmr1739786f8f.52.1748604540968; 
 Fri, 30 May 2025 04:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv3Jl7uzUNgWTUdPNd3IENz8dfBbEB2i1tON1Kbzi77cki6f6Tl7YMsTHanaTTOOFGaUw5WA==
X-Received: by 2002:a5d:58dc:0:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a4f7db764cmr1739766f8f.52.1748604540540; 
 Fri, 30 May 2025 04:29:00 -0700 (PDT)
Received: from ?IPV6:2a01:599:90b:feef:9de7:67cc:305b:deed?
 ([2a01:599:90b:feef:9de7:67cc:305b:deed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb09a3sm15456715e9.24.2025.05.30.04.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 04:29:00 -0700 (PDT)
Message-ID: <b89fc010-cf76-4951-8d06-80dd7c2ebc8c@redhat.com>
Date: Fri, 30 May 2025 13:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
 <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
 <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
 <20250514111224.7fb1263f@imammedo.users.ipa.redhat.com>
 <acc02028-89ac-49ad-9c5c-d6973738b113@redhat.com>
 <20250530071844-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250530071844-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 30.05.25 13:18, Michael S. Tsirkin wrote:
> On Wed, May 14, 2025 at 11:26:05AM +0200, David Hildenbrand wrote:
>> On 14.05.25 11:12, Igor Mammedov wrote:
>>> On Tue, 13 May 2025 15:12:11 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 13.05.25 14:13, Igor Mammedov wrote:
>>>>> On Mon,  3 Mar 2025 13:02:17 -0500
>>>>> yuanminghao <yuanmh12@chinatelecom.cn> wrote:
>>>>>>>> Global used_memslots or used_shared_memslots is updated to 0 unexpectly
>>>>>>>
>>>>>>> it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
>>>>>>> It's likely a bug somewhere else.
>>>>>
>>>>> I haven't touched this code for a long time, but I'd say if we consider multiple
>>>>> devices, we shouldn't do following:
>>>>>
>>>>> static void vhost_commit(MemoryListener *listener)
>>>>>        ...
>>>>>        if (dev->vhost_ops->vhost_backend_no_private_memslots &&
>>>>>            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
>>>>>            used_shared_memslots = dev->mem->nregions;
>>>>>        } else {
>>>>>            used_memslots = dev->mem->nregions;
>>>>>        }
>>>>>
>>>>> where value dev->mem->nregions gets is well hidden/obscured
>>>>> and hard to trace where tail ends => fragile.
>>>>>
>>>>> CCing David (accidental victim) who rewrote this part the last time,
>>>>> perhaps he can suggest a better way to fix the issue.
>>>>
>>>> I think the original idea is that all devices (of on type: private vs.
>>>> non-private memslots) have the same number of memslots.
>>>>
>>>> This avoids having to loop over all devices to figure out the number of
>>>> memslots.
>>>>
>>>> ... but in vhost_get_free_memslots() we already loop over all devices.
>>>>
>>>> The check in vhost_dev_init() needs to be taken care of.
>>>>
>>>> So maybe we can get rid of both variables completely?
>>>
>>> looks reasonable to me,  (instead of current state which is
>>> juggling with  dev->mem->nregions that can become 0 on unplug
>>> as it was reported).
>>>
>>> David,
>>> do you have time to fix it?
>>
>> I can try, but I was wondering/hoping whether Yuanminghao could take a look
>> at that? I can provide guidance if necessary.
> 
> 
> Guys?

Is the original author not interested in fixing the problem?

-- 
Cheers,

David / dhildenb


