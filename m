Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DCFFAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 04:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFm3B-00014Y-P3; Thu, 23 Apr 2026 00:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFm3A-000148-DW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 00:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFm38-0004pX-QH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 00:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776919945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zCe+Yvs+3z5dhrSnxl/ObpacRV9+S2dbQIPz720xQH4=;
 b=HXM9RgryHY8k31dri/rL74G8S1T8auM10CtLD7oprOttmc3vx8hlRZt7HuH9Co5UMWF88k
 scswP8F8SFfkKyNvmJIVfNb/3V8XvgrIwIxRHfDlHD9F8Oqd/q/8/K9mMWDi7HN7P4iG4c
 iTo/Qab6t3dplyGNKdlz8+k5FKfMITU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-vrD7aMraPQG2S7IBBjGttw-1; Thu, 23 Apr 2026 00:52:23 -0400
X-MC-Unique: vrD7aMraPQG2S7IBBjGttw-1
X-Mimecast-MFC-AGG-ID: vrD7aMraPQG2S7IBBjGttw_1776919942
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo4694539f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 21:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776919942; x=1777524742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zCe+Yvs+3z5dhrSnxl/ObpacRV9+S2dbQIPz720xQH4=;
 b=WxE2/b3ijskcRBgG/LNruIvLw+ORAHOAYu59c42E8rX2H1BNDi3TZFVM1SqiGAP9ZD
 ArTlRyitZoMDB3dhXODmQV4u8zPYjf4j2OViycJQdl/fEYKy6/S8QxUIMqPngVcfa740
 EIecR7OxSSHHMq1B07kg4JY0v0Xz2eXnFyBp2ikbpAnwk0d0HRWVak8BrXCEDVlsmvbM
 NI6HapMo6ojIe0sULP4y8Lgk1UG7nOQtwRIuSWWsFf+aUWHfR9SCFBBaqICSw2zRZ1AM
 VSYDHMVAE76EKsSRFMUaSh8lhMcxBjOTpzrXptFVkX1Woa871Uc6joFZvxVJE4w6Lbmo
 V58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776919942; x=1777524742;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCe+Yvs+3z5dhrSnxl/ObpacRV9+S2dbQIPz720xQH4=;
 b=EC4PIHN7Ps0ZAmJ2n7aNJqu2VRnL/jNYku+EVhtV8PBOySBe+dNYJjBs1NAmA6U/Uu
 f5YTWy9a2VLvRCKztg9jBFnoJWkyrgc++sQzjwecsS1sWtA4s/3SXSXPclleoD8J3tvl
 wGh21m8ryCfCd/r9xKS/nN/ss/DEfIrmSki6TA/7ZMwmi3Db9KNqKkw2zwAqrsyyOKeY
 DvXIzZgv8fqw4j7vbvvhPpC5O8MKjixgOUtskSwMKAo9/oiwKFSLHIrVCjvlZ4lTRdmp
 Eb4wT6G5E7eOb4FdWcGfRmmA+kcWyloo43yB7Q7Ixghcdp5X0TTAWhuQGQdma8UUetMg
 cxIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CD95LYfqaMEHvP3JlEmDmBZd0ktHrTL7w1a0wEcNskGgIAkblO+ADfG5MjQbiaFHqE2qJ70ELpEbx@nongnu.org
X-Gm-Message-State: AOJu0Yz3l8+oht7xHz8N7apx2s6uiF64gohu9ZQ9IqxIQzCVQ8j/KVOP
 N8KZQuwuId6V/FtXpVEemDqLsExdFXkCQMLLo4w5N4aQ1CI81RzSLwgzQ9gIWuKFLlZzeG5bM9A
 1pUeQe/zObmAUW/wHI75aII/C7IGBVHCFP3lcx+gO3DsXJpZd1WXIDljQ
X-Gm-Gg: AeBDiesH66cRqkfuuVVJQo/DtD8qfrytr7ciDtOmSTuTBz3IOA6JPJmoXQGte3Dos9w
 x3Cd/qg8cPPme+xFgQoU9nZCfmIlOeElutY6Y2YDEy5NQ4JT3QvYiZe+7sOYTXbeLB0oPHakC2C
 BnG+pCiQ3ObYTPjIfjxDr25pNaX+hThreZjkC/Y3Ot072X4yF0dniqp3rBzH9Ou88WNmPJ1eI0D
 Mb5kU43sXRjVfAJc4r4xBj90SrfPkXLKDmpXpB7Dx9HT1IjN+9wXeuP90UO7c3WgxISdiNj/7V8
 Ovdu4zl8zk+01zT4pxwvwAVqV3Hr2KnAIcS0MaWZILiVitxrkT4y5IJcMmuSx92KcjKuWnMPEzG
 Yb/Ciuw/55dRlSu6RaOtLs4uwu2Irbg==
X-Received: by 2002:a05:6000:200c:b0:439:bd70:610f with SMTP id
 ffacd0b85a97d-43fe3e13c17mr39738471f8f.44.1776919942142; 
 Wed, 22 Apr 2026 21:52:22 -0700 (PDT)
X-Received: by 2002:a05:6000:200c:b0:439:bd70:610f with SMTP id
 ffacd0b85a97d-43fe3e13c17mr39738451f8f.44.1776919941717; 
 Wed, 22 Apr 2026 21:52:21 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm55484214f8f.18.2026.04.22.21.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 21:52:21 -0700 (PDT)
Message-ID: <624cf04d-6188-458d-bca6-dd5ffec877ab@redhat.com>
Date: Thu, 23 Apr 2026 06:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/functional: Make socat wait longer in migration
 exec test
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260422230001.3168-1-farosas@suse.de>
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
In-Reply-To: <20260422230001.3168-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/04/2026 01.00, Fabiano Rosas wrote:
> The migration_with_exec test is failing sporadically for all
> architectures due to a race when the destination socat process takes
> too long to start listening while the source process is already
> issuing connect().
> 
> The race is inherent because the exec: migration spawns the
> to-be-exec'ed command asynchronously and returns from the
> migrate-incoming command. The localhost-only testcase is not
> representative of the majority of migrations. In a real scenario
> between two different hosts that race wouldn't happen.
> 
> Fix the testcase by configuring the source socat command to wait
> indefinitely while trying to connect.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/functional/migration.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 144f091ba8..3b7674af3b 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -85,5 +85,5 @@ def migration_with_exec(self):
>           with Ports() as ports:
>               free_port = self._get_free_port(ports)
>               dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
> -            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
> +            src_uri = 'exec:socat - TCP:localhost:%u,forever' % free_port

Maybe use "retry=90" instead? OTOH, we have the high level timeout from the 
meson runner, so we should not hang here forever by accident anyway.

Thus:
Reviewed-by: Thomas Huth <thuth@redhat.com>


