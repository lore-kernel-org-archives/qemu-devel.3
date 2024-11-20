Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F72D6E2CA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 06:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDeIk-0003tN-SE; Wed, 20 Nov 2024 01:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tDeIi-0003t8-EN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tDeIg-0001dQ-SI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732084492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6J5kUxAgdnHrlIrhzfyi42SiG9loE4Bj9XZpVGboFgc=;
 b=hDZHorE7Dt/hcqOUKNciCsZFqN9FN9aHPXVqpk+cWzZIIgqXoLu1atZHTdkcx8GZAdlH2M
 YF6JwJT+jvFwajzbCRYx5DbPxBQ6DoBG722jvEcLL2B2LxoTH4+erWrcllTXOqu7PLNWFR
 ppyZEUaS64b59YxC9YUoWvbo3ytQ8Iw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-m5wkW4DkM1egwoQPLCfWEQ-1; Wed, 20 Nov 2024 01:34:50 -0500
X-MC-Unique: m5wkW4DkM1egwoQPLCfWEQ-1
X-Mimecast-MFC-AGG-ID: m5wkW4DkM1egwoQPLCfWEQ
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a1828916fso55410466b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 22:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732084490; x=1732689290;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6J5kUxAgdnHrlIrhzfyi42SiG9loE4Bj9XZpVGboFgc=;
 b=ngCyk/Oah2TNNWHH8xj7v7aBVUXyDILruI0TutxvltJjdsnZ44P8OALxP7vQhMz6b2
 6vfBVXvoIR8TymrOe5XXquV2u03jFygdFsX8Z8DNHJHATA1vsRqjHCRvAxq2AXB4KqRb
 B4z/QRkMESfL1LYYG9+hCCYkV0DTUoqAsvGI0VBgzzWnlJ0V5gnkG8Oo8VS+kkQi30GG
 WXSwGET0Mx63oQAlzComs2KuVJIBbJe4THGY9CUWCmg5GtbRJYGfijkuhPrlhlPaDGjB
 pWKV0ErVo4GeMwpTit+Rji98ekzuyrZacJecjIgBqaO40wXzGD2KRq0lN+lVUYpXMVjh
 OvWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuwKnq0ZQJgxUCho3r1XAQ3WQupE3IOytGiGz0nsNzgh9f4TH45U6nDIx8rcjCHI5kLW6McFv6GvU9@nongnu.org
X-Gm-Message-State: AOJu0YxDWRiZj3vIZCtMgZoiQpdAVHJhthbLHHhifj4nsKQIUPbO5HEp
 O/9hAG0Z3CfQ+9u3GWmF2yp36Ps8DUs+7Gi3VwfFosgilSdbVMjErHAeaWc++IlJiop8hfFJ1AV
 YeX8VwUraVlpiIK2lPp0IjnBTUXk2UuEC9wvstSK/4GJEo2wGRvxBP6FpJIKC
X-Received: by 2002:a17:907:2d91:b0:aa4:cd1e:c91d with SMTP id
 a640c23a62f3a-aa4dca6c691mr159833966b.11.1732084489761; 
 Tue, 19 Nov 2024 22:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESNTp2bk0wL1CfpdHCTUAf6NpUfwEp2XytnBUJFE7kO1urZFfq4K1nUv/nPSW8uUNWdt5sZA==
X-Received: by 2002:a17:907:2d91:b0:aa4:cd1e:c91d with SMTP id
 a640c23a62f3a-aa4dca6c691mr159832666b.11.1732084489440; 
 Tue, 19 Nov 2024 22:34:49 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e043552sm730303666b.149.2024.11.19.22.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 22:34:48 -0800 (PST)
Message-ID: <32d57034-68f1-4680-98aa-8b728caa37c1@redhat.com>
Date: Wed, 20 Nov 2024 07:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fix allocation for s390x loadparm
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>
References: <20241119213142.77248-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20241119213142.77248-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 19/11/2024 22.31, Paolo Bonzini wrote:
> Coverity reports a possible buffer overrun due to a non-NUL-terminated
> string in scsi_property_set_loadparm().  While things are not so easy,
> because qdev_prop_sanitize_s390x_loadparm is designed to operate on a
> buffer that is not NUL-terminated, in this case the string *does* have
> to be NUL-terminated because it is read by scsi_property_get_loadparm
> and s390_build_iplb.
> 
> Cc: jrossi@linux.ibm.com
> Cc: thuth@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Fixes: 429442e52d ("hw: Add "loadparm" property to scsi disk devices for 
booting on s390x")

> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8e553487d50..7f13b0588f2 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3152,7 +3152,7 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
>           return;
>       }
>   
> -    lp_str = g_malloc0(strlen(value));
> +    lp_str = g_malloc0(strlen(value) + 1);

D'oh, me looks for a brown paperbag for hiding... sorry for that one.

Reviewed-by: Thomas Huth <thuth@redhat.com>


