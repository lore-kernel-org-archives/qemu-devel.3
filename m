Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8610D4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t932Y-0005h1-M7; Thu, 07 Nov 2024 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t932X-0005gi-5w
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:59:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t932V-00016v-GA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730987948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NJIdqWT1TRc4smUFVOW7RDOn8PHyyCAPIQfMk7tsoNg=;
 b=WOZMGiGYusIIDJI90uFc9x/gBoVuj9FqThYZMc6aLILdwGAPg8zIdHjhm6AY/JAer9cVE+
 mMuhI828tqJisDJtw8qV1ymNHD/SgE1BahH2CMIx2Qq5Y8lohTn43PLvtcvZC0zIsqlgVK
 F5KGdHeYmuCPAOtVzVFaUqfFCrKwi58=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-2Sv0NprLOe6qy_usPma9hQ-1; Thu, 07 Nov 2024 08:59:07 -0500
X-MC-Unique: 2Sv0NprLOe6qy_usPma9hQ-1
X-Mimecast-MFC-AGG-ID: 2Sv0NprLOe6qy_usPma9hQ
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-28cc1cea79cso843665fac.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987947; x=1731592747;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJIdqWT1TRc4smUFVOW7RDOn8PHyyCAPIQfMk7tsoNg=;
 b=GP+T8hLdhdLV6AYtQLRivHmvARCqXm0Sl617Zm8nqu+75B7lAJscmYR/DjucWEnCAk
 OmTpb5Ecl9eZl5Ws/QWO+hnaGlMf3KUeNGVJiC/Jl+jhvlDFM7U4/80FGQrCf6wLrJ5L
 QQZT/Mxb+hx5SlUzt05BI6hG/01jqT1yX1EfhgjJlLKBN2eP4XX+6wohan1kk1WoNRqv
 GvXT+G7q+B5lJ1+jC+F5GDbX7KKB7NJlQ7L4CtSObnd15TWzPm48EJCQVrwl9p+OSYBK
 bBOUl+z9GvsmromHe3A0lSq0Y2liIVj/WZ7d9fTKnsxx97Sh+EJBI8WbXGUVLWmeWp4I
 d0LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYgWppxHlf9U6Ug13f/Qe39z9Oh1vBOdiKKQZ4J5c3zxIzfeHwZ4U0Vp933zCBJxuk03N3WpA6kyNK@nongnu.org
X-Gm-Message-State: AOJu0YxV/RVblbVToAIC7eqfq9mFBD2jGohwmq6Jszu2MRD8q4sxrPwQ
 dIzzw+T7P24/SNhuMEdn+UoP2JZSnxFBbFQkOPw287q583da05vW94x6XipFCiO99dzH0NP7YsC
 tr9EMjrhcq0YpqKOMQZegh4ZJ7aMSJ76XPyVXbsW1k93yna/5cdSD
X-Received: by 2002:a05:6870:3907:b0:288:e7f2:e9db with SMTP id
 586e51a60fabf-29559d76306mr68880fac.41.1730987946937; 
 Thu, 07 Nov 2024 05:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESNPOjx/vF53aCQ8WOp467IuM8yubXSjZjyYs0es/tksAgHjpKgWr4nAdh2Kf0zHPT+7VKaw==
X-Received: by 2002:a05:6870:3907:b0:288:e7f2:e9db with SMTP id
 586e51a60fabf-29559d76306mr68849fac.41.1730987946576; 
 Thu, 07 Nov 2024 05:59:06 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29546c932afsm345650fac.19.2024.11.07.05.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 05:59:06 -0800 (PST)
Message-ID: <2bca571b-4af9-4ee5-9fdd-15983e2f56d1@redhat.com>
Date: Thu, 7 Nov 2024 14:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] s390x/s390-stattrib-kvm: prepare for memory
 devices and sparse memory layouts
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
 <20241008105455.2302628-9-david@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20241008105455.2302628-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/10/2024 12.54, David Hildenbrand wrote:
> With memory devices, we will have storage attributes for memory that
> exceeds the initial ram size. Further, we can easily have memory holes,
> for which there (currently) are no storage attributes.
> 
> In particular, with memory holes, KVM_S390_SET_CMMA_BITS will fail to set
> some storage attributes.
> 
> So let's do it like we handle storage keys migration, relying on
> guest_phys_blocks_append(). However, in contrast to storage key
> migration, we will handle it on the migration destination.
> 
> This is a preparation for virtio-mem support. Note that ever since the
> "early migration" feature was added (x-early-migration), the state
> of device blocks (plugged/unplugged) is migrated early such that
> guest_phys_blocks_append() will properly consider all currently plugged
> memory blocks and skip any unplugged ones.
> 
> In the future, we should try getting rid of the large temporary buffer
> and also not send any attributes for any memory holes, just so they
> get ignored on the destination.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-stattrib-kvm.c | 67 +++++++++++++++++++++++-------------
>   1 file changed, 43 insertions(+), 24 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


