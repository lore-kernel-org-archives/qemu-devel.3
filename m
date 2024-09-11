Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E88EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMSm-0003il-K5; Wed, 11 Sep 2024 08:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1soMSg-0003K1-Tv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1soMSd-0000Ra-Oe
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726057717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hiu3ZmzuqvXv3UWpRTqWPKL3YegnPAKiiiK5QeaTY5E=;
 b=dSEPqMrVGI6BzEAbeEha9tVLmHNfpUAq65CBfOTJXVqwgpW+clTXD0W1KthevaibLwhJlL
 9d/sNm5BYv159iPcHLvFqRPcL7wZL9y44x53m+OSlGeuRz6BLbx9XiBD1/llDWe8l2VlUo
 OsJPMOZzWktzGJFszEd+rkwcGUORe9Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-bjg0y6scNlurTpNWyB3OTQ-1; Wed, 11 Sep 2024 08:28:34 -0400
X-MC-Unique: bjg0y6scNlurTpNWyB3OTQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cbcf60722so19313475e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057713; x=1726662513;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hiu3ZmzuqvXv3UWpRTqWPKL3YegnPAKiiiK5QeaTY5E=;
 b=h84vWC+69keYhO9RzRRwdvFYVyTEQ5IO3AbHg6UF2+27YBuTtu05T2bbIwKGWVF53T
 Rk7tPAqBzYMNs4mHGh7SXp+H2tr37UwY5F0V9YuTlbBNziWiKw5NBKlzm4X8oVu2b34v
 XrpYFH26icxnTBJWUE8T959tLDZebzHa4eeEenVw/hBeMnMJpMRVvGpsZr/jtquLPA0f
 3MEOZMHOim/GtJNu4VPpKBbrHiXrNJouCLAk1SUAIdw3vAhfBFGgVU4vVnjnq5XX+ApQ
 l9BDsZePkzpf/j9a2jSLZpUac+yk77VcTaQfeJEo3Fxm5XvAbeplXuNN8s0sCGW8Uy26
 PKXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmqQV/2okFk8Hhav/1kHanw7V7qItwv/5oqeh1dBqBnYn84RfNCyqf5kiP0Ca41X4eR0xU7//BbJmx@nongnu.org
X-Gm-Message-State: AOJu0YwmiDgjKgqscBOJMqWndfeB4vMsACMNYwmVkn4P0Jc9UFZ5Sdr2
 Bag1L644yanGUa0IienkDW3fJ1vsm8oezT1YHfEMkQEPc5TAwkWv7hVsDPRHGvZGdBWLpDil3Tw
 FELNA8NiPNPypW9i1Rh9UFPhJtTN6Lu5gWqZAGUxK1IjrgOED4iAB0GJDgcgzHGE=
X-Received: by 2002:a05:600c:4e08:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42cb7f94e5cmr77637245e9.26.1726057713164; 
 Wed, 11 Sep 2024 05:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhG/u2q8GL71YU1Nmgukj8KdhMzoL+1wqzbCS3gNXIUjotn+15Rs16MiUuYcQ4Fgrj6GJGgw==
X-Received: by 2002:a05:600c:4e08:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42cb7f94e5cmr77636795e9.26.1726057712191; 
 Wed, 11 Sep 2024 05:28:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:7e00:c672:608:5b3e:df8c?
 (p200300cbc7007e00c67206085b3edf8c.dip0.t-ipconnect.de.
 [2003:cb:c700:7e00:c672:608:5b3e:df8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb2f86488sm124584035e9.15.2024.09.11.05.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 05:28:31 -0700 (PDT)
Message-ID: <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
Date: Wed, 11 Sep 2024 14:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11.09.24 13:49, Janosch Frank wrote:
> On 9/10/24 7:57 PM, David Hildenbrand wrote:
>> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
>> be documented at [2] once this+kernel part go upstream.
> 
> Why not in Documentation/virt/kvm/s390/?
> s390-diag.rst is very similar already.

I can document it anywhere people fancy, really I don't care. But this 
has some history. The last time we discussed it [1] there was:

"Regardless what we end up with, this needs to be specified
somewhere(tm)." from Conny

"It must be well defined and easy to find also for kernel developers
who actually have to care about memory detection code :)" from Heiko.

And then

"the kernel's s390-diag.rst should also point to it ... Nothing as 
complicated as an OASIS spec, but maybe a git??b project?" from Conny

> 
> I'd rather have it in a shared and bigger repo than in your personal
> gitlab one. Maybe there's a space somewhere in QEMU or the Virtio team's
> repos that would be a good fit if the kernel's docu isn't the right place?

At this point, outside of kernel/QEMU feels like the right thing to do. 
Conny is already a co-maintainer of my "personal" (;)) gitlab.


And now I realize that I CCed Heiko on the Linux series but not the QEMU 
series. My bad.

[1] https://lore.kernel.org/all/20200727114819.3f816010.cohuck@redhat.com/

-- 
Cheers,

David / dhildenb


