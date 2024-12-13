Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE1E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM4tw-0008Bq-Kc; Fri, 13 Dec 2024 07:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4tt-00089d-LS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:36:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4to-0006sf-3Y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734093362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LO0i8KAJ5O3ahW0hs8APaSB4floola3rLAKY9oPT8t4=;
 b=eK1rA4YoZwiV1kYR2IBcLYR2hY0QeBCYm4lDFGJ1op1qmCjVW6jTUSNXGLyICqGib35pWS
 I8Q7x5eRw0nAH7NGbs8zyZGsIELLktm8GESxCJevpUKlF/XUTm6NVcJ84YrYpzINU0otfd
 4jc5ISERl8grXwFGxifWjAi8opulmzw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-KgPQY65UNe6sIYv6H23MtA-1; Fri, 13 Dec 2024 07:35:59 -0500
X-MC-Unique: KgPQY65UNe6sIYv6H23MtA-1
X-Mimecast-MFC-AGG-ID: KgPQY65UNe6sIYv6H23MtA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361f371908so15252275e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093358; x=1734698158;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LO0i8KAJ5O3ahW0hs8APaSB4floola3rLAKY9oPT8t4=;
 b=N0SXasynKTeRVQujmaRs1aJcvpmzEGqHSXylEuYsTpr0cKSlVnPiX9CyAB3h0Dk9s2
 99vw3vN/WpiwwkM7d9p6qr7Nmo/jy0VS0QQ6acNsgmRsEtGwy5rtWLm+UycZGjAdid+Y
 Kn9PI31H4gahDPQcfh3SbdbDz6wRnnodRVGL+zDl47Ua4HnkHb/id/zmvKUm1YorHfpq
 SPm055jM9Kp+ni72TafVKISb3GD3BtMN5EIB/o0mQbp2M0sSxhtg8X1W21sAWXTg/6hU
 oHWwB+uord1ikOGi2KYQJXC0kLo7yC7Lf97ZJ9n5Tr73lCkpCv9Whzo8O0kCeprpUjyc
 NASQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzGWaqVvK+nuBioFvmLHeyTB5KhMWK0ST2HJCiIArGvY9XT9krNQE72NfVMVloq4c75GcRD1EsWdFY@nongnu.org
X-Gm-Message-State: AOJu0YxXU72z7bwKbsUqsO10VdbXWx0mAHASAQINKflr5N6xdMMl7MBR
 XqaJZ45YgUhmhYR4iCbC1xCVh9IEX1VhOp+duVPAzyIOfF1Gh150MwHmkqyWcU0wpyZm9qVJ1TU
 wzFmfsmmEDSu7jgrppM12hGxTifq/NZgOjpfT8kLqu3hWS0iExCRB
X-Gm-Gg: ASbGncvHL5yQL5/XMTpSC2nvcF1sNKrOgXuEVFGvuvcPj3EdajQRmnbBbydMGCCVhbF
 u/JflaCB75qNlUl6esl++jtP9zYem46kNYJZtmPw6fEYx+QSbtWRP8Ji2/eehAhs5KHOxvGDphE
 sdxtjcrG+8o3VNW2+z5EPj/7f6XJz9Muq4+YdszZdEYJcSpiHJHWY9avbVN/zb5/uWJW0zQsQwC
 uz8wTYRmBXJi5xbFXVKA7rcblg7jAnKeQEkpxZxIGVlpnZM/SlhltAbmR+dShgGdJJe+QV0B59r
 nzozSw==
X-Received: by 2002:a5d:598e:0:b0:385:f60b:f5c4 with SMTP id
 ffacd0b85a97d-38880ada9f9mr1887418f8f.29.1734093357731; 
 Fri, 13 Dec 2024 04:35:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfiUvmOijK89T4Bv5G5gw5r/7DYNdoIW9f+GO2J93a+Gnha8mVA8IVasj21+yPYbIOZfBqoA==
X-Received: by 2002:a5d:598e:0:b0:385:f60b:f5c4 with SMTP id
 ffacd0b85a97d-38880ada9f9mr1887377f8f.29.1734093357261; 
 Fri, 13 Dec 2024 04:35:57 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824bd8b9sm7050302f8f.47.2024.12.13.04.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:35:56 -0800 (PST)
Message-ID: <8d06030b-37a2-4c41-9907-8e072dde47f7@redhat.com>
Date: Fri, 13 Dec 2024 13:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] s390x: virtio-mem support
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <07ca4492-1590-4cc6-94a1-0eea417da59e@redhat.com>
 <7e1025b4-c246-432c-b70d-e7156afb6519@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7e1025b4-c246-432c-b70d-e7156afb6519@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/12/2024 22.52, David Hildenbrand wrote:
> On 13.11.24 15:46, David Hildenbrand wrote:
>> On 08.10.24 12:54, David Hildenbrand wrote:
>>> Based on current master.
>>>
>>> There is really not much left to do on s390x, because virtio-mem already
>>> implements most things we need today (e.g., early-migration,
>>> unplugged-inaccessible). The biggest part of this series is just doing what
>>> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
>>> well, messing with the physical memory layout where we can now exceed
>>> initial RAM size and have sparsity (memory holes).
>>>
>>> I tested a lot of things, including:
>>>    * Memory hotplug/unplug
>>>    * Device hotplug/unplug
>>>    * System resets / reboots
>>>    * Migrate to/from file (including storage attributes under KVM)
>>>    * Basic live migration
>>>    * Basic postcopy live migration
>>>
>>> More details on how to use it on s390x -- which is pretty much how
>>> we use it on other architectures, except
>>> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
>>>
>>> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
>>> be documented in the kernel and at [2] once this+kernel part go upstream.
>>>
>>> There are not many s390x-specific virtio-mem future work items, except:
>>> * Storage attribute migration might be improved
>>> * We might want to reset storage attributes of unplugged memory
>>>     (might or might not be required for upcoming page table reclaim in
>>>      Linux; TBD)
>>>
>>> The Linux driver is available at [3].
>>>
>>> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
>>> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
>>> [3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com
>>
>> Gentle ping (and thanks to Thomas for the review!).
>>
>> I assume the kernel portion will go upstream in the next merge window.
>> I'd like get the QEMU parts merged soon after that.
>>
>> 9.2 is going to get released in roughly one month, so there is still time.
> 
> In the meantime, 9.2 was released. I don't have any changes planned. Series 
> still applies to current master, I'll do a quick test tomorrow.
> 
>>
>> @Thomas, this is mostly s390x stuff, so I guess it should go through the
>> s390x tree? But I could also take this through my "memory devices" tree.
> 
> @Thomas, any thoughts?

I'm fine either way - feel free to put it into your tree, otherwise I'll 
pick it up likely sometime next week.

  Thomas


