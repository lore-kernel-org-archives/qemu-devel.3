Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B0DCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmm9-0004ah-Dj; Mon, 07 Oct 2024 08:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sxmm7-0004a2-PE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sxmm6-0001NI-8l
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728303820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xS3npOitO/KydqSpSWcYl24QOo374nLH/6u9t7RZH3M=;
 b=MJAbizNCaudimV8rSB5kSyIF5d5vDJ1fP1aYclr3AmrExiGTxQ/+bdfEbLUrlUry8h1r8G
 vrggQPWsYYSH2zCAmclBuJZjkoxi8YK0mEIhlqKC0OfgJPgU8ILFgWWut/pL/7pBLI8hDA
 4YreiEf/yTQzNRpIWJS0hb5+5nn+CRE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-bnymZetDMwO7QlrnH3fhSw-1; Mon, 07 Oct 2024 08:23:39 -0400
X-MC-Unique: bnymZetDMwO7QlrnH3fhSw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37ccd14a2f9so1441119f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728303818; x=1728908618;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xS3npOitO/KydqSpSWcYl24QOo374nLH/6u9t7RZH3M=;
 b=hAVvyWtoc122Z74MBTdU3cWije3SAk5gm3IVNwMxA11dO1H830E+Gh4qyfbUhMcZSm
 Y7QClNGWOnUNQC9QCmNciMvu2NwxU21B46+8ewxgqqESyuXhmsefxekMAhrmPhlfFlsi
 hOn2aZ7FtPF3DeIEQQ/zGqJvRdsjAxxd4FE7By7BfbXEpPR1sZXFD7E6cAMMVO8sG/KD
 UJLKE9g5s81nVguPjMMR9acxrljjdl8ly9anF1S3ipszQzeMZ+knH+Z/NSOq9ghSU3PN
 IivkxpcGqbN+fR2xbkBANNRP6BtKEHgiUej4xnNb04iDxLbcQYmhymHp10SNLMquUYOW
 lTfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEKjM1uFLO3PKPdFE73mg9B4UTGd3Jl/UJhPhIK8TnWlzYtAlgGvH97LsfoEz2THpJn7FOcYThx64q@nongnu.org
X-Gm-Message-State: AOJu0YzAZu7mOFt00jT+28pJ9BCggsxTKeNLOpk32ZEnVCo8xBWdmD1D
 wkPG6fErBzrfSdGpebD5tkZAcARwG64YR2wTJ9+8zCWDCWcWHtLcwrVG8QJXRkZUyGVnOSXk6tE
 8A/mAaMQavUlx2ilNdlqaDggW2OkQl4aNE0mFwypGbitbPUwrMjoN
X-Received: by 2002:a5d:44ce:0:b0:37c:cfe4:6997 with SMTP id
 ffacd0b85a97d-37d0e8edfd1mr6083124f8f.47.1728303817967; 
 Mon, 07 Oct 2024 05:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV0RmJN36yfEXEAmVyehX75yD0Ag90ViIpPshpcdmD0on42bEXBS7e+rbZevS0TGWSnlcpuQ==
X-Received: by 2002:a5d:44ce:0:b0:37c:cfe4:6997 with SMTP id
 ffacd0b85a97d-37d0e8edfd1mr6083109f8f.47.1728303817563; 
 Mon, 07 Oct 2024 05:23:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34?
 (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de.
 [2003:cb:c725:8700:77c7:bde:9446:8d34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b4a38bsm91141945e9.39.2024.10.07.05.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 05:23:36 -0700 (PDT)
Message-ID: <72cb52cf-7bf5-487d-a299-e827dae5ece5@redhat.com>
Date: Mon, 7 Oct 2024 14:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
To: Janosch Frank <frankja@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
 <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
 <20240911100415-mutt-send-email-mst@kernel.org> <871q1qurol.fsf@redhat.com>
 <ae1eb296-2737-4871-8769-cee78e459bca@redhat.com>
 <20240927202019.6d721171.pasic@linux.ibm.com>
 <7aea51e4-5514-44e7-9da0-cf6aa7a31439@redhat.com>
 <20240930234912.25acd03b.pasic@linux.ibm.com>
 <44a9f7a0-d838-40e5-ad91-6c1baf33da21@redhat.com>
 <e560fad5-8c24-4518-bb94-43ba8203ad2c@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e560fad5-8c24-4518-bb94-43ba8203ad2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 02.10.24 11:04, Janosch Frank wrote:
> On 10/1/24 10:54 AM, David Hildenbrand wrote:
>> On 30.09.24 23:49, Halil Pasic wrote:
>>> On Fri, 27 Sep 2024 20:29:19 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 27.09.24 20:20, Halil Pasic wrote:
>>>>> On Wed, 11 Sep 2024 21:09:27 +0200
>>>>> David Hildenbrand <david@redhat.com> wrote:
> 
> [...]
> 
>>> That is a valid point. But IMHO the benefit of having this independent,
>>> does not justify the churn of having a separate project with its
>>> own governance, and communication infrastructure. And I suppose for an
>>> open(?) specification, one would need those things.
>>
>> I don't see the need to bring in all that bureaucracy. The original idea
>> was simple: if QEMU/TCG or QEMU/KVM implement a hypercall (IOW: it was
>> acked by the s390x maintainers), we document it somewhere.
>>
>> Implementing something in QEMU and then modifying a KVM document in the
>> kernel tree sounded odd.
>>
>> It is a valid question to ask: what if any other hypervisor
>> (cloud-hypervisor etc.) would want to implement a custom diag500
>> hypercall, and who would ack it. But I don't really think that we would
>> have to sort this out this at this point in time.
>>
>>>
>>> No strong opinions though. If Christian, Janosch and Claudio are in
>>> favor of a separate "Specifications for open-source virtualization on
>>> s390x (IBM z Systems)" project, I'm fine with it as well.
>>
>> I'm more than happy if we don't need that. As said, I'm happy to
>> document wherever people tell me to document.
>>
>> 4 years ago we thought that having a separate repository was a good
>> idea, maybe it is no longer. In that case, s390x mainters please let me
>> know what to do :)
>>
> 
> I'd like to at least have a partial documentation in the kernel if not a
> full one. You can add a link to your repo to that.

Makes sense.

> 
> Even if they go out of sync I'd rather have documentation where I'd
> expect it (Linux) than only the repo. IMHO duplication isn't a gigantic
> issue here.

Agreed.

> 
> We also have an internal space where KVM architecture is being stored
> (currently a handful of documents) and we'll store it there as well,
> including a link to the repo.

Perfect. If there is a way to enable that repository, that would be 
great. For the time being I'll document it there as well.

Thanks!

-- 
Cheers,

David / dhildenb


