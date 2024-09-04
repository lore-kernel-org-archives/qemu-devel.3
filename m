Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A4CD4F32
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slwyH-0008JP-1F; Wed, 04 Sep 2024 16:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slwyD-0008Il-Hn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slwyB-0000Az-PN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725483073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l22/Cn7yvVS4YgVx60y4wPoUGz4zZM3ZrcCaujxkh6o=;
 b=UcZlAwO0Z9NYqXvegWepa2eJNkIR+VfQ7tGHr43JK1zBWKh2aBqJcpiiSYjENrbLKJQboX
 Pa0d75+S6jHP9yWOAFAjENBv20ZgtSYOxa/avFXUfDPPMpNnWG9K7OAZKabKBXY0dLGqb4
 M/Mk36CXwIpu8bkMBuLUBnPJtTkQDGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-bZ8bE9IiMcyrY2CQRWtyBg-1; Wed, 04 Sep 2024 16:51:12 -0400
X-MC-Unique: bZ8bE9IiMcyrY2CQRWtyBg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42c827c4d3aso10770315e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725483071; x=1726087871;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l22/Cn7yvVS4YgVx60y4wPoUGz4zZM3ZrcCaujxkh6o=;
 b=clybZJkuTV+aMO7Ov2/Hm3lFFsfAPmnsU9kCxfc/bnwi/PB/TEPNQOpWkfOJL29V9K
 fxGOrItKAljnIg+pZRjR4oeOl/TQaXpOyfjDRRPw/lKxttLs6A9JmcuWl3oenZU/oBSf
 5/kGpId9O39t/WL+ZgvQzdQCIwnYubOe8pgZyiGaCE1ff5oWXIi9OO+XwPJG1vEqEIGv
 CjqqC/VhQsLRi1k16szmktm5B+4yoNzcetCCzvsZIfD3ehxd5V/KKc0Ra2ngoLs4js6Z
 VhOOgQoGhKnLEl18l7s4dy1ZHyHU52R7igtg78A4wOj5DZaDLhuxPy8b/gPqliHvAuP9
 SDkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUomsJ6eDo350dlSA5JSf7G2kRYsnb28yHJ70JiZfkPlphcMmd0wEIlwB3frG2HfRb1CoD2RgrrwhqU@nongnu.org
X-Gm-Message-State: AOJu0YwAXQ+yJi6NYPwV8pkTbILx21YFV3QlLYdvv7vC6DZ+ZlUFZRUw
 qwhew7avCK8XKPlwED4e1+0C28LafEqEnMxx1j73trnN9wVgYRpUwcd8UnG0NzcLXtJ8gCtcxg5
 aHwZ5ZOfbIDXDhmAJxsAtHicqkRpeakDmUHsYzod9V3+0wiAxWiMd
X-Received: by 2002:adf:fa81:0:b0:371:8763:763c with SMTP id
 ffacd0b85a97d-3776f92935dmr2744581f8f.33.1725483071575; 
 Wed, 04 Sep 2024 13:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvJW3QLKYy3VOd4xFGAiJ7moKUOlxR7/dbUzmaglUw57uQtUz9ZV5knKU24NUtER5qVvoSlA==
X-Received: by 2002:adf:fa81:0:b0:371:8763:763c with SMTP id
 ffacd0b85a97d-3776f92935dmr2744569f8f.33.1725483070878; 
 Wed, 04 Sep 2024 13:51:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992?
 (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de.
 [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425811sm254319895e9.40.2024.09.04.13.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 13:51:10 -0700 (PDT)
Message-ID: <9c82dcd3-1326-4b78-a928-2a01b5c56c4d@redhat.com>
Date: Wed, 4 Sep 2024 22:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
From: David Hildenbrand <david@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <4ed8cec2-413a-4254-8804-55befbcd0d00@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4ed8cec2-413a-4254-8804-55befbcd0d00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.09.24 22:43, David Hildenbrand wrote:
> On 04.09.24 21:16, Peter Xu wrote:
>> Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
>> was a separate discussion, however during that I found a regression of
>> dirty sync slowness when profiling.
>>
>> Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
>> statically allocated to be the max supported by the kernel.  However after
>> Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
>> the max supported memslots reported now grows to some number large enough
>> so that it may not be wise to always statically allocate with the max
>> reported.
>>
>> What's worse, QEMU kvm code still walks all the allocated memslots entries
>> to do any form of lookups.  It can drastically slow down all memslot
>> operations because each of such loop can run over 32K times on the new
>> kernels.
>>
>> Fix this issue by making the memslots to be allocated dynamically.
> 
> Wouldn't it be sufficient to limit the walk to the actually used slots?

Ah, I remember that kvm_get_free_slot() is also rather inefficient 
because we don't "close holes" when removing slots. So we would have to 
walk up to the "highest slot ever used". Let me take a look at the patch.

-- 
Cheers,

David / dhildenb


