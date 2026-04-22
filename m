Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F0F5A8DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSj8-0003KQ-8D; Wed, 22 Apr 2026 04:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSj6-0003K0-Kj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSj5-0004IS-0k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776845665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rApS/FmWS+Rp5ggkoQqkky7RH6E5EmYxNHqCmkbD6kM=;
 b=dmKDgieD16aU2WWNCCU/JQeMdi36GxdxtYt/N8rjQ7ff9VvUL1tyCJTNId7thOjpTUUKZT
 KUYIj0bFsvi+zpynRWtZ3YxULcIGJY3XvGmbaPUjyR9MzvM/ctjc+wz7pu2N7gKPc7CleM
 JydbHjBKYjcp7L39WHTy9jBNAAuABYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-kUYHGXtdOGeTaVCwiXLLPg-1; Wed, 22 Apr 2026 04:14:23 -0400
X-MC-Unique: kUYHGXtdOGeTaVCwiXLLPg-1
X-Mimecast-MFC-AGG-ID: kUYHGXtdOGeTaVCwiXLLPg_1776845662
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5adc141cso2240465e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776845662; x=1777450462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rApS/FmWS+Rp5ggkoQqkky7RH6E5EmYxNHqCmkbD6kM=;
 b=XSGKbdkD6NJVn3x3FBP4uN3F4YLkDL0uh/tOqiq2lM1Q8ny55xNUpTCB6wHZxcHl0I
 wfbsdRElOTSWLA/52RZv9uWhLv3Rydff82HZK2Kdv22XcCBilXme2K+RI443/IsRiUdp
 X9mqj5wyAMiBartkJ/3NcKV6yPu7B/S+jIgOyXRUR10+9QC8o2CvUDGEtB850E02AWo2
 BlXsCBrm6++kQXgBLmVd7WHOX94lCsqTSWzc/z5rQ3w0NCtKjScG4iFgdIgpftaez8JS
 zysi5VI5Nllglq2uM5oAsLdDhspSs4tZf3K9aRnT5QlN+dPuSM+FvJ8ZNUuOmaTzubVB
 jqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845662; x=1777450462;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rApS/FmWS+Rp5ggkoQqkky7RH6E5EmYxNHqCmkbD6kM=;
 b=eKUTpnqgFuXD/WgnYrAQ8crFNZ/N2RhqRMZEiRgefLiAmToRyoO4OLuwLiIc+PGzK7
 bHi3y2VoQPI4NEtelLkY28Xhw+m4prV59S4f3fM4uAz0UioiJWdnmHsGiuAd+qmDlQPZ
 MrMYVRHx/75vR6UHm6nuJMW5ynNmzDBY0sZAuQvjein3tKisffOAqodWmf4eW5G2YEoV
 MAUyvbApLMjnbvmJ0NIkpuLxhmeW57Sr1Dh6Xs2D/oPrYugzeBhCGFmIYl+gPNNbFkYp
 ducSsFSKuzLIQpTOV8BGyFXy/vDCjjrr/VEQdwYSkblfC8On7B6aYHfAC/O376UxMg9N
 9zgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l+F8OkK+lcRG5xWpUQtdlf3gzeybESJLd6/MCdzXxUiOWUm0aA5P3I2YX8hIPxGgA6lIVuJfanlQb@nongnu.org
X-Gm-Message-State: AOJu0YxFh/dLat9a4QG1w/7wGmiQgODDaaChUuogYztpFSswpuPrEjkf
 anCnSN2yJZLBxOflVg7bZsBb5HuziaRNdYxXU48ti6cfQ0g2BNQ9AxrT5rY3orb1wKtPSUMCFtq
 JkU67L++nln1dS+oedg781N411c85dxVKw1UJaYNoE4C5ZQZfdAj+ooAR
X-Gm-Gg: AeBDiesSbS9baKjsB/TqYy2Q2WrUSEwgltBh0l0H5y4kpSeed80hDXNjBhWI+OtiT8G
 OR8mPq1PP7+cig0ixczGKaySTTjNYBzX8mq9i5IkaG8vRYHzGKTIYHoJUuPdz3L3SYGHvWx3ug6
 2R/dtFZXEwLpuK5GDw4JrSewOOtlaJDpWJ6vJF/kZ1obA7N/+byTF+1NV/ifY6ygWDSOkc+IVJd
 HIle4tIxTaNmz3M1NJ0Rj8h68V76JWaz8bujTWmaikGkSn8mP4og59nVi+P8OoQlrApvUz2QW7N
 Uy52t6MDQEtL+3NRJBT7yAdPCyh7SxiDTd7xQY5y99tqIeQH2fOzu8HunxlA1RwrA2wUxcWwODC
 Q6sj5Y6WCKveNaaokBNji/AfvaopSqA==
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-48a07615b87mr123086095e9.8.1776845661984; 
 Wed, 22 Apr 2026 01:14:21 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-48a07615b87mr123085645e9.8.1776845661437; 
 Wed, 22 Apr 2026 01:14:21 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm412592235e9.0.2026.04.22.01.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:14:20 -0700 (PDT)
Message-ID: <b4dbede4-96a5-47ff-920b-30e22fe61dae@redhat.com>
Date: Wed, 22 Apr 2026 10:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] MAINTAINERS: Remove my unused git tree locations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260422080406.62638-1-philmd@linaro.org>
 <20260422080406.62638-2-philmd@linaro.org>
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
In-Reply-To: <20260422080406.62638-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/04/2026 10.03, Philippe Mathieu-Daudé wrote:
> I haven't used these for years. And as explained in [*]
> QEMU development workflow doesn't leverage subsystem's
> git trees. Remove them.
> 
> [*] https://lore.kernel.org/qemu-devel/CAFEAcA9xCN6XMUFmZ_QAn617W14FAzi4D_H1mgSER10otTtQMQ@mail.gmail.com/
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fe9672e41f..ecd236f818d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2265,7 +2265,6 @@ T: git https://github.com/jasowang/qemu.git net
>   
>   Parallel NOR Flash devices
>   M: Philippe Mathieu-Daudé <philmd@linaro.org>
> -T: git https://gitlab.com/philmd/qemu.git pflash-next
>   S: Maintained
>   F: hw/block/pflash_cfi*.c
>   F: include/hw/block/flash.h
> @@ -2864,7 +2863,6 @@ F: include/hw/nvram/fw_cfg.h
>   F: include/standard-headers/linux/qemu_fw_cfg.h
>   F: tests/qtest/libqos/fw_cfg.c
>   F: tests/qtest/fw_cfg-test.c
> -T: git https://github.com/philmd/qemu.git fw_cfg-next

Reviewed-by: Thomas Huth <thuth@redhat.com>


