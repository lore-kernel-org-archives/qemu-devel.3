Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43197CEACCD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdyY-0005ud-O7; Tue, 01 Oct 2024 10:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svdx8-0004Fc-Lq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svdx4-0001Id-G5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727793247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NQn8D+shrjyPGWhS/ZUvzsec421pPCWRv5FAaFa1AsY=;
 b=ZSu+X/maKHwJLBRuIS3hUI/L84cEc3P0MdCILztkDn9Rf8bXkQDT3elQtj0MBM8N8XkptJ
 aTqbNptBgoTJC7dNzjhD8/XN3ydAhoUEzeI67piCnXuikBLNZuumlCuVRIXgSZv7JjDAow
 1YQ7j4QEsDeUW4Tfw49uH6owrKMZkao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-a_qomncYOkm_3Sfmkkh3gQ-1; Tue, 01 Oct 2024 05:14:19 -0400
X-MC-Unique: a_qomncYOkm_3Sfmkkh3gQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso40434785e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 02:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727774058; x=1728378858;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQn8D+shrjyPGWhS/ZUvzsec421pPCWRv5FAaFa1AsY=;
 b=GrXS8xdE9meHNgBSN1zn/FJSluahvU6xTDgFexxYbCFwzyWBmsVfo239WGV/+x6zqi
 0su9C370XfD4xYTK/7ndojtEtReXjNojyNz4P/I7RfVK9g8TYVL73cro5QxKN6580IUA
 yb9gYpQP+57pZsUutwdN3a3/I3EfhPpeqCAUe68KMd1MnK6ZZscuR54j6FWWhLeHsj87
 niFiLusdFICIAkJ1bgx07BulLvZLAbe41ISKuUdlZ9oHjFu0K6Ghw5HHwag9jd+6tkJC
 zc+egq70DAppBjJafa0pv7nyhYw7t3fGdIe3g6oh0k0r8X5zMVoeiaw9A8LfEubZHVpi
 XuBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdJ7DlEZGm8kWqSvTZM6s+HNQkYNVdgDxaP44w7LlBDgzV1O35dWqouRg/sUFZ6f89Lc+7WSF+VMIS@nongnu.org
X-Gm-Message-State: AOJu0Yzyha4aeag/fK14oGSenCgZIZf9V1IR6zV4a4+i/sGrLqGa2GLd
 IYRr7wZ6VV31iUCxexzW+ITQb1p9WrSk5GG01AkjDDnVoKEAwn2xoZ+DDxOuYJ84KeTl6RxUfCL
 wbLAFTtbyL9O4mS/xyaBCu2Xc60Y/UiPh7t5i1En79HEM7fuTpgzzQRbrxOzSB9M=
X-Received: by 2002:a05:600c:5125:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42f5844b601mr117519625e9.15.1727774058216; 
 Tue, 01 Oct 2024 02:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl3f0IZNx/PKoQnuQi3oeXNgHGOTlqD7JkgdAq8cHcw60lEunsnOcyUUNMYaFvcnsgrkNaXA==
X-Received: by 2002:a05:600c:5125:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42f5844b601mr117519355e9.15.1727774057749; 
 Tue, 01 Oct 2024 02:14:17 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e30374sm129076285e9.42.2024.10.01.02.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 02:14:17 -0700 (PDT)
Message-ID: <23f7bf52-af7d-4186-b773-28b15e872064@redhat.com>
Date: Tue, 1 Oct 2024 11:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Switch back to the gitlab URLs for the
 advent calendar tests
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>
References: <20240930171834.51701-1-thuth@redhat.com>
 <ko5yn.bgayz532vi6@linaro.org>
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
In-Reply-To: <ko5yn.bgayz532vi6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 01/10/2024 10.50, Manos Pitsidianakis wrote:
> Hello Thomas,
> 
> On Mon, 30 Sep 2024 20:18, Thomas Huth <thuth@redhat.com> wrote:
>> Shortly after we switched to the original URLs on qemu-advent-calendar.org,
>> the server went offline - looks like we are better off using the gitlab
>> URLs again instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
> [snip]
>> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/ 
>> functional/test_microblazeel_s3adsp1800.py
>> index faa3927f2e..47c941d487 100755
>> --- a/tests/functional/test_microblazeel_s3adsp1800.py
>> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
>> @@ -18,8 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):
>>     timeout = 90
>>
>>     ASSET_IMAGE = Asset(
>> -        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
>> -        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
>> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/ 
>> day13.tar.xz'),
>> +        '67e4c502651f8801e724ecc26403f1d0cdbc00549b033166e2e8cd14e9d49fef')
>>
>>     def test_microblazeel_s3adsp1800(self):
>>         self.require_netdev('user')
> 
> I downloaded both day13.tar.gz and day13.tar.xz and these archives have 
> different file contents, is that on purpose?

Oh, drat! That's a different package, indeed - it's the one from 2018, not 
the one from 2023! I didn't really notice since I did not remove my 
tests/functional/ folder before re-running the tests, so this test was 
silently re-using the old binary from the previous test runs :-/
(note to myself: we should maybe remove the binaries after each test run).

Thanks for spotting it!

Meanwhile, the www.qemu-advent-calendar.org website seems to be back, so 
maybe we don't need this patch here anymore... let's wait and see whether it 
remains stable now...

  Thomas


