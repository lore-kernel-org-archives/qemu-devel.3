Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25289C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMeO-0001Dh-Ko; Fri, 21 Aug 2026 06:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wxMeM-0001DD-F9
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wxMeK-0000ED-NN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787308738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u/ZeLO7Tftbti+mGsvbY8fcodqefC59p8R1cMeBuJZw=;
 b=XuAGiAcP+6X4OvWAQ3QntC2aI3NCSullskaxk1BPyIPSPKIhhs3SaMU+9j+5J92uiDKrlG
 ON9zuzGlbP3HUL2Dc7ZJai6rh7GHNfT1wp7KSr7df01WQMf/sXGZDkYHBpHc+Y/pv/R0xX
 korNBxngdo9DGYEzfxdQobzo++bRQgo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-_rFXStPaMjOUic-zdvqFPg-1; Fri, 21 Aug 2026 06:38:57 -0400
X-MC-Unique: _rFXStPaMjOUic-zdvqFPg-1
X-Mimecast-MFC-AGG-ID: _rFXStPaMjOUic-zdvqFPg_1787308736
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a178080182so981287a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787308736; x=1787913536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u/ZeLO7Tftbti+mGsvbY8fcodqefC59p8R1cMeBuJZw=;
 b=N97HslJVNwBN87uGoC0eIK570byWZiBWgmxmsOF8c+8C39YwIi4wBHaqxCGboIjbdx
 Sa8WbRx9gBkIkEOoHDTLo73dwM0dSCSuhlt/oU1RFu4jEDhUp0BjvjPLnvTmEKbQKZTk
 7a9YiQ+i75VH8Rg00aMSUB1tmC371bQgCbxB3SuR5QgD2ezpNFM39JaaamDFXJYw3LRV
 j4PrbmzflktmT7/AQo+U52aEl/yPDMQG3Jf/3U031QQYLLCrB9zJeJjtr2acdIK9xixr
 x3cQSCF29GsANArC/+RqvfC7Z32MFPguPoCqI/cnJsYn4r1PvWz8brvWaOBohyKFPRRh
 MzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787308736; x=1787913536;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u/ZeLO7Tftbti+mGsvbY8fcodqefC59p8R1cMeBuJZw=;
 b=mL4sN33zIcU/eIZGglOMenz5VcSjfiYftVX3n2QsEbR3i5/F+AZYR2VBwroe0S1o1r
 CaLAbIai3MeZrO6Dm8XvUSGVtKLPMPtJZGssJ3ilMvT5KzNPnxjgDkLrPifYFu32WHcK
 qs0/xGjCR4SAJjwlpdTV56tCUzPTn1JZSyVN6HXMBAhzB1jMaDAgDMNK2eHTEa5Ix4fV
 kTvVwKg97uy4rQ4OcwdOE2q2mFQPW+6kxk2p0zBg30Qy1SAadlpKm/hoRk7Zl9vHoDOQ
 czDyIZr/KsaPM3FSXLQuMzFjGfTjVU+8F12XlOpty9g8PrmJAPuIfPFAPP42IrZTNwQO
 UTxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxKSvYDpc0uBJmHevt7f1EE7WnetP//B1O5rLtYSdh7KMrwJdV1suIrVq7RhnG0a84/3bzqiD43gKl@nongnu.org
X-Gm-Message-State: AFuF++kfjNrulLxpaRN6ELZs3L4o6D9U7aUQMwrstGP+LsQ57dclGb7i
 FO9RZwBttltbC8Q/me8zLCmxhXtLa6a5Kw/lM1oy3c+HFs8RBfbnZaOd+Vu2TZB1+MyqZrcnL5X
 oEYzmNVynUQ7asDhRlq550DlMxYRJd6MB/pBSbMWaA/e7njPnZ4FDVaemT8jGml3p
X-Gm-Gg: AR+sD10ty9Qwe4fY/MSDp6vUMGc9ArIzeu5PWXhu5r5bENn/bajpfdKWhnhQbis0fhf
 PyxfV4K04oxTq4mbWqfqX7vy1WnwVnJvtp/UPc/uBPcl5L3WfoodZ24zUrbf2AxBJKV7HZraIqy
 rYq62Ee2mPiCbJEZaJagWcY/njFIJXUqpivG9WSGdo1kMZurzo6NPdz0OYoxAggCbFUTpkQXxz7
 9VZ4/hSdV+0OGZxysAbZVpBvKzy9ORyiBScNIgWsiamsAa1jxv7hZS1uXexa3QR0kf1qA2Lk17g
 QXrSvBTKSnenL8qYJrmucLutTYSpJXxXG+/hMsTxZApu6cJcZwG4R6GcVqmj6HqFxAJlxLxd
X-Received: by 2002:a05:6402:2353:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a42f179014mr4976550a12.4.1787308736010; 
 Fri, 21 Aug 2026 03:38:56 -0700 (PDT)
X-Received: by 2002:a05:6402:2353:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a42f179014mr4976514a12.4.1787308735615; 
 Fri, 21 Aug 2026 03:38:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.47]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3feec9d46sm6168737a12.1.2026.08.21.03.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 03:38:54 -0700 (PDT)
Message-ID: <29d34f3f-f850-4f1b-80f3-334f626fd554@redhat.com>
Date: Fri, 21 Aug 2026 12:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Cover pflash QTest in pflash section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
References: <20260820142212.27537-1-philmd@oss.qualcomm.com>
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
In-Reply-To: <20260820142212.27537-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/08/2026 16.22, Philippe Mathieu-Daudé wrote:
> Include the pflash-cfi02-test.c test in the "Parallel NOR
> Flash devices" to be notified when patches modify it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b51f5c3e602..0361909b72f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2354,6 +2354,7 @@ M: Philippe Mathieu-Daudé <philmd@mailo.com>
>   S: Maintained
>   F: hw/block/pflash_cfi*.c
>   F: include/hw/block/flash.h
> +F: tests/qtest/pflash-cfi02-test.c
Reviewed-by: Thomas Huth <thuth@redhat.com>


