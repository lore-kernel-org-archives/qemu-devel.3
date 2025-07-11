Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F701C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCOp-0003OO-UI; Fri, 11 Jul 2025 07:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaCHi-0000qL-3P
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaCHe-0005oc-9Q
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752234674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yyFqJukxaIwSQPAoHxFgwqc98y5sJE4fg5Pl3jsxwXk=;
 b=VReYq8PWPpQceHyPd8FsFAso/PhQOVF8oL2Czpfc+v+sOftJJCdgkCOsajvou4RKSmv24z
 8apsCcjlRiNKS9Kmu+8BozR4eGKoqyAxDKRHgtPxKZBB8OEaSXBDJHCy8+QQv39T1QXLAU
 vOaCwv5EqLx4Kyd8Y82MmpQfMFKxs3E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-7hDcDa4LMHCgo_xo_GOaqA-1; Fri, 11 Jul 2025 07:51:13 -0400
X-MC-Unique: 7hDcDa4LMHCgo_xo_GOaqA-1
X-Mimecast-MFC-AGG-ID: 7hDcDa4LMHCgo_xo_GOaqA_1752234672
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso1028484f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 04:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752234672; x=1752839472;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yyFqJukxaIwSQPAoHxFgwqc98y5sJE4fg5Pl3jsxwXk=;
 b=WKhWRShUJLuSjnlesinnWiBijbiw3Lp7Km2vxU9ajSsuYSxqOV7e7K9W7tVoZGZjcp
 cHNb09XHz5/kesuQNWQLsTYDJDXrAMIMxEvDC5p8HXeB4xvWWqh1Nys/GeOFYS+3mV8H
 xPQFbolhCiB1M7O+FPtCSZ4rPtKGT5fuhf/CdmAaBCbiOLk537bzwf15QZf8Vk9STLmO
 KSKDHPzSv9Cv++PsN8CDkblTwKEkNMjZQqkbdgKxEJwth5Z16ZG33IAXBS7u9dOzqm90
 UPvJNuDQNXY/OMUnFWVhOc/dX74ZawFjWM1r8JD1A9b2UJxjJyZkQmFmjczJW6C/ufI5
 URGQ==
X-Gm-Message-State: AOJu0YwmbK6Zik4iyaUQasgR+jX1sf+4SCVijtMAOfm+0XKddXF5r+W1
 7e2eOxLz6ZK8e+PDSeuuVlAB8TtOG63bC0Msfjez/imONVbrDRcui7b4bhWAnLlMjpqg5+15mQO
 GnwwRLn1wFyocY7rR8rpIHaWzBRK3KVQTsKHTJBthulESpwD9Jw3oMCSe
X-Gm-Gg: ASbGncvhKyNhGYEOiSZiNYWHoouIZjj++2Fj+eDCS+9QsfgdbLZR61oGgJS5JAh4jGC
 K2N2Wh+00wwJ/WiPsc8+KmcDAlp0D5DRteWJK2tUkQs5B5oh2P1lzNNK0tn7AMGgcVpPa8RVYtE
 PCT1SgBz3ewZV5FXQd2zXdoUCODiMUS+pIdPBMmb7i/OrjyecZkA/GBST0WOMAubl8Bi0i9CCs3
 cyNaYIql05DHONbyThvDepmnOH4/lSoRC7GZt0aayqP7V+SvIsce6WmZ4WKlnj/3GRqj0t7wveE
 DjO2XRysDfDZxKRR6663n8ZUuzp87l0tRZRsF8o0mfr7Q4OjJeVTuqCd9aQZweDQpBOtcUWxQKy
 6uCLC
X-Received: by 2002:a05:6000:3101:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b5f352fc3dmr1817275f8f.14.1752234672014; 
 Fri, 11 Jul 2025 04:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr84vVmTseq8gJlMKAbqLuU0gQW6dnR2ygiNNhhtc4Qouct8XWG0bGF951qoOzs3wFiJ61HA==
X-Received: by 2002:a05:6000:3101:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b5f352fc3dmr1817244f8f.14.1752234671539; 
 Fri, 11 Jul 2025 04:51:11 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2703csm4247342f8f.97.2025.07.11.04.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 04:51:10 -0700 (PDT)
Message-ID: <cf687af2-fd4e-4fbd-9dcb-824b980795fd@redhat.com>
Date: Fri, 11 Jul 2025 13:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250710094251.139514-1-thuth@redhat.com>
 <aG_TSITe2VhMfpA9@redhat.com>
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
In-Reply-To: <aG_TSITe2VhMfpA9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/07/2025 16.50, Daniel P. Berrangé wrote:
> On Thu, Jul 10, 2025 at 11:42:51AM +0200, Thomas Huth wrote:
>> This patch tackles two issues. First, the tests/functional folder has
>> become quite crowded already, some restructuring would be helpful here.
>> Second, we currently encode the target architecture twice in the test
>> names since a lot of the test file names contain the target, too.
>> This contributes to the very long output lines when running "make
>> check-functional".
>>
>> So let's move the individual test files to target specific folders now.
>> Then we can drop the target from the file name (and thus from the test
>> name).
> 
>> ---
>>   Note: Marked as RFC since I'm not that happy about the symlinks yet ...
>>         if someone has a better idea, please let me know!
>>         Also the update to the MAINTAINERS file is still missing - I'll add
>>         that once we agreed on whether this patch is a good idea or not.
> 
> FWIW, I don't find the symlinks to be a problem, but if they bother you,
> we could probably just have a trivial subclass.
> 
> 
>     from ../generic/test_migration import MigrationTest
> 
>     class MigrateTestX86(MigrationTest):
>         pass
> 
> 
> Unless pytest runner really needs the 'test_XXX' methods to be only on
> the leaf class, not a parent, in order to enumerate test cases ?

I played a little bit with this now, and it seems to be worse: If I keep the 
test_* methods in the parent class, each test is now executed twice, once 
for the leaf class, and once for the parent class :-/

I guess I could rename the functions in the parent class to use a different 
prefix ("do_test_...) and then add test_... functions to the leaf classes 
that call the ones from the parent, but that's quite a bit cumbersome...

I'll ponder for it a little bit longer, but if you have any other ideas, 
that's welcome, too, of course!

  Thomas


