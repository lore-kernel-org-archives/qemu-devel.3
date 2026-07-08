Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FDAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTbd-0000Ns-Ts; Wed, 08 Jul 2026 10:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1whTbc-0000NU-AU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1whTbb-0001el-2a
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783522228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PCIz7ASt8G4js3JQ7u55rpSD9/P3fS2/BJ9G/rFRTrk=;
 b=M7q0ZZOf5MReo1ytarixOvPGmO376XAOnMe8HYfsc+vNLORzVIQlmMwFcjU1TPn8I0XWX7
 n/wwVFTVEoo9AcDS+YreyoZVI62t15wdHcghzzZDktAnXLHpe7xtIkeSiRxcFYa9PKAtar
 V/uIM24X9Oq3xLg/asOwbZEXk9Xpeqg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-8_X-eEayO4aou7qtUvAYow-1; Wed, 08 Jul 2026 10:50:27 -0400
X-MC-Unique: 8_X-eEayO4aou7qtUvAYow-1
X-Mimecast-MFC-AGG-ID: 8_X-eEayO4aou7qtUvAYow_1783522226
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4773d2405c5so979457f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783522226; x=1784127026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PCIz7ASt8G4js3JQ7u55rpSD9/P3fS2/BJ9G/rFRTrk=;
 b=V/E1BjjFBfL+/ZwI46e8N256VUcB/0BFg5ox66Wo2FoVK/pLt8Ws78n8On8RuCZlO9
 7S8sr/XGgj3WKHWMnPmL2dwO+NG5h4DloMW9+a2XlAyEWAGvjwqsoZWB1Vi0RHYERbed
 /ATvMzDeHwkM4pUDC3Im7LVTgNTMru8n6mQf6L0kgcGoLi3J12PfBSEzQsya/duz9msh
 A84hMipAImcu/S8/oS+TfWnijhnFqQsBGqWtpkZpX6hXDuSVSrkLmv65NQ5Ojwg5jo0r
 FOW236CkbaaJRWP0b+lJ+R7Z3ZjT9RuDav3Jflix8xA7tISvbHjpes/6M/1/6i3c0KzT
 KFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522226; x=1784127026;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCIz7ASt8G4js3JQ7u55rpSD9/P3fS2/BJ9G/rFRTrk=;
 b=nT8TccWzUfsH6BjsF7LzizjuhWXmL37rV/Ju/Xt+l2FTpf96QeculCXTytGEPM/KsR
 HT1/y+GCH8lxXpDXA/tF7smlI40f/lZ+KKQdoXzxSmsXsBHih5w0YdpUjnxzw5i0Zv+m
 ddqYW14bvQcicKJGPrxILXZ53cCtaveIbRprFy7PPkagMyT6rVmGEh5pDKPfQDRtKVbD
 kuOvQX9JsWJT49Q4uwn3+BUH81521ttHBYNhsa0aKN7UpvE8Lop8aqGIU7Z9Hcsn87ip
 CN0dldchhIIaHZ6ibFhPk9sKp1fz+UkOO+MxcjgSuDxiDgPG7Iv8AHzWhAq5st1qtrwT
 pUYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGM7ayW9PBF6UDS5uN+t7EkA08oAjmJ6SzShdWv1zALTQz2Yyu18mhEsETRWaDC/Tjx6tskkOShRA6@nongnu.org
X-Gm-Message-State: AOJu0Yy4oGrsbuQiaXJpaemtvD7qfabxlZ7+I+HkHcqp9tEW3zM+AeNm
 neAh9O1TJyqU982OEiXYH91NBQ8SMfL/TH54muRDdQNC8Ycf4LYQVLSBSsApNh4lwEi6hexgOEr
 BZ6Q24FbVNzqq9E+vtn1GVDpS7HIIczjkWyVVcENdFOXFKAzF421XJ3dE
X-Gm-Gg: AfdE7cnC1adeVV+JyRrfMrR3WCD5xjd5PoCinp8EQ7w5+HWVY9wMY39zrJDicMtCR3b
 Cb4SoVjIHcxfT8WPR59jmNY88D+jkJpHxO1oRKeFjVRfrksNUTWAl/rDOzrBUTWJ7gaABNopLZj
 Yx5m3L/CZP00EAi2C9k8Zju/YVHMqbN05wG/fz4uHHoiYGnuH7wD5F/w+gLq/EGNgfP9zMpQwvN
 3elEtcs8VmsmoGkDquR7kudqa39+qQnBPvrariCuNFj6dnn3v4lEnsWkKiwgxyPuWQYQKk8Yq1k
 z1Ktaf0qCO+G1ymtmobehGVSUJkmFulr4FFQrxOafkp5ocyP3/B0dTFFYnxL7Bj1HVhV6YBBLQm
 eLGp6ImMX
X-Received: by 2002:a05:6000:4028:b0:475:c578:b619 with SMTP id
 ffacd0b85a97d-47df0797e0bmr3412826f8f.30.1783522226214; 
 Wed, 08 Jul 2026 07:50:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4028:b0:475:c578:b619 with SMTP id
 ffacd0b85a97d-47df0797e0bmr3412785f8f.30.1783522225754; 
 Wed, 08 Jul 2026 07:50:25 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm42401786f8f.20.2026.07.08.07.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:50:23 -0700 (PDT)
Message-ID: <efe87031-e2ca-42d2-b4e3-03adbf5d1941@redhat.com>
Date: Wed, 8 Jul 2026 16:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, qemu-stable@nongnu.org
References: <20260708144112.1830881-1-lvivier@redhat.com>
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
In-Reply-To: <20260708144112.1830881-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/07/2026 16.41, Laurent Vivier wrote:
> The migration restore path reads nr_active_ports from the incoming
> stream and passes it directly to fetch_active_ports_list(), which
> uses it to size a heap allocation. A crafted migration stream can set
> this field to a very large value, causing QEMU to attempt a
> multi-gigabyte allocation and abort.
> 
> Fix this by checking nr_active_ports against the configured
> max_virtserial_ports before calling fetch_active_ports_list().
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/char/virtio-serial-bus.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index c1973f0248fc..80f1b308aa53 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -804,6 +804,10 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
>   
>       qemu_get_be32s(f, &nr_active_ports);
>   
> +    if (nr_active_ports > max_nr_ports) {
> +        return -EINVAL;
> +    }
> +
>       if (nr_active_ports) {
>           ret = fetch_active_ports_list(f, s, nr_active_ports);
>           if (ret) {

Reviewed-by: Thomas Huth <thuth@redhat.com>


