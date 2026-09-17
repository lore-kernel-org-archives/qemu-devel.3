Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3916CC982CD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x75vd-00082G-Fj; Thu, 17 Sep 2026 02:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x75va-00081d-BY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x75uo-0005dM-AN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789627693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gwFFQ/wscyj3YRP529/yP2lRJ/DKsbvymvqMZ+C9LZo=;
 b=Ht9oXAHnKkGK3SO/nZaMFSN96X66kwx8W+mJYj6OxT3CTIFqFzwsL8vFRjI6JugnwCld2u
 x682Ae9ZXkvTO9c4A2pe3Uda3slGwG3xShPyKc2DqGBb5YJIr8sdD6vg27mYNogLRFwMGQ
 G98FqqLU37/JWdURf/gIJdNjJiiscek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-gn1SgePnMDWySTm41MmHRA-1; Thu, 17 Sep 2026 02:48:11 -0400
X-MC-Unique: gn1SgePnMDWySTm41MmHRA-1
X-Mimecast-MFC-AGG-ID: gn1SgePnMDWySTm41MmHRA_1789627690
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6c17ec1dso5969205e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789627690; x=1790232490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gwFFQ/wscyj3YRP529/yP2lRJ/DKsbvymvqMZ+C9LZo=;
 b=EDxay15R37xzES4efZpMxVdV11885qiEI0KeSpTzWbDY66W/TIvpdleTSaZma4HMKx
 vWRjYCrahUU5PYw1/KskEUhlaun7se0Ddq3a/Qu1z4Fa5oHsKtxHJZHL4lPRDu0pHgtN
 1XB+GkirsrWvoX4yR0ZL8yrSseSGzxPIo9tDGcrWn6ZiaOS4+9uc62TSBnjebPqWOTNa
 +4+6P/vIDEOokxdkA86KqsnfQVBQAWVSTRguCcbbfTvJbSVYqRu0s/pSq3siq9wqcOQv
 5S4+nUBrxJA8aEI3BegpJMHO7rXBdHPCKtajP8vhHop7HDUZ00GHX3K00xZj2qT03HAb
 SzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789627690; x=1790232490;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gwFFQ/wscyj3YRP529/yP2lRJ/DKsbvymvqMZ+C9LZo=;
 b=ZjUOZgFnYso5WyyYJCEA2DhHg6uZaQhptLc5IUzcMtfUu77LZuLFMgwafXOV7G/VgU
 MAoDklKJiZ8c5SAyRxcVQ/dsaDRIzC+NLdY9yUBU38qAfkqKNSDPt6R5uRv3Qx70KOlK
 aVvXdRq/JkX6Nq5sYQNgtpQy8tTqjqXk4+NlOYQQwdFcxdpP7KwKx/T6tLTTCMOM+BPX
 FcfKwcOeTiE+54Hm03Dy99zB0Hqhjzdx7AfqUYmgtMoeBbplqi3zL2PIz5HLC49ha5pQ
 krmSrjZNEIeq3+A34F7NFNW7u7P7uyZPpgUJ14fozAvWqgj+Dk61CvpygH8nX5SWYdXn
 mURw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjpmIoYC3eVjftDC2VdtEu95hwzHGUT1hytYBK67gb1/qnE+cmn8pAkvho9ssk5Q7E6IP44FwsWVaW@nongnu.org
X-Gm-Message-State: AFuF++ms4DcdwN5mfQ47na+SI96Ho0l5WQvehiVpooCt/Doty2E1zwVy
 opm0e2THTCbxkBhvcSy++mlJBh3FQ97fuaKyrSUE1zlLpjy/IEpJWuMBAWTlemgXM4PASAGnFPL
 1AGKXzUdJ33+c2Uudpxldn29oFmfLOvMvDs++mscNJ3fawoJ6gRpH+tZc
X-Gm-Gg: AYBFou2CrG8djahTHxABCsUlwkUOSwbIWbSssVgwEDw6szXUjWcl0c/xjyFIJPzUK0H
 HXffKeweEIe3G7HyvPOKYj4csFc/j4kp4RtCks/ypGPFcvY1fcjqj5WKL4Dgjsi/MQxey6Ngn4E
 5CBbiqeeHcQNdj0FSroKwgdpo0XFoHJvjO3LMEtMciRogmaAGVZROKqUWUC5jgvqazs9Ms1ipKT
 iQiuTuGvSL5fnGPgKAbg/B4GDWr9BBW9S6Cm6BNWw6JCoK4Ryi7SDX7clfbn/YNHwOQnCnJcCD/
 rZAHguUpz72rUAqWOp1+cxRgw8UVziwMYgO9HNdPDSfsPdbFpN6RqmcliLYMUmXvqcdccRPgPg=
 =
X-Received: by 2002:a05:600c:8215:b0:49f:bd3c:bc1a with SMTP id
 5b1f17b1804b1-49fbd3cbda2mr20340055e9.21.1789627689901; 
 Wed, 16 Sep 2026 23:48:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8215:b0:49f:bd3c:bc1a with SMTP id
 5b1f17b1804b1-49fbd3cbda2mr20339915e9.21.1789627689597; 
 Wed, 16 Sep 2026 23:48:09 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd83e39sm76125035e9.4.2026.09.16.23.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 23:48:08 -0700 (PDT)
Message-ID: <c6546b3b-b77a-4d8e-a635-c93f5841e30b@redhat.com>
Date: Thu, 17 Sep 2026 08:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/functional/ppc64: extend ppc64 powernv net
 device tests
To: Aniket Sahu <asahu1x@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-3-asahu1x@linux.ibm.com>
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
In-Reply-To: <20260916103635.7797-3-asahu1x@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/09/2026 12.36, Aniket Sahu wrote:
> Added console checks as the probe log lines will appear before the
> S14Silence-console init scripts.
> ---
>   tests/functional/ppc64/test_powernv.py | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index f3e05e4d38..200fd2c894 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -201,9 +201,12 @@ def do_test_ppc64_powernv(self, proc):
>   
>           self.wait_for_console_pattern("CPU: " + proc + " generation processor")
>           self.wait_for_console_pattern("INIT: Starting kernel at ")
> +        # NVMe, e1000e, and xHCI are probed synchronously by the kernel
> +        # during PCI enumeration, after OPAL hands off to Linux.
> +        self.wait_for_console_pattern("nvme nvme0")
> +        self.wait_for_console_pattern("e1000e")
> +        self.wait_for_console_pattern("xhci_hcd")
>           self.wait_for_console_pattern("Run /sbin/init as init process")
> -        # Device detection output driven by udev probing is sometimes cut off
> -        # from console output, suspect S14silence-console init script.
>   
>       def test_ppc64_powernv_external_dtb(self):
>           self.set_machine('powernv11')

Reviewed-by: Thomas Huth <thuth@redhat.com>


